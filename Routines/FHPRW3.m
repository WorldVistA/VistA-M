FHPRW3 ; HISC/REL - List Communication Offices ;4/25/93  14:23 
 ;;5.5;DIETETICS;;Jan 28, 2005
 F K1=0:0 S K1=$O(^FH(119.73,K1)) Q:K1'>0  D Q4
 Q
Q4 S X=^FH(119.73,K1,0) D BLD,HDR
 S X1=$G(^FH(119.73,K1,1)),X2=$G(^(2))
 F LL=1:1:6 S Y=$P(X2,"^",LL) I Y'="" D MIP^FHSYSP S $P(X2,"^",LL)=Y
 W !!,"Provide Bagged Meals:",?25 S Z=$P(X2,"^",10) W $S(Z="Y":"YES",1:"NO")
 W !!?44,"Breakfast     Noon     Evening",!
 W !,?5,"Meal Time:" W ?46,$J($P(X2,"^",7),6),?57,$J($P(X2,"^",8),6),?67,$J($P(X2,"^",9),6)
 W !!,?5,"Early Time 1:" W ?46,$J($P(X1,"^",1),6),?57,$J($P(X1,"^",7),6),?67,$J($P(X1,"^",13),6)
 W !,?5,"Early Time 2:" W ?46,$J($P(X1,"^",2),6),?57,$J($P(X1,"^",8),6),?67,$J($P(X1,"^",14),6)
 W !,?5,"Early Time 3:" W ?46,$J($P(X1,"^",3),6),?57,$J($P(X1,"^",9),6),?67,$J($P(X1,"^",15),6)
 W !!,?5,"Late Time 1:" W ?46,$J($P(X1,"^",4),6),?57,$J($P(X1,"^",10),6),?67,$J($P(X1,"^",16),6)
 W !,?5,"Late Time 2:" W ?46,$J($P(X1,"^",5),6),?57,$J($P(X1,"^",11),6),?67,$J($P(X1,"^",17),6)
 W !,?5,"Late Time 3:" W ?46,$J($P(X1,"^",6),6),?57,$J($P(X1,"^",12),6),?67,$J($P(X1,"^",18),6)
 W !!,?5,"Late Alarm Begin:" W ?46,$J($P(X2,"^",1),6),?57,$J($P(X2,"^",3),6),?67,$J($P(X2,"^",5),6)
 W !,?5,"Late Alarm End:" W ?46,$J($P(X2,"^",2),6),?57,$J($P(X2,"^",4),6),?67,$J($P(X2,"^",6),6)
 D WRD W ! Q
WRD W !!,"Associated Dietetic Wards:",!
 K P S N=0,NM="" F  S NM=$O(^TMP($J,NM)) Q:NM=""  S N=N+1,P(N)=$P(NM,"~",1)
 I N S (Z,K)=N+1\2 F LL=1:1:Z W !?5,P(LL) S K=K+1 I $D(P(K)) W ?45,P(K)
 Q
BLD ; Build temp files
 K ^TMP($J)
 F LL=0:0 S LL=$O(^FH(119.6,LL)) Q:LL<1  S Y=^(LL,0) I $P(Y,"^",8)=K1 D B1
 Q
B1 S ^TMP($J,$P(Y,"^",1)_"~"_LL)="" Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1,DTP=NOW D DTP^FH W !,$E(DTP,1,9),?20,"C O M M U N I C A T I O N   O F F I C E",?73,"Page ",PG
 S Y=$P(X,"^",1) W !!?(78-$L(Y)\2),Y
 W !,"-------------------------------------------------------------------------------",! Q
