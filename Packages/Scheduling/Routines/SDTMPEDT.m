SDTMPEDT ;MS/SJA - TELEHEALTH STOP CODES EDIT ;Dec 17, 2020
 ;;5.3;Scheduling;**773,779,780,817**;Aug 13, 1993;Build 7
 ;
 ;
EDIT ; Add/edit stop code entries in file #40.6
 N ADD,DEL,Y,X,STOPCODE,X1,GOOD,TMPERR
 S GOOD=0,X1=0,(ADD,DEL)=0
 K DIR,DTOUT,DUOUT
 W ! S DIR(0)="N",DIR("A")="Enter Stop Code"
 S DIR("?")="This is the stop code to added or deleted" D ^DIR K DIR I 'Y!$D(DTOUT)!$D(DUOUT) G EXIT
 S STOPCODE=Y
 S GOOD=$$CHKSTOP(STOPCODE) ;check to see if valid stop code in 40.7, message to user and quit if not valid
 I GOOD'>0 S TEXT="NOT A VALID STOP CODE" D MSG(TEXT) G:$G(Y) EDIT I $D(DTOUT)!$D(DUOUT) G EXIT  ; Need to add code to give user an error message
 S X1=$O(^SD(40.6,"B",STOPCODE,""))
 D ASK($S(X1>0:"D",1:"A")) I $D(DTOUT)!$D(DUOUT) G EXIT
 I $G(DEL)="0",($G(ADD)="0") W ! D MSG("Do you want to edit another stop code") G:$G(Y) EDIT I 'Y!$D(DTOUT)!$D(DUOUT) G EXIT
 D UPD(DEL,STOPCODE)
 S TEXT=$G(TMPERR)
 D MSG("Do you want to edit another stop code") G:$G(Y) EDIT I $D(DTOUT)!$D(DUOUT) G EXIT
 Q
UPD(DEL,STOPCODE) ;
 N FDA
 I DEL="1" S FDA(40.6,X1_",",.01)="@"
 E  S FDA(40.6,"+1,",.01)=STOPCODE
 D UPDATE^DIE("","FDA","TMPERR")
 W !,$C(7),"STOP Code: ",STOPCODE," has been ",$S(DEL=1:"Deleted!",1:"Added!"),!
 Q
ASK(ACT) ;
 D EX1
 S DIR(0)="Y",DIR("A")="This stop code is "_$S(ACT="D":"already",1:"NOT")_" in the file, do you want to "_$S(ACT="D":"delete",1:"add")_" it",DIR("B")="NO"
 D ^DIR K DIR I Y S:ACT="D" DEL=Y S:ACT="A" ADD=Y
 Q
CHKSTOP(STOPCODE) ;
 N XX
 S XX=$O(^DIC(40.7,"C",STOPCODE,"")) ; check to be sure it is valid stop code
 Q XX
EX1 ;
 K DIR(0),DIR("A"),DIR("?"),DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 Q
EXIT ;
 K DIR(0),DIR("A"),DIR("?"),DIRUT,DUOUT,DTOUT,DIROUT,X,X1,Y,STOPCODE
 Q
MSG(TEXT) ; give user error message if stop code is not valid
 D EX1
 S DIR(0)="Y",DIR("A")=$G(TEXT),DIR("B")="NO" D ^DIR
 Q
 ;
PROVID ; provider fields add/edit
 N CLNDA,JJ,PRIEN,SEQ,TXT
 W !!!,$C(7),"CAUTION: DO NOT USE - Default Provider for setting up a Shared or Patient Site",!,?19,"Telehealth VistA Clinics."
 W !! S DIC("A")="Select Clinic: ",(DIC,DIE)=44,DIC(0)="AEQMZ" D ^DIC G:"^"[X EX
 G:Y<0 PROVID
 S CLNDA=+Y
 L +^SC(CLNDA,0):5 I '$T W !!,$C(7),"Another user is editing this record.  Try again later.",! D CR G EX
 S TXT="Providers associated with this clinic"
 W !!,$S($O(^SC(CLNDA,"PR",0)):"  "_TXT_":",1:"  No "_TXT_".")
 S PRIEN=0 F  S PRIEN=$O(^SC(CLNDA,"PR","B",PRIEN)) Q:'PRIEN  W !,?4,"- ",$$GET1^DIQ(200,PRIEN,.01) D
 . S SEQ=$O(^SC(CLNDA,"PR","B",PRIEN,0)) I $$GET1^DIQ(44.1,SEQ_","_CLNDA_",",.02,"I") W ?39,"<< Default >>"
 ; edit default provider and provider multiple fields
 W !
 K DR S DR="16",DA=CLNDA,DIE=44 D ^DIE K DR
 I X D DPMAIL
 I $D(Y) Q
 W !
 K DR S DR="2600",DR(2,44.1)=".01;.02",DA=CLNDA,DIE=44 D ^DIE K DR
 L -^SC(CLNDA,0)
 ;
CR W !! K DIR S DIR("T")=DTIME,DIR(0)="EA",DIR("A")="Press <Enter> to continue: "
 D ^DIR K DIR
 Q
EX W @IOF K DA,DIC,DIE,DR,DIR
 Q
DPMAIL ; default provider email
 N DPDA
 S DPDA=X
 L +^VA(200,DPDA):5
 I '$T W !!,$C(7),"Another user is editing this provider record.  Try again later.",! Q
 S DR=".151",DA=DPDA,DIE=200 D ^DIE K DR ;Prompt for default provider email - 780
 L -^VA(200,DPDA)
 Q
