IBOSTUS1 ;ALB/SGD-MCCR BILL STATUS REPORT ;25 MAY 88 14:19
 ;;2.0;INTEGRATED BILLING;**31,118,128,153,137,161,183,155**;21-MAR-94
 ;
 ;MAP TO DGCROST1
 ;
EN ; - Entry point from IBOSTUS.
 N IBSUB,IBHDR,IBST1,IBST2,IBCAT,IBAMT,IBBEF,IBCRT,IBQUIT,IBMTCT,DFN,REJFLG
 S IBBEF="",IBQUIT=0,IBCRT=$S($E($G(IOST),1,2)="C-":1,1:0)
 I IBDTP="Entered" S IBSUB="APD",IBHDR=1
 I IBDTP="Bill" S IBSUB="AP",IBHDR=1
 I IBDTP="Event" S IBSUB="D",IBHDR=0
 I IBDTP="MRA Request" S IBSUB="APM",IBHDR=0
 I 'IBSUM D HEAD
 ;
PROC ; - Get data for report(s).
 S X1=IBBEG\1,X2=-1 D C^%DTC S IBNEX=X_.2359,X=132 X ^%ZOSF("RM")
 F  S IBNEX=$O(^DGCR(399,IBSUB,IBNEX)) Q:'IBNEX!(IBNEX>(IBEND\1_.2359))!(IBQUIT)  D  Q:IBQUIT
 .I $Y>$S($D(IOSL):(IOSL-$S(IBCRT:4,1:9)),1:20) D HEAD Q:IBQUIT
 .I IBHDR,'IBSUM D SUBHDR
 .S IBIFN="" F J=0:0 S IBIFN=$O(^DGCR(399,IBSUB,IBNEX,IBIFN)) Q:'IBIFN!IBQUIT  D SET S IBBEF=IBNEX
 I 'IBQUIT D
 .I '$D(IBF) W !!,?10,"*** No matches found ***"
 .E  D SUM^IBOSTUS
 ;
Q I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
SET ; This section is called for a single bill - IBIFN
 S IBS=$G(^DGCR(399,IBIFN,"S")),IBAPP=1
 I $P(IBS,U,17)'="" S IBBS="  CANCELLED",IBBSDT=$P(IBS,U,17),IBBSBY=$P(IBS,U,18) D:IBBST="C" PRINT G ALL
 I $P(IBS,U,14)'="" S IBBS="  PRNT/TXMT",IBBSDT=$P(IBS,U,12),IBBSBY=$P(IBS,U,13) D:IBBST="P" PRINT G ALL
 I $P(IBS,U,10)'="" S IBBS="* AUTHORIZED",IBAPP=$P(IBS,U,9),IBBSDT=$P(IBS,U,10),IBBSBY=$P(IBS,U,11) D:IBBST="A" PRINT G ALL
 I $P(IBS,U,7)'="" S IBBS="* REQUEST MRA",IBBSDT=$P(IBS,U,7),IBBSBY=$P(IBS,U,8) D:IBBST="R"  G ALL
 . ; if user answered No to 'print Bills with No MRA Received and No Rejection messages', print report as usual
 . I 'IBNOEOB D PRINT Q
 . ; if user answered Yes (IBNOEOB=1), check two things before printing:
 . ;     1) if MRA on file, don't print
 . I $$CHK^IBCEMU1(IBIFN) Q
 . ;     2) if the most recent transmission for this claim was rejected, don't print
 . D TXSTS^IBCEMU2(IBIFN,,.REJFLG)
 . I REJFLG Q
 . ;
 . ; otherwise, print bill
 . D PRINT
 ;
 S IBBS="* ENTERED",IBBSDT=$P(IBS,U),IBBSBY=$P(IBS,U,2) D:IBBST="E" PRINT
ALL Q:IBQUIT  I IBBST="ALL" D PRINT
 Q
 ;
PRINT ; - Print detail report, if necessary.
 NEW LINE
 I $Y>$S($D(IOSL):(IOSL-$S(IBCRT:4,1:6)),1:6) D HEAD Q:IBQUIT  D SUBHDR:(IBBEF=IBNEX)&IBHDR
 S IBF=1,IB0=$G(^DGCR(399,IBIFN,0))
 S IBCAT=$S($D(^DGCR(399.3,+$P(IB0,U,7),0)):$P(^(0),U,4),1:"UNSPECIFIED")_$S($P(IB0,U,5)>2:"-OPT",1:"-INPT")
 S IBU1=$G(^DGCR(399,IBIFN,"U1")),IBAMT=$S(IBU1="":0,$P(IBU1,U,2)]"":$P(IBU1,U)-$P(IBU1,U,2),1:$P(IBU1,U))
 I IBSUM D ADD Q  ; Printing summary ONLY.
 ;
 S DFN=$P(IB0,U,2) D PID^VADPT6 W !,$P(IB0,U),?10,$E($P(^DPT($P(IB0,U,2),0),U),1,20),?31,VA("BID"),?39,$E($P(IB0,U,3),4,5),"/",$E($P(IB0,U,3),6,7),"/",$E($P(IB0,U,3),2,3)
 S IBBY=$P(IBS,U,2) W:IBBY ?50,$E($S($D(^VA(200,IBBY,0)):$P(^(0),U,2),1:"UNKN"),1,4) W ?57,IBCAT
 ;
 ; - MT status as of event date.
 S IBMTCT=$P($$LST^DGMTU(DFN,$P(IB0,U,3)),U,4)
 S IBMTCT=$S(IBMTCT="C":"YES",IBMTCT="P":"PEN",IBMTCT="R":"REQ",IBMTCT="G":"GMT",1:"NO")
 W ?72,IBMTCT
 ;
 S X=IBAMT,X2="2$" D COMMA^%DTC W ?77,$J(X,10)
 W ?90,IBBS,$S('IBAPP:"/DISAPP",1:"")," ",$E(IBBSDT,4,5),"/",$E(IBBSDT,6,7),"/",$E(IBBSDT,2,3)," (",$S($D(^VA(200,+IBBSBY,0)):$P(^(0),U,2),1:"UNKN USER"),"/",IBBSBY,")" K VA("BID"),VA("PID")
 ;
 ; If the user chose to print the ClaimsManager comments, then show
 ; them all here.  Also do the appropriate $Y checks for the next page.
 ;
 I 'IBCICOMM G SKPCMM                     ; user doesn't want comments
 I '$D(^IBA(351.9,IBIFN,2)) G SKPCMM      ; no comments exist
 ;
 W !!?8,$$CMTINFO^IBCIUT5(IBIFN)
 S LINE=0
 F  S LINE=$O(^IBA(351.9,IBIFN,2,LINE)) Q:'LINE  D  Q:IBQUIT
 . I $Y>(IOSL-$S(IBCRT:4,1:6)) D HEAD Q:IBQUIT
 . W !?10,$G(^IBA(351.9,IBIFN,2,LINE,0))
 . Q
 Q:IBQUIT
 W !
 ;
SKPCMM ; skip to here if we're not printing ClaimsManager comments
 ;
 D ADD
 Q
 ;
HEAD ; - Print report header.
 I $G(IBPAGE)>0,IBCRT S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S IBQUIT=1 Q
 S IBPAGE=$G(IBPAGE)+1,$P(IBL,"=",IOM)="",Y=IBBEG X ^DD("DD")
 W @IOF,!,"MCCR Bill Status ",$S(IBSUM:"Statistics",1:"Report")," for ",$S(IBBEG'=IBEND:"period covering ",1:"")_Y
 I IBBEG<IBEND S Y=IBEND X ^DD("DD") W " thru "_Y
 I '$D(IBRUN) D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S IBRUN=Y
 I 'IBSUM W ?100,IBRUN,?123,"Page ",$J(IBPAGE,3)
 W ! I $D(IBHD) W "Bill Status: ",IBHD,"     "
 I 'IBSUM W:IBBST'="C"&(IBBST'="P") "* Denotes that the bill status is not Printed or Cancelled" W:IBCICOMM ?106,"ClaimsManager Comments ON"
 E  W "Run Date: ",IBRUN
 ; if user answered Yes to 'No MRA Received and No Rejection messages' question, print this line in header
 I IBNOEOB W !,"**** Bills with No MRA Received and No current CSA Rejection messages ****"
 I 'IBSUM D
 .W !!?39,"EVENT",?49,"ENTRD",?73,"MT",!,"BILL NO.",?10,"PATIENT NAME"
 .W ?31,"PT.ID",?39,"DATE",?50,"BY",?57,"RATE TYPE",?70,"STATUS"
 .W ?81,"CHARGES",?94,"BILL STATUS"
 ;
 W !,IBL W:IBSUM ! K IBL
 Q
 ;
SUBHDR W !!?3,IBDTP_" Date: "_$$DAT1^IBOUTL(IBNEX)
 Q
 ;
ADD ; - For summary statistics.
 S IBST1(IBCAT,"C")=1+$G(IBST1(IBCAT,"C"))
 S IBST1(IBCAT,"$")=IBAMT+$G(IBST1(IBCAT,"$"))
 S:IBBS["* " IBBS=$P(IBBS,"* ",2)
 S:IBBS["  " IBBS=$P(IBBS,"  ",2)
 S:IBBS="" IBBS="UNKNOWN"
 S IBST2(IBBS,"C")=1+$G(IBST2(IBBS,"C"))
 S IBST2(IBBS,"$")=IBAMT+$G(IBST2(IBBS,"$"))
 Q
