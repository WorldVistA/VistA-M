RMPFQIP ;DDC/KAW-PRINT PRODUCT LISTS [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 Q:'$D(RMPFIT)!'$D(RMPFPG)  S PA=1,Y=DT D DD^%DT S DP=Y K ^TMP("RMPF",$J)
 S MU=$O(^RMPF(791810.5,"C",RMPFMENU,0)) G END:'MU S P=-1
 I RMPFPG S P=RMPFPG G U11:RMPFIT="*" Q:'RMPFIT  S I=RMPFIT G U3
U1 S P=$O(^RMPF(791811,"AC",P)) G PRINT:'P
U11 S I=0
U2 S I=$O(^RMPF(791811,"AC",P,I)) I 'I G PRINT:RMPFPG,U1
U3 G U2:I=1,U2:'$D(^RMPF(791811,I,0)) S S0=^(0) I $D(^("I")),$P(^("I"),U) G U2
 S IT=$P(S0,U,1),MK=$P(S0,U,2),PG=$P(S0,U,3) S:MK="" MK=0
 G U2:'PG,U2:'$D(^RMPF(791811.1,PG,101,"B",MU))
 S CS=$P(S0,U,4),NN=$P(S0,U,5)
 I PG,$D(^RMPF(791811.1,PG,0)) S PG=$P(^(0),U,1)
 S ^TMP("RMPF",$J,PG,MK,IT,I)=NN_U_CS
 G U2:'RMPFIT
PRINT S (CT,PG)=0
PG S PG=$O(^TMP("RMPF",$J,PG)) G EXIT:PG=""
 S X=$O(^RMPF(791811.1,"B",PG,0)),PP=0
 I X,$D(^RMPF(791811.1,X,0)) S PP=$P(^(0),U,2)
IT S MK=-1,PP=$S(PP="CHA"!(PP="SHA")!(PP="ALD"):0,1:1) D HEAD
 D @("HEAD"_PP)
IT1 S MK=$O(^TMP("RMPF",$J,PG,MK)) I MK="" D CONT:IOST?1"C-".E G PG
 S IT=0
IT2 S IT=$O(^TMP("RMPF",$J,PG,MK,IT)) G IT1:IT="" S DA=0
IT3 S DA=$O(^TMP("RMPF",$J,PG,MK,IT,DA)) G IT2:'DA,IT3:DA=1
 G IT3:'$D(^RMPF(791811,DA,0)) S S0=^(0) I $D(^("I")),$P(^("I"),U) G IT3
 S CS=$P(S0,U,4),MR=$P(S0,U,6),UI=$P(S0,U,8),NN=$P(S0,U,5) S:'UI UI=1
 S AM=$P(S0,U,9) ;I MR S CS=CS*(1+(MR*.01))
 I $Y>(IOSL-3),IOST?1"C-".E D CRT G END:$D(RMPFOUT)
 I $Y>58,IOST?1"P-".E D PRT
 I 'PP D AIDS G END:$D(RMPFOUT) G IT3:'RMPFIT,EXIT
 W !!,$E(IT,1,30),?33,$J(CS,8,2),?43,$J(UI,7,0),?58,NN,?76,AM S CT=CT+1
 G IT3:'RMPFIT
EXIT W !!,"Total Items Printed: ",CT W:IOST?1"P-".E @IOF
 D:$D(IO("S")) ^%ZISC
END K B,BP,BT,C,C1,CM,CP,CS,CT,DA,DP,I,IT,MK,NN,PA,PG,S0,P,Y,^TMP("RMPF",$J)
 K RMPFBT,RMPFCM,RMPFIT,RMPFOUT,RMPFPG,RMPFQUT,PP,UI,X,POP,MR,CD,AM Q
AIDS D WRITE S (CM,BT)=0,CT=CT+1 K RMPFBT,RMPFCM
 F I=1:1 S BT=$O(^RMPF(791811,DA,102,BT)) Q:'BT  I $D(^(BT,0)) S B=$P(^(0),U,1) I B,$D(^RMPF(791811.3,B,0)) S BP=$P(^(0),U,1),RMPFBT(BP)=""
 F I=1:1 S CM=$O(^RMPF(791811,DA,101,CM)) Q:'CM  I $D(^(CM,0)) S C=$P(^(0),U,1) I C,$D(^RMPF(791811.2,C,0)) S CP=$P(^(0),U,1),CD=$P(^(0),U,3) I CP'="" S RMPFCM(CP)=$P(^RMPF(791811,DA,101,CM,0),U,2)_U_CD
 S (BT,CM)=0
 F I=1:1 Q:'$D(RMPFCM)&'$D(RMPFBT)  D  Q:$D(RMPFOUT)
 .W:C1 ! S C1=C1+1
 .S BT=$O(RMPFCM(BT))
 .I BT'="" S (X,S)=$P(RMPFCM(BT),U,1) S:MR="TAKE THIS OUT" S=X*(1+(MR*.01)) W ?37,$E(BT,1,19),?58,$E($P(RMPFCM(BT),U,2),1,8),?68,$J(S,5,2) K RMPFCM(BT)
 .S CM=$O(RMPFBT(CM)) I CM'="" W ?75,$E(CM,1,8) K RMPFBT(CM)
 .I $Y>21,IOST?1"C-".E D CRT Q:$D(RMPFOUT)  D WRITE
 .I $Y>58,IOST?1"P-".E D PRT
 .Q
 Q
WRITE W !!,$E(IT,1,16),?18,$E(MK,1,9),?29,$J(CS,6,2) S C1=0 Q
CONT F  Q:$Y>22  W !
 W !,"Enter <RETURN> to continue." D READ Q:$D(RMPFOUT)
 I $D(RMPFQUT) W !!,"Enter a <RETURN> to continue viewing or an <^> to exit." G CONT
 Q:Y=""  G CONT Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
CRT D CONT Q:$D(RMPFOUT)  D HEAD,@("HEAD"_PP) W !,"cont." Q
PRT D HEAD,@("HEAD"_PP) W !,"cont." Q
HEAD W @IOF,!?27,"REMOTE ORDER/ENTRY SYSTEM",?72,"page: ",PA S PA=PA+1
 W !?32,"PRODUCT LISTING"
 W !!,"Product Group: ",PG,?56,"Print Date: ",DP
 W ! F I=1:1:80 W "-"
 Q
HEAD0 W !?5,"Model",?20,"Make",?29,"Price",?42,"Component",?60,"Code"
 W ?68,"Price",?75,"Batt."
 W !,"----------------",?18,"---------",?29,"------",?37,"-------------------",?58,"--------"
 W ?68,"-----",?75,"-----"
 Q
HEAD1 W !?13,"Item",?35,"Price",?43,"Unit of Issue",?64,"NSN",?76,"AMIS"
 W !,"-------------------------------",?33,"--------",?43,"-------------",?58,"----------------",?76,"----"
 Q
