IBOUNP1 ;ALB/CJM - OUTPATIENT INSURANCE REPORT ;JAN 25,1992
 ;;2.0;INTEGRATED BILLING;**249**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; VAUTD =1 if all divisions selected
 ; VAUTD() - list of selected divisions
 ; VAUTC =1 if all clinics selected in selected divisions
 ; VAUTC() - list of selected clinics, indexed by record number
 ; IBOEND - end of the date range for the report
 ; IBOBEG - start of the date range for report
 ; IBOQUIT - flag to exit
 ; IBOUK =1 if vets whose insurance is unknow should be included
 ; IBOUI =1 if vets that are no insured should be included
 ; IBOEXP = 1 if vets whose insurance is expiring should be included
MAIN ;
 ;***
 ;
 S IBOQUIT=0 K ^TMP($J,"SDAMA301"),^TMP("IBOUNP",$J)
 D CLINIC,CATGRY:'IBOQUIT,DRANGE:'IBOQUIT
 D:'IBOQUIT DEVICE
 G:IBOQUIT EXIT
QUEUED ; entry point if queued
 ;
 ;
 D LCLINIC
 ;
 ; look up info from scheduling
 S IBARRAY(1)=IBOBEG_";"_IBOEND_".99"
 S:$D(VAUTC)>9 IBARRAY(2)="VAUTC("
 S IBARRAY(3)="R"
 S IBARRAY("FLDS")="2;4"
 S IBARRAY("SORT")="P"
 S IBCOUNT=$$SDAPI^SDAMA301(.IBARRAY)
 I IBCOUNT<0 U IO W !!,"Scheduling Information not Available",! S IBOQUIT=1 F  S IBCOUNT=$O(^TMP($J,"SDAMA301",IBCOUNT)) Q:'IBCOUNT  W !?10,IBCOUNT,?20,$G(^TMP($J,"SDAMA301",IBCOUNT))
 ;
 D:'IBOQUIT LOOPPT^IBOUNP2,REPORT^IBOUNP3
EXIT ; 
 K ^TMP($J,"SDAMA301")
 ;
 ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IBOQUIT,IBOBEG,IBOEND,IBOUK,IBOUI,IBOEXP,VAUTC,VAUTD,IBARRAY,IBCOUNT
 K Y,POP,X1,X2,X,VAEL,VAERR,IBSDDAT,IBODIV,IBOCLN,DIRUT,VADM,VAOA,VAPD
 Q
 ;
DRANGE ; select a date range for report
 S DIR(0)="D^::EX",DIR("A")="Start with DATE" D ^DIR I $D(DIRUT) S IBOQUIT=1 K DIR Q
 S IBOBEG=Y,DIR("A")="Go to DATE" F  D ^DIR S:$D(DIRUT) IBOQUIT=1 Q:(Y>IBOBEG)!(Y=IBOBEG)!IBOQUIT  W !,*7,"ENDING DATE must follow or be the same as the STARTING DATE"
 S IBOEND=Y K DIR
 Q
 ;
DEVICE ;
 I $D(ZTQUEUED) Q
 W !!,*7,"*** Margin width of this output is 132 ***"
 W !,"*** This output should be queued ***"
 S %ZIS="MQ" D ^%ZIS I POP S IBOQUIT=1 Q
 I $D(IO("Q")) S ZTRTN="QUEUED^IBOUNP1",ZTIO=ION,ZTSAVE("VA*")="",ZTSAVE("IBO*")="",ZTDESC="OUTPATIENT INSURANCE REPORT" D ^%ZTLOAD W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED") D HOME^%ZIS S IBOQUIT=1 Q
 Q
 ;
CLINIC ; gets list of selected clinics,or sets VAUTC=1 if all selected
 ; IA#664
 N VAUTNI S VAUTNI=2,IBOQUIT=1
 D DIVISION^VAUTOMA Q:Y<0  S VAUTNI=2 D CLINIC^VAUTOMA Q:Y<0
 S IBOQUIT=0
 Q
 ;
LCLINIC ; lists clinics if not ALL included and ALL divisions
 N IBCLN,NODE
 I VAUTD'=1&(VAUTC=1) S VAUTC=0,IBCLN="" F  S IBCLN=$O(^SC(IBCLN)) Q:IBCLN=""  D
 .S NODE=$G(^SC(IBCLN,0))
 .;make sure it's the one of selected divisions division
 .Q:'$D(VAUTD(+$P(NODE,"^",15)))
 .;check that location is a clinic
 .Q:$P(NODE,"^",3)'="C"
 .S VAUTC(IBCLN)=""
 Q
 ;
CATGRY ; allows user to select categories to include in report
 S DIR(0)="Y",DIR("A")="Include veterans whose insurance is unknown"
 S DIR("B")="YES" D ^DIR K DIR I $D(DIRUT) S IBOQUIT=1 Q
 S IBOUK=Y
 S DIR(0)="Y",DIR("A")="Include veterans whose insurance is expiring"
 S DIR("B")="YES" D ^DIR K DIR I $D(DIRUT) S IBOQUIT=1 Q
 S IBOEXP=Y
 S DIR(0)="Y",DIR("A")="Include veterans who have no insurance"
 S DIR("B")="YES" D ^DIR K DIR I $D(DIRUT) S IBOQUIT=1 Q
 S IBOUI=Y
 Q
