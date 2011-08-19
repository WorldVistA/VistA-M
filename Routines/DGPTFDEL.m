DGPTFDEL ;ALB/JDS - PTF ENTRY DELETION ; 7/31/07 11:19am
 ;;5.3;Registration;**517,760**;Aug 13, 1993;Build 11
 ;
A D LO^DGUTL I $D(^DISV(DUZ,"^DPT(")),$D(^("^DGPT(")) S A=+^("^DGPT("),B=+^("^DPT(") I $D(^DGPT(A,0)),$D(^DPT(B,0)) S:(+^DGPT(A,0)'=B&$D(^DGPT("B",B))) ^DISV(DUZ,"^DGPT(")=""
 Q
 ;
ASK D A W !!
 S Y=1 D RTY^DGPTUTL
 S DIC("S")="I $P(^(0),U,11)=1,'$D(^DGP(45.84,+Y))",DIC="^DGPT(",DIC(0)="NEAQ",DIC("A")="Enter PTF record to delete: "
 D ^DIC G Q:Y'>0 S DA=+Y,DIC(0)="NE",X=DA D CEN G ASK:'$D(DA)
A1 W !! D ^DIC S %=2 W !,"Ok to delete" D YN^DICN
 I %=1 S DGPTIFN=DA D KDGPT W !,"****** DELETED ******" D HANG^DGPTUTL G Q
AD I '% W !,"Anwer Yes or No",!,"On deletion pointers will be updated" G A1
 ;
 ;
Q K DA,DFN,A,B,L,I,ANS,DIE,DR,DIK,DIC,DGRTY,DGRTY0,DGPTIFN Q
 ;
HEL ;
 I '$D(DGRTY) S Y=1 D RTY^DGPTUTL
 D A W !!
 S DIC(0)="NEAQ",DIC="^DGP(45.84,",DIC("S")="I '$D(^DGP(45.83,""C"",+Y)),$D(^DGPT(+Y,0)),$P(^(0),U,11)="_DGRTY,DIC("A")="Enter "_$P(DGRTY0,U)_" record to re-open: "
 D ^DIC G Q:Y'>0 S (X,DGPTIFN)=+Y,%=2
A2 I '% W !!,DGPTIFN,"  ",$P(^DPT(+^DGPT(DGPTIFN,0),0),U) S DGSENFLG="",X=DGPTIFN,DIC(0)="NE",DIC="^DGP(45.84," D ^DIC K DIC,DGSENFLG
 I DGRTY=2 D CHK G Q:'DGPTIFN
 S %=2 W !,"Ok to reactivate" D YN^DICN
 I '% W !,"Answer Yes or No" G A2
 G Q:%'=1
 D OPEN G Q
 ;
OLD I '$D(^DISV(DUZ,"PTFAD",DFN)) W "  ???",*7,*7 G AD
 S X=^(DFN)
 Q
DREL ; -- open released rec
 I '$D(DGRTY) S Y=1 D RTY^DGPTUTL
 W ! S DIC("A")="Enter Released "_$P(DGRTY0,U)_" Record to Re-open: ",DIC("S")="I $D(^DGP(45.83,""C"",+Y)),$D(^DGPT(+Y,0)),$D(^(70)),+^(70)>2901000,$P(^(0),U,11)="_DGRTY,DIC="^DGP(45.84,",DIC(0)="MEQA"
 D ^DIC K DIC G Q:+Y'>0 S DGPTIFN=+Y
 I DGRTY=2 D CHK G Q:'DGPTIFN
OK W !,"Ok to Re-open" S %=2 D YN^DICN
 I '% W !!?14,"Enter <RET> to exit routine",!?10,"Enter 'Y' for YES to RE-OPEN Record",! G OK
 G Q:%'=1
 S DA(1)=$O(^DGP(45.83,"C",DGPTIFN,0)) I DA(1) S DIK="^DGP(45.83,"_DA(1)_",""P"",",DA=DGPTIFN D ^DIK K DIK,DA
 D OPEN G Q
 ;
OPEN ;
 D KDGP,KDGPT:DGRTY=2
 W !,"****** RECORD RE-OPENED ******" D HANG^DGPTUTL
 Q
 ;
KDGP ; -- kill close-out rec ; input DGPTIFN := ifn
 S DA=DGPTIFN,DIK="^DGP(45.84," D ^DIK K DIK,DA
 Q
 ;
KDGPT ; -- kill DGPT rec ; input DGPTIFN := ifn
 S DA=DGPTIFN,DIK="^DGPT(",FLAG=1,I=0 F  S I=$O(^DGCPT(46,"C",DA,I)) Q:'I  I '$G(^DGCPT(46,I,9)) S FLAG=0 Q
 I 'FLAG W !,"CANNOT DELETE THE PTF RECORD WHEN THERE ARE ACTIVE ORDERS OR CPT RECORDS." H 2 K FLAG Q
 D ^DIK K DA,DIK,I,FLAG
 I DGRTY=1 S DA=+$O(^DGPM("APTF",DGPTIFN,0)) I $D(^DGPM(DA,0)),$P(^(0),U,16)=DGPTIFN S DR=".16///@",DIE="^DGPM(" D ^DIE K DR,DIE
 K DA Q
 ;
CHK ; -- check to see if PTF is open ; return DGPTIFN="" is not open
 I $D(^DGPT(+$P(^DGPT(DGPTIFN,0),U,12),0)),$P(^(0),U,6) W !!,*7,?5,"Associated PTF record #",+$P(^DGPT(DGPTIFN,0),U,12)," must be RE-OPENED",!?5,"in order to re-open Census record #",DGPTIFN,"." S DGPTIFN=""
 Q
 ;
CEN ; -- check if closed for census
 K DGI
 F DGI=0:0 S DGI=$O(^DGPT("ACENSUS",DA,DGI)) Q:'DGI  I $D(^DGPT(DGI,0)),$P(^(0),U,12)=DA,$D(^DG(45.86,+$P(^(0),U,13),0)) S Y=+^(0) X ^DD("DD") S DGI(DGI)=Y
 G CENQ:$D(DGI)<10
 W !!?2,*7,"This PTF record is associated with the following Census records:"
 F DGI=0:0 S DGI=$O(DGI(DGI)) Q:'DGI  W !?10,"Census Record #",DGI,?35,"==>",?40,"Census Date: ",DGI(DGI)
 W !!?2,"PTF record can not be deleted."
 K DA
CENQ K DGI Q
