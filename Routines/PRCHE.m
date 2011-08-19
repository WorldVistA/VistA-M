PRCHE ;WOIFO/LKG/DST-EDIT ROUTINES FOR SUPPLY SYSTEM ; 6/22/05 8:40am
V ;;5.1;IFCAP;**1,28,39,81,63**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN1 ;ITEM FILE EDIT
 N PRCVDA
 I '$D(PRC("PARAM")) S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("PARAM"))
 W !! D DISP^PRCOSS1
 S DIC="^PRC(441,",DIC(0)="AEMQL",DLAYGO=441,PRCHPO="",PRCHDA=-1 D ^DIC
 I Y>0 D
 . S PRCHDA=+Y,DIE=DIC,DA=+Y
 . S DR=$S($P($G(^PRC(441,DA,0)),U,15)="":"[PRCHITEM2]",$D(^XUSEC("PRCHITEM MASTER",DUZ)):"[PRCHITEM2]",1:"[PRCHITEM]")
 . I DR="[PRCHITEM]" D
 . . N PRCARR S PRCARR(1)="This item is a National Item File entry and you have"
 . . S PRCARR(2)="not been granted permission to edit the SHORT DESCRIPTION"
 . . S PRCARR(3)="and DESCRIPTION fields.  You will not be able to edit these fields."
 . . D EN^DDIOL(.PRCARR)
 . D LCK D:$D(DA) ^DIE
 . ; Send ITEM master file updates info to DynaMed - **81**
 . S PRCVDA=$G(DA)
 S Y=PRCHDA K PRCHDA D Q K PRCHPO
 I Y<0 D CHECK^PRCOSS1 Q
 S (PRCHDA,DA,DA(1))=+Y I $O(^PRC(441,DA,4,0)) S DIC="^PRC(441,"_DA(1)_",4,",DIC(0)="QEMAN" D ^DIC S:$G(Y)'=-1 PRCVDA=PRCHDA I Y>0 S DA=+Y,DIE=DIC,DR=3 D ^DIE,Q
 ; S:$G(Y)'=-1 PRCVDA=PRCHDA
 ; If either ITEM record (and FCP fields) created or updated, and
 ; this site is a DynaMed Interface site
 I $G(PRCVDA),$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 D ONECHK^PRCVIT(PRCVDA)
 I $P(^PRC(441,PRCHDA,0),U,10)="",$P(PRC("PARAM"),U,16)="Y" W $C(7),!!,"Warning--BOC is missing from this item--you should",!,"re-edit the item!!",!
 I $O(^PRCP(445,"AH",PRCHDA,""))]"" D BLDSEG^PRCPHLFM(3,PRCHDA,0) ; update supply stations
 K PRCHDA G EN1
 ;
EN2 ;EDIT SITE PARAMETERS
 N X R !,"STATION NUMBER: ",X:DTIME Q:'$T!(X["^")!(X="")
 I "???"[X D EN2DSP G EN2
 I X'?3N W !,"Please enter a 3 digit number or '^' to exit.  If attempting to enter substation information, please use 'Substation Enter/Edit'." G EN2
 I $D(^PRC(411,"B",X)) G EN2A
 N PRCX
 S PRCX=$O(^DIC(4,"D",X,"")) I PRCX="" W " ?? (That is not a valid Station Number)" G EN2
 S PRCX=$P($G(^DIC(4,PRCX,0)),U,1)
 D EN^DDIOL("Do you wish to add "_X_" ("_PRCX_") as a NEW station")
 S %=0 D YN^DICN I %'=1 G EN2
 ;
EN2A S DIC="^PRC(411,",DIC(0)="LX",DR="[PRCHSITE]",DLAYGO=411 D DIE
 G EN2
EN2DSP ;Display entries from file #411 if they are Ok in file #4. Otherwise,
 ;alert user about any incomplete entry.
 N PRCDA,PRCA,J,PRCIEN,PRCINSN
 S PRCDA=0 F J=2:0 S PRCDA=$O(^PRC(411,"B",PRCDA)) Q:PRCDA=""  D
 . S PRCIEN=$O(^PRC(411,"B",PRCDA,"")) I $D(^PRC(411,PRCIEN,0))#10 D 
 .. S PRCA=$P($G(^PRC(411,PRCIEN,0)),U,1) I PRCA?3N D
 ... S PRCA(J)=$J("",5)_PRCA_"  "
 ... S PRCINSN=$O(^DIC(4,"D",PRCDA,"")) I PRCINSN']"" D  Q
 .... W !,$C(7),?5,"ENTRY "_PRCDA_" IS NOT SET UP PROPERLY IN FILE #4. PLEASE CALL IRM"
 ... S PRCA(J)=PRCA(J)_$P($G(^DIC(4,PRCINSN,0)),U,1),J=J+1
 I J>2 S PRCA(1)=" ",PRCA(J)=" " D EN^DDIOL(.PRCA)
 Q
EN3 ;EDIT VENDOR FILE
 S DIC="^PRC(440,",DIC(0)="AEMQL",DR="[PRCHVENDOR1]",DLAYGO=440 K PRCHPO D DIE Q:Y<0  G EN3
 ;
EN5 ;ENTER A NEW P.O.
 D ST Q:'$D(PRC("SITE"))
EN50 D ENPO^PRCHUTL Q:'$D(PRCHPO)  D LCK1 G:'$D(DA) EN50 D ^PRCHNPO L  G EN50
 ;
EN6 ;EDIT AN INCOMPLETE P.O.
 ;Edit an Incomplete Purchase Order created by 'New Purchase Order' option only
 D ST Q:'$D(PRC("SITE"))
EN60 N FLG1 S FLG1=1 D PO Q:'$D(PRCHPO)
 D LCK1 G:'$D(DA) EN60 D ^PRCHNPO L  G EN60
 ;
EN8 ;DELETE A RECEIVING REPORT
 N FLG1 S FLG1=0 D ST Q:'$D(PRC("SITE"))  G EN80^PRCHEF
 ;
EN9 ;EDIT COMMON NUMBERING SERIES
 W ! S DIC="^PRC(442.6,",DIC(0)="AEMQL",DR=".01:99",DLAYGO=442.6 D DIE Q:Y<0  I $D(^PRC(442.6,+Y)),$P(^(+Y,0),U,5)="" W !!,$C(7),"NOTE: Since you have left the USING SECTION field empty, these",!,"numbers can only be used by P&C.",!
 G EN9
 ;
EN10 ;EDIT SUPPLY EMPLOYEE INFORMATION
 K DIC,DA,X,Y S DIC="^VA(200,",DIC(0)="AEMQ" D ^DIC
 G:Y<0 EN10Q
 S DA=+Y L +^VA(200,DA):0 E  W $C(7),!,"ANOTHER USER IS EDITING THIS ENTRY!" G EN10
 K DR,DIE S DR="400;.135;.136;.151",DIE=DIC D ^DIE K DIE,DR
 L -^VA(200,DA)
 W !?5,"To edit the Signature Block Printed Name or title, Use TBOX",!
 G:'$D(DTOUT) EN10
EN10Q K DIC,DIE,X,Y,DA,DR,DTOUT,DUOUT
 Q
 ;
EN11 ;EDIT ADMINISTRATIVE CERTIFICATIONS
 S DIC="^PRC(442.7,",DIC(0)="AEMLQ",DR=".01:99",DLAYGO=442.7 D DIE Q:Y<0  G EN11
 ;
EN12 ;EDIT DELIVERY DATE
 N PRCHP D ST Q:'$D(PRC("SITE"))
 ;S PRCHP("S")="$P($G(^(7)),U,2)>19,$P($G(^(7)),U,2)<30,($P($G(^(0)),U,2)=25!($S($D(PRCHNRQ):$P($G(^(0)),U,2)=8,1:$P($G(^(0)),U,2)<8)))"
EN120 D PORQ I '$D(PRCHPO) G Q
 ;I X<20!(X>29) W " ??",$C(7) G EN120
 I "^20^21^22^23^24^25^26^27^28^29^32^34^39^44^46^47^"'[(U_X_U) W " ??",$C(7) G EN120
 D LCK1 G:'$D(DA) EN120
 S D0=DA,%=2,%B="",%A="REVIEW ORDER " D ^PRCFYN D:%=1 ^PRCHDP1
 W ! S PRCHDT=$P(^PRC(442,PRCHPO,0),U,10) S DA=PRCHPO,DIE="^PRC(442,",DR="[PRCHDEL]" D ^DIE S X=$P(^PRC(442,PRCHPO,0),U,10) I X,X'=PRCHDT,$P(^(0),U,20)="" S $P(^(0),U,20)=PRCHDT
 ; trigger bulletin for changed delivery date
 S PRCHDTT=$P(^PRC(442,PRCHPO,0),U,10) I PRCHDTT'=PRCHDT D ^PRCFACS2
 K PRCHDT D Q G EN120
 ;
EN13 ; Delete 2237 option has been de-activated.
 ; See documentation for PRC*5*128.
 Q
EN14 ;CREATE ADJUSTMENT VOUCHER
 D ST Q:'$D(PRC("SITE"))
EN140 D PORQ Q:'$D(PRCHPO)
 I X=28!(X=33) W $C(7),!,"Adjustment Vouchers not allowed until after order has been Obligated!!" G EN140
 I '$O(^PRC(442,PRCHPO,11,0)) W !?3,"Order has no Receiving Reports !",$C(7) G EN140
 D ^PRCHAM4 G EN140
 ;
EN15 ;ENTER LOG DEPARTMENTS TO FCP FILE (420)
 D ST Q:'$D(PRC("SITE"))
EN150 S DIC="^PRC(420,"_PRC("SITE")_",1,",DIC(0)="AEMNQ"
 S DIC("A")="Select CONTROL POINT: ",D="B^C" D MIX^DIC1 G:Y<0 Q
 S DIE=DIC,DA(1)=PRC("SITE"),DA=+Y,DR=19 D ^DIE
 D:$P(^PRC(420,DA(1),1,DA,0),U,18)?1"11".E
 .  W !,">>> You have just assigned a LOG DEPARTMENT that should only be used for        Subsistence FCPs.  If that is NOT true, please reassign it or you will be       asked for a Food Group on every item purchased."
 G EN150
 ;
DIE S PRCHDA=-1 D ^DIC
 I Y>0 S PRCHDA=+Y,DIE=DIC,DA=+Y D LCK I $D(DA) D ^DIE
 S Y=PRCHDA K PRCHDA G Q
 ;
QQ S:'$D(ROUTINE) ROUTINE=$T(+0) W !!,$$ERR^PRCHQQ(ROUTINE,PRCSIG) W:PRCSIG=0!(PRCSIG=-3) !,"Notify Application Coordinator!",$C(7) S DIR(0)="EAO",DIR("A")="Press <return> to continue" D ^DIR
 ;
Q K DA,DIC,DIE,DIK,DR,DLAYGO,D0,E,I,J,L,PRCHEX,PRCHPUSH,%,ROUTINE,CHECK L
 Q
 ;
LCK1 S DIC="^PRC(442,"
 ;
LCK L @(DIC_DA_"):0") E  W !,$C(7),"ANOTHER USER IS EDITING THIS ENTRY!" K DA
 Q
 ;
ST S PRCF("X")="S" D ^PRCFSITE
 Q
 ;
PO S PRCHP("A")="P.O./REQ.NO.: "
 S PRCHP("S")=$S(FLG1:"$P($G(^(7)),U,2)<10,($P(^(0),U,2)<10!($P(^(0),U,2)=25&($P($G(^(23)),U,11)=""""))!($P(^(0),U,2)=26))",1:"$P(^(0),U,2)<10!($P(^(0),U,2)=25)!($P(^(0),U,2)=26)")
 S:$G(PRCHPC)=1 PRCHP("S")="$P($G(^(7)),U,2)<9,$P($G(^(1)),U,10)=DUZ,$P($G(^(0)),U,2)=25,$P($G(^(23)),U,11)=""S"""
 S:$G(PRCHPC)=2 PRCHP("S")="$P($G(^(7)),U,2)<9,$P($G(^(1)),U,10)=DUZ,$P($G(^(0)),U,2)=25,$P($G(^(23)),U,11)=""P"""
 S:$G(PRCHDELV) PRCHP("S")="$P($G(^(7)),U,2)<9,$P($G(^(23)),U,11)=""D"",$P(^(0),U,2)'=26"
 S:$G(PRCHPC)=3 PRCHP("S")="$P($G(^(7)),U,2)<9,$P($G(^(1)),U,10)=DUZ,$P($G(^(0)),U,2)=25,$P($G(^(23)),U,11)=""P"""
 S:$G(PRCHPHAM) PRCHP("S")="$P($G(^(7)),U,2)<9,$P($G(^(23)),U,11)=""D"",$P(^(0),U,2)=26"
 D EN3^PRCHPAT
 Q
 ;
PORQ S:$D(PRCHNRQ) PRCHP("A")="REQUISITION NO.: "
 I $G(PRCHAUTH)=1 S PRCHP("S")="$P($G(^(23)),U,11)=""P"""
 I $G(PRCHAUTH)=2 S PRCHP("S")="$P($G(^(23)),U,11)=""D"""
 D EN3^PRCHPAT
 Q
