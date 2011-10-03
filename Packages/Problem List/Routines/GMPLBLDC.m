GMPLBLDC ; SLC/MKB -- Build Problem Selection Categories ;3/12/03 9:22
 ;;2.0;Problem List;**3,7,28**;Aug 25, 1994
 ;
 ; This routine invokes IA #3991
 ;
EN ; -- main entry point for GMPL SELECTION GROUP BUILD
 D EN^VALM("GMPL SELECTION GROUP BUILD")
 Q
 ;
HDR ; -- header code
 N NAME,NUM,DATE S NUM=+^TMP("GMPLST",$J,0)_" problem"_$S(+^TMP("GMPLST",$J,0)'=1:"s",1:"")
 S DATE="Last Modified: "_$S(+$P(GMPLGRP,U,3):$$FMTE^XLFDT($P(GMPLGRP,U,3)),1:"<new category>")
 S VALMHDR(1)=DATE_$J(NUM,79-$L(DATE))
 S NAME=$P(GMPLGRP,U,2),VALMHDR(2)=$J(NAME,$L(NAME)\2+41)
 Q
 ;
INIT ; -- init variables and list array
 S GMPLGRP=$$GROUP^GMPLBLD2("L") I GMPLGRP="^" S VALMQUIT=1 Q
 L +^GMPL(125.11,+GMPLGRP,0):1 I '$T D  G INIT
 . W $C(7),!!,"This category is currently being edited by another user!",!
 S GMPLMODE="E",VALMSG=$$MSG^GMPLX
 D GETLIST,BUILD("^TMP(""GMPLIST"",$J)",GMPLMODE)
 Q
 ;
GETLIST ; Build ^TMP("GMPLIST",$J,#) of problems
 N SEQ,IFN,ITEM,PROB,CNT K ^TMP("GMPLIST",$J) S CNT=0
 W !,"Searching for the problems ..."
 F IFN=0:0 S IFN=$O(^GMPL(125.12,"B",+GMPLGRP,IFN)) Q:IFN'>0  D
 . S ITEM=$G(^GMPL(125.12,IFN,0)),SEQ=$P(ITEM,U,2),PROB=$P(ITEM,U,3)
 . S ^TMP("GMPLIST",$J,IFN)=$P(ITEM,U,2,5),CNT=CNT+1 ; seq ^ prob ^ text ^ code
 . S (^TMP("GMPLIST",$J,"PROB",PROB),^TMP("GMPLIST",$J,"SEQ",SEQ))=IFN ; Xrefs
 S ^TMP("GMPLIST",$J,0)=CNT
 Q
 ;
BUILD(LIST,MODE) ; Build ^TMP("GMPLST",$J,) of current items in LIST for display
 N SEQ,LCNT,NUM,PROB,TEXT,IFN,ITEM,CODE D CLEAN^VALM10
 I $P($G(^TMP("GMPLIST",$J,0)),U,1)'>0 S ^TMP("GMPLST",$J,1,0)="   ",^TMP("GMPLST",$J,2,0)="No items available.",^TMP("GMPLST",$J,0)="0^2",VALMCNT=2 Q
 S (LCNT,NUM,SEQ)=0
 F  S SEQ=$O(^TMP("GMPLIST",$J,"SEQ",SEQ)) Q:SEQ'>0  D
 . S IFN=^TMP("GMPLIST",$J,"SEQ",SEQ),LCNT=LCNT+1,NUM=NUM+1
 . S PROB=$P(^TMP("GMPLIST",$J,IFN),U,2),TEXT=$P(^TMP("GMPLIST",$J,IFN),U,3),CODE=$P(^TMP("GMPLIST",$J,IFN),U,4)
 . S ^TMP("GMPLST",$J,LCNT,0)=$S(MODE="I":$J("<"_SEQ_">",8),1:"        ")_$J(NUM,4)_" "_TEXT
 . I $L(CODE) D
 .. S ^TMP("GMPLST",$J,LCNT,0)=^TMP("GMPLST",$J,LCNT,0)_" ("_CODE_")"
 .. I $$STATCHK^ICDAPIU(CODE,DT) Q  ; OK - code is active
 .. S ^TMP("GMPLST",$J,LCNT,0)=^TMP("GMPLST",$J,LCNT,0)_"     <INACTIVE CODE>"
 . D CNTRL^VALM10(LCNT,9,5,IOINHI,IOINORM)
 . S ^TMP("GMPLST",$J,"B",NUM)=IFN
 S ^TMP("GMPLST",$J,0)=NUM_U_LCNT,VALMCNT=LCNT
 Q
 ;
HELP ; -- help code
 N X
 W !!?4,"You may take a variety of actions from this prompt.  To update"
 W !?4,"this category you may add new problems or remove an existing"
 W !?4,"one; you may also change the text or code displayed, or the order"
 W !?4,"in which each problem is displayed.  Select View w/wo Seq Numbers"
 W !?4,"to toggle seeing the sequence number in addition to the display"
 W !?4,"number per problem.  If necessary, the current category may be"
 W !?4,"deleted; you may change to a different category to continue editing."
 W !!,"Press <return> to continue ..." R X:DTIME
 S VALMSG=$$MSG^GMPLX,VALMBCK=$S(VALMCC:"",1:"R")
 Q
 ;
EXIT ; -- exit code
 I $D(GMPLSAVE),$$CKSAVE^GMPLBLD2 D
 . D SAVE^GMPLBLD2
 . S ^GMPL(125.11,+GMPLGRP,0)=$P(GMPLGRP,U,2)_U_DT
 L -^GMPL(125.11,+GMPLGRP,0)
 K GMPLIST,GMPLST,GMPLMODE,GMPLGRP,GMPLSAVE,GMPREBLD,GMPQUIT,RT1,TMPITEM
 K VALMBCK,VALMCNT,VALMSG,VALMHDR
 K ^TMP("GMPLIST",$J),^TMP("GMPLST",$J)
 Q
 ;
ADD ; Add new problem(s)
 N X,Y,SEQ,CODE,IFN,GMPVOCAB,GMPQUIT,GMPREBLD S VALMBCK=""
 S GMPVOCAB=$$VOCAB^GMPLX1 Q:GMPVOCAB="^"
 F  D  Q:$D(GMPQUIT)  W !!
 . S (X,Y)="" D SEARCH^GMPLX(.X,.Y,"PROBLEM: ","1",GMPVOCAB)
 . I +Y'>0 S GMPQUIT=1 Q
 . S X=$$TEXT^GMPLBLD1(X) I X="^" S GMPQUIT=1 Q
 . S CODE=$$CODE^GMPLBLD1($G(Y(1))) I CODE="^" S GMPQUIT=1 Q
 . S RT1="^TMP(""GMPLIST"",$J,""SEQ"",",SEQ=+$$LAST^GMPLBLD2(RT1)+1 ; dflt = next #
 . S SEQ=$$SEQ^GMPLBLD1(SEQ) I SEQ="^" S GMPQUIT=1 Q
 . S IFN=$$TMPIFN^GMPLBLD1,^TMP("GMPLIST",$J,0)=^TMP("GMPLIST",$J,0)+1
 . S ^TMP("GMPLIST",$J,IFN)=SEQ_U_+Y_U_X_U_CODE ; seq ^ # ^ text ^ code
 . S (^TMP("GMPLIST",$J,"PROB",+Y),^TMP("GMPLIST",$J,"SEQ",SEQ))=IFN,GMPREBLD=1
 I $D(GMPREBLD) S VALMBCK="R",GMPLSAVE=1 D BUILD("^TMP(""GMPLIST"",$J)",GMPLMODE),HDR
 S:'VALMCC VALMBCK="R" S VALMSG=$$MSG^GMPLX
 Q
 ;
REMOVE ; Remove problem from group
 N NUM,IFN S VALMBCK=""
 S NUM=$$SEL1^GMPLBLD1 G:NUM="^" RMQ
 S IFN=$P($G(^TMP("GMPLST",$J,"B",NUM)),U,1) G:+IFN'>0 RMQ
 I "@"[$G(^TMP("GMPLIST",$J,IFN)) W $C(7),!!,"Problem does not exist in this category!" H 2 G RMQ
 I '$$SURE^GMPLX W !?5,"< Nothing removed! >" H 1 G RMQ
 D DELETE^GMPLBLD1(IFN) S VALMBCK="R",GMPLSAVE=1
 D BUILD("^TMP(""GMPLIST"",$J)",GMPLMODE),HDR
RMQ S:'VALMCC VALMBCK="R" S VALMSG=$$MSG^GMPLX
 Q
 ;
EDIT ; Edit problem text and code
 N NUM,SEL,IFN,PIECE,CODE,PROB,PROBLEM,GMPQUIT,GMPREBLD S VALMBCK=""
 S SEL=$$SEL^GMPLBLD1 G:SEL="^" EDQ
 F PIECE=1:1:$L(SEL,",") D  Q:$D(GMPQUIT)  W !
 . S NUM=$P(SEL,",",PIECE) Q:NUM'>0
 . S IFN=$P($G(^TMP("GMPLST",$J,"B",NUM)),U,1) Q:IFN'>0
 . I "@"[$G(^TMP("GMPLIST",$J,IFN)) W $C(7),!!,"Problem #"_NUM_" does not exist in this category!" H 2 Q
 . W !!,">>>  Problem #"_NUM S PROBLEM=^TMP("GMPLIST",$J,IFN)
 . W:$P(PROBLEM,U,2)>1 " = "_$G(^LEX(757.01,+$P(PROBLEM,U,2),0)) W ! ; KER
 . S PROB=$$TEXT^GMPLBLD1($P(PROBLEM,U,3)) I PROB="^" S GMPQUIT=1 Q
 . I PROB="@" D DELETE^GMPLBLD1(IFN) S GMPREBLD=1 Q
 . S CODE=$$CODE^GMPLBLD1($P(PROBLEM,U,4)) I CODE="^" S GMPQUIT=1 Q
 . S ^TMP("GMPLIST",$J,IFN)=$P(PROBLEM,U,1,2)_U_PROB_U_CODE,GMPREBLD=1
 I $D(GMPREBLD) S VALMBCK="R",GMPLSAVE=1 D BUILD("^TMP(""GMPLIST"",$J)",GMPLMODE)
EDQ S:'VALMCC VALMBCK="R" S VALMSG=$$MSG^GMPLX
 Q
