SDWLE110 ;;IOFO BAY PINES/TEH - WAITING LIST-ENTER/EDIT;06/12/2002 ; 29 Aug 2002  2:54 PM
 ;;5.3;scheduling;**263,273,424,454**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   11/27/02                  SD*5.3*273            Add "/", line SA1+11,+13,FA2+13
 ;   
 ;   
EN K DIR
 I $D(^SDWL(409.3,SDWLDA,0)) S DIR("B")=$$EXTERNAL^DILFD(409.3,10,,$P(^(0),U,11))
 I DIR("B")="" K DIR("B")
 S DIR(0)="SO^1:Future Date;2:ASAP"
 S DIR("L",1)="Priority",DIR("L",2)=""
 S DIR("L",3)="1. Future Date",DIR("L")="2. ASAP"
 D ^DIR I X["^" S DUOUT=1 Q  ;-'^' here will remove patient from wait list
 I X="@" W *7," ??" G EN
 I X="" W *7,"Required or '^' to quit." G EN
 I $D(DTOUT) S DUOUT=1 Q
 S X=$E(X,1)
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCEDFGHIJKLMNOPQRSTUVWXYZ")
 S SDWLPRIE=$S(X["A":"A",X["F":"F",X[1:"F",X[2:"A",1:"F")
 S DIE="^SDWL(409.3,",DA=SDWLDA,DR="10////^S X=SDWLPRIE" D ^DIE
 ;
 ;If priority is ASAP ask requesting provider
 ;
 I SDWLPRIE="A" S Y=DT D DD^%DT W " ",Y D SA,DUP G END:$D(DUOUT) Q
 I SDWLPRIE="F" D FA G END:$D(DUOUT) Q  ;to enter future date
 Q
 ;
SA K DIR,DR,DIE S SDWLERR=0,SDWLX=$S($D(SDWLPROV):$$EXTERNAL^DILFD(409.3,12,,SDWLPROV),1:"")
 I $D(SDWLPROV),SDWLPROV,SDWLX'="" S DIR("B")=SDWLX
 I $D(^SDWL(409.3,SDWLDA,0)) S DIR("B")=$$EXTERNAL^DILFD(409.3,11,,$P(^(0),U,12))
 I DIR("B")="" K DIR("B")
 K %DT,DR S DIR(0)="SO^1:Provider;2:Patient"
 S DIR("L",1)="Request By",DIR("L",2)=""
 S DIR("L",3)="1. Provider",DIR("L")="2. Patient"
 D ^DIR I X["^" S DUOUT=1,DIR("A")="ASAP" Q
 S X=Y
 I $D(DTOUT) S DUOUT=1,DIR("A")="ASAP" Q
 S SDWLRBE=$S(X=1:1,X["PR":1,X["pr":1,X["Pr":1,X=2:2,X["PA":2,X["pa":2,X["Pa":2,1:0) I 'SDWLRBE W *7," ??" G SA
 S DR="11////^S X=SDWLRBE",DA=SDWLDA,DIE="^SDWL(409.3," D ^DIE
 ;
SA1 I SDWLRBE=1 D
 .S DIC("S")="I $$SCREEN^SDUTL2(Y,DT)"
 .S SDWLX=$S($D(SDWLPROV):$$EXTERNAL^DILFD(409.3,12,,SDWLPROV),1:"") I SDWLX'="" S DIC("B")=SDWLPROV
 .I $D(^SDWL(409.3,SDWLDA,0)) S DIR("B")=$$EXTERNAL^DILFD(409.3,11,,$P(^(0),U,12))
 .S SDWLERR=0,DIC(0)="AEQ",DIC=200,DIC("A")="Provider Requesting Appointment: " D ^DIC
 .I X["^" S DUOUT=1 Q
 .I Y<1 S SDWLERR=1 Q
 .I $D(DUOUT) Q
 .I $D(DTOUT) S DUOUT=1 Q
 .K DIC,DIC("S"),DIC("A"),DIC(0),DIC("B")
 .S SDWLPROV=+Y,SDWLPRON=$P(Y,U,2),DIE="^SDWL(409.3,",DA=SDWLDA
 .S DR="12////^S X=SDWLPROV" D ^DIE S SDWLPRVE=SDWLPROV
 I SDWLERR W *7," Required" G SA1
 S DR="11////^S X=SDWLRBE" D ^DIE
 S DR="22///TODAY" D ^DIE K DIE,DR,DIC,DIR,SDWLPRVE,SDWLPROV,SDWLPRON
 Q
 ;
 ;If Priority is 'FUTURE' ask Desired Date of Appointment and Requesting by Provider or Patient
 ;
FA S SDWLERR=0 K DIR,DUOUT,DR,DIE I $D(SDWLDAPE) S Y=SDWLDAPE D DD^%DT S DIR("B")=Y
 I $D(^SDWL(409.3,SDWLDA,0)),$P(^(0),U,16) S %DT("B")=$$EXTERNAL^DILFD(409.3,22,,$P(^(0),U,16))  ;SD*5.3*424
 S %DT="AE",%DT("A")="Desired Date of Appointment: " D ^%DT
 I $D(DTOUT)!(X="^") G EN
 I X="" W *7,!!,"This is a required response. Enter '^' to exit.",! G EN  ;SD*5.3*454
 S SDWLDAPE=Y,DR="22////^S X=SDWLDAPE",DIE="^SDWL(409.3,",DA=SDWLDA D ^DIE
 K SDWLDAPE,Y,DA,DIE,%DT,%DT(0),%DT("A"),%DT("B")
 ;
FA1 K DIR,%DT,DR S DIR(0)="SO^1:Provider;2:Patient"
 S SDWLX=$S($D(SDWLPROV):$$EXTERNAL^DILFD(409.3,12,,SDWLPROV),1:"") I SDWLX'="" S DIR("B")=SDWLPROV
 I $D(^SDWL(409.3,SDWLDA,0)) S DIR("B")=$$EXTERNAL^DILFD(409.3,11,,$P(^(0),U,12))
 I DIR("B")="" K DIR("B")
 S DIR("L",1)="Request By",DIR("L",2)=""
 S DIR("L",3)="1. Provider",DIR("L")="2. Patient"
 D ^DIR I X["^" S DIR("B")=$S($D(SDWLDAPE):SDWLDAPE,1:"") G FA
 S X=Y
 I $D(DTOUT) S DUOUT=1 S DIR("B")=SDWLDAPE G FA
 S SDWLRBE=$S(X=1:1,X["PR":1,X["pr":1,X["Pr":1,X=2:2,X["PA":2,X["pa":2,X["Pa":2,1:0) I 'SDWLRBE W *7," ??" G FA1
 S DR="11////^S X=SDWLRBE",DA=SDWLDA,DIE="^SDWL(409.3," D ^DIE
 ;
FA2 I SDWLRBE=1 D
 .;
 .;if provider is selected look-up valid provider from new person (File 200)
 .;
 .S DIC("S")="I $$SCREEN^SDUTL2(Y,DT)"
 .S SDWLX=$S($D(SDWLPROV):$$EXTERNAL^DILFD(409.3,12,,SDWLPROV),1:""),DIC("B")=$S($D(SDWLPROV):SDWLX,1:"")
 .S SDWLERR=0,DIC(0)="AEQ",DIC=200,DIC("A")="Provider Requesting Appointment: " D ^DIC
 .I X["^" S DUOUT=1 Q
 .I Y<1 S SDWLERR=1 Q
 .I $D(DTOUT) S DUOUT=1 Q
 .Q:$D(DUOUT)  D
 ..K DIC,DIC("S"),DIC("A"),DIC(0),DIC("B")
 ..S SDWLPROV=+Y,SDWLPRON=$P(Y,U,2),DIE="^SDWL(409.3,",DA=SDWLDA
 ..S DR="12////^S X=SDWLPROV" D ^DIE S SDWLPRVE=SDWLPROV K DIE
 I SDWLERR W *7," Required" G FA2
END K DIC,DIE,DIR I $D(DUOUT) S DIR("B")=$S(SDWLPRIE="F":"Future",1:"ASAP")
 K SDWLPRVE,SDWLPROV,SDWLPRON
 Q
 ;
DUP ;
 Q
