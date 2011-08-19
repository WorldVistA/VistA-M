PRCBVE ;WISC@ALTOONA/CLH-ADD/EDIT CALM VENDOR FILE ;9-21-89/09:27
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;MUST PASS VARIABLE PRCB("VEN") WHICH IS INTERNAL VENDOR NUMBER
 ;PRC VARIABLES MUST BE SET IE. PRC("SITE")
GN ;GET TEMP NUM
 D WAIT^PRCFYN S DIC="^PRCF(421.6,",DLAYGO=421.6,DIC(0)="XOLM",X=PRC("SITE")_"-"_^%ZOSF("VOL")_"-"_$J,PRCBT=0
 S:'$D(COUNT) COUNT=0 D ^DIC Q:+Y<0  I +$P(Y,U,3)'=1 S COUNT=COUNT+1 Q:COUNT=3  S DIK=DIC,DA=+Y D ^DIK K DIK G GN
 S PRCB("TDA")=+Y,PRCBT=1
 Q
EN ;ADD VENDOR
 I $D(^PRC(440,PRCB("VEN"),7)) S PRCBE=1,%A="Do you want to review the current information on this vendor",%B="",%=2 D ^PRCFYN D:%'=2 REVO
 D GN S DIE=DIC,DA=PRCB("TDA"),DR="[PRCB VENDOR EDIT]"
ENV D ^DIE D REVN S %A="Is this data correct",%B="",%=1 D ^PRCFYN I %'=1 S %A="Re-edit data",%B="",%=1 D ^PRCFYN G:%=1 ENV
 I '$D(^PRC(440,PRCB("VEN"),7)) S %A(1)="This vendor does not appear to have been established in CALM Vendor File",%A(2)="Do you want to establish them at this time",%B="",%=1 D ^PRCFYN G:%=1 ADVEN G SET
 I $P(^PRC(440,PRCB("VEN"),7),U,10)="" S %A(1)="This vendor does not appear to have a CALM ID Number",%A(2)="Do you want to establish them to the CALM Vendor File",%B="",%=1 D ^PRCFYN G:%=1 ADVEN G SET
 I $D(PRCBE) S %A="Do you want to update the CALM vendor file at this time",%B="",%=1 D ^PRCFYN G:%'=1 SET
 ;THIS AREA FOR UPDATING EXSITING VENDOR INFO IN CALM
ADVEN ;AREA TO SET UP MSG FOR AUSTIN TO ESTABLISH NEW VENDOR
 W !!,"Twix will be sent to establish vendor: ",$P(^PRC(440,PRCB("VEN"),0),U)," in the CALM Vendor File."
SET ;MOVE TEMP INFO FROM 421.6 TO 440
 W !!,"I'm going to update the your Vendor File..."
 I '$D(^PRCF(421.6,PRCB("TDA"),3)) G OUT
 I '$D(^PRC(440,PRCB("VEN"),7)) S OR="",$P(OR,U,1,11)=""
 E  S OR=$P(^PRC(440,PRCB("VEN"),7),U,1,99)
 S NR=$P(^PRCF(421.6,PRCB("TDA"),3),U,1,99)
 ;I $P(NR,U,3)
 S ^PRC(440,PRCB("VEN"),7)=$P(NR,U,12)_U_$P(NR,U,11)_U_$P(NR,U,3,9)
 W !!,"Finished.  Hold on while I do some clean up...."
OUT I $D(PRCB("TDA")) S DIK="^PRCF(421.6,",DA=PRCB("TDA") D ^DIK
 K DIK,DIC,DIE,PRCB("TDA"),DA,X,COUNT,PRCBT,DLAYGO,%,REC,REC1,TEMP,TEMP1
 Q
REVO ;REVIEW OLD VENDOR INFO
 I '$D(^PRC(440,PRCB("VEN"),0)) W !!,$C(7),"**  No Vendor Information available  **" Q
 S REC=^PRC(440,PRCB("VEN"),0) I '$D(^PRC(440,PRCB("VEN"),7)) S REC1="",$P(REC1,U,1,11)=""
 E  S REC1=^PRC(440,PRCB("VEN"),7)
 I $D(IOF) W @IOF
 W !!?5,"Vendor Name: ",$P(REC,U,1),?48,"Vendor Number: ",PRCB("VEN")
 W !!!?5,"Payment Information: "
 W !!?19,"Calm ID Number: " I $P(REC1,U,10)'="" W $P(REC1,U,10)
 W !?19,"Stub Name: " I $P(REC1,U,11)'="" W ?35,$P(REC1,U,11)
 W !?19,"Address: " I $P(REC1,U,3)'="" W ?35,$P(REC1,U,3)
 I $P(REC1,U,4)'="" W !?35,$P(REC1,U,4)
 I $P(REC1,U,5)'="" W !?35,$P(REC1,U,5)
 I $P(REC1,U,6)'="" W !?35,$P(REC1,U,6)
 I $P(REC1,U,7)'="" W !?35,$P(REC1,U,7)_", ",$P(^DIC(5,$P(REC1,U,8),0),U)_"  ",$P(REC1,U,9)
 W !!?19,"Phone Number: " I $P(REC1,U,2)'="" W ?35,$P(REC1,U,2)
 Q
REVN ;REVIEW NEW VENDOR INFO
 I '$D(^PRCF(421.6,PRCB("TDA"),3)) W !,$C(7)," - No Data Entered - " Q
 E  S TEMP1=^PRCF(421.6,PRCB("TDA"),3)
 I $D(IOF) W @IOF
 W !!?5,"Vendor Name: ",$P(^PRC(440,PRCB("VEN"),0),U)
 W !!!?5,"Payment Information: "
 W !!?19,"Calm ID Number: " I $P(TEMP1,U,1)'="" W $P(TEMP1,U,1)
 W !?19,"Calm Stub Name: " I $P(TEMP1,U,10)'="" W ?35,$P(TEMP1,U,10)
 W !?19,"Address: " I $P(TEMP1,U,3)'="" W ?35,$P(TEMP1,U,3)
 I $P(TEMP1,U,4)'="" W !?35,$P(TEMP1,U,4)
 I $P(TEMP1,U,5)'="" W !?35,$P(TEMP1,U,5)
 I $P(TEMP1,U,6)'="" W !?35,$P(TEMP1,U,6)
 I $P(TEMP1,U,7)'="" W !?35,$P(TEMP1,U,7)_", ",$P(TEMP1,U,8)_"  ",$P(TEMP1,U,9)
 Q
