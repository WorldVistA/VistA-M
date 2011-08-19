FHPRW2 ; HISC/REL - List Service Points ;4/25/93  14:24 
 ;;5.5;DIETETICS;;Jan 28, 2005
 F K1=0:0 S K1=$O(^FH(119.72,K1)) Q:K1'>0  D Q3
 Q
Q3 I $G(^FH(119.72,K1,"I"))="Y" Q
 S X=^FH(119.72,K1,0),TYP=$P(X,"^",2) D BLD,HDR
 W !!,"Type of Service:",?25,$S(TYP="T":"Tray Line",TYP="C":"Cafeteria",1:"")
 W !,"Short Name:",?25,$P(X,"^",4)
 W !,"Production Facility:",?25 S Z=$P(X,"^",3) W:Z $P($G(^FH(119.71,Z,0)),"^",1)
 D WRD G:$O(^FH(119.72,K1,"A",0))="" Q31
 W !!,"Production Diet %:",?28,"Sun     Mon     Tue     Wed     Thu     Fri     Sat",!
 K S F L=1:1:7 S S(L)=0
 F NX=0:0 S NX=$O(^FH(119.72,K1,"A",NX)) Q:NX<1  S X=^(NX,0) D P2
 W !?3,"Not Eating",?23 F L=1:1:7 S Z=$S(S(L)<100:100-S(L),1:0),S(L)=S(L)+Z W $S('Z:$J("",8),1:$J(Z,8,1))
 W !?3,"Total Sum",?23 F L=1:1:7 W $J(S(L),8,1)
Q31 Q:$O(^FH(119.72,K1,"B",0))=""
 W !!,"Additional Meals:",?32,"Meal",?40,"Sun  Mon  Tue  Wed  Thu  Fri  Sat"
 F NX=0:0 S NX=$O(^FH(119.72,K1,"B",NX)) Q:NX<1  S X=^(NX,0) D P1
 W ! Q
P1 S NAM=$P($G(^FH(116.2,NX,0)),"^",1) W !!?3,$E(NAM,1,26)
 F L=1:1:3 W:L>1 ! W ?32,$P("Brk^Noon^Even","^",L),?38 F K=1:1:7 S Z=$P(X,"^",K*3-2+L) W $S('Z:$J("",5),1:$J(Z,5))
 Q
P2 S NAM=$P($G(^FH(116.2,NX,0)),"^",1) W !?3,$E(NAM,1,18),?23
 F L=1:1:7 S Z=$P(X,"^",L+1),S(L)=S(L)+Z W $S('Z:$J("",8),1:$J(Z,8,1))
 Q
WRD W !!,"Associated Dietetic Wards:",!
 K P S N=0,NM="" F  S NM=$O(^TMP($J,NM)) Q:NM=""  S N=N+1,P(N)=$P(NM,"~",1)
 I N S (Z,K)=N+1\2 F LL=1:1:Z W !?5,P(LL) S K=K+1 I $D(P(K)) W ?45,P(K)
 Q
BLD ; Build temp files
 K ^TMP($J) S Z=$S(TYP="T":5,TYP="C":6,1:0)
 F LL=0:0 S LL=$O(^FH(119.6,LL)) Q:LL<1  S Y=^(LL,0) I $P(Y,"^",Z)=K1 D B1
 Q
B1 S ^TMP($J,$P(Y,"^",1)_"~"_LL)="" Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1,DTP=NOW D DTP^FH W !,$E(DTP,1,9),?27,"S E R V I C E   P O I N T",?73,"Page ",PG
 S Y=$P(X,"^",1) W !!?(78-$L(Y)\2),Y
 W !,"-------------------------------------------------------------------------------",! Q
