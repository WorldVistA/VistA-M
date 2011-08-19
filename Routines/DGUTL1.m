DGUTL1 ;ALB/MJK - Re-Compile Templates/x-refs ; 8/8/90;
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ; ******* DO NOT MAP THIS ROUTINE *******
 Q
 ;
EN ; Entry point to re-compile templates
 ; input: DGKIND = OUTPUT or INPUT
 ;
 K DGLINE S U="^",$P(DGLINE,"=",81)="",DGMAX=^DD("ROU")
 G ENQ:'$D(DGKIND),ENQ:"^OUTPUT^INPUT^"'[(U_DGKIND_U)
 I DGKIND="OUTPUT" S DGFILE="^DIPT",DGROU="EN^DIPZ"
 I DGKIND="INPUT" S DGFILE="^DIE",DGROU="EN^DIEZ"
 W !,DGLINE,!?20,"Recompilation of '",DGKIND,"' Templates",!,DGLINE
 ;
 F DGX="DFzzzz","SCzzzz" F DGI=1:1 S DGX=$O(@DGFILE@("B",DGX)) Q:DGX=""!("^DG^SD^"'[(U_$E(DGX,1,2)_U))  S Y=+$O(^(DGX,0)) I $D(@DGFILE@(Y,"ROUOLD")),^("ROUOLD")]"",$D(^(0)) S (DGEMP,Y)=Y,X=$P(^("ROUOLD"),"^"),DG0=^(0) D COMP
 ;
ENQ K DGROU,DG0,DGX,DGI,DGMAX,DGEMP,DGFILE,DGI,DGLINE Q
 ;
COMP ; re-compile
 I DGKIND="INPUT",$P(DG0,U)="DG TEN" G COMPQ
 I $P(DG0,U)?1"DGHI".E G COMPQ ; excludes HINQ templates
 S DMAX=DGMAX D @DGROU W !!,DGLINE
COMPQ Q
 ;
ALL ; compile templates and x-refs
 S:'$D(DTIME) DTIME=300 S U="^"
 S DIR(0)="Y",DIR("A")="Re-compile all 'DG' and 'SD' templates and cross references"
 S DIR("?",1)="Yes to re-compile",DIR("?",2)="No  to stop recompilation process",DIR("?")=" "
 D ^DIR K DIR G ALLQ:'Y
 D DIEZ W !!
 D DIPZ W !!
 D DIKZ
 W !!,"...Done.",!!,"NOTE: Recompilation should be performed on ALL systems."
ALLQ K A,C,L,O,X1,DQ,DIE,DMAX,DIEZ,DIEZDUP,DK,DR Q
 ;
DIEZ ; -- re-compile all DG and SD 'edit' templates
 S DGKIND="INPUT" D EN K DGKIND Q
 ;
DIPZ ; -- re-compile all DG and SD 'print' templates
 S DGKIND="OUTPUT" D EN K DGKIND Q
 ;
DIKZ ; -- compile x-refs
 W !!,">>> Compiling cross references for PTF, PATIENT MOVEMENT,",!,"INDIVIDUAL ANNUAL INCOME, INCOME RELATION",!,"and ANNUAL MEANS TEST files:"
 F DGN=45,405,408.21,408.22,408.31 S N=DGN W ! I ^DD("VERSION")>17.5,$D(^DD(+N,0,"DIK"))#2 S X=^("DIK"),Y=+N,DMAX=^DD("ROU") D EN^DIKZ
 K DGN,N,DMAX
 Q
