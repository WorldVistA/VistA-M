PRCBR0 ;WISC@ALTOONA/CTB-CONTINUATION OF ^PRCFBR ; 10 Sep 89  3:08 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
Q1 W $C(7),! F I=1:1 Q:$P($T(X+I),";",3,99)=""  W !,$P($T(X+I),";",3,99)
 W ! S %A="Do you wish to see the list of all unreleased transactions",%B="",%=2 D ^PRCFYN G:%'=1 ASK^PRCBR
Q1A W !!,"Unreleased Sequence Numbers for Station ",PRC("SITE"),", FY: ",PRC("FY"),! F I=0,40 W ?I," SEQ #     TRANS #     CP#    TOTAL"
 W ! S N=0 F I=0:1 S N=$O(^PRCF(421,"AL",PRCF("SIFY"),0,N)) Q:'N  D:$D(^PRCF(421,N,0))#2 Q1A1
 G ASK^PRCBR
Q1A1 S X1="",X=^PRCF(421,N,0) F J=7:1:10 S X1=X1+$P(X,"^",J)
 W:'(I#2)*I ! W ?I#2*40,$J(+$P(X,"-",3),4,0),"    ",$P(X,"^"),"  CP-",+$P(X,"^",2),"  $",$J(X1,0,2) K X1,X,J
 Q
X ;;
 ;;Enter the Sequence Number, or indicate a range of sequence numbers by
 ;;separating the first and last numbers with a dash (-).
 ;;Type "ALL" to release all unreleased transactions.
 ;;
ALL ;TRANSFER ALL TRANSACTIONS INTO ^TMP
 S DA=0 F I=1:1 S DA=$O(^PRCF(421,"AL",PRCF("SIFY"),0,DA)) Q:DA=""  D ONE
 D QUE Q
ONE ;MARK ONE TRANSACTION AS RELEASED
 S ^PRCF(421,"AL",PRCF("SIFY"),1,DA)="",$P(^PRCF(421,DA,0),"^",20)=1 K ^PRCF(421,"AL",PRCF("SIFY"),0,DA)
 Q
DASH ;RELEASE ALL TRANSACTIONS WITHIN A RANGE OF SEQUENCE NUMBERS
 I X'?.N1"-".N W !,"Incorrect format. ",$C(7) G ASK^PRCBR
 S X1=+$P(X,"-",2),X=+$P(X,"-",1) I X1>PRCB("LAST") S X1=PRCB("LAST") I X'<X1 W !,"ILLOGICAL RANGE, THE FIRST NUMBER IS NOT LESS THAN THE SECOND.",$C(7) G ASK^PRCBR
 S PRCB("NUM")=0 S Q=X-1,Q1=X1-1 S Z=Q D ZERO S Q=Z,Z=Q1 D ZERO S Q1=Z,PRCB("LO")=$O(^PRCF(421,"B",PRCF("SIFY")_"-"_Q)) I PRCB("LO")="" W !,"Sorry, I'm a little confused.  Lets try it again.",! G ASK^PRCBR
 S PRCB("LO")=$O(^PRCF(421,"B",PRCB("LO"),0)) I PRCB("LO")="" W !,"Please check your numbers and lets try again.",! G ASK^PRCBR
D1 S PRCB("HI")=$O(^PRCF(421,"B",PRCF("SIFY")_"-"_Q1)) ;I PRCB("HI")="" S Z=Q1-1 D ZERO S Q1=Z G D1
 S PRCB("HI")=$O(^PRCF(421,"B",PRCB("HI"),0))
 S DA=PRCB("LO")-.5 F I=0:0 S DA=$O(^PRCF(421,"AL",PRCF("SIFY"),0,DA)) Q:DA=""!(DA>PRCB("HI"))  D ONE
 W "   DONE" K PRCB("CK") G ASK^PRCBR
ZERO ; PLACE UP TO 3 LEADING ZEROS ONTO A NUMBER
 S Z="000"_Z,Z=$E(Z,$L(Z)-3,$L(Z)) Q
 ;
QUE ;QUEUE PRCBR1 TO RUN RELEASE AS TASKMAN JOB
 I '$D(^PRCF(421,"AL",PRCF("SIFY"),1)) W !,"No transactions have been scheduled for release at this time.",!! G OUT
 S %A="Do you wish to generate the printout with this option",%B="",%=2 D ^PRCFYN I %=2 S PRCFA("NOPRINT")="",ZTIO=""
 D NOW^PRCFQ S PRCFTIME=% S ZTRTN="^PRCBR1",ZTSAVE("PRCFTIME")="",ZTSAVE("PRCF*")="",ZTDESC="RELEASE BUDGET TRANSACTIONS" D ^PRCFQ
 I $D(NODEV) S %X="You must select a device or time, you are past the point of no return.*" D MSG^PRCFQ G QUE
 K PRCFTIME G OUT
 Q
OUT S X="BUDGET RELEASE" D UNLOCK^PRCFALCK
KILL K %,%X,D,FAIL,J,K,PRCF,Y Q
