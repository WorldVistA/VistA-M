PRCBSTF ;WISC@ALTOONA/CLH-TRANSFER FUNDS TO ANOTHER FCP ; 05/01/94  10:40 AM
V ;;5.1;IFCAP;**143**;Oct 20, 2000;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
GETTRAN ;GET TEMP TRANS NUMBER
 S PRCF("X")="ABFS" D ^PRCFSITE Q:'%
 D WAIT^PRCFYN S DIC="^PRCF(421.6,",DLAYGO=421.6,DIC(0)="XOLM",X=PRC("SITE")_"-"_^%ZOSF("VOL")_"-"_($J#1000000000),PRCBT=0
 S:'$D(COUNT) COUNT=0 D ^DIC K DIC Q:+Y<0  I $P(Y,"^",3)="" S COUNT=COUNT+1 Q:COUNT>3  S DIK="^PRCF(421.6,",DA=+Y D ^DIK K DIK G GETTRAN
 S (TDA,DA)=+Y,PRCBT=1,PRCB("AMOUNT")="",PRCB("ANAMT")=""
 S DIE=421.6,DR="[PRCB READER FILE EDIT]"
EDIT D ^DIE I $D(Y) S %A="Do you want to quit and delete this entry",%B="",%=1 D ^PRCFYN G:%=2 EDIT S DIK="^PRCF(421.6," D ^DIK G OUT
 K X,X1 S X=$P(^PRCF(421.6,TDA,0),"^",2,9) F I=1:1:8 I $P(X,"^",I)="" S X1=1
 I $D(X1) W !,"Not all required data has been entered. Re-edit transaction." G EDIT
 S %A="Do you want to review this entry",%B="",%=1 D ^PRCFYN G:%<0 KILL D:%=1 DISP
QPOST ;GET FIRST SEQUENCE NUMBER FROM FILE 421
 S %A="Are you ready to post this transaction",%B="",%=1 D ^PRCFYN G:%'=1 KILL
 D WAIT^PRCFYN
 D POST I $G(PRCQT) G GETTRAN
 S DIK="^PRCF(421.6,",DA=TDA D ^DIK
 S %A="Make another transfer",%B="",%=1 D ^PRCFYN G:%=1 GETTRAN
 G OUT
POST ;post transfer
 S PRCQT=""
SEQNUM1 D SEQNUM^PRCBE I '$D(X) S PRCQT=1 QUIT
 S DIC="^PRCF(421,",DLAYGO=421,DIC(0)="LOX" D ^DIC I $P(Y,"^",3)'=1 G SEQNUM1
 S SEQ1DA=+Y K DIC,DLAYGO
SEQNUM2 ;GET SECOND SEQUENCE NUMBER FROM FILE 421
 D SEQNUM^PRCBE
 S DIC="^PRCF(421,",DLAYGO=421,DIC(0)="LOX" D ^DIC I $P(Y,"^",3)'=1 G SEQNUM2
 S SEQ2DA=+Y K DLAYGO,DIC
 ; Corrected SACC violation on locks for PRC*5*242
 L +^PRCF(421,SEQ1DA):5 I '$T W !,$C(7),"Another user is editing this entry" K SEQ1DA Q 
 L +^PRCF(421,SEQ2DA):5 I '$T W !,$C(7),"Another user is editing this entry" K SEQ2DA L -^PRCF(421,SEQ1DA) Q 
 ;
 S TEMP=^PRCF(421,SEQ1DA,0)
 S $P(TEMP,"^",2)=PRCB("FRCP"),$P(TEMP,"^",6)=PRCB("TDT"),$P(TEMP,"^",PRCB("QTR")+6)="-"_PRCB("AMOUNT"),$P(TEMP,"^",20)=0
 S $P(TEMP,"^",22)=SEQ2DA
 S $P(^PRCF(421,SEQ1DA,4),"^",PRCB("QTR"))=0,$P(^(4),"^",5,6)=-PRCB("ANAMT")_"^"_PRCB("RNR"),^PRCF(421,"AL",PRCF("SIFY"),0,SEQ1DA)="",^PRCF(421,"AC",PRCF("SIFY")_"-"_+PRCB("FRCP"),SEQ1DA)=""
 I $G(TDA) S %X="^PRCF(421.6,TDA,1,",%Y="^PRCF(421,SEQ1DA,1," D %XY^%RCR
 I $D(PRCDES) D
 . N A,X,Y
 . S A="421;^PRCF(421,;"_SEQ1DA_";17~421.01;^PRCF(421,"_SEQ1DA_",1,;"
 . S X=PRCDES D ADD^PRC0B1(.X,.Y,A) K ^PRCF(421,SEQ1DA,1,"B")
 . QUIT
 S ^PRCF(421,SEQ1DA,0)=TEMP D EDIT^PRC0B(.X,"421;^PRCF(421,;"_SEQ1DA,"1.6///"_PRC("BBFY"))
 S TEMP2=^PRCF(421,SEQ2DA,0)
 S $P(TEMP2,"^",2)=PRCB("TOCP"),$P(TEMP2,"^",6)=PRCB("TDT"),$P(TEMP2,"^",PRCB("QTR")+6)=PRCB("AMOUNT"),$P(TEMP2,"^",20)=0
 S $P(TEMP2,"^",22)=SEQ1DA
 S $P(^PRCF(421,SEQ2DA,4),"^",PRCB("QTR"))=0,$P(^(4),"^",5,6)=PRCB("ANAMT")_"^"_PRCB("RNR"),^PRCF(421,"AL",PRCF("SIFY"),0,SEQ2DA)="",^PRCF(421,"AC",PRCF("SIFY")_"-"_+PRCB("TOCP"),SEQ2DA)=""
 I $G(TDA) S %X="^PRCF(421.6,TDA,1,",%Y="^PRCF(421,SEQ2DA,1," D %XY^%RCR
 I $D(PRCDES) D
 . N A,X,Y
 . S A="421;^PRCF(421,;"_SEQ2DA_";17~421.01;^PRCF(421,"_SEQ2DA_",1,;"
 . S X=PRCDES D ADD^PRC0B1(.X,.Y,A) K ^PRCF(421,SEQ2DA,1,"B")
 . QUIT
 S ^PRCF(421,SEQ2DA,0)=TEMP2 D EDIT^PRC0B(.X,"421;^PRCF(421,;"_SEQ2DA,"1.6///"_PRC("BBFY"))
 L -^PRCF(421,SEQ1DA),-^PRCF(421,SEQ2DA)
 W !!,"Finished.  The following transactions have been created",!,"in file 421 (Fund Distribution):"
 W !,"                            ",$P(^PRCF(421,SEQ1DA,0),"^")
 W !,"                            ",$P(^PRCF(421,SEQ2DA,0),"^")
 W !!
 QUIT
 ;
OUT K %F,COUNT,D0,DA,DIC,DIE,DIK,DR,PRCB("AMOUNT"),PRCB("FRCP"),PRCB("QTR"),PRCB("TOCP"),PRCB("TRANS"),SEQ1DA,SEQ2DA,TDA,TEMP,TEMP2,ZX
 K PRCBT,PRCB("TDT"),PRCB("ANAMT"),PRCB("LAST"),PRCB("MDIV"),PRCB("RNR")
 Q
KILL S %A="Then I will delete this entry",%A(1)="Are you sure you want this deleted",%B="",%=1 D ^PRCFYN G:%'=1 QPOST
 S DIK="^PRCF(421.6,",DA=TDA D ^DIK S X="  <Entry Deleted>*" D MSG^PRCFQ G OUT
DISP S IOP=ION,DIC="^PRCF(421.6,",(TO,FR)=PRC("SITE")_"-"_^%ZOSF("VOL")_"-"_($J#1000000000),L=0,BY=".01",FLDS="[PRCB READER DISP]" D EN1^DIP
 S %A="Do you want to edit this entry",%B="",%=2 D ^PRCFYN Q:%'=1
 S DIE="^PRCF(421.6,",DR="[PRCB READER FILE EDIT]",DA=TDA D ^DIE K DIE
 Q
