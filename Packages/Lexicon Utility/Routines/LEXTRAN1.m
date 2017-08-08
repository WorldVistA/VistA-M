LEXTRAN1 ;ISL/KER - Lexicon code and text wrapper API's ;05/23/2017
 ;;2.0;LEXICON UTILITY;**59,73,51,80,86,103**;Sep 23, 1996;Build 2
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
 ;   SRC     Coding Sys (required)
 ;   CODE    Code (required)
 ;   CDT     Effective date (default TODAY)
 ;   LEXARY  Output array (defaults to 'LEX')
 ;   IENS    Include expression IENs in output array (optional)
 ;              1 return IENS (2nd piece)
 ;              0 do not return IENS (default)
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
 N LEX2,LEX3,LEX4,LEXC,LEXCIEN,LEXCODE,LEXDEA,LEXDID,LEXEFD,LEXEX,LEXEXI,LEXFND,LEXIAD,LEXID
 N LEXIENS,LEXINC,LEXMCI,LEXN1,LEXOUT,LEXSAB,LEXSNM,LEXSRC,LEXSRD,LEXSTAT,LEXTY,LEXVDT
 ; Get Input Parameters
 S LEXSRC=$G(SRC),LEXCODE=$G(CODE),LEXVDT=$G(CDT),LEXIENS=$G(IENS),LEXDID=$G(ID),LEXINC=+($G(INC))
 ; Verify Input Parameters
 S LEXSRD=$$CSYS^LEXU(LEXSRC),LEXSAB=$P(LEXSRD,"^",2),LEXSNM=$P(LEXSRD,"^",4),LEXSRC=+LEXSRD
 Q:+LEXSRC'>0!($L(LEXSAB)'=3)!('$L(LEXSNM)) (-1_U_"source not recognized")
 Q:'$L($G(LEXCODE)) -1_U_"no code specified"
 D VDT^LEXU Q:$P(LEXVDT,".",1)'?7N (-1_U_"invalid date format")
 S LEXOUT=0 S:'$L($G(LEXARY)) LEXARY="LEX"
 S LEXIENS=+$G(LEXIENS) S:LEXIENS'=1 LEXIENS=0
 S LEXDID=+$G(LEXDID) S:LEXDID'=1 LEXDID=0
 S LEXINC=+$G(LEXINC) S:LEXINC'=1 LEXINC=0
 ; Get Code IEN, Status, Effective Date and Initial Activation Date
 S LEXSTAT=$$STATCHK^LEXSRC2(LEXCODE,LEXVDT,.LEXSTAT,LEXSAB)
 S LEXCIEN=$P(LEXSTAT,"^",2),LEXEFD=$P(LEXSTAT,"^",3),LEXIAD=$P(LEXSTAT,"^",4),LEXSTAT=+LEXSTAT
 ; Quit Conditions
 ;   Code not found
 I +LEXCIEN<0 Q (-2_U_LEXSNM_" code "_LEXCODE_" not on file")
 ;   No Effective Date (pending activation)
 I +LEXCIEN>0,LEXSTAT'>0,LEXEFD'?7N,LEXIAD'?7N D  Q:LEXINC'>0 LEXOUT
 . S LEXOUT="-4^"_LEXSNM_" code "_LEXCODE_" not yet active for "_$S(LEXVDT?7N:$$FMTE^XLFDT(LEXVDT,"5Z"),1:"")
 ;   Inactive Code
 I +LEXCIEN>0,LEXSTAT'>0,LEXEFD?7N D  Q:LEXINC'>0 LEXOUT
 . S LEXOUT="-4^"_LEXSNM_" code "_LEXCODE_" not active for "_$S(LEXVDT?7N:$$FMTE^XLFDT(LEXVDT,"5Z"),1:"")
 ; Get Terms for the Major Concept
 S LEXMCI=$P(^LEX(757.02,+LEXCIEN,0),U,4),LEXEXI="",LEXFND=0
 K LEX2 F  S LEXEXI=$O(^LEX(757.01,"AMC",LEXMCI,LEXEXI)) Q:LEXEXI=""  D
 . S LEXFND=LEXFND+1,LEX2(LEXEXI)=""
 ; Get Info for Terms
 K LEX3 S LEXEXI="" F  S LEXEXI=$O(LEX2(LEXEXI)) Q:LEXEXI=""  D
 . N LEXN1,LEXID,LEXC,LEXDEA S LEXEX=^LEX(757.01,LEXEXI,0),LEXDEA=0
 . S LEXN1=$G(^LEX(757.01,LEXEXI,1)) Q:+($G(LEXINC))'>0&($P(LEXN1,"^",5)>0)
 . S:+($G(LEXINC))>0&($P(LEXN1,"^",5)>0) LEXDEA=1
 . S LEXID="" I LEXDID>0 D
 . . S LEXID=$O(^LEX(757.01,LEXEXI,7,"C",+LEXSRC,""))
 . S LEXTY=$P(^LEX(757.01,LEXEXI,1),U,2)
 . I LEXTY=1 D  Q
 . . S LEX3("P")=LEXEX_$S(+LEXEXI>0&(+($G(LEXIENS))>0):(U_LEXEXI),1:"") S:$L(LEXID) $P(LEX3("P"),"^",3)=LEXID
 . I LEXTY=8 D  Q
 . . S LEX3("F")=LEXEX_$S(+LEXEXI>0&(+($G(LEXIENS))>0):(U_LEXEXI),1:"") S:$L(LEXID) $P(LEX3("F"),"^",3)=LEXID
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
GETDID(X,IEN) ; Get Designation ID based on Source and IEN
 ; 
 ; Input
 ; 
 ;   X         Coding Sys (required)
 ;   IEN       IEN in the Expressions file #757.01 (required)
 ;
 ; Output
 ;
 ;   $$GETDID  Designation ID
 ;   
 ;             Otherwise
 ;             
 ;             "-1^"_error message
 ;             
 S LEXSRC=$E($G(X),1,3),LEXIEN=$G(IEN) Q:+LEXIEN'>0 (-1_U_"IEN not specified")
 Q:'$L(LEXSRC) (-1_U_"source not recognized")  Q:'$D(^LEX(757.01,+LEXIEN,0)) (-1_U_"Expression entry not found")
 Q:$O(^LEX(757.01,+LEXIEN,7,0))'>0 (-1_U_"No designation IDs found")  S LEXSRD=$$CSYS^LEXU(LEXSRC)
 Q:+LEXSRD'>0 (-1_U_"source not recognized")  S LEXSAB=$P(LEXSRD,"^",2),LEXSRC=+LEXSRD
 Q:($L(LEXSAB)'=3)!(+LEXSRC'>0) (-1_U_"Invalid source")  Q:'$D(^LEX(757.03,"ASAB",LEXSAB)) (-1_U_"Invalid source")
 Q:'$D(^LEX(757.03,LEXSRC,0)) (-1_U_"Invalid source")  S LEXID="",LEXIDI=0
 F  S LEXIDI=$O(^LEX(757.01,+LEXIEN,7,LEXIDI)) Q:+LEXIDI'>0  D
 . Q:$P($G(^LEX(757.01,+LEXIEN,7,+LEXIDI,0)),"^",2)'=LEXSRC  S LEXID=$P($G(^LEX(757.01,+LEXIEN,7,+LEXIDI,0)),"^",1)
 S X=LEXID
 Q X
 ;
GETFSN(SRC,CODE,CDT) ; Get Fully Specified Name for a Concept
 ;
 ; Input
 ;
 ;   SRC   Coding Sys (required)
 ;   CODE  Code (required)
 ;   CDT   Effective date (default TODAY)
 ;
 ; Output
 ;
 ;   if found
 ;     "1^"_fully specified name
 ;   if error or not found
 ;     "-1^"_error message
 ;   if not found
 ;     "-8^"_error message
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
 ;     "1^"_preferred name
 ;   if error or not not found
 ;     "-1^"_error message
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
 ;   SRC    Coding Sys (required)
 ;   TEXT   Text (required)
 ;   CDT    Effective date (default TODAY)
 ;
 ; Output
 ;
 ;   if found
 ;     "1^"_designation code
 ;   if error or not found
 ;     "-1^"_error message
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
 . S LEXSO=$P(^LEX(757.02,LEXCIEN,0),U,2)
 . S LEXSR=$P(^LEX(757.02,LEXCIEN,0),U,3)
 . I +($$CSYS^LEXU(LEXSRC))'=LEXSR K LEXA(LEXIEN) Q
 . I '+$$STATCHK^LEXSRC2(LEXSO,LEXVDT,,$E(LEXSRC,1,3)) K LEXA(LEXIEN) Q
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
 ;   MAP      Mapping ID (VUID) or mnemonic (required)
 ;   CDT      Effective date (default TODAY)
 ;   LEXRAY   Output array (defaults 'LEX')
 ;
 ; Output
 ;
 ;   if found
 ;     "1^"_number_of_mappings
 ;
 ;     LEX is an array containing the target codes
 ;     LEX = number of mappings
 ;     LEX(order,code)  mapped codes
 ;                      order - order of the mapping
 ;                      code - target code
 ;
 ;   if not found     "0^0"
 ;   if error        "-1^"_error_message
 ;   if not on file  "-2^"_source _" code "_code_" not on file"
 ;   
 ;   Caution
 ;   -------
 ;   S VAR=$$GETASSN^LEXTRAN1(CODE,MAP,[DATE],[ARR])
 ;   
 ;   Make sure that ARR'="VAR"
 ;     S ORY=$$GETASSN^LEXTRAN1(CODE,MAP,,"VAR") is OK
 ;     S VAR=$$GETASSN^LEXTRAN1(CODE,MAP,,"VAR") is not OK
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
GETCIEN(CODE,CDT,SRC) ; Get Code IEN for Code/Date/Source
 ;
 ; Input
 ; 
 ;   CODE         Classification Code (required)
 ;   CDT          Code Set Versioning Date (optional, 
 ;                default TODAY)
 ;   SRC          Coding System pointer or Source 
 ;                Abbreviation (optional)
 ;   
 ; Output
 ; 
 ;   $$GETCIEN    3 piece "^" delimited string
 ;   
 ;                              Content
 ;                  Piece  Normal      On Error
 ;                    1    IEN         -1
 ;                    2    Status      Error Message
 ;                    3    Comment     null
 ;                 
 N LEX,LEXCDT,LEXCIEN,LEXCO,LEXCODE,LEXEFF,LEXIDT,LEXON
 N LEXOUT,LEXSAB,LEXSN,LEXSNM,LEXSRC,LEXSRD,LEXSTA
 S LEXCODE=$G(CODE) Q:'$L(LEXCODE) "-1^No code provided^"
 S LEXCDT=$G(CDT) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 S LEXSRC=$G(SRC),(LEXSAB,LEXSRD,LEXSNM)=""
 I $L(LEXSRC) D
 . S LEXSRD=$$CSYS^LEXU(LEXSRC),LEXSAB=$P(LEXSRD,"^",2)
 . S LEXSNM=$P(LEXSRD,"^",4),LEXSRC=+LEXSRD
 S LEXSN=$S($L(LEXSNM):(LEXSNM_" "),1:"")
 Q:'$D(^LEX(757.02,"CODE",(LEXCODE_" "))) ("-1^"_LEXSN_"Code "_LEXCODE_" is not on file^")
 S:$L(LEXSAB) LEX=$$STATCHK^LEXSRC2(LEXCODE,LEXCDT,,LEXSAB)
 S:'$L(LEXSAB) LEX=$$STATCHK^LEXSRC2(LEXCODE,LEXCDT)
 S LEXSTA=$P(LEX,"^",1)
 S LEXCIEN=$P(LEX,"^",2)
 S LEXEFF=$P(LEX,"^",3)
 S LEXIDT=$P(LEX,"^",4)
 S LEXCO=$S('$L(LEXSNM):"Code ",1:"code ")
 S LEXON=$S($G(LEXEFF)?7N:("on "_$$FMTE^XLFDT(LEXCDT,"5Z")),1:"")
 I +LEXCIEN'>0 D  Q LEXOUT
 . S LEXOUT="-1^"_LEXSN_LEXCO_LEXCODE_" was not found^"
 I +LEXEFF'>0 D  Q LEXOUT
 . S LEXOUT=LEXCIEN_"^0^"_LEXSN_LEXCO_LEXCODE_" is not yet active (future activation)"
 I +LEXSTA'>0,LEXEFF>0 D  Q LEXOUT
 . S LEXOUT=LEXCIEN_"^0^"_LEXSN_LEXCO_LEXCODE_" is inactive "_LEXON
 I +LEXSTA>0,LEXEFF>0,LEXIDT>0,LEXEFF>LEXIDT D  Q LEXOUT
 . S LEXOUT=LEXCIEN_"^1^"_LEXSN_LEXCO_LEXCODE_" is active "_LEXON_", but has been revised"
 I +LEXSTA>0,LEXEFF>0,LEXIDT>0,LEXEFF'>LEXIDT D  Q LEXOUT
 . S LEXOUT=LEXCIEN_"^1^"_LEXSN_LEXCO_LEXCODE_" is active "_LEXON
 S LEXOUT=LEXSN_LEXCO_LEXCODE_" "_$S(LEXSTA>0:"is active",1:"is inactive")_" "_LEXON
 S LEXOUT=LEXCIEN_"^"_+($G(LEXSTA))_"^"_LEXOUT
 Q LEXOUT
