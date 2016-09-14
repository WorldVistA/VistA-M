VIABPCE4 ;AITC/BWF - wrap calls to PCE and AICS ;2/12/16  15:13
 ;;1.0;VISTA INTEGRATION ADAPTER;**5**;06-FEB-2014;Build 8
 ;
 ; DBIA 2950   LOOK^LEXA          ^TMP("LEXFND",$J)
 ; DBIA 1609   CONFIG^LEXSET      ^TMP("LEXSCH",$J)
 ; DBIA 3991   $$STATCHK^ICDAPIU
 ;
 ; This is a clone of ORWPCE4.
 Q
LEX(LST,X,APP,VIADATE,VIAXTND,VIAINSYN) ; return list after lexicon lookup
 ; Call with: X           (Required) The search text entered by the user
 ;            APP         (Required) The Lexicon APP parameter (e.g., "GMPX"
 ;                                   for Problem List Subset, "10D" for ICD-10-CM, etc.
 ;            [VIADATE]    (Optional) the date of interest (Defaults to TODAY - should
 ;                                   be passed as DATE OF SERVICE if not TODAY)
 ;            [VIAXTND]    (Optional) Boolean flag specifying whether or not to
 ;                                   use an extended search (Initial search is PL Subset
 ;                                   of SCT, extended search is ICD (or 10D after impl.)
 ;                                   (Defaults to 0 (FALSE))
 ;            [VIAINSYN]  (Optional) Boolean flag specifying whether or not to
 ;                                   include synonyms for SNOMED CT Concepts
 ;                                   (Defaults to 0 (FALSE))
 ;
 ;   Returns: LST=local array name passed by ref, which contains search result set as:
 ;            <lvn>(1..n)=LEXIEN^PREFTEXT^CODESYS^CONCEPTID^ICDVER^DESIGID^PARENTSUBSCRIPT
 ;
 N LEX,ILST,I,IEN,IMPLDT,SUBSET,FILTER
 S FILTER=""
 S IMPLDT=$$IMPDATE^LEXU("10D")
 S:APP="CPT" APP="CHP" ; LEX PATCH 10
 I APP="ICD",'+$G(VIAXTND) S APP=$S($E(X,1,3)?.1A2.3N:"ICD",1:"GMPX")
 S:'+$G(VIADATE) VIADATE=DT
 S VIAINSYN=+$G(VIAINSYN)
 I APP="ICD",(VIADATE'<IMPLDT) S APP="10D"
 S SUBSET=$S(APP="GMPX":$S(VIADATE<IMPLDT:"PLS",1:"CLF"),1:APP)
 ; call CONFIG^LEXSET to set-up the constraints of the Lexicon search
 D CONFIG^LEXSET(APP,SUBSET,VIADATE)  ;DBIA 1609
 I APP="CHP" D
 . ; Set the filter for CPT only using CS APIs - format is the same as for DIC("S")
 . S ^TMP("LEXSCH",$J,"FIL",0)="I $L($$CPTONE^LEXU(+Y,$G(VIADATE)))!($L($$CPCONE^LEXU(+Y,$G(VIADATE))))"  ;DBIA 1609
 . ; Set Applications Default Flag (Lexicon can not overwrite filter)
 . S ^TMP("LEXSCH",$J,"ADF",0)=1
 ; setup and/or search
 S X=$$UP^XLFSTR(X)
 ; execute the search
 D SRCH(.LST,X,APP,SUBSET,VIADATE,VIAINSYN)
LEXX K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J),^TMP("LEXSCH",$J),^TMP("LEXLE",$J)
 Q
SRCH(LST,X,APP,SUBSET,VIADATE,VIAINSYN) ; call LOOK^LEXA to execute the search
 N LEX,I,IEN,ILST
 D LOOK^LEXA(X,APP,1,SUBSET,VIADATE)
 I '$D(LEX("LIST",1)) D  G LEXX
 . S LST(1)="-1^No matches found.^"_APP
 S ILST=0
 S LEX("LIST",1)=$$LEXXFRM(LEX("LIST",1),VIADATE,APP)
 I $S(APP="GMPX":1,APP="ICD":1,1:0),($P(LEX("LIST",1),U,6)'="799.9") D  I 1
 . I APP="ICD",($E($P(LEX("LIST",1),U,3),1,3)'="ICD") Q
 . S LST(1)=LEX("LIST",1),ILST=1
 E  S LST(1)=LEX("LIST",1),ILST=1
 I APP="GMPX",+$G(VIAINSYN) D SYNONYMS(.LST,.ILST,"SCT",$P(LST(1),U,4),VIADATE)
 S (I,IEN)=""
 F  S I=$O(^TMP("LEXFND",$J,I)) Q:I=""  D  ;DBIA 2950
 .F  S IEN=$O(^TMP("LEXFND",$J,I,IEN)) Q:IEN=""  D
 ..N TXT,ELEMENT S TXT=^TMP("LEXFND",$J,I,IEN)
 ..S ELEMENT=IEN_U_TXT
 ..S ELEMENT=$$LEXXFRM(ELEMENT,VIADATE,APP) Q:$S(APP="GMPX":1,APP="ICD":1,1:0)&($P(ELEMENT,U,6)="799.9")
 ..I APP="ICD",($E($P(ELEMENT,U,3),1,3)'="ICD") Q
 ..S ILST=ILST+1,LST(ILST)=ELEMENT
 ..I APP="GMPX",+$G(VIAINSYN) D SYNONYMS(.LST,.ILST,"SCT",$P(LST(ILST),U,4),VIADATE)
 I '$D(LST(1)) S LST(1)="-1^No matches found.^"_APP
 Q
LEXXFRM(VIAX,VIADATE,VIAAPP) ; Transform text for SCT look-up
 N VIALEX,VIAY,VIAICD,VIASCT,VIATXT,VIACSYS,VIACCODE,VIADCODE
 S VIALEX=$P(VIAX,U),VIATXT=$P(VIAX,U,2),(VIACCODE,VIACSYS)=""
 I (VIATXT["("),(VIATXT[")") D
 . S VIACSYS=$RE($P($P($RE(VIATXT),"("),")",2))
 . S VIACCODE=$RE($P($RE(VIACSYS)," ")),VIACSYS=$RE($P($RE(VIACSYS)," ",2,99))
 . S VIATXT=$$TRIM^XLFSTR($RE($P($RE(VIATXT),"(",2,99)))
 S VIAY=$$SETELEM(VIALEX,VIATXT,VIACSYS,VIACCODE,VIADATE)
 Q VIAY
SYNONYMS(LST,ILST,VIACSYS,VIACCODE,VIADT) ; Get synonyms fVIA expression
 N VIASYN,VIAI,VIADAD S VIADT=$G(VIADT,DT),VIADAD=ILST
 D GETSYN^LEXTRAN1(VIACSYS,VIACCODE,VIADT,"VIASYN",1)
 S VIAI=0 F  S VIAI=$O(VIASYN("S",VIAI)) Q:+VIAI'>0  D
 . N ELEMENT,TXT,IEN,VIADCODE
 . S IEN=$P(VIASYN("S",VIAI),U,2),TXT=$P(VIASYN("S",VIAI),U)
 . S ELEMENT=$$SETELEM(IEN,TXT,"SNOMED CT",VIACCODE,VIADT)_U_VIADAD
 . S ILST=ILST+1,LST(ILST)=ELEMENT
 Q
SETELEM(VIALEX,VIATXT,VIACSYS,VIACCODE,VIADATE) ; Set List Element
 ;LEXIEN^PREFTEXT^CODESYS^CONCEPTID^ICDVER^ICDCODE^DESIGID^PARENTSUBSCRIPT
 N VIAY,VIADCODE,VIAIMPDT,VIAICD
 S VIAIMPDT=$$IMPDATE^LEXU("10D")
 S VIAY=VIALEX_U_VIATXT_U_VIACSYS_U_VIACCODE
 I $S(VIACSYS["SNOMED":1,VIACSYS["VHAT":1,1:0) D
 .S VIAY=VIAY_U_$S(VIADATE<VIAIMPDT:"ICD-9-CM",1:""),VIAICD=""
 .S:VIADATE<VIAIMPDT VIAICD=$$GETDX(VIACCODE,VIACSYS,VIADATE)
 .S VIADCODE=$$GETDES^LEXTRAN1("SCT",VIATXT,VIADATE)
 .S VIADCODE=$S(+VIADCODE=1:$P(VIADCODE,U,2),1:"")
 .S VIAY=VIAY_U_VIAICD_U_VIADCODE
 E  S VIAY=VIAY_U_U
 Q VIAY
GETDX(CODE,SYS,VIAIDT) ; Get ICD associated with SNOMED CT VIA VHAT Code
 N LEX,VIAI,VIAY,VIAUH,IMPLDT,VIASYSPR
 S VIAIDT=$G(VIAIDT,DT)
 S VIAY=0,IMPLDT=$$IMPDATE^LEXU("10D")
 S VIAUH=$S(VIAIDT<IMPLDT:"799.9",1:"R69.")
 S VIASYSPR=$S(VIAIDT<IMPLDT:1,1:30)
 I SYS["VHAT" D  I 1
 . I VIAIDT<IMPLDT S VIAY=$$GETASSN^LEXTRAN1(CODE,"VHAT2ICD") I 1
 . E  S VIAY=0
 E  D
 . I VIAIDT<IMPLDT S VIAY=$$GETASSN^LEXTRAN1(CODE,"SCT2ICD") I 1
 . E  S VIAY=0
 I $S(+VIAY'>0:1,+$P(VIAY,U,2)'>0:1,+LEX'>0:1,1:0) S VIAY=VIAUH G GETDXX
 S VIAI=0,VIAY=""
 F  S VIAI=$O(LEX(VIAI)) Q:+VIAI'>0  D
 . N ICD
 . S ICD=$O(LEX(VIAI,""))
 . S:'+$$STATCHK^ICDXCODE(VIASYSPR,ICD,VIAIDT) ICD=""
 . I ICD]"" S VIAY=$S(VIAY'="":VIAY_"/",1:"")_ICD
 I (VIAY]""),(VIAY'[".") S VIAY=VIAY_"."
GETDXX Q VIAY
