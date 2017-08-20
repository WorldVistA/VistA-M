LEXU5 ;ISL/KER - Miscellaneous Lexicon Utilities ;05/23/2017
 ;;2.0;LEXICON UTILITY;**80,86,103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.001)       N/A
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;    ^TMP("LEXTKN")      SACC 2.3.2.5.1
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ^DIWP               ICR  10011
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
PR(LEX,X) ;   Parse Array into Specified String Lengths
 ;  
 ; Input
 ;  
 ;   .LEX(n)    Local Array of Text passed by reference
 ;   X          Length of the Text strings in the output
 ;  
 ;  
 ; Output
 ; 
 ;   LEX        Number of lines in array LEX(n)
 ;   LEX(n)     Local Array of Text in the specified string
 ;              Lengths
 ;  
 N %,D,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,LEXI,LEXLEN,LEXC,Z K ^UTILITY($J,"W") Q:'$D(LEX)  D PRMN(.LEX,500)
 S LEXLEN=+($G(X)) S:+LEXLEN'>0 LEXLEN=79 S LEXC=+($G(LEX)) S:+($G(LEXC))'>0 LEXC=$O(LEX(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXLEN S LEXI=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI=0  S X=$G(LEX(LEXI)) D ^DIWP
 K LEX S (LEXC,LEXI)=0 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEX(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," "),LEXC=LEXC+1
 S:$L(LEXC) LEX=LEXC K ^UTILITY($J,"W")
 Q
PRMN(LEX,X) ; Parse Minimum Character Length (DIWP Work-Around)
 N LEXI,LEXL,LEXN,LEXMX K LEXN S LEXL=0,LEXMX=+($G(X)) S:LEXMX'>0 LEXMX=500
 F  S LEXL=$O(LEX(LEXL)) Q:+LEXL'>0  D
 . N LEXTX S LEXTX=$$TM($G(LEX(LEXL))) Q:'$L(LEXTX)
 . I $L(LEXTX)<LEXMX D  Q
 . . N LEXC S LEXC=+($O(LEXN(" "),-1))+1,LEXN(+LEXC)=LEXTX S LEXTX=""
 . F  Q:'$L($$TM(LEXTX))  D  Q:'$L($$TM(LEXTX))
 . . N LEXC,LEXREM,LEXSTO,LEXPSN Q:'$L(LEXTX)
 . . I $L(LEXTX)<LEXMX D  Q
 . . . N LEXC S LEXC=+($O(LEXN(" "),-1))+1,LEXN(+LEXC)=LEXTX S LEXTX=""
 . . I $L(LEXTX)'<LEXMX D
 . . . F LEXPSN=(LEXMX-1):-1 Q:$E(LEXTX,LEXPSN)=" "
 . . . S LEXSTO=$$TM($E(LEXTX,1,LEXPSN)),LEXREM=$$TM($E(LEXTX,LEXPSN,$L(LEXTX)))
 . . . S LEXC=+($O(LEXN(" "),-1))+1,LEXN(+LEXC)=LEXSTO
 . . . S LEXTX=LEXREM
 K LEX S LEXI=0 F  S LEXI=$O(LEXN(LEXI)) Q:+LEXI'>0  S LEX(LEXI)=$G(LEXN(LEXI))
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
SUBSETS(CODE,SRC,LEX) ; Get Subsets for a Code
 ;
 ; Input
 ;     
 ;   CODE  This is a valid classification code from one of
 ;         the coding systems in the Lexicon (see the CODING
 ;         SYSTEMS file 757.03)
 ;
 ;   SRC   This is coding system for which the code belongs.
 ;         It can either be the Source Abbreviation (SAB)
 ;         found in the .01 field of the CODING SYSTEMS file
 ;         #757.03 or a pointer to the CODING SYSTEMS file
 ;         #757.03
 ;       
 ; Output
 ;   
 ;   $$SUBSETS  Subset Identifiers
 ;   
 ;         2 or more (variable) Piece "^" delimited string
 ;             
 ;           1  Number of Subsets found
 ;           2  Subset Identifier #1
 ;           3  Subset Identifier #2
 ;           4  Subset Identifier #n
 ;                
 ;         Example:
 ;                
 ;           $$SUBSETS^LEXU(205365003,56)
 ;           
 ;           "4^CLF^DIS^PLS^SCT^"
 ;                  
 ;           4 Subsets found including CLF, DIS, PLS and SCT
 ;     
 ;         OR
 ; 
 ;           -1 ^ Error Message
 ;         
 ;   LEX   Optional array passed by Reference
 ;       
 ;         LEX(<sub>) = 4 Piece "^" delimited string
 ;             
 ;           1  Subset Name
 ;           2  Subset Definition IEN file 757.2
 ;           3  Subset IEN file 757.21
 ;           4  Expression IEN file 757.01
 ;                
 ;         Where <sub> is a three character identifier of a
 ;         subset.
 ;             
 ;         Example of the LEX array:
 ;         
 ;           $$SUBSETS^LEXU(205365003,56,.ARY)
 ;                
 ;           ARY("CLF")="Clinical Findings^7000039^70071537^7301845"
 ;           ARY("DIS")="Disorder^7000002^7150923^7301845"
 ;           ARY("PLS")="PL Standard^7000038^70175664^7301845"
 ;           ARY("SCT")="SNOMED CT^7000037^7457760^7301845"
 ;                
 K LEX N LEXIENS,LEXEX,LEXMC,LEXIEN,LEXSO,LEXSIEN,LEXSRC,LEXFND S LEXSO=$G(CODE)
 Q:'$L(LEXSO) "-1^Code Missing" Q:'$L($G(SRC)) "-1^Coding System Missing"
 S LEXFND=0,LEXSRC="" S:$G(SRC)?1N.N&($D(^LEX(757.03,+($G(SRC)),0))) LEXSRC=+($G(SRC))
 S:$G(SRC)'?1N.N&($L($G(SRC))=3)&($D(^LEX(757.03,"ASAB",$G(SRC)))) LEXSRC=$O(^LEX(757.03,"ASAB",$G(SRC),0))
 Q:'$D(^LEX(757.03,+LEXSRC,0)) "-1^Invalid Coding System"  S LEXMC="",LEXSIEN=0
 F  S LEXSIEN=$O(^LEX(757.02,"CODE",(LEXSO_" "),LEXSIEN)) Q:+LEXSIEN'>0  D  Q:LEXMC>0
 . N LEXND,LEXEF,LEXHS,LEXST S LEXND=$G(^LEX(757.02,+LEXSIEN,0)) Q:$P(LEXND,"^",3)'=LEXSRC  Q:$P(LEXND,"^",5)'>0
 . S LEXEF=$O(^LEX(757.02,+LEXSIEN,4,"B"," "),-1) Q:LEXEF'?7N
 . S LEXHS=$O(^LEX(757.02,+LEXSIEN,4,"B",+LEXEF," "),-1) Q:+LEXHS'>0
 . S LEXST=$G(^LEX(757.02,+LEXSIEN,4,+LEXHS,0)) Q:$P(LEXST,"^",2)'>0
 . S LEXMC=$P(LEXND,"^",4)
 Q:+LEXMC'>0 "-1^Code not Found" S LEXEX=+($G(^LEX(757,+LEXMC,0))) I $D(^LEX(757.21,"B",+LEXEX)) D  Q $G(LEXFND)
 . S LEXIEN=LEXEX,LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.21,"B",+LEXEX,LEXSIEN)) Q:LEXSIEN'>0  D
 . . N LEXND,LEXSI,LEXSA,LEXSF,LEXSTR
 . . S LEXSI=$P($G(^LEX(757.21,+LEXSIEN,0)),"^",2),LEXND=$G(^LEXT(757.2,+LEXSI,0))
 . . S LEXSA=$P(LEXND,"^",2),LEXSF=$$MIX^LEXXM($P(LEXND,"^",1))
 . . S:$L(LEXSA)=3&($L(LEXSF)) LEX(LEXSA)=LEXSF_"^"_LEXSI_"^"_LEXSIEN_"^"_LEXIEN
 . . S LEXSTR="",LEXFND=0,LEXSA="" F  S LEXSA=$O(LEX(LEXSA)) Q:'$L(LEXSA)  D
 . . . S LEXFND=+($G(LEXFND))+1 S LEXSTR=LEXSTR_"^"_LEXSA
 . . S:+LEXFND>0&($L($TR(LEXSTR,"^",""))) LEXFND=+LEXFND_LEXSTR_"^"
 S LEXIEN=0 F  S LEXIEN=$O(^LEX(757.01,"AMC",LEXMC,LEXIEN)) Q:+LEXIEN'>0  D
 . Q:$P($G(^LEX(757.01,+LEXIEN,1)),"^",5)>0  S LEXIENS(LEXIEN)=""
 Q:$O(LEXIENS(0))'>0 "-1^Code not Found"  S LEXIEN=0 F  S LEXIEN=$O(LEXIENS(LEXIEN)) Q:+LEXIEN'>0  D
 . Q:'$D(^LEX(757.21,"B",LEXIEN))  S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.21,"B",LEXIEN,LEXSIEN)) Q:LEXSIEN'>0  D
 . . N LEXND,LEXSI,LEXSA,LEXSF S LEXSI=$P($G(^LEX(757.21,+LEXSIEN,0)),"^",2),LEXND=$G(^LEXT(757.2,+LEXSI,0))
 . . S LEXSA=$P(LEXND,"^",2),LEXSF=$$MIX^LEXXM($P(LEXND,"^",1))
 . . S:$L(LEXSA)=3&($L(LEXSF)) LEX(LEXSA)=LEXSF_"^"_LEXSI_"^"_LEXSIEN_"^"_LEXIEN
 . . S LEXFND=0,LEXSA="" F  S LEXSA=$O(LEX(LEXSA)) Q:'$L(LEXSA)  S LEXFND=+($G(LEXFND))+1
 . . S LEXSTR="",LEXFND=0,LEXSA="" F  S LEXSA=$O(LEX(LEXSA)) Q:'$L(LEXSA)  D
 . . . S LEXFND=+($G(LEXFND))+1 S LEXSTR=LEXSTR_"^"_LEXSA
 . . S:+LEXFND>0&($L($TR(LEXSTR,"^",""))) LEXFND=+LEXFND_LEXSTR_"^"
 Q $G(LEXFND)
