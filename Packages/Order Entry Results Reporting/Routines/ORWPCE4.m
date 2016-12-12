ORWPCE4 ; SLC/JM/REV - wrap calls to PCE and AICS ;07/30/15  07:30
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,116,173,190,195,215,243,295,280,306,361,350**;Dec 17, 1997;Build 77
 ;
 ; DBIA 2950   LOOK^LEXA          ^TMP("LEXFND",$J)
 ; DBIA 1609   CONFIG^LEXSET      ^TMP("LEXSCH",$J)
 ; DBIA 1365   DSELECT^GMPLENFM   ^TMP("IB",$J)
 ; DBIA 3991   $$STATCHK^ICDAPIU
 ;
 Q
LEX(LST,X,APP,ORDATE,ORXTND,ORINCSYN) ; return list after lexicon lookup
 ; Call with: X           (Required) The search text entered by the user
 ;            APP         (Required) The Lexicon APP parameter (e.g., "GMPX"
 ;                                   for Problem List Subset, "10D" for ICD-10-CM, etc.
 ;            [ORDATE]    (Optional) the date of interest (Defaults to TODAY - should
 ;                                   be passed as DATE OF SERVICE if not TODAY)
 ;            [ORXTND]    (Optional) Boolean flag specifying whether or not to
 ;                                   use an extended search (Initial search is PL Subset
 ;                                   of SCT, extended search is ICD (or 10D after impl.)
 ;                                   (Defaults to 0 (FALSE))
 ;            [ORINCSYN]  (Optional) Boolean flag specifying whether or not to
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
 I APP="ICD",'+$G(ORXTND) S APP=$S($E(X,1,3)?.1A2.3N:"ICD",1:"GMPX")
 S:'+$G(ORDATE) ORDATE=DT
 S ORINCSYN=+$G(ORINCSYN)
 I APP="ICD",(ORDATE'<IMPLDT) S APP="10D"
 S SUBSET=$S(APP="GMPX":$S(ORDATE<IMPLDT:"PLS",1:"CLF"),1:APP)
 ; call CONFIG^LEXSET to set-up the constraints of the Lexicon search
 D CONFIG^LEXSET(APP,SUBSET,ORDATE)  ;DBIA 1609
 I APP="CHP" D
 . ; Set the filter for CPT only using CS APIs - format is the same as for DIC("S")
 . S ^TMP("LEXSCH",$J,"FIL",0)="I $L($$CPTONE^LEXU(+Y,$G(ORDATE)))!($L($$CPCONE^LEXU(+Y,$G(ORDATE))))"  ;DBIA 1609
 . ; Set Applications Default Flag (Lexicon can not overwrite filter)
 . S ^TMP("LEXSCH",$J,"ADF",0)=1
 ; setup and/or search
 S X=$$UP^XLFSTR(X)
 ; execute the search
 D SRCH(.LST,X,APP,SUBSET,ORDATE,ORINCSYN)
LEXX K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J),^TMP("LEXSCH",$J),^TMP("LEXLE",$J)
 Q
SRCH(LST,X,APP,SUBSET,ORDATE,ORINCSYN) ; call LOOK^LEXA to execute the search
 N LEX,I,IEN,ILST
 D LOOK^LEXA(X,APP,1,SUBSET,ORDATE)
 I '$D(LEX("LIST",1)) D  G LEXX
 . S LST(1)="-1^No matches found.^"_APP
 S ILST=0
 S LEX("LIST",1)=$$LEXXFRM(LEX("LIST",1),ORDATE,APP)
 I $S(APP="GMPX":1,APP="ICD":1,1:0),($P(LEX("LIST",1),U,6)'="799.9") D  I 1
 . I APP="ICD",($E($P(LEX("LIST",1),U,3),1,3)'="ICD") Q
 . S LST(1)=LEX("LIST",1),ILST=1
 E  S LST(1)=LEX("LIST",1),ILST=1
 I APP="GMPX",+$G(ORINCSYN) D SYNONYMS(.LST,.ILST,"SCT",$P(LST(1),U,4),ORDATE)
 S (I,IEN)=""
 F  S I=$O(^TMP("LEXFND",$J,I)) Q:I=""  D  ;DBIA 2950
 .F  S IEN=$O(^TMP("LEXFND",$J,I,IEN)) Q:IEN=""  D
 ..N TXT,ELEMENT S TXT=^TMP("LEXFND",$J,I,IEN)
 ..S ELEMENT=IEN_U_TXT
 ..S ELEMENT=$$LEXXFRM(ELEMENT,ORDATE,APP) Q:$S(APP="GMPX":1,APP="ICD":1,1:0)&($P(ELEMENT,U,6)="799.9")
 ..I APP="ICD",($E($P(ELEMENT,U,3),1,3)'="ICD") Q
 ..S ILST=ILST+1,LST(ILST)=ELEMENT
 ..I APP="GMPX",+$G(ORINCSYN) D SYNONYMS(.LST,.ILST,"SCT",$P(LST(ILST),U,4),ORDATE)
 I '$D(LST(1)) S LST(1)="-1^No matches found.^"_APP
 Q
LEXXFRM(ORX,ORDATE,ORAPP) ; Transform text for SCT look-up
 N ORLEX,ORY,ORICD,ORSCT,ORTXT,ORCODSYS,ORCCODE,ORDCODE
 S ORLEX=$P(ORX,U),ORTXT=$P(ORX,U,2),(ORCCODE,ORCODSYS)=""
 I ORTXT["*" S ORTXT=$$STRIP^XLFSTR(ORTXT,"*")
 I (ORTXT["("),(ORTXT[")") D
 . S ORCODSYS=$RE($P($P($RE(ORTXT),"("),")",2))
 . S ORCCODE=$$ONE^LEXU(+ORLEX,ORDATE,"SCT"),ORCODSYS=$RE($P($RE(ORCODSYS)," ",2,99))
 . S ORTXT=$$TRIM^XLFSTR($RE($P($RE(ORTXT),"(",2,99)))
 S ORY=$$SETELEM(ORLEX,ORTXT,ORCODSYS,ORCCODE,ORDATE)
 Q ORY
SYNONYMS(LST,ILST,ORCSYS,ORCCODE,ORDT) ; Get synonyms for expression
 N ORSYN,ORI,ORDAD S ORDT=$G(ORDT,DT),ORDAD=ILST
 D GETSYN^LEXTRAN1(ORCSYS,ORCCODE,ORDT,"ORSYN",1,1)
 S ORI=0 F  S ORI=$O(ORSYN("S",ORI)) Q:+ORI'>0  D
 . N ELEMENT,TXT,IEN,ORDCODE
 . S IEN=$P(ORSYN("S",ORI),U,2),TXT=$P(ORSYN("S",ORI),U),ORDCODE=$P(ORSYN("S",ORI),U,3)
 . S ELEMENT=$$SETELEM(IEN,TXT,"SNOMED CT",ORCCODE,ORDT,ORDCODE)_U_ORDAD
 . S ILST=ILST+1,LST(ILST)=ELEMENT
 Q
SETELEM(ORLEX,ORTXT,ORCODSYS,ORCCODE,ORDATE,ORDCODE) ; Set List Element
 ;LEXIEN^PREFTEXT^CODESYS^CONCEPTID^ICDVER^ICDCODE^DESIGID^PARENTSUBSCRIPT
 N ORY,ORIMPDT,ORICD,ORSYN,ORTYP,ORQT,ORNUM
 S ORIMPDT=$$IMPDATE^LEXU("10D"),(ORTYP,ORQT,ORNUM)=""
 S ORY=ORLEX_U_ORTXT_U_ORCODSYS_U_ORCCODE
 I $S(ORCODSYS["SNOMED":1,ORCODSYS["VHAT":1,1:0) D
 . S ORY=ORY_U_$S(ORDATE<ORIMPDT:"ICD-9-CM",1:"ICD-10-CM"),ORICD=""
 . S ORICD=$$GETDX^ORQQPL1(ORCCODE,ORCODSYS,ORDATE)
 . I '$D(ORDCODE) D
 . . S ORDCODE=$$GETSYN^LEXTRAN1("SCT",ORCCODE,ORDATE,"ORSYN",1,1)
 . . I $P(ORDCODE,U)'=1 S ORDCODE="" Q
 . . F  S ORTYP=$O(ORSYN(ORTYP)) Q:ORTYP="S"!(ORQT)  D
 . . . I $P(ORSYN(ORTYP),U)=ORTXT S ORDCODE=$P(ORSYN(ORTYP),U,3),ORQT=1 Q
 . . I ORTYP="S" F  S ORNUM=$O(ORSYN(ORTYP,ORNUM)) Q:ORNUM=""!(ORQT)  D
 . . . I $P(ORSYN(ORTYP,ORNUM),U)=ORTXT S ORDCODE=$P(ORSYN(ORTYP,ORNUM),U,3),ORQT=1 Q
 . I ORDCODE["^" S ORDCODE=""
 .S ORY=ORY_U_ORICD_U_ORDCODE
 E  S ORY=ORY_U_U
 Q ORY
