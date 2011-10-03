LRMIU4 ;SLC/RWF,BA - READ MICRO ACCESSION ; 2/27/89  08:33 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;from LRMIEDZ, LRMIPSZ
START K DUOUT,DTOUT S U="^" D AA
 S:LROK=1 (LRAN,LRAA,LRAD)=-1 K X1,X2,X3,%DT,DIC,LROK
 Q
AA S X="T",%DT="" D ^%DT S DT=Y
 S LROK=0 F I=0:0 R !,"Select Microbiology Accession: ",X:DTIME S:X=""!(X[U) LROK=1 Q:LROK  D:X["?" QUES I X'["?" D ACC Q:LROK
 Q
ACC S:$L(X)>2 ^DISV(DUZ,"LRACC")=X S:X=" " X=$S($D(^DISV(DUZ,"LRACC")):^("LRACC"),1:"?")
 S (LRAA,LRAD,LRAN)=0,(X1,X2,X3)="",X1=$P(X," "),X2=$P(X," ",2),X3=$P(X," ",3)
 S:X3=""&(+X2=X2) X3=X2,X2="" Q:X1'?1A.AN  S LRAA=+$O(^LRO(68,"B",X1,0)) I LRAA<1 S X=X1,DIC=68,DIC(0)="EMQ",DIC("S")="I $P(^(0),U,2)=""MI""" W !,X D ^DIC K DIC S LRAA=+Y I Y<1 Q
 I $P(^LRO(68,LRAA,0),U,2)'="MI" D QUES Q
 W !,$P(^LRO(68,LRAA,0),U)
 I X2="",X3="" S %DT="AE",%DT("A")="  Accession Date: ",%DT("B")=$E(DT,2,3) D DATE^LRWU S LRAD=Y S:$D(DUOUT) LROK=1 Q:LROK  I Y<1 D QUES Q
 I LRAD<1 S:X2="" X2=$E(DT,1,3)_"0000" S %DT="E",X=X2 D ^%DT S LRAD=Y I Y<1 D QUES Q
 S LRAD=$E(LRAD,1,3)_"0000"
 W:X3>0 "  ",+X3
 I X3="" R !,"  Number part of Accession: ",X3:DTIME S:X3[U LROK=1 Q:LROK  I X3<1!(X3>999999)!(X'?1N.N) D NQUES Q
 S LRAN=+X3 I LRAN<1 D QUES Q
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W !,"ACCESSION: ",$P(^LRO(68,LRAA,0),U,11)," ",$E(LRAD,2,3)," ",LRAN," DOES NOT EXIST!" Q
 S LROK=2
 Q
NQUES W !?5,"Enter just the number here, or you may:"
QUES W $C(7),!,"ENTER THE ACCESSION IN THIS FORMAT.",!?5," <ACCESSION AREA> <DATE> <NUMBER>"
 W !?5," ie.  MICRO 87 30173 or MICRO 30173"
 W !?5," Must be a MICROBIOLOGY accession area."
 W !?5," May enter just the Accession area, or area and number."
 Q
LRANX ;from LRMIEDZ2, LRMIPSZ
 S:$L(X)>2 ^DISV(DUZ,"LRAN")=X W:X=" " $S($D(^DISV(DUZ,"LRAN")):^("LRAN"),1:"") S:X=" " X=$S($D(^DISV(DUZ,"LRAN")):^("LRAN"),1:"?") S LRAN=X
 I LRAN<1!(LRAN>999999)!(LRAN'?1N.N) S LRANOK=0 Q
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W !,"Doesn't exist." S LRANOK=0 Q
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,3)) W !,"Incomplete data available." S LRANOK=0 Q
 Q
