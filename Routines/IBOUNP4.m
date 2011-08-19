IBOUNP4 ;ALB/CJM - INPATIENT INSURANCE REPORT ;JAN 25,1992
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ; VAUTD =1 if all divisions selected
 ; VAUTD() - list of selected divisions
 ; IBOEND - end of the date range for the report
 ; IBOBEG - start of the date range for report
 ; IBOUK =1 if vets whose insurance is unknow should be included
 ; IBOUI =1 if vets that are no insured should be included
 ; IBOEXP = 1 if vets whose insurance is expiring should be included
 ; IBOBYWRD = 1 if report should be sorted by ward, = 0 otherwise
MAIN ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOUNP4-1" D T0^%ZOSV ;start rt clock
 ;
 N QUIT S QUIT=0,IBOBYWRD=0 K ^TMP($J)
 D DIVISION,PICK:'QUIT,CATGRY:'QUIT,SORTBY:'QUIT
 D:'$G(QUIT) DEVICE
 G:QUIT EXIT
QUEUED ; entry point if queued
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOUNP4" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBOUNP4-2" D T0^%ZOSV ;start rt clock
 ;
 D LOOP^IBOUNP5,REPORT^IBOUNP6
EXIT ;
 K ^TMP($J)
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOUNP4" D T1^%ZOSV ;stop rt clock
 ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IBOBEG,IBOEND,IBOUK,IBOUI,IBOEXP,VAUTD,IBOPICK,IBOBYWRD
 Q
DRANGE ; select a date range for report
 S DIR(0)="D^::EX",DIR("A")="Start with DATE" D ^DIR I $D(DIRUT) S QUIT=1 K DIR Q
 S IBOBEG=Y,DIR("A")="Go to DATE" F  D ^DIR S:$D(DIRUT) QUIT=1 Q:(Y>IBOBEG)!(Y=IBOBEG)!QUIT  W !,*7,"ENDING DATE must follow or be the same as the STARTING DATE"
 S IBOEND=Y K DIR Q
DEVICE ;
 I $D(ZTQUEUED) Q
 W !!,*7,"*** Margin width of this output is 132 ***"
 W !,"*** This output should be queued ***"
 S %ZIS="MQ" D ^%ZIS I POP S QUIT=1 Q
 I $D(IO("Q")) S ZTRTN="QUEUED^IBOUNP4",ZTIO=ION,ZTSAVE("VA*")="",ZTSAVE("IBO*")="",ZTDESC="INPATIENT INSURANCE REPORT" D ^%ZTLOAD W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED") D HOME^%ZIS S QUIT=1 Q
 U IO
 Q
CATGRY ; allows user to select categories to include in report
 S DIR(0)="Y",DIR("A")="Include veterans whose insurance is unknown"
 S DIR("B")="YES" D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 S IBOUK=Y
 S DIR(0)="Y",DIR("A")="Include veterans whose insurance is expiring"
 S DIR("B")="YES" D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 S IBOEXP=Y
 S DIR(0)="Y",DIR("A")="Include veterans who have no insurance"
 S DIR("B")="YES" D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 S IBOUI=Y
 Q
DIVISION ; gets list of selected divisions,or sets VAUTC=1 if all select
 N VAUTNI S VAUTNI=2,QUIT=1
 D DIVISION^VAUTOMA Q:Y<0
 S QUIT=0
 Q
PICK ; gets user's choice of all current inpatients or all admitted in range
 S DIR(0)="S^D:(D)ATE RANGE;C:(C)URRENT DATE;"
 S DIR("?",1)="C for CURRENT DATE- Report will display only those patients that are "
 S DIR("?",2)="inpatients in hospital today."
 S DIR("?",3)=""
 S DIR("?",4)="D for DATE RANGE - to display all patients that were admitted "
 S DIR("?")="to the hospital during that period."
 S DIR("A")="Display report for"
 D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 S IBOPICK=Y D:IBOPICK="D" DRANGE
 Q
SORTBY ;sets IBOBYWRD=1 if user wants the output sorted by ward
 K DIR S DIR(0)="Y",DIR("A")="Do you want the report sorted by WARD, as well as by division and patient"
 D ^DIR I $D(DIRUT) S QUIT=1 Q
 S IBOBYWRD=Y
 Q
