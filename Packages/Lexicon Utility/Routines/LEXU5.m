LEXU5 ;ISL/KER - Miscellaneous Lexicon Utilities ;12/19/2014
 ;;2.0;LEXICON UTILITY;**80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.001)       N/A
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;    ^TMP("LEXTKN")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIC                ICR  10006
 ;               
IMPDATE(SYS) ; Get the Implementation Date for a Coding System
 ; 
 ; Input
 ; 
 ;   SYS       Coding System Abbreviation (757.03,.01)
 ;             or pointer to file 757.03
 ;   
 ; Output
 ; 
 ;   $$IMPDATE  Implementation Date in FileMan format
 ;   
 N FRMT,CSIEN,IMPDATE S FRMT="I" S CSIEN=$$CSYSIEN^LEXTRAN($G(SYS)) I +CSIEN<0 Q CSIEN
 S CSIEN=$P(CSIEN,U,2) S IMPDATE=$$GET1^DIQ(757.03,CSIEN,11,FRMT)
 Q IMPDATE
CSYS(SYS) ; Get Coding System Info
 ; 
 ; Input
 ; 
 ;   SYS       Coding System Abbreviation (757.03,.01)
 ;             or pointer to file 757.03
 ;    
 ; Output
 ; 
 ;     A 13 piece caret (^) delimited string 
 ;     
 ;      1    IEN 
 ;      2    SAB (3 character source abbreviation) 
 ;      3    Source Abbreviation (3-7 char)  (#.01) 
 ;      4    Nomenclature (2-11 char) (#1) 
 ;      5    Source Title (2-52 char) (#2) 
 ;      6    Source (2-50 char) (#3) 
 ;      7    Entries (numeric) (#4) 
 ;      8    Unique Entries (numeric) (#5) 
 ;      9    Inactive Version (1-20 char) (#6) 
 ;     10    HL7 Coding System (2-40 char) (#7) 
 ;     11    SDO Version Date (date) (757.08 #.01) 
 ;     12    SDO Version Id (1-40 char) (757.08 #1) 
 ;     13    Implementation Date (date) (#11)
 ;     14    Lookup Threshold (#12)
 ;     
 N LEXSYS,LEXOUT,LEXND,LEXIEN,LEXEFF,LEXVER,LEXIMP,LEXTHR
 S LEXSYS=$G(SYS) Q:'$L(LEXSYS) "-1^Coding System missing"
 S LEXIEN=$$SIEN(LEXSYS)
 Q:+LEXIEN'>0!('$D(^LEX(757.03,+LEXIEN,0))) "-1^Coding System not found"
 S LEXSYS=$$SMNEM(+LEXIEN)
 S LEXND=$G(^LEX(757.03,+LEXIEN,0))
 Q:$L(LEXND)'>3 "-1^Invalid Coding System HUH"
 S $P(LEXND,"^",8)=$P(LEXND,"^",8)
 S LEXEFF=$O(^LEX(757.03,LEXIEN,1,"B"," "),-1)
 S LEXVER=$O(^LEX(757.03,LEXIEN,1,"B",+LEXEFF),-1)
 S LEXVER=$P($G(^LEX(757.03,LEXIEN,1,+LEXVER,0)),"^",2)
 S LEXIMP=$P($G(^LEX(757.03,LEXIEN,2)),"^",1)
 S LEXTHR=$P($G(^LEX(757.03,LEXIEN,2)),"^",2)
 S LEXOUT=LEXIEN_"^"_$E(LEXND,1,3)_"^"_LEXND_"^"_LEXEFF_"^"_LEXVER_"^"_LEXIMP_"^"_LEXTHR
 Q LEXOUT
SIEN(MNEM) ; Return code system IEN for mnemonic
 Q:'$L($G(MNEM)) "-1"
 Q:$D(^LEX(757.03,"ASAB",MNEM)) $O(^LEX(757.03,"ASAB",MNEM,""))
 Q:$D(^LEX(757.03,"B",MNEM)) $O(^LEX(757.03,"B",MNEM,""))
 Q:$D(^LEX(757.03,"B",$E(MNEM,1,3))) $O(^LEX(757.03,"B",$E(MNEM,1,3),""))
 Q:$D(^LEX(757.03,"C",MNEM)) $O(^LEX(757.03,"C",MNEM,""))
 Q:MNEM?1N.N&($D(^LEX(757.03,+MNEM,0))) +MNEM
 Q "-1"
SMNEM(SIEN) ; Return code system mnemonic for IEN
 I '$D(^LEX(757.03,+($G(SIEN)),0)) Q ""
 Q $P(^LEX(757.03,SIEN,0),"^")
