LEXTRAN1 ;ISL/FJF/KER - Lexicon code and text wrapper API's ;01/03/2011
 ;;2.0;LEXICON UTILITY;**59,73,51**;Sep 23, 1996;Build 77
 ; Per VHA Directive 2004-038, this routine should not be modified.
GETSYN(LEXSRC,LEXCODE,LEXVDT,LEXRAY,LEXIENS) ; obtain synonyms
 ;
 ; Input
 ;
 ;   LEXSRC   code system source abbreviation e.g. SCT (SNOMED CT)
 ;            - mandatory
 ;   LEXCODE  code - mandatory
 ;   LEXVDT   effective date (defaults to current date) - optional
 ;   LEXRAY   output array (defaults to 'LEX') optional
 ;   LEXIENS  include expression IENs in output array
 ;            - optional
 ;              1 include IENS
 ;              0 exclude IENS (default)
 ;
 ; Output
 ;
 ;   if call finds an active code for the source
 ;     "1^LEXCODE"
 ;     LEX     -   an array containing information about the code
 ;     LEX("F")    fully specified name^IEN
 ;     LEX("P")    preferred term^IEN
 ;     LEX("S",n)  synonyms^IEN (n is the nth synonym)
 ;
 ;   if call cannot find specified code on file
 ;     "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 ;     where LEXSCNM is the source name
 ;
 I $G(LEXCODE)="" Q -1_U_"no code specified"
 I $G(LEXSRC)="" Q -1_U_"no source specified"
 I '$D(^LEX(757.03,"B",LEXSRC)) Q -1_U_"source not recognized"
 I $D(^TMP("LEXSCH",$J,"VDT",0)) S LEXVDT=^(0)
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q -1_U_"invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 I $G(LEXRAY)="" K LEXRAY
 S LEXIENS=+$G(LEXIENS)
 I LEXIENS'=0,LEXIENS'=1 Q -1_U_"if specified, IENS indicator must be 0 or 1"
 ;
 ; obtain source mnemonic and ASAB
 ;
 N LEXSIEN,LEXCIEN,VALCODE,LEXSTAT,LEXPIEN,T
 ;
 ;
 ; check for code existence for source
 ; 
 S LEXCIEN="",VALCODE=0
 F  Q:VALCODE=1  D  Q:LEXCIEN=""
 .S LEXCIEN=$O(^LEX(757.02,"CODE",LEXCODE_" ",LEXCIEN)) Q:LEXCIEN=""  D
 .I $D(^LEX(757.02,"ASRC",$$LEXASAB(LEXSRC),LEXCIEN)) S VALCODE=1 Q
 I 'VALCODE Q -2_U_$$LEXSCNM(LEXSRC)_" code "_LEXCODE_" not on file"
 ;
 ; now we know that the code belongs to the source and that it is known
 ; in our files
 ; check that code is valid for date
 ;
 K LEXSTAT
 K ^TMP("LEXSCH",$J)
 S LEXSTAT=$$STATCHK^LEXSRC2(LEXCODE,LEXVDT,.LEXSTAT,$E($G(LEXSRC),1,3)) ; Pch 73 adds parameter LEXSRC
 N RESP
 S RESP=0
 I +LEXSTAT=0 S RESP=-4_U_$$LEXSCNM(LEXSRC)_" code "_LEXCODE_" not active for "_$S(LEXVDT?7N:$$FMTE^XLFDT(LEXVDT,"5Z"),1:"") ; Pch 73 use external date
 I +LEXSTAT=-1 S RESP=-8_U_$S(LEXVDT?7N:$$FMTE^XLFDT(LEXVDT,"5Z"),1:"")_" precedes earliest activation date for code" ; Pch 73 use external date
 ;
 ; code is good for source for date
 ; 
 K LEX
 N CNIEN,EXIEN,ARR,FINDS,FOUND
 S LEXCIEN=$$GETCIEN(LEXCODE)
 Q:'$D(^LEX(757.02,+LEXCIEN,0)) -1_U_"code "_LEXCODE_" not yet active for "_$S(LEXVDT?7N:$$FMTE^XLFDT(LEXVDT,"5Z"),1:"") ; Pch 73 quit if date precedes activation or LEXCIEN=-1
 S CNIEN=$P(^LEX(757.02,+LEXCIEN,0),U,4) ; Pch 73 + plused LEXCIEN
 S EXIEN="",FINDS=0
 F  S EXIEN=$O(^LEX(757.01,"AMC",CNIEN,EXIEN)) Q:EXIEN=""  D
 .S FINDS=FINDS+1
 .S ARR(EXIEN)=""
 N CT,EXP,EXTYP,LEXW
 S EXIEN="",CT=0
 F  S EXIEN=$O(ARR(EXIEN)) Q:EXIEN=""  D
 .S EXP=^LEX(757.01,EXIEN,0)
 .S EXTYP=$P(^LEX(757.01,EXIEN,1),U,2)
 .I EXTYP=1 S LEXW("P")=EXP_$S(LEXIENS:U_EXIEN,1:"") Q
 .I EXTYP=8 S LEXW("F")=EXP_$S(LEXIENS:U_EXIEN,1:"") Q
 .S CT=CT+1
 .S LEXW("S",CT)=EXP_$S(LEXIENS:U_EXIEN,1:"")
 M LEX=LEXW
 S FINDS=''$D(LEX("F"))+''$D(LEX("P"))+$O(LEX("S"," "),-1) ; Pch 73 adds calculation of FINDS
 I $D(LEXRAY),LEXRAY'="LEX" M @LEXRAY=LEX K LEX
 I RESP=0 S RESP=''FINDS_U_FINDS
 Q RESP
 ;
GETFSN(LEXSRC,LEXCODE,LEXVDT) ; obtain fully specified name
 ;
 ; Input
 ;
 ;   LEXSRC   code system source abbreviation e.g. SCT (SNOMED CT)
 ;            - mandatory
 ;   LEXCODE  code - mandatory
 ;   LEXVDT   effective date (defaults to current date) - optional
 ;
 ; Output
 ;
 ;   if call finds an active code for the source
 ;     "1^LEXFSN"
 ;     where LEXFSN is the fully specified name
 ;   if call cannot find specified code on file
 ;     "-8^"_LEXSCNM_" code "_LEXCODE_" has no FSN"
 ;     where LEXSCNM is the source name
 ;       
 N SYNS,LEX
 I $G(LEXCODE)="" Q -1_U_"no code specified"
 I $G(LEXSRC)="" Q -1_U_"no source specified"
 I '$D(^LEX(757.03,"B",LEXSRC)) Q -1_U_"source not recognized"
 I $D(^TMP("LEXSCH",$J,"VDT",0)) S LEXVDT=^(0)
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q -1_U_"invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 S SYNS=$$GETSYN(LEXSRC,LEXCODE,$G(LEXVDT))
 I +SYNS'>0 Q SYNS
 I $D(LEX("F")) Q 1_U_LEX("F")
 Q -8_U_$$LEXSCNM(LEXSRC)_" code "_LEXCODE_" has no FSN"
 ;
GETPREF(LEXSRC,LEXCODE,LEXVDT) ; obtain preferred term
 ;
 ; Input
 ;
 ;   LEXSRC   code system source abbreviation e.g. SCT (SNOMED CT)
 ;            - mandatory
 ;   LEXCODE  code - mandatory
 ;   LEXVDT   effective date (defaults to current date) - optional
 ;
 ; Output
 ;
 ;   if call finds an active code for the source
 ;     "1^LEXPREF"
 ;     where LEXPREF is the preferred name
 ;   if call cannot find specified code on file
 ;     "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 ;     where LEXSCNM is the source name
 ;
 N SYNS,LEX
 I $G(LEXCODE)="" Q -1_U_"no code specified"
 I $G(LEXSRC)="" Q -1_U_"no source specified"
 I '$D(^LEX(757.03,"B",LEXSRC)) Q -1_U_"source not recognized"
 I $D(^TMP("LEXSCH",$J,"VDT",0)) S LEXVDT=^(0)
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q -1_U_"invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 S SYNS=$$GETSYN(LEXSRC,LEXCODE,$G(LEXVDT))
 I +SYNS'>0 Q SYNS
 Q 1_U_LEX("P")
 ;
GETDES(LEXSRC,LEXTEXT,LEXVDT) ; obtain designation code
 ;
 ; Input
 ;
 ;   LEXSRC   code system source abbreviation e.g. SCT (SNOMED CT)
 ;            - mandatory
 ;   LEXTEXT  displayable text of expression for which designation code is required
 ;            - mandatory
 ;   LEXVDT   effective date (defaults to current date) - optional
 ;
 ; Output
 ;
 ;   if call finds an active code for the source
 ;     "1^LEXDSG"
 ;     where LEXDSG is the designation code
 ;   if call cannot find specified code on file
 ;     "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 ;     where LEXSCNM is the source name
 ;
 I $G(LEXSRC)="" Q -1_U_"no source specified"
 I '$D(^LEX(757.03,"B",LEXSRC)) Q -1_U_"source not recognized"
 I $G(LEXTEXT)="" Q -1_U_"no text specified"
 I $D(^TMP("LEXSCH",$J,"VDT",0)) S LEXVDT=^(0)
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q -1_U_"invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 ;
 ; find candidate designations
 ;
 N CIEN,CODE,SRC,TARR,XIEN,LEXDSG,INDSUB,SCIEN,CONC
 S INDSUB=$E($$UP^XLFSTR(LEXTEXT),1,63)
 S XIEN=""
 F  S XIEN=$O(^LEX(757.01,"B",INDSUB,XIEN)) Q:XIEN=""  D
 .I $$UP^XLFSTR(^LEX(757.01,XIEN,0))=$$UP^XLFSTR(LEXTEXT) S TARR(XIEN)=$P(^LEX(757.01,XIEN,1),U)
 S XIEN=""
 F  S XIEN=$O(TARR(XIEN)) Q:XIEN=""  D
 .S CONC=TARR(XIEN)
 .S (CIEN,SCIEN)=""
 .F  S SCIEN=$O(^LEX(757.02,"AMC",CONC,SCIEN)) Q:SCIEN=""  D
 ..S SRC=$P(^LEX(757.02,SCIEN,0),U,3)
 ..I $O(^LEX(757.03,"B",LEXSRC,""))'=SRC Q
 ..I $P(^LEX(757.02,SCIEN,0),U,5)'=1 Q
 ..S CIEN=SCIEN
 .I CIEN="" K TARR(XIEN) Q
 .; eliminate if wrong source
 .S CODE=$P(^LEX(757.02,CIEN,0),U,2)
 .S SRC=$P(^LEX(757.02,CIEN,0),U,3)
 .I $O(^LEX(757.03,"B",LEXSRC,""))'=SRC K TARR(XIEN) Q
 .; eliminate if inactive for LEXVDT
 .I '+$$STATCHK^LEXSRC2(CODE,LEXVDT,,$E(LEXSRC,1,3)) K TARR(XIEN) Q   ; Pch 73 adds parameter LEXSRC
 ; get the designation code
 S XIEN=$O(TARR(""))
 I XIEN="" Q -1_U_"text not recognized for source"
 S LEXDSG=$O(^LEX(757.01,XIEN,7,"C",SRC,""))
 I LEXDSG="" Q -1_U_"no designation code for text and source"
 Q 1_U_LEXDSG
 ;
GETASSN(LEXCODE,LEXMAP,LEXVDT,LEXRAY) ;
 ; Input
 ;
 ;   LEXCODE  code - mandatory
 ;   LEXMAP   mapping identifier (VUID) or mnemonic - mandatory
 ;   LEXVDT   effective date (defaults to current date) - optional
 ;   LEXRAY   output array (defaults to 'LEX') optional
 ;
 ; Output
 ;
 ;   if call finds active mappings for passed arguments
 ;     "1^"_number_of_mappings
 ;     LEX     -        an array containing the mapping target codes
 ;     LEX = number of mappings
 ;     LEX(order,code)  mapped codes (order is the order of the mapping)
 ;                                   (code is the mapping target code)
 ;
 ;   if call finds no active mappings for passed arguments
 ;     "0^0"
 ;
 ;   if a bad argument is passed for a parameter then the call returns
 ;     "-1^"_error_message
 ;
 ;   if call cannot find specified code on file
 ;     "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 ;     where LEXSCNM is the source name
 ;   
 ;   Caution
 ;   -------
 ;   When the API is invoked in the following way
 ;   S VAR=$$GETASSN^LEXTRAN1(CODE,MAP,[DATE],[ARR])
 ;   make sure that ARR'="VAR"
 ;   e.g. S ORY=$$GETASSN^LEXTRAN1(44452003,"SCT2ICD",,"VAR") is OK
 ;   but  S VAR=$$GETASSN^LEXTRAN1(44452003,"SCT2ICD",,"VAR") is not OK
 ;        this would be akin to using the same variable for two purposes. 
 ;
 I $G(LEXCODE)="" Q -1_U_"no code specified"
 I $G(LEXMAP)="" Q -1_U_"no mapping specified"
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q -1_U_"invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 S LEXRAY=$G(LEXRAY,"LEX")
 ;
 N MIDIEN,CSYS,CIEN,VALCD,MORD,MTAR,MIEN,EFDT,STAT,CT,VUID
 ;
 I '$D(^LEX(757.32,"B",LEXMAP)),'$D(^LEX(757.32,"C",LEXMAP)) Q -1_U_"unrecognized mapping identifier"
 I $D(^LEX(757.32,"C",LEXMAP)) D
 .S MIDIEN=$O(^LEX(757.32,"C",LEXMAP,""))
 I $D(^LEX(757.32,"B",LEXMAP)) D
 .S MIDIEN=$O(^LEX(757.32,"B",LEXMAP,""))
 I '$D(MIDIEN) Q -1_U_"not a recognized mapping identifier"
 S CSYS=$$GET1^DIQ(757.32,MIDIEN_",",3)
 ;
 ; check that code exists for coding system
 ;
 S CIEN="",VALCD=0
 F  Q:VALCD=1  D  Q:CIEN=""
 .S CIEN=$O(^LEX(757.02,"CODE",LEXCODE_" ",CIEN)) Q:CIEN=""  D
 .S VALCD=''$D(^LEX(757.02,"ASRC",$$LEXASAB(CSYS),CIEN))
 I 'VALCD Q -2_U_$$LEXSCNM(CSYS)_" code "_LEXCODE_" not on file"
 ;
 ; obtain mappings that are valid for date passed
 ;
 S (MORD,MTAR,MIEN)=""
 K LEX
 S LEX=0
 F  S MORD=$O(^LEX(757.33,"C",MIDIEN,LEXCODE,MORD)) Q:MORD=""  D
 .F  S MTAR=$O(^LEX(757.33,"C",MIDIEN,LEXCODE,MORD,MTAR)) Q:MTAR=""  D
 ..F  S MIEN=$O(^LEX(757.33,"C",MIDIEN,LEXCODE,MORD,MTAR,MIEN)) Q:MIEN=""  D
 ...N MAT S MAT=$P($G(^LEX(757.33,+MIEN,0)),U,5) ; Pch 73 adds variable MAT for match
 ...S VUID=$P(^LEX(757.33,MIEN,0),U)
 ...S EFDT=+$O(^LEX(757.33,"G",VUID,LEXVDT+.0001),-1)
 ...Q:EFDT=0
 ...S STAT=+$O(^LEX(757.33,"G",VUID,EFDT,""))
 ...Q:STAT=0
 ...S LEX=LEX+1
 ...S LEX(MORD,MTAR)=MAT ; Pch 73 adds variable MAT for match
 I LEXRAY'="LEX" M @LEXRAY=LEX K LEX
 Q ''@LEXRAY_U_@LEXRAY
 ;
LEXSCNM(LEXSRC) ; get source name
 Q $P(^LEX(757.03,$O(^LEX(757.03,"B",LEXSRC,"")),0),U,2)
 ;
LEXASAB(LEXSRC) ; get source abbreviation
 Q $E($P(^LEX(757.03,$O(^LEX(757.03,"B",LEXSRC,"")),0),U),1,3)
 ;
INTDAT(X) ; convert date from external format to VA internal format
 N Y
 D ^%DT
 Q Y
 ;
GETCIEN(CODE) ; get correct code ien for code and date
 ; CODE must be defined
 ; LEXVDT must be defined
 N STA,DAT,CIEN,ARR,CDT S CDT=$G(LEXVDT)
 S (STA,DAT,CIEN)=""
 F  S STA=$O(^LEX(757.02,"ACT",CODE_" ",STA)) Q:STA=""  D
 .Q:(STA+1)>2
 .F  S DAT=$O(^LEX(757.02,"ACT",CODE_" ",STA,DAT)) Q:DAT=""  D
 ..F  S CIEN=$O(^LEX(757.02,"ACT",CODE_" ",STA,DAT,CIEN)) Q:CIEN=""  D
 ...S ARR(DAT,CIEN)=""
 Q:'$D(ARR) ("-1^No Code entry found for date "_$S(CDT?7N:$$FMTE^XLFDT(CDT,"5Z"),1:""))
 S CIEN=$O(ARR(CDT+.001),-1)
 Q:'$L(CIEN) ("-1^No Code entry found for date "_$S(CDT?7N:$$FMTE^XLFDT(CDT,"5Z"),1:""))
 S CIEN=$O(ARR(CIEN,""),-1)
 Q:'$D(^LEX(757.02,+CIEN,0)) ("-1^No Code entry found for date "_$S(CDT?7N:$$FMTE^XLFDT(CDT,"5Z"),1:""))
 Q CIEN
