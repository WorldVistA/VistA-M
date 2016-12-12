GMPLBLDC ; SLC/MKB,TC -- Build Problem Selection Categories ;04/22/15  13:08
 ;;2.0;Problem List;**3,7,28,36,42,45**;Aug 25, 1994;Build 53
 ;
 ; This routine invokes ICR #5699, #5747
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
 . S ^TMP("GMPLIST",$J,IFN)=$P(ITEM,U,2,7),CNT=CNT+1 ; seq ^ prob ^ text ^ code ^ snomed ct concept ^ snomed ct designation
 . S (^TMP("GMPLIST",$J,"PROB",PROB),^TMP("GMPLIST",$J,"SEQ",SEQ))=IFN ; Xrefs
 S ^TMP("GMPLIST",$J,0)=CNT
 Q
 ;
BUILD(LIST,MODE) ; Build ^TMP("GMPLST",$J,) of current items in LIST for display
 N SEQ,LCNT,NUM,PROB,TEXT,IFN,ITEM,CODE D CLEAN^VALM10
 I $P($G(^TMP("GMPLIST",$J,0)),U,1)'>0 S ^TMP("GMPLST",$J,1,0)="   ",^TMP("GMPLST",$J,2,0)="No items available.",^TMP("GMPLST",$J,0)="0^2",VALMCNT=2 Q
 S (LCNT,NUM,SEQ)=0
 F  S SEQ=$O(^TMP("GMPLIST",$J,"SEQ",SEQ)) Q:SEQ'>0  D
 . N GMI,GMPLCSYS,GMPLCPTR
 . S IFN=^TMP("GMPLIST",$J,"SEQ",SEQ),LCNT=LCNT+1,NUM=NUM+1
 . S PROB=$P(^TMP("GMPLIST",$J,IFN),U,2),TEXT=$P(^TMP("GMPLIST",$J,IFN),U,3),CODE=$P(^TMP("GMPLIST",$J,IFN),U,4)
 . S ^TMP("GMPLST",$J,LCNT,0)=$S(MODE="I":$J("<"_SEQ_">",8),1:"        ")_$J(NUM,4)_" "_TEXT
 . I $L(CODE) D
 .. S ^TMP("GMPLST",$J,LCNT,0)=^TMP("GMPLST",$J,LCNT,0)_" ("_$P($$CODECS^ICDEX($P(CODE,"/"),80,DT),U,2)_" "_CODE_")"
 .. F GMI=1:1:$L(CODE,"/") D
 ... N GMPLCPTR S GMPLCPTR=$P($$CODECS^ICDEX($P(CODE,"/",GMI),80,DT),U)
 ... I $$STATCHK^ICDXCODE(GMPLCPTR,$P(CODE,"/",GMI),DT) Q  ; OK - code is active
 ... S ^TMP("GMPLST",$J,LCNT,0)=^TMP("GMPLST",$J,LCNT,0)_"     <INACTIVE CODE>"
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
 N GMPVOCAB,GMPQUIT,GMPREBLD,GMPIMPDT S VALMBCK="" D FULL^VALM1
 S GMPVOCAB="" ; $$VOCAB^GMPLX1 Q:GMPVOCAB="^"
 S GMPIMPDT=$$IMPDATE^LEXU("10D")
 F  D  Q:$D(GMPQUIT)  W !!
ASKAG . N X,Y,SEQ,CODE,IFN,SCTT,SCTC,SCTD,DUP,TERM,ICD,GMPTYP,GMPNUM,GMPQT,GMPSYN
 . S (X,Y,SCTT,SCTC,SCTD,GMPTYP,GMPNUM,GMPQT)="" D SEARCH^GMPLX(.X,.Y,"PROBLEM: ","1",GMPVOCAB)
 . I +Y'>0 S GMPQUIT=1 Q
 . S DUP=$$DUPL(.Y,X)
 . I DUP S (Y,GMPROB)="" W !,X,!,"is already on the selection list.  Please enter another search term to add." G ASKAG
 . S TERM=$S(+$G(Y)>1:Y,1:""),ICD=$G(Y(1))
 . S:'$L(ICD) ICD=$S(DT<GMPIMPDT:"799.9",1:"R69.")
 . N I,GMPSTAT,GMPCSREC,GMPCSPTR,GMPCSNME,GMPSCTC,GMPSCTD,GMPTXT
 . I ICD["/" F I=1:1:$L(ICD,"/") D  Q:GMPSTAT
 . . N GMPCODE S GMPCODE=$P(ICD,"/",I),GMPSTAT=0
 . . S GMPCSREC=$$CODECS^ICDEX(GMPCODE,80,DT),GMPCSPTR=$P(GMPCSREC,U),GMPCSNME=$P(GMPCSREC,U,2)
 . . S:'+$$STATCHK^ICDXCODE(GMPCSPTR,GMPCODE,DT) GMPSTAT=1
 . E  D
 . . S GMPSTAT=0,GMPCSREC=$$CODECS^ICDEX(ICD,80,DT),GMPCSPTR=$P(GMPCSREC,U),GMPCSNME=$P(GMPCSREC,U,2)
 . . S:'+$$STATCHK^ICDXCODE(GMPCSPTR,ICD,DT) GMPSTAT=1
 . I GMPSTAT W !,X,!,"has an inactive ICD code.  Please enter another search term to add." G ASKAG
 . I X["(SCT" D
 . . S SCTT=$P(X," (SCT ")
 . . S SCTC=$$ONE^LEXU(+TERM,DT,"SCT")
 . . S SCTD=$$GETSYN^LEXTRAN1("SCT",SCTC,DT,"GMPSYN",1,1)
 . . I $P(SCTD,U)'=1 S SCTD="" Q
 . . F  S GMPTYP=$O(GMPSYN(GMPTYP)) Q:GMPTYP=""!(GMPQT)  D
 . . . I GMPTYP="S" F  S GMPNUM=$O(GMPSYN(GMPTYP,GMPNUM)) Q:GMPNUM=""!(GMPQT)  D
 . . . . I $P(GMPSYN(GMPTYP,GMPNUM),U)=SCTT S SCTD=$P(GMPSYN(GMPTYP,GMPNUM),U,3),GMPQT=1 Q
 . . . Q:GMPQT
 . . . I $P(GMPSYN(GMPTYP),U)=SCTT S SCTD=$P(GMPSYN(GMPTYP),U,3),GMPQT=1 Q
 . S X=$$TEXT^GMPLBLD1(X) I X="^" S GMPQUIT=1 Q
 . S CODE=$$CODE^GMPLBLD1($G(SCTC),$G(Y(1))) I CODE']"" S GMPQUIT=1 Q
 . S RT1="^TMP(""GMPLIST"",$J,""SEQ"",",SEQ=+$$LAST^GMPLBLD2(RT1)+1 ; dflt = next #
 . S SEQ=$$SEQ^GMPLBLD1(SEQ) I SEQ="^" S GMPQUIT=1 Q
 . S IFN=$$TMPIFN^GMPLBLD1,^TMP("GMPLIST",$J,0)=^TMP("GMPLIST",$J,0)+1
 . S ^TMP("GMPLIST",$J,IFN)=SEQ_U_+Y_U_X_U_CODE_U_SCTC_U_SCTD ; seq ^ # ^ text ^ code ^ snomed ct concept ^ snomed ct designation
 . S (^TMP("GMPLIST",$J,"PROB",+Y),^TMP("GMPLIST",$J,"SEQ",SEQ))=IFN,GMPREBLD=1
 I $D(GMPREBLD) S VALMBCK="R",GMPLSAVE=1 D BUILD("^TMP(""GMPLIST"",$J)",GMPLMODE),HDR
 S VALMBCK="R" S VALMSG=$$MSG^GMPLX K GMPSYN
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
 N NUM,SEL,IFN,PIECE,CODE,PROB,PROBLEM,GMPQUIT,GMPREBLD S VALMBCK="" D FULL^VALM1
 S SEL=$$SEL^GMPLBLD1 G:SEL="^" EDQ
 F PIECE=1:1:$L(SEL,",") D  Q:$D(GMPQUIT)  W !
 . S NUM=$P(SEL,",",PIECE) Q:NUM'>0
 . S IFN=$P($G(^TMP("GMPLST",$J,"B",NUM)),U,1) Q:IFN'>0
 . I "@"[$G(^TMP("GMPLIST",$J,IFN)) W $C(7),!!,"Problem #"_NUM_" does not exist in this category!" H 2 Q
 . W !!,">>>  Problem #"_NUM S PROBLEM=^TMP("GMPLIST",$J,IFN)
 . W:$P(PROBLEM,U,2)>1 " = "_$G(^LEX(757.01,+$P(PROBLEM,U,2),0)) W ! ; KER
 . S PROB=$$TEXT^GMPLBLD1($P(PROBLEM,U,3)) I PROB="^" S GMPQUIT=1 Q
 . I PROB="@" D DELETE^GMPLBLD1(IFN) S GMPREBLD=1 Q
 . S CODE=$$CODE^GMPLBLD1($P(PROBLEM,U,5),$P(PROBLEM,U,4)) I CODE="^" S GMPQUIT=1 Q
 . S ^TMP("GMPLIST",$J,IFN)=$P(PROBLEM,U,1,2)_U_PROB_U_CODE_U_$P(PROBLEM,U,5,6),GMPREBLD=1
 I $D(GMPREBLD) S VALMBCK="R",GMPLSAVE=1 D BUILD("^TMP(""GMPLIST"",$J)",GMPLMODE)
EDQ S:'VALMCC VALMBCK="R" S VALMSG=$$MSG^GMPLX
 Q
 ;
DUPL(Y,TEXT) ; Check for Duplicates within problem selection list category
 N DA,IFN,GMPOTHR,GMPNOW,GMPSRC,GMPCODE,SCTCNEW,ICDNEW,PICDNEW
 S DA=0
 I '$D(^TMP("GMPLIST")) G DUPLX
 S GMPNOW=$E($$NOW^XLFDT,1,7)
 S GMPOTHR=$S(GMPNOW<($$IMPDATE^LEXU("10D")):"799.9",1:"R69.")
 D EXP2CODE^GMPLX(+Y,.GMPSRC,.GMPCODE)
 S SCTCNEW=$S(GMPSRC="SNOMED CT"&($D(GMPCODE)):GMPCODE,1:$P($P(TEXT," (SCT ",2),")"))
 S ICDNEW=$S(GMPSRC="SNOMED CT":$G(Y(1)),1:GMPCODE),PICDNEW=$P(ICDNEW,"/")
 S IFN=""
 F  S IFN=$O(^TMP("GMPLIST",$J,IFN)) Q:IFN=""  D  Q:DA>0
 .N PICDEXT,ICDEXT,SLST,SCTCEXT,TERMEXT,EXPTXT
 .S SLST=$G(^TMP("GMPLIST",$J,IFN)),SCTCEXT=$P(SLST,U,5)
 .S ICDEXT=$P(SLST,U,4),PICDEXT=$P(ICDEXT,"/")
 .S TERMEXT=$P(SLST,U,2)
 .;Compare problems with SNOMED CT concept codes & ICD code(s) only
 .I $L(SCTCEXT),(GMPSRC="SNOMED CT"),($G(SCTCNEW)>0),($L(ICDNEW)) D
 ..;if SCT concepts & primary + multiple ICD targets match => dup
 ..I ICDEXT["/",ICDNEW["/" D
 ...N I,J,SICDEXT S J=0 F I=2:1:$L(ICDEXT,"/") D
 ....S J=J+1,SICDEXT(J)=$P(ICDEXT,"/",I)
 ...N K,L,SICDNEW S L=0 F K=2:1:$L(ICDNEW,"/") D
 ....S L=L+1,SICDNEW(L)=$P(ICDNEW,"/",K)
 ...N T F T=1:1:L D
 ....I SCTCEXT=SCTCNEW,(PICDEXT=PICDNEW),SICDEXT(T)=SICDNEW(T) S DA=IFN Q
 ..;if SCT concept codes match => dup
 ..E  I ICDNEW=GMPOTHR!(PICDNEW=GMPOTHR) D
 ...I SCTCEXT=SCTCNEW S DA=IFN Q
 ..;if SCT concepts & primary ICD diagnosis match => dup
 ..E  I SCTCEXT=SCTCNEW,(PICDEXT=PICDNEW) S DA=IFN Q
 .;Compare legacy problems with ICD codes only
 .E  I $L(ICDEXT),'$L(SCTCEXT),(GMPSRC["ICD"),(+$G(ICDNEW)>0) D
 ..;if Exprs match => dup
 ..I +Y>1&(TERMEXT=+Y) S DA=IFN Q
 ..;if Text matches Expr from old => dup
 ..D LOOK^LEXA("`"_TERMEXT)
 ..S EXPTXT=$P($G(LEX("LIST",1)),U,2)
 ..S TEXT=$$UP^XLFSTR($P(TEXT," (ICD"))
 ..I LEX>1&(TEXT=$$UP^XLFSTR($S(EXPTXT["*":$P(EXPTXT," *"),1:EXPTXT))) S DA=IFN Q
 ..;if prim ICD of new = prim ICD of old => dup
 ..I PICDEXT'=GMPOTHR,(PICDNEW'=GMPOTHR),(PICDEXT=PICDNEW) S DA=IFN Q
DUPLX Q DA
