RCDPLPS2 ;ALB/SAB - link payment tracking report ;5 Feb 2015
 ;;4.5;Accounts Receivable;**304,326**;Feb 05, 2015;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ;
 ;
 ;init variables
 N %,RCBEGDT,RCENDFLG,RCENDDT,RCEXCEL,RCPT,RCRANGE,RCUSER
 ;
 ;Set initial values of report parameters
 S RCBEGDT="",RCENDDT="",RCUSER="A",RCPT="",RCENDFLG=0
 ;
 ; PRCA*4.5*326 - Prompt for receipt number. Not required, so continue if not entered
 S RCPT=$$RCPT()
 I RCPT=-1 Q  ; Timed out or '^'
 ;
 I RCPT="" D  I RCENDFLG Q  ; PRCA*4.5*326 - Other prompts only needed if receipt was not selected
 . ;get date range, quit if timed out or user wished to exit.
 . S RCRANGE=$$DTRNG()
 . I RCRANGE=0 S RCENDFLG=1 Q
 . ;
 . ;Extract begin and end date of report
 . S RCBEGDT=$P(RCRANGE,U,2),RCENDDT=$P(RCRANGE,U,3)
 . ;
 . ;(Optional) get the AR Clerk to filter on.
 . S RCUSER=$$USER()
 . I RCUSER="" S RCENDFLG=1 Q
 ;
 ; PRCA*4.5*326 - Produce report for export to Microsoft Excel?
 S RCEXCEL=$$DISPTY^RCDPRU() Q:+RCEXCEL=-1
 I RCEXCEL D INFO^RCDPRU
 ;
 ; Parameter RCENDFLG is set if user exits
 D REPORT(RCBEGDT,RCENDDT,RCUSER,RCPT,RCEXCEL,.RCENDFLG) ; PRCA*4.5*236 params RCPT, RCEXCEL and RCENDFLG
 ;
 I 'RCENDFLG R !,"Press RETURN to continue:",%:DTIME
 Q
 ;
 ; Get the date range for the report
DTRNG() ;
 ;
 ;Retrieve the date range 
 D DATES(.RCSTART,.RCEND)
 ;
 ;format it for use in the report
 Q:RCSTART=-1 0
 Q:RCSTART "1^"_RCSTART_"^"_RCEND
 Q:'RCSTART "0^^"
 Q 0
 ;
 ;Get start and end dates.  Default is Today for the End date and 45 days from end date for the beginning date
DATES(RCBDATE,RCEDATE) ;
 ;
 N DIR,DUOUT,RNGFLG,X,Y,DTOUT,DIROUT,DIRUT,RCTODAY
 ;
 S RCTODAY=$$DT^XLFDT()
 ; Get the End date first.  Assume the end date is today.
 S RCBDATE=$$HTFM^XLFDT($$FMTH^XLFDT(RCTODAY)-45),RCEDATE=RCTODAY
 ;
 ;Get the start date.  
 S DIR("?")="ENTER THE EARLIEST AUTO POSTING DATE TO INCLUDE ON THE REPORT"
 S DIR(0)="DAO^::APE",DIR("A")="START DATE: "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RCBDATE=-1 Q
 S RCBDATE=Y
 ;
 ;Get the end date
 S DIR("?")="ENTER THE LATEST AUTO POSTING DATE TO INCLUDE ON THE REPORT"
 S DIR("B")=$$FMTE^XLFDT(RCTODAY,2)
 S DIR(0)="DAO^"_RCBDATE_":"_RCTODAY_":APE",DIR("A")="END DATE: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RCEDATE=-1 Q
 S RCEDATE=Y
 ;
 Q
 ;
 ; Ask to see if the report needs to be by a specific user. Return the IEN if 
USER() ;
 ;
 N DIR,DUOUT,RNGFLG,X,Y,RCSTART,RCEND,DTOUT,DIRUT,DIROUT
 ; All clerks or 1 clerk
 S DIR("?")="Search on All AR Users (A), or a Single User (S)"
 S DIR("B")="ALL"
 S DIR(0)="SOA^S:Single User;A:All AR Users"
 S DIR("A")="(S)ingle User or (A)ll Users? "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="")  Q ""
 Q:Y="A" Y
 ;
 ;If a single clerk is needed, retrieve and return. 
 Q $$ARCLERK
 ;
 ; Get the AR Clerk
ARCLERK() ;
 ;
 N DIR,DUOUT,RNGFLG,X,Y,RCSTART,RCEND,DTOUT,DIRUT,DIROUT
 ;
 S DIR("?")="ENTER AN AR USER TO SEARCH TRANSACTIONS FOR"
 S DIR(0)="PA^VA(200,:AEMQ",DIR("A")="AR USER? " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="")  Q ""
 Q +Y
 ;
 ; PRCA*4.5*326 - added subroutine RCPT
RCPT() ; Prompt user for single receipt number for which to display entries
 N D,DIC,DTOUT,DUOUT,RETURN,X,Y
 S RETURN=""
 S DIC="^RCY(344,"
 S DIC(0)="AEQ"
 S DIC("A")="RECEIPT NUMBER: "
 S DIC("S")="I $D(^RCY(344.71,""D"",$P(^(0),U,1)))"
 D ^DIC
 I $D(DTOUT)!$D(DUOUT) Q -1
 I Y'=-1 S RETURN=$P(Y,U,2)
 Q RETURN
 ;
REPORT(RCBEGDT,RCENDDT,RCUSER,RCPT,RCEXCEL,RCENDFLG) ;  report to show link payment audit log in FMS
 N %ZIS,POP,RCDISP
 ;
 ;Select output device
 S %ZIS="QM" D ^%ZIS Q:POP
 ;
 ;Option to queue
 I $D(IO("Q")) D  Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="DQ^RCDPLPS2"
 .S ZTDESC="EDI LOCKBOX LINK PAYMENT AUDIT LOG REPORT"
 .S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 .D ^%ZTLOAD
 .I $D(ZTSK) W !!,"Task number "_ZTSK_" has been queued."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 D DQ
 ;
 Q
 ;
 ;  report (queue) starts here
DQ ;
 N %,PAGE,RCDATE,RCDTDIS1,RCDTDIS2,RCENTRY,RCMFST,RCMULT,RCRJFLAG,RCRJLINE,RCNOW,SCREEN,Y ; PRCA*4.5*326
 ;
 K ^TMP("RCDPLPS2",$J)
 S RCCT=0
 ; PRCA*4.5*326 - Begin changes
 ; If report is for a single receipt use the "D" cross reference
 I RCPT'="" D  ;
 . S RCENTRY=0
 . F  S RCENTRY=$O(^RCY(344.71,"D",RCPT,RCENTRY)) Q:'RCENTRY  D  ;
 . . D EXTRACT(RCENTRY,.RCCT)
 ;
 E  D  ;
 . ; Gather the data using the Date cross-reference, starting with the Begin date
 . ; Also make sure to gather all entries from the end date.
 . ;
 . S RCDATE=RCBEGDT,RCENDDT=RCENDDT+.999999
 . F  S RCDATE=$O(^RCY(344.71,"B",RCDATE)) Q:'RCDATE  Q:RCDATE>RCENDDT  D
 . . S RCENTRY=0
 . . F  S RCENTRY=$O(^RCY(344.71,"B",RCDATE,RCENTRY)) Q:'RCENTRY  D
 . . . D EXTRACT(RCENTRY,.RCCT)
 ; PRCA*4.5*326 - End changes
 ;
 ;  print report
 S Y=$P(RCBEGDT,".") D DD^%DT S RCDTDIS1=Y
 S Y=$P(RCENDDT,".") D DD^%DT S RCDTDIS2=Y
 D NOW^%DTC S Y=% D DD^%DT S RCNOW=Y
 S PAGE=1,RCRJLINE="",$P(RCRJLINE,"-",81)=""
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO D H
 S RCDATE=0
 F  S RCDATE=$O(^TMP("RCDPLPS2",$J,RCDATE)) Q:'RCDATE!($G(RCRJFLAG))  D
 . S RCCT=0
 . F  S RCCT=$O(^TMP("RCDPLPS2",$J,RCDATE,RCCT)) Q:'RCCT!($G(RCRJFLAG))  D
 . . S RCDATA=$G(^TMP("RCDPLPS2",$J,RCDATE,RCCT))
 . . ; PRCA*4.5*326 - Export in Excel format if requested
 . . S RCMULT=$S($P(RCDATA,U,8)="Multi-Trans Split":1,1:0) ; #344.711 change - PRCA*4.5*326
 . . S RCMFST=+$G(^TMP("RCDPLPS2",$J,RCDATE,RCCT,"S")) ; #344.711 change - PRCA*4.5*326
 . . I RCMULT,'RCMFST Q  ; #344.711 change - PRCA*4.5*326
 . . I RCEXCEL D  ;
 . . . W $P(RCDATA,U,3)_U_$P(RCDATA,U,4)_U_$P(RCDATA,U)_U_$P(RCDATA,"^",5)_U_$P(RCDATA,U,6)_U
 . . . W $P(RCDATA,U,2)_U_$P(RCDATA,U,7)_U_$P(RCDATA,U,8),!
 . . . ; BEGIN #344.711 - PRCA*4.5*326
 . . . Q:'RCMULT
 . . . S RCSPL=0
 . . . F  S RCSPL=$O(^TMP("RCDPLPS2",$J,RCDATE,RCCT,"S",RCSPL)) Q:'RCSPL  D  Q:$G(RCRJFLAG)
 . . . . S RCDATA=$G(^TMP("RCDPLPS2",$J,RCDATE,RCCT,"S",RCSPL)) Q:RCDATA=""
 . . . . W "^^^^^^^^"_$P(RCDATA,U)_U_$P(RCDATA,U,2)_U_$P(RCDATA,U,3),!
 . . . ; END #344.711 - PRCA*4.5*326
 . . ; Print in report format if Excel not requested
 . . E  D  ;
 . . . I 'RCMULT W $P(RCDATA,U,3),?15,$P(RCDATA,U,4),?22,$P(RCDATA,U),?32,$J($P(RCDATA,"^",5),10,2)
 . . . E  W $P(RCDATA,U,3),?22,$P(RCDATA,U),?32,$J(RCMFST,10,2)
 . . . ; BEGIN #344.711 - PRCA*4.5*326
 . . . W ?43,$P(RCDATA,U,6),?51,$P(RCDATA,U,2),?56,$E($P(RCDATA,U,7),1,11)
 . . . I $Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 . . . W:$P(RCDATA,U,8)]"" !,?5,$P(RCDATA,U,8)
 . . . W !
 . . . I $Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 . . . Q:'RCMULT
 . . . S RCSPL=0
 . . . F  S RCSPL=$O(^TMP("RCDPLPS2",$J,RCDATE,RCCT,"S",RCSPL)) Q:'RCSPL  D  Q:$G(RCRJFLAG)
 . . . . S RCDATA=$G(^TMP("RCDPLPS2",$J,RCDATE,RCCT,"S",RCSPL)) Q:RCDATA=""
 . . . . W ?18,$P(RCDATA,U),?26,$J("$"_$J($P(RCDATA,U,2),0,2),10),?38,$E($P(RCDATA,U,3),1,40),!
 . . . . I $Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 . . . ; END #344.711 - PRCA*4.5*326
 ; PRCA*4.5*326 - End changes
 ;
 K ^TMP("RCDPLPS2",$J)
 D ^%ZISC
 S:$G(RCRJFLAG) RCENDFLG=1
 I 'RCENDFLG,'RCEXCEL W !!,$$ENDORPRT^RCDPEARL
 Q
 ;
 ; PRCA*4.5*326 - Add subroutine EXTRACT
EXTRACT(RCENTRY,RCCT) ; Extract and store data for a single suspense audit file entry
 ; Input: RCENTRY = IEN of SUSPENSE AUDIT FILE entry (#344.71)
 ; Output: ^TMP("RCDPLPS2",$J) containing report data
 ;
 N RCAMT,RCDATE,RCDATA,RCEOB,RCFLG,RCLUSER,RCRECTDA,RCREASON,RCSTATUS,RCTRANDA,RCX,RCX,RCX2,RCY,Y
 ;
 S RCDATA=$G(^RCY(344.71,RCENTRY,0))
 ;
 ;Quit if corrupt index entry
 Q:RCDATA=""
 ;
 ;Get the user.  If filtering on user, quit if the user is not the filter user.
 S RCLUSER=$P(RCDATA,U,2)
 I RCUSER["",RCUSER'="A",RCUSER'=RCLUSER Q
 ;
 ;Update the counter
 S RCCT=RCCT+1
 ;
 ;get the rest of the data
 S RCDATE=$P(RCDATA,U,1)   ;Date/Time of suspese entry
 S RCRECTDA=$P(RCDATA,U,3)    ;Receipt Number
 S RCTRANDA=$P(RCDATA,U,4)    ;Receipt Transaction Number
 S RCAMT=$P(RCDATA,U,5)       ;Amount originally placed in suspense
 S RCEOB=""
 S:$P(RCDATA,U,6)[";PRCA" RCEOB=$P($$GET1^DIQ(430,$P($P(RCDATA,U,6),";")_",",".01","E"),"-",2)  ;Claim #
 S:$P(RCDATA,U,6)[";DPT" RCEOB=$E($$GET1^DIQ(2,$P($P(RCDATA,U,6),";")_",",".01","E"),1,7)       ;Pat Name
 S RCSTATUS=$$GET1^DIQ(344.71,RCENTRY_",",".07","E")  ;Suspense Status
 S RCREASON=$P(RCDATA,U,8)    ;Reason for Suspense Status
 ;
 S RCFLG=$G(^TMP("RCDPLPS2",$J,"IDX",RCRECTDA,RCTRANDA))
 ;Store in the temporary array
 S:RCFLG="" ^TMP("RCDPLPS2",$J,"IDX",RCRECTDA,RCTRANDA)=RCCT_"~"_RCDATE
 I RCFLG'="" D
 . S RCX=$P(RCFLG,U),RCX2=$P(RCX,"~",2),RCX=$P(RCX,"~"),RCY=$P(RCFLG,U,2)
 . I (RCY=""),(RCREASON="Multi-Trans Split") D
 . . S $P(^TMP("RCDPLPS2",$J,"IDX",RCRECTDA,RCTRANDA),U,2)=1
 . . K ^TMP("RCDPLPS2",$J,RCX2,RCX)
 S ^TMP("RCDPLPS2",$J,RCDATE,RCCT)=$$FMTE^XLFDT(RCDATE,"2D")_U_$$USERINIT^RCDPLPS1(RCLUSER)_U_RCRECTDA_U_RCTRANDA_U_RCAMT_U_RCEOB_U_RCSTATUS_U_RCREASON
 ; BEGIN #344.711 change - PRCA*4.5*326
 N IENS,RCCAMT,RCCLAIM,RCCOM,RCSPL
 S RCSPL=0,^TMP("RCDPLPS2",$J,RCDATE,RCCT,"S")=0
 F  S RCSPL=$O(^RCY(344.71,RCENTRY,1,RCSPL)) Q:'RCSPL  D
 . S IENS=RCSPL_","_RCENTRY_","
 . S RCCLAIM=$$GET1^DIQ(344.711,IENS,.02)
 . S RCCAMT=$$GET1^DIQ(344.711,IENS,.03)
 . S RCCOM=$$GET1^DIQ(344.711,IENS,.04)
 . S ^TMP("RCDPLPS2",$J,RCDATE,RCCT,"S",RCSPL)=RCCLAIM_U_RCCAMT_U_RCCOM
 . S ^TMP("RCDPLPS2",$J,RCDATE,RCCT,"S")=^TMP("RCDPLPS2",$J,RCDATE,RCCT,"S")+RCCAMT
 ; END #344.711 - PRCA*4.5*326
 Q
H ;  header
 N %
 I RCEXCEL D  Q  ; PRCA*4.5*321 - Header for EXCEL format
 . W !,"RECEIPT#^TRANSACTION^DATE^AMOUNT^CLAIM^USER^DISPOSITION^REASON^CLAIMS^AMOUNT^COMMENT",! ; #344.711 - PRCA*4.5*326
 ;
 S %=RCNOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"LINK PAYMENT TRACKING REPORT",?50,%
 W !,"  FOR THE DATE RANGE: ",$S(RCPT="":RCDTDIS1_"  TO  "_RCDTDIS2,1:"")
 I RCPT="" D  ;
 . W ?55,"FOR USER(S): ",$E($S(RCUSER="A":"ALL",1:$$GET1^DIQ(200,RCUSER_",",.01,"E")),1,10)
 E  D  ; PRCA*4.5*321 - display receipt number in header if selected
 . W ?55,"RECEIPT#: "_RCPT
 W !,"RECEIPT#",?15,"TRANS#",?22,"DATE",?36,"AMOUNT",?43,"CLAIM",?51,"USER",?56,"DISPOSITION" ; #344.71 - PRCA*4.5*326
 W !,?5,"REASON",?18,"CLAIMS" ; #344.71 - PRCA*4.5*326
 W !,RCRJLINE,!
 Q
 ;
