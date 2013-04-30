EDPFLEX ;SLC/KCM - Lexicon Utilities ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
ICD(TEXT) ; Return Lexicon hits for TEXT
 N LEX,X,Y,I,ICD,CPT,NAME,IEN
 ;D CONFIG^LEXSET("GMPL","PL1",DT)
 ;D LOOK^LEXA(TEXT,"GMPL",999,"",DT)
 ; (just do diagnoses until we figure out CPT modifiers)
 D CONFIG^LEXSET("ICD","ICD",DT)
 D LOOK^LEXA(TEXT,"ICD",999,"",DT)
 D XML^EDPX("<items>")
 S I=0 F  S I=$O(LEX("LIST",I)) Q:I<1  D
 . N ITEM
 . S IEN=$P(LEX("LIST",I),U),X=$P(LEX("LIST",I),U,2),CPT=""
 . S ICD=$P($P(X,"ICD-9-CM ",2),")") I $L(ICD) S NAME=X ;$P(X," (ICD-9-CM")
 . E  S CPT=$P($P(X,"CPT-4 ",2),")"),NAME=X ;$P(X," (CPT-4")
 . I '$L(ICD),'$L(CPT) Q
 . S:$E(NAME,$L(NAME))="*" NAME=$E(NAME,1,$L(NAME)-2)
 . S ITEM("text")=NAME,ITEM("ien")=IEN
 . I $L(ICD) S ITEM("code")=ICD,ITEM("type")="POV",ITEM("icd")=ICD
 . I $L(CPT) S ITEM("code")=CPT,ITEM("type")="CPT",ITEM("cpt")=CPT
 . S Y=$$XMLA^EDPX("item",.ITEM) D XML^EDPX(Y)
 D XML^EDPX("</items>")
 Q
