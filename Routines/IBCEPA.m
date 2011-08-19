IBCEPA ;ALB/WCJ - Provider ID functions - Care Units ;21-OCT-2005
 ;;2.0;INTEGRATED BILLING;**320,348,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; -- main entry point for IBCE 2ND PRVID CARE UNIT MAINT
 D EN^VALM("IBCE 2ND PRVID CARE UNIT MAINT")
 Q
 ;
HDR ; -- header code
 K VALMHDR
 S VALMHDR(1)=" "
 S VALMHDR(2)="Insurance Co: "_$S('$G(IBALL)&$G(IBINS):$P($G(^DIC(36,+IBINS,0)),U),1:"ALL")
 Q
 ;
INIT ; -- init variables and list array
 N DIR,Y
 I '$G(IBINS) D  I +Y<0 S VALMQUIT=1 Q
 . S DIR(0)="PA^DIC(36,:AEMQ",DIR("A")="Select INSURANCE CO: ",DIR("?")="Select an INSURANCE CO to display its care units"
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S Y=-2 Q
 . I Y>0 S IBINS=+Y Q
 ;
 D BLD
 Q
 ;
BLD ;
 D CLEAN^VALM10
 K ^TMP("IBPRV_CU",$J)
 N TAR,MSG,I,D0,IBCT,Z,DIV,SCREEN
 ;
 S VALMBG=1
 ;
 ; Get all care units for this insurance company that have a division
 ; If there is no division, then it is part of the other care units code (IBCEP4)
 ; 
 S SCREEN="I $P(^(0),U,4)'="""",$P(^(0),U,3)=IBINS"
 D LIST^DIC(355.95,,"@;.01;.02;.04",,,,,,SCREEN,,"TAR")
 ;
 I '+TAR("DILIST",0) D
 . D SET^VALM10(1,"No CARE UNITs found for this Insurance Company")
 ;
 I +TAR("DILIST",0) D
 . S IBCT=0
 . F VALMCNT=1:1:+TAR("DILIST",0) D
 .. S ^TMP("IBPRV_CU",$J,"SORT",TAR("DILIST","ID",VALMCNT,.04),TAR("DILIST",2,VALMCNT))=VALMCNT
 . S DIV="" F  S DIV=$O(^TMP("IBPRV_CU",$J,"SORT",DIV)) Q:DIV=""  D
 .. S Z="Division: "_DIV
 .. S IBCT=IBCT+1
 .. D SET^VALM10(IBCT,Z)
 .. S D0=0 F  S D0=$O(^TMP("IBPRV_CU",$J,"SORT",DIV,D0)) Q:'D0  D
 ... S IN=^TMP("IBPRV_CU",$J,"SORT",DIV,D0)
 ... S Z=$J("",2)
 ... S Z=Z_$E(IN_"    ",1,4)_$E(TAR("DILIST","ID",IN,.01),1,36)
 ... S Z=Z_$J("",40-$L(Z))
 ... S Z=Z_$E(TAR("DILIST","ID",IN,.02),1,38)
 ... S IBCT=IBCT+1
 ... D SET^VALM10(IBCT,Z)
 ;
 ; correct the VALMCNT variable - number of lines in the list (not entries)
 S VALMCNT=+$O(@VALMAR@(""),-1)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 K ^TMP("IBPRV_CU",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
NEW ; Add care unit
 ; Assumes IBINS is defined as ins co ien (file 36)
 ; IB = 0 or null if called from list manager, 1 if not
 N DIC,DIR,X,Y,Z,D,DA,DR,DIE,DO,DD,DLAYGO,IB95,IBADD,IBOK,IBDIV,MAIN,IBDIVNM
 ;
 D FULL^VALM1
 ; Add an entry - either new care unit/ins co or a combination for
 ; existing care unit/ins co
 ;
 S MAIN=$$MAIN^IBCEP2B()
 S MAIN=$$EXTERNAL^DILFD(355.92,.05,"",MAIN)
 S DIC=40.8,DIC("A")="Enter the Division for this Care Unit: ",DIC("B")=MAIN,DIC(0)="AEMQ"
 S D="B^C"
 D MIX^DIC1
 I Y'>0 G NEWQ
 S IBDIV=+Y
 S IBDIVNM=$$EXTERNAL^DILFD(355.92,.05,"",IBDIV)
 ;
 N SCREEN,TAR,MESS,I
 S SCREEN="I $P(^(0),U,3)=+$G(IBINS),$P(^(0),U,4)=+$G(IBDIV)"
 D LIST^DIC(355.95,,.01,,,,,,SCREEN,,"TAR")
 ;
ACU K DIR
 S I=0
 I $G(TAR("DILIST",0)) D 
 . S DIR("?",1)="Current Entries are:"
 . F I=2:1 Q:'$D(TAR("DILIST",1,I-1))  S DIR("?",I)="     "_TAR("DILIST",1,I-1)
 . S DIR("?",I)=" "
 ;
 S DIR("?",I+1)="You may enter the name of a new Care Unit for this Insurance Company."
 S DIR("?",I+2)="You can then define a Billing Provider Secondary ID - Billing Screen 3 - for"
 S DIR("?")="this Care Unit and Insurance Company using the Insurance Company Editor."
 S DIR("A")="Enter the Care Unit name"
 S DIR(0)="FO^1:30"
 D ^DIR
 I X=""!$G(DUOUT)!$G(DTOUT)!$G(DIROUT) G NEWQ
 S CAREUNIT=X
 ; 
 ; At this point, we have X and it'a not a ? or ^
 ;
 K DIC
 S DIC="^IBA(355.95,",DIC("S")="I $P(^(0),U,3)=+$G(IBINS),$P(^(0),U,4)=+$G(IBDIV)",DIC(0)="EX"
 D ^DIC
 ;
 ; Check if we have an exisitng entry and if so, get out of Dodge (This option was for new care units)
 I Y>0 D  G ACU
 . D DISPMESS("This action is for adding new entries, not editing existing entries.")
 ;
 ; New entry , validate field
 N TAR2
 D FIELD^DID(355.95,.01,"N","INPUT TRANSFORM","TAR2")
 S X=CAREUNIT
 X TAR2("INPUT TRANSFORM")
 I '$D(X) D  G ACU  ; Failed input transform
 . D DISPMESS("Invalid Format.")
 ;
 K DIR
 S DIR("A")="Are you adding '"_X_"' as a new Care Unit for '"_IBDIVNM_"'"
 S DIR("B")="N"
 S DIR(0)="Y"
 D ^DIR
 I Y=0 G ACU
 I Y["^" G NEWQ
 ;
 ; If it got this far, we have an exact match or a new entry.   
 S X=CAREUNIT
 S DIC="^IBA(355.95,",DIC("S")="I $P(^(0),U,3)=+$G(IBINS),$P(^(0),U,4)=+$G(IBDIV)",DIC(0)="XL",DLAYGO=355.95
 S DIC("DR")=".03////"_+$G(IBINS)_";.04////"_$G(IBDIV)
 D ^DIC
 I Y>0 D
 . S DA=+Y,DIE="^IBA(355.95,"
 . S DR=".02Enter the Care Unit Description"
 . D ^DIE
 D BLD
 ;
NEWQ S VALMBCK="R"
 Q
 ;
CHANGE ; Edit care unit
 ; Assumes IBINS is defined as ins co ien (file 36)
 ;
 D FULL^VALM1
 ;
 N X,Y,Z,D,DA,DD,DIC,DIK,DIR,IBDIV,CAREUNIT,SCREEN,TAR,DIVISION,I
 ;
 S SCREEN="I $P(^(0),U,3)=+$G(IBINS),$P(^(0),U,4)]"""""
 D LIST^DIC(355.95,,".01;.04",,,,,,SCREEN,,"TAR")
 ;
 I '+$G(TAR("DILIST",0)) D  G CHANGEQ
 .D DISPMESS("No Care Units Defined for this insurance company.")
 ;
 ; Store all Divisons with at least one care unit in DIVISION array
 F I=1:1 Q:'$D(TAR("DILIST","ID",I,.04))  D
 . S DIVISION(TAR("DILIST","ID",I,.04))=""
 ;
 ; Only allow divisions that have care units to be selected
 S DIC=40.8
 S DIC("A")="Enter the Division for this Care Unit: "
 S DIC(0)="AEMQ"
 S DIC("S")="I $D(DIVISION($P(^(0),U)))"
 S D="B^C"
 D MIX^DIC1
 I Y'>0 G CHANGEQ
 S IBDIV=+Y
 S DA=$$SEL($P(Y,U,2)) I 'DA G CHANGEQ
 S DIE=355.95
 S DR=".01Care Unit;.04Division;.02Description"
 D ^DIE
 ;
 D BLD
 ;
CHANGEQ S VALMBCK="R"
 Q
 ;
DEL ; Delete a Care Unit
 ; Assumes IBINS is defined as ins co ien (file 36)
 ; 
 D FULL^VALM1
 N X,Y,Z,D,DA,DD,DIC,DIK,DIR,IBDIV,CAREUNIT,SCREEN,TAR,DIVISION
 ;
 S SCREEN="I $P(^(0),U,3)=+$G(IBINS),$P(^(0),U,4)]"""""
 D LIST^DIC(355.95,,".01;.04",,,,,,SCREEN,,"TAR")
 ;
 I '+$G(TAR("DILIST",0)) D  G DELQ
 .D DISPMESS("No Care Units Defined for this insurance company.")
 ;
 ; Store all Divisons with at least one care unit in DIVISION array
 F I=1:1 Q:'$D(TAR("DILIST","ID",I,.04))  D
 . S DIVISION(TAR("DILIST","ID",I,.04))=""
 ;
 ; Only allow divisions that have care units to be selected
 S DIC=40.8
 S DIC("A")="Enter the Division for this Care Unit: "
 S DIC(0)="AEMQ"
 S DIC("S")="I $D(DIVISION($P(^(0),U)))"
 S D="B^C"
 D MIX^DIC1
 I Y'>0 G DELQ
 S IBDIV=+Y
 S CAREUNIT=$$SEL($P(Y,U,2)) I 'CAREUNIT G DELQ
 ;
 I $D(^IBA(355.92,"AC",+Y)) D  G DELQ
 . S DIR(0)="EA"
 . S DIR("A",1)="IDs that are assigned to the Care Unit in the Insurance Company Editor must be"
 . S DIR("A",2)="deleted before deleting the Care Unit."
 . S DIR("A")="Press return to continue "
 . W ! D ^DIR K DIR
 ;
 S DIR("A")="OK to Delete: "
 S DIR("B")="No"
 S DIR(0)="YAO"
 D ^DIR
 I '$G(Y) G DELQ
 K DIR
 ;
 S DA=CAREUNIT
 S DIK="^IBA("_355.95_","
 D ^DIK
 ;
 D BLD
 ;
DELQ S VALMBCK="R"
 Q
 ;
DISPMESS(MESS) ;
 N DIR,X,Y
 S DIR(0)="EA",DIR("A",1)=MESS
 S DIR("A")="PRESS ENTER to continue "
 D ^DIR
 Q
 ;
SEL(DIV) ; select care unit for a given division
 ; DIV - name of division
 ; returns ien of selected care unit, or 0 if nothing is selected
 N DIR,I,IEN,MIN,MAX,X,Y
 I $G(DIV)="" Q 0
 S IEN=0
 S I=$O(^TMP("IBPRV_CU",$J,"SORT",DIV,"")),MIN=$G(^TMP("IBPRV_CU",$J,"SORT",DIV,I))
 S I=$O(^TMP("IBPRV_CU",$J,"SORT",DIV,""),-1),MAX=$G(^TMP("IBPRV_CU",$J,"SORT",DIV,I))
 I MIN=MAX S IEN=I
 I MIN'=MAX D
 .S DIR("A")="Select CARE UNITS",DIR(0)="N^"_MIN_":"_MAX_":0" D ^DIR
 .Q:$D(DTOUT)!$D(DUOUT)
 .S I="" F  S I=$O(^TMP("IBPRV_CU",$J,"SORT",DIV,I)) Q:I=""!(IEN>0)  S:$G(^TMP("IBPRV_CU",$J,"SORT",DIV,I))=Y IEN=I
 .Q
 Q IEN
