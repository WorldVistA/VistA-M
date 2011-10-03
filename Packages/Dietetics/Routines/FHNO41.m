FHNO41 ; HISC/REL/RVD - List Bulk Nourishments ;7/14/93  10:13
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
 ;patch #5 - modify report; print total for every location.
 S D1=$O(^FH(119.74,0)) I D1'<1,$O(^FH(119.74,D1))<1 G N3
N2 R !!,"Select SUPPLEMENTAL FEEDING SITE (or ALL): ",X:DTIME G:'$T!("^"[X) KIL I (X="ALL")!(X="all") S D1=0 G N3
 K DIC S DIC="^FH(119.74,",DIC(0)="EMQ" D ^DIC G:Y<1 N2 S D1=+Y
N3 R !!,"Do you want Labels? N// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Enter YES or NO" G N3
 S X=$E(X,1),LAB=X="Y"
 S FHLBFLG=1 I LAB D  I FHLBFLG=0 Q
 .W ! K DIR,LABSTART S DIR(0)="NA^1:10",DIR("A")="If using laser label sheets, what row do you want to begin printing at? ",DIR("B")=1 D ^DIR
 .I $D(DIRUT) S FHLBFLG=0 Q
 .S LABSTART=Y Q
 W ! K IOP,%ZIS S %ZIS("A")="Select "_$S(LAB:"LABEL",1:"LIST")_" Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHNO41",FHLST="D1^LAB^LABSTART" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Process Printing Bulk Nourishments
 K ^TMP($J) D NOW^%DTC S DTP=% D DTP^FH
 I LAB S LAB=$P($G(^FH(119.9,1,"D",IOS,0)),"^",2) S:'LAB LAB=1
 F K=0:0 S K=$O(^FH(119.6,K)) Q:K<1  S X=^(K,0),D2=$P(X,"^",9) I 'D1!(D1=D2),$O(^FH(119.6,K,"BN",0))>0 S P0=$P(X,"^",4) S:P0<1 P0=99 S ^TMP($J,P0,K)=""
 G:LAB L0
 S D3=$S('D1:"ALL SITES",1:$P(^FH(119.74,D1,0),"^",1)),PG=0 D HDR
 K D S C1=0 F P0=0:0 S P0=$O(^TMP($J,P0)) Q:P0<1  F K=0:0 S K=$O(^TMP($J,P0,K)) Q:K<1  D Q4
 D:$Y>(IOSL-8) HDR W !!?(45-$L(D3)\2),"***** ",D3," TOTAL *****"
 W !!,"   Qty  Item",?33,"Cost   Vehicle   Other   Total",!
 S (C(0),C(1))=0 F K=0:0 S K=$O(D(K)) Q:K<1  D:$Y>(IOSL-8) HDR S Y=^FH(118,K,0) D C3 S CT=$P(Y,"^",4)="Y",C(CT)=D(K)*C3+C(CT) W !,$J(D(K),6),"  ",$P(Y,"^",1),?31,$J(C3,6,2) W ?($S(CT:40,1:49)),$J(D(K)*C3,6,2),?57,$J(D(K)*C3,6,2)
 W !!?8,"Grand Total",?39,$J(C(1),7,2),?48,$J(C(0),7,2),?56,$J(C(0)+C(1),7,2)
Q3 W ! Q
Q4 D:$Y>(IOSL-8) HDR W !!,"--- ",$P(^FH(119.6,K,0),"^",1)," ---",?33,"Cost   Vehicle   Other   Total",!
 S C1=C1+1
 K FHDX1 S FHCX1(0)=0,FHCX1(1)=0,FHC3X1(1)=0
 F L=0:0 S L=$O(^FH(119.6,K,"BN",L)) Q:L<1  S X=^(L,0),X1=$P(X,"^",1),X2=$P(X,"^",2) I X1,$D(^FH(118,X1,0)) D:$Y>(IOSL-8) HDR D
 .W !,$J(X2,6),"  ",$P($G(^FH(118,X1,0)),"^",1) S:'$D(D(X1)) D(X1)=0 S:'$D(FHDX1(X1)) FHDX1(X1)=0 S D(X1)=D(X1)+X2,FHDX1(X1)=FHDX1(X1)+X2
 .D:$Y>(IOSL-8) HDR S Y=^FH(118,X1,0) D C3 S CT1=$P(Y,"^",4)="Y",FHCX1(CT1)=FHDX1(X1)*C3+FHCX1(CT1),FHC3X1(1)=FHC3X1(1)+C3
 .W ?31,$J(C3,6,2) W ?($S(CT1:40,1:49)),$J(FHDX1(X1)*C3,6,2),?57,$J(FHDX1(X1)*C3,6,2)
 D:$Y>(IOSL-8) HDR
 W !!,?8,"Total for ",$P($G(^FH(119.6,K,0)),"^",1),?39,$J(FHCX1(1),7,2),?48,$J(FHCX1(0),7,2),?56,$J(FHCX1(0)+FHCX1(1),7,2)
 Q
HDR ; Print Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 S X="BULK NOURISHMENTS FOR: "_D3 W !?(80-$L(X)\2),X,?73,"Page ",PG,!!?32,DTP,! Q
L0 S S2=LAB=2*5+32,S1=$S(LAB=2:9,1:6),COUNT=0,LINE=1
 K D S C1=0
 F P0=0:0 S P0=$O(^TMP($J,P0)) Q:P0<1  F K=0:0 S K=$O(^TMP($J,P0,K)) Q:K<1  S WRD=$P(^FH(119.6,K,0),"^",1) F L=0:0 S L=$O(^FH(119.6,K,"BN",L)) Q:L<1  D L3
 I LAB>2 D DPLL^FHLABEL Q
 Q:'C1  S LN=6,X="BULK NOURISHMENTS PICK LIST" W !!?(S2-$L(X)\2),X
 S D3=$S('D1:"ALL SITES",1:$P(^FH(119.74,D1,0),"^",1)) W !!?(S2-$L(D3)\2),D3,!!
 F K=0:0 S K=$O(D(K)) Q:K<1  W !,$J(D(K),4),"  ",$P(^FH(118,K,0),"^",1) S LN=LN+1
 S LN=LN#S1 I LN F K=LN+1:1:S1 W !
 Q
L3 S X=^FH(119.6,K,"BN",L,0),X1=$P(X,"^",1),X2=$P(X,"^",2) Q:'X1!('$D(^FH(118,X1,0)))
 S:'$D(D(X1)) D(X1)=0 S D(X1)=D(X1)+X2,C1=C1+1
 S X1=^FH(118,X1,0),CHK=$P(X1,"^",2) Q:CHK="N"  S X1=$P(X1,"^",1)
 I LAB>2 D LL Q
 F C1=1:1:X2 W !!?(S2-$L(X1)\2),X1,!!,WRD,?(S2-$L(DTP)),DTP,!! W:LAB=2 !!!
 Q
C3 S C3=$P($G(^FH(114,+$P(Y,"^",7),0)),"^",13) Q
KIL K ^TMP($J) G KILL^XUSCLEAN
 Q
LL ;
 S FHCOL=$S(LAB=3:3,1:2)
 I LABSTART>1 F FHLABST=1:1:(LABSTART-1)*FHCOL D  S LABSTART=1
 .I LAB=3 S (PCL1,PCL2,PCL3,PCL4,PCL5,PCL6)="" D LL3^FHLABEL
 .I LAB=4 S (PCL1,PCL2,PCL3,PCL4,PCL5,PCL6,PCL7,PCL8)="" D LL4^FHLABEL
 .Q
 F C1=1:1:X2 D
 .S FHTAB=$S(LAB=3:24,1:37),SPC=$J(" ",70)
 .S LNA=$E(SPC,1,FHTAB-$L(X1)/2)_X1,LNB=WRD_$J(DTP,FHTAB+1-$L(WRD))
 .I LAB=3 S (PCL1,PCL2,PCL4,PCL6)="",PCL3=LNA,PCL5=LNB
 .I LAB=4 S (PCL1,PCL2,PCL3,PCL5,PCL7,PCL8)="",PCL4=LNA,PCL6=LNB
 .D:LAB=3 LL3^FHLABEL D:LAB=4 LL4^FHLABEL
 Q
