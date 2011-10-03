IBCEFG3 ; ALB/TMP - OUTPUT FORMATTER MAINT - SCREEN BLD UTILITIES ; 22-JAN-96
 ;;2.0; INTEGRATED BILLING ;**52,88**; 21-MAR-94
 ;
EN ; Main entry point LOCAL FORM maintenance
 D DT^DICRW
 K XQORS,VALMEVL,IBFASTXT
 D EN^VALM("IBCE LOCAL FORMS LIST")
 K IBFASTXT
 Q
 ;
INIT ; -- set up inital variables local form list
 S U="^",VALMCNT=0,VALMBG=1
 K ^TMP("IBCEFORM",$J),^TMP("IBCEFORMDX",$J)
 D BLD
 Q
 ;
BLD ; -- build list of local forms
 K ^TMP("IBCEFORM",$J),^TMP("IBCEFORMDX",$J)
 N IBCFORM,IBCNT,X,IB2
 S (IBCNT,VALMCNT)=0
 ;
 ; -- find all local forms
 S IBCFORM=0 F  S IBCFORM=$O(^IBE(353,IBCFORM)) Q:'IBCFORM  S IB2=$G(^(IBCFORM,2)) I $P(IB2,U,4)=0 D
 .; -- add to list
 .S IBCNT=IBCNT+1,X="" W "."
 .S X=$$SETFLD^VALM1(IBCNT,X,"NUMBER")
 .I $D(^IBE(353,IBCFORM,0)) S X=$$SETFLD^VALM1($P(^(0),"^"),X,"FNAME")
 .S X=$$SETFLD^VALM1($J(IBCFORM,6),X,"FENTRY")
 .S X=$$SETFLD^VALM1($J($P(IB2,U,2),3),X,"TYPE")
 .S X=$$SETFLD^VALM1($P(IB2,U,6),X,"DESCR")
 .D SET(X)
 I '$D(^TMP("IBCEFORM",$J)) S VALMCNT=2,IBCNT=2,^TMP("IBCEFORM",$J,1,0)=" ",^TMP("IBCEFORM",$J,2,0)="    No Local Forms Currently On File",^TMP("IBCEFORM",$J,"IDX",1,1)="",^TMP("IBCEFORM",$J,"IDX",2,2)=""
 Q
 ;
FNL ; -- Clean up local form list
 K ^TMP("IBCEFORMDX",$J)
 D CLEAN^VALM10
 K IBFASTXT
 Q
 ;
SET(X) ; -- set arrays for local form list
 S VALMCNT=VALMCNT+1,^TMP("IBCEFORM",$J,VALMCNT,0)=X
 S ^TMP("IBCEFORM",$J,"IDX",VALMCNT,IBCNT)=""
 S ^TMP("IBCEFORMDX",$J,IBCNT)=VALMCNT_"^"_IBCFORM
 Q
 ;
BLDX ; -- build display of expanded local form
 N IB2,IBPAR,Z,Z0
 Q:'$G(IBCEXDA)  ;Form ien in file 353
 S VALMBG=1,IB2=$G(^IBE(353,IBCEXDA,2)),IBPAR=+$P(IB2,U,5)
 K ^TMP("IBCEX",$J)
 D SET^VALM10(1,"Form Number: "_IBCEXDA),SET^VALM10(2,"Base File  : "_$P($G(^DIC(+IB2,0)),U))
 D SET^VALM10(3,"Format Type: "_$$EXPAND^IBTRE(353,2.02,$P(IB2,U,2)))
 D SET^VALM10(4," ")
 D SET^VALM10(5,"Description: "_$P(IB2,U,6))
 S VALMCNT=5
 I $P(IB2,U,2)="P" D SET^VALM10(VALMCNT+1,"Form Length: "_$P(IB2,U,3)) S VALMCNT=VALMCNT+1
 I $P(IB2,U,2)="T" S Z=$S(IBPAR:$P($G(^IBE(353,IBPAR,2)),U,7),1:$P(IB2,U,7)) S:Z="" Z="^" D SET^VALM10(VALMCNT+1,"  Delimiter: "_Z) S VALMCNT=VALMCNT+1
 I IBPAR D SET^VALM10(VALMCNT+1," ") D SET^VALM10(VALMCNT+2,"Associated With National Form: "_$P($G(^IBE(353,IBPAR,0)),U)) S VALMCNT=VALMCNT+2
 S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT," ")
 I $P(IB2,U,2)'="S" D
 . K Z
 . S VALMCNT=VALMCNT+1,Z0=$G(^IBE(353,IBPAR,"PRE")),Z=$G(^IBE(353,IBCEXDA,"PRE"))
 . I $L(Z)>57 D SPLITZ(.Z)
 . D SET^VALM10(VALMCNT,"Entry Pre-processor : "_$S(Z'="":Z,Z0="":"",1:Z0_" (defined for associated 'parent' form)"))
 . I $D(Z(0)) D
 .. N CT
 .. F CT=0:1:$O(Z(""),-1) S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,Z(CT))
 .. K Z
 . S VALMCNT=VALMCNT+1,Z0=$G(^IBE(353,IBPAR,"POST")),Z=$G(^IBE(353,IBCEXDA,"POST"))
 . I $L(Z)>57 D SPLITZ(.Z)
 . D SET^VALM10(VALMCNT,"Entry Post-processor: "_$S(Z'="":Z,Z0="":"",1:Z0_" (defined for associated 'parent' form)"))
 . I $D(Z(0)) D
 .. N CT
 .. F CT=0:1:$O(Z(""),-1) S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,Z(CT))
 .. K Z
 S VALMCNT=VALMCNT+1,Z0=$G(^IBE(353,IBPAR,"FPRE")),Z=$G(^IBE(353,IBCEXDA,"FPRE"))
 I $L(Z)>57 D SPLITZ(.Z)
 D SET^VALM10(VALMCNT,"Form Pre-processor  : "_$S(Z'="":Z,Z0="":"",1:Z0_" (defined for associated 'parent' form)"))
 I $D(Z(0)) D
 . N CT
 . F CT=0:1:$O(Z(""),-1) S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,Z(CT))
 . K Z
 S VALMCNT=VALMCNT+1,Z0=$G(^IBE(353,IBPAR,"FPOST")),Z=$G(^IBE(353,IBCEXDA,"FPOST"))
 I $L(Z)>57 D SPLITZ(.Z)
 D SET^VALM10(VALMCNT,"Form Post-processor : "_$S(Z'="":Z,Z0="":"",1:Z0_" (defined for associated 'parent' form)"))
 I $D(Z(0)) D
 . N CT
 . F CT=0:1:$O(Z(""),-1) S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,Z(CT))
 . K Z
 I $P(IB2,U,2)'="S" D
 . S VALMCNT=VALMCNT+1,Z0=$G(^IBE(353,IBPAR,"OUT")),Z=$G(^IBE(353,IBCEXDA,"OUT"))
 . I $L(Z)>57 D SPLITZ(.Z)
 . D SET^VALM10(VALMCNT,"Output Logic        : "_$S(Z'="":Z,Z0="":"(Use formatter default)",1:Z0_" (defined for associated 'parent' form)"))
 . I $D(Z(0)) D
 .. N CT
 .. F CT=0:1:$O(Z(""),-1) S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,Z(CT))
 .. K Z
 . S VALMCNT=VALMCNT+1,Z0=$G(^IBE(353,IBPAR,"EXT")),Z=$G(^IBE(353,IBCEXDA,"EXT"))
 . I $L(Z)>57 D SPLITZ(.Z)
 . D SET^VALM10(VALMCNT,"Extract Logic       : "_$S(Z'="":Z,Z0="":"",1:Z0_" (defined for associated 'parent' form)"))
 . I $D(Z(0)) D
 .. N CT
 .. F CT=0:1:$O(Z(""),-1) S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,Z(CT))
 .. K Z
 Q
 ;
SELX ; -- Select the form to process
 D EN^VALM2($G(XQORNOD(0)),"S")
 S IBCEXDA=$P($G(^TMP("IBCEFORMDX",$J,+$O(VALMY("")))),U,2)
 Q
 ;
FNLX ; Clean up after form view/edit action
 K IBCEXDA
 D CLEAN^VALM10
 S VALMBCK="R"
 Q
 ;
HDRX ; -- Hdr for form view/edit action
 S VALMHDR(1)=" "
 S VALMHDR(2)="LOCAL FORM: "_$P($G(^IBE(353,+$G(IBCEXDA),0)),U)
 Q
 ;
SPLITZ(Z) ;Splits code into chunks the display can handle
 N A,CT,Q,ST
 S A=Z,CT=0,ST=57
 S Z=$E(A,1,ST)
 F CT=0:1 S Q=$E(A,ST+1,ST+57) Q:Q=""  S Z(CT)=$J("",22)_Q,ST=ST+57
 Q
 ;
