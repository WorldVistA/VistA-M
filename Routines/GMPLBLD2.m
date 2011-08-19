GMPLBLD2 ; SLC/MKB,JFR -- Bld PL Selection Lists cont ; 3/14/03 11:20
 ;;2.0;Problem List;**3,28**;Aug 25, 1994
 ;
 ; This routine invokes IA #3991
 ;
NEWGRP ; Change problem groups
 N NEWGRP D FULL^VALM1
 I $D(GMPLSAVE),$$CKSAVE D SAVE
NG1 S NEWGRP=$$GROUP("L") G:+NEWGRP'>0 NGQ G:+NEWGRP=+GMPLGRP NGQ
 L +^GMPL(125.11,+NEWGRP,0):1 I '$T D  G NG1
 . W $C(7),!!,"This category is currently being edited by another user!",!
 L -^GMPL(125.11,+GMPLGRP,0) S GMPLGRP=NEWGRP
 D GETLIST^GMPLBLDC,BUILD^GMPLBLDC("^TMP(""GMPLIST"",$J)",GMPLMODE),HDR^GMPLBLDC
NGQ S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
 ;
GROUP(L) ; Lookup into Problem Selection Group file #125.11
 N DIC,X,Y,DLAYGO ; L = "" or "L", if LAYGO is [not] allowed
 S DIC="^GMPL(125.11,",DIC(0)="AEQMZ"_L,DIC("A")="Select CATEGORY NAME: "
 S:DIC(0)["L" DLAYGO=125.11
 D ^DIC S:Y'>0 Y="^" S:Y'="^" Y=+Y_U_Y(0)
 Q Y
 ;
NEWLST ; Change selection lists
 N NEWLST D FULL^VALM1
 I $D(GMPLSAVE),$$CKSAVE D SAVE
NL1 S NEWLST=$$LIST("L") G:+NEWLST'>0 NLQ G:+NEWLST=+GMPLSLST NLQ
 L +^GMPL(125,+NEWLST,0):1 I '$T D  G NL1
 . W $C(7),!!,"This list is currently being edited by another user!",!
 L -^GMPL(125,+GMPLSLST,0) S GMPLSLST=NEWLST
 D GETLIST^GMPLBLD,BUILD^GMPLBLD("^TMP(""GMPLIST"",$J)",GMPLMODE),HDR^GMPLBLD
NLQ S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
 ;
LIST(L) ; Lookup into Problem Selection List file #125
 N DIC,X,Y,DLAYGO ; L="" or "L" if LAYGO [not] allowed
 S DIC="^GMPL(125,",DIC(0)="AEQMZ"_L,DIC("A")="Select LIST NAME: "
 S:DIC(0)["L" DLAYGO=125
 D ^DIC S:Y'>0 Y="^" S:Y'="^" Y=+Y_U_Y(0)
 Q Y
 ;
LAST(ROOT) ; Returns last subscript
 N I,J S (I,J)=""
 F  S I=$O(@(ROOT_"I)")) Q:I=""  S J=I
 Q J
 ;
CKSAVE() ; Save [changes] ??
 N DIR,X,Y,TEXT S TEXT=$S($D(GMPLGRP):"category",1:"list")
 S DIR("A")="Save the changes to this "_TEXT_"? ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to save the changes that have been made to this "_TEXT,DIR("?")="before exiting it; NO will leave this "_TEXT_" unchanged."
 S DIR(0)="YA" D ^DIR
 Q +Y
 ;
SAVE ; Save changes to group/list
 N GMPLQT,LABEL,DA
 S GMPLQT=0
 I $D(GMPLGRP) D  I GMPLQT Q
 . N ITM,CODE
 . S ITM=0
 . F  S ITM=$O(^TMP("GMPLIST",$J,ITM)) Q:'ITM!(GMPLQT)  D
 .. S CODE=$P(^TMP("GMPLIST",$J,ITM),U,4) Q:'$L(CODE)
 .. I '$$STATCHK^ICDAPIU(CODE,DT) S GMPLQT=1 Q
 . I 'GMPLQT Q  ;no inactive codes in the category
 . D FULL^VALM1
 . W !!,$C(7),"This Group contains problems with inactive ICD9 codes associated with them."
 . W !,"The codes must be edited and corrected before the group can be saved."
 . N DIR,DUOUT,DTOUT,DIRUT
 . S DIR(0)="E" D ^DIR
 . S VALMBCK="R",GMPLQT=1
 . Q
 ;
 I '$D(GMPLGRP),$D(GMPLSLST) D  I GMPLQT Q
 . N GRP
 . S GRP=0
 . F  S GRP=$O(^TMP("GMPLIST",$J,"GRP",GRP)) Q:'GRP!(GMPLQT)  D
 .. I $$VALGRP(GRP) Q  ;no inactive codes in the GROUP
 .. S GMPLQT=1
 . I 'GMPLQT Q  ; all groups and problems OK
 . D FULL^VALM1
 . W !!,$C(7),"This Selection List contains problems with inactive ICD9 codes associated with"
 . W !,"them. The codes must be edited and corrected before the list can be saved."
 . N DIR,DUOUT,DTOUT,DIRUT
 . S DIR(0)="E" D ^DIR
 . S VALMBCK="R",GMPLQT=1
 . Q
 W !!,"Saving ..."
 S DA=0,LABEL=$S($D(GMPLGRP):"SAVGRP",1:"SAVLST")
 F  S DA=$O(^TMP("GMPLIST",$J,DA)) Q:+DA'>0  D @LABEL
 K GMPLSAVE S:$D(GMPLGRP) GMPSAVED=1
 S VALMBCK="Q" W " done." H 1
 Q
SAVGRP ; Save changes to existing group
 N DIK,DIE,DR,ITEM,TMPITEM
 S DIK="^GMPL(125.12,"
 I +DA'=DA D  Q
 . Q:"@"[$G(^TMP("GMPLIST",$J,DA))  ; nothing to save
 . S TMPITEM=^TMP("GMPLIST",$J,DA) D NEW(DIK,+GMPLGRP,TMPITEM)
 I "@"[$G(^TMP("GMPLIST",$J,DA)) D ^DIK Q
 S ITEM=$P($G(^GMPL(125.12,DA,0)),U,2,5)
 I ITEM'=^TMP("GMPLIST",$J,DA) D
 . S DR="",DIE=DIK
 . F I=1:1:4 D
 .. S:$P(^TMP("GMPLIST",$J,DA),U,I)'=$P(ITEM,U,I) DR=DR_";"_I_"////"_$S($P(^TMP("GMPLIST",$J,DA),U,I)="":"@",1:$P(^TMP("GMPLIST",$J,DA),U,I))
 . S:$E(DR)=";" DR=$E(DR,2,999) D ^DIE
 Q
 ;
SAVLST ; Save changes to existing list
 N DIK,DIE,DR,ITEM,TMPLST
 S DIK="^GMPL(125.1,"
 I +DA'=DA D  Q  ; new link
 . Q:"@"[$G(^TMP("GMPLIST",$J,DA))  ; nothing to save
 . S TMPLST=^TMP("GMPLIST",$J,DA) D NEW(DIK,+GMPLSLST,TMPLST)
 I "@"[$G(^TMP("GMPLIST",$J,DA)) D ^DIK Q
 S ITEM=$P($G(^GMPL(125.1,DA,0)),U,2,5)
 I ITEM'=^TMP("GMPLIST",$J,DA) D
 . S DR="",DIE=DIK
 . F I=1,2,3,4 D
 .. S:$P(^TMP("GMPLIST",$J,DA),U,I)'=$P(ITEM,U,I) DR=DR_";"_I_"////"_$S($P(^TMP("GMPLIST",$J,DA),U,I)="":"@",1:$P(^TMP("GMPLIST",$J,DA),U,I))
 . S:$E(DR)=";" DR=$E(DR,2,999) D ^DIE
 Q
 ;
NEW(DIK,LIST,ITEM) ; Create new entry in Contents file #125.1 or #125.12
 N I,HDR,LAST,TOTAL,DA
 S HDR=$G(@(DIK_"0)")),LAST=$P(HDR,U,3),TOTAL=$P(HDR,U,4)
 F I=(LAST+1):1 Q:'$D(@(DIK_"I,0)"))
 S DA=I,@(DIK_"DA,0)")=LIST_U_ITEM
 S $P(@(DIK_"0)"),U,3,4)=DA_U_(TOTAL+1)
 D IX1^DIK ; set Xrefs
 Q
 ;
DELETE ; Delete problem group
 N DIR,X,Y,DA,DIK,IFN S VALMBCK=$S(VALMCC:"",1:"R")
 I $D(^GMPL(125.1,"G",+GMPLGRP)) W $C(7),!!,">>>  This category belongs to at least one problem selection list!",!,"     CANNOT DELETE" H 2 Q
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Are you sure you want to delete the entire '"_$P(GMPLGRP,U,2)_"' category? "
 S DIR("?")="Enter YES to completely remove this category and all its items."
 D ^DIR Q:'Y
DEL1 ; Ok, go for it ...
 W !!,"Deleting category items ..."
 F IFN=0:0 S IFN=$O(^GMPL(125.12,"B",+GMPLGRP,IFN)) Q:IFN'>0  S DA=IFN,DIK="^GMPL(125.12," D ^DIK W "."
 S DA=+GMPLGRP,DIK="^GMPL(125.11," D ^DIK W "."
 L -^GMPL(125.11,+GMPLGRP,0) S GMPLGRP=0 K GMPLSAVE W " <done>"
 D NEWGRP S:+GMPLGRP'>0 VALMBCK="Q"
 Q
 ;
VALGRP(GMPLCAT) ; check all problems in the category for inactive codes
 ; Input:
 ;    GMPLCAT  = ien from file 125.11
 ;
 ; Output:
 ;    1     = category has no problems with inactive codes
 ;    0     = category has one or more problems with inactive codes
 ;    O^ERR = category is invalid^error message
 ;
 I '$G(GMPLCAT) Q "0^No category selected"
 N PROB,GMPLVALC
 S GMPLVALC=1,PROB=0
 F  S PROB=$O(^GMPL(125.12,"B",GMPLCAT,PROB)) Q:'PROB!('GMPLVALC)  D
 . N GMPLCOD
 . S GMPLCOD=$P(^GMPL(125.12,PROB,0),U,5)
 . Q:'$L(GMPLCOD)  ; no code there
 . I '$$STATCHK^ICDAPIU(GMPLCOD,DT) S GMPLVALC=0
 . Q
 Q GMPLVALC
 ;
VALLIST(LIST) ;check all categories in list for probs w/ inactive codes
 ; Input:
 ;   LIST = ien from file 125
 ;
 ; Output:
 ;    1     = list has no problems with inactive codes
 ;    0     = list has one or more problems with inactive codes
 ;    O^ERR = list is invalid^error message 
 ;
 N GMPLIEN,GMPLVAL
 I '$G(LIST) Q 0
 S GMPLIEN=0,GMPLVAL=1
 F  S GMPLIEN=$O(^GMPL(125.1,"B",LIST,GMPLIEN)) Q:'GMPLIEN!('GMPLVAL)  D
 . N GMPLCAT
 . S GMPLCAT=$P(^GMPL(125.1,GMPLIEN,0),U,3) I 'GMPLCAT Q
 . I '$$VALGRP(GMPLCAT) S GMPLVAL=0
 . Q
 Q GMPLVAL
 ;
ASSIGN ; allow lookup of PROB SEL LIST and assign to users
 ;
 N DIC,X,Y,DUOUT,DTOUT,GMPLSLST
 S DIC="^GMPL(125,",DIC(0)="AEQMZ",DIC("A")="Select LIST NAME: "
 D ^DIC
 Q:$D(DTOUT)!($D(DUOUT))
 Q:Y<0
 I '$$VALLIST(+Y) D  G ASSIGN
 . W !!,$C(7),"This Selection List contains problems with inactive ICD9 codes associated with"
 . W !,"them. The codes must be edited and corrected before the list can be assigned to",!,"users.",!!
 ;
 S GMPLSLST=+Y
 D USERS^GMPLBLD3("1")
 Q
