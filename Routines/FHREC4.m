FHREC4 ; HISC/REL - Recipe List ;3/6/95  15:50
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
 W !!,"The list requires a 132 column printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHREC4",FHLST="" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Recipe List
 D NOW^%DTC S DTP=% D DTP^FH
 K ^TMP($J) F D0=0:0 S D0=$O(^FH(114,D0)) Q:D0<1  S X=^(D0,0) D SET
 S PG=0 D HDR S CAT=";M:MIX;D:DEHYDRATED;F:FROZEN;C:CANNED;X:CONCENTRATED;S:SCRATCH;I:IND/R-T-S;P:PARTIALLY PREP;R:R-T-S;"
 S N2="" F K=0:0 S N2=$O(^TMP($J,N2)) Q:N2=""  S N1="" F L=0:0 S N1=$O(^TMP($J,N2,N1)) Q:N1=""  F D0=0:0 S D0=$O(^TMP($J,N2,N1,D0)) Q:D0<1  D LST
 W ! Q
LST D:$Y>(IOSL-8) HDR S X=$G(^FH(114,D0,0))
 W !,$P(X,"^",1),?31,$P(X,"^",9) W:N2'="*****" ?58,N2
 S Y=$P(X,"^",11) I Y'="" S %=$F(CAT,";"_Y_":") S:%>0 Y=$P($E(CAT,%,999),";",1)
 W ?74,Y,?93,$P(X,"^",10),?101,$S($P(X,"^",8)="N":"NO",1:"")
 S Y=$P(X,"^",13) W:Y ?107,$J(Y,6,3)
 I $O(^FH(114,D0,"R",0)) S FHLN="" W ?115,"   YES",!?5,"EMBEDDED RECIPES: " F FHEM=0:0 S FHEM=$O(^FH(114,D0,"R",FHEM)) Q:FHEM'>0  D
 .S FHEMZ=$P($G(^FH(114,D0,"R",FHEM,0)),U,1)
 .I FHLN=1 W !
 .W ?23,$E($P($G(^FH(114,FHEMZ,0)),U,1),1,31) S FHLN=1
 Q
SET S N1=$P(X,"^",1),N2=$P(X,"^",7) I N2 S N2=$P($G(^FH(114.1,N2,0)),"^",1)
 S:N2="" N2="*****" S ^TMP($J,N2,N1,D0)="" Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,DTP,?54,"R E C I P E   L I S T",?124,"Page ",PG
 W !!,"NAME",?31,"SYNONYM",?58,"CATEGORY",?74,"PRE-PREP STATE",?91,"E-PREP",?100,"PRINT    COST",?115,"RECIPES EMBEDDED?"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",! Q
KIL K ^TMP($J) G KILL^XUSCLEAN
