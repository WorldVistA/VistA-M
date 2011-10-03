IBOLK ;ALB/AAS - INTEGRATED BILLING - DISPLAY BY BILL NUMBER ;6-MAR-91
 ;;2.0; INTEGRATED BILLING ;**199,420,433**;21-MAR-94;Build 36
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
% ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOLK" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBOLK-1" D T0^%ZOSV ;start rt clock
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC("A")="Select CHARGE ID or PATIENT NAME: ",DIC="^PRCA(430,",DIC(0)="AEQM" D ^DIC K DIC G END1:+Y<1 S IBIL=$P(Y,"^",2)
 ; user needs to be able to look-up any iteration ie. K600111 or K600111-01
 ;S IBIFN=$O(^DGCR(399,"B",$P(IBIL,"-",2),0))
 S IBIFN=$O(^DGCR(399,"B",$P(IBIL,"-",2,3),0))
 I '$D(^IB("ABIL",IBIL)),'IBIFN W !!,"Billing has no Record of this Charge ID.",! G %
 ;
BRIEF R !,"(B)rief or (F)ull Inquiry: B// ",X:DTIME G:X="^"!('$T) END1 S:X="" X="B" S X=$E(X)
 I "BFbf"'[X D  G BRIEF
 . W !!?5,"Enter: '<CR>'  -  To select the Brief Inquiry."
 . W !?12,"'F'     -  To select the Full Inquiry.  This option will"
 . W !?23,"include the Address Inquiry, and more detailed"
 . W !?23,"information for Pharmacy Co-Pay bills."
 . W !?12,"'^'     -  To quit this option.",!
 W $S("Bb"[X:"   BRIEF",1:"   FULL") S IBFULL="Ff"[X
 I IBIFN S IBAC=8,IBQUIT=0
 ;
DEV W ! S %ZIS="QM",%ZIS("A")="Output Device: " D ^%ZIS G:POP END
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q") D HOME^%ZIS W ! G %
 . S ZTDESC="IB Print Actions by Bill Number"
 . S ZTRTN=$S(IBIFN:"VIEW^IBCNQ",1:"EN^IBOLK")
 . S ZTSAVE("IBFULL")="",ZTSAVE("IBIL")="",ZTSAVE("IBIFN")=""
 . I IBIFN F I="IBAC","IBQUIT" S ZTSAVE(I)=""
 ;
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOLK" D T1^%ZOSV ;stop rt clock
 I 'IBIFN D EN G %
 D VIEW^IBCNQ,Q^IBCNQ,END1 G %
 ;
EN ;  -Entry to display IB Action data for an AR Bill number
 ;  -Input   IBIL = external form of bill number, ie 500-K10001
 ;           IBFULL = 1 for full profile logic, 0 for brief description
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOLK-2" D T0^%ZOSV ;start rt clock
 S IBN=$O(^IB("ABIL",IBIL,"")) G:'$D(^IB(IBN,0)) ENQ
 S IBTOTL=0,IBQUIT="",IBPAG=0 D NOW^%DTC S IBHDT=$$DAT2^IBOUTL($E(%,1,12)) D HDR
 ;
 S IBN="" F IBI=0:0 S IBN=$O(^IB("ABIL",IBIL,IBN)) Q:'IBN  I $D(^IB(IBN,0)) D LINE Q:IBQUIT
 I 'IBQUIT D TOTAL,PAUSE,^IBOLK1:IBFULL&('IBQUIT)
ENQ D END Q
 ;
LINE ;  -find data for one line, write line, accumulate totals
 I '$D(IBTRAN),$Y>(IOSL-5) D PAUSE Q:IBQUIT  D HDR1
 S IBND=^IB(IBN,0),IBND1=$G(^(1))
 I IBFULL,$D(^IBE(350.1,+$P(IBND,"^",3),30)),+$P(IBND,"^",4)=52 W ! S X1=$P($P($P(IBND,"^",4),";",1),":",2),X2=$P($P($P(IBND,"^",4),";",2),":",2),X=X1_"^"_$S(X2:X2,1:0) X ^(30)
 S IBTYP=$G(^IBE(350.1,+$P(IBND,"^",3),0)),IBSEQNO=$P(IBTYP,"^",5)
 W ! S Y=$P($P(IBND1,"^",2),".",1) D DT^DIQ
 W ?15,$E($P($P(IBTYP,"^")," ",2,99),1,20),?37,$E($P(IBND,"^",8),1,20),?60,$J($P(IBND,"^",6),5)
 S IBCHRG=$P(IBND,"^",7) I IBSEQNO=2 S IBCHRG=(-IBCHRG) ;cancel types are decrease adjustments
 S X=IBCHRG,X2="2$",X3=10 D COMMA^%DTC W ?69,X
 S IBTOTL=IBTOTL+IBCHRG
 I $P(IBND,"^",10),IBSEQNO=2 W !,?5,"Charge Removal Reason: ",$S($D(^IBE(350.3,$P(IBND,"^",10),0)):$P(^(0),"^"),1:"UNKNOWN")
 Q
 ;
HDR S IBND=^IB(IBN,0),DFN=+$P(IBND,"^",2),IBNAME=$$PT^IBEFUNC(DFN)
HDR1 S IBPAG=IBPAG+1 I $E(IOST,1,2)["C-"!(IBPAG>1) W @IOF,*13
 ;W $E($P(IBNAME,"^"),1,20),"   ",$P(IBNAME,"^",2),?38,IBIL,?51,IBHDT,?72,"PAGE: ",IBPAG
 W $E($P(IBNAME,"^"),1,20),"  ",$P(IBNAME,"^",2),?36,IBIL,?51,IBHDT,?72,"PAGE: ",IBPAG
 D DISP^IBARXEU(DFN,DT,2) W !
 W:'IBFULL !,"DATE",?15,"CHARGE TYPE",?37,"BRIEF DESCRIPTION",?62,"UNITS",?73,"CHARGE"
 S IBLINE="",$P(IBLINE,"=",IOM)="" W !,IBLINE K IBLINE
 Q
 ;
TOTAL W !?67,"------------" S X=IBTOTL,X2="2$",X3=12 D COMMA^%DTC
 W !,?67,X
 Q
 ;
PAUSE Q:$E(IOST,1,2)'["C-"
 F IBJ=$Y:1:(IOSL-4) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
 ;
END1 K IBFULL
END W !
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOLK" D T1^%ZOSV ;stop rt clock
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K X,X2,X3,Y,DFN,IBIFN,IBAC,I,IB,IBIL,IBI,IBJ,IBNAME,IBLINE,IBN,IBND,IBND1,IBCHRG,IBSEQNO,IBTYP,IBTOTL,ZTSK,IBHDT,IBPAG,IBQUIT,DN,D0,DUOUT,DTOUT,VA,VADM,VAERR
 D ^%ZISC
 Q
 ;
ENF ;  -entry point for AR to print full profile for IB actions for
 ;   an ar transaction number.
 ;  -input   x = ar transaction number ($p(^ib(ibn,0),u,12)
 ;
 S IBFULL=1
 ;
ENB ;  -entry point for AR to print brief profile for IB actions for
 ;   an ar transaction number.
 ;  -input   x = ar transaction number
 ;
 S IBTOTL=0,IBPAG=0,IBQUIT="" S:'$D(IBFULL) IBFULL=0
 S IBTRAN=X
 S IBN="" F  S IBN=$O(^IB("AT",IBTRAN,IBN)) Q:IBN=""  D LINE
 K D0,DN,X,X2,X3,Y,IBFULL,IBTOTL,IBPAG,IBQUIT,IBTRAN,IBN,IBND,IBND1,IBSEQNO,IBTYP,IBCHRG
 Q
