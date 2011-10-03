FHPRW4 ; HISC/REL - List Supp. Fdg. Sites ;4/25/93  14:23 
 ;;5.5;DIETETICS;;Jan 28, 2005
 F K1=0:0 S K1=$O(^FH(119.74,K1)) Q:K1'>0  D Q5
 Q
Q5 S X=^FH(119.74,K1,0) D BLD,HDR
 W !!,"Short Name:",?25,$P(X,"^",2)
 W !,"Separate Labels:",?25,$S($P(X,"^",4)="Y":"YES",1:"NO")
 W !,"Items on Ward Lists:",?25,$S($P(X,"^",5)="Y":"YES",1:"NO")
 W !,"Production Facility:",?25 S Z=$P(X,"^",3) W:Z $P($G(^FH(119.71,Z,0)),"^",1)
 D WRD Q
WRD W !!,"Associated Dietetic Wards:",!
 K P S N=0,NM="" F  S NM=$O(^TMP($J,NM)) Q:NM=""  S N=N+1,P(N)=$P(NM,"~",1)
 I N S (Z,K)=N+1\2 F LL=1:1:Z W !?5,P(LL) S K=K+1 I $D(P(K)) W ?45,P(K)
 Q
BLD ; Build temp files
 K ^TMP($J)
 F LL=0:0 S LL=$O(^FH(119.6,LL)) Q:LL<1  S Y=^(LL,0) I $P(Y,"^",9)=K1 D B1
 Q
B1 S ^TMP($J,$P(Y,"^",1)_"~"_LL)="" Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1,DTP=NOW D DTP^FH W !,$E(DTP,1,9),?15,"S U P P L E M E N T A L   F E E D I N G   S I T E",?73,"Page ",PG
 S Y=$P(X,"^",1) W !!?(78-$L(Y)\2),Y
 W !,"-------------------------------------------------------------------------------",! Q
