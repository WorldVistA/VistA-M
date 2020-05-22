PRCHEA1 ;SF-ISC/TKW/DST/AS-MORE EDIT ROUTINES FOR SUPPLY SYSTEM ;3/17/17  18:48
V ;;5.1;IFCAP;**81,198**;Oct 20, 2000;Build 6
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN0 ;REACTIVATE VENDOR
 ;
 S PRCHREAV="I $D(^(10)),$P(^(10),U,5)"
 S DIC="^PRC(440,"
 S DIE=DIC
 S DIC(0)="AEMQZ",DIC("S")="I (+Y<950000)!$D(^XUSEC(""PRCHVEN"",DUZ))"
 D ^DIC
 G Q:Y<0
 S DA=+Y
 L +^PRC(440,DA):0 E  W !,$C(7),"ANOTHER USER IS EDITING THIS ENTRY!" K DA
 G Q:'$D(DA)
 ;
 ;NOW THE RECORD IS LOCKED
 ;
 S PRCHY=$P(Y(0),U,1)
 I $E(PRCHY,1,2)="**" S PRCHY=$E(PRCHY,3,99)
 S IEN="      "_DA
 S IEN=$E(IEN,$L(IEN)-5,99)
 W !,"Sure you want to RE-activate Vendor "_PRCHY_", NO:"_IEN
 S %B=""
 S %=2
 D ^PRCFYN
 I %=1 D
 .  S DR=".01////^S X=PRCHY;15////@;31.5////@"
 .  D ^DIE
 .  ;   SEND VENDOR UPDATE INFORMATION TO DYNAMED    **81**
 .  D:$$GET^XPAR("SYS","PRCV COTS INVENTORY",1)=1 ONECHK^PRCVNDR(DA)
 .  Q
 ;
 ;UNLOCK THE RECORD
 ;
 L -^PRC(440,DA)
 D Q
 G EN0
 ;
EN1 ;INACTIVATE VENDOR
 ;
 K PRCHREAV
 I '$D(DT) D
 .  D NOW^%DTC
 .  S DT=$P(%,".",1)
 .  Q
 N DIC
 S DIC="^PRC(440,"
 S DIC(0)="AEMQZ",DIC("S")="I (+Y<950000)!$D(^XUSEC(""PRCHVEN"",DUZ))"
 D ^DIC
 G Q:Y<0
 I $D(^PRC(440,+Y,10)),$P(^(10),U,5)=1 W $C(7),!,"Please choose another vendor that is not inactivated." G EN1
 S (PRCHOLD,DA)=+Y
 S PRCHY=$P(Y(0),U,1)
 L +^PRC(440,DA):0 E  W !,$C(7),"ANOTHER USER IS EDITING THIS ENTRY!" K DA
 G Q:'$D(DA)
 ;
 ;NOW THE RECORD IS LOCKED
 ;
 W !!,"Enter the Vendor you want to substitute for the inactivated vendor "
 S DIC("S")="I $S(PRCHOLD=+Y:0,'$D(^(10)):1,+$P(^(10),U,5)=0:1,1:0)"
 S DIC("A")="Select REPLACEMENT VENDOR: "
 S PRCHX=""
 S PRCHY="**"_$E($P(Y(0),U,1),1,34)
 D ^DIC
 S:Y>0 PRCHX=+Y
 S IENS="      "_PRCHX
 S IENS=$E(IENS,$L(IENS)-5,99)
 S IENO="      "_PRCHOLD
 S IENO=$E(IENO,$L(IENO)-5,99)
 W !!,"Sure you want to inactivate Vendor "_$P(^PRC(440,PRCHOLD,0),U)_",  NO:"_IENO
 W:PRCHX !," and substitute vendor "_$P(^PRC(440,PRCHX,0),U)_", NO:"_IENS
 S %B=""
 S %=2
 D ^PRCFYN
 I %=1 D
 .  S DIE="^PRC(440,"
 .  S DA=PRCHOLD
 .  S DR=".01////^S X=PRCHY;15////^S X=PRCHX;31.5///^S X=1"
 .  D ^DIE
 .  ;   SEND VENDOR UPDATE INFORMATION TO DYNAMED     **81**
 .  D:$$GET^XPAR("SYS","PRCV COTS INVENTORY",1)=1 ONECHK^PRCVNDR(DA)
 .  Q
 ;
 ;UNLOCK THE RECORD
 ;
 L -^PRC(440,DA)
 D Q
 G EN1
 ;
EN2 ;INACTIVATE ITEM
 ;
 K PRCHREAV
 I '$D(DT) D
 .  D NOW^%DTC
 .  S DT=$P(%,".",1)
 .  Q
 K DIC
 S DIC="^PRC(441,"
 S DIC(0)="AEMQZ",DIC("S")="I (+Y<20000000)!$D(^XUSEC(""PRCHITEM SUPER"",DUZ))"
 D ^DIC
 G Q:Y<0
 I $P(Y(0),"^",2)["*" W $C(7),!,"                ITEM ALREADY INACTIVE" G EN2
 S DA=+Y
 L +^PRC(441,DA):0 E  W !,$C(7),"ANOTHER USER IS EDITING THIS ENTRY!" K DA
 G Q:'$D(DA)
 ;
 ;NOW THE RECORD IS LOCKED
 ;
 S PRCHOLD=DA
 W !!,"Enter the item you want to substitute for the inactivated item "
 S DIC("A")="SELECT Substitute Item: "
 S PRCHY="**"_$E($P(Y(0),U,2),1,58)
 D ^DIC
 S PRCHZ=$S(+Y>0:+Y,1:"")
 W !!,"Sure you want to inactivate Item ",PRCHOLD
 W:+Y>0 " and substitute Item ",+Y
 S %B=""
 S %=2
 D ^PRCFYN
 I %=1 D
 .  S DIE="^PRC(441,"
 .  S DA=PRCHOLD
 .  S DR=".05////^S X=PRCHY;16////^S X=1"
 .  S:PRCHZ DR=DR_";16.5////^S X=PRCHZ"
 .  D ^DIE
 .  ;   Send ITEM Master File updated info to DYNAMED
 .  D:$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 ONECHK^PRCVIT(DA)
 .  Q
 ;
 ;UNLOCK THE RECORD
 ;
 L -^PRC(441,DA)
 D Q
 G EN2
 ;
EN3 ;REACTIVATE ITEM
 ;
 S PRCHREAV="I $D(^(3)),+^(3)"
 S DIC="^PRC(441,"
 S DIE=DIC
 S DIC(0)="AEMQZ",DIC("S")="I (+Y<20000000)!$D(^XUSEC(""PRCHITEM SUPER"",DUZ))"
 D ^DIC
 G Q:Y<0
 S DA=+Y
 L +^PRC(441,DA):0 E  W !,$C(7),"ANOTHER USER IS EDITING THIS ENTRY!" K DA
 G Q:'$D(DA)
 ;
 ;NOW THE RECORD IS LOCKED
 ;
 S PRCHY=$P(Y(0),U,2)
 I $E(PRCHY,1,2)="**" S PRCHY=$E(PRCHY,3,99)
 W !,"Sure you want to RE-activate Item number ",DA
 S %B=""
 S %=2
 D ^PRCFYN
 I %=1 D
 .  S DR=".05////^S X=PRCHY;16////@;16.5////@"
 .  D ^DIE
 .  ;   Send ITEM Master File updated info to DYNAMED
 .  D:$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 ONECHK^PRCVIT(DA)
 .  Q
 ;
 ;UNLOCK THE RECORD
 ;
 L -^PRC(441,DA)
 D Q
 G EN3
 ;
Q K DIC,DIE,DR,DA,PRCHOLD,PRCHREAV,PRCHX,PRCHY,PRCHZ
 W !
 Q
