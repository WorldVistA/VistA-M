ECDSS1 ;BIR/RHK,JPW-Active/Inactive Procedure Report ; 03 JUL 2008
 ;;2.0; EVENT CAPTURE ;**4,25,95**;8 May 96;Build 26
 ; Routine to report active and inactive procedures
START ; Routine execution
 N ECRAS S ECRAS=1  ;roll and scroll
 S DIR(0)="SO^A:Active Procedures;I:Inactive Procedures"
 S DIR("A")="Select Report"
 S DIR("?")="Enter an A for active procedures, I for inactive procedures, or ^ to quit."
 S DIR("??")="ECDSS1^"
 D ^DIR K DIR I $D(DIRUT) G END
 S ECRTN=Y
INACT ;list inact procs
 I ECRTN="I" D LISTI G END
ASK ;
 S DIR(0)="SO^N:National;L:Local;B:Both",DIR("A")="Select Preferred Report"
 S DIR("?,1")="Enter an N for National Procedures only, L for Local Procedures only,"
 S DIR("?")="B for a combined report, or ^ to quit."
 S DIR("??")="ECDSAC^" D ^DIR K DIR I $D(DIRUT) G END
 S ECRN=Y
SORT ;ask sort
 S DIR(0)="SO^P:Procedure Name;N:National Number",DIR("A")="Select Sort Method"
 S DIR("?")="Enter N to sort by National Number, P by Procedure Name, or ^ to quit."
 S DIR("??")="ECDSAC1^" D ^DIR K DIR I $D(DIRUT) G END
 S ECRD=Y
PRT ;start prints
 I ECRN="N",ECRD="N" D LISTNN G END
 I ECRN="N",ECRD="P" D LISTNP G END
 I ECRN="L",ECRD="N" D LISTPN G END
 I ECRN="L",ECRD="P" D LISTPP G END
 I ECRN="B",ECRD="N" D LISTBN G END
 I ECRN="B",ECRD="P" D LISTBP
END ;kills var and quit
 W @IOF D ^ECKILL
 Q
LISTI ;all inact proc
 W ! K DIC S DIC="^EC(725,",FLDS=".01,1,4,2",BY=".01",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - INACTIVE",DIS(0)="I +$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTNN ;nat only by nat num
 W ! K DIC S DIC="^EC(725,",FLDS="1,4,.01",BY="1",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE NATIONAL BY NATIONAL NUMBER",DIS(0)="I D0<90000,'$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTNP ;nat only by proc
 W ! K DIC S DIC="^EC(725,",FLDS=".01,1,4",BY=".01",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE NATIONAL BY PROCEDURE",DIS(0)="I D0<90000,'$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTPN ;loc by nat num
 W ! K DIC S DIC="^EC(725,",FLDS="1,4,.01",BY="1",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE LOCAL BY NATIONAL NUMBER",DIS(0)="I D0>89999,'$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTPP ;loc by proc
 W ! K DIC S DIC="^EC(725,",FLDS=".01,1,4",BY=".01",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE LOCAL BY PROCEDURE",DIS(0)="I D0>89999,'$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTBN ;both by nat num
 W ! K DIC S DIC="^EC(725,",FLDS="1,4,.01",BY="1",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE NATIONAL AND LOCAL BY NATIONAL NUMBER",DIS(0)="I '$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTBP ;both by proc
 W ! K DIC S DIC="^EC(725,",FLDS=".01,1,4",BY=".01",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE NATIONAL AND LOCAL BY PROCEDURE",DIS(0)="I '$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
MSG I $D(ECRAS) W !!,"Press <RET> to continue  " R X:DTIME
 Q
