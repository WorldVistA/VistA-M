PRCOVL ;WISC/DKM/BGJ-IFCAP AR VENDOR EDIT ROUTINE ;[10/19/98 2:36pm]
V ;;5.1;IFCAP;**7**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for PRCO VENDOR EDIT FOR AR
 ; FIRST LETS SEE IF THERE ARE ANY VENDOR RECORDS TO EDIT.
 S COUNT=$O(^PRCF(422.2,"B","AR-EDIT-01",0)) G:COUNT'>0 NONE
 S COUNT=$P($G(^PRCF(422.2,COUNT,0)),U,2) G:COUNT'>0 NONE
 K COUNT
 ;
 ; GET TERMINAL ATTRIBUTES.
 ;
 I '$D(IOF)!('$G(IOST(0))) S IOP="HOME" D ^%ZIS K IOP
 S X="IORVON;IORVOFF" D ENDR^%ZISS
 S PRCO("RV1")=$G(IORVON),PRCO("RV0")=$G(IORVOFF)
 S PRCO("XY")="N DX,DY S (DX,DY)=0 "_$G(^%ZOSF("XY"))
 D EN^VALM("PRCO VENDOR EDIT FOR AR")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Edit vendor selected by AR user"
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("PRCOVL",$J)
 S LOST=0
 S NAME=""
 I $O(^PRC(440.3,"AE",NAME))="" W !,"No Vendor records to edit." G NONE
INITA D CLEAN^VALM10
 S COUNT=0
 S LINENO=0
 S NAME=""
 F  S NAME=$O(^PRC(440.3,"AE",NAME)) Q:NAME=""  D
 .  S LIST=0
 .  F  S LIST=$O(^PRC(440.3,"AE",NAME,LIST)) Q:LIST=""  D
 .  .  S NAME=$S($G(NAME)]"":NAME,1:$P($G(^PRC(440,LIST,0)),U)) Q:NAME=""
 .  .  I $G(^PRC(440.3,LIST,"AR"))']"" D  Q
 .  .  .  K ^PRC(440.3,LIST)
 .  .  .  K ^PRC(440.3,"AD",NAME,LIST,LIST)
 .  .  .  K ^PRC(440.3,"AE",NAME,LIST,LIST)
 .  .  .  Q
 .  .  S VDA=0
 .  .  F  S VDA=$O(^PRC(440.3,"AE",NAME,LIST,VDA)) Q:VDA=""  D
 .  .  .  S COUNT=COUNT+1
 .  .  .  S SENT=$P($G(^PRC(440.3,VDA,"AR")),U,5)
 .  .  .  S OK=$P($G(^PRC(440.3,VDA,"AR")),U,4)
 .  .  .  S TAX=$P($G(^PRC(440,VDA,3)),U,8)
 .  .  .  S X=$$SETFLD^VALM1(COUNT,"","NUMBER")
 .  .  .  S X=$$SETFLD^VALM1(NAME,X,"VENDOR")
 .  .  .  S X=$$SETFLD^VALM1(TAX,X,"TAX ID/SSN")
 .  .  .  S X=$$SETFLD^VALM1(OK,X,"OK")
 .  .  .  S X=$$SETFLD^VALM1(SENT,X,"SENT")
 .  .  .  S LINENO=LINENO+1
 .  .  .  D SET^VALM10(COUNT,X,LINENO)
 .  .  .  S ^TMP("PRCOVL",$J,LINENO)=COUNT_"^"_LIST
 .  .  .  Q
 .  .  Q
 .  Q
 S VALMCNT=COUNT
 S LN=$O(^PRCF(422.2,"B","AR-EDIT-01",0))
 S $P(^PRCF(422.2,LN,0),U,2)=COUNT
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
NONE ; COME HERE IF THERE ARE NO VENDOR RECORDS TO EDIT.
 W !!,"There are no vendor records to edit at this time."
NONE1 S DIR(0)="E"
 S DIR("A")="Enter RETURN to continue"
 D ^DIR
 K DIR
 Q
 ;
REV ;COMPLETE REVIEW OF VENDOR ENTRY
 N SPACE,VALMY,IEN,PRCOI,PRCOIN,DIC,DA,DR,DIQ,DIR,Y
 D EN^VALM2(XQORNOD(0),"OS")
 S PRCOI=0
 S PRCOI=$O(VALMY(PRCOI)) G:'PRCOI REVQ
 S PRCOIN=$G(^TMP("PRCOVL",$J,PRCOI))
 S IEN=+$P(PRCOIN,U,2)
 D FULL^VALM1
REV1 W @IOF
 K PRCORVP
 S DIC="^PRC(440,",DA=IEN,DR=".01:46",DIQ="PRCORVP",DIQ(0)="E"
 D EN^DIQ1
 S $P(SPACE," ",24)=" "
 W !!,"           Vendor Name: "_$$FIELD(IEN,.01)
 W ?70,"PAGE: 1"
 W !,"      Ordering Address: "_$$FIELD(IEN,1)
 W:$$FIELD(IEN,2)]"" !,SPACE_$$FIELD(IEN,2)
 S X="        City,State,ZIP: "
 S:$$FIELD(IEN,4.2)]"" X=X_$$FIELD(IEN,4.2)_", "
 S:$$FIELD(IEN,4.4)]"" X=X_$$FIELD(IEN,4.4)_" "
 S X=X_$S($L($$FIELD(IEN,4.6))=9:$E($$FIELD(IEN,4.6),1,5)_"-"_$E($$FIELD(IEN,4.6),6,9),1:$$FIELD(IEN,4.6))
 W !,X
 W !!,"              FMS Name: "_$$FIELD(IEN,34.5)
 W !!," *     Payment ADDRESS: "_$$FIELD(IEN,17.3)
 W !,"                        "_$$FIELD(IEN,17.4)
 W:$$FIELD(IEN,17.5)]"" !,SPACE_$$FIELD(IEN,17.5)
 W:$$FIELD(IEN,17.6)]"" !,SPACE_$$FIELD(IEN,17.6)
 S X=" *      City,State,ZIP: "
 S:$$FIELD(IEN,17.7)]"" X=X_$$FIELD(IEN,17.7)_", "
 S:$$FIELD(IEN,17.8)]"" X=X_$$FIELD(IEN,17.8)_" "
 S X=X_$S($L($$FIELD(IEN,17.9))=9:$E($$FIELD(IEN,17.9),1,5)_"-"_$E($$FIELD(IEN,17.9),6,9),1:$$FIELD(IEN,17.9))
 W !,X
 W !!,"PAYMENT CONTACT PERSON: "_$$FIELD(IEN,17)
 W !,"  PAYMENT PHONE NUMBER: "_$$FIELD(IEN,7.2)
 W !
 W !,"     * = REQUIRED FIELD"
 W !
 S DIR(0)="E"
 D ^DIR
 K DIR
 W !
 G:Y'=1 REVEXIT
 W @IOF
 W !!,"           Vendor Name: "_$$FIELD(IEN,.01)
 W ?70,"PAGE: 2"
 W !!,"       FMS VENDOR CODE: "_$$FIELD(IEN,34)
 W !,"          ALT-ADDR-IND: "_$$FIELD(IEN,35)
 W !," *          TAX ID/SSN: "_$$FIELD(IEN,38)
 W !," *      SSN/TAX ID IND: "_$$FIELD(IEN,39)
 W !!,"        NON-RECURRING/"
 W !,"      RECURRUNG VENDOR: "_$$FIELD(IEN,36)
 W !!," 1099 VENDOR INDICATOR: "_$$FIELD(IEN,41)
 W !," *         VENDOR TYPE: "_$$FIELD(IEN,44)
 W !,"      DUN & BRADSTREET: "_$$FIELD(IEN,18.3)
 W !
 W !,"     * = REQUIRED FIELD"
 W !
 S DIR(0)="E"
 S DIR("A")="Enter RETURN to continue"
 D ^DIR
 K DIR
REVEXIT I $G(RETURN)=961 G REVQ
 S VALMBCK="R",VALMBG=1
REVQ Q
 ;
FIELD(IEN,FIELD) ;FETCH EXTERNAL VALUE OF FIELD
 ;FOR RECORD 'IEN' FROM FILE 440.3
 S FIELD=$G(PRCORVP(440,IEN,FIELD,"E"))
 Q FIELD
 ;
EDIT ;EDIT THIS VENDOR
 N PRCOI,PRCOIN,IEN,RETURN
 D EN^VALM2(XQORNOD(0),"OS")
 S PRCOI=0
 S PRCOI=$O(VALMY(PRCOI))
 G:'PRCOI REVQ
 S PRCOIN=$G(^TMP("PRCOVL",$J,PRCOI))
 S IEN=+$P(PRCOIN,U,2)
 S SENT=$P($G(^PRC(440.3,IEN,"AR")),U,5)
 I SENT]"" W !!,"This record has already been sent to Austin or FISCAL." D NONE1 G EDITEX
 D FULL^VALM1
 W @IOF
 S NAME=$P($G(^PRC(440,IEN,0)),U)
 W:NAME]"" !!?11,"Vendor Name: "_NAME
 D HILO^PRCFQ
 S (DA,PRCFA("VEND"))=IEN
 W !
 S DIR(0)="Y"
 S DIR("A")="Review the vendor selected"
 S DIR("B")="YES"
 D ^DIR
 K DIR
 W !
 G:$D(DIRUT) EDITEX
 I +Y=1 SET RETURN=961 D REV1 W @IOF
 K PRCTMP,RETURN
 D DOIT
 G:$D(DIRUT)!(Y'=1) EDITEX
 D SCREEN
 L +^PRC(440,DA):5 E  W !,$C(7),"Another user is editing this entry!" G EDITEX
 S DIE="^PRC(440,"
 S DR=$S(LOCAT="S":"[PRCHVENDOR]",1:"[PRCF FMS VENEDIT1B]")
 D ^DIE
 K DIE,DR,ORDER
 S ARFLG=$G(^PRC(440.3,PRCFA("VEND"),"AR"))
 S IEN=$P(ARFLG,U,2)
 S PRC("SITE")=$P(ARFLG,U,3)
 S FLAG=$P(ARFLG,U)
 S SAVE=$$CHECK^PRCOVTST(IEN,PRC("SITE"),FLAG)
 S SAVE1=$S(SAVE=0:"OK",SAVE=2:"GOOD",1:"")
 S TAX=$P($G(^PRC(440,IEN,3)),U,8)
 S DA=IEN
 S DIE="^PRC(440.3,"
 S DR=$S(SAVE=0:"53///^S X=SAVE1",SAVE=2:"53///^S X=SAVE1",1:"53///@")
 D ^DIE
 S X=@VALMAR@(PRCOI,0)
 S OK=$S(SAVE=0:"OK",1:"")
 S X=$$SETFLD^VALM1(OK,X,"OK")
 S X=$$SETFLD^VALM1(TAX,X,"TAX ID/SSN")
 S @VALMAR@(PRCOI,0)=X
 L -^PRC(440,PRCFA("VEND"))
EDITEX S VALMBCK="R",VALMBG=1
 Q
 ;
DOIT ;FIND OUT IF USER WANTS TO EDIT VENDOR RECORD
 W !
 S DIR(0)="Y"
 S DIR("A")="Edit the Vendor record"
 S DIR("B")="YES"
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit this edit session."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to continue."
 D ^DIR
 K DIR
 W !
 Q
 ;
SCREEN ; Control screen display
 I $D(IOF) W @IOF
 ; Write Option Header
 I $D(XQY0) W IOINHI,$P(XQY0,U,2),IOINORM,!
 Q
