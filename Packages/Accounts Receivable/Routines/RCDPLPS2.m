RCDPLPS2 ;ALB/SAB - link payment tracking report ;5 Feb 2015
 ;;4.5;Accounts Receivable;**304**;Feb 05, 2015;Build 104
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ;
 ;
 ;init variables
 N RCRANGE,RCBEGDT,RCENDDT,RCUSER,RCENDFLG,%
 ;
 ;Set user exit flag
 S RCENDFLG=0
 ;
 ;get date range, quit if timed out or user wished to exit.
 S RCRANGE=$$DTRNG()
 Q:+RCRANGE=0
 ;
 ;Extract begin and end date of report
 S RCBEGDT=$P(RCRANGE,U,2),RCENDDT=$P(RCRANGE,U,3)
 ;
 ;(Optional) get the AR Clerk to filter on.
 S RCUSER=$$USER()
 Q:RCUSER=""
 ;
 ; undeclared parameter RCENDFLG is set if 
 D REPORT(RCBEGDT,RCENDDT,RCUSER)
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
REPORT(RCBEGDT,RCENDDT,RCUSER) ;  report to show link payment audit log in FMS
 ;
 N POP,RCDISP
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
 N RCDATE,RCENTRY,RCDATA,RCLUSER,RCCT,RCRECTDA,RCTRANDA,RCAMT,RCEOB,RCSTATUS,RCREASON,RCDTDIS1,RCDTDIS2
 N SCREEN,Y,RCNOW,PAGE,RCRJLINE,RCRJFLAG,RCX1,RCX,RCY,RCFLG,%,RCX2
 ;
 K ^TMP("RCDPLPS2",$J)
 ;
 ;Gather the data using the Date cross-reference, starting with the Begin date
 ; Also make sure to gather all entries from the end date.
 ;
 S RCDATE=RCBEGDT,RCENDDT=RCENDDT+.999999,RCCT=0
 F  S RCDATE=$O(^RCY(344.71,"B",RCDATE)) Q:'RCDATE  Q:RCDATE>RCENDDT  D
 . S RCENTRY=0
 . F  S RCENTRY=$O(^RCY(344.71,"B",RCDATE,RCENTRY)) Q:'RCENTRY  D
 . . S RCEOB=""
 . . S RCDATA=$G(^RCY(344.71,RCENTRY,0))
 . . ;
 . . ;Quit if corrupt index entry
 . . Q:RCDATA=""
 . . ;
 . . ;Get the user.  If filtering on user, quit if the user is not the filter user.
 . . S RCLUSER=$P(RCDATA,U,2)
 . . I RCUSER["",RCUSER'="A",RCUSER'=RCLUSER Q
 . . ;
 . . ;Update the counter
 . . S RCCT=RCCT+1
 . . ;
 . . ;get the rest of the data
 . . S RCRECTDA=$P(RCDATA,U,3)    ;Receipt Number
 . . S RCTRANDA=$P(RCDATA,U,4)    ;Receipt Transaction Number
 . . S RCAMT=$P(RCDATA,U,5)       ;Amount originally placed in suspense
 . . S:$P(RCDATA,U,6)[";PRCA" RCEOB=$P($$GET1^DIQ(430,$P($P(RCDATA,U,6),";")_",",".01","E"),"-",2)       ;Claim #
 . . S:$P(RCDATA,U,6)[";DPT" RCEOB=$E($$GET1^DIQ(2,$P($P(RCDATA,U,6),";")_",",".01","E"),1,7)       ;Pat Name
 . . S RCSTATUS=$$GET1^DIQ(344.71,RCENTRY_",",".07","E")  ;Suspense Status
 . . S RCREASON=$P(RCDATA,U,8)    ;Reason for Suspense Status
 . . ;
 . . S RCFLG=$G(^TMP("RCDPLPS2",$J,"IDX",RCRECTDA,RCTRANDA))
 . . ;Store in the temporary array
 . . S:RCFLG="" ^TMP("RCDPLPS2",$J,"IDX",RCRECTDA,RCTRANDA)=RCCT_"~"_RCDATE
 . . I RCFLG'="" D
 . . . S RCX=$P(RCFLG,U),RCX2=$P(RCX,"~",2),RCX=$P(RCX,"~"),RCY=$P(RCFLG,U,2)
 . . . I (RCY=""),(RCREASON="Multi-Trans Split") D
 . . . . S $P(^TMP("RCDPLPS2",$J,"IDX",RCRECTDA,RCTRANDA),U,2)=1
 . . . . K ^TMP("RCDPLPS2",$J,RCX2,RCX)
 . . S ^TMP("RCDPLPS2",$J,RCDATE,RCCT)=$$FMTE^XLFDT(RCDATE,"2D")_U_$$USERINIT^RCDPLPS1(RCLUSER)_U_RCRECTDA_U_RCTRANDA_U_RCAMT_U_RCEOB_U_RCSTATUS_U_RCREASON
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
 . . W $P(RCDATA,U,3),?15,$P(RCDATA,U,4),?22,$P(RCDATA,U),?32,$J($P(RCDATA,"^",5),10,2)
 . . W ?43,$P(RCDATA,U,6),?51,$P(RCDATA,U,2),?56,$E($P(RCDATA,U,7),1,11),?68,$E($P(RCDATA,U,8),1,12),!
 . . I $Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 ;
 K ^TMP("RCDPLPS2",$J)
 D ^%ZISC
 S:$G(RCRJFLAG) RCENDFLG=1
 Q
 ;
H ;  header
 N %
 S %=RCNOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"LINK PAYMENT TRACKING REPORT",?50,%
 W !,"  FOR THE DATE RANGE: ",RCDTDIS1,"  TO  ",RCDTDIS2,?55,"FOR USER(S): ",$E($S(RCUSER="A":"ALL",1:$$GET1^DIQ(200,RCUSER_",",.01,"E")),1,10)
 W !!,"RECEIPT#",?15,"TRANS#",?22,"DATE",?36,"AMOUNT",?43,"CLAIM",?51,"USER",?56,"DISPOSITION",?68,"REASON"
 W !,RCRJLINE,!
 Q
 ;
