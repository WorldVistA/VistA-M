LEXTRAN ;ISL/KER - Lexicon code and text wrapper API's ;12/19/2014
 ;;2.0;LEXICON UTILITY;**41,59,73,80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.011)       N/A
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^%DT                ICR  10003
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
CODE(CODE,SRC,CDT,LEXRAY,IENS,ID,INC) ; Get the Concept for a Code and Source
 ;
 ; Input
 ;
 ;   CODE     Code (required)
 ;   SRC      Code System source abbreviation (required)
 ;   CDT      Effective Date (optional, default TODAY)
 ;   LEXRAY   Output array (optional, defaults to 'LEX')
 ;   IENS    Include expression IENs in output array
 ;            - optional
 ;              1 return IENS (2nd piece)
 ;              0 do not return IENS (default)
 ;   ID      Designation Identifiers
 ;            - optional
 ;              1 return Designation IDs (3rd piece)
 ;              0 do not return Designation IDs (default)
 ;   INC     Include Deactivated Expressions
 ;            - optional
 ;              1 return Deactivated Expressions
 ;              0 do not return Deactivated Expressions (default)
 ;   
 ; Output
 ; 
 ;   if call finds an active code for the source
 ;     "1^LEXCODE"
 ;     LEX     -   an array containing information about the code
 ;     LEX(0)  -   a five piece string:
 ;                 1. code
 ;                 2. hierarchy
 ;                 3. version
 ;                 4. legacy code
 ;                 5. code status
 ;     LEX("F")    fully specified name
 ;     LEX("P")    preferred term
 ;     LEX("S",n)  synonyms (n is the nth synonym)
 ;     
 ;   if call cannot find specified code on file
 ;     "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 ;         where LEXSCNM is the source name
 ;               LEXCODE is the code
 ;                 
 ;   if call finds an inactive code for the source
 ;     "-4^"_LEXSCNM_" code "_LEXCODE_" not active for "_LEXVDT
 ;         where LEXSCNM is the source name
 ;               LEXCODE is the code
 ;               LEXVDT is the versioning date
 ;     
 ;     LEX    - an array containing information about the code
 ;     LEX(0) -  a five piece string:
 ;               1. code
 ;               2. hierarchy
 ;               3. version
 ;               4. legacy code
 ;               5. code status
 ;     
 ;   otherwise
 ;     "-1^error text" 
 ; 
 ;   example of LEX array:
 ;     LEX(0)="67922002^Substance^20050701^T-C2500^1"
 ;     LEX("F")="Serum (Substance)"
 ;     LEX("P")="Serum"
 ;                        
 N LEXCODE,LEXSRC,LEXVDT,LEXIENS,LEXDID,LEXINC
 S LEXCODE=$G(CODE),LEXSRC=$G(SRC),LEXVDT=$G(CDT)
 I $G(LEXCODE)="" Q "-1^no code specified"
 S LEXIENS=$G(IENS),LEXDID=$G(ID),LEXINC=+($G(INC))
 S LEXSRC=$E($G(LEXSRC),1,3) I $G(LEXSRC)="" Q "-1^no source specified"
 I +($$CSYS^LEXU(LEXSRC))'>0 Q "-1^source not recognized"
 I $D(^TMP("LEXSCH",$J,"VDT",0)) S LEXVDT=^(0)
 D:'$L($G(LEXVDT)) VDT^LEXU
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q "-1^invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 I $G(LEXRAY)="" K LEXRAY
 N LEXSCNM,LEXSIEN,LEXASAB,LEXCIEN,VALCODE,LEXSTAT,LEXPIEN,LEXST
 S LEXSIEN=+($$CSYS^LEXU(LEXSRC))
 S LEXST=^LEX(757.03,LEXSIEN,0)
 S LEXSCNM=$P(LEXST,U,2)
 S LEXASAB=$E($P(LEXST,U),1,3)
 S LEXCIEN="",VALCODE=0
 F  Q:VALCODE=1  D  Q:LEXCIEN=""
 .S LEXCIEN=$O(^LEX(757.02,"CODE",LEXCODE_" ",LEXCIEN)) Q:LEXCIEN=""  D
 .I $D(^LEX(757.02,"ASRC",LEXASAB,LEXCIEN)) S VALCODE=1 Q
 I 'VALCODE Q "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 K LEXSTAT,LEX
 K ^TMP("LEXSCH",$J)
 S LEXSTAT=$$STATCHK^LEXSRC2(LEXCODE,LEXVDT,.LEXSTAT,$E($G(LEXSRC),1,3)) ; Pch 73 adds parameter LEXSRC
 I +LEXSTAT=0 D  Q "-4^"_LEXSCNM_" code "_LEXCODE_" not active for "_LEXVDT
 .S LEXPIEN=$P(LEXSTAT(1),U)
 .D GETINFO
 .I $D(LEXRAY),LEXRAY'="LEX" M @LEXRAY=LEX K LEX
 S LEXPIEN=$P(LEXSTAT(1),U)
 D GETINFO
 I $D(LEXRAY),LEXRAY'="LEX" M @LEXRAY=LEX K LEX
 Q "1^"_LEXCODE
 ;
GETINFO ; Get Information for a Code
 N LEXFSN,LEXHIER,LEXLGY,LEXVER,N,LEXSEP,I
 S LEXSRC=$E($G(LEXSRC),1,3)
 S LEX=$$GETSYN^LEXTRAN1(LEXSRC,LEXCODE,LEXVDT,,$G(LEXIENS),$G(LEXDID),$G(LEXINC))
 S LEXLGY=$$GET1^DIQ(757.02,LEXCIEN_",",13)
 I $D(LEX("F")) S LEXHIER=$P($P(LEX("F"),"(",$L(LEX("F"),"(")),")")
 S LEXVER=$$VERSION(LEXSRC,LEXCODE,LEXVDT)
 S LEX(0)=LEXCODE_U_$G(LEXHIER)_U_$S(+LEXVER=-1:"",1:$P(LEXVER,U,3))
 S LEX(0)=LEX(0)_U_LEXLGY_U_+LEXSTAT
 I $D(LEX("F")) S LEXHIER=$P($P(LEX("F"),"(",$L(LEX("F"),"(")),")")
 K LEX("SEL")
 Q
 ;
TEXT(TEXT,CDT,SUB,SRC,LEXRAY) ; Get the Concept for a text and source
 ; 
 ; Input
 ;   
 ;   TEXT     The search string (required)
 ;   CDT      Effective date (optional, default is TODAY)
 ;   SUB      Subset or 'hierarchy' (optional)
 ;   SRC      Code System source abbreviation
 ;   LEXRAY   Output array (optional, defaults to 'LEX')
 ;   
 ; Output
 ;    
 ;   LEX or passed array name    - an array containing information
 ;                                 about the code
 ;     LEX(0) -  a five piece string:
 ;               1. code
 ;               2. hierarchy
 ;               3. version
 ;               4. legacy code
 ;               5. code status
 ;               
 ;     LEX("F")    fully specified name ^ internal entry number
 ;     LEX("P")    preferred term ^ internal entry number
 ;     LEX("S",n)  synonyms (n is the nth synonym) ^ internal entry number
 ;     
 ;   otherwise
 ;     "-1^error text" 
 ; 
 ;   example of LEX array:
 ;     LEX(0)="67922002^Substance^20050701^T-C2500^1"
 ;     LEX("F")="Serum (Substance)"
 ;     LEX("P")="Serum"
 ;     
 N LEXTEXT,LEXVDT,LEXDT,LEXTD,LEXSUB,LEXSRC,LEXNOM,LEXID,DIC K LEX
 S LEXTEXT=$G(TEXT),LEXVDT=$G(CDT),LEXSUB=$G(SUB),LEXSRC=$G(SRC)
 I $G(LEXTEXT)="" Q "-1^no search string specified"
 S LEXSRC=$P($$CSYS^LEXU(LEXSRC),"^",2),LEXNOM=""
 S:$L(LEXSRC) LEXNOM=$P($G(^LEX(757.03,+($O(^LEX(757.03,"ASAB",LEXSRC,0))),0)),"^",2)
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q "-1^invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 S LEXDT=LEXVDT,LEXSUB=$G(LEXSUB) I LEXSUB="" S LEXSUB=LEXSRC
 K:$G(LEXRAY)="" LEXRAY
 N X,LEXPIEN,LEXCODE,LEXSTAT,LEXCIEN,Y
 K ^TMP("LEXSCH",$J),LEX S X=LEXTEXT
 D CONFIG^LEXSET(LEXSRC,LEXSUB,LEXVDT)
 S LEXVDT=LEXDT D EN^LEXA1 Q:+($G(Y))=-1 "-1^search could not find term"
 S LEXPIEN=+Y D INFO^LEXA(LEXPIEN) S LEXCODE="",LEXSTAT=-1 I $L(LEXNOM) D
 . S LEXID=$O(LEX("SEL","SRC","B",LEXNOM,0))
 . S LEXCODE=$P($G(LEX("SEL","SRC",+LEXID)),"^",2)
 I '$L(LEXCODE),$D(LEX("SEL","SRC","C")) D
 . S LEXCODE=$O(LEX("SEL","SRC","C",""))
 S LEXCIEN=0 I $L(LEXCODE) D
 . S LEXSTAT=$$STATCHK^LEXSRC2(LEXCODE,LEXVDT,.LEXSTAT,$E(LEXSRC,1,3))
 . S LEXCIEN=$P(LEXSTAT,U,2),LEXSRC=$E($P($G(LEXSTAT(2)),U,2),1,3)
 D GETINFO
 I $D(LEXRAY),LEXRAY'="LEX" M @LEXRAY=LEX K LEX
 Q "1^"_LEXPIEN
 ;
VERSION(SRC,CODE,VDT) ; Get the Code Version Number
 ;
 ; Input
 ;   
 ;   SRC      Code System source abbreviation e.g. SCT (SNOMED CT)
 ;   CODE     Code - mandatory
 ;   VDT      Effective date (defaults to current date) - optional
 ;             - optional
 ;   
 ; Output
 ; 
 ;   1^Version
 ;     or
 ;   -1^error message
 ;      
 N LEXSRC,LEXCODE,LEXVDT S LEXSRC=$G(SRC),LEXCODE=$G(CODE),LEXVDT=$G(VDT)
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q "-1^invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 S LEXSRC=$E($G(LEXSRC),1,3) I $G(LEXSRC)="" Q "-1^invalid source"
 N SIEN,VIEN,VDAT,LEXSTAT
 S SIEN=+($$CSYS^LEXU(LEXSRC))
 I '$D(^LEX(757.03,+SIEN,1)) Q "-1^No source version data available"
 S LEXSTAT=$$STATCHK^LEXSRC2(LEXCODE,LEXVDT,.LEXSTAT,$E($G(LEXSRC),1,3)) ; Pch 73 adds parameter LEXSRC
 I +LEXSTAT=0 Q "-1^Code not active for date specified"
 S VDAT=$O(^LEX(757.03,SIEN,1,"B",LEXVDT+1),-1)
 S VIEN=$O(^LEX(757.03,SIEN,1,"B",VDAT,""))
 Q "1^"_^LEX(757.03,SIEN,1,VIEN,0)
 ;
TXT4CS(TEXT,SRC,LEXRAY,SUB) ; Is text valid for an SCT code
 ;
 ; Input
 ; 
 ;   TEXT      Text to check
 ;   SRC       Coding System Mnemonic or IEN
 ;   LEXRAY    Output array (optional, defaults to 'LEX')
 ;   SUB       Subset or 'hierarchy' (optional)
 ;   
 ; Output
 ; 
 ;   1^no of finds
 ;   
 ;     plus
 ;     
 ;   LEX or passed array name - an array containing
 ;   
 ;          LEX(<code>,<seq>)= expression type ^ code IEN ^ expression IEN
 ;          
 ;     e.g. LEX(123.5,1)="MAJOR CONCEPT^119085^112525"
 ;          LEX(123.5,2)="SYNONYM^119094^112526"
 ;      or
 ;      
 ;   -1^error message
 ;   
 N LEXTEXT,LEXSRC,LEXSUB S LEXTEXT=$G(TEXT),LEXSRC=$G(SRC),LEXSUB=$G(SUB)
 N CODEC,EXP,EXIEN,MCIEN,FOUND,CIEN,CODE,EXPTYP,FINDS,LAR,HIER,HIERNAM,LEXW ; Pch 73 adds variable CODEC
 I $G(LEXTEXT)="" Q "-1^text not specified"
 I $G(LEXSRC)="" Q "-1^code system not specified"
 I $$CSYSIEN(LEXSRC)+$$CSYSMNEM(LEXSRC)=-2 Q "-1^code system unknown in Lexicon"
 I $G(LEXRAY)="" K LEXRAY
 S LEXSUB=$G(LEXSUB)
 I LEXSUB'="",'$D(^LEXT(757.2,"AA",LEXSUB)) Q "-1^hierarchy unknown in Lexicon"
 S:LEXSRC?.N LEXSRC=$P($$CSYSMNEM(LEXSRC),"^",2)
 ; text IEN's in 757.01
 I '$D(^LEX(757.01,"B",$E($$UP^XLFSTR(LEXTEXT),1,63))) Q "-1^expression unknown in Lexicon"
 ; build an array of expression IENs for text
 S EXIEN=""
 F  S EXIEN=$O(^LEX(757.01,"B",$E($$UP^XLFSTR(LEXTEXT),1,63),EXIEN)) Q:EXIEN=""  D   ; Pch 73 adds $Extract
 .S:$$UP^XLFSTR($G(^LEX(757.01,+EXIEN,0)))=$$UP^XLFSTR(LEXTEXT) EXP(EXIEN)="" ; Pch 73 adds exact match check
 ; scan array to find code for expression (LEXTEXT) for code system (LEXSRC)
 S EXIEN=""
 K LEXW
 S (FOUND,FINDS)=0
 F  S EXIEN=$O(EXP(EXIEN)) Q:EXIEN=""  D
 .S MCIEN=$P(^LEX(757.01,EXIEN,1),U)
 .; Pch 73 moved EXPTYP into CIEN loop
 .S CIEN="" F  S CIEN=$O(^LEX(757.02,"AMC",MCIEN,CIEN)) Q:CIEN=""  D
 ..I $P($$CSYSMNEM($P(^LEX(757.02,CIEN,0),U,3)),U,2)=LEXSRC D
 ...S CODE=$P(^LEX(757.02,CIEN,0),U,2)
 ...S (HIER,HIERNAM)=""
 ...I LEXSUB'="" D
 ....K LAR
 ....S LAR=$$CODE(CODE,"SCT",,"LAR")
 ....S HIER=$P($G(LAR(0)),U,2)
 ....S HIERNAM=$P(^LEXT(757.2,$O(^LEXT(757.2,"AA",LEXSUB,"")),0),U)
 ...I LEXSUB'="",HIER'=HIERNAM Q
 ...S FOUND=1
 ...S FINDS=FINDS+1
 ...S CODEC=$O(LEXW(CODE," "),-1)+1 ; Pch 73 adds counter for multiple entries for code
 ...S EXPTYP=$P(^LEX(757.011,$P(^LEX(757.01,+($G(^LEX(757.02,CIEN,0))),1),U,2),0),U) ; Pch 73 moved from EXIEN loop
 ...S LEXW(CODE,CODEC)=EXPTYP_"^"_CIEN_"^"_+($G(^LEX(757.02,CIEN,0))) ; Pch 73 adds code IEN and expression IEN to output
 M LEX=LEXW
 I $D(LEXRAY),LEXRAY'="LEX" M @LEXRAY=LEX K LEX
 Q FOUND_"^"_FINDS
 ;
CSYSIEN(MNEM) ; Return code system IEN for mnemonic
 Q:'$L($G(MNEM)) "-1^invalid code system" N LEXIEN
 S LEXIEN=+($$CSYS^LEXU(MNEM)) Q:LEXIEN>0 "1^"_LEXIEN
 Q "-1^code system unknown in Lexicon"
 ;
CSYSMNEM(SIEN) ; Return code system mnemonic for IEN
 S SIEN=+($$CSYS^LEXU($G(SIEN)))
 I '$D(^LEX(757.03,+($G(SIEN)),0)) Q "-1^code system unknown in Lexicon"
 Q "1^"_$E($P(^LEX(757.03,SIEN,0),"^"),1,3)
 ;
INTDAT(X) ; Convert date from external format to VA internal format
 N Y,%DT
 D ^%DT
 Q Y
