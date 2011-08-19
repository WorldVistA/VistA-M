LEXTRAN ;ISL/FJF/KER - Lexicon code and text wrapper API's ;01/03/2011
 ;;2.0;LEXICON UTILITY;**41,59,73**;Sep 23, 1996;Build 10
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;
CODE(LEXCODE,LEXSRC,LEXVDT,LEXRAY) ;
 ; Lexicon wrapper application to obtain concept data for a given code
 ; and source
 ; 
 ; Input
 ; 
 ;   LEXCODE  code - mandatory
 ;   LEXSRC   code system source abbreviation e.g. SCT (SNOMED CT)
 ;            - mandatory
 ;   LEXVDT   effective date (defaults to current date) - optional
 ;   LEXRAY   output array (defaults to 'LEX') optionaL
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
 ;     where LEXSCNM is the source name
 ;           LEXCODE is the code
 ;                 
 ;   if call finds an inactive code for the source
 ;     "-4^"_LEXSCNM_" code "_LEXCODE_" not active for "_LEXVDT
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
 ; check passed parameter arguments
 ;
 I $G(LEXCODE)="" Q "-1^no code specified"
 I $G(LEXSRC)="" Q "-1^no source specified"
 I '$D(^LEX(757.03,"B",LEXSRC)) Q "-1^source not recognized"
 I $D(^TMP("LEXSCH",$J,"VDT",0)) S LEXVDT=^(0)
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q "-1^invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 I $G(LEXRAY)="" K LEXRAY
 ;
 ; obtain source mnemonic and ASAB
 ;
 N LEXSCNM,LEXSIEN,LEXASAB,LEXCIEN,VALCODE,LEXSTAT,LEXPIEN,T
 ;
 S LEXSIEN=$O(^LEX(757.03,"B",LEXSRC,""))
 S T=^LEX(757.03,LEXSIEN,0)
 S LEXSCNM=$P(T,U,2)
 S LEXASAB=$E($P(T,U),1,3)
 ;
 ; check for code existence for source
 ; 
 S LEXCIEN="",VALCODE=0
 F  Q:VALCODE=1  D  Q:LEXCIEN=""
 .S LEXCIEN=$O(^LEX(757.02,"CODE",LEXCODE_" ",LEXCIEN)) Q:LEXCIEN=""  D
 .I $D(^LEX(757.02,"ASRC",LEXASAB,LEXCIEN)) S VALCODE=1 Q
 I 'VALCODE Q "-2^"_LEXSCNM_" code "_LEXCODE_" not on file"
 ;
 ; now we know that the code belongs to the source and that it is known
 ; in our files
 ; check that code is valid for date
 ;
 K LEXSTAT,LEX
 K ^TMP("LEXSCH",$J)
 S LEXSTAT=$$STATCHK^LEXSRC2(LEXCODE,LEXVDT,.LEXSTAT,$E($G(LEXSRC),1,3)) ; Pch 73 adds parameter LEXSRC
 I +LEXSTAT=0 D  Q "-4^"_LEXSCNM_" code "_LEXCODE_" not active for "_LEXVDT
 .S LEXPIEN=$P(LEXSTAT(1),U)
 .;D INFO^LEXA(LEXPIEN)
 .D GETINFO
 .I $D(LEXRAY),LEXRAY'="LEX" M @LEXRAY=LEX K LEX
 ;
 ; if we've got this far we have a good code that is active
 S LEXPIEN=$P(LEXSTAT(1),U)
 ;Q "1^"_LEXCODE
 ;D INFO^LEXA(LEXPIEN)
 D GETINFO
 I $D(LEXRAY),LEXRAY'="LEX" M @LEXRAY=LEX K LEX
 ; 
 Q "1^"_LEXCODE
 ;
GETINFO ; obtain information for code and populate LEX array
 ;
 N LEXFSN,LEXHIER,LEXLGY,LEXVER,N,LEXSEP,I
 ;I $D(LEX("SEL","EXP","C","FUL")) D
 ;.S LEXFSN=LEX("SEL","EXP",$O(LEX("SEL","EXP","C","FUL","")))
 ;.S LEXHIER=$P($P(LEXFSN,"(",$L(LEXFSN,"(")),")")
 ; designations
 S LEX=$$GETSYN^LEXTRAN1(LEXSRC,LEXCODE,LEXVDT)
 ; legacy code
 S LEXLGY=$$GET1^DIQ(757.02,LEXCIEN_",",13)
 ; hierarchy
 I $D(LEX("F")) S LEXHIER=$P($P(LEX("F"),"(",$L(LEX("F"),"(")),")")
 ; version
 S LEXVER=$$VERSION(LEXSRC,LEXCODE,LEXVDT)
 ; create return array
 ;S LEXSEP=" ["_LEXCODE_"]"
 S LEX(0)=LEXCODE_U_$G(LEXHIER)_U_$S(+LEXVER=-1:"",1:$P(LEXVER,U,3))
 S LEX(0)=LEX(0)_U_LEXLGY_U_+LEXSTAT
 I $D(LEX("F")) S LEXHIER=$P($P(LEX("F"),"(",$L(LEX("F"),"(")),")")
 ;S LEX("P")=$P(LEX("SEL","EXP",$O(LEX("SEL","EXP","C","MAJ",""))),U,2)
 ;I $D(LEXFSN) S LEX("F")=$P(LEXFSN,"^",2)
 ;S N=""
 ;F I=1:1 S N=$O(LEX("SEL","EXP","C","SYN",N)) Q:N=""  D
 ;.S LEX("S",I)=$P(LEX("SEL","EXP",N),U,2)
 K LEX("SEL")
 Q
 ;
TEXT(LEXTEXT,LEXVDT,LEXSUB,LEXSRC,LEXRAY) ;
 ;
 ; Lexicon wrapper application to obtain concept data for a given text
 ; and source
 ; 
 ; Input
 ;   
 ;   LEXTEXT  the search string - mandatory
 ;   LEXVDT   effective date (defaults to current date) - optional
 ;   LEXSUB   subset or 'hierarchy' - optional
 ;   LEXSRC   code system source abbreviation e.g. SCT (SNOMED CT)
 ;            - optional
 ;   LEXRAY   output array  (defaults to 'LEX')- optional
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
 ;   otherwise
 ;     "-1^error text" 
 ; 
 ;   example of LEX array:
 ;     LEX(0)="67922002^Substance^20050701^T-C2500^1"
 ;     LEX("F")="Serum (Substance)"
 ;     LEX("P")="Serum"
 ;     
 I $G(LEXTEXT)="" Q "-1^no search string specified"
 S LEXSRC=$G(LEXSRC)
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q "-1^invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 S LEXSRC=$G(LEXSRC)
 S LEXSUB=$G(LEXSUB) I LEXSUB="" S LEXSUB=LEXSRC
 I $G(LEXRAY)="" K LEXRAY
 ;
 N X,LEXPIEN,LEXCODE,LEXSTAT,LEXCIEN,Y
 K ^TMP("LEXSCH",$J),LEX
 S X=LEXTEXT
 D CONFIG^LEXSET(LEXSRC,LEXSUB,LEXVDT)
 D EN^LEXA1
 I +Y=-1 Q "-1^search could not find term"
 ;
 S LEXPIEN=+Y
 D INFO^LEXA(LEXPIEN)
 S LEXCODE=$O(LEX("SEL","SRC","C",""))
 S LEXSTAT=$$STATCHK^LEXSRC2(LEXCODE,LEXVDT,.LEXSTAT,$E(LEXSRC,1,3)) ; Pch 73 adds parameter LEXSRC
 S LEXCIEN=$P(LEXSTAT,U,2)
 S LEXSRC=$P(LEXSTAT(2),U,2)
 D GETINFO
 I $D(LEXRAY),LEXRAY'="LEX" M @LEXRAY=LEX K LEX
 Q "1^"_LEXPIEN
 ;
VERSION(LEXSRC,LEXCODE,LEXVDT) ;
 ; infer version of code
 ; Input
 ;   
 ;   LEXSRC   code system source abbreviation e.g. SCT (SNOMED CT)
 ;   LEXCODE  code - mandatory
 ;   LEXVDT   effective date (defaults to current date) - optional
 ;            - optional
 ;   
 ; Output
 ; 
 ;   1^Version
 ;     or
 ;   -1^error message
 ;      
 I $G(LEXVDT)'="" S LEXVDT=$$INTDAT(LEXVDT)
 I $G(LEXVDT)=-1 Q "-1^invalid date format"
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 I $G(LEXSRC)="" Q "-1^invalid source" ; Pch 73 adds quit if LEXSRC is missing
 N SIEN,VIEN,VDAT,LEXSTAT
 S SIEN=$O(^LEX(757.03,"B",LEXSRC,""))
 I '$D(^LEX(757.03,SIEN,1)) Q "-1^No source version data available"
 S LEXSTAT=$$STATCHK^LEXSRC2(LEXCODE,LEXVDT,.LEXSTAT,$E($G(LEXSRC),1,3)) ; Pch 73 adds parameter LEXSRC
 I +LEXSTAT=0 Q "-1^Code not active for date specified"
 S VDAT=$O(^LEX(757.03,SIEN,1,"B",LEXVDT+1),-1)
 S VIEN=$O(^LEX(757.03,SIEN,1,"B",VDAT,""))
 Q "1^"_^LEX(757.03,SIEN,1,VIEN,0)
 ;
 ;
TXT4CS(LEXTEXT,LEXSRC,LEXRAY,LEXSUB) ; Is text valid for an SCT code
 ;
 ; Input
 ; 
 ;   LEXTEXT is term being checked
 ;   LEXSRC is code system mnemonic or IEN
 ;   LEXRAY   output array (defaults to 'LEX') optional
 ;   LEXSUB   subset or 'hierarchy' - optional
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
 ....S HIER=$P(LAR(0),U,2)
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
CSYSIEN(MNEM) ; return code system IEN for mnemonic
 I '$D(^LEX(757.03,"B",MNEM)) Q "-1^code system unknown in Lexicon"
 Q "1^"_$O(^LEX(757.03,"B",MNEM,""))
 ;
CSYSMNEM(SIEN) ; return code system mnemonic for IEN
 I '$D(^LEX(757.03,SIEN)) Q "-1^code system unknown in Lexicon"
 Q "1^"_$P(^LEX(757.03,SIEN,0),"^")
 ;
INTDAT(X) ; convert date from external format to VA internal format
 N Y
 D ^%DT
 Q Y
