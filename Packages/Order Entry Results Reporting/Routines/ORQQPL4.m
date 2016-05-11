ORQQPL4 ; ISL/JER/TC - Lexicon Look-up w/Synonyms ;07/30/15  08:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**306,361,350**;Dec 17, 1997;Build 77
 ;
 ; DBIA 2950   LOOK^LEXA          ^TMP("LEXFND",$J)
 ; DBIA 1609   CONFIG^LEXSET      ^TMP("LEXSCH",$J)
 ;  ICR 5699   $$ICDDATA^ICDXCODE
 ;
 Q
LEX(LST,X,VIEW,ORDATE,ORINCSYN) ; return list after lexicon lookup
 ; Call with: X           (Required) The search text entered by the user
 ;            [VIEW]      (Optional) The Lexicon VIEW parameter (Defaults to
 ;                                   Problem List Subset (i.e., "PLS")
 ;            [ORDATE]    (Optional) the date of interest (Defaults to TODAY)
 ;            [ORINCSYN]  (Optional) Boolean flag specifying whether or not to
 ;                                   include synonyms for SNOMED CT Concepts
 ;                                   (Defaults to 0 (FALSE))
 ;
 ;   Returns: LST=gvn of ^TMP("ORLEX",$J), which contains search result set as:
 ;            ^TMP("ORLEX",$J,1..n)=LEXIEN^PREFTEXT^ICDCODE(S)^ICDIEN^CODESYS^CONCEPTID^DESIGID^ICDVER^PARENTSUBSCRIPT
 ;            ^TMP("ORLEX",$J,n+1)="<n> matches found"
 ;
 N LEX,ILST,I,IEN,APP
 S APP="GMPX",LST=$NA(^TMP("ORLEX",$J)) K @LST
 S:'+$G(ORDATE) ORDATE=DT
 S:'$L($G(VIEW)) VIEW="PLS"
 S ORINCSYN=+$G(ORINCSYN)
 I $S(X?.1A2.3N.1".".2N:1,X?.1A2.3N1"+":1,1:0) D  Q
 . S @LST@(1)="icd^Searching by code on the Problems Tab supports SNOMED CT, but not ICD."
 . S @LST@(2)="Please try a different search"
 D CONFIG^LEXSET(APP,VIEW,ORDATE)
 ; call LOOK^LEXA to execute the search as defined by the call to CONFIG^LEXSET
 D LOOK^LEXA(X,,1,,ORDATE)
 I '$D(LEX("LIST",1)) D  G LEXX
 . S:X?.N @LST@(1)="Code search failed"
 S ILST=0
 S @LST@(1)=$$LEXXFRM(LEX("LIST",1),ORDATE,APP),ILST=1
 D:ORINCSYN SYNONYMS(.LST,.ILST,"SCT",$P(@LST@(1),U,6),ORDATE)
 S (I,IEN)=""
 F  S I=$O(^TMP("LEXFND",$J,I)) Q:I=""  D  ;DBIA 2950
 .F  S IEN=$O(^TMP("LEXFND",$J,I,IEN)) Q:IEN=""  D
 ..N TXT,ELEMENT S TXT=^TMP("LEXFND",$J,I,IEN)
 ..S ELEMENT=IEN_U_TXT
 ..S ELEMENT=$$LEXXFRM(ELEMENT,ORDATE,APP)
 ..S ILST=ILST+1,@LST@(ILST)=ELEMENT
 ..D:ORINCSYN SYNONYMS(.LST,.ILST,"SCT",$P(ELEMENT,U,6),ORDATE)
 I '$D(@LST@(1)) S @LST@(1)="No matches found"
 E  S @LST@(ILST+1)=ILST_$S(ILST=1:" match",1:" matches")_" found"
LEXX K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J),^TMP("LEXSCH",$J),^TMP("LEXLE",$J)
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
 . S ILST=ILST+1,@LST@(ILST)=ELEMENT
 Q
SETELEM(ORLEX,ORTXT,ORCODSYS,ORCCODE,ORDATE,ORDCODE) ; Set List Element
 N ORY,ORIMPDT,ORICD,ORICDID,ORSYN,ORTYP,ORQT,ORNUM
 S ORIMPDT=$$IMPDATE^LEXU("10D"),(ORTYP,ORQT,ORNUM)=""
 I '$D(ORDCODE) D
 . S ORDCODE=$$GETSYN^LEXTRAN1("SCT",ORCCODE,ORDATE,"ORSYN",1,1)
 . I $P(ORDCODE,U)'=1 S ORDCODE="" Q
 . F  S ORTYP=$O(ORSYN(ORTYP)) Q:ORTYP="S"!(ORQT)  D
 . . I $P(ORSYN(ORTYP),U)=ORTXT S ORDCODE=$P(ORSYN(ORTYP),U,3),ORQT=1 Q
 . I ORTYP="S" F  S ORNUM=$O(ORSYN(ORTYP,ORNUM)) Q:ORNUM=""!(ORQT)  D
 . . I $P(ORSYN(ORTYP,ORNUM),U)=ORTXT S ORDCODE=$P(ORSYN(ORTYP,ORNUM),U,3),ORQT=1 Q
 I ORDCODE["^" S ORDCODE=""
 S ORICD=$$GETDX^ORQQPL1(ORCCODE,ORCODSYS,ORDATE)
 S ORICDID=+$$ICDDATA^ICDXCODE("DIAG",$P(ORICD,"/"),ORDATE,"E")
 S ORY=ORLEX_U_ORTXT_U_ORICD_U_ORICDID_U_ORCODSYS_U_ORCCODE_U_ORDCODE
 I (ORCODSYS["SNOMED")!(ORCODSYS["VHAT") D
 .S ORY=ORY_U_$S(ORDATE<ORIMPDT:"ICD-9-CM",1:"ICD-10-CM")
 Q ORY
