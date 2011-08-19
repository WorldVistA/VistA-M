ENCTBAR ;(WASH ISC)/RGY,DH-Send IRL Code to Bar Code Reader ;2.25.97
 ;;7.0;ENGINEERING;**9,32,35**;Aug 17, 1993
 S:'$D(ENCTID) ENCTID="" S:ENCTID]"" ENCTID=$O(^PRCT(446.4,"C",ENCTID,"")) I ENCTID="" S DIC="^PRCT(446.4,",DIC(0)="QEAM" D ^DIC G:Y<0 Q S ENCTID=+Y
DEV ;
 N TIME
 W:'$D(IOP) !!,"OK, enter the device to which the bar code reader is connected.",!
 D ^%ZIS G:POP Q
 S ENCTEON=^%ZOSF("EON"),ENCTEOFF=^%ZOSF("EOFF"),ENCTTYPE=^%ZOSF("TYPE-AHEAD"),ENCTOPEN=$G(^%ZIS(2,IOST(0),10)),ENCTCLOS=$G(^%ZIS(2,IOST(0),11))
 U IO D OFF D WARN^ENCTMES1 R X:DTIME G:X="^" Q
 D ON S ENCT=+$P(^PRCT(446.4,ENCTID,0),"^",9)_"^2" D SPC^ENCTLAB H 3
 S TIME=$P($H,",",2)
 ;  for janus readers
 N ENCTJNUS
 I $TR($P($G(^PRCT(446.6,+$P($G(^PRCT(446.4,ENCTID,0)),"^",9),0)),"^"),"janus","JANUS")["JANUS" S ENCTJNUS=1
 F LN=0:0 S LN=$O(^PRCT(446.4,ENCTID,1,LN)) Q:'LN  I $D(^(LN,0)) S X=^(0) D LN I X]"" W:$G(ENCTJNUS) $C(15) W X W:$G(ENCTJNUS) $C(22) W ! D:$G(ENCTJNUS)
 . D OFF W *0
 . D ON
 S ENCT=+$P(^PRCT(446.4,ENCTID,0),"^",9)_"^3" D SPC^ENCTLAB
 F I=1:1:5 R ENX(I):5 Q:'$T
 D OFF,^%ZISC
 W !!,"Download time: "_($P($H,",",2)-TIME)_" sec."
 I $G(ENX(1))=$C(30) W !,"DOWNLOAD SUCCESSFUL, you may now disconnect the bar code reader.",!!
Q D HOME^%ZIS K LN,POP,ENCTID,ENSTA,DIC,I,J,K,IOP
 Q
 ;
LN ;
 S X=$P(X,"::") F Y=$L(X):-1:0 Q:$E(X,Y)'=" "  S X=$E(X,1,Y-1)
 I '$D(COL1) S:X["|" X=$P(X,"|")_@$P(X,"|",2)_$P(X,"|",3)
 Q
 ;
ON X ENCTOPEN U IO X ENCTEOFF,ENCTTYPE
 Q
 ;
OFF X ENCTCLOS,ENCTEON U IO(0)
 Q
 ;
COM ;Entry point to allow the alignment of IRL comments in Barcode Program file
 S DIC="^PRCT(446.4,",DIC(0)="QEAM" D ^DIC G:Y<0 Q2 S ENCTID=+Y
 S X="At what character do you want comments to begin?^35^^30,35,40,45,50^COM^ENCTMES1" D ^ENCTQUES G:X="^" Q2 S COL1=X
 F LN=0:0 S LN=$O(^PRCT(446.4,ENCTID,1,LN)) Q:'LN  I $D(^(LN,0)) S X=^(0),Y=COL1 D CON S ^PRCT(446.4,ENCTID,1,LN,0)=Y W "."
 W "... Done"
Q2 K COL1,LN,ENCTID Q
CON ;X=IRL TEXT,Y=COLUMN TO START COMMENTS, Can be called from Fileman
 S COL=Y,(LN1,Y)=X G:X'["::" Q3 D LN F Y=0:0 Q:COL-3<$L(X)  S X=X_" "
 S:$A($E(X,$L(X)))>32 X=X_" " S Y=X_"::"_$P(LN1,"::",2)
Q3 K LN1,COL Q
IDENT ; Called by input transform for IDENTIFIER (446.4,.02)
 I $D(^PRCT(446.4,"C",X)),$O(^(X,""))'=DA S X=$O(^("")) W !,"This IDENTIFIER already exists for ",$S($D(^PRCT(446.4,+X,0)):$P(^(0),"^"),1:X)," !" K X Q
 I '$D(^DIC(9.4,"C",$E(X,1,$L(X)-2))) W !,"The PACKAGE NAME SPACE '",$E(X,1,$L(X)-2),"' does not exist !" K X
 Q
 ;ENCTBAR
