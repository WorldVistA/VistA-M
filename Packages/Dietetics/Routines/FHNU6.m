FHNU6 ; HISC/REL/NCA - Abbreviated Analysis Output ;8/2/94  16:09
 ;;5.5;DIETETICS;;Jan 28, 2005
 K A,B,C F K=1:1:3 S C(K)=0 F K=1:1:66 S A(K)=0,B(K)=0
 S NX=0
D1 S NX=$O(FHM(NX)) I NX="" G D2
 S AMT=+FHM(NX) I TYP="C" S WT=$P(FHM(NX),",",3),AMT=AMT*WT
 S AMT=AMT/100,Y=$G(^FHNU(NX,1)) F K=1:1:20 S Z1=$P(Y,"^",K) I Z1'="" S A(K)=Z1*AMT+A(K),B(K)=B(K)+1
 S Y=$G(^FHNU(NX,2)) F K=21:1:38 S Z1=$P(Y,"^",K-20) I Z1'="" S A(K)=Z1*AMT+A(K),B(K)=B(K)+1
 S Y=$G(^FHNU(NX,3)) F K=39:1:56 S Z1=$P(Y,"^",K-38) I Z1'="" S A(K)=Z1*AMT+A(K),B(K)=B(K)+1
 S Y=$G(^FHNU(NX,4)) F K=57:1:66 S Z1=$P(Y,"^",K-56) I Z1'="" S A(K)=Z1*AMT+A(K),B(K)=B(K)+1
 G D1
D2 S ZR=$S(RDA:^FH(112.2,RDA,1),1:""),ANS=""
 S Z1=4*A(1)+(9*A(2))+(4*A(3)) S:'Z1 Z1=1 F KK=1,3,2 S C(KK)=$J(A(KK)*$S(KK=2:900,1:400)/Z1,4,0)
 W:$E(IOST,1,2)="C-" @IOF W !?28,"--- Analysis of Menu ---",!!?(80-$L(TIT)\2),TIT,!!?34,"%",?39,"%",?76,"%",!
 W ?33,"DRI",?37,"Kcal",?75,"DRI",!
 F K=1:1:34 S Y=$T(COM+K),Z1=$P(Y,";",3) D LST
 D PSE I ANS="^" K A,B,C,KK,T1,Z1,Z2,ZR Q
 F K=35:1:70 S Y=$T(COM+K),Z1=$P(Y,";",3) D LST
 D PSE W ! K A,B,C,KK,T1,Z1,Z2,ZR Q
LST W:K#2 ! Q:'Z1  S T1=$S(K#2:0,1:42)
 W ?T1,$P(Y,";",4)," (",B(Z1),")" I B(Z1) W ?(T1+21),$J(A(Z1),7,$P(Y,";",6))," ",$P(Y,";",5)
 S Z2=$P(Y,";",7) I Z2,ZR'="" S Z2=A(Z1)/$P(ZR,U,Z2) W ?(T1+33),$J(Z2*100,3,0)
 I $D(C(Z1)) W ?(T1+37),C(Z1)
 Q
PSE I IOST?1"C-".E R !!,"Press RETURN to Continue ",X:DTIME W ! S:'$T!(X["^") ANS="^" Q:ANS="^"  I "^"'[X W !,"Enter a RETURN to Continue." G PSE
 Q
COM ;;
 ;;4;Calories;K;0;0
 ;;33;Vitamin A;RE;0;2
 ;;1;Protein;Gms;1;1
 ;;19;Ascorbic Acid;Mg;1;4
 ;;3;Carbohydrate;Gms;1;0
 ;;17;Vitamin E;Mg;1;3
 ;;2;Fat;Gms;1;0
 ;;21;Riboflavin;Mg;1;6
 ;;13;Sodium;Mg;1;19
 ;;20;Thiamin;Mg;1;5
 ;;12;Potassium;Mg;1;20
 ;;22;Niacin;Mg;1;7
 ;;8;Calcium;Mg;1;11
 ;;24;Vitamin B6;Mg;1;8
 ;;11;Phosphorus;Mg;1;12
 ;;26;Vitamin B12;Mcg;1;10
 ;;9;Iron;Mg;1;14
 ;;65;Vitamin K;Mcg;1;26
 ;;14;Zinc;Mg;1;15
 ;;25;Folate;Mcg;1;9
 ;;10;Magnesium;Mg;1;13
 ;;23;Pantothenic Ac;Mg;1;16
 ;;16;Manganese;Mg;1;18
 ;;29;Cholesterol;Mg;1;0
 ;;15;Copper;Mg;1;17
 ;;27;Linoleic Acid;Gms;1;0
 ;;66;Selenium;Mcg;1;22
 ;;28;Linolenic Acid;Gms;1;0
 ;;0;Crude Fiber;Gms;1;0
 ;;31;Monounsat. Fat;Gms;1;0
 ;;0;Dietary Fiber;Gms;1;0
 ;;32;Polyunsat. Fat;Gms;1;0
 ;;5;Water;Ml;1;0
 ;;30;Saturated Fat;Gms;1;0
 ;;34;Ash;Gms;1;0
 ;;39;Tryptophan;Gms;2;0
 ;;35;Alcohol;Gms;1;0
 ;;40;Threonine;Gms;2;0
 ;;36;Caffeine;Mg;1;0
 ;;41;Isoleucine;Gms;2;0
 ;;37;Total Diet Fiber;Gms;1;0
 ;;42;Leucine;Gms;2;0
 ;;38;Total Tocopherol;Mg;1;0
 ;;43;Lysine;Gms;2;0
 ;;57;Capric Acid;Gms;2;0
 ;;44;Methionine;Gms;2;0
 ;;58;Lauric Acid;Gms;2;0
 ;;45;Cystine;Gms;2;0
 ;;59;Myristic Acid;Gms;2;0
 ;;46;Phenylalanine;Gms;2;0
 ;;60;Palmitic Acid;Gms;2;0
 ;;47;Tyrosine;Gms;2;0
 ;;61;Palmitoleic Acid;Gms;2;0
 ;;48;Valine;Gms;2;0
 ;;62;Stearic Acid;Gms;2;0
 ;;49;Arginine;Gms;2;0
 ;;63;Oleic Acid;Gms;2;0
 ;;50;Histidine;Gms;2;0
 ;;64;Arachidonic Acid;Gms;2;0
 ;;51;Alanine;Gms;2;0
 ;;0
 ;;52;Aspartic Acid;Gms;2;0
 ;;0
 ;;53;Glutamic Acid;Gms;2;0
 ;;0
 ;;54;Glycine;Gms;2;0
 ;;0
 ;;55;Proline;Gms;2;0
 ;;0
 ;;56;Serine;Gms;2;0
