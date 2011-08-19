FHADR61 ; HISC/NCA - Nutritive Analysis Average ;12/29/93  13:54
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit Nutritive Analysis Average of one wk reg menu
 D YR^FHADR1 G:'PRE KIL
 S OLD=$P($G(^FH(117.3,PRE,3)),"^",2),Y=OLD X ^DD("DD") S OLD=Y
D1 S %DT="AEPX",%DT("A")="Enter Date Nutritive Analysis was taken: " S:OLD'="" %DT("B")=OLD W ! D ^%DT S:$D(DTOUT) X="^" G KIL:U[X,D1:Y<1 S SDT=+Y
 I SDT'<DT W *7,!?29,"  [Must Start before Today!] " G D1
 S YR=$E(SDT,1,3),S1=$E(SDT,4,5),QTR=$S(S1<4:2,S1<7:3,S1<10:4,1:1) S:QTR=1 YR=YR+1
 I YR'=$E(PRE,1,3) W *7,!?29,"  [Date Is Not Within the Fiscal Year!] " G D1
 S $P(^FH(117.3,PRE,3),"^",2)=SDT
 K DIC,DIE S DIE="^FH(117.3,",DA=PRE,DR="41:46"
 D ^DIE K DA,DIC,DIE,DR S OLD=PRE
SET ; Set all three quarters with the Nutritive Analysis Data
 F QTR=2:1:4 S PRE=$E(OLD,1,4)_QTR_"00",$P(^FH(117.3,PRE,3),"^",2,8)=$P($G(^FH(117.3,OLD,3)),"^",2,8)
KIL G KILL^XUSCLEAN
EN2 ; Print the Nutritive Analysis Average of one wk reg menu
 D HDR
 S PRE=FHYR_"0000",X1=""
 F L1=PRE:0 S L1=$O(^FH(117.3,L1)) Q:L1<1!($E(L1,1,3)'=$E(PRE,1,3))  S X=$P($G(^FH(117.3,L1,3)),"^",2,8) S:"^^^^^^"'[X X1=X
 I X1'="" D
 .S DTP=$P(X1,"^",1) D DTP^FH
 .W !?100,"Date Taken: ",DTP,!!
 .S TIT="Calories^%CHO^%PRO^%FAT^Mg CHOL^Mg Na"
 .W ?30 F L2=1:1:6 W $P(TIT,"^",L2)_":",$J($P(X1,"^",L2+1),5),"  "
 .Q
 Q
HDR ; Print Heading for Nutritive Analysis
 D:$Y'<(LIN-6) HDR^FHADRPT,HDR2^FHADR3A
 W !!!,"Nutritive Analysis 7 Days Average Regular Menu",!
 Q
