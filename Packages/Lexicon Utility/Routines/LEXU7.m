LEXU7 ;ISL/KER - Miscellaneous Lexicon Utilities ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757,           SACC 1.3
 ;    ^LEX(757.001,       SACC 1.3
 ;    ^LEX(757.01,        SACC 1.3
 ;    ^LEX(757.018        SACC 1.3
 ;    ^LEX(757.02,        SACC 1.3
 ;    ^LEX(757.03,        SACC 1.3
 ;    ^LEX(757.1,         SACC 1.3
 ;    ^LEX(757.11,        SACC 1.3
 ;    ^LEX(757.12,        SACC 1.3
 ;               
 ; External References
 ;    $$CODEN^ICDEX       ICR   5747
 ;    $$CSI^ICDEX         ICR   5747
 ;    $$PERIOD^ICDEX      ICR   5747
 ;    $$STATCHK^ICDEX     ICR   5747
 ;    PERIOD^ICPTAPIU     ICR   1997
 ;    $$CODEN^ICPTCOD     ICR   1995
 ;    $$CPT^ICPTCOD       ICR   1995
 ;    $$DT^XLFDT          ICR  10103
 ;               
IENS(X,LEX,CDT) ; Get Lexicon/National File IENS for a Code
 ;           
 ; Input
 ; 
 ;     X     Code
 ;     LEX   Local Array passed by .reference
 ;     CDT   Versioning Date (default TODAY)
 ;           
 ; Output
 ; 
 ;  $$IENS   Number of Entries found
 ;           
 ;  LEX Local Array
 ;           
 ;     LEX(0)   3 Piece "^" delimited string
 ;     
 ;        1  Number of Entries found
 ;        2  Code
 ;        3  Date used
 ;           
 ;     LEX(#,757)   2 Piece "^" delimited string
 ;           
 ;        1  IEN to file #757
 ;        2  IEN to file #757.01
 ;
 ;     LEX(#,757.001)   3 Piece "^" delimited string
 ;           
 ;        1  IEN to file #757.001
 ;        2  Originating Value
 ;        3  Frequency
 ;
 ;     LEX(#,757.01)   8 Piece "^" delimited string
 ;           
 ;        1  IEN to file #757.01
 ;        2  Expression Type
 ;        3  Expression Form
 ;        4  Expression Deactivation Flag
 ;        5  External Expression Type
 ;        6  External Expression Form
 ;        7  External Deactivation Flag
 ;        8  Expression
 ;           
 ;     LEX(#,757.01,7,CD)   5 Piece "^" delimited string
 ;           
 ;        Where CD is a Designation Code
 ;           
 ;        1  IEN of sub-file #757.118
 ;        2  Pointer to file #757.03
 ;        3  Pointer to file #757.018
 ;        4  Coding System nomenclature
 ;        5  Name of SNOMED CT Hierarchy
 ;        
 ;     LEX(#,757.02)   5 Piece "^" delimited string
 ;           
 ;        1  IEN to file #757.02
 ;        2  Code
 ;        3  Initial Activation Date
 ;        4  Status
 ;        5  Status Effective Date
 ;        
 ;     LEX(#,757.02,4,EFF)   2 Piece "^" delimited string
 ;           
 ;        Where EFF is the effective date for a Status
 ;           
 ;        1  IEN of sub-file #757.28
 ;        2  Status (1=Active, 0=Inactive)
 ;           
 ;     LEX(#,757.03)   3 Piece "^" delimited string
 ;           
 ;        1  IEN to file #757.03
 ;        2  Source Abbreviation
 ;        3  Source Nomenclature
 ;
 ;     LEX(#,757.1,#)   6 Piece "^" delimited string (multiple)
 ;           
 ;        1  IEN to file #757.1
 ;        2  IEN to file #757
 ;        3  IEN to file #757.11
 ;        4  IEN to file #757.12
 ;        5  Semantic Class (external)
 ;        6  Semantic Type (external)
 ; 
 ;     LEX(#,"VA",SR)   6 Piece "^" delimited string (multiple)
 ;           
 ;        Where SR is a pointer to the CODING SYSTEM file 757.03
 ;           
 ;        1  Variable Pointer to a VA National File
 ;        2  Code from VA file
 ;        3  Coding System Nomenclature
 ;        4  Initial Activation Date in the VA file
 ;        5  Status in the VA file
 ;        6  Status Effective Date in the VA file
 ;           
 ; Example
 ;           
 ;   ARY(0)="2^250.01^3150101"
 ;   ARY(1,757)="7006^33586"
 ;   ARY(1,757.001)="7006^4^4"
 ;   ARY(1,757.01)="33586^1^1^^Major Concept^Major Concept^^
 ;                 Diabetes Mellitus Type I"
 ;   ARY(1,757.02)="316386^250.01^2781001^0^3041001"
 ;   ARY(1,757.02,4,2781001)="1^1"
 ;   ARY(1,757.02,4,3041001)="2^0"
 ;   ARY(1,757.03)="1^ICD^ICD-9-CM"
 ;   ARY(1,757.1,1)="10167^7006^6^47^Diseases/Pathologic 
 ;                  Processes^Disease or Syndrome"
 ;   ARY(1,"VA",1)="851;ICD9(^250.01^ICD-9-CM^2781001^1^2781001"
 ;   ARY(2,757)="182207^331780"
 ;   ARY(2,757.001)="182207^4^4"
 ;   ARY(2,757.01)="331780^1^1^^Major Concept^Major Concept^^
 ;                 Diabetes Mellitus without mention of 
 ;                 Complication, type i [Juvenile type], not 
 ;                 stated as Uncontrolled"
 ;   ARY(2,757.02)="327553^250.01^3041001^1^3041001"
 ;   ARY(2,757.02,4,3041001)="1^1"
 ;   ARY(2,757.02,4,3151001)="2^0"
 ;   ARY(2,757.03)="1^ICD^ICD-9-CM"
 ;   ARY(2,757.1,1)="259374^182207^6^47^Diseases/Pathologic 
 ;                  Processes^Disease or Syndrome"
 ;   ARY(2,"VA",1)="851;ICD9(^250.01^ICD-9-CM^2781001^1^2781001"
 ;           
 N LEXCD,LEXCDT,LEXSIEN K LEX S LEXCD=$G(X),LEXCDT=$G(CDT) Q:'$L(LEXCD) 0  Q:'$D(^LEX(757.02,"CODE",(LEXCD_" "))) 0
 S:LEXCDT'?7N LEXCDT=$$DT^XLFDT Q:$O(^LEX(757.02,"CODE",(LEXCD_" "),0))'>0 0
 S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"CODE",(LEXCD_" "),LEXSIEN)) Q:+LEXSIEN'>0  D
 . N LEXE,LEXEF,LEXEX,LEXH,LEXHI,LEXI,LEXIA,LEXLEX,LEXMC,LEXND,LEXSDO,LEXSMIEN,LEXSR,LEXST S LEXSDO=""
 . S LEXND=$G(^LEX(757.02,+LEXSIEN,0)) Q:$P(LEXND,"^",5)'>0  S LEXEX=+LEXND,LEXSR=$P(LEXND,"^",3)
 . S LEXMC=$P(LEXND,"^",4)
 . I +LEXSR=3!(+LEXSR=4) D
 . . N LEXA,LEXEFF,LEXIA,LEXP,LEXSTA S LEXP=$$CODEN^ICPTCOD(LEXCD) Q:+LEXP'>0
 . . S LEXSDO=+LEXP_";ICPT("_"^"_LEXCD_"^"_$P($G(^LEX(757.03,+LEXSR,0)),"^",2)
 . . S LEXP=$$CPT^ICPTCOD(LEXCD,LEXCDT) S LEXSTA=$P(LEXP,"^",7)
 . . S:LEXSTA>0 LEXEFF=$P(LEXP,"^",9) S:LEXSTA'>0 LEXEFF=$P(LEXP,"^",8)
 . . D PERIOD^ICPTAPIU(LEXCD,.LEXA) S LEXIA=$O(LEXA(0))
 . . S:LEXSTA?1N&(LEXEFF?7N) LEXSDO=LEXSDO_"^"_LEXIA_"^"_LEXSTA_"^"_LEXEFF
 . I +LEXSR=1!(+LEXSR=30) D
 . . N LEXA,LEXE,LEXEFF,LEXIA,LEXP,LEXS,LEXSTA S LEXSDO="",LEXP=$$CODEN^ICDEX(LEXCD,80)
 . . Q:+LEXP'>0  S LEXS=$$CSI^ICDEX(80,+LEXP) Q:LEXS'=LEXSR  S LEXSDO=+LEXP_";ICD9("_"^"_LEXCD
 . . S LEXSDO=LEXSDO_"^"_$P($G(^LEX(757.03,+LEXSR,0)),"^",2),LEXP=$$STATCHK^ICDEX(LEXCD,LEXCDT,LEXSR)
 . . S LEXSTA=$P(LEXP,"^",1),LEXEFF=$P(LEXP,"^",3) S:+LEXSTA<0 LEXSTA=0,LEXEFF=""
 . . S LEXE=$$PERIOD^ICDEX(LEXCD,.LEXA,LEXSR) S LEXIA=$O(LEXA(0))
 . . S:LEXSTA?1N&(LEXEFF?7N) LEXSDO=LEXSDO_"^"_LEXIA_"^"_LEXSTA_"^"_LEXEFF
 . I +LEXSR=2!(+LEXSR=31) D
 . . N LEXA,LEXE,LEXEFF,LEXIA,LEXP,LEXS,LEXSTA S LEXSDO="",LEXP=$$CODEN^ICDEX(LEXCD,80.1)
 . . Q:+LEXP'>0  S LEXS=$$CSI^ICDEX(80.1,+LEXP) Q:LEXS'=LEXSR  S LEXSDO=+LEXP_";ICD0("_"^"_LEXCD
 . . S LEXSDO=LEXSDO_"^"_$P($G(^LEX(757.03,+LEXSR,0)),"^",2),LEXP=$$STATCHK^ICDEX(LEXCD,LEXCDT,LEXSR)
 . . S LEXSTA=$P(LEXP,"^",1),LEXEFF=$P(LEXP,"^",3),LEXE=$$PERIOD^ICDEX(LEXCD,.LEXA,LEXSR),LEXIA=$O(LEXA(0))
 . . S:LEXSTA?1N&(LEXEFF?7N) LEXSDO=LEXSDO_"^"_LEXIA_"^"_LEXSTA_"^"_LEXEFF
 . S LEXHI=$O(^LEX(757.02,+LEXSIEN,4,"B",(LEXCDT+.0001)),-1),LEXHI=$O(^LEX(757.02,+LEXSIEN,4,"B",+LEXHI," "),-1)
 . S LEXHI=$G(^LEX(757.02,+LEXSIEN,4,+LEXHI,0)),LEXST=$P(LEXHI,"^",2),LEXEF=$P(LEXHI,"^",1)
 . S LEXHI=$O(^LEX(757.02,+LEXSIEN,4,"B",0)),LEXHI=$O(^LEX(757.02,+LEXSIEN,4,+LEXHI)),LEXHI=$G(^LEX(757.02,+LEXSIEN,4,+LEXHI,0))
 . S (LEXIA,LEXE)="" F  S LEXE=$O(^LEX(757.02,+LEXSIEN,4,"B",LEXE)) Q:(LEXE'?7N)!($L(LEXIA))  D  Q:$L(LEXIA)
 . . N LEXH S LEXH=" " F  S LEXH=$O(^LEX(757.02,+LEXSIEN,4,"B",LEXE,LEXH),-1) Q:+LEXH'>0  D  Q:$L(LEXIA)
 . . . N LEXND,LEXST S LEXND=$G(^LEX(757.02,+LEXSIEN,4,+LEXH,0))
 . . . S LEXST=$P(LEXND,"^",2) S:LEXST?1N&(+LEXST>0)&('$L(LEXIA)) LEXIA=LEXE
 . S LEXLEX=LEXEX_"^"_LEXSIEN_"^"_LEXCD_"^"_LEXSR_"^"_$P($G(^LEX(757.03,+LEXSR,0)),"^",2)_"^"_LEXIA_"^"_LEXST_"^"_LEXEF
 . S LEXI=$O(LEX(" "),-1)+1
 . ; Save IENs for:
 . ;   Major Concept Map
 . S LEX(+LEXI,757)=LEXMC_"^"_+($G(^LEX(757,+LEXMC,0)))
 . ;   Frequency
 . S LEX(+LEXI,757.001)=LEXMC_"^"_$P($G(^LEX(757.001,+LEXMC,0)),"^",2)_"^"_$P($G(^LEX(757.001,+LEXMC,0)),"^",3)
 . ;   Expression
 . S LEX(+LEXI,757.01)=LEXEX I $D(^LEX(757.01,+LEXEX,0)) D
 . . N LEXT,LEXTE,LEXF,LEXFE,LEXD,LEXDE,LEXE
 . . S LEXT=$P($G(^LEX(757.01,+LEXEX,1)),"^",2) S:$L(LEXT) $P(LEX(+LEXI,757.01),"^",2)=LEXT
 . . S LEXF=$P($G(^LEX(757.01,+LEXEX,1)),"^",4) S:$L(LEXF) $P(LEX(+LEXI,757.01),"^",3)=LEXF
 . . S LEXD=$P($G(^LEX(757.01,+LEXEX,1)),"^",5) S:$L(LEXF) $P(LEX(+LEXI,757.01),"^",4)=LEXD
 . . S LEXTE=$$MIX^LEXXM($P($G(^LEX(757.011,+LEXT,0)),"^",1)) S:$L(LEXTE) $P(LEX(+LEXI,757.01),"^",5)=LEXTE
 . . S LEXFE=$$MIX^LEXXM($P($G(^LEX(757.014,+LEXF,0)),"^",2)) S:$L(LEXFE) $P(LEX(+LEXI,757.01),"^",6)=LEXFE
 . . S LEXDE=$S(LEXD>0:"Deactivated",1:"") S:$L(LEXDE) $P(LEX(+LEXI,757.01),"^",7)=LEXDE
 . . S LEXE=$G(^LEX(757.01,+LEXEX,0)) S:$L(LEXE) $P(LEX(+LEXI,757.01),"^",8)=LEXE
 . S LEXE=0 F  S LEXE=$O(^LEX(757.01,+LEXEX,7,LEXE)) Q:+LEXE'>0  D
 . . N LEXND,LEXDC,LEXCS,LEXHI,LEXCSE,LEXHIE,LEXHIA,LEXO S LEXND=$G(^LEX(757.01,+LEXEX,7,LEXE,0)),LEXDC=$P(LEXND,"^",1) Q:'$L(LEXDC)
 . . S LEXCS=$P(LEXND,"^",2) Q:'$L(LEXCS)  S LEXCSE=$P($G(^LEX(757.03,+LEXCS,0)),"^",2),LEXHI=$P(LEXND,"^",3)
 . . S LEXHIE=$G(^LEX(757.018,+LEXHI,0)),LEXHIA=$P(LEXHIE,"^",2),LEXHIE=$P(LEXHIE,"^",1),LEXO=LEXE
 . . S:$L(LEXCS) $P(LEXO,"^",2)=LEXCS S:$L(LEXHI) $P(LEXO,"^",3)=LEXHI S:$L(LEXCSE) $P(LEXO,"^",4)=LEXCSE
 . . S:$L(LEXHIE) $P(LEXO,"^",5)=LEXHIE S:$L(LEXHIA) $P(LEXO,"^",6)=LEXHIA S LEX(+LEXI,757.01,7,LEXDC)=LEXO
 . ;   Code
 . S LEX(+LEXI,757.02)=LEXSIEN_"^"_LEXCD_"^"_LEXIA_"^"_LEXST_"^"_LEXEF
 . S LEXE=0 F  S LEXE=$O(^LEX(757.02,+LEXSIEN,4,LEXE)) Q:+LEXE'>0  D
 . . N LEXND,LEXEF,LEXST S LEXND=$G(^LEX(757.02,+LEXSIEN,4,+LEXE,0)),LEXEF=$P(LEXND,"^",1),LEXST=$P(LEXND,"^",2)
 . . Q:LEXEF'?7N  Q:LEXST'?1N  S LEX(+LEXI,757.02,4,LEXEF)=LEXE_"^"_LEXST
 . ;   Coding System
 . S LEX(+LEXI,757.03)=LEXSR_"^"_$E($P($G(^LEX(757.03,+LEXSR,0)),"^",1),1,3)_"^"_$P($G(^LEX(757.03,+LEXSR,0)),"^",2)
 . ;   Semantic Map
 . S LEXSMIEN=0 F  S LEXSMIEN=$O(^LEX(757.1,"B",+LEXMC,LEXSMIEN)) Q:+LEXSMIEN'>0  D
 . . N LEXND,LEXTI,LEXTE,LEXCI,LEXCE,LEXS,LEXMC S LEXND=$G(^LEX(757.1,+LEXSMIEN,0))
 . . S LEXMC=$P(LEXND,"^",1),LEXCI=$P(LEXND,"^",2),LEXTI=$P(LEXND,"^",3)
 . . S LEXCE=$P($G(^LEX(757.11,+LEXCI,0)),"^",2),LEXTE=$P($G(^LEX(757.12,+LEXTI,0)),"^",2),LEXS=$O(LEX(+LEXI,757.1," "),-1)+1
 . . S LEX(+LEXI,757.1,+LEXS)=+LEXSMIEN_"^"_LEXMC_"^"_LEXCI_"^"_LEXTI_"^"_LEXCE_"^"_LEXTE
 . S:$L($G(LEXCD)) $P(LEX(0),"^",2)=$G(LEXCD) S:$G(LEXCDT)?7N $P(LEX(0),"^",3)=$G(LEXCDT)
 . ;   VA File
 . S:$L($G(LEXSDO)) LEX(+LEXI,"VA",LEXSR)=LEXSDO
 . S LEX(0)=LEXI S:$L($G(LEXCD)) $P(LEX(0),"^",2)=LEXCD S:$G(LEXCDT)?7N $P(LEX(0),"^",3)=LEXCDT
 Q +($G(LEX(0)))
