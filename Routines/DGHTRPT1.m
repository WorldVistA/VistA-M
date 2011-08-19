DGHTRPT1 ;ALB/JRC - Home Telehealth Transmissions Report ; 10/14/05 12:38pm
 ;;5.3;Registration;**644**;Aug 13, 1993;Build 11
 ;
EN ;entry point from option
 ;Declare variable(s) and arrays
 N DGSD,DGED,I,ZTDESC,ZTIO,ZTSAVE,FLAG,SORT
 S FLAG=0
 ;Get beginning and ending dates
 D GETDATES Q:FLAG
 ;Get sort
 D GETSORT Q:FLAG
 ;Queue Report
 S ZTIO=""
 S ZTDESC="Home Telehealth Transmission Report"
 F I="DGSD","DGED","SORT" D
 .S ZTSAVE(I)=""
 D EN^XUTMDEVQ("EN1^DGHTRPT1",ZTDESC,.ZTSAVE)
 Q
 ;
EN1 ;Tasked entry point
 ;Input : DGSD  -  FM format report start date
 ;        DGED   -  FM format report end date
 ;
 ;Output : None
 ;
 ;Declare variables
 N DGSD1,DGED1,CNT,ICNT,ACNT,LN,SCRNARR
 N NODE,STOP,PAGENUM,FLAG
 S DGED1=DGED+.9999,DGSD1=DGSD-.0001,(CNT,ACNT,ICNT,PAGENUM,STOP)=0
 S SCRNARR="^TMP(""DGHT"",$J,""SCRNARR"")",FLAG=0
 K @SCRNARR
 D HEADER I STOP D EXIT Q
 D GETDATA
 I 'CNT D  Q
 .W !
 .W !,"***********************************************"
 .W !,"*  NOTHING TO REPORT FOR SELECTED TIME FRAME  *"
 .W !,"***********************************************"
 .D WAIT
 D DETAIL I STOP D EXIT Q
 D TOTAL
 D EXIT
 Q
 ;
GETDATES ;Prompt for start date
 N DIR,DIRUT,X,Y
 S DIR(0)="D^:NOW:EX"
 S DIR("A")="Enter Report Start Date"
 S DIR("B")=$$FMTE^XLFDT($$NOW^XLFDT,"1D")
 D ^DIR
 I $D(DIRUT) S FLAG=1 Q
 S DGSD=Y
 ;Prompt for end date
 K DIR,DIRUT,X,Y
 S DIR(0)="D^:NOW:EX"
 S DIR("A")="Enter Report Ending Date"
 S DIR("B")=$$FMTE^XLFDT($$NOW^XLFDT,"1D")
 D ^DIR
 I $D(DIRUT) S FLAG=1 Q
 S DGED=Y
 Q
 ;
GETSORT ;Select sort, 1 for patient or 2 for trans date
 ;Declare variables
 N DIR,X,Y,DIRUT,DIROUT,DTOUT,DUOUT
 ;Get sort
 S DIR(0)="SC^1:Patient;2:Transmission Date;"
 S DIR("A")="Select sorting criteria"
 D ^DIR
 I $D(DIRUT) S FLAG=1 Q
 S SORT=Y
 Q
 ;
GETDATA ;Get data
 ;Declare variables
 N DG0,DG1,DGDA0,DGDA1,PATIENT,VENDOR,INACTDT,DATE,MSGTYPE,STATUS
 F  S DGSD1=$O(^DGHT(391.31,"C",DGSD1)) Q:(DGSD1>DGED1)!('DGSD1)  D
 .S DGDA0=0
 .F  S DGDA0=$O(^DGHT(391.31,"C",DGSD1,DGDA0)) Q:'DGDA0  D
 ..S DGDA1=0
 ..F  S DGDA1=$O(^DGHT(391.31,"C",DGSD1,DGDA0,DGDA1)) Q:'DGDA1  D
 ...;Get data nodes and icrement conunter
 ...S DG0=$G(^DGHT(391.31,DGDA0,0))
 ...Q:DG0=""
 ...S DG1=$G(^DGHT(391.31,DGDA0,"TRAN",DGDA1,0))
 ...;Quit if there is no transaction data or type = inactivation
 ...Q:DG1=""
 ...Q:$P(DG1,U,4)="I"
 ...S PATIENT=$P(DG0,U,2),VENDOR=$P(DG0,U,3),INACTDT=$P(DG0,U,7)
 ...S DATE=$P(DG1,U,1),MSGTYPE=$P(DG1,U,4)
 ...I 'INACTDT S STATUS="Active"
 ...;If there is an Inactivation date validate trans status
 ...I INACTDT D
 ....S DGDA1=$O(^DGHT(391.31,DGDA0,"TRAN",DGDA1))
 ....S DG1=$G(^DGHT(391.31,DGDA0,"TRAN",DGDA1,0))
 ....S STATUS=$S($P(DG1,U,7)="A":"Inactive",$P(DG1,U,7)="R":"Active",1:"Active")
 ...;Resolve external values for PATIENT
 ...S PATIENT=$$GET1^DIQ(2,PATIENT,.01,"E")
 ...;Resolve external value for VENDOR
 ...S VENDOR=$$GET1^DIQ(4,VENDOR,.01,"E")
 ...;Resolve external value for COORD
 ...;Increment counters and save for later
 ...S CNT=CNT+1
 ...I STATUS="Active" S ACNT=ACNT+1
 ...I STATUS="Inactive" S ICNT=ICNT+1
 ...S ^TMP("DGHT",$J,$S(SORT=1:PATIENT,1:DATE),CNT)=PATIENT_U_STATUS_U_DATE_U_VENDOR
 Q
HEADER ;print header
 S PAGENUM=PAGENUM+1
 S $P(LN,"-",80)=""
 W @IOF
 W !,"Home Telehealth Patient Summary Report ",?65,"Page: ",PAGENUM
 W !!,"Report for ",$$FMTE^XLFDT(DGSD)," thru ",$$FMTE^XLFDT(DGED)
 W !!,?1,"Patient",?25,"Status",?34,"Date of Last Change",?56,"HT Vendor"
 W !?1,LN
 Q
 ;
DETAIL ;Print detailed line
 ;Input  :  ^TMP("DGHT",$J) full global reference
 ;          PATIENT   -   HTH Patient
 ;          STATUS    -   Registration Status
 ;          DATE      -   Event/Transmission Date
 ;          VENDOR    -   HTH Vendor Server
 ;Output  : None
 ;Declare variables
 N SORT,RECORD
 S SORT=""
 F  S SORT=$O(^TMP("DGHT",$J,SORT)) Q:SORT=""  D  Q:STOP
 .S RECORD=0 F  S RECORD=$O(^TMP("DGHT",$J,SORT,RECORD)) Q:'RECORD!(STOP)  D  Q:STOP
 ..S NODE=^TMP("DGHT",$J,SORT,RECORD)
 ..W !,?1,$E($P(NODE,U,1),1,22),?25,$P(NODE,U,2),?34,$$FMTE^XLFDT($P(NODE,U,3),"2Z"),?56,$E($P(NODE,U,4),1,23)
 ..I $Y>(IOSL-5) D WAIT Q:STOP  D HEADER
 Q
 ;
TOTAL ;Report totals
 W !!?1,"Total Number of Active Patient Record(s): ",?45,$J($FNUMBER(ACNT,",",0),8)
 W !?1,"Total Number of Inactive Patient Record(s): ",?45,$J($FNUMBER(ICNT,",",0),8)
 W !?1,"Total Number of Patient Record(s): ",?45,$J($FNUMBER(CNT,",",0),8)
 Q
 ;
WAIT ;End of page logic
 ;Input   ; None
 ;Output  ; STOP - Flag inidcating if printing should continue
 ;                 1 = Stop     0 = Continue
 ;
 S STOP=0
 ;CRT - Prompt for continue
 I $E(IOST,1,2)="C-"&(IOSL'>24) D  Q
 .F  Q:$Y>(IOSL-3)  W !
 .N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 .S DIR(0)="E"
 .D ^DIR
 .S STOP=$S(Y'=1:1,1:0)
 ;Background task - check taskman
 S STOP=$$S^%ZTLOAD()
 I STOP D
 .W !,"*********************************************"
 .W !,"*  PRINTING OF REPORT STOPPED AS REQUESTED  *"
 .W !,"*********************************************"
 Q
EXIT ;Kill temp global
 K ^TMP("DGHT",$J)
 Q
