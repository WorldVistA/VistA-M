IBARXET ;ALB/AAS - RX COPAY EXEMPTION THRESHOLD ENTER/LIST ; 20-JAN-93
 ;;2.0;INTEGRATED BILLING;**26,74**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ADD ; -- add/edit new thresholds
 S IBTH=""
 S DIC="^IBE(354.3,",DIC(0)="AEQLMN",DLAYGO=354.3,DIC("DR")="" D ^DIC G ADDQ:Y<1
 S DA=+Y,DIE="^IBE(354.3,",DR="[IB ENTER THRESHOLD]" D ^DIE
 ;I $D(DA) S IBX=$G(^IBE(354.3,DA,0)),$P(IBX,"^",2)=2 D
 I $D(DA) S IBX=$G(^IBE(354.3,DA,0)),$P(IBX,"^",2)=$S($E($P(IBX,"^",1),1,5)<29612:2,1:1) D
 .I $P(IBX,"^",3)'="",$P(IBX,"^",4)'="",$P(IBX,"^",12)'="" Q
 .S DIK="^IBE(354.3," D ^DIK
 .W !!,"Entry Deleted, not enough information."
 .K DA,DIK
 .Q
 ;
 D:$D(DA)#2 PRIOR
 W ! G ADD
ADDQ K DLAYGO,DIC,DIE,DA,DR,X,Y,IBDA,IBTH,IBX
 Q
 ;
PRINT ; -- print threshold list
 I '$D(IOF) D HOME^%ZIS
 W @IOF,?15,"Print Medication Copayment Income Thresholds",!!!
 W !!,"You will need a 132 column printer for this report!",!
 S DIC="^IBE(354.3,",L=0,FLDS="[IB PRINT THRESHOLD]",BY="[IB PRINT THRESHOLD]",FR="?,?",TO="?,?"
 S DHD="Medication Copayment Income Thresholds"
 D EN1^DIP
PRINTQ K L,FLDS,BY,FR,TO,DHD,DIC
 Q
 ;
PRIOR ; -- check to see if prior year thresholds used
 S IBPR=$G(^IBE(354.3,+DA,0)) I IBPR="" G PRIORQ
 ;I $P(IBPR,"^",2)'=2 G PRIORQ
 S X=$S($P(IBPR,"^",2)=2:1,$P(IBPR,"^",2)=1:1,1:"") G:X="" PRIORQ
 ;S IBPRDT=$O(^IBE(354.3,"AIVDT",2,-($P(IBPR,"^")))) ;threshold prior to the one entered
 S X=$S($E($P(IBPR,"^"),1,5)'<29712:1,1:2) S IBPRDT=$O(^IBE(354.3,"AIVDT",X,-($P(IBPR,"^")))) ;threshold prior to the one entered
 I IBPRDT<0 S IBPRDT=-IBPRDT ; minus a negative to make positive
 G:IBPRDT="" PRIORQ I '$D(^IBA(354.1,"APRIOR",IBPRDT)) G PRIORQ
 ;
 ; -- is exemptions based on prior thresholds
 W !!,"There are Medication Copayment Exemptions based on prior thresholds",!
 S DIR("?")="There are exemptions that were based on the threshold values over a year old.  You can ignore this, print a list of patients with old exemptions, or automatically update while printing the same list"
 S DIR(0)="S^1:IGNORE;2:PRINT;3:UPDATE AND PRINT",DIR("A")="Select ACTION",DIR("B")="IGNORE" D ^DIR K DIR I $D(DIRUT)!(Y<2)!(Y>3) G PRIORQ
 S IBACT=Y
 ;
 S %ZIS="QM" D ^%ZIS G:POP PRIORQ
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^IBARXET",ZTDESC="IB PRIOR YEAR THRESHOLD PRINT"_$S(IBACT=3:" AND UPDATE",1:""),ZTSAVE("IB*")="" D ^%ZTLOAD K ZTSK D HOME^%ZIS G PRIORQ
 U IO
 ;
DQ ; -- entry point from tasking
 S (IBQUIT,IBPAG)=0 D NOW^%DTC S Y=% D D^DIQ S IBPDAT=Y
 K ^TMP($J,"IBPRIOR") S IBJOB=17
 D HDR
 S IBEX=""
 F  S IBEX=$O(^IBA(354.1,"APRIOR",IBPRDT,IBEX)) Q:IBEX=""  D SET
 ;
 S IBNAM=""
 F  S IBNAM=$O(^TMP($J,"IBPRIOR",IBNAM)) Q:IBNAM=""!IBQUIT  D
 .S DFN="" F  S DFN=$O(^TMP($J,"IBPRIOR",IBNAM,DFN)) Q:DFN=""!IBQUIT  D
 ..S IBXXX=0 F  S IBXXX=$O(^TMP($J,"IBPRIOR",IBNAM,DFN,IBXXX)) Q:'IBXXX!IBQUIT  S IBP=^(IBXXX) D ONE
 ;
 I 'IBQUIT D PAUSE^IBOUTL
 K ^TMP($J,"IBPRIOR")
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
PRIORQ K X,Y,DFN,DIR,DIRUT,IBACT,IBPR,IBPRDT,IBQUIT,IBPAG,IBPDAT,IBPRIOR
 K IBEX,IBNAM,IBND,IBP,IBEXREA,IBJOB,IBQUIT,IBXXX,IBWHER,IBEXERR,IBADDE,IBADD,IBCODA,IBCODP
 Q
 ;
HDR ; -- print prior threshold header
 I IBPAG!($E(IOST,1,2)="C-") W @IOF,*13
 S IBPAG=IBPAG+1
 W "Exemptions Based on Prior Year Thresholds",?(IOM-35),$P(IBPDAT,"@")," @ ",$P(IBPDAT,"@",2)," Page ",IBPAG
 W !,"Patient",?22,"PT. ID",?36,"Exemption Date",?52,"Status" W:IBACT=3 ?63,"Action"
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
SET ; -- set up sortable array by patient
 S IBND=$G(^IBA(354.1,IBEX,0)) Q:IBND=""
 S DFN=$P(IBND,"^",2),IBP=$$PT^IBEFUNC(DFN)
 S ^TMP($J,"IBPRIOR",$P(IBP,"^"),DFN,IBEX)=IBEX_"^"_IBP
 Q
 ;
ONE ; -- print line for one patient
 S IBEX=+IBP,IBP=$P(IBP,"^",2,5)
 I $Y>(IOSL-5) D PAUSE^IBOUTL G:IBQUIT ONEQ D HDR
 S IBND=$G(^IBA(354.1,IBEX,0)) G ONEQ:IBND=""
 S Y=+IBND D D^DIQ
 W !,$E(IBNAM,1,20),?22,$P(IBP,"^",2),?36,Y,?52,$$TEXT^IBARXEU0($P(IBND,"^",4))
 ;
 ; -- compute exempt, add if different, else delete prior
 G:IBACT'=3 ONEQ
 S IBEXREA=$$STATUS^IBARXEU1(DFN,+IBND)
 I +IBEXREA'=$P(IBND,"^",5) D ADDEX^IBAUTL6(+IBEXREA,+IBND,1,1) W ?63,"Exemption updated"
 I +IBEXREA=$P(IBND,"^",5) S DA=IBEX,DIE="^IBA(354.1,",DR=".15///@" D ^DIE W ?63,"No Change"
 K DIE,DA,DR,DIC
ONEQ Q
