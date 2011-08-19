IBECPTE ;ALB/ARH - ENTER/EDIT CPT BILLING TIME SENS DATA (350.4&350.5) ; 11/5/91
 ;;2.0;INTEGRATED BILLING;**133**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; THIS FUNCTION IS OBSOLETE AND THE ROUTINE SHOULD BE DELETED WHEN 350.4 AND 350.5 ARE DELETED (133)
 ;
EN4 ;entry point - enter/edit procedure and rate group for amb surg billing (350.4)
 Q  ; 133
 D HOME^%ZIS
CPT W !! S DIC("A")="Select AMBULATORY SURGERY PROCEDURE: "
 S DIC="^SD(409.71,",DIC(0)="AEQL" D ^DIC K DIC G:Y<0 CPTQ S IBCPT=+Y
 I $P(Y,"^",3) S DIE="^SD(409.71,",DA=IBCPT,DR="[SD-AMB-PROC-EDIT]" D ^DIE K DIE,DR,DIC,Y G:'$D(DA) CPT K DA
 S IBEDT=0 D DISCPT,EFFCPT D:IBEDT DISCPT G CPT
CPTQ K IBCPT,IBEDT,DA,DTOUT,DUOUT,X,Y
 Q
 ;
EN5 ;entry point - enter/edit division and wage percentage data for amb surg billing (350.5)
 D HOME^%ZIS
DIV W !! S DIC("A")="Select MEDICAL CENTER DIVISION: "
 S DIC="^DG(40.8,",DIC(0)="AEQ" D ^DIC K DIC G:Y<0 DIVQ S IBDIV=+Y
 S IBEDT=0 D DISDIV,EFFDIV D:IBEDT DISDIV G DIV
DIVQ K IBDIV,IBEDT,DA,DTOUT,DUOUT,X,Y
 Q
 ;
EFFCPT ;enter/edit time sensitve procedure data
 ;DIR was used instead of DIC because of the size of the file and number of entries DIC would search through
 S DIR("?")="Enter the date the new rate or status becomes effective",DIR("??")="^D LISTCPT^IBECPTE"
 S DIR(0)="DO^::AEX",DIR("A")="Select PROCEDURE EFFECTIVE DATE" D ^DIR K DIR G:$D(DIRUT) EFFCPTQ S IBEFF=+Y
 I $D(^IBE(350.4,"AIVDT",IBCPT,-IBEFF)) S Y=$O(^(-IBEFF,"")) G EDITC
 S DIR(0)="Y",DIR("A")="Are you adding a new RATE GROUP entry to this PROCEDURE" D ^DIR K DIR G:'Y EFFCPT
 K DO,DD S DIC="^IBE(350.4,",DIC(0)="",X=IBEFF,DIC("DR")=".02////"_IBCPT D FILE^DICN K DIC G:Y<0 EFFCPTQ
EDITC S IBEDT=1,DR=".01;.04;I X=0 S Y=0;.03",DA=+Y,DIE="^IBE(350.4,",DIE("NO^")="BACK" D ^DIE K DIE,DIC,DR,DA,Y
 W ! G EFFCPT
EFFCPTQ K IBEFF,%DT,DR,DA,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 Q
 ;
EFFDIV ;enter/edit time sensitve division data
 S DIR("?")="Enter the date the new percentages or status becomes effective",DIR("??")="^D LISTDIV^IBECPTE"
 S DIR(0)="DO^::AEX",DIR("A")="Select PROCEDURE EFFECTIVE DATE" D ^DIR K DIR G:$D(DIRUT) EFFDIVQ S IBEFF=+Y
 I $D(^IBE(350.5,"AIVDT",IBDIV,-IBEFF)) S Y=$O(^(-IBEFF,""))  G EDITD
 S DIR(0)="Y",DIR("A")="Are you adding a new WAGE PERCENTAGE entry to this DIVISION" D ^DIR K DIR G:'Y EFFDIV
 K DO,DD S DIC="^IBE(350.5,",DIC(0)="",X=IBEFF,DIC("DR")=".02////"_IBDIV D FILE^DICN K DIC G:Y<0 EFFDIV
EDITD S DA=+Y,DIE="^IBE(350.5,",DR=".01;.04;I X=0 S Y=0;.05;.07",DIE("NO^")="BACK",IBEDT=1 D ^DIE K DIE,DIC,DR,DA,Y
 W ! G EFFDIV
EFFDIVQ K IBEFF,%DT,DR,DA,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 Q
 ;
DISCPT ;display data on procedure
 S X="IBXCPTR" X ^%ZOSF("TEST") Q:'$T
 W:$D(IOF) @IOF,?24,"Ambulatory Surgery Procedure Billing Profile"
 ;S D0=IBCPT D ^IBXCPTR K X,DXS,D0
 Q
 ;
DISDIV ;display data on division
 S X="IBXDIVD" X ^%ZOSF("TEST") Q:'$T
 W:$D(IOF) @IOF,?24,"Medical Center Division Billing Profile"
 S D0=IBDIV D ^IBXDIVD K X,DXS,D0
 Q
 ;
LISTCPT ;provide list of effective dates already defined for CPT
 Q:'$D(^IBE(350.4,"AIVDT",IBCPT))  N Y,IBX,IBY,IBLN
 S IBX="" F  S IBX=$O(^IBE(350.4,"AIVDT",IBCPT,IBX)) Q:IBX=""  D
 . S IBY="" F  S IBY=$O(^IBE(350.4,"AIVDT",IBCPT,IBX,IBY)) Q:IBY=""  D
 .. S IBLN=$G(^IBE(350.4,IBY,0)) Q:IBLN=""  S Y=-IBX X ^DD("DD")
 .. W !,?5,Y,?20,$P($$CPT^ICPTCOD(+$P(IBLN,"^",2)),"^",2),?30,$S($P(IBLN,"^",4):"ACTIVE",1:"INACTIVE"),?43,$P($G(^IBE(350.1,+$P(IBLN,"^",3),0)),"^",1)
 Q
 ;
LISTDIV ;provide list of effective dates already defined for division
 Q:'$D(^IBE(350.5,"AIVDT",IBDIV))  N Y,IBX,IBY,IBLN
 S IBX="" F  S IBX=$O(^IBE(350.5,"AIVDT",IBDIV,IBX)) Q:IBX=""  D
 . S IBY="" F  S IBY=$O(^IBE(350.5,"AIVDT",IBDIV,IBX,IBY)) Q:IBY=""  D
 .. S IBLN=$G(^IBE(350.5,IBY,0)) Q:IBLN=""  S Y=-IBX X ^DD("DD")
 .. W !,?4,Y,?20,$E($P($G(^DG(40.8,+$P(IBLN,"^",2),0)),"^",1),1,20),?43,$S($P(IBLN,"^",4):"ACTIVE",1:"INACTIVE"),?52,$J($P(IBLN,"^",5),7),?61,$J($P(IBLN,"^",6),7),?70,$J($P(IBLN,"^",7),7)
 Q
