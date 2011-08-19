IBDFUTI ;ALB/AAS - Installation utilitie Re-Compile Templates/x-refs ; 1/31/92
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
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
 S IBDX="IBCzzz"
 F IBI=1:1 S IBDX=$O(@IBFILE@("B",IBDX)) Q:IBDX=""!($E(IBDX,1,3)'="IBD")  S Y=+$O(^(IBDX,0)) D
 .I $D(@IBFILE@(Y,"ROUOLD")),^("ROUOLD")]"",$D(^(0)) S (IBEMP,Y)=Y,X=$P(^("ROUOLD"),"^"),IB0=^(0) D COMP
 ;
ENQ K IBROU,IB0,IBDX,IBI,IBMAX,IBEMP,IBFILE,IBI,IBLINE Q
 ;
COMP ; re-compile
 ;
 ;
 S DMAX=IBMAX D @IBROU W !!,IBLINE
COMPQ Q
 ;
ALL ; compile templates and x-refs
 S DIR(0)="Y",DIR("A")="Re-compile all AICS 'IBD' templates and cross references"
 S DIR("?",1)="Yes to re-compile",DIR("?",2)="No  to stop recompilation process",DIR("?")=" "
 D ^DIR K DIR G ALLQ:'Y
 D DIEZ W !!
 D DIPZ W !!
 D DIKZ
 W !!,"...Done.",!!,"NOTE: Recompilation should be performed on ALL systems."
ALLQ K A,C,L,O,X1,DQ,DIE,DMAX,DIEZ,DIEZDUP,DK,DR Q
 ;
DIEZ ; -- re-compile all IBD 'edit' templates
 S IBKIND="INPUT" D EN K IBKIND Q
 ;
DIPZ ; -- re-compile all IB 'print' templates
 S IBKIND="OUTPUT" D EN K IBKIND Q
 ;
DIKZ ; -- compile x-refs
 W !!,">>> Compiling cross references for  BILL/CLAIMS, INTEGRATED BILLING, and ENCOUNTER FORM files:"
 F IBN=357,357.1,357.2,357.3,357.4,357.5 S N=IBN W ! I $D(^DD(+N,0,"DIK"))#2 S X=^("DIK"),Y=+N,DMAX=^DD("ROU") W !,"** File "_IBN_" **",! D EN^DIKZ
 K IBN,N,DMAX
 Q
