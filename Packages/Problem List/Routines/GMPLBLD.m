GMPLBLD ; SLC/MKB/TC -- Build Problem Selection Lists ;02/22/17  14:07
 ;;2.0;Problem List;**3,28,33,36,42,49**;Aug 25, 1994;Build 43
 ;
 ; External References:
 ;   ICR  2056   $$GET1^DIQ
 ;   ICR  4083   $$STATCHK^LEXSRC2
 ;   ICR  5747   $$CODECS^ICDEX,$$STATCHK^ICDEX
 ;   ICR  10026  ^DIR
 ;   ICR  10103  $$DT^XLFDT,$$FMTE^XLFDT
 ;   ICR  10116  FULL^VALM1
 ;   ICR  10117  CNTRL^VALM10
 ;   ICR  10118  EN^VALM
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
 ;D LENGTH
 Q
 ;
GETLIST ; Build ^TMP("GMPLIST",$J,#)
 N GRP,ITEM,CNT,GMPLDA K ^TMP("GMPLIST",$J) S CNT=0,(GMPLDA,GMPLCSQ)=""
 W !,"Searching for the list ..."
 F  S GMPLCSQ=$O(^GMPL(125,"AD",+GMPLSLST,GMPLCSQ)) Q:'GMPLCSQ  D
 . F  S GMPLDA=$O(^GMPL(125,"AD",+GMPLSLST,GMPLCSQ,GMPLDA)) Q:GMPLDA'>0  D
 . . S ITEM=$G(^GMPL(125,+GMPLSLST,1,GMPLDA,0)),GRP=$P(ITEM,U,1)
 . . S ^TMP("GMPLIST",$J,GMPLDA)=$G(ITEM),CNT=CNT+1 ; group ^ seq ^ subhdr ^ probs
 . . S (^TMP("GMPLIST",$J,"GRP",GRP),^TMP("GMPLIST",$J,"SEQ",GMPLCSQ))=GMPLDA
 S ^TMP("GMPLIST",$J,0)=CNT
 Q
 ;
BUILD(LIST,MODE) ; Build ^TMP("GMPLST",$J,)
 N LCNT,NUM,HDR,GROUP,GMPSEQ,ITEM,IFN,PSEQ,GMPIFN,GMPLCSQ,GMPDT,GMPCLASS,GMPLSHDR,GMPLCOL D CLEAN^VALM10
 S:'$D(^TMP("GMPLIST",$J,0)) ^TMP("GMPLIST",$J,0)=0
 I $P($G(^TMP("GMPLIST",$J,0)),U,1)'>0 S ^TMP("GMPLST",$J,1,0)="   ",^TMP("GMPLST",$J,2,0)="No items available.",^TMP("GMPLST",$J,0)="0^2",VALMCNT=2 Q
 S (LCNT,NUM,GMPSEQ)=0,GMPDT=$$DT^XLFDT
 F  S GMPSEQ=$O(^TMP("GMPLIST",$J,"SEQ",GMPSEQ)) Q:GMPSEQ'>0  D
 . S GMPIFN=^TMP("GMPLIST",$J,"SEQ",GMPSEQ),LCNT=LCNT+1,NUM=NUM+1
 . S GROUP=$P(^TMP("GMPLIST",$J,GMPIFN),U,1),GMPLCSQ=$P(^TMP("GMPLIST",$J,GMPIFN),U,2)
 . S HDR=$P(^TMP("GMPLIST",$J,GMPIFN),U,3),GMPCLASS=$$GET1^DIQ(125.11,""_GROUP_",",.03)
 . S:'$L(HDR) HDR="<no header>"
 . S HDR=HDR_"   ("_GMPCLASS_")"
 . I LCNT>1,+$P(^TMP("GMPLIST",$J,GMPIFN),U,4),^TMP("GMPLST",$J,LCNT-1,0)'="   " S LCNT=LCNT+1,^TMP("GMPLST",$J,LCNT,0)="   "
 . S GMPLSHDR=$J(NUM,3)_" "_HDR
 . S ^TMP("GMPLST",$J,LCNT,0)=$S(MODE="I":"<"_GMPLCSQ_">",1:"   ")_GMPLSHDR,^TMP("GMPLST",$J,"B",NUM)=GMPIFN
 . S GMPLCOL=(($L(^TMP("GMPLST",$J,LCNT,0)))-($L(GMPLSHDR)))+1
 . D CNTRL^VALM10(LCNT,GMPLCOL,$L(GMPLSHDR),IOINHI,IOINORM)
 . Q:'+$P(^TMP("GMPLIST",$J,GMPIFN),U,4)
 . D CNTRL^VALM10(LCNT,8,$L(HDR),IOUON,IOUOFF)
 . F PSEQ=0:0 S PSEQ=$O(^GMPL(125.11,"C",+GROUP,PSEQ)) Q:PSEQ'>0  D
 .. N GMPCSYS,GMPLSCT,GMPLICD,GMPSCTC,GMPICD,GMPDTXT S (GMPLSCT,GMPLICD)=0
 .. S IFN=$O(^GMPL(125.11,"C",+GROUP,PSEQ,0)),LCNT=LCNT+1
 .. S ITEM=$G(^GMPL(125.11,+GROUP,1,IFN,0)),GMPDTXT=$P(ITEM,U,3)
 .. S GMPSCTC=$P(ITEM,U,5),GMPICD=$P(ITEM,U,4)
 .. S ^TMP("GMPLST",$J,LCNT,0)="       "_GMPDTXT
 .. I $L(GMPSCTC) D
 ... I $$STATCHK^LEXSRC2(GMPSCTC,GMPDT,"","SCT") Q
 ... S GMPLSCT=1
 .. I $L(GMPICD) D
 ... N GMI,GMPCSPTR,GMPCSREC,GMPCSNME
 ... S GMPCSREC=$$CODECS^ICDEX($P(GMPICD,"/"),80,GMPDT),GMPCSPTR=$P(GMPCSREC,U),GMPCSNME=$P(GMPCSREC,U,2)
 ... S ^TMP("GMPLST",$J,LCNT,0)=^TMP("GMPLST",$J,LCNT,0)_" ("_GMPCSNME_" "_GMPICD_")"
 ... F GMI=1:1:$L(GMPICD,"/") D
 .... I $$STATCHK^ICDEX($P(GMPICD,"/",GMI),GMPDT,GMPCSPTR) Q  ; code is active
 .... S GMPLICD=1
 .. S GMPCSYS=$S(GMPLSCT:"SCT",GMPLICD:"ICD",(GMPLSCT&GMPLICD):"SCT/ICD",1:"")
 .. S:GMPCSYS'="" ^TMP("GMPLST",$J,LCNT,0)=^TMP("GMPLST",$J,LCNT,0)_"    <INACTIVE "_GMPCSYS_" CODE>"
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
 N GMPDT
 I $D(GMPLSAVE),$$CKSAVE^GMPLBLD2 D
 . S GMPDT=$$DT^XLFDT
 . D SAVE^GMPLBLD2
 . S ^GMPL(125,+GMPLSLST,0)=$P(GMPLSLST,U,2)_U_GMPDT_U_$P(GMPLSLST,U,4)_U_$P(GMPLSLST,U,5)
 L -^GMPL(125,+GMPLSLST,0)
 K GMPLIST,GMPLST,GMPLMODE,GMPLSLST,GMPLSAVE,GMPREBLD,GMPQUIT,RT,TMPLST
 K ^TMP("GMPLIST",$J),^TMP("GMPLST",$J)
 Q
 ;
ADD ; Add group(s)
 N SEQ,GROUP,HDR,IFN,GMPQUIT,GMPREBLD D FULL^VALM1
 I $P($G(GMPLSLST),U,5)="N" W !!,"Cannot make edits to a National list." H 2 G ADQ
 F  D  Q:$D(GMPQUIT)  W !
 . S GROUP=$$GROUP^GMPLBLD2("") I GROUP="^" S GMPQUIT=1 Q
 . I $P(GROUP,U,4)="N" D  Q
 . . W !!,"Cannot add a National category to a list. Please use the Copy to New Category"
 . . W !,"menu action under the Enter/Edit Category menu to copy into a local category."
 . . H 2 G ADQ
 . I $D(^TMP("GMPLIST",$J,"GRP",+GROUP)) W !?4,">>>  This category is already part of this list!" Q
 . I '$$VALGRP^GMPLBLD2(+GROUP) D  Q
 . . D FULL^VALM1
 . . W !!,$C(7),"This category contains one or more problems with inactive SNOMED and/or ICD"
 . . W !,"codes. These codes must be updated before adding the category to a selection"
 . . W !,"list."
 . . N DIR,DTOUT,DIRUT,DUOUT,X,Y
 . . S DIR(0)="E" D ^DIR
 . . S VALMBCK="R"
 . S HDR=$$HDR^GMPLBLD1($P(GROUP,U,2)) I HDR="^" S GMPQUIT=1 Q
 . S RT="^TMP(""GMPLIST"",$J,""SEQ"",",SEQ=+$$LAST^GMPLBLD2(RT)+1
 . S SEQ=$$SEQ^GMPLBLD1(SEQ) I SEQ="^" S GMPQUIT=1 Q
 . S IFN=$$TMPIFN^GMPLBLD1,^TMP("GMPLIST",$J,IFN)=+GROUP_U_SEQ_U_HDR_"^1"
 . S (^TMP("GMPLIST",$J,"GRP",+GROUP),^TMP("GMPLIST",$J,"SEQ",SEQ))=IFN,^TMP("GMPLIST",$J,0)=^TMP("GMPLIST",$J,0)+1,GMPREBLD=1
 I $D(GMPREBLD) S VALMBCK="R",GMPLSAVE=1 D BUILD("^TMP(""GMPLIST"",$J)",GMPLMODE),HDR
ADQ S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
 ;
EDIT ; Edit category contents
 N GMPLIST,GMPLST,GMPLMODE,GMPLGRP,GMPLSAVE
 I $P($G(GMPLSLST),U,5)="N" W !!,"Cannot make edits to a National list." H 2 G EDQ
 D EN^VALM("GMPL SELECTION GROUP BUILD")
 S GMPLMODE="E"
 D GETLIST,BUILD("TMP(""GMPLIST"",$J)",GMPLMODE)
EDQ S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
 ;
REMOVE ; Remove group
 N NUM,IFN,SEQ,GRP,DIR,X,Y,GMPLCIEN S VALMBCK=""
 I $P($G(GMPLSLST),U,5)="N" W !!,"Cannot make edits to a National list." H 2 G RMQ
 S NUM=$$SEL1^GMPLBLD1 G:NUM="^" RMQ
 S IFN=$G(^TMP("GMPLST",$J,"B",NUM)) G:+IFN'>0 RMQ
 S GMPLCIEN=$P($G(^TMP("GMPLIST",$J,IFN)),U,1)
 I "@"[$G(^TMP("GMPLIST",$J,IFN)) W $C(7),!!,"Category is not part of this list!" H 2 G RMQ
 I $P(^GMPL(125.11,GMPLCIEN,0),U,3)="N",($P($G(GMPLSLST),U,5)="N") W $C(7),!!,"Category may not be removed from this National list!" H 2 G RMQ
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
