GMPLMENU ; SLC/MKB -- VALM Utilities for Add Menu sub-list ;5/26/94  15:55
 ;;2.0;Problem List;**11**;Aug 25, 1994
HDR ; -- header code
 N PAT,NUM,LIST S NUM=GMPLCNT_" problem(s) added"
 S PAT=$P(GMPDFN,U,2)_"  ("_$P(GMPDFN,U,3)_")"
 S VALMHDR(1)=PAT_$J(NUM,79-$L(PAT)),LIST=$P(GMPLSLST,U,2)
 S VALMHDR(2)=$J(LIST,$L(LIST)\2+41)
 Q
 ;
HELP ; -- help code
 N X,CNT S CNT=+$G(^TMP("GMPLMENU",$J,"LIST",0))
 W !!?4,"You may select one or more of the above listed items by entering"
 W !?4,"its display number (1-"_CNT_") at the prompt; if the text if followed"
 W !?4,"by '...', all problems under that heading will be displayed for"
 W !?4,"selection.  Enter AD to select a problem not listed above."
 W !?4,"If you enter a list or range of numbers to add several problems,"
 W !?4,"you will be presented with each to complete, one at a time."
 W:VALMCNT>10 !?4,"Enter + to see more items, as in the problem list."
 W !!,"Press <return> to continue ..." R X:DTIME
 S VALMSG=$$MSG,VALMBCK=$S(VALMCC:"",1:"R")
 Q
EXIT ; -- exit code
 N I F I=0:0 S I=$O(XQORM("KEY",I)) Q:I'>0  K XQORM("KEY",I)
 K ^TMP("GMPLMENU",$J),GMPLCNT
 Q
 ;
MSG() ; -- set LMgr msg bar
 Q "Enter the number of the item(s) you wish to select"
 ;
BUILD ; -- Build ^TMP("GMPLMENU",$J,"LIST") list to display
 N I,LCNT,NUM,ITEM,CODE,GRP,PROBS,ADDED
 S (GRP,NUM,LCNT)=0 D CLEAN^VALM10
 F  S GRP=$O(^TMP("GMPLMENU",$J,GRP)) Q:GRP'>0  D
 . S ITEM=$G(^TMP("GMPLMENU",$J,GRP,0)),PROBS=+$P(ITEM,U,2)
 . I 'PROBS D  Q
 . . S LCNT=LCNT+1,NUM=NUM+1,^TMP("GMPLMENU",$J,"IDX",NUM)=U_GRP_U_LCNT
 . . S ^TMP("GMPLMENU",$J,"LIST",LCNT,0)=$J(NUM,5)_" "_$P(ITEM,U)_" ..."
 . . D CNTRL^VALM10(LCNT,1,5,IOINHI,IOINORM)
BLD1 . I LCNT,^TMP("GMPLMENU",$J,"LIST",LCNT,0)'="   " S LCNT=LCNT+1,^TMP("GMPLMENU",$J,"LIST",LCNT,0)="   "
 . S:+$G(GMPLGRP)=GRP VALMBG=LCNT+1 ; start list display here
 . I $L($P(ITEM,U)) D  ; have a hdr
 . . S LCNT=LCNT+1,^TMP("GMPLMENU",$J,"LIST",LCNT,0)="      "_$P(ITEM,U)
 . . D CNTRL^VALM10(LCNT,7,$L($P(ITEM,U)),IOUON,IOUOFF)
 . S I=0 F  S I=$O(^TMP("GMPLMENU",$J,GRP,I)) Q:I'>0  D
 . . S LCNT=LCNT+1,NUM=NUM+1
 . . S ITEM=$G(^TMP("GMPLMENU",$J,GRP,I)),CODE=$P(ITEM,U,3),ADDED=+$P(ITEM,U,4) ; ITEM=term^text^code, _"^1" if added
 . . S ^TMP("GMPLMENU",$J,"LIST",LCNT,0)=$S(ADDED:" X",1:"  ")_$J(NUM,3)_" "_$P(ITEM,U,2)_$S($L(CODE):" ("_CODE_")",1:"")
 . . S ^TMP("GMPLMENU",$J,"IDX",NUM)=I_U_GRP_U_LCNT_U_ITEM
 . . D CNTRL^VALM10(LCNT,1,5,IOINHI,IOINORM)
 . S LCNT=LCNT+1,^TMP("GMPLMENU",$J,"LIST",LCNT,0)="   "
BLDQ S ^TMP("GMPLMENU",$J,"LIST",0)=NUM_U_LCNT,VALMCNT=LCNT,GMPLCNT=0,VALMSG=$$MSG
 D KEYS
 Q
 ;
KEYS ; -- setup XQORM("KEY") array for menu
 N I,PROTCL,NUM S NUM=+$G(^TMP("GMPLMENU",$J,"LIST",0))
 S PROTCL=$O(^ORD(101,"B","GMPL LIST SELECT ITEM",0))_"^1"
 F I=1:1:NUM S XQORM("KEY",I)=PROTCL
 S VALMSG=$$MSG
 Q
 ;
CK ; -- check whether to stop processing after each problem
 ; Called from exit action of GMPL LIST XXX protocols
 S:$D(GMPQUIT) XQORPOP=1 K GMPQUIT
 I $D(DTOUT)!($G(VALMBCK)="Q") S VALMBCK="Q" Q
 S VALMBCK="R",VALMSG=$$MSG
 Q
 ;
ITEM ; -- select item from menu
 N NUM,GMPROB,GMPTERM,GMPICD,GMPSAVED,LCNT,LINE,DUP,ITEM,CODE,GRP,PROB,GMPINDEX
 S NUM=+$P(XQORNOD(0),U,3) Q:NUM'>0
 S GMPINDEX=$G(^TMP("GMPLMENU",$J,"IDX",NUM)),PROB=+GMPINDEX,GRP=$P(GMPINDEX,U,2)
 I 'PROB D  Q  ; expand category
 . S ITEM=$G(^TMP("GMPLMENU",$J,+GRP,0)) S:'$D(GMPLGRP) GMPLGRP=+GRP
 . S ^TMP("GMPLMENU",$J,+GRP,0)=$P(ITEM,U)_"^1"
 S ITEM=$P(GMPINDEX,U,4,6) ; CLU^text^code
 S GMPTERM=$S(+ITEM>1:$P(ITEM,U,1,2),1:""),GMPROB=$P(ITEM,U,2)
 S CODE=$P(ITEM,U,3),GMPICD=$S('$L(CODE):"799.9",1:CODE)
 W !!!,">>>  Adding problem #"_NUM_" '"_GMPROB_"' ..."
 S DUP=$$DUPL^GMPLX(+GMPDFN,+GMPTERM,GMPROB)
 I DUP,'$$DUPLOK^GMPLX(DUP) G ITQ
 D ADD1^GMPL1
ITQ I $D(GMPSAVED) D  D HDR
 . S GMPREBLD=1,GMPLCNT=GMPLCNT+1,LCNT=+$P(GMPINDEX,U,3)
 . S LINE=$G(^TMP("GMPLMENU",$J,"LIST",LCNT,0)),^TMP("GMPLMENU",$J,"LIST",LCNT,0)=" X"_$E(LINE,3,999)
 . S ^TMP("GMPLMENU",$J,+GRP,+PROB)=ITEM_"^1" ; problem added
 Q
 ;
CLU ; -- add problem not on menu, from CLU
 N GMPSAVED W !!!,">>> Adding a problem not on the menu ..."
 W @IOF D FULL^VALM1,ADD^GMPL1 S VALMBCK="R" I $D(GMPSAVED) S GMPREBLD=1,GMPLCNT=GMPLCNT+1 K VALMHDR
 Q
