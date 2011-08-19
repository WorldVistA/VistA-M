IBAGMR1 ;WOIFO/AAT-GMT SINGLE PATIENT REPORT;12-JUL-02
 ;;2.0;INTEGRATED BILLING;**183**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 Q
 ;
 ; Prints report to the current device
 ;
 ; Input:
 ;   IBDFN - Patient IEN
 ;   IBBDT - Beginning date
 ;   IBEDT - Ending date
 ; Output:
 ;   IBQUIT = 1, if user entered "^" (Devices starting with "C-" only)
REPORT ;
 N IBDT,IBDTE,IBDTH,IBCR,IBDA,IBAT,IBTMP,IBZ,IBCL,IBDTBF,IBDTBT
 S IBQUIT=0
 S IBTMP=$NA(^TMP($J,"IBAGMR")) ; The node of TMP array
 K @IBTMP
 ;
 ; Marking beginning and ending of each clock within the range.
 S IBDT="" F  D  Q:'IBDT  Q:(-IBDT)<IBBDT
 . S IBDT=$O(^IBE(351,"AIVDT",IBDFN,IBDT)) Q:'IBDT
 . S IBCL=0 F  D  Q:'IBCL
 .. S IBCL=$O(^IBE(351,"AIVDT",IBDFN,IBDT,IBCL)) Q:'IBCL
 .. S IBZ=$G(^IBE(351,IBCL,0)) Q:IBZ=""
 .. I $P(IBZ,U,4)=3 Q  ; Status - CANCELLED
 .. I (-IBDT)'<IBBDT,(-IBDT)'>IBEDT S @IBTMP@(-IBDT,"C")=IBCL ; Mark the beginning of the clock
 .. ;S IBDTE=$P(+$P(IBZ,U,10),".") ;Expiration date
 .. ;I IBDTE,IBDTE'<IBBDT,IBDTE'>IBEDT S @IBTMP@(IBDTE,"E")=IBCL ; Mark the ending of the clock
 ;
 ; Get the charges from file #350.
 ; IBDT here - Parent Event Date
 S IBDT=-(IBEDT+.00001) F  S IBDT=$O(^IB("AFDT",IBDFN,IBDT)) Q:'IBDT  D
 . S IBCR=0 F  S IBCR=$O(^IB("AFDT",IBDFN,IBDT,IBCR)) Q:'IBCR  D
 .. S IBDA=0 F  S IBDA=$O(^IB("AF",IBCR,IBDA)) Q:'IBDA  D
 ... S IBZ=$G(^IB(IBDA,0)) I 'IBZ Q
 ... Q:$P(IBZ,U,8)["ADMISSION"
 ... ; Bill 'To' and 'From' dates
 ... S IBDTBF=$P(IBZ,U,14),IBDTBT=$P(IBZ,U,15) S:IBDTBT="" IBDTBT=IBDTBF
 ... I IBDTBT<IBBDT Q
 ... I IBDTBF>IBEDT Q
 ... S IBAT=$P(IBZ,U,3) Q:'IBAT  ; Action type is really required
 ... I $$ACTNM^IBOUTL(IBAT)["LTC " Q  ; Exclude LTC action type
 ... S @IBTMP@(+$P(IBZ,U,14),"I"_IBDA)=IBZ
 ;
 D PRINT
 K @IBTMP ; Kill the temporary global node
 S:$D(ZTQUEUED) ZTREQ="@" ; for Taskman
 Q
 ;
PRINT ; Print report from the temp. global
 N IBLINE,IBPAG,IBTOT,IBTOTS,IBPT,IBH,IBD,IBTY,IBDA,IBZ,IBCHG,IBSAV,IBSEQ,IBGMT,X,X2,X3,Y,%,IBCIS
 D NOW^%DTC S IBDTH=$$FMTE^XLFDT($E(%,1,12))
 S IBLINE="",$P(IBLINE,"=",IOM+1)="",(IBPAG,IBTOT,IBTOTS,IBQUIT,IBCHG)=0
 S IBPT=$$PT^IBEFUNC(IBDFN)
 S IBCIS=0
 S IBH="GMT Single Patient Report for "_$P(IBPT,U)_"  "_$P(IBPT,U,2) D HDR
 I '$D(@IBTMP) W !!,"The patient has no MT/GMT bills within the specified period" D PAUSE(1) Q
 ; - first, print detail lines
 S IBD="" F  S IBD=$O(@IBTMP@(IBD)) Q:'IBD  D  Q:IBQUIT
 . S IBTY="" F  S IBTY=$O(@IBTMP@(IBD,IBTY)) Q:IBTY=""  D  Q:IBQUIT
 ..  D CHKSTOP Q:IBQUIT
 ..  I IBTY="C" W !,$$DAT(IBD),?10,"Begin Means Test Billing Clock" K @IBTMP@(IBD,"E") Q
 ..  I IBTY="E" W !,$$DAT(IBD),?10,"Expire Means Test Billing Clock" Q
 ..  W !,$$DAT(IBD)
 ..  S IBDA=+$E(IBTY,2,99),IBZ=$G(^IB(IBDA,0)),IBSEQ=0
 ..  S IBAT=+$P(IBZ,U,3)
 ..  I $P(IBZ,U,14)'=$P(IBZ,U,15) W ?10,$$DAT($P(IBZ,U,15))
 ..  S IBSEQ=$P($G(^IBE(350.1,+$P(IBZ,U,3),0)),U,5)
 ..  W ?20,$E($$ACTNM^IBOUTL(+$P(IBZ,U,3)),1,25)
 ..  W ?46,$$STAT()
 ..  S IBCHG=+$P(IBZ,U,7)
 ..  S IBGMT=$P(IBZ,U,21)
 ..  I IBSEQ=2 S IBCHG=-IBCHG I 'IBGMT S IBGMT=$P($G(^IB(+$P(IBZ,U,9),0)),U,21)
 ..  ; The Charge provide GMT Savings if it has GMT RELATED field set to "1"
 ..  S IBSAV=$S(IBGMT:IBCHG*4,1:0) ;GMT Savings
 ..  I $P(IBZ,U,11)="",$P($G(^IBE(350.21,+$P(IBZ,U,5),0)),U,5) S (IBCHG,IBSAV)=0
 ..  W ?56,$$FORMAT(IBCHG,10) W:IBSAV ?68,$$FORMAT(IBSAV,10)
 ..  S IBTOT=IBTOT+IBCHG ; Total
 ..  S IBTOTS=IBTOTS+IBSAV ; Savings total
 ..  I IBSEQ=2!($P(IBZ,U,11)=""&($P($G(^IBE(350.21,+$P(IBZ,U,5),0)),U,5))) W !?5,"Charge Removal Reason: ",$S($D(^IBE(350.3,+$P(IBZ,U,10),0)):$P(^(0),U),1:"UNKNOWN")
 Q:IBQUIT
 I IBTOT D TOTALS
 D PAUSE(1)
 Q
 ;Number format
FORMAT(IBNUM,IBDIG,IBFRM) ;
 N X,X1,X2,X3
 S X=IBNUM,X2=$G(IBFRM,"2$"),X3=IBDIG
 D COMMA^%DTC
 Q X
 ;
CHKSTOP I $Y>(IOSL-5) D PAUSE(0) Q:IBQUIT  D HDR
 Q
 ;
 ;
HDR ; Print header.
 N IBI
 I $E(IOST,1,2)["C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1 W ?(80-$L(IBH)\2),IBH
 W !,"From ",$$DAT(IBBDT)," through ",$$DAT(IBEDT)
 W ?IOM-36,IBDTH,?IOM-9,"Page: ",IBPAG
 W !,"BILL FROM  BILL TO    BILL TYPE",?46,"BILL #    TOT CHRG   TOT GMT DIFF"
 W ! F IBI=1:1:80 W "-"
 Q
 ;
TOTALS N IBI,X
 W !,?56 F IBI=1:1:22 W "-"
 W !,?54,$$FORMAT(IBTOT,12),?66,$$FORMAT(IBTOTS,12)
 Q
 ;
STAT() ; Display bill number or status
 N IBSTAT S IBSTAT=$G(^IBE(350.21,+$P(IBZ,U,5),0))
 Q $S($P(IBSTAT,U,6):$$HLD(+$P(IBZ,U,5)),$P(IBZ,U,5)=99:"Converted",$P(IBZ,U,11)]"":$P($P(IBZ,U,11),"-",2),$P(IBSTAT,U,5):"Cancelled",1:"Pending")
 ;
HLD(STAT) ; Return an 'on hold' status string
 Q "Hold "_$S(STAT=20:"Rate",STAT=21:"Rev",1:"Ins")
 ;
PAUSE(IBEND) ;
 Q:$E(IOST,1,2)'["C-"
 N IBJ,DIR,DIRUT,DTOUT,DUOUT,DIROUT,Y
 W !! ;F IBJ=$Y:1:(IOSL-4) W !
 S DIR(0)="E"
 I $G(IBEND) S DIR("A")="End of the report. Enter RETURN to continue or '^' to exit"
 D ^DIR K DIR I $G(DUOUT) S IBQUIT=1 W @IOF Q
 I $G(IBEND) W @IOF
 Q
 ;
DAT(IBDT) ; Convert FM date to (mm/dd/yy) format.
 Q $$FMTE^XLFDT(IBDT,"2MZ")
 ;
 ; Action Billing Group
BILGR(IBACT) ; Input pointer to Action Type File #350.1
 ; Output - Billing Group
 N IBNEW
 S IBNEW=$P($G(^IBE(350.1,+IBACT,0)),U,9) ;New action type
 Q +$S($P($G(^IBE(350.1,+IBNEW,0)),U,11):$P(^(0),U,11),1:$P($G(^IBE(350.1,+IBACT,0)),U,11))
