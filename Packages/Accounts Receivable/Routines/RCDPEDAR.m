RCDPEDAR ;ALB/TMK - ACTIVITY REPORT ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,276,284,283,298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
RPT ; Daily Activity Rpt On Demand
 N RCDET,RCDIV,RCDT1,RCDT2,RCHDR,RCINC,RCLSTMGR,RCNJ,RCNP,RCPG,RCPYRSEL,RCRANGE,RCTMPND,VAUTD,X,Y
 ; RCDT1 - date range start
 ; RCDT2 - date range end
 ; RCNP - payer selection
 ; RCPYRSEL - payer selection, used for tasked job to store ^TMP("RCSELPAY",$J)
 ; RCTMPND - storage node
 ;
 S RCNJ=0  ; not the nightly job, user interactions
 ; Get division/station
 D DIVISION^VAUTOMA  ; sets VAUTD
 I 'VAUTD&($D(VAUTD)'=11) G RPTQ
 N DIR,DTOUT,DUOUT
 S DIR("A")="(S)UMMARY OR (D)ETAIL?: ",DIR(0)="SA^S:SUMMARY TOTALS ONLY;D:DETAIL AND TOTALS"
 S DIR("B")="D" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G RPTQ
 S RCDET=(Y="D")
 K DIR
 S DIR("?")="ENTER THE EARLIEST DATE OF RECEIPT OF DEPOSIT TO INCLUDE ON THE REPORT"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="START DATE: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G RPTQ
 S RCDT1=Y
 K DIR
 S DIR("?")="ENTER THE LATEST DATE OF RECEIPT OF DEPOSIT TO INCLUDE ON THE REPORT"
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_RCDT1_":"_DT_":APE",DIR("A")="END DATE: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G RPTQ
 S RCDT2=Y
 ;Get insurance company to be used as filter
 ; PRCA*4.5*284 - RCNP is Type of Response (1=Range,2=All,3=Specific) ^ From Range^ Thru Range
 S RCNP=$$GETPAY^RCDPEM9(344.31) I +RCNP=-1 G RPTQ
 ;
 ; PRCA*4.5*298 - Add List Manager Prompts
 S RCLSTMGR=$$ASKLM^RCDPEARL I RCLSTMGR<0 G RPTQ  ; '^' or timeout
 ;
 I RCLSTMGR=1 D  G RPTQ  ; ListMan format, put in array
 .S RCTMPND="RCDPE_DAR"
 .K ^TMP($J,RCTMPND)
 .N RCCT,RCNJ,RCPG
 .S RCNJ=1,RCPG=1,RCCT=0
 .D EN(RCDET,RCDT1,RCDT2)
 .D LMHDR(.RCSTOP,RCDET,1)
 .D LMRPT^RCDPEARL(.RCHDR,$NA(^TMP($J,RCTMPND))) ; generate ListMan display
 .I $D(RCTMPND) K ^TMP($J,RCTMPND)
 ;
 ; Ask device
 N %ZIS,POP S %ZIS="QM" D ^%ZIS G:POP RPTQ
 I $D(IO("Q")) D  G RPTQ
 .N ZTDSC,ZTRTN,ZTSK
 .S ZTRTN="EN^RCDPEDAR("_RCDET_","_RCDT1_","_RCDT2_")",ZTDESC="AR - EDI LOCKBOX EFT DAILY ACTIVITY REPORT"
 .S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 .; PRCA*4.5*284 - Because TMP global may be on another server, save off specific payers in local
 .M RCPYRSEL=^TMP("RCSELPAY",$J)
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"Task number "_ZTSK_" was queued.",1:"Unable to queue this task.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO D EN(RCDET,RCDT1,RCDT2)
 ;
RPTQ ;
 Q
 ;
EN(RCDET,RCDT1,RCDT2) ; Entry point for report, might be queued
 ; RCDET = 1 to include detail, 0 for totals only
 ; RCDT1, RCDT2 = date from, to
 N DATA,RC,RCFLG,RCIEN,RCJOB,RCPG,RCSTOP,RCT,STATION,Z,Z0
 ;
 I $G(ZTSK) N ZTSTOP  ; job was tasked, ZTSTOP = flag to stop
 ; PRCA*4.5*284 - Queued job needs to reload payer selection list
 I $D(RCPYRSEL) D
 .K ^TMP("RCSELPAY",$J) M ^TMP("RCSELPAY",$J)=RCPYRSEL
 ;
 S RCNP=+RCNP,RCJOB=$J
 K ^TMP("RCDAILYACT",$J)
 S Z=RCDT1-.0001,(RCSTOP,RCT)=0
 F  S Z=$O(^RCY(344.3,"ARECDT",Z)) Q:'Z!(Z>(RCDT2_".9999"))!RCSTOP  D
 .S Z0=0 F  S Z0=$O(^RCY(344.3,"ARECDT",Z,Z0)) Q:'Z0!RCSTOP  D
 ..S DATA=$G(^RCY(344.3,Z0,0)),RCFLG=0
 ..S RCIEN="" F  S RCIEN=$O(^RCY(344.31,"B",Z0,RCIEN)) Q:RCIEN=""  D
 ...I '$$CHKPYR(RCIEN,0,RCJOB) Q  ; check payer
 ...I '$$CHKDIV(RCIEN,0,.VAUTD) Q  ; check station/division
 ...S RCFLG=1,^TMP("RCDAILYACT",$J,Z\1,Z0,"EFT",RCIEN)=""
 ..;
 ..I RCFLG S ^TMP("RCDAILYACT",$J,Z\1,Z0)=DATA
 ..S RCT=RCT+1 I '(RCT#100),$D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ Q  ; Check for user stopped every 100 records
 ;
 D:'RCSTOP RPT1(RCNJ,RCDET,RCDT1,RCDT2,.RCSTOP,.RCPG)
 D ENQ(RCSTOP,$G(RCPG))
 Q
 ;
RPT1(RCNJ,RCDET,RCDT1,RCDT2,RCSTOP,RCPG) ; Entry point for report
 ; RCNJ - 1 if called by nightly job, 0 if called on demand
 ; RCDET - 1 to include detail, 0 for totals only
 ; RCDT1, RCDT2 - date from, to
 ; RCSTOP - stop flag, 1 if user elected to quit job
 ; RCPG - page #, returned if passed by reference
 ;
 N X,Q,Q0,Z,Z0,Z1,Z2,Z3,ZCT,RCCT,RCDEP,RCDEPA,RCDEPAP,RCFMS,RCFMS1,RCD1,RCFMSTOT,RCEFT,RCMATCH,RCDEPREC,RCDT
 N D,DIC,I,RCIEN,RCPAY
 ;
 ; RCCT - line counter
 S (RCCT,RCDEP,RCDEPA,RCDEPAP,RCDEPREC,RCPG,RCSTOP,Z,ZCT)=0,RCD1=1
 S RCNJ=+$G(RCNJ)
 F  S Z=$O(^TMP("RCDAILYACT",$J,Z)) Q:'Z  D  G:RCSTOP RPT1Q ; Z = date
 .I '$G(RCLSTMGR),'RCPG!$S('$G(RCNJ):($Y+5)>IOSL,1:0) D:'$G(RCLSTMGR) HDR(.RCSTOP,RCDET,RCNJ) S RCDT=1 Q:RCSTOP
 .S Q="DATE EFT DEPOSIT RECEIVED: "_$$FMTE^XLFDT(Z,2),Q=$J("",80-$L(Q)\2)_Q ; Center it
 .I 'RCD1,$G(RCDET) D SL(" ") ; Skip line if >1 dt on pg
 .S RCDT=0
 .D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .I $G(RCDET) D
 ..D SL(Q)
 ..D SL(" ")
 .; Z0 = ien of entry in file 344.3
 .K RCEFT("D"),RCMATCH("D"),RCFMS("D")
 .S Z0=0 F  S Z0=$O(^TMP("RCDAILYACT",$J,Z,Z0)) Q:'Z0  D  Q:RCSTOP
 ..S Z1=$G(^TMP("RCDAILYACT",$J,Z,Z0))
 ..S RCDEPREC=+$O(^RCY(344,"AD",+$P(Z1,U,3),0)),RCDEP(Z)=$G(RCDEP(Z))+1,RCDEPA(Z)=$G(RCDEPA(Z))+$P(Z1,U,8)
 ..I $P($G(^RCY(344,RCDEPREC,2)),U)="" S RCFMS("D",-1)=$G(RCFMS("D",-1))+$P(Z1,U,8),RCFMS="NO FMS DOC"
 ..I $P($G(^RCY(344,RCDEPREC,2)),U)'="" D
 ...S X=$$STATUS^GECSSGET($P(^RCY(344,RCDEPREC,2),U))
 ...I X=-1 S RCFMS("D",-1)=$G(RCFMS("D",-1))+$P(Z1,U,8) Q
 ...S RCFMS=$E($P(X," "),1,10),Q=$E(X),Q=$S(Q="E"!(Q="R"):0,Q="Q":2,1:1),RCFMS("D",Q)=$G(RCFMS("D",Q))+$P(Z1,U,8)
 ...;
 ..I $G(RCDET) D  Q:RCSTOP
 ...; PRCA*4.5*283 - change length of DEP # from 6 to 9 to allow for 9 digit DEP #'s
 ...S X=$$SETSTR^VALM1($P(Z1,U,6),"",1,9)
 ...; Change DEPOSIT DT's starting position from 9 to 12
 ...S X=$$SETSTR^VALM1($$FMTE^XLFDT($P(Z1,U,7)\1,2),X,12,10)
 ...; Change starting position from 21 to 23 & reduce length of spaces from 10 to 8.
 ...S X=$$SETSTR^VALM1("",X,23,8)
 ...S X=$$SETSTR^VALM1("",X,32,10)
 ...S X=$$SETSTR^VALM1($E($J($P(Z1,U,8),"",2)_$J("",20),1,20)_RCFMS,X,43,37)
 ...D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 ...D SL(X)
 ..S RCFMSTOT=0,RCFMS1="NO FMS DOC"
 ..I $O(^RCY(344.3,Z0,2,0)) D  Q:RCSTOP
 ...N V
 ...D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 ...D SL($J("",10)_"ERROR MESSAGES FOR EFT:")
 ...S V=0 F  S V=$O(^RCY(344.3,Z0,2,V)) Q:'V  D  Q:RCSTOP
 ....D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 ....D SL($J("",12)_$G(^RCY(344.3,Z0,2,V,0)))
 ..S Z2=0 F  S Z2=$O(^TMP("RCDAILYACT",$J,Z,Z0,"EFT",Z2)) Q:'Z2  S Z3=$G(^RCY(344.31,Z2,0)) D  Q:RCSTOP
 ...S RCEFT("D")=$G(RCEFT("D"))+1
 ...S X=$S($P($G(^RCY(344,+$P(Z3,U,9),2)),U)'="":$$STATUS^GECSSGET($P(^RCY(344,+$P(Z3,U,9),2),U)),1:"")
 ...I X'="",X'=-1,$E(X)'="R",$E(X)'="E" S RCFMSTOT=RCFMSTOT+$P(Z3,U,7),RCFMS1=$S($E(X)="Q":"QUEUED TO POST",1:"POSTED")
 ...S RCFMS1(Z2)=$S(X="":"",X=-1:"NO FMS DOC",1:$E($P(X," "),1,10))
 ...I $P(Z3,U,8) S RCMATCH("D")=$G(RCMATCH("D"))+1
 ...I $G(RCDET) D EFTDTL(Z2,Z3,.RCSTOP,RCDET,.RCFMS1,RCNJ) Q:RCSTOP
 ..;
 ..Q:RCSTOP
 ..I RCDET D SL(" ")
 .;
 .Q:RCSTOP
 .S RCDEPA=RCDEPA+$G(RCDEPA(Z)),RCDEP=RCDEP+$G(RCDEP(Z)),RCDEPAP=RCDEPAP+$G(RCDEPAP(Z)),RCFMSTOT("D")=$G(RCFMSTOT("D"))+$G(RCFMSTOT),RCEFT("T")=$G(RCEFT("T"))+$G(RCEFT("D")),RCMATCH("T")=$G(RCMATCH("T"))+$G(RCMATCH("D"))
 .F Q=-1,0,1,2 S RCFMS("T",Q)=$G(RCFMS("T",Q))+$G(RCFMS("D",Q))
 .D SL(" ")
 .I $S('$G(RCNJ):($Y+5)>IOSL,1:0)!'RCPG D:'$G(RCLSTMGR) HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .D SL($E("**TOTALS FOR DATE: "_$$FMTE^XLFDT(Z\1,2)_$J("",30),1,30)_"   # OF DEPOSIT TICKETS RECEIVED: "_+$G(RCDEP(Z))_$J("",5))
 .D SL($J("",29)_"TOTAL AMOUNT OF DEPOSITS RECEIVED: $"_$J(+$G(RCDEPA(Z)),"",2))
 .D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .D SL(" ")
 .D SL($J("",20)_"DEPOSIT AMOUNTS SENT TO FMS:")
 .D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .D SL($J("",39)_"ACCEPTED: $"_$J(+$G(RCFMS("D",1)),"",2))
 .D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .D SL($J("",41)_"QUEUED: $"_$J(+$G(RCFMS("D",2)),"",2))
 .D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .D SL($J("",35)_"ERROR/REJECT: $"_$J(+$G(RCFMS("D",0)),"",2))
 .D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .D SL($J("",37)_"NOT IN FMS: $"_$J(+$G(RCFMS("D",-1)),"",2))
 .D SL(" ")
 .D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .D SL($J("",26)_"# EFT PAYMENT RECORDS: "_(+$G(RCEFT("D"))))
 .D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .D SL($J("",25)_"# EFT PAYMENTS MATCHED: "_+($G(RCMATCH("D"))))
 .D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .D SL($J("",18)_"MATCHED PAYMENT AMOUNT POSTED: $"_$J(+$G(RCDEPAP(Z)),"",2))
 .D SL(" ")
 ;
 I '$O(^TMP("RCDAILYACT",$J,0)) D:'$G(RCLSTMGR) HDR(.RCSTOP,RCDET,RCNJ)
 G:RCSTOP!(RCNJ&(+$G(RCLSTMGR)=0)) RPT1Q
 D SL(" ")
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) G:RCSTOP RPT1Q
 D SL($E("**** TOTALS FOR DATE RANGE:"_$J("",30),1,30)_"   # OF DEPOSIT TICKETS RECEIVED: "_+$G(RCDEP)_$J("",5))
 D SL($J("",29)_"TOTAL AMOUNT OF DEPOSITS RECEIVED: $"_$J(+$G(RCDEPA),"",2))
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) G:RCSTOP RPT1Q
 D SL(" ")
 D SL($J("",20)_"DEPOSIT AMOUNTS SENT TO FMS:")
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) G:RCSTOP RPT1Q
 D SL($J("",39)_"ACCEPTED: $"_$J(+$G(RCFMS("T",1)),"",2))
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) G:RCSTOP RPT1Q
 D SL($J("",41)_"QUEUED: $"_$J(+$G(RCFMS("T",2)),"",2))
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) G:RCSTOP RPT1Q
 D SL($J("",35)_"ERROR/REJECT: $"_$J(+$G(RCFMS("T",0)),"",2))
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) G:RCSTOP RPT1Q
 D SL($J("",37)_"NOT IN FMS: $"_$J(+$G(RCFMS("T",-1)),"",2))
 D SL(" ")
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) G:RCSTOP RPT1Q
 D SL($J("",26)_"# EFT PAYMENT RECORDS: "_+$G(RCEFT("T")))
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) G:RCSTOP RPT1Q
 D SL($J("",25)_"# EFT PAYMENTS MATCHED: "_+$G(RCMATCH("T")))
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) G:RCSTOP RPT1Q
 D SL($J("",18)_"MATCHED PAYMENT AMOUNT POSTED: $"_$J(+$G(RCDEPAP),"",2))
 D SL(" ")
 ;
 D SL(" ")
 D SL($$ENDORPRT^RCDPEARL)
 ;
PC() ; boolean function, page check
 I '$G(RCLSTMGR),$G(RCNJ),$Y+5>IOSL Q 1
 Q 0
 ;
RPT1Q ; exit point
 K ^TMP("RCDAILYACT",$J)
 Q
 ;
ENQ(RCSTOP,RCPG) ; Clean up
 I '$D(ZTQUEUED) D ^%ZISC I 'RCNJ,'RCSTOP,RCPG S X="" D ASK^RCDPEARL(.X)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
SL(Z) ; Writes or stores line
 ; RCNJ and RCCT set before calling
 ; RCNJ = 1 to set array,  0 to write line
 ; Z = text to handle
 ; RCCT = line counter
 S RCCT=RCCT+1
 I $G(RCNJ) S ^TMP($J,"RCDPE_DAR",RCCT)=Z Q
 W !,Z
 Q
 ;
CHKPYR(IEN,FLG,RCJOB) ; function
 ; IEN - ien in file 344.31 or 344.4
 ; FLG - 0 if IEN contains ien in file 344.31, 1 if IEN contains ien in file 344.4
 ; RCJOB - $J
 ; returns 1 if payer in 344.31/.02 or 344.4/.06 is in the list of selected payers ^TMP("RCSELPAY",$J)
 ; returns 0 otherwise
 ;
 N RCPAY,RES,Z
 S RES=0  ; result
 S RCPAY="" I IEN S RCPAY=$S(FLG:$P($G(^RCY(344.4,IEN,0)),U,6),1:$P($G(^RCY(344.31,IEN,0)),U,2))
 I RCPAY'="" S (RCFLG,Z)=0 D
 .F  S Z=$O(^TMP("RCSELPAY",RCJOB,Z)) Q:Z=""  I $E(RCPAY,1,30)=$G(^TMP("RCSELPAY",RCJOB,Z)) S RES=1 Q
 ;Include EFT with null Payer Names in reports for ALL payers - PRCA*4.5*298 
 I FLG=0,$G(RCNP)=2,RCPAY="" S RES=1 ; PRCA*4.5*298
 Q RES
 ;
CHKDIV(IEN,FLG,VAUTD) ;
 ; IEN - ien in file 344.31 or 344.4
 ; FLG - 0 if IEN contains ien in file 344.31, 1 if IEN contains ien in file 344.4
 ; VAUTD - array of selected divisions from DIVISION^VAUTOMA API call
 ; returns 1 if division associated with an entry in 344.31 is on the list in VAUTD
 ; returns 0 otherwise
 N ERA,I,NAME,RCSTA,RES
 S RES=0
 I VAUTD=1 S RES=1 G CHKDIVX
 I 'IEN G CHKDIVX
 S ERA=$S(FLG:IEN,1:$P($G(^RCY(344.31,IEN,0)),U,10))
 S RCSTA=$$ERASTA^RCDPEM3(ERA),NAME=$P(RCSTA,U)
 I NAME="UNKNOWN" G CHKDIVX
 S I=0 I 'VAUTD F  S I=$O(VAUTD(I)) Q:'I!RES  I NAME=VAUTD(I) S RES=1
CHKDIVX ;
 Q RES
 ;
HDR(RCSTOP,RCDET,RCNJ) ;Prints report heading
 ; RCSTOP - flag to stop
 ; variables RCCT,RCPG,RCDT1,RCDT2 set before calling this subroutine
 ; RCCT - line count
 ; RCPG - page number
 ; RCDT1, RCDT2 - from, to date
 ; RCDET - flag is 1 if detail is desired
 N Z,Z0,Z1,X,Y
 Q:RCNJ&(RCPG)
 I RCPG!($E(IOST,1,2)="C-") D
 .Q:$G(RCNJ)
 .I RCPG&($E(IOST,1,2)="C-") D ASK(.RCSTOP) Q:RCSTOP
 .W @IOF ; Write form feed
 Q:RCSTOP
 S RCPG=RCPG+1
 I '$D(RCNP) N RCNP S RCNP=2  ; PRCA276 if coming from nightly job need to define payer selection variable
 I '$D(VAUTD) N VAUTD S VAUTD=1  ; PRCA276 if coming from nightly job need to define division selection variable
 S Z0="EDI LOCKBOX EFT DAILY ACTIVITY "_$S($G(RCDET):"DETAIL",1:"SUMMARY")_" REPORT"
 S Z=$$SETSTR^VALM1($J("",80-$L(Z0)\2)_Z0,"",1,79)
 S Z=$$SETSTR^VALM1("Page: "_RCPG,Z,70,10)
 D SL(Z)
 S Z="RUN DATE: "_$$FMTE^XLFDT($$NOW^XLFDT(),2),Z=$J("",80-$L(Z)\2)_Z
 D SL(Z)
 ;prca276 add divisions to header
 S Z1="" I 'VAUTD S Z0=0 F  S Z0=$O(VAUTD(Z0)) Q:'Z0  S Z1=Z1_VAUTD(Z0)_", "
 S Z="DIVISIONS: "_$S(VAUTD:"ALL",1:$E(Z1,1,$L(Z1)-2)),Z=$J("",80-$L(Z)\2)_Z
 D SL(Z)
 ; prca 276 add payer selection list to header
 S Z1="" I RCNP'=2 S Z0=0 F  S Z0=$O(^TMP("RCSELPAY",$J,Z0)) Q:'Z0  S Z1=Z1_^TMP("RCSELPAY",$J,Z0)_", "
 S Z="PAYERS: "_$S(RCNP=2:"ALL",1:$E(Z1,1,$L(Z1)-2)),Z=$J("",80-$L(Z)\2)_Z
 D SL(Z)
 ;prca 276  add date filter to header
 S Z="DATE RANGE: "_$$FMTE^XLFDT(RCDT1,2)_" - "_$$FMTE^XLFDT(RCDT2,2)_" (Date Deposit Added)",Z=$J("",80-$L(Z)\2)_Z
 D SL(Z)
 I $G(RCDET) D
 .; PRCA*4.5*283 - Add 3 more spaces between DEP # and DEPOSIT DT 
 .; and remove 3 spaces between DEPOSIT DT and DEP AMOUNT to allow for 9 digit DEP #'s
 .D SL("")
 .S Z=$$SETSTR^VALM1("DEP #      DEPOSIT DT  "_$J("",19)_"DEP AMOUNT          FMS DEPOSIT STAT","",1,80)
 .D SL(Z)
 .; PRCA*4.5*284, Move Match Status to left 3 space to allow for 10 digit ERA #'s
 .S Z=$$SETSTR^VALM1($J("",3)_"EFT #"_$J("",23)_"DATE PD   PAYMENT AMOUNT  ERA MATCH STATUS","",1,80)
 .D SL(Z)
 .S Z=$$SETSTR^VALM1($J("",10)_"EFT PAYER TRACE #","",1,30)
 .D SL(Z)
 .S Z=$$SETSTR^VALM1($J("",14)_"PAYMENT FROM","",1,30)
 .D SL(Z)
 .S Z=$$SETSTR^VALM1($J("",45)_"DEP RECEIPT #","",1,60)
 .S Z=$$SETSTR^VALM1("DEP RECEIPT STATUS",Z,61,19)
 .D SL(Z)
 ;
 D SL($TR($J("",IOM-1)," ","="))
 Q
 ;
ASK(RCSTOP) ; Ask to continue
 ; If passed by reference ,RCSTOP is returned as 1 if print is aborted
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S RCSTOP=1 Q
 Q
 ;
LMHDR(RCSTOP,RCDET,RCNJ) ; ListMan report heading
 ; RCSTOP - stop flag, passed by reference
 ;  > RCSTOP must be passed by reference
 ; RCDET = flag is 1 if detail is desired
 ;
 ; RCCT = line counter
 ; RCPG = page #
 ; RCDT1, RCDT2 = from, to date
 N Z,Z0,Z1,X,Y
 S RCPG=RCPG+1
 S RCHDR("TITLE")="EDI LOCKBOX EFT DAILY ACTIVITY "_$S($G(RCDET):"DETAIL",1:"SUMMARY")_" REPORT"
 S Z1="" I 'VAUTD S Z0=0 F  S Z0=$O(VAUTD(Z0)) Q:'Z0  S Z1=Z1_VAUTD(Z0)_", "
 S Z="DIVISIONS: "_$S(VAUTD:"ALL",1:$E(Z1,1,$L(Z1)-2))
 D:'$G(RCDET) ADLM("")
 D ADLM(Z)
 ; prca 276 add payer selection list to header
 S Z1="" I RCNP'=2 S Z0=0 F  S Z0=$O(^TMP("RCSELPAY",$J,Z0)) Q:'Z0  S Z1=Z1_^TMP("RCSELPAY",$J,Z0)_", "
 S Z="PAYERS: "_$S(RCNP=2:"ALL",1:$E(Z1,1,$L(Z1)-2))
 D:'$G(RCDET) ADLM("")
 D ADLM(Z)
 S Z="DATE RANGE: "_$$FMTE^XLFDT(RCDT1,2)_" - "_$$FMTE^XLFDT(RCDT2,2)_" (Date Deposit Added)"
 D:'$G(RCDET) ADLM("")
 D ADLM(Z)
 I $G(RCDET) D
 .S Z=$$SETSTR^VALM1("DEP #      DEPOSIT DT  "_$J("",19)_"DEP AMOUNT          FMS DEPOSIT STAT","",1,80)
 .D ADLM(Z)
 .S Z=$$SETSTR^VALM1($J("",3)_"EFT #"_$J("",23)_"DATE PD   PAYMENT AMOUNT  ERA MATCH STATUS","",1,80)
 .D ADLM(Z)
 .S Z=$$SETSTR^VALM1($J("",10)_"EFT PAYER TRACE #","",1,30)
 .D ADLM(Z)
 .S Z=$$SETSTR^VALM1($J("",14)_"PAYMENT FROM","",1,30)
 .S Z=$$SETSTR^VALM1($J("",15)_"DEP RECEIPT #",Z,31,30)
 .S Z=$$SETSTR^VALM1("DEP RECEIPT STATUS",Z,61,19)
 .D ADLM(Z)
 ;
 Q
 ;
ADLM(Z) ; add to ListMan header
 S RCCT=RCCT+1,RCHDR(RCCT)=Z Q
 ;
EFTDTL(Z2,Z3,RCSTOP,RCDET,RCFMS1,RCNJ) ; Display EFT Detail
 N DATA,X
 S X=$$SETSTR^VALM1($P(Z3,U),"",4,6)
 S X=$$SETSTR^VALM1($$FMTE^XLFDT($P(Z3,U,12)\1,2),X,32,8)
 S X=$$SETSTR^VALM1($J($P(Z3,U,7),"",2),X,42,18)
 ; PRCA*4.5*284, Move to left 3 space (61 to 58) to allow for 10 digit ERA #'s
 S X=$$SETSTR^VALM1($$EXTERNAL^DILFD(344.31,.08,"",+$P(Z3,U,8))_$S($P(Z3,U,8)=1:"/ERA #"_$P(Z3,U,10),1:""),X,58,20)
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 D SL(X)
 S X=$$SETSTR^VALM1($P(Z3,U,4),"",11,61)
 D SL(X)
 N RCPAY S RCPAY=$P(Z3,U,2),RCPAY=$S(RCPAY="":"NO PAYER NAME RECEIVED",1:RCPAY) ; PRCA*4.5*298
 S X=$$SETSTR^VALM1(RCPAY_"/"_$P(Z3,U,3),"",15,65) ; PRCA*4.5*298
 D SL(X)
 S X=""
 I $P(Z3,U,9) S X=$$SETSTR^VALM1($P($G(^RCY(344,+$P(Z3,U,9),0)),U),X,46,10)
 S X=$$SETSTR^VALM1($G(RCFMS1(Z2)),X,61,19)
 D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 D SL(X)
 I $O(^RCY(344.31,Z2,2,0)) D  Q:RCSTOP
 . N V
 . D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 . D SL($J("",10)_"ERROR MESSAGES FOR EFT DETAIL:")
 . S V=0 F  S V=$O(^RCY(344.31,Z2,2,V)) Q:'V  D  Q:RCSTOP
 .. D:$$PC HDR(.RCSTOP,RCDET,RCNJ) Q:RCSTOP
 .. D SL($J("",12)_$G(^RCY(344.31,Z2,2,V,0)))
 I $D(^RCY(344.31,Z2,3)) D
 .S DATA=$G(^RCY(344.31,Z2,3))
 .S X="   MARKED AS DUPLICATE: "_$$FMTE^XLFDT($P(DATA,U,2),5)_" "_$$EXTERNAL^DILFD(344.31,.17,,$P(DATA,U))
 .D SL(X)
 .D SL(" ")
 ;
 Q
 ;
