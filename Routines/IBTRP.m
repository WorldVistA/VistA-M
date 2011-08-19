IBTRP ;ALB/AAS - CLAIMS TRACKING PARAMETER EDIT ; 27-JUN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% D DISP
 L +^IBE(350.9,1):5 I '$T D LOCKED^IBTRCD1 G END
 S DIE="^IBE(350.9,",DA=1,DR="4.01;6.01;6.02;6.03;6.04;6.05;6.23;6.06;I 'X S Y=""@50"";5.01;5.02;5.03;@50;6.08;6.09;6.13;6.14;6.18;6.19"
 D ^DIE K DA,DR,DIE
 L -^IBE(350.9,1)
 D DISP,PAUSE^IBOUTL
END Q
 ;
DISP ; -- Display tracking parameters
 I '$D(IOF) D HOME^%ZIS
 S IBTRKR=$G(^IBE(350.9,1,6))
 W @IOF,?22,"Claims Tracking Parameter Enter Edit"
 W !,$TR($J(" ",IOM)," ","-")
 W !!,"Initialization Date: ",$$DAT1^IBOUTL(+IBTRKR)
 W !,"Use Admission Sheet: ",$$EXPAND^IBTRE(350.9,6.06,$P(IBTRKR,"^",6))
 W !,"      Header line 1: ",$P($G(^IBE(350.9,1,5)),"^")
 W !,"      Header line 2: ",$P($G(^IBE(350.9,1,5)),"^",2)
 W !,"      Header line 3: ",$P($G(^IBE(350.9,1,5)),"^",3)
 W !!,"    Track Inpatient: ",$$EXPAND^IBTRE(350.9,6.02,$P(IBTRKR,"^",2))
 W ?40,"    Track Outpatient: ",$$EXPAND^IBTRE(350.9,6.03,$P(IBTRKR,"^",3))
 W !,"           Track Rx: ",$$EXPAND^IBTRE(350.9,6.04,$P(IBTRKR,"^",4))
D W ?40,"   Track Prosthetics: ",$$EXPAND^IBTRE(350.9,6.05,$P(IBTRKR,"^",5))
 W !," Reports can Add CT: ",$$EXPAND^IBTRE(350.9,6.23,$P(IBTRKR,"^",23))
 W !!,"    Medicine Sample: ",$J($P(IBTRKR,"^",8),3)
 W ?40,"      Surgery Sample: ",$J($P(IBTRKR,"^",13),3)
 W !,"Medicine Admissions: ",$J($P(IBTRKR,"^",9),3)
 W ?40,"  Surgery Admissions: ",$J($P(IBTRKR,"^",14),3)
 W !!,"       Psych Sample: ",$J($P(IBTRKR,"^",18),3)
 W !,"   Psych Admissions: ",$J($P(IBTRKR,"^",19),3)
 W !!!
 Q
