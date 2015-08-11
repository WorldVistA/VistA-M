RCDPEM3 ;OIFO-BAYPINES/RBN - ERA AUDIT REPORT and return EFT function ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**276,284,298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; General read access of IB EOB file #361.1 is allowed from AR (IA 4051)
 ; completely refactored for PRCA*4.5*298
 Q
 ;
 ; PRCA*4.5*284 - Changed report name from 'Mark ERA returned to Payer' to 'Remove ERA from active worklist'
 ;
 ; generates an audit report that displays all ERAs that have been removed from the worklist.  
 ; The user can select filters with which to limit the number of ERAs displayed:
 ;   Station/Division - default is all
 ;   Date Range - default is all
 ;   Start Date type - no default, P:Date removed from worklist, R:Date ERA Received, B:Both Dates
 ;                 
 ; INPUT:
 ;    user is prompted for the Station/Division, Date/Time range, and start/end dates
 ;
 ; OUTPUT:
 ;  report which displays returned ERAs, it contains:
 ;    User's name -  who performed the transaction
 ;    Date/Time ERA received from the payer
 ;    Date/Time ERA removed from worklist
 ;    Free text reasons for returning the ERA to the payer
 ;    ERA number
 ;    Trace number
 ;    Dollar amount of ERA
 ;    Payer name
 ;
 ; data taken from ELECTRONIC REMITTANCE ADVICE file (#344.4)
 ;                
 ; ^TMP($J,"RC REMV ERA", line #) structure:
 ;    STATION NAME^PAYER^ERA #^DEPOSIT #^DATE REMOVED^USER^REMOVE REASON^ERA #^ERA DATE^T0TAL AMOUNT
 ;
EN ; entry point for Remove ERA from Active Worklist Audit Report [RCDPE REMOVED ERA AUDIT]
 N %ZIS,I,RCDISPTY,RCDIV,RCDTRNG,RCEND,RCHDR,RCLNCNT,RCLSTMGR,RCPAGE,RCPG,RCSSD,RCSTA,RCSTART,RCSTNO,RCSTOP,RCTMPND
 N RCXCLUDE,VAUTD,X,Y
 ; RCDTRNG  - Date/Time range of report (range flag^start date^end date)
 ; RCDISPTY   - Display/print/Excel flag
 ; RCPAGE - page number of the report
 ; RCSSD - Selected Start Date (W:Date Removed from Worklist;R:Date ERA Received;B:Both Dates
 ; RCLNCNT - counter for SL^RCDPEARL
 ; RCSTOP - flag to exit listing
 ; RCTMPND - storage node for SL^RCDPEARL
 ; RCXCLUDE("CHAMPVA") - boolean, exclude CHAMPVA
 ; RCXCLUDE("TRICARE") - boolean, exclude TriCare
 ;
 S RCLSTMGR=""  ; ListMan flag, set to '^' if sent to Excel
 S RCTMPND=""  ; if null, report lines not stored in ^TMP, written directly
 S (RCSTOP,RCPG,RCLNCNT)=0  ; initial values of zero
 S (RCXCLUDE("CHAMPVA"),RCXCLUDE("TRICARE"))=0  ; default to false
 S RCPAGE=0  ; report page number
 ; PRCA*4.5*276 - Modify Header display
 S RCDIV="ALL"  ; default to All divisions
 S RCSSD=$$DTPRB^RCDPEM4() G:RCSSD=0 EXIT
 S RCDTRNG=$$DTRNG^RCDPEM4() G:'RCDTRNG EXIT
 S RCSTART=$P(RCDTRNG,U,2),RCEND=$P(RCDTRNG,U,3)
 ; VAUTD=1 for 'ALL'
 D DIVISION^VAUTOMA Q:Y=-1
 I 'VAUTD&($D(VAUTD)'=11) G EXIT
 I VAUTD=0 D
 .N J,C S (J,C)=0,RCDIV="" F  S J=$O(VAUTD(J)) Q:'J  S C=C+1,$P(RCDIV,", ",C)=VAUTD(J)
 ;
 ; CHAMPVA exclusion filter
 S RCXCLUDE("CHAMPVA")=$$INCHMPVA^RCDPEARL  ; user is asked whether to include
 G:RCXCLUDE("CHAMPVA")<0 EXIT
 ; TRICARE exclusion filter
 S RCXCLUDE("TRICARE")=$$INTRICAR^RCDPEARL  ; user is asked whether to include
 G:RCXCLUDE("TRICARE")<0 EXIT
 ; ask display type for Excel
 S RCDISPTY=$$DISPTY() G:RCDISPTY<0 EXIT
 ; display Excel info, set ListMan flag to prevent question
 I RCDISPTY D INFO^RCDPEM6 S RCLSTMGR="^"
 ; if not output to Excel ask for ListMan display, exit if timeout or '^' - PRCA*4.5*298
 I RCLSTMGR="" S RCLSTMGR=$$ASKLM^RCDPEARL G:RCLSTMGR<0 EXIT
 ; display in ListMan format and exit on return
 I RCLSTMGR D  G EXIT
 .S RCTMPND=$T(+0)_"^REMOVE ERA AUDIT"  K ^TMP($J,RCTMPND)  ; clean any residue
 .D REPRT,DISP(RCDISPTY)
 .N H,L,HDR S L=0
 .S HDR("TITLE")=$$HDRNM
 .F H=1:1:7 I $D(RCHDR(H)) S L=H,HDR(H)=RCHDR(H)  ; take first 7 lines of report header
 .I $O(RCHDR(L)) D  ; any remaining header lines at top of report
 ..N N S N=0,H=L F  S H=$O(RCHDR(H)) Q:'H  S N=N+.001,^TMP($J,RCTMPND,N)=RCHDR(H)
 .; invoke ListMan
 .D LMRPT^RCDPEARL(.HDR,$NA(^TMP($J,RCTMPND))) ; generate ListMan display
 ;
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="ENFRMQ^RCDPEM3"
 .S ZTDESC=$$HDRNM
 .S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 .D ^%ZTLOAD
 .W !!,$S($G(ZTSK):"Task number "_ZTSK_" queued.",1:"Unable to queue this task.")
 .K IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
ENFRMQ ; entry point from queue
 D REPRT
 D DISP(RCDISPTY)
 D EXIT
 Q
 ;
DISPTY() ; function, ask display/output type
 ; input from user
 ; returns: Output destination (0=Display, 1=MS Excel, -1=timeout or '^')
 N DIR,DUOUT,X,Y
 S DIR(0)="YA",DIR("A")="Export the report to Microsoft Excel? (Y/N): ",DIR("B")="NO"
 D ^DIR
 I $D(DUOUT)!$D(DIRUT) S Y=-1
 Q Y
 ;
ERASTA(ERAIEN) ; function, returns "station name ^ station #" for an ERA
 ; ERAIEN - ien of the ERA
 Q:'($G(ERAIEN)>0) "-1^"  ; must have valid IEN  
 N ERAEOB,BILLPTR,J,M,P,STAPTR,STNAM,STANMBR,Y
 ; ERAEOB  - EOB corresponding to the ERA
 ; BILLPTR - pointer to Bill corresponding to the ERA
 ; STAPTR - IEN of the Station of the ERA
 S STNAM=""  ; initial value
 D
 .;^RCY(344.4,D0,1,D1,0)= (#.01) SEQUENCE # [1N] ^ (#.02) EOB DETAIL [2P:361.1]
 .S J=0 F  S J=$O(^RCY(344.4,ERAIEN,1,J)) Q:'J!(STNAM]"")  S M=^(J,0) D
 ..N J,Y  ; protect loop counter, Y used below 
 ..S ERAEOB=0,P=+$P(M,U,2) I P>0,$D(^IBM(361.1,P,0)) S Y=$G(^(0)),ERAEOB=P
 ..Q:'ERAEOB  ; pointer to ^IBM(361.1,0) = EXPLANATION OF BENEFITS^361.1
 ..S BILLPTR=$P(Y,U) Q:'(BILLPTR>0)
 ..; ^DGCR(399,0) = BILL/CLAIMS^399
 ..S STAPTR=$P($G(^DGCR(399,BILLPTR,0)),U,22) Q:'(STAPTR>0)
 ..; ^DG(40.8,0) = MEDICAL CENTER DIVISION^40.8
 ..S STNAM=$$GET1^DIQ(40.8,STAPTR_",",.01,"","","RCDIERR")  ; 40.8,.01 = NAME
 ..Q:STNAM=""
 ..S STANMBR=$P(^DG(40.8,STAPTR,0),U,2)  ; IA 417
 ;
 S:STNAM="" STNAM="STATION UNKNOWN",STANMBR="000"
 Q STNAM_"^"_STANMBR
 ;
REPRT ; Generate the report ^TMP array
 ; INPUT:
 ;   RCSSD
 ;   RCDTRNG
 N DTXREF,START,END,ERAIEN,X,DTERA,ZROND
 ; DTXREF - date from cross-reference, "AC" is ERA DATE (#.04), "AD" is REMOVED DATE (#.17)
 ; DTERA - Date ERA received
 ; START - Start date of report date range
 ; END - End date of report date range
 ; ERAIEN - IEN of ERA
 ; RCSSD  - Start date (W:Date Removed from Worklist;R:Date ERA Received;B:Both Dates)
 ; ZROND - node zero of entry in file #344.4
 ;
 ; ^RCY(344.4,D0,6)= (#.16) REMOVED BY [1P:200] ^ (#.17) REMOVED DATE [2D] ^ (#.18) REMOVE REASON [3F] ^
 ;
 K ^TMP($J,"RC REMV ERA"),^TMP($J,"RC TOTAL")
 ; If user picked W:Date Removed from Worklist or B:Both Dates, use x-ref "AD" (REMOVED DATE)
 I (RCSSD="W")!(RCSSD="B") D
 .S END=$P(RCDTRNG,U,3),START=$P(RCDTRNG,U,2),DTXREF=START-.0000001
 .F  S DTXREF=$O(^RCY(344.4,"AD",DTXREF)) Q:'DTXREF!(DTXREF\1>END)  D
 ..S ERAIEN=0
 ..F  S ERAIEN=$O(^RCY(344.4,"AD",DTXREF,ERAIEN)) Q:'ERAIEN  I $D(^RCY(344.4,ERAIEN,6)) S ZROND=$G(^(0)) D:ZROND]""
 ...; CHAMPVA check
 ...I $G(RCXCLUDE("CHAMPVA")),$$CLMCHMPV^RCDPEARL("344.4;"_ERAIEN) D  Q  ; count and quit if true
 ....N N S N=$G(^TMP($J,"RC TOTAL","CHAMPVA"))+1,^("CHAMPVA")=N  ; total can be listed
 ...;
 ...; TRICARE check
 ...I $G(RCXCLUDE("TRICARE")),$$CLMTRICR^RCDPEARL("344.4;"_ERAIEN) D  Q  ; count and quit if true
 ....N N S N=$G(^TMP($J,"RC TOTAL","TRICARE"))+1,^("TRICARE")=N  ; total can be listed
 ...;
 ...D PROC(ERAIEN)
 ;
 ; If user picked R:Date ERA Received or B:Both Dates, use x-ref "AC" (ERA DATE)
 I (RCSSD="R")!(RCSSD="B") D
 .S END=$P(RCDTRNG,U,3),START=$P(RCDTRNG,U,2),DTXREF=START-.0000001
 .F  S DTXREF=$O(^RCY(344.4,"AC",DTXREF)) Q:'DTXREF!(DTXREF\1>END)  D
 ..S ERAIEN=0 F  S ERAIEN=$O(^RCY(344.4,"AC",DTXREF,ERAIEN)) Q:'ERAIEN  D
 ...Q:'$D(^RCY(344.4,ERAIEN,6))  S ZROND=$G(^(0)) Q:ZROND=""
 ...Q:$D(^TMP($J,"RC REMV ERA",$P(ZROND,U)))  ; data is in ^TMP
 ...; CHAMPVA check
 ...I $G(RCXCLUDE("CHAMPVA")),$$CLMCHMPV^RCDPEARL("344.4;"_ERAIEN) D  Q  ; count and quit if true
 ....N N S N=$G(^TMP($J,"RC TOTAL","CHAMPVA"))+1,^("CHAMPVA")=N  ; total can be listed
 ...;
 ...; TRICARE check
 ...I $G(RCXCLUDE("TRICARE")),$$CLMTRICR^RCDPEARL("344.4;"_ERAIEN) D  Q  ; count and quit if true
 ....N N S N=$G(^TMP($J,"RC TOTAL","TRICARE"))+1,^("TRICARE")=N  ; total can be listed
 ...;
 ...S DTERA=$P(ZROND,U,4) Q:'DTERA  D PROC(ERAIEN)
 ;
 Q
 ;
DISP(RCDISPTY) ; Format the display for screen/printer or MS Excel
 ; RCDISPTY -  Display/print/Excel flag
 ; LOCAL VARIABLES: IEN - line number of the data in ^TMP (see above)
 D:'RCLSTMGR HDRBLD
 D:RCLSTMGR HDRLM
 N A,IEN,LEN,RCNAM,Y
 D:'RCLSTMGR HDRLST^RCDPEARL(.RCSTOP,.RCHDR)
 S IEN=0
 ; PRCA*4.5*276 - Modify Display
 F  S IEN=$O(^TMP($J,"RC REMV ERA",IEN)) Q:'IEN!RCSTOP  S Y=^(IEN) D
 .I RCDISPTY W !,Y Q  ; Excel format
 .I 'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 .S A=$$PAD^RCDPEARL($P(Y,U,3),15)_$P(Y,U,2) D SL^RCDPEARL(A,.RCLNCNT,RCTMPND) ; ERA & Payer
 .S A=$$PAD^RCDPEARL($J("",5)_$P(Y,U,4),29)  ;  date ERA received
 .S A=$$PAD^RCDPEARL(A_$P(Y,U,5),46)  ; Date/Time Removed
 .S RCNAM=$P(Y,U,7) ; User who removed
 .; add ERA amount and user who removed
 .S A=$$PAD^RCDPEARL(A_"$"_$P(Y,U,6),58)_$E(RCNAM,1,19)  ; limit name to 19 chars.
 .D SL^RCDPEARL(A,.RCLNCNT,RCTMPND)
 .D WP($P(Y,U,8))  ; reason removed
 ;
 Q:RCSTOP
 ; end of report
 D SL^RCDPEARL(" ",.RCLNCNT,RCTMPND)  ; skip a line
 D SL^RCDPEARL($$ENDORPRT^RCDPEARL,.RCLNCNT,RCTMPND)
 ;
 Q
 ;
PROC(ERAIEN) ;  Put data into ^TMP based on filters
 ; ERAIEN  - ien of the ERA
 N ERAEOB,DTERA,DTRTN,RMVRSN,TRACE,AMT,PAYER,USER,Y,DEPTCKT,ERA,RCLOCDV,RCNTRY,P
 ; ERAEOB - EOB corresponding to this ERA
 ; RCDIV  - Name of station
 ; STANMBR  - Station number
 ; DTERA  - Date of ERA
 ; DTRTN  - Date ERA removed from worklist
 ; RMVRSN   - Justification for removal of ERA
 ; TRACE  - Trace number of the ERA
 ; AMT    - Total amount of the ERA
 ; PAYER  - ERA payer
 ; USER   - User who completed the removal of the ERA from the worklist
 ; DEPTCKT   - deposit ticket
 ; RCNTRY - entry from ^RCY(344.4,ien)
 ;
 S Y=$$ERASTA(ERAIEN)  ; station name and number
 S RCSTA=$P(Y,U),RCSTNO=$P(Y,U,2)
 ; PRCA*4.5*276 - Modify Display
 I 'VAUTD Q:RCDIV'[RCSTA
 M RCNTRY=^RCY(344.4,ERAIEN)
 S ERAEOB=$P($G(RCNTRY(1,1,0)),U,2)
 S Y=$P(RCNTRY(0),U,4),DTERA=$$FMTE^XLFDT(Y,"2D")
 S ERA=$P(RCNTRY(0),U)  ; (#.01) ENTRY [1N] 
 S TRACE=$P(RCNTRY(0),U,2)
 S AMT=$P(RCNTRY(0),U,5)
 S Y=$P(RCNTRY(6),U,2),DTRTN=$$FMTE^XLFDT(Y,2)  ; (#.17) REMOVED DATE [2D]
 S RMVRSN=$P(RCNTRY(6),U,3)  ; (#.18) REMOVE REASON [3F] 
 ; user's name for report
 S USER="",Y=+$P(RCNTRY(6),U) S:Y>0 USER=$$NAME^XUSER(Y,"F")
 S PAYER=""
 ; get PAYER if available
 I ERAEOB S P=+$P($G(^IBM(361.1,ERAEOB,0)),U,2) S:P>0 PAYER=$$GET1^DIQ(36,P_",",.01,"","","RCDIERR")
 S:PAYER="" PAYER="PAYER UNKNOWN"
 ; get Deposit Ticket
 ;S DEPTCKT="UNKNOWN" D
 ;.S Y=+$P(RCNTRY(0),U,8) Q:'Y  ; (#.08) RECEIPT [8P:344]
 ;.S Y=$P($G(^RCY(344,Y,0)),U,6) Q:'Y  ; file #344,(#.06) DEPOSIT TICKET [6P:344.1]
 ;.S DEPTCKT=$P($G(^RCY(344.1,DEPTCKT,0)),U)  ; file #344.1, (#.01) TICKET # [1F] 
 ;
 ; PRCA*4.5*276 - Remove Trace# from Excel
 S ^TMP($J,"RC REMV ERA",ERA)=RCSTA_U_PAYER_U_ERA_U_DTRTN_U_DTERA_U_AMT_U_USER_U_RMVRSN
 Q
 ;
 ;
HDRBLD ; create the report header
 ; returns RCHDR, RCPGNUM, RCSTOP
 ;   RCHDR(0) = header text line count
 ;   RCHDR("XECUTE") = M code for page number
 ;   RCHDR("RUNDATE") = date/time report generated, external format
 ;   RCPGNUM - page counter
 ;   RCSTOP - flag to exit
 ; INPUT:
 ;   RCDISPTY - Display/print/Excel flag
 ;   RCDTRNG - date range
 ;   RCXCLUDE - TRICARE /CHAMPVA flags
 ;
 K RCHDR S RCHDR("RUNDATE")=$$NOW^RCDPEARL,RCPGNUM=0,RCSTOP=0
 I RCDISPTY D  Q  ; Excel format, xecute code is QUIT, null page number
 .S RCHDR(0)=1,RCHDR("XECUTE")="Q",RCPGNUM=""
 .S RCHDR(1)="STATION NAME^PAYER^ERA NUMBER^DATE REMOVED^DATE RECEIVED^AMOUNT^USER^REMOVED REASON"
 ;
 N DIV,HCNT,Y
 S HCNT=0  ; counter for header
 ;
 S Y=$$HDRNM,HCNT=1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y  ; line 1 will be replaced by XECUTE code below
 S RCHDR("XECUTE")="N Y S RCPGNUM=RCPGNUM+1,Y=$$HDRNM^"_$T(+0)_"_$S(RCLSTMGR:"""",1:$J(""Page: ""_RCPGNUM,12)),RCHDR(1)=$J("" "",80-$L(Y)\2)_Y"
 S Y="Run Date/Time: "_RCHDR("RUNDATE"),HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y  ; line 1 will be replaced by XECUTE code below
 ;
 S Y("1ST")=$P(RCDTRNG,U,2),Y("LST")=$P(RCDTRNG,U,3)
 F Y="1ST","LST" S Y(Y)=$$FMTE^XLFDT(Y(Y),"2Z")
 S Y="Date Range: "_Y("1ST")_" - "_Y("LST")
 S Y=Y_" ("_$S(RCSSD="B":"Received & Removed",RCSSD="W":"Date Removed from Worklist",1:"Date ERA Received")_")"
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 K Y  ; delete Y subscripts
 S Y="DIVISIONS: "_RCDIV,Y=$J("",80-$L(Y)\2)_Y,HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y=" " F J="CHAMPVA","TRICARE" S Y=Y_" "_J_": "_$S($G(RCXCLUDE(J)):"NO",1:"YES")_" "
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 S HCNT=HCNT+1,RCHDR(HCNT)="ERA#           Payer Name"
 S HCNT=HCNT+1,RCHDR(HCNT)="     Date/Time               Date ERA         Total Amt   User Who"
 S HCNT=HCNT+1,RCHDR(HCNT)="     Removed                 Received         Paid        Removed"
 S Y="",$P(Y,"=",81)="",HCNT=HCNT+1,RCHDR(HCNT)=Y  ; row of equal signs at bottom
 ;
 S RCHDR(0)=HCNT  ; line count for header
 ;
 Q
 ;
HDRLM ; create the Listman header
 ; returns RCHDR
 ;   RCHDR(0) = header text line count
 ; INPUT:
 ;   RCDTRNG - date range
 ;   RCXCLUDE - TRICARE /CHAMPVA flags
 ;
 N DIV,HCNT,Y
 S HCNT=0  ; counter for header
 ;
 S Y("1ST")=$P(RCDTRNG,U,2),Y("LST")=$P(RCDTRNG,U,3)
 F Y="1ST","LST" S Y(Y)=$$FMTE^XLFDT(Y(Y),"2Z")
 S Y="Date Range: "_Y("1ST")_" - "_Y("LST")
 S Y=Y_" ("_$S(RCSSD="B":"Received & Removed",RCSSD="W":"Date Removed from Worklist",1:"Date ERA Received")_")"
 S HCNT=1,RCHDR(HCNT)=Y
 K Y  ; delete Y subscripts
 S Y="DIVISIONS: "_RCDIV,Y=Y,HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="" F J="CHAMPVA","TRICARE" S Y=Y_J_": "_$S($G(RCXCLUDE(J)):"NO",1:"YES")_"       "
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 S HCNT=HCNT+1,RCHDR(HCNT)="ERA#           Payer Name"
 S HCNT=HCNT+1,RCHDR(HCNT)="     Date/Time               Date ERA         Total Amt   User Who"
 S HCNT=HCNT+1,RCHDR(HCNT)="     Removed                 Received         Paid        Removed"
 ;
 S RCHDR(0)=HCNT  ; line count for header
 ;
 Q
 ; extrinsic var, name for header PRCA*4.5*298
HDRNM() Q "ERAs Removed from Active Worklist - Audit Report"
 ;
EXIT ;
 D ^%ZISC
 K ^TMP($J,"RC REMV ERA"),^TMP($J,"RC TOTAL")
 Q
 ;
WP(RR) ; format Removed Reason comments
 ; RR - Removed Reason
 I RR="" Q
 N PCS,I,CNTR,CMNT,Y
 ; PCS - Number of " " $pieces in the comment
 ; CNTR - CMNT line counter
 ; CMNT - comment text to be displayed
 S PCS=$L(RR," "),CNTR=1,CMNT(CNTR)=" Removed Reason: "
 F I=1:1:PCS D
 .S Y=$P(RR," ",I)
 .S:$L(CMNT(CNTR))+$L(Y)>72 CNTR=CNTR+1,CMNT(CNTR)=$J(" ",17)
 .S CMNT(CNTR)=CMNT(CNTR)_" "_Y
 ;
 F I=1:1:CNTR D SL^RCDPEARL(CMNT(I),.RCLNCNT,RCTMPND)
 Q
 ;
RETN ; Entry point for Remove Duplicate EFT Deposits [RCDPE REMOVE DUP DEPOSITS]
 N DA,DIC,DIE,DIR,DR,DTOUT,MSG,RCERANUM,RCY,X,Y
 D OWNSKEY^XUSRB(.MSG,"RCDPE REMOVE DUPLICATES",DUZ)
 I 'MSG(0) W !,"You are not authorized to use this option.",! S DIR(0)="E" D ^DIR K DIR Q
 W !!,"          WARNING: Removing an EFT is **NOT** reversible."
 W !,"  Use this option only if you are sure you want to remove this EFT."
 W !," Please be aware that once an EFT is removed - it cannot be restored.",!!
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Are you sure you want to continue? "
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!'Y Q
 ; EDI THIRD PARTY EFT DETAIL (#344.31)
 S DIC="^RCY(344.31,"
 ; screening logic for field #.08 MATCH STATUS [8S], must be UNMATCHED
 S DIC(0)="AEMQZ",DIC("S")="I '$P(^(0),U,8)"
 D ^DIC S RCY=+Y
 Q:RCY<0
 S RCERANUM=$P(Y(0),U) ; Get EFT number from returned zero node
 K DIR S DIR(0)="YA",DIR("B")="NO"
 S DIR("A",1)="This will mark EFT # "_RCERANUM_" as removed."
 S DIR("A")="Are you sure you want to continue? "
 W !
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y=0) D NOCHNG Q
 S DIE="^RCY(344.31,",DA=RCY,DR=".19" D ^DIE
 I $D(Y) D NOCHNG Q  ; user aborted edit
 ;
 ; 344.31,.08 - MATCH STATUS
 ; 344.31,.17 - USER WHO REMOVED EFT 
 ; 344.31,.18 - DATE/TIME DUPLICATE REMOVED
 S DR=".08////1;.17////"_DUZ_";.18////"_$$NOW^XLFDT D ^DIE
 W !!
 K DIR S DIR(0)="EA"
 S DIR("A")="Press return to continue: "
 S DIR("A",1)="EFT # "_RCERANUM_" has been marked as removed."
 D ^DIR
 Q
 ;
NOCHNG ;
 N DIR,DTOUT,DUOUT,X,Y
 S DIR(0)="EA"
 S DIR("A")="Press return to continue: "
 S DIR("A",1)="*** This EFT was NOT removed. ***"
 W !! D ^DIR
 Q
 ;
