RCDPE8NZ ;ALB/TMK/KML/hrubovcak - Unapplied EFT Deposits report ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,212,208,269,276,283,293,298,317,318,326,375,371**;Mar 20, 1995;Build 29
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; entry point for Unapplied EFT Deposits Report [RCDPE UNAPPLIED EFT DEP REPORT]
 ; ^RCY(344.3,0) = EDI LOCKBOX DEPOSIT^344.3I^
 ;
 N %ZIS,DIR,RCDET,RCDISPTY,RCDTRNG,RCENDT,RCHDR,RCLNCNT,RCLSTMGR,RCPGNUM,RCRPLST,RCSTDT,RCTMPND,RCTYPE,RPTQ,X,Y
 ; RCDET - detail report or grand totals only
 ; RCDISPTY - display type for Excel
 ; RCDTRNG - range of dates
 ; RCHDR - report header
 ; RCLNCNT - line counter for ^TMP storage
 ; RCLSTMGR - ListMan flag
 ; RCPGNUM - page number
 ; RCRPLST - node for report list in ^TMP
 ; RCTMPND - storage node (or null) for SL^RCPEARL
 ; RCTYPE - Payer type filter M - MEDICAL, P-PHARMACY, T-TRICARE, A-ALL
 ;
 S RCRPLST=$T(+0)_"_EFT"  ; storage for list of entries
 S RCLNCNT=0,RCLSTMGR="",RCTMPND=""  ; initial values for ListMan
 S RCDET=$$RDET("D") G:(RCDET=-1) RPTQ ; PRCA*4.5*371 - Prompt for detail report or grand total only
 S RCTYPE="A",(RCDTRNG,RCSTDT,RCENDT,RCDISPTY,RCLSTMGR)="",RPTQ=0 ; PRCA*4.5*371 - Make sure these don't crash grand totals report
 ;PRCA*4.5*371 - Change G RPTQ commands to setting a quit variable, because GOTO in a DO block apparently doesn't actually GOTO
 I RCDET'="G" D  G:RPTQ RPTQ  ;PRCA*4.5*371 - Don't prompt for any other options if grand total only selected
 .S RCTYPE=$$RTYPE^RCDPEU1("A") I (RCTYPE=-1) S RPTQ=1 Q  ; PRCA*4.5*326 - Add M/P/T filter
 .S RCDTRNG=$$DTRNG^RCDPEM4() I '(RCDTRNG>0) S RPTQ=1 Q
 .S RCSTDT=$P(RCDTRNG,U,2),RCENDT=$P(RCDTRNG,U,3)
 .; ask if export to excel
 .S RCDISPTY=$$DISPTY^RCDPEM3() I RCDISPTY<0 S RPTQ=1 Q
 .; for Excel, set ListMan flag to prevent question
 .I RCDISPTY S RCLSTMGR="^" D INFO^RCDPEM6
 .I RCLSTMGR="" S RCLSTMGR=$$ASKLM^RCDPEARL I RCLSTMGR<0 S RPTQ=1 Q
 .I RCLSTMGR D  S RPTQ=1 Q  ; send output to ListMan
 ..S RCTMPND=$T(+0)_"^UNAPPLIED EFT" K ^TMP($J,RCTMPND)  ; clean any residue
 ..D MKRPRT
 ..N H,L,HDR S L=0
 ..S HDR("TITLE")=$$HDRNM
 ..F H=1:1:7 I $D(RCHDR(H)) S L=H,HDR(H)=RCHDR(H)  ; take first 3 lines of report header
 ..I $O(RCHDR(L)) D  ; any remaining header lines at top of report
 ...N N S N=0,H=L F  S H=$O(RCHDR(H)) Q:'H  S N=N+.001,^TMP($J,RCTMPND,N)=RCHDR(H)
 ..; invoke ListMan
 ..D LMRPT^RCDPEARL(.HDR,$NA(^TMP($J,RCTMPND))) ; generate ListMan display
 ;
 ; Ask device
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .N ZTRTN,ZTSAVE,ZTDESC,POP,ZTSK
 .S ZTRTN="MKRPRT^RCDPE8NZ",ZTDESC="AR - List of unlinked EFT deposit payments"
 .S ZTSAVE("RC*")=""
 .D ^%ZTLOAD
 .W !!,$S($G(ZTSK):"Task number "_ZTSK_" was queued.",1:"Unable to queue this task.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 D MKRPRT
 Q
 ;
MKRPRT ; Entry point for queued job
 N RCTSKCNT,RCARDEP,RCCR,RCDA,RCDATA,RCDT,RCEFT,RCEFTIEN,RCREC,RCSTAT,RCSTOP,RCSUM,RCTOT,RCTR,RCUNAP,RECEXT,Y,Z,ZTSTOP
 ;
 ;  get list of unlinked EFT deposit data
 K ^TMP(RCRPLST,$J) ; subscripts: dep date,EFT ien,EFT det ien
 ;  Data is FMS doc indicator^FMS doc #^FMS Doc Status
 ;    FMS doc indicator = -1:no receipt  -2:no FMS doc  1:FMS doc exists
 ;
 S (RCTSKCNT,RCSTOP,RCSUM,RCUNAP)=0
 S RCARDEP="" F  S RCARDEP=$O(^RCY(344.3,"ARDEP",RCARDEP)) Q:RCARDEP=""!RCSTOP  S RCDA=0 F  S RCDA=$O(^RCY(344.3,"ARDEP",RCARDEP,RCDA)) Q:'RCDA  D  Q:RCSTOP
 . S RCDATA=$G(^RCY(344.3,RCDA,0)),RCDT=$P(RCDATA,U,7),RCTOT=0
 . Q:+RCSTDT&(RCDT<RCSTDT)  ; Before start date
 . Q:+RCENDT&(RCDT>(RCENDT+.999999))  ; After the end date
 . Q:'$P(RCDATA,"^",8)  ; no payment amt
 . S RCEFT=0 F  S RCEFT=$O(^RCY(344.31,"B",RCDA,RCEFT)) Q:'RCEFT!RCSTOP  S RCDATA(0)=$G(^RCY(344.31,RCEFT,0)) D  Q:RCSTOP
 . . I '$$ISTYPE^RCDPEU1(344.31,RCEFT,RCTYPE) Q  ;PRCA*4.5*326
 . . Q:$P($G(^RCY(344.31,RCEFT,0)),U,16)="D"  ; PRCA*4.5*375 - Do not show Debit EFTs because there's nothing to apply
 . . S RCTSKCNT=RCTSKCNT+1
 . . I '(RCTSKCNT#100),$D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ Q
 . . Q:$P($G(^RCY(344.31,RCEFT,3)),U)        ; EFT has been removed   PRCA*4.5*293
 . . S RCREC=$$GETREC(RCEFT,RCDATA(0),.RECEXT)
 . . Q:RCREC="PURGED"  ; need to prevent processed EFTs that had receipts purged from being generated on the report
 . . ;; PRCA276 - need to add EFT entries without a receipt to the total number of unapplied deposits
 . . I 'RCREC S RCUNAP=RCUNAP+1,^TMP(RCRPLST,$J,RCDT,RCDA,RCEFT)=-1,RCTOT=RCTOT+$P(RCDATA(0),U,7) Q  ; No receipt therefore no FMS document
 . . S RCSTAT=$$FMSSTAT^RCDPUREC(RCREC)
 . . I $E($P(RCSTAT,U),1,2)="TR",$P(RCSTAT,U,2)["ACCEPTED" Q
 . . S RCUNAP=RCUNAP+1,RCTOT=RCTOT+$P(RCDATA(0),U,7)  ; total unapplied deposits and total dollar amount of unapplied deposits
 . . I $P(RCSTAT,U,2)="NOT ENTERED" S ^TMP(RCRPLST,$J,RCDT,RCDA,RCEFT)="-2^^"_$P(RCSTAT,U) Q  ; No FMS doc
 . . S ^TMP(RCRPLST,$J,RCDT,RCDA,RCEFT)="1^"_$P(RCSTAT,U,1,2)_"^"_RECEXT
 . S:RCTOT ^TMP(RCRPLST,$J,RCDT,RCDA)=RCTOT,RCSUM=RCSUM+RCTOT
 ;
 D:'RCLSTMGR HDRBLD
 D:RCLSTMGR HDRLM
 ;
 I RCDISPTY D EXCEL Q
 ;
 D RPT
 Q
 ;
RPT ;  display/print the report using data populated in temporary global array
 N RCPAYID,RCPAYER,XX,YY,ZZ   ;PRCA*4.5*318
 ;
 D:'RCLSTMGR HDRLST^RCDPEARL(.RCSTOP,.RCHDR)  ; initial report header
 G:RCDET="G" RPTQ  ; PRCA*4.5*371 - Quit here if grand totals only report
 ;
 S RCDT=0
 F  S RCDT=$O(^TMP(RCRPLST,$J,RCDT)) Q:'RCDT  D  Q:RCSTOP
 .I 'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 .D SL^RCDPEARL(" ",.RCLNCNT,RCTMPND)  ; skip a line
 .S Y="DEPOSIT DATE: "_$$FMTE^XLFDT(RCDT,1),Y=$J("",80-$L(Y)\2)_Y D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 .S RCARDEP=0 F  S RCARDEP=$O(^TMP(RCRPLST,$J,RCDT,RCARDEP)) Q:'RCARDEP  D
 ..D SL^RCDPEARL(" ",.RCLNCNT,RCTMPND)  ; skip a line
 ..S RCTSKCNT=RCTSKCNT+1 I 'RCLSTMGR,(RCTSKCNT#100),$D(ZTQUEUED),$$S^%ZTLOAD D  Q  ; stop task
 ...S (RCSTOP,ZTSTOP)=1 D SL^RCDPEARL("TASK STOPPED BY USER!!",.RCLNCNT,RCTMPND) K ZTREQ
 ..;
 ..S RCDATA(0)=$G(^RCY(344.3,RCARDEP,0))
 ..I 'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 ..; PRCA*4.5*283 - Change the spaces for DEP # from 10 to 13 to allow 9 digit DEP #
 ..; PRCA*4.5*317 Shift line 2 chars to the right
 ..S Y="  "_$E($P(RCDATA(0),U,6)_$S('$$HACEFT^RCDPEU(RCARDEP):"",1:"-HAC")_$J("",13),1,13)  ;deposit #
 ..S Y=Y_"  "_$E($$FMTE^XLFDT($P(RCDATA(0),U,7),2)_$J("",16),1,16)     ; deposit date
 ..S Y=Y_"  "_$E($J(+$P(RCDATA(0),U,8),"",2)_$J("",20),1,20)           ; total amt deposit
 ..S Y=Y_"  "_$J(+$G(^TMP(RCRPLST,$J,RCDT,RCARDEP)),"",2)              ; total amt unposted
 ..D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 ..S RCEFTIEN=0 F  S RCEFTIEN=$O(^TMP(RCRPLST,$J,RCDT,RCARDEP,RCEFTIEN)) Q:'RCEFTIEN  S RCDATA=$G(^(RCEFTIEN)),RCEFT("DEP")=$G(^RCY(344.31,RCEFTIEN,0)) D
 ...I 'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 ...N RCPAY S RCPAY=$P(RCEFT("DEP"),U,2) S:RCPAY="" RCPAY="NO PAYER NAME RECEIVED" ; PRCA*4.5*298
 ...;
 ...; PRCA*4.5*317 Shift line 2 chars to the right
 ...;S Y="   "_RCPAY_"/"_$P(RCEFT("DEP"),U,3)  D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)   ; payer/ID
 ...; PRCA*4.5*318 Account for payer names of 60 characters and payer ID of 20 characters
 ...S RCPAYID=$P(RCEFT("DEP"),U,3)
 ...S RCPAYER=RCPAY_"/"_RCPAYID      ; payer/ID
 ...I $L(RCPAYER)>77 D
 ... . S ZZ=$L(RCPAYER,"/"),XX=$P(RCPAYER,"/",1,ZZ-1),YY=$P(RCPAYER,"/",ZZ)
 ... . S XX=$E(XX,1,$L(XX)-($L(RCPAYER)-77)),RCPAYER=XX_"/"_YY
 ...S Y="   "_RCPAYER
 ...; end of PRCA*4.5*318
 ...D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)   ; payer/ID
 ...; PRCA*4.5*317 Shift line 2 chars to the right
 ...S Y="    "_$E($P(RCEFT("DEP"),U,4)_$J("",50),1,50)                ; trace #
 ...S Y=Y_" "_$E($J(+$P(RCEFT("DEP"),U,7),"",2)_$J("",12),1,12)       ; payment amt
 ...;
 ...; PRCA*4.5*317 Shift lines 2 to thr right to allow 12 digit receipt #
 ...S Y=Y_" "_$S($P(RCDATA,U,4)'="":$P(RCDATA,U,4),1:"NO RECEIPT")    ; receipt #
 ... D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 ...; PRCA*4.5*317 Shift line 2 chars to the right
 ...S Z=$P(RCEFT("DEP"),U,8)
 ...S Y="      "_$E($S('Z:"UNMATCHED",Z=2:"PAPER EOB",1:"MATCHED TO ERA #: "_$P(RCEFT("DEP"),U,10)_$S(Z=-1:" (TOTALS MISMATCH)",1:""))_$J("",40),1,40)_"  "
 ...S Y=Y_$S($P(RCDATA,U)=-1:"NO RECEIPT",$P(RCDATA,U)=-2:"NO FMS DOCUMENT",1:$E($P(RCDATA,U,2)_" - "_$P(RCDATA,U,3),1,30))
 ...D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 ;
 I '$D(^TMP(RCRPLST,$J)) D SL^RCDPEARL("*** NO RECORDS TO PRINT ***",.RCLNCNT,RCTMPND)
 ;
 I 'RCSTOP D SL^RCDPEARL(" ",.RCLNCNT,RCTMPND),SL^RCDPEARL($$ENDORPRT^RCDPEARL,.RCLNCNT,RCTMPND)
 I $D(ZTQUEUED) S ZTREQ="@"
 D:'$D(ZTQUEUED) ^%ZISC
 G:RCSTOP RPTQ
 ;
RPTQ ;
 I '$G(RCLSTMGR),'$G(RCSTOP),$E(IOST,1,2)="C-" D ASK^RCDPEARL(.RCSTOP)
 K ^TMP(RCRPLST,$J)
 Q
 ;
GETREC(EFTDA,EFTDET,RECEXT) ; function,  prca276
 ; input - EFTDA - IEN OF 344.31
 ; input - EFTDET - data stored at the 0 subscript of the THIRD PARTY EFT DETAIL file (344.31)
 ; input - RECEXT passed by reference
 ; output - RECEXT populated with the external receipt value that gets generated on the report
 ; output - RECEIPT - returns internal value of the receipt that either comes from the EFT file (344.31) or the ERA file (344.4) 
 N RECEIPT
 S RECEXT=0
 S RECEIPT=+$P($G(^RCY(344.4,+$P(EFTDET,U,10),0)),U,8)  ; get receipt off the ERA record
 I 'RECEIPT,$P(EFTDET,U,8)=2 S RECEIPT=+$O(^RCY(344,"AEFT",EFTDA,0))  ; EFT processed against paper EOB
 I 'RECEIPT S RECEIPT=$P(EFTDET,U,9) ; receipt not posted in payment file so get from EFT detail (unprocessed EFT)
 I +RECEIPT,'$D(^RCY(344,RECEIPT)) Q "PURGED"  ; handle purged receipts but broken pointer exists in 344.31; need to handle as a processed EFT 
 I +RECEIPT S RECEXT=$P(^RCY(344,RECEIPT,0),U)
 Q +RECEIPT
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
 ;   RCRTYP - Report Type (EOB or ERA)
 ;   VAUTD
 K RCHDR S RCHDR("RUNDATE")=$$NOW^RCDPEARL,RCPGNUM=0,RCSTOP=0
 ;
 ;
 I RCDISPTY D  Q  ; Excel format, xecute code is QUIT, null page number
 .S RCHDR(0)=1,RCHDR("XECUTE")="Q",RCPGNUM=""
 .S RCHDR(1)="DEPOSIT #^DEPOSIT DATE^TOT AMT DEPOSIT^TOT AMT UNPOSTED^PAYER ID^TRACE #^PAYMENT AMT^RECEIPT #^ERA MATCHED^FMS DOC #/STATUS"
 ;
 N DIV,HCNT,Y
 S HCNT=0  ; header counter
 ;
 S Y=$$HDRNM,HCNT=1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y  ; line 1 will be replaced by XECUTE code below
 S RCHDR("XECUTE")="N Y S RCPGNUM=RCPGNUM+1,Y=$$HDRNM^"_$T(+0)_"_$S(RCLSTMGR:"""",1:$J(""Page: ""_RCPGNUM,12)),RCHDR(1)=$J("" "",80-$L(Y)\2)_Y"
 S Y="Run Date: "_RCHDR("RUNDATE")
 I RCDET'="G" D  ; PRCA*4.5*371 - Don't display MPT information in Grand Totals report
 . S Y=Y_"                 MEDICAL/PHARMACY/TRICARE: "   ; PRCA*4.5*326
 . S Y=Y_$S(RCTYPE="M":"MEDICAL",RCTYPE="P":"PHARMACY",RCTYPE="T":"TRICARE",1:"ALL") ; PRCA*4.5*326
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 ;
 S:RCDET="G" Y="GRAND TOTAL",Y=$J("",80-$L(Y)\2)_Y ; PRCA*4.5*371 - Grand Totals report
 S:RCDET'="G" Y="Date Range: "_$$FMTE^XLFDT(RCSTDT,2)_" - "_$$FMTE^XLFDT(RCENDT,2)_" (Deposit Date)",Y=$J("",80-$L(Y)\2)_Y
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="TOTAL NUMBER OF UNAPPLIED DEPOSITS: "_RCUNAP,HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 S Y="TOTAL AMOUNT OF UNAPPLIED DEPOSITS: $"_$FN(RCSUM,",",2),HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 ;
 I RCDET'="G" D  ; PRCA*4.5*371 - Don't display details on grand total report
 .; PRCA*4.5*317 Shift each line 2 chars to the right
 .S HCNT=HCNT+1,RCHDR(HCNT)="  DEPOSIT #      DEPOSIT DATE      TOT AMT OF DEPOSIT    TOT AMT UNPOSTED"
 .S HCNT=HCNT+1,RCHDR(HCNT)="   PAYER/ID"
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",4)_"TRACE #"_$J("",44)_"PAYMENT AMT  RECEIPT #"
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",6)_$E("ERA MATCHED"_$J("",40),1,40)_"  FMS DOC #/STATUS"
 .; PRCA*4.5*317 End
 S Y="",$P(Y,"=",81)="",HCNT=HCNT+1,RCHDR(HCNT)=Y  ; row of equal signs at bottom
 ;
 S RCHDR(0)=HCNT  ; header line count
 Q
 ;
HDRLM ; create the report header
 ; returns RCHDR
 ;   RCHDR(0) = header text line count
 ; INPUT: 
 ;   RCSTDT - Date Range
 K RCHDR
 ;
 N DIV,HCNT,Y
 S HCNT=0  ; header counter
 S Y="Date Range: "_$$FMTE^XLFDT(RCSTDT,2)_" - "_$$FMTE^XLFDT(RCENDT,2)_" (Deposit Date) "
 S Y=Y_"MEDICAL/PHARMACY/TRICARE: "                                                ; PRCA*4.5*326
 S Y=Y_$S(RCTYPE="M":"MEDICAL",RCTYPE="P":"PHARMACY",RCTYPE="T":"TRICARE",1:"ALL") ; PRCA*4.5*326
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="TOTAL NUMBER OF UNAPPLIED DEPOSITS: "_RCUNAP,HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="TOTAL AMOUNT OF UNAPPLIED DEPOSITS: $"_$FN(RCSUM,",",2),HCNT=HCNT+1,RCHDR(HCNT)=Y
 ;
 ; PRCA*4.5*317 Shift each line 2 chars to the right
 S HCNT=HCNT+1,RCHDR(HCNT)="  DEPOSIT #      DEPOSIT DATE      TOT AMT OF DEPOSIT    TOT AMT UNPOSTED"
 S HCNT=HCNT+1,RCHDR(HCNT)="   PAYER/ID"
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",4)_"TRACE #"_$J("",44)_"PAYMENT AMT  RECEIPT #"
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",6)_$E("ERA MATCHED"_$J("",40),1,40)_"  FMS DOC #/STATUS"
 ; PRCA*4.5*317 End
 ;
 S RCHDR(0)=HCNT  ; header line count
 Q
 ;
 ; extrinsic variable, name for header PRCA*4.5*298
HDRNM() Q "Unapplied EFT Deposits Report"
 ;
EXCEL ; Print report formatted for export to Excel
 N STR1
 W !,$G(RCHDR(1)),!
 S RCDT=0 F  S RCDT=$O(^TMP(RCRPLST,$J,RCDT)) Q:'RCDT  D  Q:RCSTOP
 .S RCARDEP=0 F  S RCARDEP=$O(^TMP(RCRPLST,$J,RCDT,RCARDEP)) Q:'RCARDEP  D
 ..S RCDATA(0)=$G(^RCY(344.3,RCARDEP,0))
 ..S STR1=$P(RCDATA(0),U,6)_$S('$$HACEFT^RCDPEU(RCARDEP):"",1:"-HAC")_U_$$FMTE^XLFDT($P(RCDATA(0),U,7))_U_$P(RCDATA(0),U,8)_U
 ..S STR1=STR1_+$G(^TMP(RCRPLST,$J,RCDT,RCARDEP))_U
 ..S RCEFTIEN=0 F  S RCEFTIEN=$O(^TMP(RCRPLST,$J,RCDT,RCARDEP,RCEFTIEN)) Q:'RCEFTIEN  S RCDATA=$G(^(RCEFTIEN)),RCEFT("DEP")=$G(^RCY(344.31,RCEFTIEN,0)) D
 ...W STR1 S:$P(RCEFT("DEP"),U,2)="" $P(RCEFT("DEP"),U,2)="NO PAYER NAME RECEIVED" ;PRCA*4.5*298
 ...W $P(RCEFT("DEP"),U,2)_"/"_$P(RCEFT("DEP"),U,3)_U_$P(RCEFT("DEP"),U,4)_U
 ...W +$P(RCEFT("DEP"),U,7)_U_$S($P(RCDATA,U,4)'="":$P(RCDATA,U,4),1:"NO RECEIPT")_U
 ...W $P(RCEFT("DEP"),U,10)_U
 ...W $S($P(RCDATA,U)=-1:"NO RECEIPT",$P(RCDATA,U)=-2:"NO FMS DOCUMENT",1:$P(RCDATA,U,2)_" - "_$P(RCDATA,U,3))
 ...W !
 Q
 ;
 ; PRCA*4.5*371 - Add subroutine
RDET(DEF) ; Prompt for full report or just grand total 
 ; Input:   DEF     - Value to use a default
 ; Returns: -1      - User ^ or timed out
 ;           D      - User selected DETAIL REPORT
 ;           G      - User selected GRAND TOTAL
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT,RCTYPE,RETURN
 S RCTYPE=""
 S DIR("?")="Enter the type of report to run"
 S DIR(0)="SA^D:DETAIL;G:GRAND TOTAL"
 S DIR("A")="(D)ETAIL REPORT or (G)RAND TOTAL?: "
 S DIR("B")=$S($G(DEF)'="":DEF,1:"D")
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 Q:Y="" "A"
 S RETURN=$E(Y)
 Q RETURN
 ;
