ENCTUTL ;(WASH ISC)/RGY-Bar Code Task Handler ;1-19-93
 ;;7.0;ENGINEERING;;Aug 17, 1993
 ;Copy of PRCTUTL ;DH-WASH ISC
PRO ;Enter/edit barcode program
 S DIC="^PRCT(446.4,",DIC(0)="QEAML" D ^DIC G:+Y<0 Q1 S DIE=DIC,DR="[ENCT PROGRAM ENTER/EDIT]",DA=+Y D ^DIE
Q1 K DIC,DIE,DA,DR Q
PARAM ;Edit barcode parameters
 S DIC="^PRCT(446.4,",DIC(0)="QEAM" D ^DIC G:+Y<0 Q2 S DIE=DIC,DR="[ENCT PARAMETER ENTER/EDIT]",DA=+Y D ^DIE
Q2 K DIC,DIE,DA,DR Q
DATA ;Enter/Edit/View barcode data
 S DIC="^PRCT(446.4,",DIC(0)="QEAM" D ^DIC G:+Y<0 Q3 S DIE=DIC,DR="[ENCT DATA ENTER/EDIT/VIEW]",DA=+Y D ^DIE
Q3 K DIC,DIE,DA,DR Q
IDENT ; Called by input transform for IDENTIFIER (446.4,.02)
 I $D(^PRCT(446.4,"C",X)),$O(^(X,""))'=DA S X=$O(^("")) W !,"This IDENTIFIER alread exists for ",$S($D(^PRCT(446.4,+X,0)):$P(^(0),"^"),1:X)," !" K X Q
 I '$D(^DIC(9.4,"C",$E(X,1,$L(X)-2))) W !,"The PACKAGE NAME SPACE '",$E(X,1,$L(X)-2),"' does not exist !" K X
 Q
RTN ; Called by input transform for 446.4,.03 and 446.4,.04
 S:X'["-" X="-"_X I $D(^DD("OS"))#2,$D(^("OS",^DD("OS"),18)) S ENCT1=X,X=$P(ENCT1,"-",2) X ^(18) S X=ENCT1 K ENCT1 I '$T W " ... routine does not exist" K X
 Q
PROG ; Called by the input transform for 446.52,1
 I $S('$D(DUZ)#2:1,'$D(^VA(200,DUZ,0)):1,1:0) K X W " ... Sorry, Your DUZ (user value) is not defined" Q
 I '$D(DUZ(0))#2 K X W " ... Sorry, your FileMan access is not defined" Q
 I DUZ(0)'="@" K X W " ... Sorry, only programmers can use this field" Q
 D ^DIM W:'$D(X) " ... MUMPS code has an error" Q
INQ ;Call to inquire on FILEMAN report
 S DIC="^PRCT(446.5,",DIC(0)="QEAM",DR="0:2" D ^DIC G:Y<0 Q4 S DA=+Y D EN^DIQ G INQ
Q4 K DIC,DA Q
