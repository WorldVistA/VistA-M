PRCBMT ;WISC@ALTOONA/CLH-MULTIPLE TRANSACTIONS ;9-6-90/10:27
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S PRCF("X")="ABFS" D ^PRCFSITE I '% D OUT Q
EN S (COUNT,PRCB("TN"))=0 I '$D(^PRCF(421.1,0)) W $C(7),!!,"YOU HAVE AN UNDEFINED FILE.  CALL SITE MANAGER.",!! Q
 S LOCKFLG=0
GETNUM ;GET TEMP TRANS NUMBER
 L +^PRCF(421.1,0):5
 E  D EN^DDIOL("File in use. Please try later.") QUIT
 S TNUM=$P(^PRCF(421.1,0),"^",3)+1,PRCB("TN")="0000"_TNUM K TNUM
 L -^PRCF(421.1,0)
 S DIC="^PRCF(421.1,",DLAYGO=421.1,DIC(0)="LMN",X="T-"_$E(PRCB("TN"),$L(PRCB("TN"))-4,$L(PRCB("TN"))) D ^DIC K DIC S COUNT=COUNT+1 Q:COUNT>5  G:$P(Y,"^",3)'=1 GETNUM
 S PRCB("TN")=$P(Y,"^",2),DA=+Y,PRCB("TDA")=+Y
 W $C(7),!!,"This has been assigned TRANSACTION NUMBER: ",PRCB("TN"),".",!,"Please note and use for editing of this transaction.",!
 S PRCB("ASK")="" D DIE
 S %A="Enter another transaction",%B="",%=2 D ^PRCFYN I %=1 S (COUNT,PRCB("TN"))=0 G EN
 D OUT Q
DIE ;I $D(PRCB("ASK")) D DEL Q
 S PRCB("NOFLG")=""
 D EDIT^PRCBMT1 I $D(PRCB("^")) K PRCB("^") D DEL Q
 D VERI I $D(PRCB("ERR",1)) K PRCB("ER") W !,$C(7),"This transaction contains no entries. No further action can be taken." G DIE
 I $D(PRCB("ERR")) K PRCB("ERR") S PRCB("ASK")="" D REVIEW^PRCBMT1 W !,$C(7),"This transaction contains at least one entry with no funding information.",!,"Either correct or delete this entry."
 I PRCB("NOFLG")=1 K PRCB("ASK") Q
 D PST^PRCBMT1 I $D(PRCB("^")) K PRCB("^") D DEL Q
 Q
DEL G:LOCKFLG=1 OUT
 I '$D(PRCB("AUTOKILL")) K PRCB("AUTOKILL") S %A="Are you sure you want to DELETE temporary transaction number "_PRCB("TN"),%=2,%B="" D ^PRCFYN S:%<0 PRCB("^")="" I %'=1 S X="  <No Action Taken>" D MSG^PRCFQ Q
 K PRCB("AUTOKILL") S DIK="^PRCF(421.1,",DA=PRCB("TDA") D ^DIK S X=" <Temporary Transaction Number "_PRCB("TN")_" has been Deleted.>*" D MSG^PRCFQ W !
OUT K DIC,DIE,DIK,DA,DUOUT,POP,X,TNUM,PRCB,PRCF("SIFY"),CNT,COUNT,TOREC,DR,REC,CHK,NXT,PRCBE,PRCBNUM,DATA,DLAYGO,FREC,LOCKFLG
 Q
INPT ;INPUT TRANSFORM
 N DIX,DIC,D0,DO
 S DIC("S")="I $D(^PRC(420,+PRC(""SITE""),1,+Y))",DIC="^PRC(420,"_PRC("SITE")_",1,",DIC(0)="EMNQZ" D ^DIC S X=$P(Y,"^",2) I +Y<0 K X Q
 Q
VERI ;VERIFY DATA
 K PRCB("ERR") I $S('$D(^PRCF(421.1,DA,1,0)):1,$P(^(0),"^",3)<1:1,1:0) S PRCB("ERR",1)="" QUIT
 S DA(1)=0 F I=1:1 S DA(1)=$O(^PRCF(421.1,DA,1,DA(1))) Q:'DA(1)  D VER1 Q:$D(PRCB("ERR"))
 Q
VER1 S PRCB("ERR",2,DA(1))="",REC=^PRCF(421.1,DA,1,DA(1),0),DATA=0 F J=2:1:6 I +$P(REC,"^",J)'=0 K PRCB("ERR",2,DA(1)) Q
 I $P($G(^PRCF(421.1,DA,1,DA(1),4)),"^",6)="" S PRCB("ERR",2,DA(1))=""
 Q
POST S PRCF("X")="ABS",LOCKFLG=0,PRCB("NOFLG")="" D ^PRCFSITE Q:'%
 S DIC="^PRCF(421.1,",DIC("A")="Select TEMPORARY TRANSACTION NUMBER: ",DIC(0)="AEQMN" D ^DIC G:+Y<0 OUT S PRCB("TDA")=+Y,DA=+Y,PRCB("TN")=$P(Y,"^",2) K DIC
 D DIE S DIC("A")="Select Next TEMPORARY TRANSACTION NUMBER: " G POST
