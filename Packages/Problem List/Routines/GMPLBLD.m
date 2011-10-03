GMPLBLD ; SLC/MKB -- Build Problem Selection Lists ; 3/12/03  9:31
 ;;2.0;Problem List;**3,28,33**;Aug 25, 1994
 ;
 ;This routine invokes IA #3991
 ;
EN ; -- main entry point
 D EN^VALM("GMPL SELECTION LIST BUILD")
 Q
 ;
HDR ; -- header code
 N NAME,NUM,DATE
 S NUM=+^TMP("GMPLST",$J,0)_" categor"_$S(+^TMP("GMPLST",$J,0)'=1:"ies",1:"y")
 S DATE="Last Modified: "_$S(+$P(GMPLSLST,U,3):$$FMTE^XLFDT($P(GMPLSLST,U,3)),1:"<new list>")
 S VALMHDR(1)=DATE_$J(NUM,79-$L(DATE))
 S NAME=$P(GMPLSLST,U,2),VALMHDR(2)=$J(NAME,$L(NAME)\2+41)
 Q
 ;
INIT ; -- init variables and list array
 S GMPLSLST=$$LIST^GMPLBLD2("L") I GMPLSLST="^" S VALMQUIT=1 Q
 L +^GMPL(125,+GMPLSLST,0):1 I '$T D  G INIT
 . W $C(7),!!,"This list is currently being edited by another user!",!
 S GMPLMODE="E",VALMSG=$$MSG^GMPLX
 D GETLIST,BUILD("^TMP(""GMPLIST"",$J)",GMPLMODE)
 D LENGTH
 Q
 ;
GETLIST ; Build ^TMP("GMPLIST",$J,#)
 N IFN,SEQ,GRP,ITEM,CNT K ^TMP("GMPLIST",$J) S CNT=0
 W !,"Searching for the list ..."
 F IFN=0:0 S IFN=$O(^GMPL(125.1,"B",+GMPLSLST,IFN)) Q:IFN'>0  D
 . S ITEM=$G(^GMPL(125.1,IFN,0)),SEQ=$P(ITEM,U,2),GRP=$P(ITEM,U,3)
 . S ^TMP("GMPLIST",$J,IFN)=$P(ITEM,U,2,5),CNT=CNT+1 ; seq ^ group ^ subhdr ^ probs
 . S (^TMP("GMPLIST",$J,"GRP",GRP),^TMP("GMPLIST",$J,"SEQ",SEQ))=IFN
 S ^TMP("GMPLIST",$J,0)=CNT
 Q
 ;
BUILD(LIST,MODE) ; Build ^TMP("GMPLST",$J,)
 N SEQ,LCNT,NUM,HDR,GROUP,IFN,ITEM,PSEQ D CLEAN^VALM10
 S:'$D(^TMP("GMPLIST",$J,0)) ^TMP("GMPLIST",$J,0)=0
 I $P($G(^TMP("GMPLIST",$J,0)),U,1)'>0 S ^TMP("GMPLST",$J,1,0)="   ",^TMP("GMPLST",$J,2,0)="No items available.",^TMP("GMPLST",$J,0)="0^2",VALMCNT=2 Q
 S (LCNT,NUM,SEQ)=0
 F  S SEQ=$O(^TMP("GMPLIST",$J,"SEQ",SEQ)) Q:SEQ'>0  D
 . S IFN=^TMP("GMPLIST",$J,"SEQ",SEQ),LCNT=LCNT+1,NUM=NUM+1
 . S GROUP=$P(^TMP("GMPLIST",$J,IFN),U,2),HDR=$P(^TMP("GMPLIST",$J,IFN),U,3)
 . S:'$L(HDR) HDR="<no header>"
 . I LCNT>1,+$P(^TMP("GMPLIST",$J,IFN),U,4),^TMP("GMPLST",$J,LCNT-1,0)'="   " S LCNT=LCNT+1,^TMP("GMPLST",$J,LCNT,0)="   "
 . S ^TMP("GMPLST",$J,LCNT,0)=$S(MODE="I":$J("<"_SEQ_">",8),1:"        ")_$J(NUM,4)_" "_HDR,^TMP("GMPLST",$J,"B",NUM)=IFN
 . D CNTRL^VALM10(LCNT,9,5,IOINHI,IOINORM)
 . Q:'+$P(^TMP("GMPLIST",$J,IFN),U,4)
 . D CNTRL^VALM10(LCNT,14,$L(HDR),IOUON,IOUOFF)
 . F PSEQ=0:0 S PSEQ=$O(^GMPL(125.12,"C",+GROUP,PSEQ)) Q:PSEQ'>0  D
 . . S IFN=$O(^GMPL(125.12,"C",+GROUP,PSEQ,0)),LCNT=LCNT+1
 . . S ITEM=$G(^GMPL(125.12,IFN,0)),^TMP("GMPLST",$J,LCNT,0)="             "_$P(ITEM,U,4)
 . . I $L($P(ITEM,U,5)) D
 ... S ^TMP("GMPLST",$J,LCNT,0)=^TMP("GMPLST",$J,LCNT,0)_" ("_$P(ITEM,U,5)_")"
 ... I $$STATCHK^ICDAPIU($P(ITEM,U,5),DT) Q  ; code is active
 ... S ^TMP("GMPLST",$J,LCNT,0)=^TMP("GMPLST",$J,LCNT,0)_"    <INACTIVE CODE>"
 . S LCNT=LCNT+1,^TMP("GMPLST",$J,LCNT,0)="   "
 S ^TMP("GMPLST",$J,0)=NUM_U_LCNT,VALMCNT=LCNT
 Q
 ;
HELP ; -- help code
 N X
 W !!?4,"You may take a variety of actions to update this selection list."
 W !?4,"New categories may be added to this list, or an existing one"
 W !?4,"removed; Edit Category will allow you to change the contents of"
 W !?4,"a category, or create a new one that may be added to this list."
 W !?4,"You may also change how each category appears in this list,"
 W !?4,"view each category's sequence number to facilitate resequencing,"
 W !?4,"assign this list to a clinic or user(s), or edit a different list."
 W !!,"Press <return> to continue ..." R X:DTIME
 S VALMSG=$$MSG^GMPLX,VALMBCK=$S(VALMCC:"",1:"R")
 Q
 ;
EXIT ; -- exit code
 I $D(GMPLSAVE),$$CKSAVE^GMPLBLD2 D
 . D SAVE^GMPLBLD2
 . S ^GMPL(125,+GMPLSLST,0)=$P(GMPLSLST,U,2)_U_DT_U_$P(GMPLSLST,U,4)
 L -^GMPL(125,+GMPLSLST,0)
 K GMPLIST,GMPLST,GMPLMODE,GMPLSLST,GMPLSAVE,GMPREBLD,GMPQUIT,RT,TMPLST
 K ^TMP("GMPLIST",$J),^TMP("GMPLST",$J)
 Q
 ;
ADD ; Add group(s)
 N SEQ,GROUP,HDR,IFN,GMPQUIT,GMPREBLD D FULL^VALM1
 F  D  Q:$D(GMPQUIT)  W !
 . S GROUP=$$GROUP^GMPLBLD2("") I GROUP="^" S GMPQUIT=1 Q
 . I $D(^TMP("GMPLIST",$J,"GRP",+GROUP)) W !?4,">>>  This category is already part of this list!" Q
 . I '$$VALGRP^GMPLBLD2(+GROUP) D  Q
 .. D FULL^VALM1
 .. W !!,$C(7),"This category contains one or more problems with inactive ICD-9 codes. "
 .. W !,"These codes must be updated before adding the category to a selection list."
 .. N DIR,DTOUT,DIRUT,DUOUT,X,Y
 .. S DIR(0)="E" D ^DIR
 .. S VALMBCK="R"
 . S HDR=$$HDR^GMPLBLD1($P(GROUP,U,2)) I HDR="^" S GMPQUIT=1 Q
 . S RT="^TMP(""GMPLIST"",$J,""SEQ"",",SEQ=+$$LAST^GMPLBLD2(RT)+1
 . S SEQ=$$SEQ^GMPLBLD1(SEQ) I SEQ="^" S GMPQUIT=1 Q
 . S IFN=$$TMPIFN^GMPLBLD1,^TMP("GMPLIST",$J,IFN)=SEQ_U_+GROUP_U_HDR_"^1"
 . S (^TMP("GMPLIST",$J,"GRP",+GROUP),^TMP("GMPLIST",$J,"SEQ",SEQ))=IFN,^TMP("GMPLIST",$J,0)=^TMP("GMPLIST",$J,0)+1,GMPREBLD=1
 I $D(GMPREBLD) S VALMBCK="R",GMPLSAVE=1 D BUILD("^TMP(""GMPLIST"",$J)",GMPLMODE),HDR
 S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
 ;
EDIT ; Edit category contents
 N GMPLIST,GMPLST,GMPLMODE,GMPLGRP,GMPLSAVE
 D EN^VALM("GMPL SELECTION GROUP BUILD")
 S GMPLMODE="E"
 D GETLIST,BUILD("TMP(""GMPLIST"",$J)",GMPLMODE)
 S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
 ;
REMOVE ; Remove group
 N NUM,IFN,SEQ,GRP,DIR,X,Y S VALMBCK=""
 S NUM=$$SEL1^GMPLBLD1 G:NUM="^" RMQ
 S IFN=$G(^TMP("GMPLST",$J,"B",NUM)) G:+IFN'>0 RMQ
 I "@"[$G(^TMP("GMPLIST",$J,IFN)) W $C(7),!!,"Category is not part of this list!" H 2 G RMQ
 S DIR("A")="Are you sure you want to remove '"_$P(^TMP("GMPLIST",$J,IFN),U,3)_"'? "
 S DIR("?")="Enter YES to delete this category from the current list; enter NO to exit."
 S DIR(0)="YA",DIR("B")="NO" D ^DIR
 I 'Y W !?5,"< Nothing removed! >" H 1 G RMQ
 D DELETE^GMPLBLD1(IFN) S VALMBCK="R",GMPLSAVE=1
 D BUILD("^TMP(""GMPLIST"",$J)",GMPLMODE),HDR
RMQ S:'VALMCC VALMBCK="R" S VALMSG=$$MSG^GMPLX
 Q
 ;
LENGTH ;SHORTEN THE ICD9'S DESCRIPTION TO FIT SCREEN
 S LLCNT=0
 F  S LLCNT=$O(^TMP("GMPLST",$J,LLCNT)) Q:LLCNT=""  Q:LLCNT'?1N.N  D
 .; I '$D(^TMP("GMPLST",$J,LLCNT,O)) Q
 . S ICD9VAR=^TMP("GMPLST",$J,LLCNT,0) I $L(ICD9VAR)>50 D
 .. S ICD9VAR=$P(ICD9VAR,"(",1)
 .. S ICD9VAR=$E(ICD9VAR,1,50)_" ("_$P(^TMP("GMPLST",$J,LLCNT,0),"(",2)
 .. S ^TMP("GMPLST",$J,LLCNT,0)=ICD9VAR
 Q
