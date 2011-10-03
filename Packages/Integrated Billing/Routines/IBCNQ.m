IBCNQ ;ALB/MJB - MCCR PATIENT BILLING INQUIRY ;13 JUN 88 13:52
 ;;2.0;INTEGRATED BILLING;**51,320,377,433**;21-MAR-94;Build 36
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRNQ
 ;
 D HOME^%ZIS
ASKPAT S DIC="^DGCR(399,",DIC(0)="AEMQZ",DIC("A")="Enter BILL NUMBER or PATIENT NAME: " W !! D ^DIC G:X=""!(X["^") Q
 ;
 S IBIFN=+Y,IBQUIT=0,IBAC=7
VIEW ;
 ;***
 F I=0,"S","U","U1" S IB(I)=$G(^DGCR(399,IBIFN,I))
 S DFN=$P(IB(0),"^",2),IBSTAT=$P(IB(0),"^",13),IBBNO=$$BN^PRCAFN(IBIFN),IBPAGE=0 S:IBBNO=-1 IBBNO=$S($D(IBIL):IBIL,1:$P(IB(0),"^"))
 ;
 D NOW^%DTC S Y=$E(%,1,12) D D^DIQ S IBNOW=Y,IBPT=$$PT^IBEFUNC(DFN) D HDR1
 ;
 S IBUN="UNSPECIFIED",IBUK="UNKNOWN USER"
 W !,"Bill Status",?15,": ",$S(IBSTAT=1:"ENTERED/NOT REVIEWED",IBSTAT=2:"MRA REQUESTED",IBSTAT=3:"AUTHORIZED",IBSTAT=4:"PRINTED/TRANSMITTED",IBSTAT=7:"CANCELLED",1:IBUN)," - RECORD IS ",$S(IBSTAT=1:"",1:"UN"),"EDITABLE"
 W !,"Rate Type",?15,": ",$S($P(IB(0),"^",7)="":IBUN,'$D(^DGCR(399.3,$P(IB(0),"^",7),0)):IBUN,1:$P(^DGCR(399.3,$P(IB(0),"^",7),0),"^"))
 W:+$P(^IBE(350.9,1,1),"^",22) !,"Form Type",?15,": ",$S($P($G(^IBE(353,+$P(IB(0),"^",19),0)),"^")]"":$P(^(0),"^"),1:IBUN)
 W:IBSTAT=7 !,"Reason Canceled",?15,": ",$S($P(IB("S"),"^",19)]"":$P(IB("S"),"^",19),1:IBUN)
 I $$INPAT^IBCEF(IBIFN) S Y=$P(IB(0),"^",3) D D^DIQ W !!,"Admission Date : ",Y
 E  D OPDATE
 W !!,"Charges",?15,": " S X=$P(IB("U1"),U,1),X2="2$" D:X]"" COMMA^%DTC W $S(X]"":X,1:IBUN)
 I $P(IB("U1"),U,2)]"" W !,"LESS Offset",?15,": " S X=$P(IB("U1"),U,2),X2="2$" D COMMA^%DTC W X,"   [",$P(IB("U1"),U,3),"]",!,"Bill Total",?15,": " S X=($P(IB("U1"),U,1)-$P(IB("U1"),U,2)),X2="2$" D COMMA^%DTC W X
 S X=$$TPR^PRCAFN(IBIFN) I X>0 S X2="2$" D COMMA^%DTC W !,"Amount Paid",?15,": ",X
 S X=$$STA^PRCAFN(IBIFN) I X>0 W !,"AR Status",?15,": ",$P(X,"^",2)
 I $P(IB("U"),U)]"" S Y=$P(IB("U"),U) D D^DIQ W !!,"Statement From",?15,": ",Y S Y=$P(IB("U"),"^",2) D D^DIQ W !,"Statement To",?15,": ",Y,!
 I $P(IB("U"),U)']"" W !!,"Statement From",?15,": ",IBUN,!,"Statement To",?15,": ",IBUN,!
 D DISP I IBQUIT Q:IBAC[8  G Q
 I IBSTAT<5 D NOPTF^IBCB2 I 'IBAC1 D:$Y>(IOSL-6) HDR Q:IBQUIT&(IBAC[8)  G Q:IBQUIT D NOPTF1^IBCB2
 D PAUSE,^IBOLK1:$G(IBFULL)&('IBQUIT) Q:IBAC[8  ; Called from Outpatient Visit Date Inquiry
 G Q:IBQUIT,ASKPAT
 ;
DISP ; The variable IBAC must be defined as input to this sub-routine.
 G:'$D(IBAC) DISPQ
 S IBUN="UNSPECIFIED",IBUK="UNKNOWN USER"
 I IB("S")']"" W !,"Past actions of this billing record unspecified." G DISPQ
 S IBX="Entered^^^^^^MRA Requested^^^Authorized^^First Printed^^Last Printed^^^Cancelled"
 F I=1,7,10,12,14,17 I $P(IB("S"),U,I)]"" D:IBAC[7&($Y>(IOSL-4)) HDR Q:$S(IBAC'[7:0,1:IBQUIT)  D DISP1
 ;
 ;Patch 320 - Added call to retrieve claim clone history.
 N IBCCR,IBCURR,IBNEXT,IBBCH,IBINDENT
 S IBINDENT=0
 D EN^IBCCR(IBIFN,.IBCCR)   ; utility to pull cloning history
 ;
 ; attempt to go one claim forward from the current claim
 S IBCURR="IBCCR("_+$P(IB("S"),U,1)_","_IBIFN_")"
 S IBNEXT=$Q(@IBCURR)
 I IBNEXT'="" D
 . N IBX S IBX=@IBNEXT
 . W !,"Copied"
 . W ?15,": ",$$FMTE^XLFDT($P(IBX,U,1),"1Z")_" by "_$P(IBX,U,3)
 . W !,"Copied To",?15,": ",$P(IBX,U,2)
 . S IBINDENT=1
 . Q
 ;
 ; now go backwards for claim cloning history all the way back
 S IBBCH=IBCURR
 F  S IBBCH=$Q(@IBBCH,-1) Q:IBBCH=""  D
 . N IBX,TS1,TS2 S IBX=@IBBCH
 . I IBINDENT S TS1=4,TS2=19     ; set tab stops
 . E  S TS1=0,TS2=15
 . W !?TS1,"Copied",?TS2,": "
 . W $$FMTE^XLFDT($P(IBX,U,1),"1Z")_" by "_$P(IBX,U,3)
 . W !?TS1,"Copied From",?TS2,": ",$P(IBX,U,2)
 . W !?TS1,"Reason Copied",?TS2,": ",$P(IBX,U,4)
 . S IBINDENT=1
 . Q
 ;
 I $D(^DGCR(399,IBIFN,"R","AC",1)) S IB=0 F I=0:0 S IB=$O(^DGCR(399,IBIFN,"R","AC",1,IB)) Q:'IB  D:IBAC[7&($Y>(IOSL-4)) HDR Q:$S(IBAC'[7:0,1:IBQUIT)  W !,"Returned to AR : " D RETN
DISPQ Q
 ;
DISP1 W !,$P(IBX,U,I) S Y=$P(IB("S"),U,I) D D^DIQ W ?15,": ",Y,?28," by " S IBN=$P(IB("S"),U,(I+1)) W $S(IBN']"":IBUK,$D(^VA(200,IBN,0)):$P(^(0),U,1),1:IBUK)
 Q
 ;
Q K DFN,IB,IBAC,IBBNO,IBN,IBNOW,IBPAGE,IBPT,IBU,IBQUIT,IBUK,IBUN,IBX,IBSTAT,IBAC1,IBIFN,IBOPD,DIC,X,X2,Y
 Q
 ;
RETN I $D(^DGCR(399,IBIFN,"R",IB,0)) S IBN=^(0),Y=$P($P(IBN,"^"),".") D D^DIQ W Y,?28," by " S IBN=$P(IBN,"^",2) I IBN]"",$D(^VA(200,IBN,0)) W $P(^VA(200,IBN,0),"^")
 Q
 ;
HDR D PAUSE Q:IBQUIT
HDR1 S L="",$P(L,"=",80)="",IBPAGE=IBPAGE+1
 W:$E(IOST,1,2)["C-"!(IBPAGE>1) @IOF
 ;W $E($P(IBPT,"^"),1,20),"   ",$P(IBPT,"^",2),?38,IBBNO,?51,IBNOW,?72,"PAGE: ",IBPAGE,!,L
 W $E($P(IBPT,"^"),1,20),"  ",$P(IBPT,"^",2),?36,IBBNO,?51,IBNOW,?72,"PAGE: ",IBPAGE,!,L
 K L Q
 ;
OPDATE ; List Outpatient Visit Dates.
 Q:'$O(^DGCR(399,IBIFN,"OP",0))
 W !!,"OP Visit Dates :" S IBOPD=0
 F I=1:1 S IBOPD=$O(^DGCR(399,IBIFN,"OP",IBOPD)) Q:'IBOPD  D
 . W:'((I-1)#4)&(I>1) !
 . S Y=IBOPD D D^DIQ W ?($S(I#4:I#4,1:4)*14+3),Y
 Q
 ;
PAUSE Q:$E(IOST,1,2)'="C-"
 F I=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
