FHNU3 ; HISC/REL/NCA - Weekly Summary ;2/15/95  16:08 
 ;;5.5;DIETETICS;;Jan 28, 2005
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 I PG=1 D SITE^FH
 W !,"Station #: ",SITE(1),?43,"E N E R G Y / N U T R I E N T   S U M M A R Y",?124,"Page ",PG
 W !,"Station Name: ",SITE,?61,DTP,?110,"DRI: ",$P(^FH(112.2,RDA,0),U,1)
 W !?(132-$L(MNAM)\2),MNAM S (T(1),T(2),T(3),T(4),T(5))="",NDAY=0
 W !!,"Daily Totals",?20,"Energ    Pro    CHO    Fat    Sod    Pot   Calc   Phos   Iron   Zinc    Mag    Man    Cop    Sel   DFib      K"
 W !?21,"KCal     Gm     Gm     Gm     Mg     Mg     Mg     Mg     Mg     Mg     Mg     Mg     Mg    Mcg     Gm    Mcg",!
 S NUT="1047000101710110370001027000113701911270201087011111701210971141147115110711311672181157217466712223771004657126",DAY=0
T1 S DAY=$O(^TMP($J,"D",DAY)) G:DAY="" T2 S X1=$G(^(DAY,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)),X5=$G(^(5)),NDAY=NDAY+1
 F K=1:1:20 S Z1=$P(X1,"^",K) I Z1 S $P(T(1),"^",K)=$P(T(1),"^",K)+Z1
 F K=1:1:18 S Z1=$P(X2,"^",K) I Z1 S $P(T(2),"^",K)=$P(T(2),"^",K)+Z1
 F K=9,10 S Z1=$P(X4,"^",K) I Z1 S $P(T(4),"^",K)=$P(T(4),"^",K)+Z1
 F K=1:1:66 S:$P(X5,"^",K) $P(T(5),"^",K)=1
 W !?3,"Day ",DAY,?19 D LIS G T1
T2 D AVG W !!,"Daily Average",?19 S X1=T(1),X2=T(2),X4=T(4),X5=T(5) D LIS
 W !,"Average % DRI",?18 D RDA^FHNU9
 W !,"% of Kcal",?25 S Z1=$P(X1,"^",4) S:'Z1 Z1=1 F KK=1,3,2 W $J($P(X1,"^",KK)*$S(KK=2:900,1:400)/Z1,7,0)
 W !!!!,"Daily Totals",?24,"A      C      E    Rib    Thi    Nia     B6    B12    Fol   Pant   Chol   18C2   18C3   Mono   PuFa   SaFa"
 W !?23,"RE     Mg     Mg     Mg     Mg     Mg     Mg    Mcg    Mcg     Mg     Mg     Gm     Gm     Gm     Gm     Gm",!
 S NUT="2338002119710411771032217206120720522272072247208226721022572092237216229700022771002287100231710023271002307100",DAY=0
T3 S DAY=$O(^TMP($J,"D",DAY)) G:DAY="" T4 S X1=$G(^(DAY,1)),X2=$G(^(2)),X4=$G(^(4)),X5=$G(^(5))
 W !?3,"Day ",DAY,?18 D LIS G T3
T4 W !!,"Daily Average",?18 S X1=T(1),X2=T(2),X4=T(4),X5=T(5) D LIS
 W !,"Average % DRI",?17 D RDA^FHNU9
 W:$P(X1,"^",1) !!,"Kcal:N Ratio = ",$J(6.25*$P(X1,"^",4)/$P(X1,"^",1),0,0),":1"
 W !!,"'+' following a daily value indicates that incomplete data exists.",! G KIL^FHNU2
LIS ; List nutrient values
 S KK=1
L1 S NODE=$E(NUT,KK) Q:'NODE  S ITM=+$E(NUT,KK+1,KK+2) Q:'ITM  S SIZ=$E(NUT,KK+3),DEC=$E(NUT,KK+4),KK=KK+7
 S Z1=$S(NODE=1:$P(X1,"^",ITM),NODE=2:$P(X2,"^",ITM-20),NODE=3:$P(X3,"^",ITM-38),1:$P(X4,"^",ITM-56))
 S Z1=$S(Z1'="":$J(Z1,SIZ-1,DEC),1:$J(Z1,SIZ-1))_$S($P(X5,"^",ITM):"+",1:" ") W Z1 G L1
AVG ; Get averages
 S:'NDAY NDAY=1 F K=1:1:20 S $P(T(1),"^",K)=$J($P(T(1),"^",K)/NDAY,0,3)
 F K=1:1:18 S $P(T(2),"^",K)=$J($P(T(2),"^",K)/NDAY,0,3)
 F K=9,10 S $P(T(4),"^",K)=$J($P(T(4),"^",K)/NDAY,0,3)
 Q
