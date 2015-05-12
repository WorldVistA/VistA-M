EDPFLEX ;SLC/KCM - Lexicon Utilities ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;**2**;Feb 24, 2012;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;    $$DIAGSRCH^LEX10CS      ICR   5681
 ;....CONFIG^LEXSET...........ICR...1609
 ;....LOOK^LEXA...............ICR...2950
 ;
ICD(TEXT) ; Return Lexicon hits for TEXT
 ; Begin EDP*2.0*2 changes drp 04052012 
 N LEX,X,Y,I,ICD,CPT,NAME,IEN,EDPCSYS,EDPRTN,EDPDOI,EDPMSG,EDPLMT
 S EDPDOI=$P(REQ("inTS",1),"."),EDPLMT='($G(REQ("ignoreThreshold",1),0)),EDPMSG=0
 S EDPCSYS=$$CSYS^EDPLEX(EDPDOI),EDPICDVER=$$VER^EDPLEX(EDPCSYS) ;drp
 ; Add validation for ICDVER after the set.
 D CONFIG^LEXSET("ICD","ICD",EDPDOI)
 I EDPCSYS="ICD" D LOOK^LEXA(TEXT,"ICD",999,"",EDPDOI) D ICD9(.LEX)
 I EDPCSYS="10D" D
 . S EDPMSG=$$TOOHI^EDPLEX(TEXT,EDPCSYS,EDPLMT)
 . I EDPLMT,+EDPMSG S LEX(1,"MSG")=$P(EDPMSG,U,2)
 . I '+EDPMSG S EDPRTN=$$DIAGSRCH^LEX10CS(TEXT,.LEX,EDPDOI,999) D
 . . S:+EDPRTN=-1 LEX(1,"MSG")=$S($P($G(EDPRTN),"^",2):$P($G(EDPRTN),"^",2),1:"NO MATCH FOUND")
 . .Q
 . S LEX(1,"2HI")=+EDPMSG
 . D ICD10(.LEX)
 .Q
 K EDPICDVER
 Q
 ;
ICD9(LEX) ; BUILD ICD 9 SEARCH ARRAY 
 ; this tag was renamed, but is essentially the old code with one change.
 N I,ITEM
 D XML^EDPX("<items>")
 S I=0 F  S I=$O(LEX("LIST",I)) Q:I<1  D
 . K ITEM
 . S IEN=$P(LEX("LIST",I),U),X=$P(LEX("LIST",I),U,2),CPT=""
 . ;replaced line below with one that follows
 . ;S ICD=$P($P(X,"ICD-9-CM ",2),")") I $L(ICD) S NAME=X
 . S ICD=$P($P(X,EDPICDVER_" ",2),")") I $L(ICD) S NAME=X ;$P(X,"ICD-9-CM ",2) removed hardcoded ref drp
 . E  S CPT=$P($P(X,"CPT-4 ",2),")"),NAME=X ;$P(X," (CPT-4")
 . I '$L(ICD),'$L(CPT) Q
 . S:$E(NAME,$L(NAME))="*" NAME=$E(NAME,1,$L(NAME)-2)
 . S ITEM("text")=NAME,ITEM("ien")=IEN,ITEM("icdType")=EDPICDVER
 . I $L(ICD) S ITEM("code")=ICD,ITEM("type")="POV",ITEM("icd")=ICD
 . I $L(CPT) S ITEM("code")=CPT,ITEM("type")="CPT",ITEM("cpt")=CPT
 . S Y=$$XMLA^EDPX("item",.ITEM) D XML^EDPX(Y)
 D XML^EDPX("</items>")
 Q
ICD10(LEX) ; BUILD ICD 10 SEARCH ARRAY THERE ARE NO CPT'S
 ;tag added 04052012 drp EDP*2.0*2
 N I,ITEM
 D XML^EDPX("<items>")
 S I=0 F  S I=$O(LEX(I)) Q:I<1  D
 . K ITEM S X=""
 . S ITEM("thresholdReached")=$G(LEX(1,"2HI"),-1) ; Value should be 0 or 1, -1 denotes error state
 . S:$D(LEX(I,"MSG")) ITEM("userMessage")=LEX(I,"MSG")
 . S:$D(LEX(I,"IDS",1)) IEN=$P(LEX(I,"IDS",1),U),X=LEX(I,"IDS"),ITEM("childrenCount")=0
 . S:$D(LEX(I,"CAT")) IEN="",X=LEX(I,"MENU"),ITEM("childrenCount")=$P(LEX(I,0),U,3)
 . S ICD=$P($G(LEX(I,0),$G(LEX(I,"MSG"))),U) I $L(ICD),$L(X) S NAME=X_" ("_$G(EDPICDVER)_" "_ICD_")"
 . I '$L(ICD) Q 
 . I $G(NAME)'="" S:$E(NAME,$L(NAME))="*" NAME=$E(NAME,1,$L(NAME)-2)
 . S ITEM("text")=$G(NAME),ITEM("icdType")=EDPICDVER
 . S:$G(IEN)'="" ITEM("ien")=IEN
 . I $L(ICD) S ITEM("code")=ICD,ITEM("type")="POV",ITEM("icd")=ICD
 . ;M ITEM(I)=LEX(I)
 . S Y=$$XMLQA^EDPX("item",.ITEM) D XML^EDPX(Y)
 .Q
 D XML^EDPX("</items>")
 Q
