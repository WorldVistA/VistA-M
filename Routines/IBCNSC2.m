IBCNSC2 ;ALB/NLR - INACTIVATE AND REPOINT INS STUFF ; 20-APR-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
MAIN ; -- main flow control
 ;
 S IBQUIT=0
 D START I IBQUIT G MAINQ
 D AP I IBQUIT G MAINQ
 I +IBV=1 D RPTASK^IBCNSC3
MAINQ K DFN,DIRUT,DIROUT,DTOUT,DUOUT,IBC,IBCOV,IBV,IBVER,IBV1,IBN,IBQUIT
 Q
 ;
 ;
START ; -- activate or inactivate insurance co. if necessary
 ;
 I $D(^IBT(356.2,"AIACT",IBCNS)) W !!,*7,"Please note that Insurance Reviews have been conducted with this company!!",!
 S IBV=$P(^DIC(36,IBCNS,0),U,5),IBV1=IBV,IBN=$P(^DIC(36,IBCNS,0),U)
 S IBA="ACTIVE",IBB="ACTIVATE",IBVER=0 I IBV S IBA="IN"_IBA
 I 'IBV S IBB="IN"_IBB
 S DIR("B")="No"
 S DIR(0)="YO",DIR("A")=""_IBN_" IS CURRENTLY "_IBA_".  DO YOU WISH TO "_IBB_" IT"
 S DIR("?",1)="Company should be INACTIVE if it is no longer"
 S DIR("?",2)="active in your area.  This will disallow users"
 S DIR("?")="from selecting this insurance company entry."
 D ^DIR K DIR I $D(DIRUT) S IBQUIT=1 G STARTQ
 I 'IBV,Y D VERIFY^IBCNSC3 G:IBQUIT STARTQ S IBVER=1
 I 'IBVER,IBV,Y S IBV=0
 ;
 ; -- change global if ins. co. activated or inactivated 
 I IBV1'=IBV S $P(^DIC(36,IBCNS,0),U,5)=IBV,IBCOV=1
 ;
 ; -- display number of patients with coverage from selected company
 S DFN=0,IBC=0 F  S DFN=$O(^DPT("AB",IBCNS,DFN)) Q:'DFN!(IBC>20)  S IBC=IBC+1
 W !!,"THERE "_$S(IBC=0:"ARE NO PATIENTS",IBC=1:"IS ONE PATIENT",IBC>20:"ARE MORE THAN 20 PATIENTS",1:"ARE "_IBC_" PATIENTS")_" COVERED BY THIS "_$S(+IBV=0:"(ACTIVE)",1:"(INACTIVE)")_" INSURANCE COMPANY...."
 I 'IBC D PAUSE^VALM1 S IBQUIT=1
STARTQ K IBA,IBB
 Q
 ;
AP ; -- ask if user wishes to print patients with inactivated insurance
 ;
 S DIR(0)="YO",DIR("A")="DO YOU WISH TO PRINT "_$S(IBC=1:"THE NAME OF THIS PATIENT",1:"A LIST OF ALL OF THE PATIENTS"),DIR("B")="No"
 W ! D ^DIR K DIR I 'Y!$D(DIRUT) S:$D(DIRUT) IBQUIT=1 D:$G(IBCOV) COVD^IBCNSC3 G APQ
 ;
 ; -- ask for device
 W !!,"*** You will need a 132 column printer for this report. ***",!
 S %ZIS="QM" D ^%ZIS I POP S IBQUIT=1 D:$G(IBCOV) COVD^IBCNSC3 G APQ
 I $D(IO("Q")) K IO("Q") S ZTRTN="PRINT^IBCNSC2",ZTSAVE("IB*")="",ZTDESC="PATIENTS WITH INACTIVATED INSURANCE" D ^%ZTLOAD K ZTSK D HOME^%ZIS Q
 U IO
 ;
PRINT ; -- print list of patients covered by inactivated insurance company
 ;
 D BUILD^IBCNSC3
 D HDR^IBCNSC3
 S IBNA="" F  S IBNA=$O(^TMP($J,"IBCNSC2",IBNA)) Q:IBNA=""!(IBQUIT)  S DFN=0 F  S DFN=$O(^TMP($J,"IBCNSC2",IBNA,DFN)) Q:'DFN!(IBQUIT)  S IBD=0 F  S IBD=$O(^TMP($J,"IBCNSC2",IBNA,DFN,IBD)) Q:'IBD!(IBQUIT)  D
 .S IBST=^TMP($J,"IBCNSC2",IBNA,DFN,IBD)
 .I $Y>(IOSL-5) D PAUSE^IBOUTL D HDR^IBCNSC3
 .W !,?1,$E(IBNA,1,28),?31,$P(IBST,"^",1),?46,$P(IBST,"^",2),?52,$$DAT1^IBOUTL($P(IBST,"^",3)),?63,$$DAT1^IBOUTL($P(IBST,"^",4)),?74,$P(IBST,"^",5),?95,$$EXPAND^IBTRE(2.312,6,$P(IBST,"^",6)),?106,$E($P(IBST,"^",7),1,24)
 I $E(IOST,1,2)["C-",('($G(IBV))) D PAUSE^VALM1
 K ^TMP($J,"IBCNSC2")
 ;
APQ I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IBPAG,IBNA,IBNO,IBIND,IBWI,VAOA,VA,VAERR
 Q
