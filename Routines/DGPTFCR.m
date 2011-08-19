DGPTFCR ;ALB/JDS - CREATE IN PATIENT PTF RECORD ; 11 JAN 85
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN D LO^DGUTL F DGDUMB=0:0 K DFN D SEL Q:'$D(DFN)
Q K %,D0,DQ,T,Y,X,DGDUMB Q
 ;
SEL ; -- pt select
 W ! K DIC
 S DIC(0)="AEQMZ",DIC="^DPT(",DIC("S")="I $D(^DGPM(""APTT1"",+Y))",DIC("A")="Select Patient: "
 D ^DIC K DIC G SELQ:Y'>0 S DFN=+Y
 ;
 ; -- adm mvt select
 ; will change to use ^DGPM("ADFN") cross-reference when available
 W !
 S DIC(0)="EQZ",DIC="^DGPM(",DIC("S")="I $P(^(0),U,2)=1,'$P(^(0),U,26),'$D(^DGPT(+$P(^(0),U,16),0))",DIC("A")="Select Admission Date: "
 D DFN^DGPMUTL K DIC G SELQ:Y'>0
 ;
 N DGPMCA,DGPMAN,DGPMDN
 S DGPMCA=+Y,DGPMAN=Y(0),DGPMDN=$S($D(^DGPM(+$P(DGPMAN,"^",17),0)):^(0),1:""),DGTY=$S($D(^DG(405.2,+$P(DGPMDN,"^",18),0)):$P(^(0),"^",8),1:0)
 S Y=1 D RTY^DGPTUTL S Y=+DGPMAN
 W !!?5,"Creating new PTF record..."
 D CREATE I +Y<0 W *7,"unable to create record." G SELQ
 S PTF=+Y,DR="[DG PTF ATTACH]",DIE="^DGPM(",DA=DGPMCA D ^DIE
 W !?5,"record #",PTF," created.",!
SELQ K DR,X,DA,DIE,DIC,DGTY,DGRTY,DGRTY0,PTF,I,J,Y,DQ,DG Q
 ;
CREATE ; -- entry point to create a new PTF record
 ;    input:   DFN := pt number
 ;               Y := admission d/t ^ fee record
 ;           DGRTY := type of record (1-PTF ; 2-CENSUS)
 ;                    (PTF assumed if undefined)
 ;   output:     Y := ifn of ^DGPT
 ;
 I $S('$D(DFN):1,'DFN:1,1:'Y) S Y=-1,Y(0)="" G CREATEQ
 S DGPTDATA=U_Y,DIC="^DGPT(",DIC("DR")="[DG PTF CREATE PTF ENTRY]"
 S DIC(0)="FLZ",X=DFN K DD,DO D FILE^DICN S Y=+Y
 I $S('$D(DGRTY):1,1:DGRTY=1) N PTF K DA S (PTF,DA)=Y,DIE="^DGPT(",DR="[DG PTF POST CREATE]" D ^DIE:DA>0 S Y=PTF
CREATEQ K DA,DIC,DGPTDATA,DIE,DR Q
