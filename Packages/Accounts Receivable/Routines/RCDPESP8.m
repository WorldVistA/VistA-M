RCDPESP8 ;AITC/CJE - ePayment Lockbox Site Parameters History
 ;;4.5;Accounts Receivable;**332**;Mar 20, 1995;Build 40
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; entry point for EDI Lockbox Parameters History Report [RCDPE PARAMETER HISTORY REPORT]
 N BDATE,EDATE,RCHDR,IEN2,POP,RCDATE,RCDISPTY,RCEND,RCLN,RCNEW,RCOLD,RCPGNUM,RCSTOP,RCTMPND,RCUSRVALMHDR
 K ^TMP($J,"RCDPESP8")
 Q:$$PROMPTS(.BDATE,.EDATE,.RCLM)=-1  ; Prompt for report parameters
 ;
 S RCPGNUM=0,RCSTOP=0
 I RCLM D  G EXIT
 . S RCTMPND="RCDPESP8"  K ^TMP($J,RCTMPND)  ; clean any residue
 . D COMPILE
 . D LMRPT^RCDPEARL(.VALMHDR,$NA(^TMP($J,RCTMPND))) ; generate ListMan display
 . I $D(RCTMPND) K ^TMP($J,RCTMPND)
 ;
 W !
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="COMPILE^RCDPESP8",ZTDESC="EDI LOCKBOX AUTO PARAMETER HISTORY REPORT"
 .S ZTSAVE("*")=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 .K IO("Q") D HOME^%ZIS
 ;
 U IO
 D COMPILE
 I 'RCSTOP D ASK^RCDPEARL(.RCSTOP)
 ;
 Q
COMPILE ; Get data for user selected date range
 N IEN2,LINE,LMHDR,RCDET,RCPARAM,RCSEQ,RCUSR,SPACE,SPLIT
 S SPACE=$J("",40)
 S RCSEQ=0
 S RCDATE=BDATE,RCEND=EDATE_"."_24
 F  S RCDATE=$O(^RCY(344.61,1,2,"ADU",RCDATE)) Q:(RCDATE>RCEND)!(RCDATE="")  D  ;
 . S RCUSR=""
 . F  S RCUSR=$O(^RCY(344.61,1,2,"ADU",RCDATE,RCUSR)) Q:RCUSR=""  D  ;
 . . S RCSEQ=RCSEQ+1
 . . S ^TMP($J,"RCDPESP8",RCSEQ)=$E($$FMTE^XLFDT(RCDATE,"2Z")_SPACE,1,19)_RCUSR
 . . S IEN2=""
 . . F  S IEN2=$O(^RCY(344.61,1,2,"ADU",RCDATE,RCUSR,IEN2)) Q:IEN2=""  D  ;
 . . . S RCPARAM=$$GET1^DIQ(344.611,IEN2_",1,",1,"E")
 . . . S RCDET=$$GET1^DIQ(344.611,IEN2_",1,",2,"E")
 . . . S RCOLD=$$GET1^DIQ(344.611,IEN2_",1,",3,"E")
 . . . S RCNEW=$$GET1^DIQ(344.611,IEN2_",1,",4,"E")
 . . . S SPLIT=0
 . . . S RCSEQ=RCSEQ+1
 . . . S LINE="  "_RCPARAM
 . . . I $L(LINE_" ("_RCDET_")")>62 S SPLIT=1
 . . . I 'SPLIT D  ;
 . . . . I RCDET'="" S LINE=LINE_" ("_RCDET_")"
 . . . . S LINE=LINE_$J("",62-$L(LINE))_" "_$J(RCOLD,8)_" "_$J(RCNEW,8)
 . . . S ^TMP($J,"RCDPESP8",RCSEQ)=LINE
 . . . I SPLIT D  ;
 . . . . S RCSEQ=RCSEQ+1
 . . . . S LINE="    "_$E(RCDET,1,58)
 . . . . S LINE=LINE_$J("",62-$L(LINE))_" "_$J(RCOLD,8)_" "_$J(RCNEW,8)
 . . . . S ^TMP($J,"RCDPESP8",RCSEQ)=LINE
 I 'RCLM D  ;
 . D OUTPUT
 E  D  ;
 . D HEAD
 . S LMHDR("TITLE")="Auto Parameter History Report"
 . S LMHDR(1)=RCHDR(2)
 . S LMHDR(2)=RCHDR(3)
 . S LMHDR(3)=""
 . S LMHDR(4)=""
 . S LMHDR(5)=""
 . S LMHDR(6)=RCHDR(5)
 . S LMHDR(7)=RCHDR(6)
 . D LMRPT^RCDPEARL(.LMHDR,$NA(^TMP($J,"RCDPESP8"))) ; Generate ListMan display
 ;
EXIT ; Exit point to clean up ^TMP
 K ^TMP($J,"RCDPESP8")
 Q
 ;
OUTPUT ; Output printed report to screen or printer
 S RCPGNUM=0
 D HEAD
 S RCSEQ=0
 F  S RCSEQ=$O(^TMP($J,"RCDPESP8",RCSEQ)) Q:'RCSEQ  D  I RCSTOP Q
 . I $Y>(IOSL-3)!(RCPGNUM=0) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) I RCSTOP Q
 . W !,^TMP($J,"RCDPESP8",RCSEQ)
 Q
HEAD ; Print header
 N LINE
 S LINE="Auto Parameter History Report"
 S LINE=$J("",(80-$L(LINE)\2))_LINE
 S RCHDR("H")=LINE_$J("",71-$L(LINE))
 S LINE="RUN DATE: "_$$FMTE^XLFDT($$NOW^XLFDT,"2Z")
 S RCHDR(2)=$J("",(80-$L(LINE)\2))_LINE
 S LINE="DATE RANGE: "_$$FMTE^XLFDT(BDATE,"2DZ")_" - "_$$FMTE^XLFDT(EDATE,"2DZ")
 S RCHDR(3)=$J("",(80-$L(LINE)\2))_LINE
 S RCHDR(4)=""
 S LINE="Date/Time Edited   User"_$J("",48)_"Values"
 S RCHDR(5)=LINE
 S LINE="  Parameter"_$J("",57)_"Old      New"
 S RCHDR(6)=LINE
 S RCHDR(7)=$TR($J("",80)," ","=")
 S RCHDR("XECUTE")="S RCPGNUM=RCPGNUM+1,RCHDR(1)=RCHDR(""H"")_""Page: ""_RCPGNUM"
 S RCDISPTY=$S(RCLM:1,1:0)
 S RCHDR(0)=7
 ;
 S VALMHDR(1)=RCHDR("H")
 S VALMHDR(2)=RCHDR(3)
 S VALMHDR(3)=""
 S VALMHDR(4)=RCHDR(5)
 S VALMHDR(5)=RCHDR(6)
 Q
 ;
PROMPTS(BDATE,EDATE,RCLM,RCXL) ; Propmt for report Parameters
 ; Input: None
 ; Output:  BDATE - Start date for report in FileMan internal format
 ;          EDATE - End date for report in Fileman internal format
 ;          RCLM - Boolean flag - display in ListMan
 ; Returns: -1 Quit without running report
 ;           1 Continue
 ;
 N DIR,RETURN,Y
 S RETURN=1
 S DIR("?")="ENTER THE DATE OF THE EARIEST PARAMETER CHANGE TO INCLUDE"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start Date: ",DIR("B")="T" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RETURN=-1 G PQ
 S BDATE=Y
 ;
 K DIR
 S DIR("?")="ENTER THE DATE OF THE LATEST PARAMETER CHANGE TO INCLUDE"
 S DIR("B")="T"
 S DIR(0)="DAO^"_BDATE_":"_DT_":APE",DIR("A")="End Date: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RETURN=-1 G PQ
 S EDATE=Y
 ;
 S RCLM=$$ASKLM^RCDPEARL() I RCLM=-1 S RETURN=-1
PQ ; Common exit point for PROMPTS 
 Q RETURN
