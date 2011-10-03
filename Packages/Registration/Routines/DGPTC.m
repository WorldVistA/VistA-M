DGPTC ;ALB/MJK - Census Main Options; 15 APR 90 ; 5/11/01 1:15pm
 ;;5.3;Registration;**383,643,702**;Aug 13, 1993
 ;
 D DT^DICRW S X="DGPTC",DIK="^DOPT("""_X_""","
 G A:$D(^DOPT(X,10))
 S ^DOPT(X,0)="Census Main Options^1N^"
 F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT(X,I,0)=$P(Y,";",3,99)
 D IXALL^DIK
 ;
A W !! S DIC="^DOPT(""DGPTC"",",DIC(0)="IQEAM"
 D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Load/Edit PTF Record
 G ^DGPTF
 ;
2 ;;Release Closed Census Record
 S Y=2 D RTY^DGPTUTL,^DGPTFREL
 Q
 ;
3 ;;Open Closed Census Record
 S Y=2 D RTY^DGPTUTL,HEL^DGPTFDEL
 K DGADM,DGDOM,DGNHCU,MASD,MASDEV,PARA,DG,DGHEM Q
 ;
4 ;;Transmit Census Records
 D CLOSE G Q4:'Y
 S Y=2 D RTY^DGPTUTL,^DGPTFTR
Q4 K DGCN,DGCN0 Q
 ;
5 ;;Re-Open Released/Transmitted Records
 S Y=2 D RTY^DGPTUTL,DREL^DGPTFDEL
 Q
 ;
6 ;;Census Outputs
 G ^DGPTCO
 ;
7 ;;Census Date Parameters
 D CHKCUR^DGPTCO1
 K DGDASH W ! D DATE^DGPTCO1 S:Y]"" DIC("B")=Y
 S DIC="^DG(45.86,",DIC(0)="AELMQ" D ^DIC K DIC G Q7:Y<0
 S (D0,DGCN)=+Y D PAR
 ;S DA=DGCN,DIE="^DG(45.86,",DR="[DGPT CENSUS DATE]" D ^DIE K DIE,DR,DQ,DE
 ;I '$D(Y) S D0=DGCN D PAR W !!
Q7 K DGCN,D0,DA Q
 ;
8 ;;Regenerate Census WorkFile
 D GEN^DGPTCR
 Q
 ;
9 ;;Send 099 Transmission for Census Record
 D CLOSE G Q9:'Y
 S Y=2 D RTY^DGPTUTL,EN^DGPTF099
Q9 K DGCN,DGCN0 Q
 ;
10 ;;Close Census Reord
 W ! S DIC="^DGPT(",DIC(0)="AEMZQ",DIC("S")="I '$P(^(0),U,6),$P(^(0),U,11)=1"
 D ^DIC K DIC G Q10:Y<0
 S (DGPTF,PTF)=+Y,DFN=+Y(0) D PM^DGPTUTL,CEN^DGPTC1
 I '$D(DGCST) W !!,*7," >>>> Census transactions are not required for this PTF record." G 10
 I DGCST W !!,*7," >>>> This PTF record is already closed for census. (Census #",$S($D(DGCI):DGCI,1:""),")" G 10
 D UPDT^DGPTUTL:'$P(Y(0),U,4) S DGPTFE=$P(^DGPT(PTF,0),U,4)
 S Y=+$S($D(^DG(45.86,+DGCN,0)):+^(0),1:"") D FMT^DGPTUTL
 S Y=2 D RTY^DGPTUTL
 D CLS^DGPTC1
 I 'DGCST W !!," >>>> Not able to close for census.  Please use 'Load/Edit' option to edit PTF."
 D Q1^DGPTF G 10
Q10 K DG1,DGL,DGADM,DGPTFMT,DFN,PTF,DGPTFE,DGRTY,DGRTY0,DGPTF D KVAR^DGPTC1 Q
 ; 
CLOSE ; -- can we xmit?
 D CEN^DGPTUTL S Y=1
 I 'DGCN W !!?5,*7,"There is currently no active census being conducted." S Y=0 G CLOSEQ
 I DT>$P(DGCN0,U,2) S Y=$P(DGCN0,U,2) X ^DD("DD") W !!?5,*7,"Census Close date has passed (",Y,").",!?5,"No transmissions allowed." S Y=0 G CLOSEQ
CLOSEQ Q
 ;
PAR ; census date parameter profile
 ;  input: D0 := ifn of ^DG(45.86)
 S X="DGPTXCP" X ^%ZOSF("TEST") G PARQ:'$T
 K DGDASH,DXS S $P(DGDASH,"-",81)="",IOP="HOME" D ^%ZIS K IOP
 W @IOF,*13,$E(DGDASH,1,28)," Quick Parameter Profile ",$E(DGDASH,1,27)
 D ^DGPTXCP W !,DGDASH
PARQ K DGDASH,DXS Q
