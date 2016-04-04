DITC3 ;SFISC/XAK-COMPARE FILE ENTRIES ;9/17/91  3:12 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:1:(IOSL-$Y-1) W !
 W "Enter RETURN to continue: " R X:DTIME S:'$T DTOUT=1
ASK Q:$D(DTOUT)  K DUOUT,DIRUT W @IOF,!,"OK.  I'M READY TO DO THE MERGE."
 S DIR(0)="S^P:PROCEED to merge the data;S:SUMMARIZE the modifications before proceeding;E:EDIT the data again before proceeding"
 S DIR("A")="ACTION" D ^DIR K DIR
 Q:$D(DIRUT)  I Y="E" D ^DITC2 Q:$D(DTOUT)  G ASK:X=U,DITC3:$D(^UTILITY($J,"DIT",U)),ASK
 S DIACT=Y,DNUM=0 D ACT Q:DIACT="P"  G:$D(DIRUT) ASK G DITC3
ACT ;
 I DIACT="S" D SUMHD
 S DIT1="" F K=0:0 Q:$D(DTOUT)  S DIT1=$O(^UTILITY($J,"DIT",DIT1)) Q:DIT1=""  S DIT2="" F K=0:0 Q:$D(DTOUT)  S DIT2=$O(^UTILITY($J,"DIT",DIT1,DIT2)) Q:DIT2=""  S X(0)=^(DIT2,0),%=$P(X(0),U,3) I %,DDEF'=% D EACH
 W !!,?2,"NOTE: Multiples will be merged into the target record"
 K DIT1,DIT2 Q
EACH ;
 I DIACT="S" G SUMEACH
 S DIE=DFF(1),DA=$P(DIT(DDEF),","),X2=$S($D(^UTILITY($J,"DITI",DIT1,DIT2,%)):^(%),'$D(^UTILITY($J,"DIT",DIT1,DIT2,%)):"@",1:^(%))
 S DR=+X(0)_"///"_X2 D ^DIE W "."
 K DR,DIE Q
SUMHD ;
 W @IOF,!,"SUMMARY OF MODIFICATIONS TO ",$P(DHD(DFL),U,DDEF),!,"FIELD",?DV,$S(DDEF=1:"OLD",1:"NEW")," VALUE",?(DV*2),$S(DDEF=1:"NEW",1:"OLD")," VALUE",!,DDSH
 Q
SUMEACH ;
 I $Y+5>IOSL K DIR S DIR(0)="E" D ^DIR K DIR Q:$D(DIRUT)  D SUMHD
 K D S X2="",X(0)=$P(X(0),U,2) F I=1:1:2 S X(I)=$S($D(^UTILITY($J,"DIT",DIT1,DIT2,I)):^(I),1:"")
 D D20^DITC2
 Q
