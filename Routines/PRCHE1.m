PRCHE1 ;WISC/DJM/BGJ/AS-IFCAP EDIT VENDOR FILE ;3/8/05
V ;;5.1;IFCAP;**7,59,55,81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;NEW ENTER/EDIT VENDOR FILE CALLED FROM PRCHPC VEN EDIT OPTION
 N %,%X,%Y,DIE,DIK,DIR,DIRUT,DR,PRCF,SITE,DA,PRCHV3,FLAGN,FLAG
 N DIC,DLAYGO,IEN,Y,FISCAL,VRQ,STOP,INACT,NAME,EDIT,NEW
 ;
VEDIT I '$D(PRC("PARAM")) D  Q:'%
 .  S PRCF("X")="AS"
 .  D ^PRCFSITE
 .  Q
 ;   SEND VENDOR UPDATE INFORMATION TO DYNAMED   **81**
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1)=1,$D(IEN) D ONECHK^PRCVNDR(IEN)
 S SITE=PRC("SITE")
 S DIC="^PRC(440,"
 S DIC(0)="AELMQ"
 S DLAYGO=440
 S PRCHDA=-1
 K PRCHPO
 D ^DIC
 Q:Y<0
 S (IEN,DA)=+Y
 S (FLAGN,NEW)=$P(Y,U,3)
 G:'$D(DA) VEDIT
 D  G:'$D(DA) VEDIT
 .  L +^PRC(440,DA):0
 .  E  W !,$C(7),"ANOTHER USER IS EDITING THIS ENTRY!" K DA
 .  Q
 D  I FLAG=0 L -^PRC(440,IEN) G VEDIT
 .  S PRCHV3=$G(^PRC(440,DA,3))
 .  S FLAG=0
 .  ;
 .  ;NO FMS VENDOR CODE - DO 'ADD' VENDOR REQUEST
 .  I $P(PRCHV3,U,4)="" S FLAG=1
 .  ;
 .  ;FMS VENDOR CODE - DO 'CHANGE' VENDOR REQUEST
 .  I $P(PRCHV3,U,4)]"" S FLAG=2
 .  ;
 .  I $P(PRCHV3,U,12)="P" D
 .  .  W !!,"There is a FMS Vendor Request pending for this vendor."
 .  .  W !,"Any changes you make now may be overwritten when the Vendor"
 .  .  W !,"Update is received.",!!
 .  .  Q
 .  Q
 K ^PRC(440.3,DA)
 I FLAGN="" D
 .  S %X="^PRC(440,DA,"
 .  S %Y="^PRC(440.3,DA,"
 .  D %XY^%RCR
 .  Q
 ;
 S EDIT="[PRCHVENDOR1]"
 ;
 ;  NOW LETS FIND OUT IF USER WANTS TO 'REACTIVATE VENDOR', IF
 ;  APPROPRIATE.
 ;
 S INACT=$P($G(^PRC(440,DA,10)),U,5)
 I INACT=1 D
 .  S DIR("A")="Do you want to 'Reactivate' this vendor"
 .  S DIR("A",1)="  "
 .  S DIR("A",2)="  "
 .  S DIR(0)="Y"
 .  S DIR("B")="NO"
 .  D ^DIR
 .  I Y'=1 S EDIT="[PRCHVENDORNOREACT]" Q
 .  ;  OK USER WANTS TO REACTIVATE VENDOR.
 .  S DIE="^PRC(440,"
 .  S NAME=$P($G(^PRC(440,DA,0)),U,1)
 .  I $E(NAME,1,2)="**" S NAME=$E(NAME,3,99)
 .  S DR=".01////^S X=NAME;15////@;31.5////@"
 .  D ^DIE
 .  W !!
 .  Q
 .  ;  NOW THE VENDOR IS REACTIVATED.
 ;
 S DR=EDIT
 S DIE=DIC
 D ^DIE
 ; $D(Y)=TRUE (1) -- USER '^' OUT OF TEMPLATE
 I $D(Y) D  I FLAG=0 L -^PRC(440,IEN) G VEDIT
 .  ; CHECK TO SEE IF BUSINESS TYPE (FPDS) FIELD HAS BEEN ENTERED
 .  I $P($G(^PRC(440,DA,2)),"^",3)="" D
 .  .  W $C(7),!!,"*** NOT ALL REQUIRED FIELDS HAVE BEEN ENTERED ***"
 .  .  W !,"Failure to enter required data may affect Purchase Order"
 .  .  W " processing",!
 .  .  ;
 .  .  ;See NOIS:V13-0802-N1396
 .  I $P($G(^PRC(440,DA,1.1,0)),"^",3)="" D
 .  .  KILL ^PRC(440,DA,1.1)
 .  .  W $C(7),!!,"*** SOCIOECONOMIC GROUP IS MISSING ***"
 .  .  W !,"Failure to enter required data may affect Purchase Order"
 .  .  W " processing",!
 .  ;
 .  S DIR("A")="Do you want to keep the VENDOR changes"
 .  S DIR(0)="Y"
 .  S DIR("B")="YES"
 .  D ^DIR
 .  ; KILL VARIABLES SET TO USE THE READER
 .  K DIR
 .  ; DIRUT SET IF USER TIMES OUT OR ENTERS '^'.
 .  Q:$D(DIRUT)
 .  ; Y=1 -- USER WANTS TO KEEP VENDOR CHANGES
 .  Q:Y=1
 .  ; USER DECIDED **NOT** TO KEEP VENDOR CHANGES
 .  ; FLAGN=1 MEANS THIS IS A NEW VENDOR (NEW DURING THIS EDIT SESSION)
 .  I FLAGN=1 S DIK="^PRC(440," D ^DIK S FLAG=0 Q
 .  S %X="^PRC(440.3,DA,"
 .  S %Y="^PRC(440,DA,"
 .  D %XY^%RCR
 .  S FLAG=0
 .  W !!
 .  K ^PRC(440.3,DA)
 .  S NAME=$P($G(^PRC(440,DA,0)),U,1)
 .  W "Name: "_NAME,!,"DA: "_DA,!
 .  S N1=$E(NAME,1,2)
 .  Q:N1'["**"
 .  S N1=$E(NAME,3,99)
 .  K ^PRC(440,"B",N1,DA)
 .  S ^PRC(440,"B",NAME,DA)=""
 .  Q
 S FISCAL=$G(^PRC(411,PRC("SITE"),9))
 I $P(FISCAL,U,3)="Y" D  G VEDIT
 .  Q:$$NEW^PRCOVTST(DA,PRC("SITE"),FLAG)
 .  ;
 .  ; SEE IF THIS IS A NEW VENDOR -- IF SO NOW MOVE THE ENTRY
 .  ; OVER TO FILE 440.3
 .  ;
 .  I NEW D
 .  .  S %X="^PRC(440,DA,"
 .  .  S %Y="^PRC(440.3,DA,"
 .  .  D %XY^%RCR
 .  .  Q
 .  ;
 .  ; NOW SET UP TO REVIEW THIS NEW VENDOR
 .  ;
 .  S DIE="^PRC(440.3,"
 .  S DR="47///^S X=FLAG;48///^S X=DA;49///^S X=PRC(""SITE"")"
 .  D ^DIE
 .  Q
 ;
GENERATE ;GO CREATE A VRQ ANS SEND IT TO AUSTIN
 D  Q:$G(STOP)=1
 .  I FLAG=1 D NEW^PRCOVRQ(DA,SITE) Q
 .  I FLAG=2 D UPDATE^PRCOVRQ1(DA,SITE) Q
 G VEDIT
 ;
 ;
SEND(IEN) ;SEND OFF THE VRQ TO AUSTIN -- CALLED FROM SEND^PRCORV1
 S VRQ=$G(^PRC(440.3,IEN,"VRQ"))
 S FLAG=$P(VRQ,U)
 S DA=$P(VRQ,U,2)
 S SITE=$P(VRQ,U,3)
 S STOP=1
 D GENERATE
 Q:$G(^PRC(440.3,IEN,0))]""
 S VRQ=$O(^PRCF(422.2,"B","123-VRQ-01",0))
 S COUNT=$P(^PRCF(422.2,VRQ,0),U,2)
 S COUNT=$S(COUNT-1>0:COUNT-1,1:0)
 S $P(^PRCF(422.2,VRQ,0),U,2)=COUNT
 K ^PRC(440.3,"AD",IEN,IEN)
 Q
