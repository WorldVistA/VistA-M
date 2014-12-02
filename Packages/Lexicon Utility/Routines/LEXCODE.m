LEXCODE ;ISL/KER - Retrieval of IEN^Term based on Code ;04/21/2014
 ;;2.0;LEXICON UTILITY;**25,73,80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 Q
 ; Source Abbreviatioin (SAB) is 3 character mnemonics for a 
 ; classification/coding system.  They can be found on the
 ; "ASAB" Cross-Reference of the Coding Systems file 757.03.
 ; Here are some of the more commonly used SABs:
 ;                   
 ;     SAB   Nomenclature  Source
 ;     -----------------------------------------------------------
 ;     ICD   ICD-9-CM      Int'l Class of Diseases, Diagnosis
 ;     ICP   ICD-9 Proc    Int'l Class of Diseases, Procedures
 ;     10D   ICD-10-CM     Int'l Class of Diseases, Diagnosis
 ;     10P   ICD-10-PCS    Int'l Class of Diseases, Procedures
 ;     CPT   CPT=4         Current Procedural Terminology
 ;     CPC   HCPCS         Healthcare Common Procedure Codes
 ;     SSC   Title 38      Service Connected Codes
 ;     DS4   DSM-IV        Diag Manual of Mental Disorder
 ;     SCT   SNOMED CT     SNOMED Clinical Terms
 ;                   
 Q
EN(LEX,LEXVDT) ; Get terms associated with a Code
 ;
 ;   Input
 ;                   
 ;     LEX      (Required) Code
 ;                        
 ;     LEXVDT   (Optional) The date against which the codes 
 ;              found by the search will be compared in order
 ;              to determine whether the code is active or 
 ;              inactive. If not passed, TODAY's date will 
 ;              be used.
 ;                   
 ;    Output    Local Array LEXS 
 ;
 ;              LEXS(0)=Code
 ;              LEXS(SAB,0)=Number of Terms found for SAB
 ;              LEXS(SAB,0,"SAB")=Source Nomenclature ^ Name
 ;              LEXS(SAB,#)=IEN file 757.01^Display Text (term)
 ;              
 ;              Example of returned array LEXS using code V62.4
 ;                
 ;              LEXS(0)="V62.4"
 ;              LEXS("DS4",0)=1
 ;              LEXS("DS4",0,"SAB")="DSM-IV^Diagnostic & 
 ;                                  Statistical Manual of Mental
 ;                                  Disorders"
 ;              LEXS("DS4",1)="303722^Acculturation Problem"
 ;              LEXS("ICD",0)=5
 ;              LEXS("ICD",0,"SAB")="ICD-9-CM^International 
 ;                                  Classification of Diseases,
 ;                                  Diagnosis"
 ;              LEXS("ICD",1)="111638^Social maladjustment"
 ;              LEXS("ICD",2)="29696^Cultural Deprivation"
 ;              LEXS("ICD",3)="100676^Psychosocial Deprivation"
 ;              LEXS("ICD",4)="303722^Acculturation Problem"
 ;              LEXS("ICD",5)="111507^Social Behavior
 ;                   
 K LEXS S LEX=$$UP^XLFSTR($G(LEX)) Q:'$L(LEX)
 N LEXSRC,LEXSO,LEXO,LEXEXI,LEXEXP,LEXSAB,LEXDA,LEXPF,LEXINA,LEXSTA
 N LEXND D VDT^LEXU S LEXVDT=$G(LEXVDT)
 S LEXS(0)=LEX,LEXO=LEX_" ",LEXDA=0 Q:'$D(^LEX(757.02,"CODE",LEXO))
 F  S LEXDA=$O(^LEX(757.02,"CODE",LEXO,LEXDA)) Q:+LEXDA=0  D CHK
 D ASEM Q
CHK ;   Check if Valid
 N LEXPD,LEXPI,LEXPH,LEXEX
 S LEXND=$G(^LEX(757.02,LEXDA,0)),LEXSO=$P(LEXND,"^",2) Q:LEXSO'=LEX
 S LEXSRC=+($P(LEXND,"^",3)) Q:LEXSRC'>0
 S LEXPD=$O(^LEX(757.02,+LEXDA,4,"B",(LEXVDT+.0001)),-1) Q:LEXPD'?7N
 S LEXPI=$O(^LEX(757.02,+LEXDA,4,"B",LEXPD," "),-1) Q:+LEXPI'>0
 S LEXPH=$G(^LEX(757.02,+LEXDA,4,+LEXPI,0)) Q:+($P(LEXPH,"^",2))'>0
 S LEXEX=+LEXND Q:+LEXEX'>0  Q:'$D(^LEX(757.01,+LEXEX,0))
 S LEXSAB=$E($G(^LEX(757.03,+LEXSRC,0)),1,3) Q:$L(LEXSAB)'=3
 S LEXPF=+($P($G(^LEX(757.02,LEXDA,0)),"^",5))
 S:LEXPF=1 LEXS(LEXSAB,"PRE")=LEXDA
 S:LEXPF'=1 LEXS(LEXSAB,"OTH",LEXDA)=""
 Q
ASEM ;   Assemble List
 Q:'$D(LEXS)  N LEXSAB,LEXCT,LEXDA,LEXEX,LEXEXP,LEXY S LEXSAB=""
 F  S LEXSAB=$O(LEXS(LEXSAB)) Q:LEXSAB=""  S LEXCT=0 D
 . N LEXSABT S LEXSABT=$O(^LEX(757.03,"ASAB",LEXSAB,0))
 . S LEXSABT=$P($G(^LEX(757.03,+LEXSABT,0)),"^",2,3)
 . I $D(LEXS(LEXSAB,"PRE")) D
 . . S LEXDA=LEXS(LEXSAB,"PRE") D LEXY
 . S LEXDA=0
 . F  S LEXDA=$O(LEXS(LEXSAB,"OTH",LEXDA)) Q:+LEXDA=0  D LEXY
 . I $L(LEXSAB) S:$D(^LEX(757.03,"ASAB",LEXSAB)) LEXS(LEXSAB,0)=LEXCT
 . I $L($P($G(LEXSABT),"^",1)),$L($P($G(LEXSABT),"^",1)) D
 . . S LEXS(LEXSAB,0,"SAB")=LEXSABT
 Q
LEXY ;   Get IEN^TERM for Code X
 Q:+($G(LEXDA))'>0  Q:'$D(^LEX(757.02,+LEXDA,0))
 K LEXS(LEXSAB,"OTH",LEXDA) K LEXS(LEXSAB,"PRE")
 S LEXY="" N LEXEXI,LEXEXP
 S LEXEXI=+($P($G(^LEX(757.02,+LEXDA,0)),"^",1)) Q:+LEXEXI'>0
 Q:'$L($G(^LEX(757.01,+LEXEXI,0)))
 S LEXEXP=$G(^LEX(757.01,+LEXEXI,0)),LEXCT=LEXCT+1
 S LEXY=LEXEXI_"^"_LEXEXP,LEXS(LEXSAB,LEXCT)=LEXY
 Q
 ;          
CODE(X,LEXVDT,LEXSAB) ; Code for an Expression and Source
 ; 
 ; Similar to $$ICDDX^ICDEX
 ;            $$ICDOP^ICDEX
 ;            $$CPT^ICPTCOD
 ;            $$DX^ICDXCD
 ;            $$PR^ICDXCD
 ;            
 ;            Except the data comes from the Lexicon and
 ;            can be used for any source in file 757.03 and
 ;            is not limited to ICD-9, ICD-10 and CPT.
 ;            
 ; Input
 ; 
 ;    X       Pointer to an Expression in file 757.01
 ;    LEXVDT  Versioning Date
 ;    LEXSAB  Source Abbreviation
 ;   
 ; Output     A 11 piece "^" delimited string
 ; 
 ;    1  IEN of Code          File ^LEX(757.02)
 ;    2  Code                 File ^LEX(757.02) Field #1
 ;    3  Expression           Pointer to ^LEX(757.01)
 ;    4  Concept Expression   Pointer to ^LEX(757.01)
 ;    5  Source               Pointer ^LEX(757.03)
 ;    6  Preference           File ^LEX(757.02) Field #4
 ;    7  Primary              File ^LEX(757.02) Field #6
 ;    8  Status on date       4 multiple
 ;    9  Inactive Date        4 multiple
 ;   10  Active Date          4 multiple
 ;   11  Source Nomenclature  File ^LEX(757.03) Field #1
 ;    
 N LEXAC,LEXE,LEXEF,LEXEX,LEXEXI,LEXH,LEXHE,LEXHI,LEXHS,LEXI
 N LEXIEN,LEXIENS,LEXIN,LEXMC,LEXMCE,LEXN,LEXNAM,LEXND,LEXO
 N LEXS,LEXSO,LEXSOI,LEXSRC,LEXST,LEXTY S LEXO="",LEXEX=+($G(X))
 Q:'$D(^LEX(757.01,+LEXEX,0)) "-1^Expression not found"
 Q:$P($G(^LEX(757.01,+LEXEX,1)),"^",5)>0 "-1^Expression deactivated"
 S LEXIENS(LEXEX)=""
 S LEXMC=+($G(^LEX(757.01,+LEXEX,1))),LEXMCE=+($G(^LEX(757,+LEXMC,0)))
 S LEXTY=$P($G(^LEX(757.01,+LEXEX,1)),"^",2)  I LEXTY=1 D
 . N LEXMC,LEXI
 . S LEXMC=+($G(^LEX(757.01,+LEXEX,1))),LEXI=0
 . F  S LEXI=$O(^LEX(757.01,"AMC",+LEXMC,LEXI)) Q:+LEXI'>0  D
 . . Q:$P($G(^LEX(757.01,+LEXI,1)),"^",5)>0
 . . S:+LEXI>0 LEXIENS(+LEXI)=""
 Q:$O(LEXIENS(0))'>0 "-1^Expression not found"
 S LEXVDT=$G(LEXVDT) D VDT^LEXU
 S LEXSAB=$G(LEXSAB),LEXSRC=$$SAB^LEXSRC2(LEXSAB)
 Q:+LEXSRC'>0 "-1^Invalid Source specified"
 S LEXNAM=$P($G(^LEX(757.03,+LEXSRC,0)),"^",2)
 Q:'$L(LEXNAM) "-1^Invalid Source specified"
 S LEXS=0,LEXO=""
 S LEXIEN=0 F  S LEXIEN=$O(LEXIENS(LEXIEN)) Q:+LEXIEN'>0  D  Q:$L(LEXO)
 . F  S LEXS=$O(^LEX(757.02,"B",+LEXEX,LEXS)) Q:+LEXS'>0  D  Q:$L(LEXO)
 . . N LEXAC,LEXEF,LEXEXI,LEXHE,LEXHI,LEXHS,LEXIN,LEXND,LEXSOI,LEXST
 . . S LEXND=$G(^LEX(757.02,+LEXS,0))
 . . Q:$P(LEXND,"^",3)'=LEXSRC  S LEXEXI=+LEXND
 . . S LEXHE=$O(^LEX(757.02,+LEXS,4,"B",(LEXVDT+.00001)),-1) Q:+LEXHE'>0
 . . S LEXHI=$O(^LEX(757.02,+LEXS,4,"B",LEXHE," "),-1) Q:+LEXHI'>0
 . . S LEXHS=$G(^LEX(757.02,+LEXS,4,+LEXHI,0)) S LEXST=+$P(LEXHS,"^",2)
 . . S LEXEF=LEXHE,LEXSO=$P(LEXND,"^",2)
 . . S LEXSOI=+LEXS S:LEXST>0 LEXAC=LEXEF S:LEXST'>0 LEXIN=LEXEF
 . . I LEXST'>0,LEXIN?7N S LEXAC=$$PA(LEXS,LEXIN)
 . . I LEXST'>0,LEXIN?7N,$G(LEXAC)'?7N Q
 . . S LEXO=$G(LEXS)_"^"_$G(LEXSO)_"^"_$G(LEXEXI)_"^"_$G(LEXMCE)_"^"
 . . S LEXO=LEXO_$G(LEXSRC)_"^"_$P(LEXND,"^",5)_"^"_$P(LEXND,"^",7)
 . . S LEXO=LEXO_"^"_$G(LEXST)_"^"_$G(LEXIN)_"^"_$G(LEXAC)_"^"_LEXNAM
 S X=LEXO S:+X'>0 X="-1^"_LEXNAM_" Code not found"
 Q X
 ;
EXP(LEX,LEXS,LEXVDT) ; Get Preferred Expression for an Active Code
 ;
 ;   Input
 ;
 ;     LEX      (Required) Code
 ;
 ;     LEXS     (Required) This is either the three character
 ;              Source Abbreviation (see list above) or a pointer
 ;              to the Coding Systems file 757.03.
 ;
 ;     LEXVDT   (Optional) The date against which the codes 
 ;              found by the search will be compared in order
 ;              to determine whether the code is active or 
 ;              inactive. If not passed, TODAY's date will 
 ;              be used.
 ;
 ;   Output
 ;
 ;     $$EXP    2 Piece "^" delimited string containing
 ;
 ;              Either:
 ;
 ;                 1  Pointer to Expression file #757.01
 ;                 2  Display Text (Expression)
 ;
 ;              or:
 ;
 ;                 1  -1
 ;                 2  Error Message
 ;
 N LEXARY,LEXCDT,LEXCND,LEXEXP,LEXHI,LEXHND,LEXIN,LEXNOM,LEXORD,LEXPD
 N LEXPF,LEXSB,LEXSI,LEXSR S (LEX,LEXIN)=$G(LEX)
 Q:'$L(LEXIN) "-1^Code not passed"  S LEXS=$G(LEXS)
 Q:'$L(LEXS) "-1^Source not passed"
 S LEXSR=+($O(^LEX(757.03,"ASAB",LEXS,0)))
 S LEXSB=$E($G(^LEX(757.03,+LEXSR,0)),1,3)
 I +LEXSR'>0!($L(LEXSB)'=3) D
 . S LEXSR=0,LEXSB=$E($G(^LEX(757.03,+LEXS,0)),1,3)
 . S:$L(LEXSB) LEXSR=+($O(^LEX(757.03,"ASAB",LEXSB,0)))
 Q:+LEXSR'>0!($L(LEXSB)'=3) "-1^Invalid source passed"
 I '$D(^LEX(757.03,+LEXSR,0))!('$D(^LEX(757.03,"ASAB",LEXSB))) D  Q LEX
 . S LEX="-1^Invalid source passed"
 S LEXNOM=$P($G(^LEX(757.03,+LEXSR,0)),"^",2)
 Q:'$L(LEXNOM) "-1^Invalid source on file"
 S LEXORD=(LEXIN_" ") D VDT^LEXU S LEXCDT=$G(LEXVDT)
 K LEXARY S LEXSI=" "
 F  S LEXSI=$O(^LEX(757.02,"CODE",LEXORD,LEXSI),-1) Q:+LEXSI'>0  D
 . N LEXCND,LEXHND,LEXPD,LEXHI,LEXPF
 . S LEXCND=$G(^LEX(757.02,+LEXSI,0)) Q:$P(LEXCND,"^",3)'=LEXSR
 . S LEXPD=$O(^LEX(757.02,+LEXSI,4,"B",(LEXCDT+.0009)),-1) Q:LEXPD'?7N
 . S LEXHI=$O(^LEX(757.02,+LEXSI,4,"B",LEXPD," "),-1) Q:+LEXHI'>0
 . S LEXHND=$G(^LEX(757.02,+LEXSI,4,+LEXHI,0)) Q:$P(LEXHND,"^",2)'>0
 . S LEXPF=+($P($G(^LEX(757.02,+LEXSI,0)),"^",5)) Q:LEXPF'>0
 . S LEXARY(LEXSI,0)=LEXCND,LEXARY(LEXSI,4)=LEXHND
 I $O(LEXARY(0))'>0 D  Q LEX
 . N LEXC S LEXC=LEX
 . S LEX="-1^Active code/expression not found for "_LEXNOM_" code "
 . S LEX=LEX_LEXC_" on "_$$FMTE^XLFDT(LEXCDT,"5Z")
 I $O(LEXARY(0))'=$O(LEXARY(" "),-1) D  Q LEX
 . N LEXC S LEXC=LEX
 . S LEX="-1^Multiple active preferred expressions for "_LEXNOM
 . S LEX=LEX_" code "_LEXC_" on "_$$FMTE^XLFDT(LEXCDT,"5Z")
 S LEXEXP=$O(LEXARY(0)),LEXEXP=+($G(LEXARY(+LEXEXP,0)))
 Q:'$D(^LEX(757.01,+LEXEXP)) ("-1^Expression not found in file 757.01")
 S LEX=LEXEXP_"^"_$P($G(^LEX(757.01,+LEXEXP,0)),"^",1)
 Q LEX
 ;
 ; Miscellaneous
PA(X,Y) ;   Previous Activation Date
 N LEX,LEXA,LEXE,LEXI,LEXN S LEX=+($G(X)),LEXI=$G(Y)
 Q:'$D(^LEX(757.02,LEXS,4))  Q:LEXI'?7N ""
 S LEXA="",LEXE=LEXI+.000001
 F  S LEXE=$O(^LEX(757.02,+LEX,4,"B",LEXE),-1) Q:+LEXE'>0  D
 . Q:LEXA?7N  S LEXH=" "
 . F  S LEXH=$O(^LEX(757.02,+LEX,4,"B",LEXE,LEXH),-1) Q:+LEXH'>0  D
 . . Q:LEXA?7N  N LEXN S LEXN=$G(^LEX(757.02,+LEX,4,+LEXH,0))
 . . S:$P(LEXN,"^",2)>0 LEXA=LEXE
 S X="" S:LEXA?7N X=LEXA
 Q X
