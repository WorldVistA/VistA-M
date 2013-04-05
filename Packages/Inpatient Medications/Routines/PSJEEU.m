PSJEEU ;BIR/CML3-EXTERNAL ENTRIES UTILITY ; 9/10/09 10:46am
 ;;5.0;INPATIENT MEDICATIONS ;**3,208,232,283**;16 DEC 97;Build 4
 ;
ENSV ; schedule validation
 ;K PSJAT,PSJM I $S('$D(PSJPP):1,PSJPP="":1,PSJPP?.E1C.E:1,1:'$D(^DIC(9.4,"C",PSJPP))) Q
 ; changed to remove ref to 9.4,"C"
 K PSJAT,PSJM Q:$S('$D(PSJPP):1,PSJPP="":1,PSJPP?.E1C.E:1,1:0)  N DIC S X=PSJPP,DIC(0)="OX",DIC=9.4,D="C" D IX^DIC I +Y'>0 Q
 Q:$D(PSJX)[0  I $D(PSJW),$S('PSJW:1,1:'$D(^SC(PSJW,0))) K PSJW
 N D,DIC,DIE,Q,QX,SDW,SWD,X,X0,X1,X2,XT,Y,Z D EN^PSJSV Q
 ;
ENSVI ; standard schedule inquire
 Q:$S('$D(PSJPP):1,PSJPP="":1,PSJPP?.E1C.E:1,1:0)  S X=PSJPP,DIC(0)="OX",DIC=9.4,D="C" D IX^DIC I +Y'>0 Q
 D ENI^PSJSV0
 Q
 ;
ENSPU ; schedule processor (count)
 K PSJC S PSJC=-1 I $S('$D(PSJAT):1,'$D(PSJM):1,'$D(PSJSCH):1,'$D(PSJSD):1,1:'$D(PSJFD)) Q
 ;the following line is for lab order with no start time PSJ*5.0*208
 I PSJPP="LR",PSJSD'["." D
 . N XPSJSD
 . S XPSJSD=PSJSD
 . ;*283 - Calculate start time
 . I PSJSD=DT S PSJSD=$$NOW^XLFDT()
 . I ORDUR S PSJFD=$$FMADD^XLFDT(PSJSD,+ORDUR,,-1) ; Calculate the new stopdate/time based on the new start date/time
 . I 'ORDUR S X=+$E(ORDUR,2,9) D
 .. I PSJM S PSJFD=$$FMADD^XLFDT(PSJSD,,,(PSJM*X)-1) Q  ;X_#times
 .. ;no freq in minutes --> day of week
 .. N DAYS,LOCMX,SCHMX
 .. S LOCMX=$$GET^XPAR("ALL^LOC.`"_+ORL,"LR MAX DAYS CONTINUOUS",1,"Q")
 .. S SCHMX=$P(^PS(51.1,PSJY,0),U,7)
 .. S DAYS=$S('SCHMX:LOCMX,LOCMX<SCHMX:LOCMX,1:SCHMX)
 .. S PSJFD=$$FMADD^XLFDT(PSJSD,DAYS,,-1)
 S:'$D(PSJOSD) PSJOSD=PSJSD S:'$D(PSJOFD) PSJOFD=PSJFD N AM,CD,H,HCD,I,J,M,MID,OD,PDL,PLSD,ST,Q,QQ,WD,WDT,WS,WS1,X,X1,X2,XX D EN^PSJSPU Q
 ;
ENPSJSE ; schedule edit for Inpatient Meds
 S PSJPP="PSJ"
 ;
ENSE ; schedule edit
 ;I $S('$D(PSJPP):1,PSJPP="":1,PSJPP?.E1C.E:1,1:'$D(^DIC(9.4,"C",PSJPP))) Q
 ; changed to remove ref to 9.4,"C"
 Q:$S('$D(PSJPP):1,PSJPP="":1,PSJPP?.E1C.E:1,1:0)  S X=PSJPP,DIC(0)="OX",DIC=9.4,D="C" D IX^DIC I +Y'>0 Q
 I $D(PSJW),$S('PSJW:1,1:'$D(^SC(PSJW,0))) K PSJW
 F FQ=0:0 K DIC S DIC="^PS(51.1,",DIC(0)="QEASL",DIC("DR")="4////"_PSJPP,DIC("W")="D DICW^PSSJSV0",D="AP"_PSJPP W ! D IX^DIC K DIC Q:Y'>0  S DIE="^PS(51.1,",DA=+Y,DR="[PSSJ "_$S(PSJPP="PSJ":"",1:"EXT ")_"SCHEDULE EDIT]" D ^DIE K DA,DIE,DR,PSJS
 K:PSJPP="PSJ" PSJPP K D0,DI,DISYS,DQ,FQ,X,Y
 Q
 ;
ENDSD ; default start date
 I $S('$D(PSJSCH):1,'$D(PSJAT):1,1:'$D(PSJTS)) S PSJX="" Q
 D ENDSD^PSJSPU0 Q
 ;
ENPSJSHE ; shift edit for Inpatient Meds
 S PSJPP="PSJ"
 ;
ENSHE ; shift edit
 ;I $S('$D(PSJPP):1,PSJPP="":1,PSJPP'?.ANP:1,1:'$D(^DIC(9.4,"C",PSJPP))) Q
 ; changed to remove ref to 9.4,"C"
 Q:$S('$D(PSJPP):1,PSJPP="":1,PSJPP'?.ANP:1,1:0)  S X=PSJPP,DIC(0)="OX",DIC=9.4,D="C" D IX^DIC I +Y'>0 Q
 I $D(PSJW),$S('PSJW:1,1:'$D(^SC(PSJW,0))) K PSJW
 F FQ=0:0 K DIC S DIC="^PS(51.15,",DIC(0)="AEQLS",DIC("DR")="4////"_PSJPP,D="AP"_PSJPP W ! D IX^DIC K DIC Q:Y'>0  S DIE="^PS(51.15,",DA=+Y,DR="[PSJ SHIFT EDIT]" D ^DIE K DA,DIE,DR
 K FQ,X,Y Q
 ;
ENATV ; validate admin times
 D ENCHK^PSJSV Q
 ;
ENSHV ;
 D ENSHV^PSJSV Q
