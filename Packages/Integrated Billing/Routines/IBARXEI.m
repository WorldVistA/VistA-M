IBARXEI ;ALB/AAS - RX COPAY EXEMPTION INQUIRY ; 21-JAN-93
 ;;2.0; INTEGRATED BILLING ;**34,199**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% I '$D(IOF) D HOME^%ZIS
 ;
PAT I $G(IBQUIT) G END
 D END
 S (IBPAG,IBQUIT)=0 D NOW^%DTC S Y=% D D^DIQ S IBPDAT=Y
 ;
 S DIC("W")="N IBX S IBX=$G(^IBA(354,+Y,0)) W ?32,"" "",$P($G(^DPT(+IBX,0)),U,9),?46,"" "",$$TEXT^IBARXEU0($P(IBX,U,4)),?59,"" "",$P($G(^IBE(354.2,+$P(IBX,U,5),0)),U)"
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 W ! S DIC="^DPT(",DIC("S")="I $D(^IBA(354,+Y,0))",DIC(0)="AEQM",DIC("A")="Select BILLING PATIENT: " D ^DIC K DIC
 G:Y<1 END
 S DFN=+Y,IBP=$$PT^IBEFUNC(DFN),IBPBN=$G(^IBA(354,DFN,0))
 ;
TYP ; -- inquire is active or all
 S DIR("?")="Enter 1 or B to see a brief inquiry of all Active Exemptions or enter 2 or F to see a full inquiry of the entire exemption history"
 S DIR(0)="SAOM^1:BRIEF;2:FULL",DIR("A")="(B)rief or (Full) Inquiry: ",DIR("B")="Brief"
 D ^DIR K DIR G:$D(DIRUT)!($G(Y)<1) END S IBFULL=Y
 ;
DEV S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^IBARXEI",ZTSAVE("IB*")="",ZTSAVE("DFN")="",ZTDESC="IB INQUIRE TO PATIENT EXEMPTION" D ^%ZTLOAD,HOME^%ZIS K ZTSK D END G PAT
 U IO
 ;
DQ ;
 K ^TMP($J)
 D @IBFULL
 I 'IBQUIT,$E(IOST,1,2)="C-" D PAUSE^IBOUTL
 I '$D(ZTQUEUED) D END G PAT
 G END
 Q
 ;
1 ; -- brief view active exemptions
 D DISP^IBARXEX,STAT^IBARXEX
 Q
 ;
2 ; -- full view all exemptions
 D HDR
 S IBT=""
 ;
 ; -- build list in inverse effective date, inverse date/time added
 F  S IBT=$O(^IBA(354.1,"APIDT",DFN,IBT)) Q:'IBT  S IBIDT="" F  S IBIDT=$O(^IBA(354.1,"APIDT",DFN,IBT,IBIDT)) Q:'IBIDT  S IBDA="" F  S IBDA=$O(^IBA(354.1,"APIDT",DFN,IBT,IBIDT,IBDA)) Q:'IBDA!(IBQUIT)  D SET
 ;
 ; -- print list
 S IBIDT="" F  S IBIDT=$O(^TMP($J,DFN,IBIDT)) Q:'IBIDT!(IBQUIT)  S IBA="" F  S IBA=$O(^TMP($J,DFN,IBIDT,IBA)) Q:'IBA!(IBQUIT)  S IBDA="" F  S IBDA=$O(^TMP($J,DFN,IBIDT,IBA,IBDA)) Q:'IBDA!(IBQUIT)  S IBND=^(IBDA) D FULL
 ;
 Q
 ;
END K ^TMP($J) S ZTREQ="@" I $D(ZTQUEUED) Q
 D ^%ZISC
 K C,X,Y,DFN,DIC,DIR,DIRUT,ZTSK,ZTREQ,IBCNT,IBDA,IBDT,IBFULL,IBIDT,IBJ,IBND,IBP,IBPAG,IBPBN,IBPDAT,IBQUIT,IBSTAT,IBSTATR,IBT
 Q
 ;
HDR ; -- print header for full inquiry
 I IBPAG!($E(IOST,1,2)="C-") W @IOF
 S IBPAG=IBPAG+1
 W "Billing Exemption Inquiry",?(IOM-35),$P(IBPDAT,"@")," ",$P(IBPDAT,"@",2),"  Page ",IBPAG
 W !,$E($P(IBP,"^"),1,20),"   ",$P(IBP,"^",3),?27,"Currently: ",$$TEXT^IBARXEU0($P(IBPBN,"^",4))_"-"_$P($G(^IBE(354.2,+$P(IBPBN,"^",5),0)),"^"),?65," ",$$DAT1^IBOUTL($P(IBPBN,"^",3))
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
FULL ; -- print full inquiry for one exemption
 I $Y>(IOSL-8) D PAUSE^IBOUTL Q:IBQUIT  D HDR
 I $G(IBND)="" W !,"Error, Missing Record - ",IBDA Q
 S Y=+IBND D D^DIQ
 W !,$S($P(IBND,"^",10):"**",1:"  "),"Effective Date: ",Y
 W ?36,"      Type: ",$P($P($P(^DD(354.1,.03,0),"^",3),$P(IBND,"^",3)_":",2),";",1)
 W !,"          Status: ",$P($P($P(^DD(354.1,.04,0),"^",3),$P(IBND,"^",4)_":",2),";",1)
 W ?36,"    Reason: ",$P($G(^IBE(354.2,+$P(IBND,"^",5),0)),"^")
 W !,"          Active: ",$S($P(IBND,"^",10):"YES, ACTIVE",1:"NO, INACTIVE")
 W ?36,"      User: ",$P($G(^VA(200,+$P(IBND,"^",7),0)),"^")
 W !,"       How Added: ",$P($P($P(^DD(354.1,.06,0),"^",3),$P(IBND,"^",6)_":",2),";",1)
 W ?36,"When Added: " S Y=$P(IBND,"^",8) D DT^DIQ
 I $P(IBND,"^",13)'="" W !,"Charges Canceled: " S Y=$P(IBND,"^",13) D DT^DIQ W ?36,"        To: " S Y=$P(IBND,"^",14) D DT^DIQ
 I $P(IBND,"^",15)'="" W !," Prior Threshold: " S Y=$P(IBND,"^",15) D DT^DIQ
 I $G(DUZ(0))="@" W !,"     Patient DFN: ",$P(IBND,"^",2),?36,"Ex. Number: ",IBDA
 W !
 Q
 ;
SET ; -- built tmp array ==> ^tmp($j, dfn, -eff date, -date/time added, da)
 N X
 S X=$G(^IBA(354.1,+IBDA,0)) Q:X=""
 S ^TMP($J,DFN,IBIDT,-$P(X,"^",8),IBDA)=X
 Q
