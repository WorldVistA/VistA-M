IBARXEX1 ;ALB/AAS - RX COPAY INCOME EXEMPTION ROUTINE - MANUAL UPDATE OPTION, CONT. ; 16-NOV-92
 ;;Version 2.0 ; INTEGRATED BILLING ;**34**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
AUTO ; -- auto update of exemption reason file and billing pat file.
 ; -- if computes to pending but status is adjudicated quit
 N IBOLDAUT,IBFORCE
 I $$NETW^IBARXEU1,$P(IBSTAT,"^",5)=130 S X=$$LST^IBARXEU0(DFN,DT),Y=$P($G(^IBE(354.2,$P(X,"^",5),0)),"^",5) I Y=140!(Y=150) Q
 ;
 ; -- ask if sure
 S DIR(0)="Y",DIR("A")="Update Patient Billing Status",DIR("B")="NO" D ^DIR K DIR I $D(DIRUT)!(Y<1) S IBQUIT=1 G AUTOQ
 D SELCY^IBARXEX G:IBQUIT AUTOQ
 ;
 L +^IBA(354,DFN):5 I '$T W !,"Another User accessing Record, Try Again Later." G AUTOQ
 S IBCHANGE=1
 ;
 S (IBEVT,X)=$$STATUS^IBARXEU1(DFN,IBDT)
 ;
 ; -- not currently autoexempt, see if most recent is auto
 S IBOLDAUT=""
 I $L($P(^IBE(354.2,+IBEVT,0),"^",5))>2 D OLDAUT(IBEVT)
 ;
 ; -- first inactivate all entries for day
 S IBFORCE=$P(X,"^",2)
 ;
 ; -- for income, inactivate most recent
 D MOSTR^IBARXEU5($P(X,"^",2),+X)
 D ADDEX^IBAUTL6(+X,$P(X,"^",2),1,1,$G(IBOLDAUT))
 L -^IBA(354,DFN)
 ;W !!,"Entry Updated!"
AUTOQ K IBFORCE D PAUSE^IBOUTL
 Q
 ;
OLDAUT(X1) ; -- not currently autoexempt, most current is auto exempt delete
 ;    inactivate autoexempt
 N X
 S X=$$LSTAC^IBARXEU0(DFN) I $L(+X)'=3,$P(X,"^",2)'<$P(X1,"^",2) S IBOLDAUT=$P(X,"^",2)
 Q
 ;
MANUAL ; -- allow user to do manual change
 S DIR(0)="Y",DIR("A")="Do you wish to manually assign a Hardship Copay Exemption",DIR("B")="NO" D ^DIR K DIR I $D(DIRUT)!(Y<1) S IBQUIT=1 G MANUALQ
 ;
 D SELCY^IBARXEX G:IBQUIT MANUALQ
 S IBEXREA=$O(^IBE(354.2,"ACODE",2010,0)) ;only hardships
 S IBCODA=2010
 ;
 ; -- if current exemption is exempt can't give hardship
 S X=$$LST^IBARXEU0(DFN,IBDT)
 I +X'<(DT-100000),$P(X,"^",4) K IBEXREA W !!,"You can only give a hardship to a Non-Exempt patient",!,*7 G MANUALQ
 ;
 L +^IBA(354,DFN):5 I '$T W !,"Another User accessing record, Try Again Later." G MANUALQ
 S IBCHANGE=1
 S DIR(0)="Y",DIR("A")="Are You Sure" D ^DIR K DIR G:$D(DIRUT)!(Y<1) MANUALQ
 ;
 ; -- get electronic signature code
 D SIG^XUSESIG
 I X1=""!(X'=X1) W !,"Not your electronic signature" G MANUALQ
 S IBASIG=X1
 ;
 ; -- add new exemption
 D ADDEX^IBAUTL6(IBEXREA,IBDT,2,1)
 ;
MANUALQ L -^IBA(354,DFN)
 D PAUSE^IBOUTL
 Q
