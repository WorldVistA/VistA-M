IBCSC9 ;ALB/BI - MCCR SCREEN 9 (AMBULANCE INFO)  ;11 MAY 2011 10:20
 ;;2.0;INTEGRATED BILLING;**52,51,447,473**;11-MAY-2011;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; Main Entry Point
 N IBACI,IBACIX,IB,IBT
 D ^IBCSCU
 S IBT=$P($G(^DGCR(399,IBIFN,0)),U,19)
 S IBSR=9,IBSR1="",IBV1=$S(IBT=3:"11",IBV:"11",1:"00")
 S IB("U")=$G(^DGCR(399,IBIFN,"U"))
 S IB("U1")=$G(^DGCR(399,IBIFN,"U1"))
 S IB("U4")=$G(^DGCR(399,IBIFN,"U4"))
 S IB("U5")=$G(^DGCR(399,IBIFN,"U5"))
 S IB("U6")=$G(^DGCR(399,IBIFN,"U6"))
 S IB("U7")=$G(^DGCR(399,IBIFN,"U7"))
 S IB("U8")=$G(^DGCR(399,IBIFN,"U8"))
 M IB("U9")=^DGCR(399,IBIFN,"U9")
 D H^IBCSCU
 S Z=1,IBW=1 X IBWW W " Ambulance Transport Data"
 W !,?41,"D/O Location: ",$P(IB("U6"),U)
 W !,?4,"P/U Address1: ",$P(IB("U5"),U,2),?41,"D/O Address1: ",$P(IB("U6"),U,2)
 W !,?4,"P/U Address2: ",$P(IB("U5"),U,3),?41,"D/O Address2: ",$P(IB("U6"),U,3)
 W !,?4,"P/U City: ",$P(IB("U5"),U,4),?41,"D/O City: ",$P(IB("U6"),U,4)
 W !,?4,"P/U State/Zip: " W:$P(IB("U5"),U,5)'="" $P($G(^DIC(5,$P(IB("U5"),U,5),0)),U,2)
 W:$P(IB("U5"),U,6)]"" "/"_$P(IB("U5"),U,6)
 W ?41,"D/O State/Zip: " W:$P(IB("U6"),U,5)'="" $P($G(^DIC(5,$P(IB("U6"),U,5),0)),U,2)
 W:$P(IB("U6"),U,6)]"" "/"_$P(IB("U6"),U,6)
 W !,?4,"Patient Weight: ",$P(IB("U7"),U,1),?41,"Transport Distance: ",$P(IB("U7"),U,3)
 W !,?4,"Transport Reason: " I $P(IB("U7"),U,2)'="" D IBWP($$GET1^DIQ(353.4,$P(IB("U7"),U,2)_",",.02),22,55)
 W !,?4,"R/T Purpose: " D IBWP($P(IB("U7"),U,4),17,60)
 W !,?4,"Stretcher Purpose: " D IBWP($P(IB("U7"),U,5),23,54)
 S Z=2,IBW=2 X IBWW W " Ambulance Certification Data"
 W !,?4,"Condition Indicator:"
 S IBACIX=0
 F  S IBACIX=$O(IB("U9",IBACIX)) Q:+IBACIX=0  D
 . S IBACI=IB("U9",IBACIX,0)
 . W ?25,$$GET1^DIQ(353.5,IBACI_",",.01)," - ",$$GET1^DIQ(353.5,IBACI_",",.02),!
 K IB("U9")
 W !
 G ^IBCSCP
 Q
 ;
IBWP(IBX,IBLM,IBRM) ;
 K ^UTILITY($J,"W")
 N X,Y,DIWF,DIWL,DIWR S X=IBX
 S DIWL=1,DIWR=IBRM,DIWF="" D ^DIWP
 I $D(^UTILITY($J,"W")) S Y=0 F  S Y=$O(^UTILITY($J,"W",1,Y)) Q:'Y  W:Y>1 !,?(IBLM) W $G(^UTILITY($J,"W",1,Y,0))
 K ^UTILITY($J,"W")
 Q
 ;
SCREEN1(DA1) ;
 N A,RESPONSE S RESPONSE=0
 I +$P($G(^DGCR(399,DA1,"U9",0)),U,4)<5 S RESPONSE=1 Q RESPONSE
 S A(1,"F")="!?35",A(1)="Maximum of 5 Condition Indicators allowed"
 D EN^DDIOL(.A)
 Q RESPONSE
 ;IBCSC9
