PRCFAC3 ;WISC/CTB/CLH/SJG/AS-ACCOUNTING MODULE ; 3/8/05
V ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
E10 ; Enter FMS Vendor Code Numbers into Vendor File
 N TAG,PRCF
 D HILO^PRCFQ
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 D SCREEN
 S PRCFA("FISCVEND")=$P($G(PRC("PARAM")),U,20)
 S TAG=$S(PRCFA("FISCVEND"):"E10B",'PRCFA("FISCVEND"):"E10A") D @TAG
OUT10 K %W,%X,%Y,D0,DA,DIC,DIE,DQ,DR,I,J,K,X,Y,DIRUT
 K PRCTMP,IOINHI,IOINLOW,IOINORM,PRCFA
 QUIT
E10A ; No adding by Fiscal/editing only
 I 'PRCFA("FISCVEND") W !!,"Only Supply may add new Vendors to the Vendor File",!,"but Fiscal may edit payment information.",!!
E10A1 W ! S DIC(0)="AENMQ",DIC=440 D ^DIC Q:Y<0
 I Y>0 S (DA,PRCFA("VEND"))=+Y D INFO K PRCTMP D EDIT^PRCFAC31
 Q:$D(DIRUT)
 I 'Y W !!,"No further action is being taken on this Vendor.",! G E10A1
 D SCREEN
 L +^PRC(440,DA):5 E  W !,$C(7),"Another user is editing this entry!" G E10A1
 K ^PRC(440.3,DA) S %X="^PRC(440,DA,",%Y="^PRC(440.3,DA," D %XY^%RCR
 D WARN
 S DIE=DIC,DR=$S($D(^XUSEC("PRCFA VENDOR EDIT",DUZ)):"[PRCF FMS VENEDIT1B]",1:"[PRCF FMS VENEDIT1]")
 D ^DIE K DIE,DR,ORDER W ! D VEDIT^PRCHE1A(PRCFA("VEND"),PRC("SITE"))
 L -^PRC(440,PRCFA("VEND"))
 ;   SEND VENDOR UPDATE INFORMATION TO DYNAMED   **81**
 D:$$GET^XPAR("SYS","PRCV COTS INVENTORY",1)=1 ONECHK^PRCVNDR(PRCFA("VEND"))
 G E10A1
 QUIT
E10B ; Adding/editing by Fiscal
 I PRCFA("FISCVEND") W !!,"Fiscal may add new Vendors to the Vendor File.",!!
E10B1 W ! S DIC(0)="AENMQL",DLAYGO=440,DIC=440 D ^DIC K DLAYGO Q:Y<0
 I Y>0 S (DA,PRCFA("VEND"))=+Y D INFO K PRCTMP D EDIT^PRCFAC31
 Q:$D(DIRUT)
 I 'Y W !!,"No further action is being taken on this Vendor.",! G E10B1
 D SCREEN
 L +^PRC(440,DA):5 E  W !,$C(7),"Another user is editing this entry!" G E10B1
 K ^PRC(440.3,DA) S %X="^PRC(440,DA,",%Y="^PRC(440.3,DA," D %XY^%RCR
 D WARN
 S DIE=DIC,DR=$S($D(^XUSEC("PRCFA VENDOR EDIT",DUZ)):"[PRCF FMS VENEDIT2B]",1:"[PRCF FMS VENEDIT2]")
 D ^DIE K DIE,DR,ORDER W ! D VEDIT^PRCHE1A(PRCFA("VEND"),PRC("SITE"))
 L -^PRC(440,PRCFA("VEND"))
 ;   SEND VENDOR UPDATE INFORMATION TO DYNAMED   **81**
 D:$$GET^XPAR("SYS","PRCV COTS INVENTORY",1)=1 ONECHK^PRCVNDR(PRCFA("VEND"))
 G E10B1
 QUIT
 ;
E11 ;LOOK VENDOR NUMBER
 D HILO^PRCFQ
 W !,"Select Vendor Name or PO Number: " R X:$S($D(DTIME):DTIME,1:30) G:X="" OUT11
 S X1=X,DIC=440,DIC(0)="EMN" D ^DIC G:X="^" OUT11 I +Y>0 S (PRCFA("VEND"),DA)=+Y D INFO G E11
 S X=X1,DIC=442,DIC(0)="EMN" D ^DIC G:X="?" E11 G:Y<0 E11 S (PRCFA("VEND"),DA)=$P($G(^PRC(442,+Y,1)),U,1) I DA="" W !!?25,$C(7),"No Vendor for this obligation number.",! G E11
 W !,$P(^PRC(440,PRCFA("VEND"),0),"^") D INFO G E11
OUT11 K %,%W,%Y,DA,DIC,I,X,X1,Y
 K PRCTMP,PRCFA,IOINHI,IOINLO,IONORM
 QUIT
 ;
E12 ;;INQUIRE TO CODE SHEET ERROR MESSAGE
 S DIC=421.3,DIC(0)="AEMNQ" D ^DIC I Y>0 S DA=+Y,DR=1 D EN^DIQ G E12
 K %,%Y,A,D0,D1,DA,DIC,DIW,DIWF,DIWL,DIWR,DIWT,DL,DN,DR,DX,I,J,K,S,X,Y Q
E13 ;ADD/EDIT CODE SHEET ERROR MESSAGE
 S DIC="^PRCF(421.3,",DIC(0)="AEMNLQ",DLAYGO=421.3 D ^DIC K DLAYGO I Y>0 S DIE=DIC,DA=+Y,DR=1 D ^DIE W ! G E13
 K %,%DT,D0,DA,DIC,DIE,DQ,DR,DWLW,I,J,X,X1,Y Q
E14 ;INQUIRE TO TRANSMISSION RECORD
 S:'$D(PRCFASYS) PRCFASYS="FEEFENIRSCLI"
 S PRCFASYS=PRCFASYS_"RR"
 S DIC=421.2,DIC(0)="AMENQ",DIC("S")="I PRCFASYS[$P(^(0),""-"",2)" D ^DIC I Y>0 S DA=+Y,DR="0;1" D EN^DIQ G E14
 K %,A,D0,DA,DIC,DL,DR,DRX,DX,S,X,Y Q
INFO ; Get/Print Vendor Payment Information
 I '$D(^PRC(440,PRCFA("VEND"),7)) W !!,$C(7),"No payment information in Vendor File.",!! Q
 S DIR(0)="Y",DIR("A")="Review current payment information on this Vendor",DIR("B")="YES" W ! D ^DIR K DIR
 I 'Y!($D(DIRUT)) Q
 D GET^PRCFAC31(PRCFA("VEND")),DISPLAY^PRCFAC31(PRCFA("VEND"))
 Q
SCREEN ; Control screen display
 I $D(IOF) W @IOF
HDR ; Write Option Header
 I $D(XQY0) W IOINHI,$P(XQY0,U,2),IOINORM,!
 Q
WARN ;WARNING IF PENDING VRQ
 I $P($G(^PRC(440,DA,3)),U,12)="P" W !!,"There is a FMS Vendor Request pending for this vendor.",!,"Any changes you make now may be overwritten when the Vendor",!,"Update is received.",!!
 Q
