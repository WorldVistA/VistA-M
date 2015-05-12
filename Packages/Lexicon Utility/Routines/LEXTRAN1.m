LEXTRAN1 ;ISL/KER - Lexicon code and text wrapper API's ;12/19/2014
 ;;2.0;LEXICON UTILITY;**59,73,51,80,86**;Sep 23, 1996;Build 1
 ;
 ; Global Variables
 ;    ^LEX(757.32)        N/A
 ;    ^LEX(757.33)        N/A
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$GET1^DIQ          ICR   2056
 ;    $$UP^XLFSTR         ICR  10103
 ;    ^%DT                ICR  10003
 ;
GETSYN(SRC,CODE,CDT,LEXARY,IENS,ID,INC) ; Get Synonyms for a Concept
 ;
 ; Local Variables
 ;
 ; Input
 ; 
 ;   SRC     Coding System (required)
 ;   CODE    Code (required)
 ;   CDT     Effective date (optional, default TODAY)
 ;   LEXARY  Output array (optional, defaults to 'LEX')
 ;   IENS    Include expression IENs in output array (optional)
 ;             1 return IENS (2nd piece)
 ;             0 do not return IENS (default)
 ;   ID      Designation Identifiers (optional)
 ;              1 return Designation IDs (3rd piece)
 ;              0 do not return Designation IDs (default)
 ;   INC     Include Deactivated Terms (optional)
 ;              1 return Deactivated Terms
 ;              0 do not return Deactivated Terms (default)
 ;
 ; Output
 ;
 ;   If call finds an active code for the source
 ;     "1^LEXCODE"
 ;     LEX               An array containing code information
 ;     LEX("F")          Fully Specified Name^IEN^Designation ID
 ;     LEX("P")          Preferred Term^IEN^Designation ID
 ;     LEX("S",n)        Synonyms 4 Piece ^ Delimited string
 ;                          1  Synonym (required)
 ;                          2  IEN (optional)
 ;                          3  Designation ID (optional)
 ;                          4  Deactivation flag (optional)
 ;                               1 = Deactivated Synonym
 ;                              
 ;                       n is the nth Synonym
 ;
 ;   Errors:
 ;   
 ;     "-1^Code "_LEXCODE_" not yet active for "_LEXVDT
 ;         where LEXCODE is the code
 ;               LEXVDT is the versioning date
 ;             
 ;     "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 ;         where LEXSCNM is the source name
 ;               LEXCODE is the code
 ;
 ;     "-4^"_LEXSNM_" code "_LEXCODE_" not active for "_LEXVDT
 ;         where LEXSCNM is the source name
 ;               LEXCODE is the code
 ;               LEXVDT is the versioning date
 ;               
 ;   Otherwise
 ;     "-1^error text"
 ;
 N LEXSRC,LEXCODE,LEXVDT,LEXIENS,LEXDID,LEXINC S LEXSRC=$G(SRC),LEXCODE=$G(CODE)
 S LEXVDT=$G(CDT),LEXIENS=$G(IENS),LEXDID=$G(ID),LEXINC=+($G(INC))
 N LEX1,LEX2,LEX3,LEX4,LEXCIEN,LEXD,LEXDOW,LEXEX,LEXEXI,LEXFND,LEXI
 N LEXMCI,LEXOUT,LEXS,LEXSAB,LEXSNM,LEXSRD,LEXSTAT,LEXTY
 N LEXVAL S LEXSRC=$E($G(LEXSRC),1,3) S:'$L($G(LEXARY)) LEXARY="LEX"
 Q:'$L($G(LEXSRC)) (-1_U_"source not recognized")
 S LEXSRD=$$CSYS^LEXU(LEXSRC) Q:+LEXSRD'>0 (-1_U_"source not recognized")
 S LEXSAB=$P(LEXSRD,"^",2),LEXSNM=$P(LEXSRD,"^",4)
 Q:($L(LEXSAB)'=3)!('$L(LEXSNM)) (-1_U_"source not recognized")
 Q:'$L($G(LEXCODE)) -1_U_"no code specified"
 D VDT^LEXU Q:$P(LEXVDT,".",1)'?7N (-1_U_"invalid date format")
 K:$G(LEXARY)="" LEXARY
 S LEXIENS=+$G(LEXIENS) S:LEXIENS'=1 LEXIENS=0
 S LEXCIEN="",LEXVAL=0
 F  Q:LEXVAL=1  D  Q:LEXCIEN=""
 .S LEXCIEN=$O(^LEX(757.02,"CODE",LEXCODE_" ",LEXCIEN)) Q:LEXCIEN=""  D
 .I $D(^LEX(757.02,"ASRC",LEXSAB,LEXCIEN)) S LEXVAL=1 Q
 I 'LEXVAL Q -2_U_LEXSNM_" code "_LEXCODE_" not on file"
 S LEXSTAT=$$STATCHK^LEXSRC2(LEXCODE,LEXVDT,.LEXSTAT,LEXSAB)
 S:+LEXSTAT>0&($P(LEXSTAT,"^",2)>0) LEXCIEN=$P(LEXSTAT,"^",2)
 S LEXOUT=0 I +LEXSTAT=0 D
 . S LEXOUT=-4_U_LEXSNM_" code "_LEXCODE_" not active for "
 . S LEXOUT=LEXOUT_$S(LEXVDT?7N:$$FMTE^XLFDT(LEXVDT,"5Z"),1:"")
 I +LEXSTAT=-1 D
 . S LEXOUT=-8_U_$S(LEXVDT?7N:$$FMTE^XLFDT(LEXVDT,"5Z"),1:"")
 . S LEXOUT=LEXOUT_" precedes earliest activation date for code"
 I +($G(LEXCIEN))'>0 D
 . N LEXS,LEXD,LEXI,LEX1 S LEXCIEN=-1,(LEXS,LEXD,LEXI)=""
 . F  S LEXS=$O(^LEX(757.02,"ACT",LEXCODE_" ",LEXS)) Q:LEXS=""  D
 . . Q:(LEXS+1)>2  S LEXD=""
 . . F  S LEXD=$O(^LEX(757.02,"ACT",LEXCODE_" ",LEXS,LEXD)) Q:LEXD=""  S LEXI="" D
 . . . F  S LEXI=$O(^LEX(757.02,"ACT",LEXCODE_" ",LEXS,LEXD,LEXI)) Q:LEXI=""  D
 . . . . S LEX1(LEXD,LEXI)=""
 . Q:'$D(LEX1)  S LEXI=$O(LEX1(LEXVDT+.001),-1) Q:'$L(LEXI)
 . S LEXI=$O(LEX1(LEXI,""),-1) Q:'$D(^LEX(757.02,+LEXI,0))  S LEXCIEN=LEXI
 I '$D(^LEX(757.02,+($G(LEXCIEN)),0)) D  Q LEXOUT
 . S LEXOUT="-1^Code "_LEXCODE_" not yet active for "
 . S LEXOUT=LEXOUT_$S(LEXVDT?7N:$$FMTE^XLFDT(LEXVDT,"5Z"),1:"")
 S LEXMCI=$P(^LEX(757.02,+LEXCIEN,0),U,4)
 S LEXEXI="",LEXFND=0
 K LEX2 F  S LEXEXI=$O(^LEX(757.01,"AMC",LEXMCI,LEXEXI)) Q:LEXEXI=""  D
 .S LEXFND=LEXFND+1,LEX2(LEXEXI)=""
 K LEX3 S LEXEXI="" F  S LEXEXI=$O(LEX2(LEXEXI)) Q:LEXEXI=""  D
 . N LEXN1,LEXID,LEXC,LEXDEA S LEXEX=^LEX(757.01,LEXEXI,0),LEXDEA=0
 . S LEXN1=$G(^LEX(757.01,LEXEXI,1)) Q:+($G(LEXINC))'>0&($P(LEXN1,"^",5)>0)
 . S:+($G(LEXINC))>0&($P(LEXN1,"^",5)>0) LEXDEA=1
 . S LEXID="" I LEXDID>0,$L($G(LEXSRC)) D
 . . N LEXSI S LEXSI=$O(^LEX(757.03,"ASAB",LEXSRC,0)) Q:LEXSI'>0
 . . S LEXID=$O(^LEX(757.01,LEXEXI,7,"C",LEXSI,""))
 . S LEXTY=$P(^LEX(757.01,LEXEXI,1),U,2)
 . I LEXTY=1 D  Q
 . . S LEX3("P")=LEXEX_$S(+LEXEXI>0&(+($G(LEXIENS))>0):(U_LEXEXI),1:"")
 . . S:$L(LEXID) $P(LEX3("P"),"^",3)=LEXID
 . I LEXTY=8 D  Q
 . . S LEX3("F")=LEXEX_$S(+LEXEXI>0&(+($G(LEXIENS))>0):(U_LEXEXI),1:"")
 . . S:$L(LEXID) $P(LEX3("F"),"^",3)=LEXID
 . S LEXC=$O(LEX3("S"," "),-1)+1
 . S LEX3("S",LEXC)=LEXEX_$S(+LEXEXI>0&(+($G(LEXIENS))>0):(U_LEXEXI),1:"")
 . S:$L(LEXID) $P(LEX3("S",LEXC),"^",3)=LEXID
 . S:LEXDEA>0 $P(LEX3("S",LEXC),"^",4)=1
 K LEX4 M LEX4=LEX3
 S LEXFND=''$D(LEX4("F"))+''$D(LEX4("P"))+$O(LEX4("S"," "),-1)
 I $D(LEXARY),LEXARY'="LEX4" M @LEXARY=LEX4
 K LEX4 I LEXOUT=0 S LEXOUT=''LEXFND_U_LEXFND
 Q LEXOUT
 ;
GETFSN(SRC,CODE,CDT) ; Get Fully Specified Name for a Concept
 ;
 ; Input
 ;
 ;   SRC   Coding System (required)
 ;   CODE  Code (required)
 ;   CDT   Effective date (optional, default TODAY)
 ;
 ; Output
 ;
 ;   if found
 ;     "1^LEXFSN"
 ;     where LEXFSN is the fully specified name
 ;   if not found
 ;     "-8^"_LEXSCNM_" code "_LEXCODE_" has no FSN"
 ;     where LEXSCNM is the source name
 ;       
 N LEXSRC,LEXCODE,LEXVDT S LEXSRC=$G(SRC),LEXCODE=$G(CODE),LEXVDT=$G(CDT)
 N SYNS,LEX S LEXSRC=$E($G(LEXSRC),1,3)
 I $G(LEXCODE)="" Q -1_U_"no code specified"
 I $G(LEXSRC)="" Q -1_U_"no source specified"
 I +($$CSYS^LEXU(LEXSRC))'>0 Q -1_U_"source not recognized"
 I $L($G(LEXVDT)),$P($G(LEXVDT),".",1)'?7N S LEXVDT=$$INTDAT(LEXVDT)
 D VDT^LEXU I $P($G(LEXVDT),".",1)'?7N Q -1_U_"invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 S SYNS=$$GETSYN(LEXSRC,LEXCODE,$G(LEXVDT))
 I +SYNS'>0 Q SYNS
 I $D(LEX("F")) Q 1_U_LEX("F")
 Q -8_U_$$LEXSCNM(LEXSRC)_" code "_LEXCODE_" has no FSN"
 ;
GETPREF(SRC,CODE,CDT) ; Get the Preferred Term for a Code
 ;
 ; Input
 ;
 ;   SRC    Coding System (required)
 ;   CODE   Code (required)
 ;   CDT    Effective date (optional, default TODAY)
 ;
 ; Output
 ;
 ;   if found
 ;     "1^LEXPREF"
 ;     where LEXPREF is the preferred name
 ;   if not found
 ;     "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 ;     where LEXSCNM is the source name
 ;
 N LEXSRC,LEXCODE,LEXVDT S LEXSRC=$G(SRC),LEXCODE=$G(CODE),LEXVDT=$G(CDT)
 N SYNS,LEX S LEXSRC=$E($G(LEXSRC),1,3)
 I $G(LEXCODE)="" Q -1_U_"no code specified"
 I $G(LEXSRC)="" Q -1_U_"no source specified"
 I +($$CSYS^LEXU(LEXSRC))'>0 Q -1_U_"source not recognized"
 I $L($G(LEXVDT)),$P($G(LEXVDT),".",1)'?7N S LEXVDT=$$INTDAT(LEXVDT)
 D VDT^LEXU I $P($G(LEXVDT),".",1)'?7N Q -1_U_"invalid date format"
 I $G(LEXVDT)=-1 Q -1_U_"invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 S SYNS=$$GETSYN(LEXSRC,LEXCODE,$G(LEXVDT))
 I +SYNS'>0 Q SYNS
 Q 1_U_LEX("P")
 ;
GETDES(SRC,TEXT,CDT) ; Get the Designation Code for a Concept/Synonym
 ;
 ; Input
 ;
 ;   SRC    Coding System (required)
 ;   TEXT   Text (required)
 ;   CDT    Effective date (optional, default TODAY)
 ;
 ; Output
 ;
 ;   if found
 ;     "1^LEXDSG"
 ;     where LEXDSG is the designation code
 ;   if not found
 ;     "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 ;     where LEXSCNM is the source name
 ;
 N LEXSRC,LEXTEXT,LEXVDT S LEXSRC=$G(SRC),LEXTEXT=$G(TEXT),LEXVDT=$G(CDT)
 N LEXA,LEXCIEN,LEXDSG,LEXIEN,LEXMC,LEXSAB,LEXSIEN,LEXSO
 N LEXSR,LEXSRD,LEXSRI,LEXSUB,LEXTMP S LEXSRC=$E($G(LEXSRC),1,3)
 S LEXSRD=$$CSYS^LEXU(LEXSRC),LEXSAB=$P(LEXSRD,"^",2)
 S LEXSRI=+LEXSRD Q:$G(LEXSRC)="" -1_U_"no source specified"
 Q:+LEXSRI'>0 -1_U_"source not recognized"
 Q:'$L($G(LEXTEXT)) -1_U_"no text specified"
 S LEXTMP=$G(^TMP("LEXSCH",$J,"VDT",0))
 S:LEXTMP?7N LEXVDT=LEXTMP
 I $L($G(LEXVDT)),$P($G(LEXVDT),".",1)'?7N S LEXVDT=$$INTDAT(LEXVDT)
 D VDT^LEXU I $P($G(LEXVDT),".",1)'?7N Q -1_U_"invalid date format"
 ;
 ; find candidate designations
 ;
 S LEXSUB=$E($$UP^XLFSTR(LEXTEXT),1,63)
 S LEXIEN=""
 F  S LEXIEN=$O(^LEX(757.01,"B",LEXSUB,LEXIEN)) Q:LEXIEN=""  D
 .I $$UP^XLFSTR(^LEX(757.01,LEXIEN,0))=$$UP^XLFSTR(LEXTEXT) S LEXA(LEXIEN)=$P(^LEX(757.01,LEXIEN,1),U)
 S LEXIEN=""
 F  S LEXIEN=$O(LEXA(LEXIEN)) Q:LEXIEN=""  D
 . N LEXSR S LEXMC=LEXA(LEXIEN)
 . S (LEXCIEN,LEXSIEN)=""
 . F  S LEXSIEN=$O(^LEX(757.02,"AMC",LEXMC,LEXSIEN)) Q:LEXSIEN=""  D
 . . S LEXSR=$P(^LEX(757.02,LEXSIEN,0),U,3)
 . . I +($$CSYS^LEXU(LEXSRC))'=LEXSR Q
 . . I $P(^LEX(757.02,LEXSIEN,0),U,5)'=1 Q
 . . S LEXCIEN=LEXSIEN
 . I LEXCIEN="" K LEXA(LEXIEN) Q
 . ; eliminate if wrong source
 . S LEXSO=$P(^LEX(757.02,LEXCIEN,0),U,2)
 . S LEXSR=$P(^LEX(757.02,LEXCIEN,0),U,3)
 . I +($$CSYS^LEXU(LEXSRC))'=LEXSR K LEXA(LEXIEN) Q
 . ; eliminate if inactive for LEXVDT
 . I '+$$STATCHK^LEXSRC2(LEXSO,LEXVDT,,$E(LEXSRC,1,3)) K LEXA(LEXIEN) Q
 ; get the designation code
 S LEXIEN=$O(LEXA(""))
 I LEXIEN="" Q -1_U_"text not recognized for source"
 S LEXDSG=$O(^LEX(757.01,LEXIEN,7,"C",+LEXSRI,""))
 I LEXDSG="" Q -1_U_"no designation code for text and source"
 Q 1_U_LEXDSG
 ;
GETASSN(CODE,MAP,CDT,LEXRAY) ; Get Mapped Associated Codes
 ;
 ; Input
 ;
 ;   CODE     Code (required)
 ;   MAP      Mapping Identifier (VUID) or mnemonic (required)
 ;   CDT      Effective date (optional, default TODAY)
 ;   LEXRAY   Output array (defaults to 'LEX') optional
 ;
 ; Output
 ;
 ;   if found
 ;     "1^"_number_of_mappings
 ;
 ;     LEX is an array containing the mapping target codes
 ;     LEX = number of mappings
 ;     LEX(order,code)  mapped codes
 ;                      order - is the order of the mapping
 ;                      code - is the mapping target code
 ;
 ;   if not found
 ;     "0^0"
 ;
 ;   if error
 ;     "-1^"_error_message
 ;
 ;   if no code on file
 ;     "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 ;     where LEXSCNM is the source name
 ;   
 ;   Caution
 ;   -------
 ;   When the API is invoked in the following way
 ;   S VAR=$$GETASSN^LEXTRAN1(CODE,MAP,[DATE],[ARR])
 ;   
 ;   Make sure that ARR'="VAR"
 ;     e.g. S ORY=$$GETASSN^LEXTRAN1(CODE,MAP,,"VAR") is OK
 ;     but  S VAR=$$GETASSN^LEXTRAN1(CODE,MAP,,"VAR") is not OK
 ; 
 N LEXCODE,LEXMAP,LEXVDT S LEXCODE=$G(CODE),LEXMAP=$G(MAP),LEXVDT=$G(CDT)
 I $G(LEXCODE)="" Q -1_U_"no code specified"
 I $G(LEXMAP)="" Q -1_U_"no mapping specified"
 I $L($G(LEXVDT)),$P($G(LEXVDT),".",1)'?7N S LEXVDT=$$INTDAT(LEXVDT)
 D VDT^LEXU I $P($G(LEXVDT),".",1)'?7N Q -1_U_"invalid date format"
 S LEXRAY=$G(LEXRAY,"LEX")
 N MIDIEN,CSYS,CIEN,VALCD,MORD,MTAR,MIEN,EFDT,STAT,CT,VUID
 I '$D(^LEX(757.32,"B",LEXMAP)),'$D(^LEX(757.32,"C",LEXMAP)) Q -1_U_"unrecognized mapping identifier"
 I $D(^LEX(757.32,"C",LEXMAP)) D
 .S MIDIEN=$O(^LEX(757.32,"C",LEXMAP,""))
 I $D(^LEX(757.32,"B",LEXMAP)) D
 .S MIDIEN=$O(^LEX(757.32,"B",LEXMAP,""))
 I '$D(MIDIEN) Q -1_U_"not a recognized mapping identifier"
 S CSYS=$$GET1^DIQ(757.32,MIDIEN_",",3)
 ;   Check that code exists for coding system
 S CIEN="",VALCD=0
 F  Q:VALCD=1  D  Q:CIEN=""
 .S CIEN=$O(^LEX(757.02,"CODE",LEXCODE_" ",CIEN)) Q:CIEN=""  D
 .S VALCD=''$D(^LEX(757.02,"ASRC",$$LEXASAB(CSYS),CIEN))
 I 'VALCD Q -2_U_$$LEXSCNM(CSYS)_" code "_LEXCODE_" not on file"
 ;   Obtain valid mappings for date
 S (MORD,MTAR,MIEN)=""
 K LEX
 S LEX=0
 F  S MORD=$O(^LEX(757.33,"C",MIDIEN,LEXCODE,MORD)) Q:MORD=""  D
 .F  S MTAR=$O(^LEX(757.33,"C",MIDIEN,LEXCODE,MORD,MTAR)) Q:MTAR=""  D
 ..F  S MIEN=$O(^LEX(757.33,"C",MIDIEN,LEXCODE,MORD,MTAR,MIEN)) Q:MIEN=""  D
 ...N MAT S MAT=$P($G(^LEX(757.33,+MIEN,0)),U,5)
 ...S VUID=$P(^LEX(757.33,MIEN,0),U)
 ...S EFDT=+$O(^LEX(757.33,"G",VUID,LEXVDT+.0001),-1)
 ...Q:EFDT=0
 ...S STAT=+$O(^LEX(757.33,"G",VUID,EFDT,""))
 ...Q:STAT=0
 ...S LEX=LEX+1
 ...S LEX(MORD,MTAR)=MAT
 I LEXRAY'="LEX" M @LEXRAY=LEX K LEX
 Q ''@LEXRAY_U_@LEXRAY
 ;
LEXSCNM(LEXSRC) ; get source name
 N LEXI Q:'$L(LEXSRC) ""  S LEXI=+($$CSYS^LEXU(LEXSRC))'>0 Q:LEXI'>0 ""
 Q $P(^LEX(757.03,+LEXI,0),U,2)
 ;
LEXASAB(LEXSRC) ; get source abbreviation
 N LEXI Q:'$L(LEXSRC) ""  S LEXI=+($$CSYS^LEXU(LEXSRC)) Q:LEXI'>0 ""
 Q $E($P($G(^LEX(757.03,+LEXI,0)),U),1,3)
CSI(LEXSRC) ; get source IEN
 Q:'$L($E($G(LEXSRC),1,3)) -1  N LEXI S LEXI=+($$CSYS^LEXU(LEXSRC)) S:LEXI'>0 LEXI=-2
 Q +LEXI
 ;
INTDAT(X) ; convert date from external format to VA internal format
 S X=$G(X) Q:$P(X,".",1)?7N $P(X,".",1)
 N Y,%DT D ^%DT K %DT
 Q Y
 ;
GETCIEN(CODE) ; get correct code ien for code and date
 ; CODE and LEXVDT must be defined
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
