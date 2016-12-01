IBNCPDRA ;ALB/CFS - ROI EXPIRATION REPORT ;21-SEP-15
 ;;2.0;INTEGRATED BILLING;**550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;; External reference to ^PSS50 supported by DBIA #4533
 ;
 Q
 ;
EN ;
 N AIB,DEV,DATESEL,IBEXCEL
 W @IOF,!,"Release of Information Expiration Report",!!
 S DATESEL=$$DATE()  ; Date selection, (return format "beginning date^ending date")
 I DATESEL="^" W @IOF Q
 S AIB=$$SELAIB()  ;"Active", "Inactive" or "Both" selection.
 I AIB="^" W @IOF Q
 S IBEXCEL=$$EXCEL()  ;Microsoft EXCEL prompt selection.
 I IBEXCEL="^" W @IOF Q
 S DEV=$$DEVICE()
 W @IOF
 Q
 ;
 ; Validate user inputs.
DATE() ; Beginning expiration date and ending expiration date selection prompts.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,VAL,X,Y
 S VAL="",DIR(0)="DA^::EX",DIR("A")="Beginning Expiration Date: ",DIR("B")="T-180"
 W ! D ^DIR
 K DIR
 I $D(DIRUT) Q "^"  ; Abort
 S $P(VAL,U)=Y
 S DIR(0)="DA^"_VAL_"::EX",DIR("A")="Ending Expiration Date: ",DIR("B")="T+60"
 D ^DIR
 K DIR
 I $D(DIRUT) Q "^"  ; Abort
 S $P(VAL,U,2)=Y
 Q VAL
 ;
SELAIB() ; (A)ctive, (I)nactive or (B)oth selection prompt.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S^A:Active;I:Inactive;B:Both"
 S DIR("A")="Display (A)ctive or (I)nactive or (B)oth ROI Status",DIR("B")="Both"
 D ^DIR
 K DIR
 I $D(DIRUT) Q "^" ; Abort
 Q Y
 ;
EXCEL() ; Export the report to MS Excel?
 ; Function return values:
 ;   0 - User selected "No" at prompt.
 ;   1 - User selected "Yes" at prompt.
 ;   ^ - User aborted.
 ; This function allows the user to indicate whether the report should be
 ; printed in a format that could easily be imported into an Excel
 ; spreadsheet.  If the user wants to print in EXCEL format, the variable 
 ; IBEXCEL will be set to '1', otherwise IBEXCEL will be set to '0' for "No" 
 ; or "^" to abort.
 ;
 N DIR,DIRUT,Y
 S DIR(0)="Y"
 S DIR("A")="Export the report to Microsoft Excel (Y/N)"
 I $G(IBEXCEL)=1 S DIR("B")="YES"
 E  S DIR("B")="NO"
 S DIR("?",1)="If you want to capture the output from this report in a format that"
 S DIR("?",2)="could easily be imported into an Excel spreadsheet, then answer YES here."
 S DIR("?")="If you want a normal report output, then answer NO here."
 W !
 D ^DIR
 K DIR
 I $D(DIRUT) Q "^" ; Abort
 Q +Y
 ;
DEVICE() ; Device selection.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RET,RPTNAME,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 S RET=1
 S RPTNAME="Release of Information Expiration Report"
 I 'IBEXCEL D
 . W !!,"WARNING - THIS REPORT REQUIRES THAT A DEVICE WITH 132 COLUMN WIDTH BE USED."
 . W !,"IT WILL NOT DISPLAY CORRECTLY USING 80 COLUMN WIDTH DEVICES",!
 I IBEXCEL D
 . W !!?5,"Before continuing, please set up your terminal to capture the"
 . W !?5,"detail report data and save the detail report data in a text file"
 . W !?5,"to a local drive. This report may take a while to run."
 . W !!?5,"Note: To avoid undesired wrapping of the data saved to the file,"
 . W !?11,"please enter '0;256;99999' at the 'DEVICE:' prompt.",!
 . Q
 S ZTRTN="COMPILE^IBNCPDRA(RPTNAME,DATESEL,AIB,IBEXCEL)"
 S ZTDESC="IB REPORT: "_RPTNAME
 S ZTSAVE("RPTNAME")=""
 S ZTSAVE("DATESEL")=""
 S ZTSAVE("AIB")=""
 S ZTSAVE("IBEXCEL")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S RET=0
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 Q RET
 ;
COMPILE(RPTNAME,DATESEL,AIB,IBEXCEL) ; Compile the report.
 ; RPTNAME = Report Name
 ; DATESEL = The earliest and latest expiration dates (format: earliest^latest).
 ; AIB     = Active, Inactive or Both.
 ; IBEXCEL = 1 if user requested to display in EXCEL format; 0 otherwise.
 K ^TMP("IBNCPDRA",$J)
 I '$D(ZTQUEUED),'IBEXCEL U 0 W !,"Compiling Release of Information Expiration Report. Please wait..." U IO
 ; Collect the data
 D GETDATA(DATESEL,AIB)
 ; Display the report
 D REPORT^IBNCPDRB(RPTNAME,DATESEL,AIB,IBEXCEL)
 D ^%ZISC
 K ^TMP("IBNCPDRA",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
GETDATA(DATES,AIB) ; Get the data from ^IBT(356.25)
 ; DATES = The earliest and latest expiration dates (format: earliest^latest).
 ; AIB   = Active, Inactive or Both
 N ACTIVE,ADDED,CNT,DATE1,DATE2,D0,DOD,DPTIEN,DRUG,DRUGNAME,EFFDATE,ENTERDBY
 N EXPDATE,INS,INSNAME,PATNAME,NODE0,NODE1,STATUS,USERIEN
 S DATE1=$P(DATES,U),DATE2=$P(DATES,U,2)
 S CNT=0
 S D0=0 F  S D0=$O(^IBT(356.25,D0)) Q:'D0  D
 . S (DRUGNAME,ENTERDBY,INSNAME,PATNAME)=""
 . S CNT=CNT+1
 . I CNT#1000=0,'$D(ZTQUEUED) U 0 W "." U IO  ; Write another dot after "Please wait..."
 . S NODE0=$G(^IBT(356.25,D0,0)),NODE1=$G(^IBT(356.25,D0,1))
 . S DPTIEN=$P(NODE0,U,2)      ; patient ien to ^DPT file
 . S DRUG=$P(NODE0,U,3)        ; drug ien to ^PSDRUG file
 . S INS=$P(NODE0,U,4)         ; insurance ien to ^DIC(36
 . S EFFDATE=$P(NODE0,U,5)     ; effective date of ROI
 . S EXPDATE=$P(NODE0,U,6)     ; expiration date of ROI
 . S ACTIVE=$P(NODE0,U,7)      ; active? (0=no; 1=yes)
 . S ADDED=$P(NODE1,U)         ; date added to ROI Claims Tracking file
 . S USERIEN=$P(NODE1,U,2)     ; user who added the ROI entry
 . I EXPDATE="" Q
 . I EXPDATE<DATE1!(EXPDATE>DATE2) Q
 . I AIB="I",ACTIVE Q
 . I AIB="A",'ACTIVE Q
 . I DPTIEN'="" S PATNAME=$P($G(^DPT(DPTIEN,0)),U)
 . I PATNAME="" Q
 . S DOD=$P($G(^DPT(DPTIEN,.35)),U)  ; date of death
 . S STATUS=$S(ACTIVE:"A",1:"I")
 . I USERIEN'="" S ENTERDBY=$P($G(^VA(200,USERIEN,0)),U)
 . I ENTERDBY="" S ENTERDBY="UNKNOWN"
 . I DRUG'="" S DRUGNAME=$$DRUG(DRUG)
 . I DRUGNAME="" S DRUGNAME="NO DRUG NAME"
 . I INS'="" S INSNAME=$P($G(^DIC(36,INS,0)),U)
 . I INSNAME="" S INSNAME="NO INSURANCE NAME"
 . S ^TMP("IBNCPDRA",$J,EXPDATE,PATNAME,D0)=DOD_U_EFFDATE_U_STATUS_U_ADDED_U_ENTERDBY_U_INSNAME_U_DRUGNAME
 Q
 ; Get drug info
DRUG(DRUGIEN) ; Get drug name
 ; DRUGIEN = drug ien pointer
 N X
 K ^TMP($J,"IBNCPDRA_DRUG")
 D DATA^PSS50(DRUGIEN,"","","","","IBNCPDRA_DRUG") ;DBIA #4533
 S X=$G(^TMP($J,"IBNCPDRA_DRUG",DRUGIEN,.01))
 K ^TMP($J,"IBNCPDRA_DRUG")
 Q X
