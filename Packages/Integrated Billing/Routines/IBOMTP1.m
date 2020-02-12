IBOMTP1 ;ALB/CPM-MEANS TEST BILLING PROFILE (CON'T);10-DEC-91
 ;;2.0;INTEGRATED BILLING;**15,153,176,183,651,656**;21-MAR-94;Build 17
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 N IBLEG,IBCHK
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOMTP1-2" D T0^%ZOSV ;start rt clock
 ; Begin compilation.  Start with billing clocks.
 S Y=-(IBEDT+.1),X=0 F  Q:-Y<IBBDT  S Y=$O(^IBE(351,"AIVDT",IBDFN,Y)) Q:'Y  F  S X=$O(^IBE(351,"AIVDT",IBDFN,Y,X)) Q:'X  S:$P($G(^IBE(351,X,0)),U,4)'=3 ^TMP($J,"IBOMTP",-Y,"C")=""
 ;
 ; Get O/P visits from file #399.
 S X1=IBBDT,X2=-1 D C^%DTC S Y=X
 F  S Y=$O(^DGCR(399,"AOPV",IBDFN,Y)) Q:'Y!(Y>IBEDT)  D
 . S IBDA=0 F  S IBDA=$O(^DGCR(399,"AOPV",IBDFN,Y,IBDA)) Q:'IBDA  D
 ..  I $D(^DGCR(399,+IBDA,0)),'$P($G(^("S")),U,16),$P($G(^DGCR(399.3,+$P(^(0),U,7),0)),U)["MEANS" S ^TMP($J,"IBOMTP",Y,"M"_IBDA)=""
 ;
 ; Get the rest of the charges from file #350.
 S Y="" F  S Y=$O(^IB("AFDT",IBDFN,Y)) Q:'Y  I -Y'>IBEDT S Y1=0 F  S Y1=$O(^IB("AFDT",IBDFN,Y,Y1)) Q:'Y1  D
 . S (IBDA,IBCHK)=0 F  S IBDA=$O(^IB("AF",Y1,IBDA)) Q:'IBDA  D
 ..  ;Q:'$D(^IB(IBDA,0))  S IBX=^(0)
 ..  Q:'$D(^IB(IBDA,0))
 ..  S IBX=^IB(IBDA,0)
 ..  Q:$P(IBX,U,8)["ADMISSION"
 ..  I $P(IBX,U,15)<IBBDT!($P(IBX,U,14)>IBEDT) Q
 ..  N Y,Y1
 ..  ; Action type. We don't include LTC actions to the report
 ..  I $P(IBX,U,3) I $$ACTNM^IBOUTL(+$P(IBX,U,3))["LTC " Q  ; Exclude LTC action type
 ..  S ^TMP($J,"IBOMTP",+$P(IBX,U,14),"I"_IBDA)="",IBCHK=1
 . Q:IBCHK     ;If an entry already found its not a pharmacy RX
 . S IBX=$G(^IB(Y1,0))
 . S IBATYP=$P(IBX,U,3),IBBLG=$$GET1^DIQ(350.1,IBATYP_",",.11,"I")
 . I IBBLG=5 D             ;Is this an RX copay
 ..  I $P(IBX,U,15)<IBBDT!($P(IBX,U,14)>IBEDT) Q      ;Check to ensure the visit is in the correct search range
 ..  S ^TMP($J,"IBOMTP",+$P(IBX,U,14),"I"_Y1)=""      ;Store in reporting array.
 ;
 ; Print report.
 S IBLEG=0 ; Legend not required
 D NOW^%DTC S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 S IBLINE="",$P(IBLINE,"-",IOM+1)="",(IBPAG,IBCHGT,IBQUIT)=0
 S IBPT=$$PT^IBEFUNC(IBDFN)
 S IBH="Means Test Billing Profile for "_$P(IBPT,U)_"  "_$P(IBPT,U,2) D HDR
 I '$D(^TMP($J,"IBOMTP")) W !,"This patient has no Means Test bills." D PAUSE^IBOUTL G END
 ; - first, print detail lines
 S IBD="" F  S IBD=$O(^TMP($J,"IBOMTP",IBD)) Q:'IBD  D  G:IBQUIT END
 . S IBTY="" F  S IBTY=$O(^TMP($J,"IBOMTP",IBD,IBTY)) Q:IBTY=""  D  Q:IBQUIT
 ..  I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR
 ..  W !,$$DAT1^IBOUTL(IBD)
 ..  I IBTY="C" W ?12,"Begin Means Test Billing Clock" Q
 ..  S IBDA=+$E(IBTY,2,99),IBD0=$S($E(IBTY)="M":$G(^DGCR(399,IBDA,0)),1:$G(^IB(IBDA,0))),IBSEQ=0
 ..  I $E(IBTY)="I" S IBSEQ=$P($G(^IBE(350.1,+$P(IBD0,U,3),0)),U,5)
 ..  W ?14,$S($E(IBTY)="M":"OPT COPAYMENT (UB-82)",1:$$ACTNM^IBOUTL(+$P(IBD0,U,3)))
 ..  W ?44,$S($E(IBTY)="M":$P(IBD0,U),1:$$STAT())
 ..  I $E(IBTY)="I",$P(IBD0,U,14)'=$P(IBD0,U,15) W ?54,$$DAT1^IBOUTL($P(IBD0,U,15))
 ..  I $E(IBTY)="M" S X=+$O(^DGCR(399,IBDA,"RC","B",500,0)),IBCHG=+$P($G(^DGCR(399,IBDA,"RC",X,0)),U,2)
 ..  E  S IBCHG=+$P(IBD0,U,7)
 ..  I IBSEQ=2 S IBCHG=-IBCHG
 ..  I $E(IBTY)="I",$P(IBD0,U,11)="",$P($G(^IBE(350.21,+$P(IBD0,U,5),0)),U,5) S IBCHG=0
 ..  S X=IBCHG,X2="2$",X3=10 D COMMA^%DTC W ?65,X
 ..  I $P(IBD0,U,21) W " *" S IBLEG=1 ;Print legend at the bottom
 ..  S IBCHGT=IBCHGT+IBCHG
 ..  I IBSEQ=2!($P(IBD0,U,11)=""&($P($G(^IBE(350.21,+$P(IBD0,U,5),0)),U,5))) W !?5,"Charge Removal Reason: ",$S($D(^IBE(350.3,+$P(IBD0,U,10),0)):$P(^(0),U),1:"UNKNOWN")
 ; - print totals line
 I ($Y-IBLEG)>(IOSL-5) D LEGEND,PAUSE^IBOUTL G:IBQUIT END D HDR
 W !?63,"-----------" S X=IBCHGT,X2="2$",X3=12 D COMMA^%DTC W !?63,X
 D LEGEND,PAUSE^IBOUTL
 ; - close device and quit
END K ^TMP($J)
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTP1" D T1^%ZOSV ;stop rt clock
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K IBJ,IBD,IBH,IBHDT,IBTY,IBDA,IBD0,IBSEQ,IBQUIT,IBCHG,IBCHGT,IBPAG,IBLINE,IBX,IBPT,X,X2,X3,Y,Y1
 D ^%ZISC Q
 ;
 ;
HDR ; Print header.
 S IBLEG=0
 I $E(IOST,1,2)["C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1 W ?(80-$L(IBH)\2),IBH
 W !,"From ",$$DAT1^IBOUTL(IBBDT)," through ",$$DAT1^IBOUTL(IBEDT)
 W ?IOM-36,IBHDT,?IOM-9,"Page: ",IBPAG
 W !,"BILL DATE   BILL TYPE",?44,"BILL #    BILL TO   TOT CHARGE"
 W !,IBLINE,! Q
 ;
STAT() ; Display bill number or status
 N IBSTAT S IBSTAT=$G(^IBE(350.21,+$P(IBD0,U,5),0))
 Q $S($P(IBSTAT,U,6):$$HLD(+$P(IBD0,U,5)),$P(IBD0,U,5)=99:"Converted",$P(IBD0,U,11)]"":$P($P(IBD0,U,11),"-",2),$P(IBSTAT,U,5):"Cancelled",1:"Pending")
 ;
HLD(STAT) ; Return an 'on hold' status string
 Q "Hold "_$S(STAT=20:"Rate",STAT=21:"Rev",1:"Ins")
 ;
LEGEND I $G(IBLEG) W !,"    '*' - Geographic Means Test rates"
 Q
