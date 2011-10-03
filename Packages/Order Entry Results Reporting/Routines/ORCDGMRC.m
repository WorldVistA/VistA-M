ORCDGMRC ;SLC/MKB-Utility functions for GMRC dialogs ;3/10/03  07:34
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,26,68,100,181**;Dec 17, 1997
 ; External References
 ;    DBIA 10006 Call to ^DIC
 ;    DBIA 10026 Call to ^DIR
 ;    DBIA  2426 Call to SERV1^GMRCASV
 ;    DBIA  3119 Call to GETDEF^GMRCDRFR
 ;    DBIA  2982 Call to GETSVC^GMRCPR0
 ;    DBIA  3121 Call to APIs $$PROVDX and PREREQ in routine ^GMRCUTL1
 ;    DBIA  1609 Call to CONFIG^LEXSET
 ;    DBIA 10104 Call to APIs $$RJ and $$UP in routine ^XLFSTR
 ;    DBIA 10102 Call to DISP^XQORM1
 ;    DBIA  3991 Call to $$STATCHK^ICDAPIU
URGENCY(TYPE) ; -- Returns index of allowable urgencies from file #101.42
 N X S X=$S($$VAL^ORCD("CATEGORY")'="I":"O",TYPE="C":"T",1:"R")
 S ORDIALOG(PROMPT,"D")="S.GMRC"_X
 Q
 ;
PLACE ; -- Returns list of allowable places of consultation
 Q:$D(ORDIALOG(PROMPT,"LIST"))  N CHOICES,I,J,INPT,X
 S INPT=($$VAL^ORCD("CATEGORY")="I")
 I INPT S CHOICES="B^Bedside;C^Consultant's Choice"
 I 'INPT S CHOICES="E^Emergency Room;C^Consultant's Choice"
 S I=0 F J=1:1:$L(CHOICES,";") S X=$P(CHOICES,";",J) D
 . S I=I+1,ORDIALOG(PROMPT,"LIST",I)=X
 . S ORDIALOG(PROMPT,"LIST","B",$$UP^XLFSTR($P(X,U,2)))=$P(X,U)
 S ORDIALOG(PROMPT,"LIST")=I_"^1"
 Q
 ;
CHANGED(PRMT) ; -- Kill lists for Request Service or Place of Consultation
 N I,P
 S I=$S(PRMT="OI":"REQUEST SERVICE",1:"PLACE OF CONSULTATION")
 S P=$$PTR^ORCD("OR GTX "_I) Q:'P
 K ORDIALOG(P,"LIST"),ORDIALOG(P,1)
 Q
 ;
GETSERV ; -- Get list of orderable services
 N GMRCTO,GMRCDG,I,X K ^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J)
 S (GMRCTO,GMRCDG)=1 D SERV1^GMRCASV ; get list of orderable services
 F I=1:1 S X=+$G(^TMP("GMRCSLIST",$J,I)) Q:X'>0  S $P(^TMP("GMRCS",$J,X),U,2)=I
 Q
 ;
LISTSERV(ORI) ; -- List Consult services from ORSERV
 N ORSTK,ORCNT,ORX,ORQ
 W !,"Choose from:" S:$G(ORI)'>0 ORI=1
 S (ORSTK,ORQ)=0,ORCNT=1,ORSTK(0)=$P(^TMP("GMRCSLIST",$J,ORI),U,3)
 F  S ORX=$G(^TMP("GMRCSLIST",$J,ORI)) Q:ORX=""  D  Q:ORQ  S ORI=ORI+1
 . I $P(ORX,U,3)'=+$G(ORSTK(ORSTK)) D POP I ORSTK'>0 S ORQ=1 Q
 . S ORCNT=ORCNT+1 I ORCNT>(IOSL-6) S:'$$CONT ORQ=1 Q:$G(ORQ)  S ORCNT=1
 . W !,?((ORSTK*2)),$P(ORX,U,2)
 . W:$P(ORX,U,5) "  ("_$S($P(ORX,U,5)=1:"Grouper",1:"Tracking")_" Only)"
 . I $P(ORX,U,4)="+" S ORSTK=ORSTK+1,ORSTK(ORSTK)=+ORX
 Q
 ;
POP ; -- pop stack
 S ORSTK=ORSTK-1 Q:ORSTK'>0
 I ORSTK(ORSTK)'=$P(ORX,U,3) G POP
 Q
 ;
CONT() ; -- continue?
 N X,Y,DIR S DIR(0)="E" D ^DIR
 Q +Y
 ;
CKSERV ; -- Ck service usage in Post-Selection Action
 N GMRCI,ORI
 S GMRCI=+$P(^ORD(101.43,+Y,0),U,2)
 S ORI=+$P($G(^TMP("GMRCS",$J,GMRCI)),U,2) S:ORI'>0 ORI=1
 I $P($G(^TMP("GMRCSLIST",$J,ORI)),U,5)=1 D LISTSERV^ORCDGMRC(ORI) K DONE
 Q
 ;
PROCSVC ; -- Get list of services for procedure
 Q:$D(ORDIALOG(PROMPT,"LIST"))  Q:'$L($T(GETSVC^GMRCPR0))
 N OI,PROTCL,ORY,ORI,X
 S OI=+$$VAL^ORCD("PROCEDURE"),PROTCL=$P($G(^ORD(101.43,OI,0)),U,2) ;ID
 D:PROTCL GETSVC^GMRCPR0(.ORY,PROTCL)
 I $G(ORY)'>0 W $C(7),!,"There are no services defined for this procedure!" H 1 S ORQUIT=1 Q
 M ORDIALOG(PROMPT,"LIST")=ORY S $P(ORDIALOG(PROMPT,"LIST"),U,2)=1
 S ORI=0 F  S ORI=$O(ORY(ORI)) Q:ORI'>0  S X=$P(ORY(ORI),U,2),ORDIALOG(PROMPT,"LIST","B",X)=+ORY(ORI)
 Q
 ;
CKPROCSV ; -- Make sure procedure has at least one service
 N PROT,ORY S PROT=$P($G(^ORD(101.43,+Y,0)),U,2)
 D GETSVC^GMRCPR0(.ORY,PROT) I $G(ORY)'>0 W $C(7),!,"There are no services defined for this procedure!",! K DONE
 Q
 ;
NWHELP ; -- help code for NW action
 N X
 W !!,"Select the type of request you wish to enter, either a consult to a service",!,"or a procedure that may be ordered without a formal consult."
 W !!,"Press <return> to continue ..." R X:DTIME
 S X="?" D DISP^XQORM1 W !
 Q
 ;
REASON ; -- Get default Reason for Request text for Service
 N ORIT,ORSERV,OROOT
 S ORIT=$G(ORDIALOG($$PTR^ORCD("OR GTX ORDERABLE ITEM"),1))
 S ORSERV=$P($G(^ORD(101.43,+ORIT,0)),U,2) Q:'ORSERV!(ORSERV["99PRO")
 S OROOT=$NA(^TMP("ORWORD",$J,PROMPT,INST)) D
 . N PROMPT,INST,X,Y,DIR,ACTION,REQD,MULT,ITEM,COND ;protect var's
 . D GETDEF^GMRCDRFR(OROOT,ORSERV,+$G(ORVP),$S($G(ORVP):1,1:0))
 S:$D(^TMP("ORWORD",$J,PROMPT,INST)) Y=OROOT
 Q
 ;
ENPDX ; -- setup Prov Dx field
 N CODE
 S ORPDX=$$PROVDX^GMRCUTL1($S($D(ORPROC):ORPROC,1:$G(ORSERV)))
 S CODE=$$PTR^ORCD("OR GTX CODE")
 I $P(ORPDX,U)="S" K ORDIALOG(PROMPT,INST),ORDIALOG(CODE,INST) S COND="I 0" Q
 S:$G(ORTYPE)'="Z" REQD=$S($P(ORPDX,U)="R":1,1:0)
 K:$P(ORPDX,U,2)'="L" ORDIALOG(CODE,INST)
 I $P(ORPDX,U,2)="L" S ORDIALOG(PROMPT,"?")="Select a preliminary diagnosis from the Lexicon, as text or an ICD code." K:'$L($G(ORDIALOG(CODE,INST))) ORDIALOG(PROMPT,INST)
 I $L($G(ORDIALOG(CODE,INST))),'$$STATCHK^ICDAPIU(ORDIALOG(CODE,INST),DT)  D  ;csv
 . D EN^DDIOL("The existing diagnosis is associated with an inactive ICD-9 code.")
 . I $G(REQD) D EN^DDIOL("Another code must be selected before proceeding.")
 . I '$G(REQD) D EN^DDIOL("If another code is not selected, no code will be saved with the new order.")
 . D EN^DDIOL(" ")
 . K ORDIALOG(PROMPT,INST),ORDIALOG(CODE,INST)
 . S ACTION=$G(ACTION)_"W"
 Q
 ;
LEX ; -- search Lexicon for Prov Dx
 I $L($G(ORESET)),ORESET=Y Q  ;no change
 I Y?1." " K DONE W !!,$C(7),"Use of only spaces not allowed!",! Q
 Q:$P(ORPDX,U,2)'="L"  ;free text only, no ICD code
 N DIC,DUOUT,DTOUT
 D CONFIG^LEXSET("ICD","ICD",DT)
 S DIC="^LEX(757.01,",DIC(0)="EQM",DIC("A")="Provisional Diagnosis: "
 S:$L($G(ORESET)) DIC("B")=ORESET
 D ^DIC I Y'>0 D  Q
 . I $L($G(ORESET)) S ORDIALOG(PROMPT,ORI)=ORESET
 . E  K ORDIALOG(PROMPT,ORI)
 . I $D(DTOUT)!$D(DUOUT) S ORQUIT=1 Q
 . I REQD,'$D(ORDIALOG(PROMPT,ORI)) K DONE W !!,$C(7),$$REQUIRED^ORCDLG1,!
 S ORDIALOG(PROMPT,ORI)=$P(Y,U,2)
 S ORDIALOG($$PTR^ORCD("OR GTX CODE"),ORI)=$G(Y(1)) K Y(1)
 Q
 ;
SERVMSG ; -- Get, display text message for service ORSERV
 Q:'$G(ORSERV)&('$G(ORPROC))  Q:'FIRST  ;show first time only
 N ORTXT,I,CNT,HDR S HDR=$S($G(ORMENU):5,1:7)
 D PREREQ^GMRCUTL1("ORTXT",$S($D(ORPROC):ORPROC,1:ORSERV),+ORVP)
 Q:'$D(ORTXT)
 I $D(ORPROC) W !!,$$RJ^XLFSTR("** Procedure Pre-requisite **",57)
 E  W !!,$$RJ^XLFSTR("** Consult Service Pre-requisite **",57)
 S (I,CNT)=0 F  S I=$O(ORTXT(I)) Q:I'>0  D  Q:$G(ORQUIT)
 . S CNT=CNT+1 I CNT>(IOSL-HDR) S CNT=0 I '$$CONT S ORQUIT=1 Q
 . W !,ORTXT(I,0)
 Q:$G(ORQUIT)  S:'$$CONT ORQUIT=1 W !
 Q
