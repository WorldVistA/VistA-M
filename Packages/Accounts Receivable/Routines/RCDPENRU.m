RCDPENRU ;ALB/SAB - AR DM DATA EXTRACTION (MENU OPTIONS/TRANSMIT E-MAIL) ;15-JUL-15
 ;;4.5;Accounts Receivable;**304**;Mar 20, 1995;Build 104
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; Tag which runs starts the periodic AR DM reporting processes
AUTO(RCMRUN,RCMAN) ;
 ;
 ; RCMRUN - Which report to run
 ;        E-EFT/ERA Trending Report
 ;        V-Volume Statistics Report
 ; RCMAN - Manual or Automated (1=Manual, 0 or Null - Automated
 ;
 N RCENDDT,RCBEGDT,RCPYRLST,I,RCFLG,RCDATA,RCVOL,RCEFT,RCDIV
 ;
 S RCMAN=+$G(RCMAN)
 ; Set variables
 S RCENDDT=$$DT^XLFDT
 S RCBEGDT=$$FMADD^XLFDT(RCENDDT,-90) ; Previous 90 days
 S RCPYRLST("A")="",(RCPYRLST("START"),RCPYRLST("END"))=""
 S RCDIV("A")=""   ;all divisions
 S:$G(RCMRUN)="" RCMRUN="B"
 ;
 ; Quit if the end date (the run date) is not Saturday.
 I ('RCMAN),($$DOW^XLFDT(RCENDDT)'="Saturday") Q
 ;
 S (RCVOL,RCEFT,I)=0
 ; Retrieve enable/disabled flags and location in array for the flag for the reports
 F  S I=$O(^RCDM(344.9,I)) Q:'I  D
 .  S RCDATA=$G(^RCDM(344.9,I,0))
 .  Q:RCDATA=""
 .  S RCFLG(I)=RCDATA
 .  S:RCDATA["VOLUME" RCVOL=I
 .  S:RCDATA["EFT/ERA" RCEFT=I
 ;
 ; Run Volume Statistics Report if enabled
 I +RCVOL,(RCMRUN'="E") D:+$P($G(RCFLG(RCVOL)),U,2) AUTO^RCDPENR1(0,RCBEGDT,RCENDDT,.RCPYRLST,"A","G")
 ;
 S (RCPYRLST("TIN","START"),RCPYRLST("TIN","END"))=""
 ;
 ; Run EFT/ERA Trending Report if enabled
 I +RCEFT,(RCMRUN'="V") D:+$P($G(RCFLG(RCEFT)),U,2) AUTO^RCDPENR2(0,RCBEGDT,RCENDDT,.RCPYRLST,"A","G",1,8,.RCDIV)
 ;
 ;Cleanup
 K ^TMP("RCDPENR2",$J),^TMP("RCDPEADP",$J),^TMP("RCDPENR1",$J)
 ;
 ; Write mesage back to the user...
 I RCMAN W $S(RCMRUN="E":"THE EFT/ERA TRENDING REPORT HAS ",RCMRUN="V":"THE VOLUME STATISTICS REPORT HAS ",1:"ALL REPORTS HAVE "),"BEEN STARTED.",!
 ;
 Q
VPE ; - View/print entries in RCDPE DM REPORT ARCHIVE file (#344.91) for a given report date.
 N RCDATA,RCHDR,RCIEN,RCDT,RCRPT,RCPAGE,RCDISP,POP
 ;
 S RCPAGE=0,RCDISP=1
 ; Check for entries
 I '$O(^RCDM(344.91,0)) W !!,"There are no entries available.",*7 Q
 ;
 ; Ask for the date to report on
 S RCIEN=$$GETDT
 Q:RCIEN=-1
 ;
 ;Select output device
 S %ZIS="QM" D ^%ZIS Q:POP
 ;Option to queue
 I $D(IO("Q")) D  Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="VPE1^RCDPENRU"
 .S ZTDESC="EDI Volume Statistics Report"
 .S ZTSAVE("RC*")=""
 .D ^%ZTLOAD
 .I $D(ZTSK) W !!,"Task number "_ZTSK_" has been queued."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 ;
 ;Reprint the report to the specified device
VPE1 ;
 ; Display the selected report.
 ;
 S RCRPT=$P(RCIEN,U,2),RCIEN=$P(RCIEN,U)
 ;
 ; Extract the data and build the data string or array.
 D GETRPT(RCIEN,.RCHDR,.RCDATA)
 ;
 ; Print the VOLUME STATISTICS reports
 I RCRPT="VOLUME STATISTICS" D REPRINT^RCDPENR1(RCHDR,RCDATA)
 I RCRPT="EFT/ERA TRENDING" D REPRINT^RCDPENR2(RCIEN)
 ;
 Q
 ;
GETDT() ;
 ;
 N X,Y,DIC,DTOUT,DUOUT
 ;
 S DIC="^RCDM(344.91,",DIC(0)="AEMQZ",DIC("A")="Enter MONTH/YEAR: "
 S DIC("?")="Enter the Month/Year (MM/DD) of the report(s) to view or print"
 S DIC("W")="D EN^DDIOL($$UP^XLFSTR($$FMTE^XLFDT($P(^(0),U,2),9)),,""?40"")"
 D ^DIC
 K DIC
 I $G(DTOUT)!$G(DUOUT) S Y=-1 Q
 Q:Y'>0 Y
 Q Y
 ;
 ;Return the report data
GETRPT(RCIEN,RCHDR,RCDATA) ;
 ; Input  -  RCIEN  - IEN for the report
 ; Output -  RCHDR  - Header information for the report
 ;           RCDATA - Body of data for the report.
 ;
 ; Initiaze variables
 N RCI,RCSTR,RCD0
 ;
 S RCI=1,RCSTR=""
 ;
 ; get the header record info in line one.
 S RCHDR=$G(^RCDM(344.91,RCIEN,1,RCI,0))
 ;
 ; get the info for the report body
 F  S RCI=$O(^RCDM(344.91,RCIEN,1,RCI)) Q:'RCI  D
 . S RCD0=$G(^RCDM(344.91,RCIEN,1,RCI,0))
 . S RCSTR=RCSTR_$P(RCD0,U,2)_U
 ;
 ; remove the extra ^ piece
 S RCDATA=$P(RCSTR,U,1,$L(RCSTR,U)-1)
 Q
DER ; - Disable/enable report(s) or extraction process.
 N RCSTAT,RCSTTXT,RCSTTXT1,RCDATA,RCIEN,RCDMNM
 N X,Y,DIR,DIRUT,DIROUT,DUOUT,DTOUT
 ;
 S (Y,RCIEN)=0
 F  S RCIEN=$O(^RCDM(344.9,RCIEN)) Q:'RCIEN  D  Q:Y=-1
 . ;
 . ; Ask user to disable/enable reports.
 . W ! S DIR(0)="Y",DIR("B")="NO"
 . ;values should be the same for the reports, so get the status of the first report.
 . S RCDATA=$G(^RCDM(344.9,RCIEN,0))
 . Q:RCDATA=""
 . S RCSTAT=$P(RCDATA,U,2)
 . S RCDMNM=$P(RCDATA,U)
 . ; set up message
 . S:RCSTAT RCSTTXT="enabled",RCSTTXT1="disable"
 . S:'RCSTAT RCSTTXT="disabled",RCSTTXT1="re-enable"
 . ;
 . S DIR("A",1)="The nightly AR DM "_RCDMNM_" report is currently "_RCSTTXT_"."
 . S DIR("A")=" Do you want to "_RCSTTXT1_" it?"
 . D ^DIR K DIR
 . I $G(DTOUT)!$G(DUOUT) S Y=-1 Q
 . D:Y UPDSTAT(RCSTAT,RCIEN)
 Q
 ;
 ; Update the status of the 
UPDSTAT(RCSTAT,RCIEN) ;
 N DA,DIE,DR,NEWSTAT,X,Y
 ;
 S NEWSTAT=$S(RCSTAT=0:1,1:0)
 S DA=RCIEN,DIE="^RCDM(344.9,",DR=".02///"_NEWSTAT
 D ^DIE
 Q
 ;
MAN1 ; - Manually start AR DM extraction process.
 N DIRUT,DIROUT,DUOUT,X,Y,DTOUT,DIR
 ;
 ;Let the process know that this is a rerun, do not transmit.
 S DIR("A")="Enter the AR DM report to Manually Start: "
 S DIR(0)="SAO^V:VOLUME STATISTICS;E:EFT/ERA TRENDING REPORT;B:BOTH"
 S DIR("?",1)="Enter V to Manually start the Volume Statistics report, E for the "
 S DIR("?")="EFT/ERA Trending Report, or B for Both reports"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 ;
 ; Run the selected report
 D AUTO(Y,1)
 Q
 ;
MAN2 ; - Manually transmit DM extract file.
 N DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT,X
 N RCIEN,RCBGDT,RCENDDT,RCSUB,RCXMZ
 ;
 S RCPAGE=0,RCDISP=1
 ; Check for entries
 I '$O(^RCDM(344.91,0)) W !!,"There are no entries available to retransmit.",*7 Q
 ;
MAN2A ; Ask for the date and report to retransmit
 S RCIEN=$$GETDT
 Q:RCIEN=-1
 ;
 S RCBGDT=$P($$GET1^DIQ(344.91,+RCIEN_",",".04","I"),".")
 S RCENDDT=$P($$GET1^DIQ(344.91,+RCIEN_",",".05","I"),".")
 S RCSUB=$$GET1^DIQ(344.91,+RCIEN_",",".01","E")
 ;
 ;Confirm the resend
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you want to transmit this report? "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="")  Q
 ;
 ;Transmit
 S RCXMZ=$$XM(+RCIEN,RCBGDT,RCENDDT,RCSUB)
 ;
 ;Check for success
 I $G(RCXMZ) W " Done."
 E  D  G:Y MAN2A
 .S DIR(0)="Y",DIR("B")="NO"
 .S DIR("A")="The DM extract message failed to transmit...try again"
 .W !,*7 D ^DIR K DIR
 .I $D(DTOUT)!$D(DUOUT)!(Y="")  Q
 ;
 Q
 ;
 ; - DM extract reports message (shown when DM Menu is called up).
MSG ;
 N RCDT,RCDT1,RCST,RCN,RCIEN,RCFLG,RCNAME
 ;
 W @IOF
 S RCDT=$$M1^RCDPENR4(DT,1),RCDT1=$$M1^RCDPENR4(RCDT,3)
 S RCIEN=0,RCFLG=0
 F  S RCIEN=$O(^RCDM(344.91,"C",RCDT,RCIEN)) Q:'RCIEN  D
 . S RCN=$G(^RCDM(344.91,RCDT,0)),RCNAME=$P(RCN,U),RCST=$P(RCN,U,3) I 'RCST G ENQ
 . I RCST=1 D  Q
 . . W !,"The "_RCNAME_" DM extract process for ",RCDT1," was initiated on "
 . . W $$M1^RCDPENR4($P(RCN,U,4),3),!,"but it hasn't run yet.",!
 . . D MSQ
 . ;
 . I RCST=3 D  Q
 . . W !,"The "_RCNAME_" DM report data for ",IBDT1," has been successfully"
 . . W !,"extracted on ",$$M1^RCDPENR4($P(RCN,U,5),3),". This data has been"
 . . W !,"sent to the Central Collections mail group in FORUM.",*7
 . ; Set array of reports that are not completed or on standby
 . S ^TMP("RCDPENRU",$J,"DM",RCIEN)=""
 I $D(^TMP("RCDPENRU",$J,"DM")) D MSG1(RCDT,RCDT1)
 K ^TMP("RCDPENRU",$J)
 Q
 ;
 ; Output those currently started.
MSG1(RCDT,RCDT1) ;
 ;
 N RCIEN
 ;
 W !
 D MSH(RCDT1)
 W !
 S RCIEN=0
 F  S RCIEN=$O(^TMP("RCDPENRU",$J,"DM",RCIEN)) Q:RCIEN=""  D
 . S RCDATA=$G(^RCDM(344.91,RCIEN,0))
 . Q:'RCDATA
 . I $Y'<(IOSL-14) R X:DTIME
 . S RCSTAT=$$GET1^DIQ(344.91,RCIEN_",",.03,"E") ; Get the external display for the status
 . S RCNAME=$P(RCDATA,U)
 . W RCDT1,?12,RCNAME,?35,RCSTAT,!
 Q
 ;
 ; Restart Message
MSQ ;
 W !,"If you want, you can restart the DM extract process"
 W !,"by using the ""Manually Start DM Extraction"" option in"
 W !,"the Diagnostic Measures Extract Menu."
 Q
 ;
MSH(RCDT1) ; - DM extract reports message header.
 W !,"Data for the following DM reports have not been extracted"
 W !," for ",RCDT1,":",!!,*7
 Q
 ;
CHK ; - Check file #344.91 for completed and/or transmitted DM extracts
 ;   (shown when DM Extract Menu is called up).
 N RCDT,RCDATA,RCDATE,RCENDDT,RCNEXDT,RCDONE,RCMSARY,RCVS,RCTR,RCI,RCJ,RCEMARY
 N RCINCARY,RCMSG,RCRPTYPE,RCTREM,RCTRST,RCVSEM,RCVSST,RCJD,RCQ,RC0
 ;
 S RCDT=$$DT^XLFDT,RCI=0
 F  S RCI=$O(^RCDM(344.91,"C",RCI)) Q:'RCI  D
 . ; - Check to see if next month is missing from file, if any.
 . S RCNEXDT=RCI+$S($E(RCI,4,5)=12:8900,1:100)
 . I $D(^RCDM(344.91,"C",RCNEXDT))!(RCNEXDT>RCDT) Q
 . ;
 . S RCDONE=0
 . ;check for any future missing dates between the current and next days run.
 . F  Q:RCDONE  D
 . . S RCNEXDT=RCNEXDT+$S($E(RCNEXDT,4,5)=12:8900,1:100)
 . . I $D(^RCDM(344.91,"C",RCNEXDT))!(RCNEXDT>RCDT) S RCDONE=1 Q
 . . ;
 . . ;Date missing update missing array for both reports.
 . . S RCMSARY("VS",RCNEXDT)="",RCMSARY("TR",RCNEXDT)=""
 . ;
 . ;init loop variable and report missing flags to 1 (missing)
 . S RCJ=0,RCVS=1,RCTR=1
 . F  S RCJ=$O(^RCDM(344.91,"C",RCI,RCJ)) Q:'RCJ  D 
 . . S RCJD=$G(^RCDM(344.91,RCJ,0))
 . . S RCRPT=$P(RCJD,U)
 . . S RCRPTYPE=$S(RCRPT="VOLUME STATISTICS":"VS",1:"TR")
 . . I RCRPT="VOLUME STATISTICS" S RCVS=0 Q
 . . I RCRPT="EFT/ERA TRENDING REPORT" S RCTR=0
 . ;
 . ;update missing array
 . S:RCVS RCMSARY("VS",RCI)=""
 . S:RCTR RCMSARY("TR",RCI)=""
 . ;
 . ;check status of reports to report completion, transmission issues
 . ;init loop variable and report missing flags to 1 (missing)
 . S RCJ=0,RCVSST=1,RCTRST=1,RCVSEM=1,RCTREM=1
 . F  S RCJ=$O(^RCDM(344.91,"C",RCI,RCJ)) Q:'RCJ  D 
 . . S RCJD=$G(^RCDM(344.91,RCJ,0))
 . . S RCRPT=$P(RCJD,U),RCSTAT=$P(RCJD,U,3),RCMSG=$P(RCJD,U,7)
 . . S RCRPTYPE=$S(RCRPT="VOLUME STATISTICS":"VS",1:"TR")
 . . I RCSTAT'=3 S RCINCARY(RCRPTYPE,RCI)=""
 . . I 'RCMSG S RCEMARY(RCRPTYPE,RCI)=""
 ;
 I '$D(RCMSARY),'$D(RCINCARY),'$D(RCEMARY) W "Done" Q
 ;
 ;Report what dates are missing for which reports, which are incomplete and which were not sent
 ;
 I $D(RCMSARY) D
 . S RCJ=0 F  S RCJ=$O(RCMSARY(RCJ)) Q:RCJ=""  D
 . . S RCQ=$S(RCJ="TR":"EFT/ERA TRENDING REPORT",1:"VOLUME STATISTICS")
 . . I $D(RCMSARY(RCJ))=10 W !!,"The "_RCQ_" data has NOT been fully extracted for these months:",!,*7
 . . S RC0=0 F  S RC0=$O(RCMSARY(RCJ,RC0)) Q:'RC0  W "  ",$$M1^RCDPENR4(RC0,3)
 . W !,"If you want, you can start the DM extract process for these"
 . W !,"months by using the ""Manually Start DM Extraction"" option."
 ;
 I $D(RCINCARY) D
 . S RCJ=0 F  S RCJ=$O(RCINCARY(RCJ)) Q:RCJ=""  D
 . . S RCQ=$S(RCJ="TR":"EFT/ERA TRENDING REPORT",1:"VOLUME STATISTICS")
 . . I $D(RCINCARY(RCJ))=10 W !!,"The "_RCQ_" data has NOT been transmitted for these months:",!,*7
 . . S RC0=0 F  S RC0=$O(RCINCARY(RCJ,RC0)) Q:'RC0  W "  ",$$M1^RCDPENR4(RC0,3)
 . W !,"If you want, you can re-transmit the DM extract data for these"
 . W !,"months by using the ""Manually Transmit DM Extract"" option."
 ;
 I $D(RCEMARY) D
 . S RCJ=0 F  S RCJ=$O(RCEMARY(RCJ)) Q:RCJ=""  D
 . . S RCQ=$S(RCJ="TR":"EFT/ERA TRENDING REPORT",1:"VOLUME STATISTICS")
 . . I $D(RCEMARY(RCJ))=10 W !!,"The "_RCQ_" data has NOT stored an email message for these months:",!,*7
 . . S RC0=0 F  S RC0=$O(RCEMARY(RCJ,RC0)) Q:'RC0  W "  ",$$M1^RCDPENR4(RC0,3)
 . W !,"If you want, you can re-transmit the DM extract data for these"
 . W !,"months by using the ""Manually Transmit DM Extract"" option."
 ;
 Q
XM(RCDMIEN,RCBEGDT,RCENDDT,XMSUB) ; - Create/transmit DM extract file message.
 N DA,DIE,DR,RCSTE,X,Y,XMTEXT,XMDUZ,DT,CT,XMZ,RCJ,DT,DT1,DTRNG,RCXMZ,RCMG
 S RCXMZ=0
 K ^TMP("RCDPENRU",$J) S RCXMZ=0,DT=$$DT^XLFDT,RCSTE=$$SITE^VASITE,X=$E(DT,4,7)_(1700+$E(DT,1,3))
 S ^TMP("RCDPENRU",$J,1)="HDR^"_$P(RCSTE,U,3)_U_$P(RCSTE,U,2)_U_X
 S CT=1,RCJ=0
 S DTRNG=$E(RCBEGDT,4,7)_(1700+$E(RCBEGDT,1,3))_"~"_$E(RCENDDT,4,7)_(1700+$E(RCBEGDT,1,3))
 ; Build the body of the message
 F  S RCJ=$O(^RCDM(344.91,RCDMIEN,1,RCJ)) Q:'RCJ  D
 . S CT=CT+1
 . S ^TMP("RCDPENRU",$J,CT)="DAT~"_DTRNG_"^"_$G(^RCDM(344.91,RCDMIEN,1,RCJ,0))
 ;
 S ^TMP("RCDPENRU",$J,CT+1)="END^"_$P(RCSTE,U,3)
 S XMSUB=XMSUB_"-"_DTRNG_" ("_$P(RCSTE,U,2)_")"
 ;
 S RCMG=$P($G(^IBE(350.9,1,4)),U,5)
 Q:RCMG="" RCXMZ
 ;
 S XMDUZ="ACCOUNTS RECEIVABLE PACKAGE"
 S XMTEXT="^TMP(""RCDPENRU"",$J,",XMY(RCMG)=""
 S XMTEXT="^TMP(""RCDPENRU"",$J,",XMY(RCMG)=""
 D SEND
 ;
 I $G(XMZ) S RCXMZ=XMZ,DIE="^RCDM(344.91,",DA=RCDMIEN,DR=".03///3;.07///1;.06///"_XMZ D ^DIE
 ;
 Q RCXMZ
 ;
ENQ K IB2,IBDT2,IBD1,IBD2,IBDT,IBFL,IBFR,IBN,IBS,IBST,IBST1,IBX,IBX1,BY,DHD
 K DIC,DIOEND,FLDS,FR,IOP,L,TO,X,XMZ,Y,%
ENQ1 K IB0,IB1,IBC,IBDT1,IBMG,IBSTE,XMSUB,XMTEXT,XMY,^TMP("DME",$J)
 Q
 ;
SEND ; Calls ^XMD to send the mail message with the data extracted
 ; Obs: By NEWing DUZ, ^XMD will assume DUZ=.5 (Sender=POSTMASTER)
 ;
 N DUZ D ^XMD
 Q
 ;
 ; Pass RCPAY by reference
GETPAY(RCPAY) ; Get payer information
 N EX,RCLPAY,DTOUT,DUOUT,X,Y,DIR,DIRUT,DIROUT
 S EX=1 ; Exit status
 S DIR("A")="Select (A)ll or (R)ange of Payer Names?: ",DIR(0)="SA^A:All Payer Names;R:Range or List of Payer Names"
 S DIR("B")="ALL" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S EX=0 Q EX
 S RCLPAY=Y I $G(Y)="A" S RCPAY="ALL",RCPAY("DATA")="ALL" G GPO
 ; Get Range of Payers from Insurance file
 I RCLPAY="R" S EX=$$GETRANG(.RCPAY,"P"),RCPAY="R"
GPO ;
 Q EX
 ;
 ; RTNARR - Indirect Return array
 ; TYPE - The type of lookup "P" - Payer; "T" - TIN
GETRANG(RTNARR,TYPE) ;
 N DIC,D,RCDTN,RCDN,RCPT,DTOUT,DUOUT,DIRUT,DIROUT,X,Y,IDX
 I $G(TYPE)=""!("PT"'[$G(TYPE)) S RTNARR="ERROR" Q  ; Quit if TYPE not correct
 S IDX=$S(TYPE="P":"B",TYPE="T":"C")
 K DIC S DIC="^DIC(36,",DIC(0)="AES",D=IDX
 S DIC("A")="Start with "_$S(TYPE="P":"Payer Name",TYPE="T":"Payer TIN")_": "
 I TYPE="P" S DIC("W")=""
 E  S DIC("W")="D EN^DDIOL($P(^(0),U,1),,""?35"")"
 D IX^DIC I $D(DTOUT)!$D(DUOUT)!(Y="")!(Y=-1) Q 0
 S RCDN=$O(^DIC(36,IDX,X,""))
 S RTNARR("START")=RCDN_U_X_U_Y,RTNARR("DATA")=X
 ;
 K DIC S DIC="^DIC(36,",DIC(0)="AES",D=IDX
 S DIC("A")="Go to with "_$S(TYPE="P":"Payer Name",TYPE="T":"Payer TIN")_": "
 I TYPE="P" S DIC("W")=""
 E  S DIC("W")="D EN^DDIOL($P(^(0),U,1),,""?35"")"
 D IX^DIC I $D(DTOUT)!$D(DUOUT)!(Y="")!(Y=-1) Q 0
 S RCDN=$O(^DIC(36,IDX,X,""))
 S RTNARR("END")=RCDN_U_X_U_Y
 I TYPE="P" S RTNARR("DATA")=$P(RTNARR("START"),U,4)_":"_$P(RTNARR("END"),U,4)
 I TYPE="T" S RTNARR("DATA")=$P(RTNARR("START"),U,2)_":"_$P(RTNARR("END"),U,2)
 Q 1
 ;
 ;Retrieve a list of valid payers
GETPAYER(RCPYRLST) ;
 ;
 N RCANS
 ;
 ; Initialize start and end nodes in array
 S (RCPYRLST("START"),RCPYRLST("END"))=""
 ;
 ; Ask user whether they wish to see All payers, a specific Payer, or a range of payers
 S RCANS=$$GETANS(1)
 I RCANS=-1 S RCPYRLST("QUIT")="" Q
 ;
 ; Exit if user wants all payers
 Q:$E(RCANS)="A"
 ;
 ; Get the payer if the user wishes a single payer
 I RCANS="S" D  Q
 . S RCANS=$$GETANS(2)
 . I RCANS=-1 S RCPYRLST("QUIT")="" Q
 . S (RCPYRLST("START"),RCPYRLST("END"))=RCANS
 ;
 ; User wishes a range, Get the Beginning payer
 S RCANS=$$GETANS(3)
 I RCANS=-1 S RCPYRLST("QUIT")="" Q
 S RCPYRLST("START")=$$UP^XLFSTR(RCANS)
 ;
 ; Get the ending payer
 S RCANS=$$GETANS(4)
 I RCANS=-1 S RCPYRLST("QUIT")="" Q
 S RCPYRLST("END")=$$UP^XLFSTR(RCANS)
 ;
 Q
 ;
 ;Get users answers to questions for reports.
GETANS(RCIDX) ;
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT
 ;
 ; Ask the user what kind of report
 I RCIDX=1 D
 . S DIR("?")="Select to (A) to see All payers on the report or (R) for a range of payers."
 . S DIR("A")="(A)LL PAYERS, (R)ANGE OF PAYER NAMES: "
 . ;S DIR("S")="A:ALL;S:SINGLE;R:RANGE"
 . S DIR("B")="ALL",DIR(0)="SA^A:ALL;R:RANGE"
 ;
 ; Ask the user for the Payer to report on (Single Payer option)
 I RCIDX=2 Q $$SPAY^RCDPENR4
 ;
 ; Ask the user for the payer to start the reporting on (Range Option)
 I RCIDX=3 D
 . S DIR("?")="Enter the first Payer name to run this report on."
 . S DIR("A")="Select First Payer: ",DIR(0)="FA"
 ;
 ; Ask the user for the payer to end the reporting on (Range Option)
 I RCIDX=4 D
 . S DIR("?")="Enter the last Payer name to run this report on."
 . S DIR("A")="Select Last Payer: ",DIR(0)="FA"
 ;
 I RCIDX=5 D
 . S DIR("?")="Select to (A) to see All Payer TINs on the report, or (R) for a Range of Payer TINs."
 . S DIR("A")="SELECT (A)LL PAYER TINs, (R)ANGE of PAYER TINs: "
 . ;S DIR("S")="A:All;R:Range"
 . S DIR("B")="ALL",DIR(0)="SA^A:ALL;R:RANGE"
 ;
 I $G(DIR(0))="" S DIR(0)="FA"
 D ^DIR
 K DIR
 I ($D(DIRUT))!($D(DUOUT)) S Y=-1
 I Y="N" S Y=-1
 Q Y
 ;
 ; Compile the list of payers.  The Payer IENS are extracted
PYRARY(RCSTART,RCEND,RCSWITCH) ;
 ;
 ;RCSTART - The text to start the search for insurance companies
 ;RCEND - The text to end the search for insurance companies,
 ;RCSWITCH - A flag to indicate which file to perform the insurance lookup
 ;           1 or Null) RCDPE AUTO-PAY EXCLUSION FILE (#344.6)
 ;                   2) INSURANCE COMPANY FILE (#36)
 ;
 N RCI,RCJ,RCFILE
 ;
 ; Clear any older data out of the array.
 K ^TMP("RCDPEADP",$J,"INS")
 ;
 ; If start and end are NULL, then User wishes all payers, set flag and quit
 I (RCSTART=""),(RCEND="") S ^TMP("RCDPEADP",$J,"INS","A")="" Q
 ;
 I $G(RCSWITCH)=2 D INSLKUP(RCSTART,RCEND) Q
 ;
 ; If single payer, find the IEN if it exists and post it.
 I RCSTART=RCEND D  Q
 . S RCJ=""
 . F  S RCJ=$O(^RCY(344.6,"B",RCSTART,RCJ)) Q:RCJ=""  D
 . . S ^TMP("RCDPEADP",$J,"INS",RCJ)=""
 ;
 ; For a range of payers, loop through the Payer name list until 
 ; you reach the last payer in the range (RCEND)
 ;
 S RCI=$O(^RCY(344.6,"B",RCSTART),-1)    ; Set the starting location for the loop
 F  S RCI=$O(^RCY(344.6,"B",RCI)) Q:RCI=""  Q:(RCI]RCEND)  D
 . S RCJ=""
 . F  S RCJ=$O(^RCY(344.6,"B",RCI,RCJ)) Q:RCJ=""  D
 . . S ^TMP("RCDPEADP",$J,"INS",RCJ)=""
 ;
 Q
 ;
 ; Check to see if the Payer is in the list of Payers to process
INSCHK(RCINSIEN) ;
 ;Return value 0 - No, not in list or 1 - Yes in list
 ;
 ; If all payers are supposed to be process, then send back a 1
 Q:$D(^TMP("RCDPEADP",$J,"INS","A")) 1
 ;
 ; If the payer is in the list of payers, send back yes
 Q:$D(^TMP("RCDPEADP",$J,"INS",RCINSIEN)) 1
 ;
 ;Payer not in list, quit with No
 Q 0
 ;
 ; Compile the list of payers from the Insurance File.  The Payer IENS are extracted
INSLKUP(RCSTART,RCEND) ;
 ;
 ;RCSTART - The text to start the search for insurance companies
 ;RCEND - The text to end the search for insurance companies,
 ;
 N RCI,RCJ
 ;
 S RCI=RCSTART
 ;
 ;Loop through the Payer name list until you reach the last payer in the range (RCEND)
INSLP ;
 S RCJ=""
 F  S RCJ=$O(^DIC(36,"B",RCI,RCJ)) Q:RCJ=""  D
 . S ^TMP("RCDPEADP",$J,"INS",RCJ)=""
 S RCI=$O(^DIC(36,"B",RCI))
 G:RCI]RCEND INSQT
 G INSLP
 ;
 ;Work is done, exit
INSQT ;
 Q
 ;
