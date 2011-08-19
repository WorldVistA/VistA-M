LRBLS ;AVAMC/REG - BLOOD BANK SUPERVISOR OPTS ;12/01/95  15:30 ;
 ;;5.2;LAB SERVICE;**97,247,267,275,315,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;Reference to $$CPTD^ICPTCOD Supported by 1995
 ;Reference to EN^DDIOL Supported by ICR# 10142
 ;Reference to ^DIC Supported by ICR# 2051
 ;Reference to MIX^DIC1 Supported by ICR# 10007
 ;Reference to ^DIE Supported by ICR# 10018
 ;Reference to ^DIR Supported by ICR# 10026
MSB ;max surg blood order edit
 Q  D END I '$D(^ICPT(0)) W $C(7),!!,"Current Procedure Terminology File (#81) not installed.",! G END
 W ! S DIC="^ICPT(",DIC("A")="Select OPERATION: ",DIC(0)="AEOQMZ",DIC("S")="I $P(^(0),U,3),$P(^DIC(81.1,$P(^DIC(81.1,$P(^ICPT(Y,0),U,3),0),U,3),0),U)=""SURGERY""" D ^DIC K DIC G:Y<1 END S (DA,X)=+Y
 D:'$D(^LAB(66.5,X,0)) SET^LRBLPCSS D
  . N LRX
  . S LRX=X,LRX=$$CPTD^ICPTCOD(LRX,"LRX")
  . I +LRX=-1 Q
  . F I=1:1:LRX W !,LRX(I)
  . Q
 W !!,"Selection OK " S %=1 D YN^LRU G:%'=1 MSB W ! S DR=1,DIE="^LAB(66.5," D ^DIE G MSB
CR ;blood component request
 Q  W ! S (DIC,DIE)="^LAB(66.9,",DIC(0)="AEQLM",DLAYGO=66 D ^DIC G:Y<1 END W ! S DA=+Y,DR=".01;2;1" D ^DIE G CR
SNO Q  N A
 S A(1)="This option is case sensitive."
 S A(1,"F")="!!"
 S A(2)="Enter data using the EXACT case of the ANTIBODY or ANTIGEN."
 S A(3)=" "
 D EN^DDIOL(.A)
SNO1 S DIC="^LAB(61.3,",DIC(0)="AEMQZ"
 S DIC("A")="Select ANTIGEN or ANTIBODY: "
 S DIC("S")="I $P(^(0),U,5)=""AN""!($P(^(0),U,5)=""AB"")"
 D ^DIC K DIC G:Y<1 END
 I $D(DTOUT)!($D(DUOUT)) G END
 S LRBLDA=+Y
 S LRBLA=$S($P(Y(0),U,5)="AB":"ANTIBODY",1:"ANTIGEN")
 N A
 S A(2)=LRBLA_":  "_$P(Y,U,2)
 S A(2,"F")="!!?6"
 S A(3)="CORRESPONDING "_$S(LRBLA="ANTIBODY":"ANTIGEN",1:"ANTIBODY")_":  "_$S($P(Y(0),U,4)]"":$P(^LAB(61.3,$P(Y(0),U,4),0),U),1:"")
 S A(3,"F")="!?6"
 S A(4)="SNOMED CODE:  "_$P(Y(0),U,2)
 S A(4,"F")="!?6"
 S A(5,"F")="!"
 D EN^DDIOL(.A)
 N DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="IS THIS CORRECT"
 D ^DIR Q:$D(DIRUT)  G:Y=0 SNO1
 ;
 S DA=LRBLDA,DR=".04;.06;7;5",DIE=61.3 D ^DIE K DA,DIE,DR,DIC G SNO
DES Q  S DIC="^LAB(65.4,",DIC(0)="AEQLM",DLAYGO=65,DIC("S")="I $P(^(0),U,2)]""""" W ! D ^DIC K DIC G:X=""!(X[U) END S DA=+Y,DR=".01;.02;S Z=X;.03;S:""GC""'[Z Y=0;.04:1.9;3:99",DIE=65.4 D ^DIE K DA,DIE,DR,DIC G DES
BBD Q  S DIC("A")="Select BLOOD BANK DESCRIPTIONS NAME: ",DIC="^LAB(62.5,",DIC(0)="AEQLM",DLAYGO=62,DIC("S")="I ""BDRJXZ""[$P(^(0),U,4)"
 W ! D ^DIC K DIC G:X=""!(X[U) END S DA=+Y,DR=".01;5;1;.5",DIE="^LAB(62.5," D ^DIE K DA,DIE,DR,DIC,DLAYGO G BBD
COM Q  W ! S (DIC,DIE)="^LAB(66,",DIC(0)="AEQLM",DLAYGO=66 D ^DIC K DIC,DLAYGO G:X=""!(X[U) END S DA=+Y,LR=$S($P(Y,U,2)["PEDIATRIC":1,1:0),DR=".01:.05;.29;10;.055:.1;9;.11:.19;S:LR Y=.23;.21:.28;1:999" D ^DIE K DA,DR,DIE,DIC G COM
LL Q  W ! S (DIC,DIE)="^LAB(65.9,",DIC(0)="AEQLM",DLAYGO=65 D ^DIC G:Y<1 END S DA=+Y,DR=".01:99" D ^DIE G LL
HX Q  S DA=$O(^LAB(65.4,"B","DNRHX",0)) G:'DA END S DIE=65.4,DR=2 D ^DIE K DIE,DR,DIC,DA Q
DL Q  W ! S (DIC,DIE)="^LAB(65.9,",DIC(0)="AEQLM",DLAYGO=65,DIC("S")="I ""01""[$P(^(0),U,2)" D ^DIC K DIC,DLAYGO G:Y<1 END S DA=+Y,DR=".01:99" D ^DIE G DL
CX Q  S DA=$O(^LAB(65.4,"B","DNRCX",0)) G:'DA END S DIE=65.4,DR=3 D ^DIE K DIE,DR,DIC,DA Q
LRAD W ! S (DIC,DIE)=65,DIC(0)="AEQM" D ^DIC K DIC G:Y<1 END S DA=+Y,DR="[LRBLIXR]" D ^DIE K DA,DR,DIE,DIC G LRAD
A Q  D Z G:Y=-1 END G EN1^LRUDIT
 ;
SP Q  I $S('$D(^LAB(69.9,1,8,0)):1,$P(^(0),"^",4)<8:1,1:0) D C
 W ! D END S DIE="^LAB(69.9,",DA=1,DR=".18;8.1" D ^DIE,END
ASK W ! S DIC="^LAB(69.9,1,8,",DIC(0)="AEQM",DIC("A")="Select BLOOD BANK DEFAULT OPTION: " D ^DIC K DIC G:Y<1 END
 S DA=+Y,DIE="^LAB(69.9,1,8,",DR=".02:.07" D ^DIE G ASK
 ;
C S Y="DONOR^INVENTORY^PATIENT^INQUIRIES^REPORTS^SUPERVISOR^TEST WORKLISTS^WARD"
 F A=1:1:8 I '$D(^LAB(69.9,1,8,A,0)) S ^(0)=$P(Y,"^",A),^LAB(69.9,1,8,"B",$P(Y,"^",A),A)=""
 S ^LAB(69.9,1,8,0)="^69.98A^8^8" Q
 ;
EN Q  D:'$D(LRAA) Z W ! S (DIC,DIE)=65.5,DIC(0)="AEQM",D="B^C^"_$S("NAFARMY"[DUZ("AG")&(DUZ("AG")]""):"G4^G",1:"D") D MIX^DIC1 K DIC G:Y<1 END S DA=+Y,DR="[LRBLDEF]" D ^DIE K DA,DR,DIE,DIC G EN
 ;
Z S X="BLOOD BANK" D ^LRUTL Q
 ;
END D V^LRU Q
