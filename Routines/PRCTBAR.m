PRCTBAR ;WISC@ALTOONA/RGY-SEND A IRL PROGRAM TO BAR CODE READER ;3.13.98
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S:'$D(PRCTID) PRCTID="" S:PRCTID]"" PRCTID=$O(^PRCT(446.4,"C",PRCTID,"")) I PRCTID="" S DIC="^PRCT(446.4,",DIC(0)="QEAM",DIC("S")="I $P(^(0),U,12)" D ^DIC K DIC("S") G:Y<0 Q S PRCTID=+Y
DEV ;
 N TIME,PRX
 W:'$D(IOP) !!,"OK, please enter the device to which the bar code reader is connected.",!
 D ^%ZIS G:POP Q
 S PRCTEON=^%ZOSF("EON"),PRCTEOFF=^%ZOSF("EOFF"),PRCTTYPE=^%ZOSF("TYPE-AHEAD"),PRCTOPEN=$G(^%ZIS(2,IOST(0),10)),PRCTCLOS=$G(^%ZIS(2,IOST(0),11))
 U IO D OFF D WARN^PRCTMES1 R X:DTIME G:X="^" Q
 D ON S PRCT=+$P(^PRCT(446.4,PRCTID,0),"^",9)_"^2" D SPC^PRCTLAB H 3
 S TIME=$P($H,",",2)
 ;  for janus readers
 N PRCTJNUS
 I $TR($P($G(^PRCT(446.6,+$P($G(^PRCT(446.4,PRCTID,0)),"^",9),0)),"^"),"janus","JANUS")["JANUS" S PRCTJNUS=1
 F LN=0:0 S LN=$O(^PRCT(446.4,PRCTID,1,LN)) Q:'LN  I $D(^(LN,0)) S X=^(0) D LN I X]"" W:$G(PRCTJNUS) $C(15) W X W:$G(PRCTJNUS) $C(22) W ! D:$G(PRCTJNUS)
 . D OFF W *0
 . D ON
 S PRCT=+$P(^PRCT(446.4,PRCTID,0),"^",9)_"^3" D SPC^PRCTLAB
 F I=1:1:5 R PRX(I):5 Q:'$T
 D OFF,^%ZISC
 W !!,"Download time: "_($P($H,",",2)-TIME)_" sec."
 I $G(PRX(1))=$C(30) W !,"DOWNLOAD SUCCESSFUL, you may now disconnect the bar code reader.",!!
Q ;
 D HOME^%ZIS K I,LN,%DT,POP,PRCTID,DIC,IOP Q
LN ;
 S X=$P(X,"::") F Y=$L(X):-1:0 Q:$E(X,Y)'=" "  S X=$E(X,1,Y-1)
 I '$D(COL1) S:X["|" X=$P(X,"|")_@$P(X,"|",2)_$P(X,"|",3)
 Q
 ;
ON X PRCTOPEN U IO X PRCTEOFF,PRCTTYPE
 Q
 ;
OFF X PRCTCLOS,PRCTEON U IO(0)
 Q
 ;
COM ;Entry point to allow the alignment of IRL comments in Barcode Program file
 S DIC="^PRCT(446.4,",DIC(0)="QEAM" D ^DIC G:Y<0 Q2 S PRCTID=+Y
 S X="At what character do you want comments to begin at ?^35^^^COM^PRCTMES1^1" D ^PRCTQUES G:X="^" Q2 S COL1=X
 S X="From line no. ?^1^^^COM1^PRCTMES1^1" D ^PRCTQUES G:X="^" Q2 S LN1=X
 S X="To line no. ?^"_$S($D(^PRCT(446.4,PRCTID,1,0)):$P(^(0),"^",4),1:"")_"^^^COM2^PRCTMES1^1" D ^PRCTQUES G:X="^" Q2 S LN2=X
 F LN=LN1-1:0 S LN=$O(^PRCT(446.4,PRCTID,1,LN)) Q:'LN!(LN>LN2)  I $D(^(LN,0)) S X=^(0),Y=COL1 D CON S ^PRCT(446.4,PRCTID,1,LN,0)=Y W "."
 W "... Done"
Q2 K COL1,LN,PRCTID,TLN,LN1,LN2,LN3 Q
CON ;X=IRL TEXT,Y=COLUMN TO START COMMENTS, Can be called from Fileman
 S COL=Y,(LN1,Y)=X G:X'["::" Q3 D LN F Y=0:0 Q:COL-3<$L(X)  S X=X_" "
 S:$A($E(X,$L(X)))>32 X=X_" " S Y=X_"::"_$P(LN1,"::",2)
Q3 K LN1,COL Q
IDENT ; Called by input transform for IDENTIFIER (446.4,.02)
 I $D(^PRCT(446.4,"C",X)),$O(^(X,""))'=DA S X=$O(^("")) W !,"This IDENTIFIER already exists for ",$S($D(^PRCT(446.4,+X,0)):$P(^(0),"^"),1:X)," !" K X Q
 I '$D(^DIC(9.4,"C",$E(X,1,$L(X)-2))) W !,"The PACKAGE NAME SPACE '",$E(X,1,$L(X)-2),"' does not exist !" K X
 Q
