LRARCAM4 ;DALISC/CKA - ARCHIVED RCS 14-4 REPORT PART 1
 ;;5.2;LAB SERVICE;**59**;August 31,1995
 ;same as LRCAPAM5 except for archived wkld file reference
EN ;
INST ;
 K LRDA,LRRPTM S LRDA(1)=1 I '$D(^LAR(67.99999,1,0)) W !!?10,"Sorry, there is no primary institution in file 67.99999.  Exiting." G EXIT
 ;Check for lab archival activity in archived status
 S LRART=67.9,LRARC=0 S LRARC=$O(^LAB(95.11,"O",2,LRART,LRARC))
 I LRARC="" D ERROR
DIV ;
 K DIC
 S DIC("A")="Select Division: "
 S DIC("B")=$P($G(^DIC(4,+DUZ(2),0)),U)
 S DIC=4,DIC(0)="AQENMZ"
 D ^DIC G:Y<1 EXIT S LRDA=Y,LRDA=$O(^LAR(67.99999,1,1,"B",+LRDA,0))
MONTHS ;
 K DA,DIC
 S DA(1)=LRDA(1),DA=+LRDA,DIC(0)="AQEN"
 S DIC="^LAR(67.99999,"_DA(1)_",1,"_DA_",1,"
 S DIC("A")="Select Month: "
 F  D ^DIC Q:Y<1  S LRRPTM(Y)=""
 I '$O(LRRPTM(0)) W !!?5,"Nothing Selected " G EXIT
DATTYP ;
 K DIR
 S DIR(0)="S^1:All workload;2:LMIP reportable workload;3:Non-LMIP workload"
 S DIR("A")="Enter the number for the workload data to report"
 S DIR("B")=1
 S DIR("?")="    reportable for LMIP."
 S DIR("?",1)="1 - will include all workload data in the file, period."
 S DIR("?",2)=" "
 S DIR("?",3)="2 - will include only workload which is associated with a"
 S DIR("?",4)="    WKLD code that is marked as reportable for LMIP uses."
 S DIR("?",5)=" "
 S DIR("?",6)="3 - will include any workload which is not marked as"
 D ^DIR G:($D(DTOUT))!($D(DUOUT)) EXIT
 S LRDTYP=Y,LRHD0=$S(LRDTYP=1:"ALL WORKLOAD DATA FOR: ",LRDTYP=2:"LMIP WORKLOAD DATA FOR: ",1:"Non-LMIP WORKLOAD DATA FOR: ")
REPTYP ;
 K DIR S DIR(0)="S^1:CDR report"
 S:LRDTYP=2 DIR(0)=DIR(0)_";2:LMIP report;3:CDR and LMIP reports"
 S DIR("A")="Enter the number for the report(s) you want printed"
 S DIR("B")=1
 D ^DIR G:($D(DTOUT))!($D(DUOUT)) EXIT S LRRTYP=Y
DETSUM ;
 I (LRRTYP=1)!(LRRTYP=3) D  G:$G(LREND) EXIT
 .W !!,"CDR format selection: "
 .K DIR,X,Y S DIR(0)="S^1:Detailed report;2:Summary report"
 .D ^DIR
 .I ($D(DTOUT))!($D(DUOUT)) S LREND=1 Q
 .S LRRPT=+X
 G ^LRARCAM5
EXIT ;
 D ^%ZISC
 D KILLALL^LRARCU
 K ^TMP($J,"RCS14-4"),^TMP($J,"LMIP"),LRERR
 Q
ERROR W !!,$C(7),"This file does not have an archival activity with the status of archived."
 W !,"Therefore this file may be incomplete if archiving is still in progress."
 W !!
 Q
