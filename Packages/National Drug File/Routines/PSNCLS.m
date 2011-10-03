PSNCLS ;BIR/WRT-VA Drug Class Report ;01/12/98   5:18 PM
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 W !!,"This report will display the VA Drug Classification code and class name.",!
 R "Would you also like to see the class descriptions? N// ",ANS:DTIME S:'$T ANS="^" G:ANS["^" DONE S:ANS']"" ANS="N" I $D(ANS),ANS["?" D CLS^PSNHELP1 K ANS G PSNCLS
 I ANS?.E1C.E K ANS G PSNCLS
 I ANS["^" G DONE
SORT S DIC="^PS(50.605,",L=0,BY="@CODE,@TYPE",FR="?,",TO="?,",DHD="VA DRUG CLASSIFICATION CODES",FLDS="[PSNPRINT]" D EN1^DIP
DONE K ANS,NOD Q
PRINT W !,$S($P(^PS(50.605,D0,0),"^",4)=0:$P(^(0),"^"),$P(^PS(50.605,D0,0),"^",4)=1:"  "_$P(^(0),"^"),$P(^PS(50.605,D0,0),"^",4)=2:"     "_$P(^(0),"^"),1:$P(^PS(50.605,D0,0),"^")),?14,$P(^(0),"^",2)
 I $D(ANS),"Yy"[$E(ANS),$D(^PS(50.605,D0,1,0)) F NOD=0:0 S NOD=$O(^PS(50.605,D0,1,NOD)) Q:'NOD  W !,$P(^PS(50.605,D0,1,NOD,0),"^",1)
 Q
