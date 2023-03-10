IBCERPN ;ALB/VD - RPN Resubmission/Printing Claims No Changes CSA Report ;1/16/2019
 ;;2.0;INTEGRATED BILLING;**641**;21-MAR-94;Build 61
 ;;Per VA Directive 6402, this routine should not be modified.
 ; This report is generated to provide a list of claims that have errors that
 ; prevent a claim from being RESUBMITTED BY PRINT, or RETRANSMITTED, or PRINTED.
 ; The user can use this report in tandem with the CLAIMS STATUS AWAITING RESOLUTION
 ; worklist.
 ; The user is prompted for the following dates:
 ;   -  Earliest Retransmitted/Printed Date
 ;   -  Latest Retransmitted/Printed Date
 ; This report has a format of 132 columns.
 ; This report will display the following data elements:
 ;   -  Bill #
 ;   -  Payer Name (Secondary sort)
 ;   -  Error Message (Tertiary sort based on the Error Code). If there is no Error
 ;       message then Narrative, and if no Narrative then Category message.
 ;   -  Current Balance
 ;   -  User Name (Primary sort)
 ;   -  Date (Retransmitted/Resubmitted/Printed)
 ;
 ; Refer to US3380
 ; Called by EDI Return Message Management Menu (Path: Billing Clerk Menu>EDI>MM)
 ; Option: RPN
 ;
ENT ; Menu Option Entry Point
 N BILLDT,BEGDT,BEGIN,BILLNO,CNT,CURBAL,DASH,DT,END,ENDDT,EORMSG,HDR1,HDR2,IBABEG
 N IBAEND,IBQUIT,LEGEND,LNCNT,MAX,NARATV,PAGES,PAYNAM,PGC,RNAME,USERNM,Y,LNTOT,POP
 S IBQUIT=0,RNAME="IBCERPN"
 D DATES Q:IBQUIT  Q:'Y
 S LEGEND="Retransmitted/Printed Timeframe: "_BEGIN_" thru "_END
 D DEVICE Q:POP  Q:IBQUIT
QUE ; Queued Entry Point
 K ^TMP(RNAME,$J)
 D GATHER
 S BEGDT=$$FMTE^XLFDT(IBABEG,2),ENDDT=$$FMTE^XLFDT(IBAEND,2)
 S LEGEND="Retransmitted/Printed Timeframe: "_BEGDT_" thru "_ENDDT
 D HDRINIT
 D HEADER Q:IBQUIT
 D PRINT
 D EXIT
 Q
 ;
DATES ; Enter the date range for this report
 N DIR
 W !
 S DIR(0)="DA^:DT:EX",DIR("A")="Enter Earliest Retransmitted/Printed Date: "
 S DIR("B")=$$HTE^XLFDT($H-30),DIR("?")="Enter the earliest retransmitted or printed date for this report."
 D ^DIR K DIR Q:'Y  S IBABEG=+Y,BEGIN=Y(0)
 ;
 W !
 S DIR(0)="DA^"_+Y_":DT:EX",DIR("A")="Enter Latest Retransmitted/Printed Date: "
 S DIR("B")=$$FMTE^XLFDT(DT,1),DIR("?")="Enter the latest retransmitted or printed date for this report."
 D ^DIR K DIR Q:'Y  S IBAEND=+Y,END=Y(0)
 Q
 ;
DEVICE ; - Ask device
 N %ZIS,ZTDESC,ZTIO,ZTQUEUED,ZTRTN,ZTSAVE
 W !!!,"You will need a 132 column printer for this report",!
 S %ZIS="QM" D ^%ZIS S:POP IBQUIT=1 Q:POP
 I $D(IO("Q")) D  S IBQUIT=1 Q
 . S ZTRTN="QUE^IBCERPN",ZTDESC="Resubmission/Printing claims No Changes CSA Report"
 . S (ZTSAVE("BEGIN"),ZTSAVE("END"),ZTSAVE("IBABEG"),ZTSAVE("IBAEND"))=""
 . S (ZTSAVE("BEGDT"),ZTSAVE("ENDDT"),ZTSAVE("RNAME"),ZTSAVE("IBQUIT"))=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK D HOME^%ZIS
 . W !!! I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR    ;pause to see task no.
 U IO
 Q
 ;
GATHER ;GATHER THE INFO BASED ON THE DATE RANGE ENTERED
 ; Uses the ^IBM(361,"ARPN",CURDAT,IBNO,USER,ACTION) cross-reference file to get
 ; data within date range.  If data is within date range this sets up the ^TMP($J
 ; file with all data needed for the report.
 ;
 N ACTION,ARPNRC,CURDAT,IBCBAL,IBCLMNO,IBIFN,IBNO,IBOAM,IBPAY
 N LNCNT,SEQ,USER,USRNAM
 S $P(DASH,"_",132)=""
 S LNTOT=0,PGC=1,MAX=IOSL
 S CURDAT=IBABEG
 F  S CURDAT=$O(^IBM(361,"ARPN",CURDAT)) Q:CURDAT=""  Q:CURDAT>(IBAEND+1)  D
 . S IBNO="" F  S IBNO=$O(^IBM(361,"ARPN",CURDAT,IBNO)) Q:IBNO=""  D
 .. S IBIFN=+$G(^IBM(361,IBNO,0))
 .. S IBCLMNO=$P($G(^DGCR(399,IBIFN,0)),U)   ; External Claim No.
 .. S IBPAY=$P($G(^DIC(36,+$P($G(^DGCR(399,IBIFN,"MP")),U),0)),U)
 .. I IBPAY="" S IBPAY=$P($G(^DIC(36,+$$CURR^IBCEF2(IBIFN),0)),U)
 .. I IBPAY="" S IBPAY="UNKNOWN PAYER"
 .. S IBOAM=$G(^DGCR(399,IBIFN,"U1"))
 .. S IBCBAL=$P(IBOAM,U,1)-$P(IBOAM,U,2) ; current balance (total charges - offset)
 .. S IBEMSG=$$TXT^IBCECSA1(IBNO,60)     ; error message (60 chars max).
 .. S:IBEMSG="" IBEMSG=" "
 .. S SEQ="" F  S SEQ=$O(^IBM(361,"ARPN",CURDAT,IBNO,SEQ)) Q:SEQ=""  D
 ... ;S ARPNRC=$G(^IBM(361,"ARPN",CURDAT,IBNO,SEQ))
 ... S ARPNRC=$G(^IBM(361,IBNO,3,SEQ,0))
 ... S USER=$P(ARPNRC,U,2),ACTION=$P(ARPNRC,U,3)
 ... S USRNAM=$P(^VA(200,USER,0),U)      ; External User Name
 ... S ^TMP(RNAME,$J,USRNAM,IBPAY,$E(IBEMSG,1,50),CURDAT,IBCLMNO)=IBCBAL_U_ACTION_U_USER_U_IBIFN
 ... S LNTOT=LNTOT+1
 Q
 ;
PRINT ; Print data
 ;
 ; PGC=page ct,LNTOT=no of lines to be printed,LNCNT=when to page break
 ; MAX=IOSL (device length)
 ;
 N CURDAT,EORMSG,IBCBAL,IBCLMNO,IBEMSG,IBPAY,LCTR,NONEMSG,USRNAM
 S EORMSG="*** END OF REPORT ***"
 S NONEMSG="* * * N O D A T A T O P R I N T * * *"
 S LCTR=0
 ;
 I '$D(^TMP(RNAME,$J)) W !!!,NONEMSG D END Q
 S USRNAM="" F  S USRNAM=$O(^TMP(RNAME,$J,USRNAM)) Q:USRNAM=""  D
 . S IBPAY="" F  S IBPAY=$O(^TMP(RNAME,$J,USRNAM,IBPAY)) Q:IBPAY=""  D
 .. S IBEMSG="" F  S IBEMSG=$O(^TMP(RNAME,$J,USRNAM,IBPAY,IBEMSG)) Q:IBEMSG=""  D
 ... S CURDAT="" F  S CURDAT=$O(^TMP(RNAME,$J,USRNAM,IBPAY,IBEMSG,CURDAT)) Q:CURDAT=""  Q:IBQUIT  D
 .... S IBCLMNO="" F  S IBCLMNO=$O(^TMP(RNAME,$J,USRNAM,IBPAY,IBEMSG,CURDAT,IBCLMNO)) Q:IBCLMNO=""  Q:IBQUIT  D
 ..... S IBCBAL=+$G(^TMP(RNAME,$J,USRNAM,IBPAY,IBEMSG,CURDAT,IBCLMNO))
 ..... I LNCNT>MAX D HEADER Q:IBQUIT
 ..... S LCTR=LCTR+1
 ..... ;W !,$J(LCTR,4),?10,$E(IBPAY,1,20),?38,$E(USRNAM,1,15),?55,$E(IBEMSG,1,50),?111,$P($$FMTE^XLFDT(CURDAT,2),"@"),?120, $J("$"_$FN(IBCBAL,"",2),12)
 ..... W !,$J(LCTR,3),?7,IBCLMNO,?16,$E(IBPAY,1,20),?38,$E(USRNAM,1,15),?59
 ..... W $E(IBEMSG,1,50),?111,$P($$FMTE^XLFDT(CURDAT,2),"@"),?120,$J("$"_$FN(IBCBAL,"",2),12)
 ..... S LNCNT=LNCNT+1
 I LNCNT>MAX D HEADER
 Q:IBQUIT
 ;
END W !!!,?49,EORMSG,!!!
 I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR    ;pause at end of report
 Q
 ;
HDRINIT ; Initial setting
 S LNCNT=0
 I PGC=1,$E(IOST,1,2)["C-" W @IOF  ; refresh terminal screen on 1st hdr
 I 'LNTOT S PAGES=1
 I LNTOT,PGC=1 D
 . S LNCNT=0
 . S PAGES=LNTOT/(MAX-10)
 . I PAGES<1 S PAGES=1
 . I PAGES["." S PAGES=$P(PAGES+1,".") ; if more than one page set whole number
 S HDR1="Resubmission/Printing claims No Changes CSA Report"
 S HDR2=$$FMTE^XLFDT($$NOW^XLFDT,1)
 Q
 ;
HEADER ; Print Header info
 N DIR,DUOUT
 S LNCNT=0
 I PGC'=1 D  Q:IBQUIT
 . W !
 . I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR I $D(DUOUT) S IBQUIT=1 Q:IBQUIT
 . W @IOF   ; refresh terminal screen on hdr
 W !,HDR1,?59,HDR2,?114," Page: "_PGC_" of "_PAGES
 W !,LEGEND
 W !!,?7,"Bill #",?17,"Payer Name",?38,"User Name",?59,"Error Message/Narrative/Category",?111,"Date",?124,"Curr Bal"
 W !,DASH
 S LNCNT=LNCNT+10,PGC=PGC+1
 Q
EXIT() ;clean up and quit
 N ZTREQ
 ; Force a form feed at end of a printer report
 I $E(IOST,1,2)'["C-" W @IOF
 ; handle device closing before exiting
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP(RNAME,$J)
 K BEGIN,BEGDT,ENDDT,IBABEG,IBAEND,IBQUIT,IEN,LNCNT,Y
 Q
