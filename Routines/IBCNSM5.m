IBCNSM5 ;ALB/NLR - INSURANCE MANAGEMENT WORKSHEET ; 23-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G EN^IBCNSM
 ;
WPPC ; -- print insurance management worksheet, insurance coverage
 ;
 I '$G(IBCPOL) D  G WPPCQ
 .D FULL^VALM1
 .W !!,"There is no plan associated with this policy!"
 .W !!,"Please use the action 'Change Plan Info', which will create a plan"
 .W !,"for the policy."
 .N DIR,DTOUT,DUOUT,DIROUT S DIR(0)="E" W ! D ^DIR
 ;
 N IBCAB,IBPIB1,IBPAG,IBQUIT,IBW
 S IBPIB1=1,IBW=1
 D GETEN1 I ('($G(IBW)))!(IBYR<(DT-10000)&($G(IBLINE)))!($D(DIRUT)) G WPPCQ
 D DEV
 I $G(IBQUIT) G WPPCQ
DQ ;
 S IBPAG=0,IBHDT=$$HTE^XLFDT($H,1)
 D PR
 D:IBCY GETEN2
 D:IBYR&IBCY PR
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
WPPCQ I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IBCPOL,IBYR,IBPIB1,IBW
 Q 
PR ; -- set variables needed for file navigation, print insurance worksheet or coverage
 ;
 D SETVAR
 D PRINT
PRQ Q
 ;
GETEN1 ; -- find IEN of most recent policy
 ;
 ;N IBCDFND,IBCDFND1,IBCDFND2
 ;I $G(IBYR)="" S IBYR=DT
 ;I '$G(IBCPOL) S IBCPOL=$P($G(^IBA(355.4,$G(DA),0)),"^",2)
 ;I 'IBCPOL G GETEN1Q
 S IBYR=$O(^IBA(355.4,"APY",IBCPOL,-(DT+.0001))) I IBYR S:IBYR<0 IBYR=-IBYR
 I ('IBYR),'IBLINE D ASK I ($D(DIRUT))!('($G(IBW))) G GETEN1Q
 I $G(IBLINE)&(('IBYR)!(IBYR<(DT-10000))) S IBYR=DT
 S IBCAB="" S IBCAB=$O(^IBA(355.4,"APY",IBCPOL,-IBYR,IBCAB))
 ;W !!,"DATE OF PREVIOUS ENTRY IS "_$$DAT1^IBOUTL(IBYR),!! H 3
 ;I IBYR<(DT-10000),IBLINE S IBYR=DT
 ;I IBYR<(DT-10000),IBLINE W !!,"MOST RECENT ENTRY IS "_$$DAT1^IBOUTL(IBYR)_".  ENTRY CANNOT BE MORE THAN A YEAR OLD.",!!,"YOU MAY PRINT ENTRY UNDER 'PC'.",!! H 4
GETEN1Q Q
 ;
SETVAR ; -- set variables needed for file navigation
 ;
 S IBCDFND=$G(^DPT(DFN,.312,$P(IBPPOL,"^",4),0)),IBCNS=+IBCDFND
 S IBCDFND1=$G(^DPT(DFN,.312,$P(IBPPOL,"^",4),1))
 S IBCDFND2=$G(^DPT(DFN,.312,$P(IBPPOL,"^",4),2))
 S IBCDFNDA=$G(^DIC(36,+IBCDFND,.11))
 S IBCDFNDB=$G(^DIC(36,+IBCDFND,.13))
 S IBCPOL=+$P(IBCDFND,"^",18),IBCNS=+IBCDFND,IBCDFN=$P(IBPPOL,"^",4)
 S IBCPOLD=$G(^IBA(355.3,+$P(IBCDFND,"^",18),0))
 S FILE="^DPT("_DFN_",.312,"
 S IBCBU=$O(^IBA(355.5,"APPY",DFN,IBCPOL,-IBYR,IBCDFN,0))
 S IBCBUD=$G(^IBA(355.5,+IBCBU,0))
 S IBCBUD1=$G(^IBA(355.5,+IBCBU,1))
 S IBCGN=$$GRP^IBCNS(IBCPOL)
 S IBPAT=1
 S IBCABD=$G(^IBA(355.4,+IBCAB,0))
 S IBCABD2=$G(^IBA(355.4,+IBCAB,2))
 S IBCABD3=$G(^IBA(355.4,+IBCAB,3))
 S IBCABD4=$G(^IBA(355.4,+IBCAB,4))
 S IBCABD5=$G(^IBA(355.4,+IBCAB,5))
 Q
 ;
DEV ; -- ask for device
 ;
 W !!,"*** You will need a 132 column printer for this report. ***",!
 S %ZIS="QM" D ^%ZIS I POP S IBQUIT=1 G R1Q
 I $D(IO("Q")) K IO("Q") S IBQUIT=1,ZTRTN="DQ^IBCNSM5",ZTSAVE("IB*")="",ZTSAVE("DFN")="",ZTDESC="INSURANCE MANAGEMENT WORKSHEET" D ^%ZTLOAD K ZTSK D HOME^%ZIS Q
 I $E(IOST,1,2)="C-" D FULL^VALM1
 U IO
R1Q Q
 ;
PRINT ; -- print insurance management worksheet/insurance coverage
 ;
 D PID^VADPT
 D HDR
 D BL1^IBCNSM6,BL2^IBCNSM7,BL3^IBCNSM8,BL4^IBCNSM8,BL5^IBCNSM9,BL6^IBCNSM9,BL7^IBCNSM9
 Q
 ;
HDR ; -- print header
 ;
 I $E(IOST,1,2)["C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 W:$E(IOST,1,2)["C-"!($G(IBPAG)) @IOF
 S IBPAG=$G(IBPAG)+1
 W !,$S($G(IBLINE):"INSURANCE MANAGEMENT WORKSHEET",1:"INSURANCE COVERAGE FOR "_$S($G(IBPIB1):"CURRENT ENTRY",1:"NEXT-MOST-CURRENT ENTRY")),?(IOM-30),IBHDT,"  PAGE ",IBPAG
 W !,$TR($J(" ",IOM)," ","_")
 D DEM^VADPT
 W !!,VADM(1),?34,"PT ID:  "_VA("PID"),?79,"DOB:  "_$P(VADM(3),"^",2)
 W !,$E($P($G(^DIC(36,+IBCDFND,0)),"^"),1,28),?31," GROUP #:  ",$$DOL^IBCNSM6(355.3,.04,$P(IBCPOLD,"^",4),$G(IBLINE))
 W ?74,"For YEAR:  "_$S($G(IBCAB):$$DAT1^IBOUTL(IBYR),1:"______________")
 W !?30,"Ins. Type:  ",$$DOL^IBCNSM6(355.1,.01,$P($G(^IBE(355.1,+$P(IBCPOLD,"^",9),0)),"^"),$G(IBLINE))
 Q
 ;
GETEN2 ; -- get IEN of next-to-most-recent entry (Print Coverage)
 ;
 S IBYR=$O(^IBA(355.4,"APY",IBCPOL,-IBYR)) I 'IBYR G PR1Q
 S:IBYR<0 IBYR=-IBYR
 S IBCAB="" S IBCAB=$O(^IBA(355.4,"APY",IBCPOL,-IBYR,IBCAB))
 S IBPIB1=0
PR1Q Q
 ;
ASK ; -- if Print Coverage and no benefit years for selected policy, ask if user wants worksheet 
 ;
 W !
 S DIR(0)="YO",DIR("A")="No Benefit Years on File.  Do you want to fill out a worksheet",DIR("B")="No"
 W !
 D ^DIR K DIR I $D(DIRUT) S IBQUIT=1 G ASKQ
 I Y S IBW=1,IBLINE=1,IBCY=0 G ASKQ
 S IBW=0 D PAUSE^VALM1
ASKQ ;
 Q
