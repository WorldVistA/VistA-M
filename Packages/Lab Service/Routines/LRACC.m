LRACC ;SLC/RWF - READ ACCESSION ; 7/10/87  17:38 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 K DUOUT,DTOUT S U="^" I '$D(DT) S X="T",%DT="" D ^%DT S DT=Y
AA R !,"Select Accession: ",X:DTIME S:X[U DUOUT=1 G QUIT:X=""!$D(DUOUT),QUES:X["?"
 S:$L(X)>2 ^DISV(DUZ,"LRACC")=X S:X=" " X=$S($D(^DISV(DUZ,"LRACC")):^("LRACC"),1:"?")
AC S (WL,WDT,WLE,LOG)=0,(X1,X2,X3)="",X1=$P(X," ",1),X2=$P(X," ",2),X3=$P(X," ",3)
 S:X3=""&(+X2=X2) X3=X2,X2="" G AA:X1'?1A.AN S WL=$O(^LRO(68,"B",X1,0)) G WLQUES:WL<1
AC2 W !,$P(^LRO(68,WL,0),U,1)
 I X2="",X3="" S %DT="AE",%DT("A")="  Accession Date: ",%DT("B")="TODAY" D DATE^LRWU S WDT=Y G QUIT:$D(DUOUT),QUES:Y<1
 I WDT<1 S:X2="" X2=DT S %DT="E",X=X2 D ^%DT S WDT=Y G QUES:Y<1
 S X=$P(^LRO(68,WL,0),U,3),WDT=$S(X="D":WDT,X="M":$E(WDT,1,5)_"00",X="Y":$E(WDT,1,3)_"0000",1:WDT)
 W:X3>0 "  ",+X3
AC4 I X3=""&$D(LRACC) R !,"  Number part of Accession: ",X3:DTIME G QUES:X3["?",QUIT:X3[U,QUES:X3<1!(X3>999999)
 S WLE=+X3,LOG=WLE G QUES:WLE<1&$D(LRACC)
 I $D(LRACC),'$D(^LRO(68,WL,1,WDT,1,WLE,0)) W !,"ACCESSION: ",$P(^LRO(68,WL,0),U,11),"/",$E(WDT,2,7),"/",WLE," DOES NOT EXIST!" G AA
 K X1,X2,X3,%DT,DIC Q
QUIT S (WLE,LOG,WL,WDT)=-1 K X1,X2,X3,%DT,DIC Q
QUES W $C(7),!,"PLEASE ENTER ACCESSION IN THIS FORMAT.",!?5," <ACCESSION AREA> <DATE> <NUMBER>"
 W !?5," ie.  CH 0426 125 or CH 125 or CH T 125",!?5," or if it's a yearly accession area ie. MICRO 85 30173"
 W:'$D(LRACC) !?5," or just the Accession area, or area and date."
 W:$D(LRACC) !?5," Must include the Accession area and the final number part."
 G AA
WLQUES S X=X1,DIC="^LRO(68,",DIC(0)="EMQ" W !,X D ^DIC S WL=+Y G AA:Y<1,AC2
