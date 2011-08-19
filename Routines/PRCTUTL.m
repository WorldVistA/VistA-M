PRCTUTL ;WISC@ALTOONA/RGY-HANDLES MISC TASKS ;3-6-91/17:11
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
PRO ;Enter/edit barcode program
 S DIC="^PRCT(446.4,",DIC(0)="QEAML",DLAYGO=446.4 D ^DIC G:+Y<0 Q1 S DA=+Y,DIE=DIC,DR="[PRCT PROGRAM ENTER/EDIT]" D ^DIE
Q1 K DIC,DIE,DA,DLAYGO,DR,%DT,%X,D0,DG,DQ,J Q
PARAM ;Edit barcode parameters
 S DIC="^PRCT(446.4,",DIC(0)="QEAM" D ^DIC G:+Y<0 Q2 S DA=+Y
 S DIE=DIC,DR=$S(DUZ(0)["@":"[PRCT PARAMETER (CREATOR)]",1:"[PRCT PARAMETER (USER)]")
 D ^DIE G PARAM
Q2 K DIC,DIE,DA,DR,%DT,%X,D0,DQ Q
DATA ;Enter/Edit/View barcode data
 S DIC="^PRCT(446.4,",DIC(0)="QEAM" D ^DIC G:+Y<0 Q3 S DIE=DIC,DR="[PRCT DATA ENTER/EDIT/VIEW]",DA=+Y D ^DIE
Q3 K DIC,DIE,DA,DR,%DT,%X,%Y,D,D0,D1,DLAYGO,DQ,J Q
IDENT ; Called by input transform for IDENTIFIER (446.4,.02)
 I $D(^PRCT(446.4,"C",X)),$O(^(X,""))'=DA S X=$O(^("")) W !,"This IDENTIFIER already exists for ",$S($D(^PRCT(446.4,+X,0)):$P(^(0),"^"),1:X)," !" K X Q
 I '$D(^DIC(9.4,"C",$E(X,1,$L(X)-2))) W !,"The PACKAGE NAME SPACE '",$E(X,1,$L(X)-2),"' does not exist !" K X
 Q
RTN ; Called by input transform for 446.4,.03 and 446.4,.04
 N Y
 S:X'["-" X="-"_X I $D(^%ZOSF("TEST")) S Y=X,X=$P(X,"-",2) X ^%ZOSF("TEST") S X=Y I '$T W " ... routine does not exist" K X
 Q
PROG ; Called by the input transform for 446.52,1
 I $S('$D(DUZ)#2:1,'$D(^VA(200,DUZ,0)):1,1:0) K X W " ... Sorry, Your DUZ (user value) is not defined" Q
 I '$D(DUZ(0))#2 K X W " ... Sorry, your FileMan access is not defined" Q
 I DUZ(0)'="@" K X W " ... Sorry, only programmers can use this field" Q
 D ^DIM W:'$D(X) " ... MUMPS code has an error" Q
INQ ;Call to inquire on FILEMAN report
 S DIC="^PRCT(446.5,",DIC(0)="QEAM",DR="0:2" D ^DIC G:Y<0 Q4 S DA=+Y D EN^DIQ G INQ
Q4 K DIC,DA,%DT,A,D0,D1,DIW,DIWF,DIWL,DIWR,DIWT,DK,DL,DN,DR,DX(0),S Q
