GMPLBLD2 ; SLC/MKB,JFR,TC -- Bld PL Selection Lists cont ;07/19/17  13:32
 ;;2.0;Problem List;**3,28,36,42,49**;Aug 25, 1994;Build 43
 ;
 ; External References:
 ;   ICR  2053   $$FILE^DIE,$$UPDATE^DIE
 ;   ICR  2336   $$GETENT,$$EDIT,$$EDITPAR^XPAREDIT
 ;   ICR  4083   $$STATCHK^LEXSRC2
 ;   ICR  5747   $$CODECS^ICDEX,$$STATCHK^ICDEX
 ;   ICR  10103  $$DT^XLFDT
 ;   ICR  10006  ^DIC
 ;   ICR  10013  ^DIK
 ;   ICR  10026  ^DIR
 ;   ICR  10116  FULL^VALM1
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
 N DIC,X,Y,DLAYGO,GMPDT ; L = "" or "L", if LAYGO is [not] allowed
 S GMPDT=$$DT^XLFDT
 S DIC="^GMPL(125.11,",DIC(0)="AEQMZ"_L,DIC("A")="Select CATEGORY NAME: "
 I DIC(0)["L" S DLAYGO=125.11,DIC("DR")=".02////"_GMPDT_";.03",DIC("?N","125.11")=6
 E  S DIC("S")="I $P(^(0),U,3)'=""N"""
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
 N DIC,X,Y,DLAYGO,GMPDT ; L="" or "L" if LAYGO [not] allowed
 S GMPDT=$$DT^XLFDT
 S DIC="^GMPL(125,",DIC(0)="AEQMZ"_L,DIC("A")="Select LIST NAME: "
 S:DIC(0)["L" DLAYGO=125,DIC("DR")=".02////"_GMPDT_";.04"
 D ^DIC S:Y<0!($D(DTOUT))!($D(DUOUT)) Y="^" S:Y'="^" Y=+Y_U_Y(0)
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
 N GMPLQT,LABEL,DA,GMPDT
 S GMPLQT=0,GMPDT=$$DT^XLFDT
 I $D(GMPLGRP) D  I GMPLQT Q
 . N ITM,CODE
 . S ITM=0
 . F  S ITM=$O(^TMP("GMPLIST",$J,ITM)) Q:'ITM!(GMPLQT)  D
 .. N GMI,GMPSCTC
 .. S GMPSCTC=$P(^TMP("GMPLIST",$J,ITM),U,5) Q:'$L(GMPSCTC)
 .. I '$$STATCHK^LEXSRC2(GMPSCTC,GMPDT,"","SCT") S GMPLQT=1 Q
 .. S CODE=$P(^TMP("GMPLIST",$J,ITM),U,4) Q:'$L(CODE)
 .. F GMI=1:1:$L(CODE,"/") D
 ... N GMPLCPTR S GMPLCPTR=$P($$CODECS^ICDEX($P(CODE,"/",GMI),80,GMPDT),U)
 ... I '$$STATCHK^ICDEX($P(CODE,"/",GMI),GMPDT,GMPLCPTR) S GMPLQT=1 Q
 . I 'GMPLQT Q  ;no inactive codes in the category
 . D FULL^VALM1
 . W !!,$C(7),"This Group contains problems with inactive SNOMED or ICD codes associated"
 . W !,"with them. The codes must be edited and corrected before the group can be saved."
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
 . W !!,$C(7),"This Selection List contains problems with inactive SNOMED or ICD codes"
 . W !,"associated with them. The codes must be edited and corrected before the"
 . W !,"list can be saved."
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
 N I,DIK,ITEM,TMPITEM,GMPJ,GMPFDA,GMPERR,GMPSFN,GMPLTXT
 S DA(1)=+GMPLGRP,DIK="^GMPL(125.11,"_DA(1)_",1,"
 S GMPSFN="125.111"
 I +DA'=DA D  Q
 . Q:"@"[$G(^TMP("GMPLIST",$J,DA))  ; nothing to save
 . S TMPITEM=^TMP("GMPLIST",$J,DA) D NEW(GMPSFN,+GMPLGRP,TMPITEM)
 I "@"[$G(^TMP("GMPLIST",$J,DA)) D ^DIK Q
 S ITEM=$G(^GMPL(125.11,+GMPLGRP,1,DA,0))
 I ITEM'=^TMP("GMPLIST",$J,DA) D
 . F I=1:1:6 D
 .. S GMPJ=$S(I=1:".01",I=2:".02",I=3:".03",I=4:".04",I=5:".05",1:".06")
 .. Q:$P(^TMP("GMPLIST",$J,DA),U,I)=$P(ITEM,U,I)
 .. S GMPFDA(125.111,""_DA_","_+GMPLGRP_",",GMPJ)=$S($P(^TMP("GMPLIST",$J,DA),U,I)="":"@",1:$P(^TMP("GMPLIST",$J,DA),U,I))
 . D FILE^DIE("K","GMPFDA","GMPERR")
 I $D(GMPERR) D
 . S GMPLTXT(1)="Error updating Rec #"_+GMPLGRP_", Sub-rec #"_DA_"."
 . S GMPLTXT(2)="Error "_GMPERR("DIERR",1)_": "_GMPERR("DIERR",1,"TEXT",1)
 . D EN^DDIOL(.GMPLTXT)
 Q
 ;
SAVLST ; Save changes to existing list
 N I,DIK,ITEM,TMPLST,GMPJ,GMPFDA,GMPERR,GMPSFN
 S DA(1)=+GMPLSLST,DIK="^GMPL(125,"_DA(1)_",1,"
 S GMPSFN="125.01"
 I +DA'=DA D  Q  ; new link
 . Q:"@"[$G(^TMP("GMPLIST",$J,DA))  ; nothing to save
 . S TMPLST=^TMP("GMPLIST",$J,DA) D NEW(GMPSFN,+GMPLSLST,TMPLST)
 I "@"[$G(^TMP("GMPLIST",$J,DA)) D ^DIK Q
 S ITEM=$G(^GMPL(125,+GMPLSLST,1,DA,0))
 I ITEM'=^TMP("GMPLIST",$J,DA) D
 . F I=1:1:4 D
 .. S GMPJ=$S(I=1:".01",I=2:".02",I=3:".03",1:".04")
 .. Q:$P(^TMP("GMPLIST",$J,DA),U,I)=$P(ITEM,U,I)
 .. S GMPFDA(125.01,""_DA_","_+GMPLSLST_",",GMPJ)=$S($P(^TMP("GMPLIST",$J,DA),U,I)="":"@",1:$P(^TMP("GMPLIST",$J,DA),U,I))
 . D FILE^DIE("K","GMPFDA","GMPERR")
 I $D(GMPERR) D
 . S GMPLTXT(1)="Error updating Rec #"_+GMPLSLST_", Sub-rec #"_DA_"."
 . S GMPLTXT(2)="Error "_GMPERR("DIERR",1)_": "_GMPERR("DIERR",1,"TEXT",1)
 . D EN^DDIOL(.GMPLTXT)
 Q
 ;
NEW(GMPSFN,LIST,ITEM) ; Create new contents entry in subfile #125.01 or #125.111
 N I,GMPFDA,GMPJ,GMPNF,GMPERR,GMPFILE
 S GMPFILE=$S(GMPSFN="125.01":"125",1:"125.11")
 S GMPNF=$S(GMPSFN="125.01":4,1:6)
 F I=1:1:GMPNF D
 . S GMPJ=$S(I=1:".01",I=2:".02",I=3:".03",I=4:".04",I=5:".05",1:".06")
 . S GMPFDA(GMPSFN,"+2,"_LIST_",",GMPJ)=$P(ITEM,U,I)
 L +^GMPL(GMPFILE,LIST):5 I '$T D  Q
 . W !,"Lock Error: error updating record #"_LIST_" in File #"_GMPFILE_"."
 D UPDATE^DIE("","GMPFDA","","GMPERR")
 L -^GMPL(GMPFILE,LIST)
 Q
 ;
DELETE ; Delete problem group
 N DIR,X,Y,DA,DIK,IFN,GMPLSEQ,GMPLDA S VALMBCK=$S(VALMCC:"",1:"R")
 I $P($G(GMPLGRP),U,4)="N" W !!,"Cannot make edits to a National category." H 2 Q
 I $D(^GMPL(125,"AC",+GMPLGRP)) W $C(7),!!,">>>  This category belongs to at least one problem selection list!",!,"     CANNOT DELETE" H 2 Q
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Are you sure you want to delete the entire '"_$P(GMPLGRP,U,2)_"' category? "
 S DIR("?")="Enter YES to completely remove this category and all its items."
 D ^DIR Q:'Y
DEL1 ; Ok, go for it ...
 W !!,"Deleting category items ..."
 S (GMPLSEQ,GMPLDA)=0
 F  S GMPLSEQ=$O(^GMPL(125.11,"C",+GMPLGRP,GMPLSEQ)) Q:'GMPLSEQ  D
 . F  S GMPLDA=$O(^GMPL(125.11,"C",+GMPLGRP,GMPLSEQ,GMPLDA)) Q:'GMPLDA  D
 . . S DA(1)=+GMPLGRP,DA=GMPLDA,DIK="^GMPL(125.11,"_DA(1)_",1," D ^DIK W "."
 . K ^GMPL(125.11,+GMPLGRP,1,0)
 S DA=+GMPLGRP,DIK="^GMPL(125.11," D ^DIK W "."
 L -^GMPL(125.11,+GMPLGRP,0) S GMPLGRP=0 K GMPLSAVE W " <done>"
 D NEWGRP S:+GMPLGRP'>0 VALMBCK="Q"
 Q
 ;
VALGRP(GMPLCAT,GMPLCODE) ; check all problems in the category for inactive SNOMED/ICD codes
 ; Input:
 ;    GMPLCAT  = ien from file 125.11
 ;    GMPLCODE = Name of array where the categories & probs w/inactive codes are stored (Optional)
 ;
 ; Output:
 ;    1     = category has no problems with inactive codes
 ;    0     = category has one or more problems with inactive codes
 ;    0^GMPLCODE = category has one or more problems with inactive codes^array w/inactive codes
 ;    0^ERR = category is invalid^error message
 ;
 ; Array format (if returned):
 ;    GMPLCODE(Category Name, Problem Sequence)=Display Text^(ICD-9/10-CM Code)^Inactive coding system (ICD,SCT,SCT/ICD)
 ;
 I '$G(GMPLCAT) Q "0^No category selected"
 N GMPLSEQ,GMPLVALC,GMPLDA,GMPDT,GMPLCNME
 S GMPLVALC=1,(GMPLSEQ,GMPLDA)=0,GMPDT=$$DT^XLFDT
 S GMPLCNME=$$GET1^DIQ(125.11,GMPLCAT,.01)
 F  S GMPLSEQ=$O(^GMPL(125.11,"C",GMPLCAT,GMPLSEQ)) Q:'GMPLSEQ  D
 . F  S GMPLDA=$O(^GMPL(125.11,"C",GMPLCAT,GMPLSEQ,GMPLDA)) Q:'GMPLDA  D
 . . N GMPLICD,GMPLSCTC,GMI,GMPLX,GMPSCT,GMPICD
 . . N GMPLICDS,GMPLCLBL,GMPLCPTR,GMPCSYS,GMPLDTXT
 . . S (GMPSCT,GMPICD)=0
 . . S GMPLX=$G(^GMPL(125.11,GMPLCAT,1,GMPLDA,0))
 . . S GMPLDTXT=$P(GMPLX,U,3)
 . . S GMPLICD=$P(GMPLX,U,4),GMPLSCTC=$P(GMPLX,U,5)
 . . Q:'$L(GMPLICD)&('$L(GMPLSCTC))  ; no code there
 . . I $L(GMPLSCTC) D
 . . . I '$$STATCHK^LEXSRC2(GMPLSCTC,GMPDT,"","SCT") S GMPLVALC=0,GMPSCT=1
 . . S GMPLICDS=$$CODECS^ICDEX($P(GMPLICD,"/"),80,GMPDT)
 . . S GMPLCPTR=$P(GMPLICDS,U),GMPLCLBL=$P(GMPLICDS,U,2)
 . . I $L(GMPLICD) D
 . . . F GMI=1:1:$L(GMPLICD,"/") D
 . . . . I '$$STATCHK^ICDEX($P(GMPLICD,"/",GMI),GMPDT,GMPLCPTR) S GMPLVALC=0,GMPICD=1
 . . I $D(GMPLCODE),(GMPSCT!GMPICD) D
 . . . S GMPCSYS=$S((GMPSCT&GMPICD):"SCT/ICD",GMPSCT:"SCT",GMPICD:"ICD",1:"")
 . . . S @GMPLCODE@(GMPLCNME,GMPLSEQ)=GMPLDTXT_U_"("_GMPLCLBL_" "_GMPLICD_")"_U_GMPCSYS
 . Q
 I $D(GMPLCODE),('GMPLVALC) S GMPLVALC=GMPLVALC_U_GMPLCODE
 Q GMPLVALC
 ;
VALLIST(LIST,GMPLCODE) ;check all categories in list for probs w/ inactive SNOMED/ICD codes
 ; Input:
 ;   LIST = ien from file 125
 ;   GMPLCODE = Name of array where the categories & probs w/inactive codes are stored (Optional)
 ;
 ; Output:
 ;    1     = list has no problems with inactive codes
 ;    0     = list has one or more problems with inactive codes
 ;    0^GMPLCODE = list has one or more problems with inactive codes^array w/inactive codes
 ;    O^ERR = list is invalid^error message
 ;
 ; Array format (if returned):
 ;    GMPLCODE(Category Name, Problem Sequence)=Display Text^(ICD-9/10-CM Code)^Inactive coding system (ICD,SCT,SCT/ICD)
 ;
 N GMPLIEN,GMPLVAL
 I '$G(LIST) Q 0
 S GMPLCAT=0,GMPLVAL=1
 F  S GMPLCAT=$O(^GMPL(125,LIST,1,"B",GMPLCAT)) Q:'GMPLCAT  D
 . I $D(GMPLCODE) D
 . . I '$$VALGRP(GMPLCAT,GMPLCODE) S GMPLVAL=0
 . E  I '$$VALGRP(GMPLCAT) S GMPLVAL=0
 . Q
 I $D(GMPLCODE) S GMPLVAL=GMPLVAL_U_GMPLCODE
 Q GMPLVAL
 ;
ASSIGN ; assign or remove selection list to users/clinic
 ;
 N GMPLENT,GMPLPAR,GMPJUST1,GMPLDTXT
 I $D(VALMCC) D FULL^VALM1
 S GMPLPAR=$$FIND1^DIC(8989.51,,"BX","ORQQPL SELECTION LIST")
 I $D(GMPLPAR) S GMPLDTXT=$$GET1^DIQ(8989.51,GMPLPAR,.02),GMPLPAR=GMPLPAR_U_GMPLDTXT
 F  D GETENT^XPAREDIT(.GMPLENT,GMPLPAR,.GMPJUST1) Q:'GMPLENT  D EDIT^XPAREDIT(GMPLENT,GMPLPAR) Q:GMPJUST1
 I $D(VALMCC) S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
