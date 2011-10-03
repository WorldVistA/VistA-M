PRCORV ;WISC/DJM/BGJ-IFCAP VRQ REVIEW ROUTINE ;5/8/96  11:00 AM
V ;;5.1;IFCAP;**7**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ; -- main entry point for PRCO VENDOR REVIEW
 ;First lets check if there are any VRQs to review.  IF not - exit.
 S COUNT=$O(^PRCF(422.2,"B","123-VRQ-01",0)) I COUNT'>0 G NODO
 S COUNT=$P($G(^PRCF(422.2,COUNT,0)),U,2) I COUNT'>0 G NODO
 K COUNT
 ;
 D TERM
 D EN^VALM("PRCO VENDOR REVIEW")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="VENDOR REQUESTs for review"
 Q
 ;
INIT ; -- init variables and list array
 N NAME,CNT,VDA,FMS,ALT,TAX,COUNT,LINENO,LIST
 K ^TMP("PRCORV",$J)
 S LIST=0,NAME=""
 I $O(^PRC(440.3,"AD",NAME))="" W !,"No VRQs to review" Q
 D CLEAN^VALM10
 S COUNT=0,LINENO=0,NAME=""
 F  S NAME=$O(^PRC(440.3,"AD",NAME)) Q:NAME=""  D
 .  S LIST=0
 .  F  S LIST=$O(^PRC(440.3,"AD",NAME,LIST)) Q:LIST=""  D
 .  .  S NAME=$S($G(NAME)]"":NAME,1:$G(^PRC(440,LIST,0))) Q:NAME=""
 .  .  I $G(^PRC(440.3,LIST,"VRQ"))']"" D  Q
 .  .  .  K ^PRC(440.3,LIST)
 .  .  .  K ^PRC(440.3,"AD",NAME,LIST,LIST)
 .  .  S VDA=0
 .  .  F  S VDA=$O(^PRC(440.3,"AD",NAME,LIST,VDA)) Q:VDA=""  D
 .  .  .  S COUNT=COUNT+1
 .  .  .  S FMS=$P($G(^PRC(440,VDA,3)),U,4)
 .  .  .  S ALT=$P($G(^PRC(440,VDA,3)),U,5)
 .  .  .  S FMS=FMS_$S(ALT]"":"-"_FMS,1:"")
 .  .  .  S TAX=$P($G(^PRC(440,VDA,3)),U,8)
 .  .  .  S X=$$SETFLD^VALM1(COUNT,"","NUMBER")
 .  .  .  S X=$$SETFLD^VALM1(NAME,X,"VENDOR")
 .  .  .  S X=$$SETFLD^VALM1(FMS,X,"FMS VENDOR")
 .  .  .  S X=$$SETFLD^VALM1(TAX,X,"TAX ID/SSN")
 .  .  .  S LINENO=LINENO+1
 .  .  .  D SET^VALM10(COUNT,X,LINENO)
 .  .  .  S ^TMP("PRCORV",$J,LINENO)=COUNT_"^"_LIST
 .  .  .  Q
 .  .  Q
 .  Q
 S VALMCNT=COUNT
 S LN=$O(^PRCF(422.2,"B","123-VRQ-01",0))
 S $P(^PRCF(422.2,LN,0),U,2)=COUNT
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAR^VALM1 K ^TMP($J,"PRCORV")
 K ^TMP("PRCORV",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
TERM ; -- get terminal attributes
 N X
 I '$D(IOF)!('$G(IOST(0))) S IOP="HOME" D ^%ZIS K IOP
 S X="IORVON;IORVOFF" D ENDR^%ZISS
 S PRCO("RV1")=$G(IORVON),PRCO("RV0")=$G(IORVOFF)
 S PRCO("XY")="N DX,DY S (DX,DY)=0 "_$G(^%ZOSF("XY"))
 Q
 ;
SET(STRING,LINE,COLUMN,CLREND,ON,OFF) ; -- set array
 S COLUMN=$S($G(COLUMN)>0:COLUMN,1:1)
 I STRING="" D SET^VALM10(LINE,$J("",80),COLUMN)
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80),COLUMN)
 D SET^VALM10(LINE,STRING,COLUMN)
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLUMN,$L(STRING),ON,OFF)
 Q
 ;
NODO ;COME HERE IF THERE ARE NO VRQs TO REVIEW.
 W !!,"There are no VRQs for you to review at this time.",!!
 S DIR(0)="E"
 S DIR("A")="Enter RETURN to continue"
 D ^DIR
 K DIR
 Q
 ;
PRINT ;PRINTING OF A COMPLETE REVIEW OF VENDOR ENTRY
 N %ZIS,AA,POP
 D EN^VALM2(XQORNOD(0),"O")
 Q:'$D(VALMY)
 D FULL^VALM1
 W @IOF
 K IO("Q")
 S %ZIS="MQ",%ZIS("A")="Select a printer: ",%ZIS("B")=""
 S %ZIS("S")="S AA=$G(^%ZIS(1,Y,""SUBTYPE"")) I AA>0,$E($G(^%ZIS(2,AA,0)),1)=""P"""
 D ^%ZIS
 I POP W !!," No printer selected -- quitting." G PRINTQ
 I $D(IO("Q")) K IO("Q") D  G PRINTQ
 .  S ZTRTN="PRINT1^PRCORV"
 .  S ZTSAVE("VALMY(")=""
 .  S ZTSAVE("^TMP(""PRCORV"",$J,")=""
 .  S ZTDESC="Complete review of vender entry"
 .  D ^%ZTLOAD
 .  Q
 ;
PRINT1 ;ENTER HERE TO PRINT THE REPORT
 N DIC,DA,DIQ,SPACE,%,%H,%I,X,Y,FIELD,PN,PRCOI,PRCOIN,IEN
 S (PRCOI,PN)=0
 ;GET THE IEN FOR EACH ENTRY SELECTED
 F  S PRCOI=$O(VALMY(PRCOI)) Q:PRCOI'>0  D
 .  S PRCOIN=$G(^TMP("PRCORV",$J,PRCOI))
 .  S IEN=+$P(PRCOIN,U,2)
 .  S PN=PN+1
 .  D PRINT2
 G PRINTQ
 ;
PRINT2 ;PRINT EACH ENTRY SELECTED HERE
 K PRCORVP
 S DIC="^PRC(440,",DA=IEN,DR=".01:46",DIQ="PRCORVP",DIQ(0)="E"
 D EN^DIQ1
 S $P(SPACE," ",24)=" "
 U IO
 W:$Y>0 @IOF
 I $D(ZTQUEUED) W:PN>1 !
 W !!,?9,"VENDOR Review"
 W ?38
 D NOW^%DTC
 D YX^%DTC
 W Y
 W ?70,"PAGE: "_PN
 W !!,?11,"Vendor Name: "_$$FIELD(.01)
 W !,?6,"Ordering Address: "_$$FIELD(1)
 W:$$FIELD(2)]"" !,SPACE_$$FIELD(2)
 S X=SPACE
 S:$$FIELD(4.2)]"" X=X_$$FIELD(4.2)_", "
 S:$$FIELD(4.4)]"" X=X_$$FIELD(4.4)_" "
 S X=X_$S($L($$FIELD(4.6))=9:$E($$FIELD(4.6),1,5)_"-"_$E($$FIELD(4.6),6,9),1:$$FIELD(4.6))
 W !,X
 W !!,?14,"FMS Name: "_$$FIELD(34.5)
 W !!,?7,"Payment ADDRESS: "_$$FIELD(17.3)
 W !,SPACE,$$FIELD(17.4)
 W:$$FIELD(17.5)]"" !,SPACE_$$FIELD(17.5)
 W:$$FIELD(17.6)]"" !,SPACE_$$FIELD(17.6)
 S X=SPACE
 S:$$FIELD(17.7)]"" X=X_$$FIELD(17.7)_", "
 S:$$FIELD(17.8)]"" X=X_$$FIELD(17.8)_" "
 S X=X_$S($L($$FIELD(17.9))=9:$E($$FIELD(17.9),1,5)_"-"_$E($$FIELD(17.9),6,9),1:$$FIELD(17.9))
 W !,X
 W !!,"PAYMENT CONTACT PERSON: "_$$FIELD(17)
 W !,"  PAYMENT PHONE NUMBER: "_$$FIELD(7.2)
 W !!,?7,"FMS VENDOR CODE: "_$$FIELD(34)
 W !,?10,"ALT-ADDR-IND: "_$$FIELD(35)
 W !,?12,"TAX ID/SSN: "_$$FIELD(38)
 W !,?8,"SSN/TAX ID IND: "_$$FIELD(39)
 W !!,?8,"NON-RECURRING/"
 W !,?6,"RECURRING VENDOR: "_$$FIELD(36)
 W !!," 1099 VENDOR INDICATOR: "_$$FIELD(41)
 W !,?11,"VENDOR TYPE: "_$$FIELD(44)
 W !,?6,"DUN & BRADSTREET: "_$$FIELD(18.3)
 Q
 ;
PRINTQ S VALMBCK="R",VALMBG=1
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
PRINTQ1 Q
 ;
FIELD(FIELD) ;FETCH EXTERNAL VALUE OF FIELD
 ;FOR RECORD 'IEN' FROM FILE 440
 S FIELD=$G(PRCORVP(440,IEN,FIELD,"E"))
 Q FIELD
