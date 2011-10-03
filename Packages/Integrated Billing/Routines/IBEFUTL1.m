IBEFUTL1 ;ALB/MJK/AAS - Re-Compile Templates/x-refs ; 1/31/92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; ******* DO NOT MAP THIS ROUTINE *******
 Q
 ;
EN ; Entry point to re-compile templates
 ; input: IBKIND = OUTPUT or INPUT
 ;
 K IBLINE S U="^",$P(IBLINE,"=",81)="",IBMAX=^DD("ROU")
 G ENQ:'$D(IBKIND),ENQ:"^OUTPUT^INPUT^"'[(U_IBKIND_U)
 I IBKIND="OUTPUT" S IBFILE="^DIPT",IBROU="EN^DIPZ"
 I IBKIND="INPUT" S IBFILE="^DIE",IBROU="EN^DIEZ"
 W !,IBLINE,!?20,"Recompilation of '",IBKIND,"' Templates",!,IBLINE
 ;
 S IBX="IAzzz" F IBI=1:1 S IBX=$O(@IBFILE@("B",IBX)) Q:IBX=""!($E(IBX,1,2)'="IB")  S Y=+$O(^(IBX,0)) I $D(@IBFILE@(Y,"ROUOLD")),^("ROUOLD")]"",$D(^(0)) S (IBEMP,Y)=Y,X=$P(^("ROUOLD"),"^"),IB0=^(0) D COMP
 ;
ENQ K IBROU,IB0,IBX,IBI,IBMAX,IBEMP,IBFILE,IBI,IBLINE Q
 ;
COMP ; re-compile
 ;
 ;
 S DMAX=IBMAX D @IBROU W !!,IBLINE
COMPQ Q
 ;
ALL ; compile templates and x-refs
 S:'$D(DTIME) DTIME=300 S U="^"
 S DIR(0)="Y",DIR("A")="Re-compile all 'IB' templates and cross references"
 S DIR("?",1)="Yes to re-compile",DIR("?",2)="No  to stop recompilation process",DIR("?")=" "
 D ^DIR K DIR G ALLQ:'Y
 D DIEZ W !!
 D DIPZ W !!
 D DIKZ
 W !!,"...Done.",!!,"NOTE: Recompilation should be performed on ALL systems."
ALLQ K A,C,L,O,X1,DQ,DIE,DMAX,DIEZ,DIEZDUP,DK,DR Q
 ;
DIEZ ; -- re-compile all IB 'edit' templates
 S IBKIND="INPUT" D EN K IBKIND Q
 ;
DIPZ ; -- re-compile all IB 'print' templates
 S IBKIND="OUTPUT" D EN K IBKIND Q
 ;
DIKZ ; -- compile x-refs
 W !!,">>> Compiling cross references for  BILL/CLAIMS, INTEGRATED BILLING, and ENCOUNTER FORM files:"
 F IBN=399,350,357,357.1,357.2,357.3,357.4,357.5 S N=IBN W ! I $D(^DD(+N,0,"DIK"))#2 S X=^("DIK"),Y=+N,DMAX=^DD("ROU") W !,"** File "_IBN_" **",! D EN^DIKZ
 K IBN,N,DMAX
 Q
