RCDPEM6 ;OIFO-BAYPINES/RBN - DUPLICATE EFT DEPOSITS AUDIT REPORT ;Jun 11, 2014@18:03:49
 ;;4.5;Accounts Receivable;**276,298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; completely refactored for PRCA*4.5*298
 Q
 ;
 ; generate an audit report that displays EFTs that have been removed by the user
 ; user selects a date range to limit the number of EFTs displayed.
 ; EDI THIRD PARTY EFT DETAIL file (#344.31)
 ;
 ; INPUT: user prompted for Date/Time range
 ;
 ; OUTPUT:
 ; report OF EFTs that have been removed.  
 ; The report has the following:
 ;   Trace number, Payer name, Deposit number, Date removed, User, Justification for removal
 ; data taken from EDI THIRD PARTY EFT DETAIL file (#344.31)
 ; report formatted for 80 columns
 ;
 ; put into ^TMP($J,"RCDPEM6",counter) for ListMan
 ; $pieces: DEPOSIT NUMBER^PAYER^TRACE NUMBER^AMOUNT^DATE REMOVED^USER^JUSTIFICATION
 ;
EN1 ; entry point for EFT Audit Report
 N I,RCDISPTY,RCDTRNG,RCHDR,RCLSTMGR,RCPGNUM,RCSTOP,RCTMPND,X,Y
 ; RCDISPTY - Display/print/Excel flag
 ; RCDTRNG - date range selected
 ; RCHDR - header array
 ; RCLSTMGR - ListMan flag
 ; RCPGNUM - report page number
 ; RCSTOP - boolean, User indicated to stop
 ; RCTMPND - storage node in ^TMP
 ;
 W !,"    "_$$HDRNM,!
 S RCDTRNG=$$DTRNG^RCDPEM4() G:'(RCDTRNG>0) EXIT
 S RCLSTMGR=""  ; ListMan flag, set to '^' if sent to Excel
 S RCTMPND=""  ; if null, report lines not stored in ^TMP, written directly
 S RCDISPTY=$$DISPTY^RCDPEM3() G:RCDISPTY<0 EXIT
 ; display information for Excel, indicate not to ask for ListMan
 I RCDISPTY D INFO S RCLSTMGR=U
 ; if not output to Excel ask for ListMan display, exit if timeout or '^' - PRCA*4.5*298
 I RCLSTMGR="" S RCLSTMGR=$$ASKLM^RCDPEARL G:RCLSTMGR<0 EXIT
 I RCLSTMGR D  G EXIT
 .S RCTMPND=$T(+0)_"^DUP EFT"  K ^TMP($J,RCTMPND)  ; clean any residue
 .D GENRPRT,DSPRPRT  ; generate report and store it in ^TMP
 .N H,L,HDR S L=0
 .S HDR("TITLE")=$$HDRNM
 .F H=1:1 Q:'$D(RCHDR(H))  S L=H,HDR(H)=RCHDR(H)  ; take first 3 lines of report header
 .I $O(RCHDR(L)) D  ; any remaining header lines at top of report
 ..N N S N=0,H=L F  S H=$O(RCHDR(H)) Q:'H  S N=N+.001,^TMP($J,RCTMPND,N)=RCHDR(H)
 .D LMRPT^RCDPEARL(.HDR,$NA(^TMP($J,RCTMPND))) ; generate ListMan display
 ;
 ; Select output device
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="ENFRMQ^RCDPEM6",ZTDESC=$$HDRNM,ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 .D ^%ZTLOAD
 .W !!,$S($G(ZTSK):"Task number "_ZTSK_" queued.",1:"Unable to queue this task.")
 .K IO("Q") D HOME^%ZIS
 ;
 U IO
 ; fall through to generate report
 ;
ENFRMQ ; entry point from TaskMan Queue
 D GENRPRT,DSPRPRT
 D EXIT
 Q
 ;
GENRPRT ; Generate the report ^TMP array
 ; INPUT: RCDTRNG - date range for report
 ;
 N EFTIEN,FRSTDT,INDXDT,LSTDT,X,Y
 ; INDXDT - date of EFT from "E" x-ref
 ; FRSTDT  - Start date of report date range
 ; LSTDT - End date of report date range
 ; EFTIEN - IEN of EFT
 ;
 K ^TMP($J,"RC DUP EFT")  ; used for report
 S FRSTDT=$P(RCDTRNG,U,2) S:FRSTDT<1 FRSTDT=2010101  ; 1 Jan 1901
 S LSTDT=$P(RCDTRNG,U,3) S:LSTDT<1 LSTDT=4010101  ; 1 Jan 2101
 S INDXDT=FRSTDT-.00000001  ; initial value for x-ref
 ;
 ; ^RCY(344.31,D0,3) = (#.17) USER WHO REMOVED EFT [1P:200] ^ (#.18) DATE/TIME DUPLICATE REMOVED [2D] ^ (#.19) EFT REMOVAL REASON [3F]
 F  S INDXDT=$O(^RCY(344.31,"E",INDXDT)) Q:'INDXDT!(INDXDT>LSTDT)  D
 .S EFTIEN=0 F  S EFTIEN=$O(^RCY(344.31,"E",INDXDT,EFTIEN)) Q:'EFTIEN  D:$D(^RCY(344.31,EFTIEN,3)) PROC(EFTIEN)
 ;
 Q
 ;
DSPRPRT ; Format display for screen/printer, Excel, or ListMan
 ; RCDISPTY - display for Excel flag
 ; RCLSTMGR - display for ListMan flag
 ;
 N CNT,DUPEFT,IEN,LINE,RCLNCNT,Y
 ; CNT - Count of EFT Deposits removed
 ; IEN - line number of the data in ^TMP
 ; DUPEFT - Data from ^TMP($J,"RC DUP EFT",IEN)
 ; RCLNCNT - line counter for SL^RCDPEARL
 ;
 D:'RCLSTMGR HDRBLD
 D:RCLSTMGR HDRLM
 ;
 I $G(RCTMPND)'="" K ^TMP($J,RCTMPND) S RCLNCNT=0
 D:'RCLSTMGR HDRLST^RCDPEARL(.RCSTOP,.RCHDR)  ; initial report header
 S IEN="",CNT=0
 F  S IEN=$O(^TMP($J,"RC DUP EFT",IEN)) Q:'IEN!RCSTOP  D
 .S CNT=CNT+1,DUPEFT=^TMP($J,"RC DUP EFT",IEN)
 .I RCDISPTY D SL^RCDPEARL(DUPEFT,.RCLNCNT,RCTMPND) Q  ; Excel format, write line and quit
 .I 'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 .S Y=$$PAD^RCDPEARL(" "_$P(DUPEFT,U),16)_$P(DUPEFT,U,3) D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 .S Y=$J(" ",6)_$P(DUPEFT,U,2) D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 .S Y=$$PAD^RCDPEARL($J(" ",16)_$J($P(DUPEFT,U,4),0,2),28)_$P(DUPEFT,U,5)
 .S Y=$$PAD^RCDPEARL(Y,50)_$E($P(DUPEFT,U,6),1,25) D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 .D WP($P(DUPEFT,U,7)) D SL^RCDPEARL(" ",.RCLNCNT,RCTMPND)
 ;
 I 'RCDISPTY,'RCSTOP D  ; not for Excel
 .S Y=" Total number of duplicates removed: "_CNT D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND),SL^RCDPEARL(" ",.RCLNCNT,RCTMPND)
 ;
 I 'RCSTOP D SL^RCDPEARL($$ENDORPRT^RCDPEARL,.RCLNCNT,RCTMPND)
 ;
 Q
 ;
PROC(EFTIEN) ;  gather data into ^TMP
 ; EFTIEN = ien of the EFT
 ;
 N AMT,DEPNO,JUST,PAYER,PTR,RCRD,RTRNDT,TRACE,USER
 ; JUST - Justification for returning EFT
 ; TRACE - EFT Trace number
 ; AMT - amount of the EFT
 ; PAYER - EFT payer
 ; PTR - pointer to #344.3
 ; RTRNDT - Date EFT returned
 ; USER - User who completed the transaction
 ; DEPNO - Deposit # of EFT
 ;
 S RCRD(0)=$G(^RCY(344.31,EFTIEN,0)),RCRD(3)=$G(^(3))
 S USER=$$NAME^XUSER($P(RCRD(3),U),"F")
 S RTRNDT=$$FMTE^XLFDT($P(^RCY(344.31,EFTIEN,3),U,2),2)
 S JUST=$P(RCRD(3),U,3)
 S PAYER=$P(RCRD(0),U,2) S:PAYER="" PAYER="Unknown Payer"
 S TRACE=$P(RCRD(0),U,4),AMT=$P(RCRD(0),U,7)
 S PTR=+$P(RCRD(0),U)
 ; EDI LOCKBOX DEPOSIT (#344.3), (#.06) DEPOSIT NUMBER [6F]
 S:PTR>0 DEPNO=$P($G(^RCY(344.3,PTR,0)),U,6)
 S:DEPNO="" DEPNO="Unknown"
 S ^TMP($J,"RC DUP EFT",EFTIEN)=DEPNO_"^"_PAYER_"^"_TRACE_"^"_AMT_"^"_RTRNDT_"^"_USER_"^"_JUST
 Q
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
 ;   RCRTYP - Report Type (EOB or ERA)
 ;   RCDTRNG - selected dates
 ;
 K RCHDR S RCHDR("RUNDATE")=$$NOW^RCDPEARL,RCPGNUM=0,RCSTOP=0
 ;
 I RCDISPTY D  Q  ; Excel format, xecute code is QUIT, null page number
 .S RCHDR(0)=1,RCHDR("XECUTE")="Q",RCPGNUM=""
 .S RCHDR(1)="DEPOSIT NUMBER^PAYER^TRACE NUMBER^AMOUNT^DATE REMOVED^USER^JUSTIFICATION"
 ;
 N DIV,HCNT,Y
 S HCNT=0  ; counter for header
 ;
 S Y=$$HDRNM,HCNT=1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y  ; line 1 will be replaced by XECUTE code below
 S RCHDR("XECUTE")="N Y S RCPGNUM=RCPGNUM+1,Y=$$HDRNM^"_$T(+0)_",RCHDR(1)=$J("" "",80-$L(Y)\2)_Y_""            Page: ""_RCPGNUM"
 S Y="RUN DATE: "_RCHDR("RUNDATE"),HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y  ; line 1 will be replaced by XECUTE code below
 ;
 S Y("1ST")=$P(RCDTRNG,U,2),Y("LST")=$P(RCDTRNG,U,3)
 F Y="1ST","LST" S Y(Y)=$$FMTE^XLFDT(Y(Y),"2Z")
 S Y="Date Range: "_Y("1ST")_" - "_$$FMTE^XLFDT(Y("LST"),"2Z")_" (DATE EFT REMOVAL)"
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 K Y  ; delete Y subscripts
 I $G(RCLSTMGR) S HCNT=HCNT+1,RCHDR(HCNT)="",HCNT=HCNT+1,RCHDR(HCNT)=""
 S Y=$$PAD^RCDPEARL(" Deposit#",16)_"Trace #",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y=$$PAD^RCDPEARL($J(" ",6)_"Payer Name",28),Y=Y_"Date/Time",Y=$$PAD^RCDPEARL(Y,50)_"User Who"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y=$J(" ",16)_"Amount",Y=$$PAD^RCDPEARL(Y,28)_"Removed",Y=$$PAD^RCDPEARL(Y,50)_"Removed"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="",$P(Y,"=",81)="",HCNT=HCNT+1,RCHDR(HCNT)=Y
 ;
 S RCHDR(0)=HCNT
 Q
 ;
HDRLM ; create the Listman Screen header section
 ; returns RCHDR
 ;   RCHDR(0) = header text line count
 ; INPUT: 
 ;   RCDTRNG - selected dates
 ;
 K RCHDR S RCPGNUM=0,RCSTOP=0
 ;
 N DIV,HCNT,Y
 S HCNT=0  ; counter for header
 ;
 S Y("1ST")=$P(RCDTRNG,U,2),Y("LST")=$P(RCDTRNG,U,3)
 F Y="1ST","LST" S Y(Y)=$$FMTE^XLFDT(Y(Y),"2Z")
 S Y="Date Range: "_Y("1ST")_" - "_$$FMTE^XLFDT(Y("LST"),"2Z")_" (DATE EFT REMOVAL)"
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 K Y  ; delete Y subscripts
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 S Y=$$PAD^RCDPEARL(" Deposit#",16)_"Trace #",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y=$$PAD^RCDPEARL($J(" ",6)_"Payer Name",28),Y=Y_"Date/Time",Y=$$PAD^RCDPEARL(Y,50)_"User Who"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y=$J(" ",16)_"Amount",Y=$$PAD^RCDPEARL(Y,28)_"Removed",Y=$$PAD^RCDPEARL(Y,50)_"Removed"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 ;
 S RCHDR(0)=HCNT
 Q
 ;
 ; extrinsic variable, header text
HDRNM() Q "Duplicate EFT Deposits - Audit Report"
 ;
EXIT ;
 D ^%ZISC
 K ^TMP($J,"RC DUP EFT")  ; clean up
 Q
 ;
INFO ; Useful Info for Excel capture
 N SP S SP=$J(" ",10)  ; spaces
 W !!!,SP_"Before continuing, please set up your terminal to capture the"
 W !,SP_"report data as this report may take a while to run."
 W !!,SP_"To avoid undesired wrapping of the data saved to the"
 W !,SP_"file, please enter '0;256;999' at the 'DEVICE:' prompt."
 W !!,SP_"It may be necessary to set the terminal's display width"
 W !,SP_"to 256 characters, which can be performed by selecting the"
 W !,SP_"Display option located within the 'Setup' menu on the"
 W !,SP_"tool bar of the terminal emulation software (e.g. KEA,"
 W !,SP_"Reflection, or Smarterm).",!!
 Q
 ;
WP(JC) ; format justification comments
 ; JC - Justification Comment
 I JC="" Q
 N PCS,I,CNTR,CMNT,Y
 ; PCS - Number of " " $pieces in the comment
 ; CNTR - CMNT line counter
 ; CMNT - comment text to be displayed
 S PCS=$L(JC," "),CNTR=1,CMNT(CNTR)=" Justification Comments: "
 F I=1:1:PCS D
 .S Y=$P(JC," ",I)
 .S:$L(CMNT(CNTR))+$L(Y)>72 CNTR=CNTR+1,CMNT(CNTR)=$J(" ",25)
 .S CMNT(CNTR)=CMNT(CNTR)_" "_Y
 ;
 F I=1:1:CNTR D SL^RCDPEARL(CMNT(I),.RCLNCNT,RCTMPND)
 Q
 ;
NOW() ;function, Returns current date/time in format mm/dd/yy@hh:mm:ss
 Q $$FMTE^XLFDT($$NOW^XLFDT,2)
 ;
