PRCBR ;WISC@ALTOONA/CLH/CTB-ROUTINE TO RELEASE FUND DISTRIBUTION TRANSACTIONS ; 10 Apr 93  3:50 PM
V ;;5.1;IFCAP;**139**;Oct 20, 2000;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 N X,DIR,DIC,DR,DIE,DIK,PRC,PRCF,PRCB,PRCFA,%,Y,Z,Z1,Q,J,K,D,Y,FAIL
 S X="BUDGET RELEASE" D ^PRCFALCK I '% G KILL
 S PRCF("X")="ABFS" D ^PRCFSITE G:'% OUT
 S X=$O(^PRCF(421,"AL",PRCF("SIFY"),"")) I X'=0&(X'=1) W !!,$C(7),"There are no PENDING RELEASE transactions for FY: ",PRC("FY") R X:3 G OUT
 S K=0 I '$D(^PRC(420,PRC("SITE"),2,DUZ)) W !,"You are not authorized to release funds for station ",PRC("SITE"),",",!,"PLEASE CONTACT YOUR APPLICATION MANAGER.",$C(7) R X:3 G OUT
 D SIG^PRCFACX0 K PRCFK I $D(PRCFA("SIGFAIL")) K PRCFA("SIGFAIL") G OUT
 N DIR,Y,X
 S PRCB("CK")="" S DIR(0)="YO",DIR("A")="Do you wish to review/edit any transactions",DIR("B")="NO",DIR("?")="Enter yes to review/edit a transaction, '^' to quit" D ^DIR G:Y["^" OUT
 I Y D
  . S DR="[PRCB NEW TRANSACTION]",DIC("A")="Select Sequence Number for "_$S($D(PRCB("MDIV")):"Station "_PRC("SITE")_",",1:"")_" FY "_PRC("FY")_": "
  . S Z="",PRCFLAST=PRCB("LAST") D EN21^PRCBE S PRCB("LAST")=PRCFLAST K PRCFLAST I '$D(PRCF("SIFY")) S PRCF("SIFY")=PRC("SITE")_"-"_PRC("FY")
ASK R !,"Enter Sequence Number of Transaction(s) to be Released: ",X:DTIME G:X["?" Q1 G:X["^" OUT G:X="ALL" ALL G:X["-" DASH G:X="" UNDO I X'?1.N W $C(7),"  ??" G ASK
 S (Z,X1)=X D ZERO S X1=Z I '$D(^PRCF(421,"B",PRCF("SIFY")_"-"_X1)) W $C(7),!,"  ??" G Q1A
 S DA=$O(^PRCF(421,"B",PRCF("SIFY")_"-"_X1,0)) I $D(^PRCF(421,"AL",PRCF("SIFY"),2,DA)) W $C(7),!,"  THIS SEQUENCE HAS ALREADY BEEN RELEASED.  RERELEASE IS NOT PERMITTED." G Q1A
 I $D(^PRCF(421,"AL",PRCF("SIFY"),1,DA)) W !,$C(7),"THIS TRANSACTION HAS ALREADY BEEN SELECTED FOR RELEASE.  NO ACTION TAKEN." H 2 K PRCB("CK") G ASK
 W "  OK" K PRCB("CK") D ONE
 G ASK
UNDO I '$D(^PRCF(421,"AL",PRCF("SIFY"),1)) W !!,$C(7),"No transactions have been selected for releasing for FY: ",PRC("FY") G ASK
 W !!,"To not release a transaction already selected to be released"
 S DIC("A")="Enter the last 5 digits of the transaction for "_$S($D(PRCB("MDIV")):"Station "_PRC("SITE")_",",1:"")_" FY "_PRC("FY")_": "
 S DIC("S")="S ZX=^(0) I $P(ZX,U)[PRCF(""SIFY"")&($P(ZX,U,11)="""")&($P(ZX,U)'[""00000"")&(+$P(ZX,U,20)=1)",DIC=421,DIC(0)="AEQZ",D="D" D IX^DIC K DIC G:Y<0 DEV S DA=+Y
 D UNREL(DA)
 ;if transfer fund
 I $P(^PRCF(421,DA,0),"^",22) D UNREL($P(^(0),"^",22))
 G UNDO
 ;
UNREL(DA) I $D(^PRCF(421,"AL",PRCF("SIFY"),1,DA)),'$D(^PRCF(421,"AL",PRCF("SIFY"),2,DA)) S DIE="^PRCF(421,",DR="11.5////^S X=0" D ^DIE K ^PRCF(421,"AL",PRCF("SIFY"),1,DA)
 QUIT
DEV ;ask device
 G QDEV^PRCBR2
Q1 F I=1:1 Q:$P($T(X+I),";",3,99)=""  W !,$P($T(X+I),";",3,99)
 S DIR(0)="Y",DIR("A")="Do you wish to see the list of all unreleased transactions",DIR("?")="Enter yes to look at list, no or '^' to quit" D ^DIR G:'Y ASK
Q1A W !!,"Unreleased Sequence Numbers for Station ",PRC("SITE"),", FY: ",PRC("FY"),! F I=0,40 W ?I," SEQ #     TRANS #     CP#    TOTAL"
 W ! S N=0 F I=0:1 S N=$O(^PRCF(421,"AL",PRCF("SIFY"),0,N)) Q:'N  D
  . S X1="",X=^PRCF(421,N,0) F J=7:1:10 S X1=X1+$P(X,"^",J)
  . W:'(I#2)*I ! W ?I#2*40,$J(+$P(X,"-",3),4,0),"    ",$P(X,"^"),"  CP-",+$P(X,"^",2),"  $",$J(X1,0,2) K X1,X,J
  . Q
 G ASK
X ;;
 ;;Enter the Sequence Number, or indicate a range of sequence numbers by
 ;;separating the first and last numbers with a dash (-).
 ;;Type "ALL" to release all unreleased transactions.
 ;;
ALL ;TRANSFER ALL TRANSACTIONS INTO ^TMP
 S DA=0 F I=1:1 S DA=$O(^PRCF(421,"AL",PRCF("SIFY"),0,DA)) Q:DA=""  D ONE
 G UNDO
ONE ;mark release status
 QUIT:$$FCPVAL^PRCBR2(DA)
 D REL(DA)
 ;if transfer fund
 I $P(^PRCF(421,DA,0),"^",22) D REL($P(^(0),"^",22))
 QUIT
 ;
REL(DA) I '$D(^PRCF(421,"AL",PRCF("SIFY"),1,DA)),'$D(^PRCF(421,"AL",PRCF("SIFY"),2,DA)) S DIE="^PRCF(421,",DR="11.5////^S X=1" D ^DIE K ^PRCF(421,"AL",PRCF("SIFY"),0,DA)
 QUIT
 ;
DASH ;release all transactions within a range of sequence numbers
 I X'?.N1"-".N W !,"Incorrect format. ",$C(7) G ASK
 S X1=+$P(X,"-",2),X=+$P(X,"-",1) I X'<X1 W !,"Illogical range, the first number is not less than the second.",$C(7),! G ASK
 I X>PRCB("LAST") W !,"First number in range is greater than highest defined sequence number in file, try again.",$C(7),! G ASK
 I X1>PRCB("LAST") S X1=PRCB("LAST") W !,"Second number in range greater than highest defined number, changing to highest number allowed: ",X1,$C(7)
 S PRCB("NUM")=0 S Q=X-1,Q1=X1-1 S Z=Q D ZERO S Q=Z,Z=Q1 D ZERO S Q1=Z,PRCB("LO")=$O(^PRCF(421,"B",PRCF("SIFY")_"-"_Q)) I PRCB("LO")="" W !,"No sequence numbers on file in range, try again.",$C(7),! G ASK
 S PRCB("LO")=$O(^PRCF(421,"B",PRCB("LO"),0)) I PRCB("LO")="" W !,"No sequence numbers in range specified. Please check your numbers and let's try again.",$C(7),! G ASK
D1 S PRCB("HI")=$O(^PRCF(421,"B",PRCF("SIFY")_"-"_Q1))
 S PRCB("HI")=$O(^PRCF(421,"B",PRCB("HI"),0))
 S DA=PRCB("LO")-.5 F I=0:0 S DA=$O(^PRCF(421,"AL",PRCF("SIFY"),0,DA)) Q:DA=""!(DA>PRCB("HI"))  D ONE
 W "   DONE" K PRCB("CK") G ASK
ZERO ;place up to 4 leading zeros onto a number
 S Z="0000"_Z,Z=$E(Z,$L(Z)-4,$L(Z)) Q
 ;
OUT S X="BUDGET RELEASE" D UNLOCK^PRCFALCK
KILL K DIRUT,DTOUT,DIROUT,DUOUT Q
