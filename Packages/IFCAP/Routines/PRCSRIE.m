PRCSRIE ;WISC/SAW/DXH - BUILD AND MAINTAIN REPETITIVE ITEM LIST FILE ;7.26.99
V ;;5.1;IFCAP;**13,53**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ENTER REP ITEM
 N CC S CC=0
 D ENF^PRCSUT(1) G W5^PRCSUT3:'$D(PRC("SITE")) G EXIT:Y<0
 ;I $$ISSUPFCP^PRCSCK(PRC("SITE"),+PRC("CP")) S CC=+$$SUPPLYCC^PRCSCK()
 ;I $$VALIDCC^PRCSECP(PRC("SITE"),+PRC("CP"),CC) S DIC("B")=CC G GOTDFLT
 S CC=$$GETCCCNT^PRCSECP(PRC("SITE"),+PRC("CP"))
 I 'CC G CC ;GO BAIL OUT IF NO CC'S DEFINED
 I +CC=1 S DIC("B")=$P(CC,U,2)
GOTDFLT S DIC("A")="Select COST CENTER: "
 S DIC="^PRC(420,PRC(""SITE""),1,+PRC(""CP""),2,",DIC(0)="AEMNQZ"
 D ^DIC I Y'>0 G EXIT
 S Y=$P(Y(0),"^") I '$D(^PRCD(420.1,Y,0)) G ERREXIT
 ;
STF N REP
 S REP=1
 S X=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")_"-"_Y
 D EN1^PRCSUT3
 S DLAYGO=410.3,DIC="^PRCS(410.3,",DIC(0)="LZ" D ^DIC K DLAYGO
 G W4^PRCSUT3:Y<0 S (PRCSDA,DA)=+Y
 L +^PRCS(410.3,DA):15 G:$T=0 PRCSRIE
 Q:$D(PRCHSPD)
 D NOW^%DTC S $P(^PRCS(410.3,DA,0),"^",2)=0,$P(^(0),"^",4)=%
 S PRCSNO=$P(^PRCS(410.3,DA,0),"^") S:$D(PRCSIP) $P(^(0),"^",3)=PRCSIP
 S DIC(0)="AEMQ",DIE=DIC,DR="[PRCSRI]",DIE("NO^")=1 D ^DIE
 S DA=PRCSDA L -^PRCS(410.3,DA) K DIE("NO^")
 D CALC^PRCSRIE1
W1 W !!,"Would you like to create another repetitive item list entry"
 S %=2 D YN^DICN
 G W1:%=0,EXIT:%=2!(%<0)
 W !! K PRCSV,PRCSV1
 G PRCSRIE
 ;
VENDOR ;INPUT TRANS VENDOR FIELD-410.3
 Q:'$D(PRC("SITE"))  Q:'$D(PRC("CP"))  S Z0=$P(^PRCS(410.3,DA(1),1,DA,0),"^") K:'Z0 X G EX1:'Z0,EX1:'$D(^PRC(441,Z0,2,0))
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),"^",12)=2 S DIC("S")="I '$D(^PRC(440,""AC"",""S"",+Y))"
 S DIC="^PRC(441,Z0,2,",DIC(0)="QEMNZ" D ^DIC K DIC("S") I Y'>0 K X G EX1
 I '$D(^PRC(440,+Y,0)) K X G EX1
 S X=$P(^PRC(440,+Y,0),"^"),$P(^PRCS(410.3,DA(1),1,DA,0),"^",5)=+Y
VENDOR1 S Z=$P(Y(0),"^",2) I Z="" D VENDOR2 Q
 I Z=0 W !,"NOTE: This item has a unit cost of $0.00" ;HEH-0502-40043
 S $P(^PRCS(410.3,DA(1),1,DA,0),"^",4)=Z
EX I $P(Y(0),"^",12) W $C(7),!,"NOTE: This item has a minimum order quantity of ",$P(Y(0),"^",12)
 I $P(Y(0),"^",11) W $C(7),!,"NOTE: This item must be ordered in multiples of ",$P(Y(0),"^",11)
 I $P(Y(0),"^",8) S Z(1)=$P(Y(0),"^",7),Z(1)=$S($D(^PRCD(420.5,+Z(1),0)):$P(^(0),"^",2),1:"") I Z(1)'="" W $C(7),!,"NOTE: This item has a packaging multiple/unit of purchase of ",$P(Y(0),"^",8)_"/"_Z(1)
EX1 K DIC,Z0,Z("DR")
 Q
 ;
VENDOR2 K DIC,Z0,Z("DR")
 S NOCOST=1
 S DIC(0)="AEMQ",DIC="^PRCS(410.3,",DIK=DIC_DA(1)_",1,"
 ;
 W !!,"   The vendor you have chosen has no unit cost for this item."
 W !,"   Please do one of the following:"
 W !,"      1. Choose another item."
 W !,"      2. Choose another vendor."
 W !,"      3. Contact A&MM to enter the unit cost.",!!
 ;
 QUIT
 ;
VENDORC ;CK MND SOURCE/PREF VENDOR
 S Z0=$P(^PRCS(410.3,DA(1),1,DA,0),"^") K PRCSV1 I 'Z0 K Z0 Q
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),"^",12)=2 G V2
 S Z2=$P(^PRCS(410.3,DA(1),1,DA,0),"^",3),Z3="This item has a mandatory source (vendor) of "
 I $P(^PRC(441,Z0,0),"^",8) S Y=$P(^(0),"^",8) I $D(^PRC(440,Y,0)) S X=$P(^(0),"^") Q:X=Z2
 I  W !,$C(7),Z3,X S $P(^PRCS(410.3,DA(1),1,DA,0),"^",3)=X,$P(^(0),"^",5)=Y,^PRCS(410.3,DA(1),1,"AC",X,DA)="",PRCSV=1 I Z2'="" K ^PRCS(410.3,DA(1),1,"AC",Z2,DA)
 K Z2,Z3 I $D(PRCSV) S Y(0)=$S($D(^PRC(441,Z0,2,Y,0)):^(0),1:"") G VENDOR1
V2 S X=0,X=$O(^PRC(441,Z0,4,"B",PRC("SITE")_$P(PRC("CP")," "),X)) I X,$D(^PRC(441,Z0,4,X,0)),$P(^(0),"^",3)'="" S PRCSV1=$P(^(0),"^",3)
 I $D(PRCSV1),$D(^PRC(440,PRCSV1,0)) S PRCSV1=$P(^(0),"^") W !,$C(7),"The following is the preferred (but not mandatory) vendor for this item." K X,Z0
 Q
CC W $C(7),!!,"There are no cost centers entered for this station and control point in the Fund",!,"Control Point file.  You must enter one or more cost centers before continuing." R !,"Press return to continue: ",X:5
EXIT K %,DA,DIC,DIE,DR,PRCSDA,PRCSL,PRCSNO,PRCSV,PRCSV1,Y(0),X,Y,Z,Z0,Z1 Q
ERREXIT W $C(7),!!,"That Cost Center is invalid."
 R "  Press return to continue: ",X:5
 G EXIT
