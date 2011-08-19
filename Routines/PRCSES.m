PRCSES ;WISC/SAW-SUB-MODULES CALLED BY FIELDS IN CONTROL POINT ACT. FILE ;1/20/98 3:07 PM [7/14/98 3:04pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 W !,"Major budget object code classifications are:"
 W !,"10 thru 13 - Personal Services and Benefits"
 W !,"        21 - Travel and Transportation of Persons"
 W !,"        22 - Transportation of Things"
 W !,"        23 - Rent, Communications, and Utilities"
 W !,"        24 - Printing and Reproduction"
 W !,"        25 - Other Services"
 W !,"        26 - Supplies and Materials"
 W !,"31 thru 33 - Acquisition of Capital Assets",!
 Q
SUB ;INPUT TRANSFORM FOR BOC FIELD
 S Z0=$S($D(^PRCS(410,DA(1),3)):+$P(^(3),"^",3),1:0)
SUB1 I 'Z0!('$D(^PRCD(420.1,Z0,1,0))) K Z0,X Q
 S DIC="^PRCD(420.1,Z0,1,",DIC(0)="EMQZ" D ^DIC I +Y'>0 K DIC,X,Z0 Q
 S X=+$P(Y(0),"^") I '$D(^PRCD(420.2,X,0)) K DIC,X,Z0 Q
 S (PRCS("SUB"),X)=$E($P(^PRCD(420.2,X,0),"^"),1,30) K DIC,Z0 Q
 ;
VENDOR ;INPUT TRANSFORM FOR VENDOR FIELD
 ;
 N IEN,LOOP,OK,PRCX,PRCY,NAME,N9,RV,RVX
 K:X[""""!($A(X)=45)!($L(X)>30)!($L(X)<1)!((X?1P.E&'((X?1"`"1.N)!(X?1"**".E)))) X
 W:'$D(X) !,$C(7),"The vendor name must be between 1 and 30 characters long,",!,"without a leading punctuation mark."
 Q:'$D(X)
 I $P(^PRCS(410,DA,0),"^",4)=5 D ISS Q:'$D(X)  G VENDOR2
 S PRCX=X
AGAIN I $G(RV)>0 S NAME=$P($G(^PRC(440,RV,0)),U)
 I $G(RV)'>0 S X=PRCX
 S Z("Z")=1
 I $P(^PRCS(410,DA,0),"^",4)=3,$D(^(10)),$P(^(10),"^") D  K X Q
 .  W !,$C(7),"This is a repetitive item type of request."
 .  W !,"Cancel this request if you wish to order from a different vendor."
 .  Q
 K DIC
 K Y
 K Y(0)
 S Z(1)=$G(X)
 S DIC="^PRC(440,"
 S DIC(0)=$S($G(RV)>0:"EMQZ",1:"EMZ")
 S:$G(RV)>0 X="`"_RV
 S DIC("S")="I '$D(^PRC(440,""AC"",""S"",+Y))"
 D ^DIC
 ;
 ; QUIT IF USER TIMES OUT OR '^'s OUT.
 ;
 I $D(DTOUT)!($D(DUOUT)) S X="^" Q
 ;
 K:Y<0 X,RV
 S IEN=Y
 S PRCY(0)=$G(Y(0))
 K:+IEN>0 OK,RV
 D:+IEN>0 INACT
 ;
 ; ACTIVE VENDOR
 ;
 I $G(OK)=1 G VENDOR2
 ;
 ; INACTIVE VENDOR WITH REPLACEMENT VENDOR
 ;
 I $G(LOOP)=1!($G(RV)>0) K X,IEN,PRCY(0),DIC G AGAIN
 ;
 ; NO VENDOR SELECTED
 ;
 I +IEN'>0 D
 .  S X=Z(1)
 .  K Z(1)
 .  I $D(^PRCS(410,DA,3)),$P(^(3),U,4)'="" S $P(^(3),"^",4)=""
 .  Q
 ;
 ; INACTIVE VENDOR WOTHOUT A REPLACEMENT VENDOR
 ;
 I $G(RV)=0 D  Q
 .  K X
 .  K Z(1)
 .  I $D(^PRCS(410,DA,3)),$P(^(3),U,4)'="" S $P(^(3),"^",4)=""
 .  Q
 ;
VENDOR1 I +IEN'>0 W !,"INVALID SELECTION OR NOT IN VENDOR FILE. ARE YOU SURE",$C(7) S %=2 D YN^DICN G VENDOR1:%=0 K:%'=1 X W:%=1 !!,"Enter information for new vendor"
 ;
VENDOR2 I +IEN>0 D
 .  S Z(1)="@1"
 .  S X=$P(PRCY(0),U)
 .  S ^PRCS(410,DA,2)=$P(PRCY(0),U,1,10)
 .  S $P(^PRCS(410,DA,3),"^",4)=+IEN
 .  Q
 K %
 K DIC
 Q
 ;
ISS S IEN=$O(^PRC(440,"AC","S",0))
 S PRCY(0)=$S($D(^PRC(440,+IEN,0)):^(0),1:"")
 S X=$P(PRCY(0),"^")
 I 'IEN!(PRCY(0)="") D  K X Q
 .  W $C(7),"A&MM MUST enter the A&MM Warehouse as a vendor before you can place an"
 .  W !,"Issue Book request."
 .  Q
 W !,"Issue Book Requests will automatically be ordered from",!,X,!
 Q
 ;
INACT ; CHECK IF THE VENDOR SELECTED IS INACTIVE.
 ; IF INACTIVE, SEE IF THERE IS A REPLACEMENT VENDOR.
 ; IF THERE IS AN ACTIVE REPLACEMENT VENDOR SUGGEST THAT VENDOR
 ; TO THE USER.
 ;
 ; VARIABLES 'OK' AND 'RV' ARE UNDEFINED WHEN ENTERING 'INACT'.
 ;
 ; DIFFERENT OUTCOMES FROM INACT, AND OUTPUT VARIABLES.
 ;
 ;         CONDITION                         OUTPUT
 ; VENDOR SELECTED BY USER IS ACTIVE.     'OK' SET TO 1
 ; VENDOR SELECTED BY USER IS INACTIVE,
 ;        NO REPLACEMENT VENDOR AT END    'RV' SET TO 0
 ;        OF CHAIN.                       'LOOP' SET TO 1
 ; VENDOR SELECTED BY USER IS INACTIVE,
 ;        REPLACEMENT VENDOR AT END OF    'RV' SET TO SUBSTITUTE
 ;        CHAIN.                          VENDOR IEN
 ;                                        'LOOP' SET TO 1
 ;
 S N10=$G(^PRC(440,+IEN,10))
 I N10="" S OK=1 Q
 I $P(N10,U,5)="" S OK=1 Q
 S N9=$G(^PRC(440,+IEN,9))
 S RV=+N9
 I RV=+IEN S LOOP=1,RV=0
 W !!,"The VENDOR you have chosen is Inactivated."
 W:RV'>0 !,"You need to select an active vendor.",!!
 ;
 ;QUIT IF A REPLACEMENT VENDOR POINTS TO ITSELF
 ;
 S LOOP=""
 F  Q:RV=0  S IVCK=$P($G(^PRC(440,RV,10)),U,5) Q:IVCK=""  D  Q:LOOP=1
 .  S RVX=$G(^PRC(440,RV,9))
 .  I RVX'>0 S LOOP=1 Q
 .  I RV=RVX S LOOP=1 Q
 .  S RV=RVX
 .  Q
 ;
 ;PAUSE IF THERE IS NO REPLACEMENT VENDOR TO ALLOW USER TO SEE MESSAGE
 ;
 I RV'>0 D
 .  S DIR(0)="E"
 .  S DIR("A")="Press the return key to continue"
 .  D ^DIR
 .  Q
 W:RV>0 !,"Here is the suggested REPLACEMENT VENDOR.",!!
 Q
 ;
CC ;INPUT TRANSFORM FOR COST CENTER
 N Z1 S Z0=$P(^PRCS(410,DA,0),"^",5),Z1=$S($D(^(3)):+$P(^(3),"^"),1:0) I 'Z0!('Z1) K X G CC1
 I '$D(^PRC(420,Z0,1,0))!('$D(^PRC(420,Z0,1,Z1,2,0))) K X G CC1
 S DIC="^PRC(420,Z0,1,Z1,2,",DIC(0)="QEMZ" D ^DIC I +Y'>0 K X G CC1
 S X=$P(Y(0),"^") I '$D(^PRCD(420.1,X,0)) K X G CC1
 S X=$E($P(^PRCD(420.1,X,0),"^"),1,30)
CC1 K DIC,Z0,Z1 Q
TRANS ;SET FOR X-REF ON TRANS $ AMT FIELD
 G TRANS^PRCSEZ
TRANS1 G TRANS1^PRCSEZ
TRANK ;KILL FOR X-REF ON TRANS $ AMT FIELD
 G TRANK^PRCSEZ
TRANK1 G TRANK1^PRCSEZ
STATUS ;COMPUTES STATUS OF PO FOR FIELD 54, FILE 410
 S X="",Y(410)=$S($D(^PRCS(410,D0,10)):$P(^(10),"^",3),1:"")
 I $D(^PRC(443,D0,0)) S Y(411)=$P(^(0),"^",7) I Y(411),$D(^PRCD(442.3,Y(411),0)) S X=$P(^(0),"^")
 I Y(410),$D(^PRC(442,Y(410),7)) S Y(410)=$P(^(7),"^") I Y(410),$D(^PRCD(442.3,Y(410),0)) S X=$P(^(0),"^")
 K Y(410),Y(411) Q
