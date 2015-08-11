RCDPEAR1 ;ALB/TMK/PJH - ERA Unmatched Aging Report (file #344.4) ;Dec 20, 2014@18:41:35
 ;;4.5;Accounts Receivable;**173,269,276,284,293,298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; PRCA*4.5*298 routine completely refactored
EN1 ; entry point - ERA Unmatched Aging Report [RCDPE ERA AGING REPORT]
 ; data from ELECTRONIC REMITTANCE ADVICE file (#344.4)
 N RCDISPTY,RCDT,RCDTRNG,RCHDR,RCJOB,RCLNCNT,RCLSTMGR,RCOUT,RCPGNUM,RCPYRLST,RCRESPYR
 N RCSTOP,RCTMPND,RCXCLUDE,RCZROBAL,VAUTD,Y
 ; RCDISPTY - display type (Excel)
 ; RCDTRNG - selected date range
 ; RCDT("BEG") - start date, RCDT("END") - end date
 ; RCHDR - header array
 ; RCLSTMGR - list manager flag
 ; RCRESPYR - payer info response: "1^first payer^last payer" or "2^^" (for all) or "3^^" (for specific)
 ; RCDTRNG - "1^start date^end date"
 ; RCPYRLST - payer list for selected payers
 ; RCXCLUDE("CHAMPVA") - boolean, exclude CHAMPVA
 ; RCXCLUDE("TRICARE") - boolean, exclude TriCare
 ; RCZROBAL - zero balance flag
 ; VAUTD - division information
 ;
 K ^TMP($J,"RC TOTAL")  ; clear old totals
 W !,$$HDRNM D DIVISION^VAUTOMA  ; returns VAUTD
 I 'VAUTD&($D(VAUTD)'=11) G EN1Q
 S RCLSTMGR=""  ; initial value, won't be asked if non-null
 S (RCXCLUDE("CHAMPVA"),RCXCLUDE("TRICARE"))=0  ; default to false
 S RCDTRNG=$$DTRNG^RCDPEM4() I 'RCDTRNG G EN1Q
 S RCDT("BEG")=$P(RCDTRNG,U,2),RCDT("END")=$P(RCDTRNG,U,3)
 ;Get insurance company to be used as filter
 ; PRCA*4.5*284 - RCRESPYR (Type of Response(1=Range,2=All,3=Specific)^From name^To name)
 S RCRESPYR=$$GETPAY^RCDPEM9(344.4) G:RCRESPYR<0 EN1Q
 ; Get Zero Balance Filter
 S RCZROBAL=$$ZROBAL() G:RCZROBAL<0 EN1Q
 ; CHAMPVA exclusion filter
 S RCXCLUDE("CHAMPVA")=$$INCHMPVA^RCDPEARL  ; user is asked whether to include
 G:RCXCLUDE("CHAMPVA")<0 EN1Q
 ; TRICARE exclusion filter
 S RCXCLUDE("TRICARE")=$$INTRICAR^RCDPEARL  ; user is asked whether to include
 G:RCXCLUDE("TRICARE")<0 EN1Q
 ; display type, ask for Excel format
 S RCDISPTY=$$DISPTY^RCDPEM3() I RCDISPTY=-1 G EN1Q
 ; display device info about Excel format, set ListMan flag to prevent question
 I RCDISPTY S RCLSTMGR="^" D INFO^RCDPEM6
 I $D(DUOUT)!$D(DTOUT) G EN1Q
 S RCJOB=$J  ; needed in RPTOUT
 ;
 I '(+RCRESPYR=2) D  ; get payer list if not all payers
 .N J,P S J=0
 .F  S J=$O(^TMP("RCSELPAY",$J,J)) Q:'J  S P=$G(^(J)) S:P]"" RCPYRLST(P)=""
 ; if not output to Excel ask for ListMan display, exit if timeout or '^' - PRCA*4.5*298
 I RCLSTMGR="" S RCLSTMGR=$$ASKLM^RCDPEARL G:RCLSTMGR<0 EN1Q
 ; display in ListMan format and exit on return
 I RCLSTMGR D  G EN1Q
 .S RCTMPND=$T(+0)_"^ERA UNMATCHED AGING"  K ^TMP($J,RCTMPND)  ; clean any residue
 .D RPTOUT
 .N H,L,HDR S L=0
 .S HDR("TITLE")=$$HDRNM
 .F H=1:1:7 I $D(RCHDR(H)) S L=H,HDR(H)=RCHDR(H)  ; take first 7 lines of report header
 .I $O(RCHDR(L)) D  ; any remaining header lines at top of report
 ..N N S N=0,H=L F  S H=$O(RCHDR(H)) Q:'H  S N=N+.001,^TMP($J,RCTMPND,N)=RCHDR(H)
 .; invoke ListMan
 .D LMRPT^RCDPEARL(.HDR,$NA(^TMP($J,RCTMPND))) ; generate ListMan display
 ;
 ; Ask device
 N %ZIS S %ZIS="QM" D ^%ZIS G:POP EN1Q
 I $D(IO("Q")) D  G EN1Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK,ZTSTOP
 .S ZTRTN="RPTOUT^RCDPEAR1",ZTDESC="AR - EDI LOCKBOX ERA AGING REPORT"
 .S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 .; PRCA*4.5*284 - ^TMP may be on another server, save off specific payers in local
 .;I +RCRESPYR=3 M RCPYRLST=^TMP("RCSELPAY",$J)
 .D ^%ZTLOAD
 .W !!,$S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this task.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO S RCTMPND="" D RPTOUT
 ;
EN1Q ; exit and clean up
 K ^TMP("RCSELPAY",$J),^TMP("RCPAYER",$J)
 I '$G(RCLSTMGR) D ^%ZISC
 Q
 ;
RPTOUT ; Entry point for listing report
 ; RCTMPND = name of the subscript for ^TMP to use to return all lines
 ;        (for bulletin).  If undefined or null, output is printed
 ; Return global if RCTMPND not null: ^TMP($J,RCTMPND,line#)=line text
 N ERADT,PYMNTFRM,RC0,RCEDT,RCEXCEP,RCFLIEN,RCITM,RCNT,RCPAY,RCSF0,RCZ,STA,STNAM,STNUM,X,Y,Z,Z0
 ; ERADT - date of entry
 ; RCFLIEN - entry number in file #344.4
 ; RCITM - entry in ^RCY(344.4,0) = ELECTRONIC REMITTANCE ADVICE^344.4I
 ; RCSF0 - zero node of sub-file entry
 ;
 S RCTMPND=$G(RCTMPND)  I RCTMPND'="" K ^TMP($J,RCTMPND)  ; clear residual data
 ; RCNT - count of items
 K ^TMP($J,"RCERA_AGED"),^TMP($J,"RCERA_ADJ")
 S RCRESPYR=+RCRESPYR
 S RCFLIEN=0,RCNT=0
 F  S RCFLIEN=$O(^RCY(344.4,"AMATCH",0,RCFLIEN)) Q:'RCFLIEN  D
 .K RCITM M RCITM=^RCY(344.4,RCFLIEN)  ; grab entire entry
 .Q:$P($G(RCITM(6)),U)  ; who removed the ERA - PRCA*4.5*293
 .S ERADT=+$P($G(RCITM(0)),U,7)  ; (#.07) FILE DATE/TIME [7D]
 .Q:'ERADT  ; no date, don't include
 .; Check date range
 .Q:(RCDT("BEG")>ERADT\1)!(ERADT\1>RCDT("END"))
 .; Check Station/Division
 .;I '$$CHKDIV^RCDPEDAR(RCFLIEN,1,.VAUTD) Q
 .I 'VAUTD D ERASTA^RCDPEM4(RCFLIEN,.STA,.STNUM,.STNAM) I '$D(VAUTD(STA)) Q
 .; Check for payer match
 .S PYMNTFRM=$P($G(RCITM(0)),U,6)  ; PAYMENT FROM field
 .I '(RCRESPYR=2),PYMNTFRM]"" Q:'$D(RCPYRLST($$UP^XLFSTR(PYMNTFRM)))  ; will include null payers when ALL payers selected
 .Q:(PYMNTFRM="")&'(RCRESPYR=2)  ; null payers excluded when not ALL selected
 .; Check for Zero Bal
 .I 'RCZROBAL,'$P($G(RCITM(0)),U,5) Q  ; (#.05) TOTAL AMOUNT PAID [5N]
 .; CHAMPVA check
 .I $G(RCXCLUDE("CHAMPVA")),$$CLMCHMPV^RCDPEARL("344.4;"_RCFLIEN) D  Q  ; count and quit if true
 ..N N S N=$G(^TMP($J,"RC TOTAL","CHAMPVA"))+1,^("CHAMPVA")=N  ; total can be listed
 .;
 .; TRICARE check
 .I $G(RCXCLUDE("TRICARE")),$$CLMTRICR^RCDPEARL("344.4;"_RCFLIEN) D  Q  ; count and quit if true
 ..N N S N=$G(^TMP($J,"RC TOTAL","TRICARE"))+1,^("TRICARE")=N  ; total can be listed
 .;
 .; include on report
 .S ^TMP($J,"RCERA_AGED",$$FMDIFF^XLFDT(ERADT,DT),RCFLIEN)=0,RCNT=RCNT+1
 ;
 S ^TMP($J,"RC TOTAL","COUNT")=RCNT  ; save counter
 ; build local payer array
 D SELPAY(RCRESPYR,RCJOB,.RCPAY)
 ; build header, initialize stop flag
 D:'RCLSTMGR HDRBLD S RCSTOP=0
 D:RCLSTMGR HDRLM
 ;
 ; Excel format, print and exit
 I RCDISPTY D EXCEL,^%ZISC G EXIT
 ;
 D  ;  Calculate total amount for ERA
 .N T S T=0  ; total
 .S RCZ="" F  S RCZ=$O(^TMP($J,"RCERA_AGED",RCZ)) Q:RCZ=""  S RCFLIEN=0 F  S RCFLIEN=$O(^TMP($J,"RCERA_AGED",RCZ,RCFLIEN)) Q:'RCFLIEN  D
 ..S RC0=$G(^RCY(344.4,RCFLIEN,0)),T=T+$P(RC0,U,5)
 .;
 .S ^TMP($J,"RC TOTAL","AMOUNT")=T
 ;
 S RCLNCNT=0  ; line counter
 D:'RCLSTMGR HDRLST^RCDPEARL(.RCSTOP,.RCHDR)  ; first header in report
 ; list totals
 S Y=" Total NUMBER Aged Electronic ERA messages found: "_$FN(^TMP($J,"RC TOTAL","COUNT"),",")
 D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 S Y=" Total AMOUNT Aged Electronic ERA messages found: $"_$FN(^TMP($J,"RC TOTAL","AMOUNT"),",",2)
 D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 ; if filters selected show total excluded
 F J="CHAMPVA","TRICARE" I $G(RCXCLUDE(J)) S Y=" "_J_" exclusion count: "_(+$G(^TMP($J,"RC TOTAL",J))) D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 D SL^RCDPEARL(" "_$TR($J("",78)," ","="),.RCLNCNT,RCTMPND)  ; row of equal signs
 ;
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCERA_AGED",RCZ)) Q:RCZ=""  S RCFLIEN=0 F  S RCFLIEN=$O(^TMP($J,"RCERA_AGED",RCZ,RCFLIEN)) Q:'RCFLIEN  D  G:RCSTOP EXIT
 .I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPGNUM) W:RCTMPND="" !!,"***TASK STOPPED BY USER***" Q
 .I RCPGNUM D SL^RCDPEARL(" ",.RCLNCNT,.RCTMPND) ; On detail list, skip line
 .I 'RCLSTMGR,'RCPGNUM!(($Y+5)>IOSL) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 .S RC0=$G(^RCY(344.4,RCFLIEN,0))
 .S RCEXCEP=$$XCEPT^RCDPEWLP(RCFLIEN)  ; PRCA*4.5*298  assignment of ERA exception flag (will either be "" or "x")
 .S Z=$$SETSTR^VALM1($J(RCEXCEP_-RCZ,4),"",1,5)  ; PRCA*4.5*298 display ERA exception flag
 .S Z=$$SETSTR^VALM1("  "_$P(RC0,U,2),Z,5,50)
 .D SL^RCDPEARL(Z,.RCLNCNT,RCTMPND)
 .S Z=$$SETSTR^VALM1($P(RC0,U,6)_"/"_$P(RC0,U,3),"",11,69)
 .S Z=$$SETSTR^VALM1("  "_$$FMTE^XLFDT($P(RC0,U,4),2),Z,70,10)
 .D SL^RCDPEARL(Z,.RCLNCNT,RCTMPND)
 .S Z=$$SETSTR^VALM1($J("",16)_$S($P(RC0,U,7):$$FMTE^XLFDT($P(RC0,U,7)\1,2),1:""),"",1,25)
 .S Z=$$SETSTR^VALM1("  "_$J($P(RC0,U,5),15,2),Z,26,17)
 .S Z=$$SETSTR^VALM1("  "_+$P(RC0,U,11),Z,43,11)
 .S Z=$$SETSTR^VALM1("  "_$P(RC0,U),Z_$S('$$HACERA^RCDPEU(RCFLIEN):"",1:" (HAC ERA)"),54,26)
 .D SL^RCDPEARL(Z,.RCLNCNT,RCTMPND)
 .I "23"[$$ADJ^RCDPEU(RCFLIEN) D SL^RCDPEARL($J("",9)_"** CLAIM LEVEL ADJUSTMENTS EXIST FOR THIS ERA ***",.RCLNCNT,RCTMPND)
 .I $O(^RCY(344.4,RCFLIEN,2,0)) D  ; ERA level adjustments exist
 ..N Q
 ..D DISPADJ^RCDPESR8(RCFLIEN,"^TMP("_$J_",""RCERA_ADJ"")")
 ..I $O(^TMP($J,"RCERA_ADJ",0)) D SL^RCDPEARL($J("",9)_"** GENERAL ADJUSTMENT DATA EXIST FOR THIS ERA **",.RCLNCNT,RCTMPND)
 ..S Q=0 F  S Q=$O(^TMP($J,"RCERA_ADJ",Q)) Q:'Q  D SL^RCDPEARL($J("",9)_$G(^TMP($J,"RCERA_ADJ",Q)),.RCLNCNT,RCTMPND)
 .;
 .N D,RCSFIEN S RCSFIEN=0  ; RCSFIEN - sub-file ien, RCSF0 - zero node of sub-file entry
 .F  S RCSFIEN=$O(^RCY(344.4,RCFLIEN,1,RCSFIEN)) Q:'RCSFIEN  S RCSF0=$G(^(RCSFIEN,0)) D  Q:RCSTOP
 ..N RCDATA,RCOUT  ; set by RCDPESR0, RCDATA - message data, RCOUT - formatted message display
 ..I 'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 ..S D=$J("",7)_" EEOB Seq #: "_$P(RCSF0,U)_$S($D(^RCY(344.4,RCFLIEN,1,"ATB",1,RCSFIEN)):" (REVERSAL)",1:"")_"  EEOB "
 ..S D=D_$S('$P(RCSF0,U,2):"not on file",1:"on file for "_$P($G(^DGCR(399,+$G(^IBM(361.1,+$P(RCSF0,U,2),0)),0)),U))_"  "_$J(+$P(RCSF0,U,3),"",2)
 ..D SL^RCDPEARL(D,.RCLNCNT,RCTMPND)
 ..Q:$P(RCSF0,U,2)
 ..D DISP^RCDPESR0("^RCY(344.4,"_RCFLIEN_",1,"_RCSFIEN_",1)","RCDATA",1,"RCOUT",68,1)
 ..I '$O(RCOUT(0)) D SL^RCDPEARL($J("",9)_" NO DETAIL FOUND",.RCLNCNT,RCTMPND) Q
 ..S Z=0 F  S Z=$O(RCOUT(Z)) Q:'Z  D  Q:RCSTOP
 ...I 'RCDISPTY,'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 ...D SL^RCDPEARL($J("",9)_"*"_RCOUT(Z),.RCLNCNT,RCTMPND)
 ;
 ; PRCA*4.5*298, put end-of-report into SL^RCDPEARL
 I 'RCSTOP D SL^RCDPEARL(" ",.RCLNCNT,RCTMPND),SL^RCDPEARL($$ENDORPRT^RCDPEARL,.RCLNCNT,RCTMPND)
 ;
EXIT ;
 ; PRCA*4.5*298, added ListMan check
 I '$D(ZTQUEUED),'RCLSTMGR D
 .I 'RCSTOP,RCPGNUM,RCTMPND="" D ASK^RCDPEARL(.RCSTOP)
 .D ^%ZISC
 ;
 S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J,"RCERA_AGED"),^TMP("RCSELPAY",$J),^TMP($J,"RC TOTAL")
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
 ;   RCDTRNG - date range selected
 ;   RCXCLUDE - TRICARE /CHAMPVA flags
 ;   VAUTD
 ;
 K RCHDR S RCHDR("RUNDATE")=$$NOW^RCDPEARL,RCPGNUM=0,RCSTOP=0
 I RCDISPTY D  Q  ; Excel format, xecute code is QUIT, null page number
 .S RCHDR(0)=1,RCHDR("XECUTE")="Q",RCPGNUM=""
 .S RCHDR(1)="Aged Days^Trace #^Payment From/ID^ERA Date^File Date^Amount Paid^EEOB Cnt^ERA #^EEOB Detail"
 ;
 N DIV,HCNT,Y,CHATRI
 ;
 S RCHDR("XECUTE")="N Y S RCPGNUM=RCPGNUM+1,Y=$$HDRNM^"_$T(+0)_",RCHDR(1)=$J("" "",80-$L(Y)\2)_Y"_"_""          Page: ""_RCPGNUM"
 S HCNT=1
 S Y="RUN DATE: "_RCHDR("RUNDATE"),HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 ;
 ; divisions
 S Y="DIVISIONS: " I $D(VAUTD)=1 S Y=Y_"ALL",Y=$J("",80-$L(Y)\2)_Y,HCNT=HCNT+1,RCHDR(HCNT)=Y
 I $D(VAUTD)>1 D
 .N S,X S S=0 F  S S=$O(VAUTD(S)) Q:'S  D
 ..S X=VAUTD(S)_$S($O(VAUTD(S)):", ",1:"")
 ..I $L(X)+$L(Y)>80 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y,Y=$J(" ",12)
 ..S Y=Y_X
 .;
 .S:$TR(Y," ")]"" HCNT=HCNT+1,RCHDR(HCNT)=Y  ; any residual data
 ;
 ; Payers
 S Y="PAYERS: " I $D(RCPAY)=1 S Y=Y_RCPAY,Y=Y,HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 I $D(RCPAY)=10 D
 .N S,X S S=0 F  S S=$O(RCPAY(S)) Q:'S  D
 ..S X=RCPAY(S)_$S($O(RCPAY(S)):", ",1:"")
 ..I $L(X)+$L(Y)>80 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y,Y=$J(" ",8)
 ..S Y=Y_X
 .;
 .S:$TR(Y," ")]"" HCNT=HCNT+1,RCHDR(HCNT)=Y  ; any residual data
 ;
 S Y("1ST")=$P(RCDTRNG,U,2),Y("LST")=$P(RCDTRNG,U,3)
 F Y="1ST","LST" S Y(Y)=$$FMTE^XLFDT(Y(Y),"2Z")
 S Y="DATE RANGE: "_Y("1ST")_" - "_Y("LST")_" (ERA FILE DATE)"
 S CHATRI="" F J="CHAMPVA","TRICARE" S Y=Y_"    "_J_": "_$S($G(RCXCLUDE(J)):"NO",1:"YES")
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 ;
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 S Y="AGED"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="DAYS  TRACE #"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="          PAYMENT FROM/ID"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="                FILE DATE      AMOUNT PAID  EEOB CNT   ERA #           ERA DATE"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="",$P(Y,"=",80)="",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S RCHDR(0)=HCNT  ; total lines in header
 Q
 ;
HDRLM ; create the list manager version of the report header
 ; returns RCHDR
 ;   RCHDR(0) = header text line count
 ;INPUT:
 ; RCDTRNG - date range filter value to be printed as part of the header
 ; RCPAY - Payer filter value(s)
 ; RCLSTMGR
 ;
 N Z0 S Z0=""
 K RCHDR S RCPGNUM=0,RCSTOP=0
 N MSG,DATE,Y,DIV,HCNT
 S RCHDR(1)="DATE RANGE: "_$$FMTE^XLFDT($P(RCDTRNG,U,2),"2Z")_" - "_$$FMTE^XLFDT($P(RCDTRNG,U,3),"2Z")_" (ERA FILE DATE)"
 S RCHDR(1)=RCHDR(1)_"    TRICARE: "_$S($G(RCXCLUDE("TRICARE")):"NO",1:"YES")
 S RCHDR(1)=RCHDR(1)_"    CHAMPVA: "_$S($G(RCXCLUDE("CHAMPVA")):"NO",1:"YES")
 S HCNT=1
 ;
 S Y="DIVISIONS: " I $D(VAUTD)=1 S Y=Y_"ALL",HCNT=HCNT+1,RCHDR(HCNT)=Y
 I $D(VAUTD)>1 D
 .N S,X S S=0 F  S S=$O(VAUTD(S)) Q:'S  D
 ..S X=VAUTD(S)_$S($O(VAUTD(S)):", ",1:"")
 ..I $L(X)+$L(Y)>80 S HCNT=HCNT+1,RCHDR(HCNT)=Y,Y=$J(" ",12)
 ..S Y=Y_X
 .;
 .S:$TR(Y," ")]"" HCNT=HCNT+1,RCHDR(HCNT)=Y  ; any residual data
 ;
 ; Payers
 S Y="PAYERS: "
 I $D(RCPAY)=1 D 
 . S Y=Y_RCPAY,HCNT=HCNT+1,RCHDR(HCNT)=Y
 I $D(RCPAY)=10 D
 .N S,X S S=0 F  S S=$O(RCPAY(S)) Q:'S  D
 ..S X=RCPAY(S)_$S($O(RCPAY(S)):", ",1:"")
 ..I $L(X)+$L(Y)>80 S HCNT=HCNT+1,RCHDR(HCNT)=Y,Y=$J(" ",8)
 ..S Y=Y_X
 .;
 .S:$TR(Y," ")]"" HCNT=HCNT+1,RCHDR(HCNT)=Y  ; any residual data
 ;
 S Y="AGED"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="DAYS  TRACE #"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="          PAYMENT FROM/ID"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="                FILE DATE      AMOUNT PAID  EEOB CNT   ERA #           ERA DATE"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S RCHDR(0)=HCNT  ; total lines in header
 Q
 ; extrinsic variable, name for header PRCA*4.5*298
HDRNM() Q "ERA UNMATCHED AGING REPORT"
 ;
EXCEL ; Print report to screen, one record per line for export to MS Excel.
 N D,RCSF0,RC1ST,RCEXCEP,RCFLIEN,RCLN,RCSFIEN,RCZ,Z
 ; RCSFIEN - sub-file ien
 D HDRLST^RCDPEARL(.RCSTOP,.RCHDR)
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCERA_AGED",RCZ)) Q:RCZ=""  S RCFLIEN=0 F  S RCFLIEN=$O(^TMP($J,"RCERA_AGED",RCZ,RCFLIEN)) Q:'RCFLIEN  D  G:RCSTOP PRTQ2
 .I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPGNUM) W:RCTMPND="" !!,"***TASK STOPPED BY USER***" Q
 .S RC0=$G(^RCY(344.4,RCFLIEN,0))
 .S RCEXCEP=$$XCEPT^RCDPEWLP(RCFLIEN)  ; PRCA*4.5*298  assignment of ERA exception flag (will either be "" or "x")
 .S Z=$J(RCEXCEP_-RCZ,4)_U_$P(RC0,U,2)_U_$P(RC0,U,6)_"/"_$P(RC0,U,3)_U_$$FMTE^XLFDT($P(RC0,U,4),2)_U_$$FMTE^XLFDT($P(RC0,U,7),2)_U   ;PRCA*4.5*298 display ERA exception flag
 .S Z=Z_$P(RC0,U,5)_U_$P(RC0,U,11)_U_$P(RC0,U)
 .W !,Z
 .S RCLN=Z,RC1ST=0
 .K Z
 .I "23"[$$ADJ^RCDPEU(RCFLIEN) D LSTXCEL W "^** CLAIM LEVEL ADJUSTMENTS EXIST FOR THIS ERA ***"
 .I $O(^RCY(344.4,RCFLIEN,2,0)) D  ; ERA level adjustments exist
 ..N Q
 ..D DISPADJ^RCDPESR8(RCFLIEN,"^TMP("_$J_",""RCERA_ADJ"")")
 ..I $O(^TMP($J,"RCERA_ADJ",0)) D LSTXCEL W "^** GENERAL ADJUSTMENT DATA EXISTS FOR ERA **"
 ..S Q=0 F  S Q=$O(^TMP($J,"RCERA_ADJ",Q)) Q:'Q  D LSTXCEL W "^"_$G(^TMP($J,"RCERA_ADJ",Q))
 .;
 .S RCSFIEN=0 F  S RCSFIEN=$O(^RCY(344.4,RCFLIEN,1,RCSFIEN)) Q:'RCSFIEN  S RCSF0=$G(^(RCSFIEN,0)) D  Q:RCSTOP
 ..N D
 ..K RCOUT
 ..S D=" EEOB Seq #: "_$P(RCSF0,U)_$S($D(^RCY(344.4,RCFLIEN,1,"ATB",1,RCSFIEN)):" (REVERSAL)",1:"")_"  EEOB "
 ..S D=D_$S('$P(RCSF0,U,2):"not on file",1:"on file for "_$P($G(^DGCR(399,+$G(^IBM(361.1,+$P(RCSF0,U,2),0)),0)),U))_"  "_$J(+$P(RCSF0,U,3),"",2)
 ..D LSTXCEL W "^",D
 ..Q:$P(RCSF0,U,2)
 ..D DISP^RCDPESR0("^RCY(344.4,"_RCFLIEN_",1,"_RCSFIEN_",1)","RCDATA",1,"RCOUT",68,1)
 ..I '$O(RCOUT(0)) D LSTXCEL W "^NO DETAIL FOUND" Q
 ..S Z=0 F  S Z=$O(RCOUT(Z)) Q:'Z  D  Q:RCSTOP
 ...D LSTXCEL W "^*"_RCOUT(Z)
 ;
 W !!,$$ENDORPRT^RCDPEARL
 Q
 ;
LSTXCEL ; Display repeat info line before each EEOB detail section.
 ; First detail line does not need it
 I RC1ST W !,RCLN Q
 S RC1ST=1 Q
 ;
PRTQ2 I '$D(ZTQUEUED),'RCSTOP,RCPGNUM,RCTMPND="" D ASK^RCDPEARL(.RCSTOP)
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCEFT_AGED")
 Q
 ;
SELPAY(RCRESPYR,RCJOB,RCPAY) ;localize the payer filters for header display
 ; Input:
 ;   RCRESPYR (pass-by-val/required) - payer filter response indicator (2=ALL, 3=SPECIFIC)
 ;   RCJOB - job number to access the populated temporary global array in case report was tasked to run
 ; Output:
 ;   RCPAY (pass-by-ref/required) - local array of payers e.g. RCPAY="ALL", RCPAY(1)="Aetna",
 ;                                  or RCPAY="start payer = end payer"
 N CNT,I
 I RCRESPYR=2 S RCPAY="ALL" Q
 S:RCJOB="" RCJOB=$J   ; RCJOB should not be null
 I RCRESPYR=3 D  Q
 .S CNT=0
 .F  S CNT=$O(^TMP("RCSELPAY",RCJOB,CNT)) Q:'CNT  D
 ..S RCPAY(CNT)=^TMP("RCSELPAY",RCJOB,CNT)
 ; RCRESPYR indicates a range of payers
 S I=$O(^TMP("RCSELPAY",RCJOB,"")),RCPAY=^(I)_" - "
 S I=$O(^TMP("RCSELPAY",RCJOB,""),-1),RCPAY=RCPAY_^(I)
 Q
 ;
ZROBAL() ; function, Get Zero Payment Filter
 ; returns 1 for yes, zero for no, -1 on '^' or timeout
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YA",DIR("A")="Include Zero payment amounts? (Y/N): ",DIR("B")="YES"
 D ^DIR
 I $D(DUOUT)!$D(DIRUT)!$D(DTOUT) S Y=-1
 Q Y
 ;
RLOAD(FILE) ; PRCA*4.5*284 - Load Payer temp global AFTER queued job starts
 ; Load Selected payers from local array end exit
 I +RCRESPYR=3 M ^TMP("RCSELPAY",$J)=RCPYRLST Q
 N CNT,INDX,NUM,RCINSF,RCINST,RCPAY
 ;
 ; Load ALL payers and exit
 I +RCRESPYR=2 D  Q
 .S CNT=0,RCPAY="" F  S RCPAY=$O(^RCY(FILE,"C",RCPAY)) Q:RCPAY=""  S CNT=CNT+1,^TMP("RCSELPAY",$J,CNT)=RCPAY
 ;
 ; Range of Payers
 ; Build list of available stations
 K ^TMP("RCPAYER",$J)  ; Clear residual list data
 S CNT=0,RCPAY=""
 F  S RCPAY=$O(^RCY(FILE,"C",RCPAY)) Q:RCPAY=""  S CNT=CNT+1,^TMP("RCPAYER",$J,CNT)=RCPAY,^TMP("RCPAYER",$J,"B",RCPAY,CNT)=""
 ;
 S RCINSF=$P(RCRESPYR,"^",2),RCINST=$P(RCRESPYR,"^",3),INDX=1
 F  S RCINSF=$O(^TMP("RCPAYER",$J,"B",RCINSF)) Q:RCINSF=""  Q:RCINSF]RCINST  D
 .S NUM=$O(^TMP("RCPAYER",$J,"B",RCINSF,""))
 .S ^TMP("RCSELPAY",$J,INDX)=$G(^TMP("RCPAYER",$J,NUM)),INDX=INDX+1
 Q
 ;
