LEXCODE ;ISL/KER - Retrieval of IEN^Term based on Code ;01/03/2011
 ;;2.0;LEXICON UTILITY;**25,73**;Sep 23, 1996;Build 10
 ;               
 ; External Global Variables
 ;    None
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 Q
 ;                   
 ; Source Abbreviatioin (SAB) is 3 character mnemonics for a 
 ; classification/coding system.  They can be found on the
 ; "ASAB" Cross-Reference of the Coding Systems file 757.03.
 ; Here are some of the more commonly used SABs:
 ;                   
 ;     SAB   Nomenclature  Source
 ;     -----------------------------------------------------------
 ;     ICD   ICD-9-CM      Int'l Class of Diseases, Diagnosis
 ;     ICP   ICD-9 Proc    Int'l Class of Diseases, Procedures
 ;     CPT   CPT=4         Current Procedural Terminology
 ;     CPC   HCPCS         Healthcare Common Procedure Codes
 ;     DS3   DSM-IIIR      Diag Manual of Mental Disorder
 ;     DS4   DSM-IV        Diag Manual of Mental Disorder
 ;     SNM   SNOMED 2      Sys Nomen of Medicine
 ;     NAN   NANDA         North American Nursing Diagnosis Assoc
 ;     NIC                 Nursing Intervention Classification
 ;     OMA                 Omaha Nursing Diagnosis/Interventions
 ;     SSC   Title 38      Service Connected Codes
 ;     10D   ICD-10-CM     Int'l Class of Diseases, Diagnosis
 ;     10P   ICD-10-CM     Int'l Class of Diseases, Procedures
 ;     LNC   LOINC         Logical Observation Id Names and Codes
 ;     DMI   DODFAC        DoD DMIS ID's
 ;     MTF                 DoD Military Treating Facilities
 ;     SCT   SNOMED CT     SNOMED Clinical Terms
 ;     BIR   BI-RADS       Breast Imaging Reporting and Data Sys
 ;                   
 Q
EN(LEX,LEXVDT) ; Get terms associated with a Code
 ;
 ;   Input
 ;                   
 ;     LEX      (Required) Code taken from a classification 
 ;              system listed in Coding Systems file #757.03
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
 N LEXSRC,LEXSO,LEXO,LEXEXI,LEXEXP,LEXSAB,LEXDA,LEXPF,LEXINA,LEXSTA,LEXND S LEXVDT=$G(LEXVDT) S:LEXVDT'?7N LEXVDT=$$DT^XLFDT
 S LEXS(0)=LEX,LEXO=LEX_" ",LEXDA=0 Q:'$D(^LEX(757.02,"CODE",LEXO))
 F  S LEXDA=$O(^LEX(757.02,"CODE",LEXO,LEXDA)) Q:+LEXDA=0  D CHK
 D ASEM Q
CHK ;   Check if Valid
 N LEXPD,LEXPI,LEXPH,LEXEX
 S LEXND=$G(^LEX(757.02,LEXDA,0)),LEXSO=$P(LEXND,"^",2) Q:LEXSO'=LEX
 S LEXSRC=+($P(LEXND,"^",3)) Q:LEXSRC'>0   S:$G(LEXVDT)'?7N LEXVDT=$$DT^XLFDT
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
 . I $D(LEXS(LEXSAB,"PRE")) D LEXY
 . S LEXDA=0
 . F  S LEXDA=$O(LEXS(LEXSAB,"OTH",LEXDA)) Q:+LEXDA=0  D LEXY
 . S:+LEXSAB'>0&(LEXSAB'="0") LEXS(LEXSAB,0)=LEXCT
 . S:$L($P($G(LEXSABT),"^",1))&($L($P($G(LEXSABT),"^",1))) LEXS(LEXSAB,0,"SAB")=LEXSABT
 Q
LEXY ;   Get IEN^TERM for Code X
 S:$D(LEXS(LEXSAB,"PRE")) LEXDA=LEXS(LEXSAB,"PRE")
 K:'$D(LEXS(LEXSAB,"PRE")) LEXS(LEXSAB,"OTH",LEXDA) K LEXS(LEXSAB,"PRE")
 S:$G(LEXVDT)'?7N LEXVDT=$$DT^XLFDT
 S LEXY="" N LEXEXI,LEXEXP S LEXEXI=+($P($G(^LEX(757.02,+LEXDA,0)),"^",1)) Q:+LEXEXI'>0
 Q:'$L($G(^LEX(757.01,+LEXEXI,0)))  S LEXEXP=$G(^LEX(757.01,+LEXEXI,0)),LEXCT=LEXCT+1,LEXY=LEXEXI_"^"_LEXEXP
 S LEXS(LEXSAB,LEXCT)=LEXY
 Q
 ;          
EXP(LEX,LEXS,LEXVDT) ; Get Preferred Expression for an Active Code
 ;
 ;   Input
 ;   
 ;     LEX      (Required) Code taken from a classification 
 ;              system listed in Coding Systems file #757.03
 ;   
 ;     LEXS     (Required) This is either the three character
 ;              Source Abbreviation (see list above) or a pointer
 ;              to the Coding Systems file 757.03.  It is used
 ;              to distinguish between different coding systems
 ;              with the same code (i.e., the code 300.01 occurs
 ;              in both the ICD-9-CM and DSM-IV coding systems).
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
 N LEXARY,LEXCDT,LEXCND,LEXEXP,LEXHI,LEXHND,LEXIN,LEXNOM,LEXORD,LEXPD,LEXPF,LEXSAB,LEXSIEN,LEXSRC
 S (LEX,LEXIN)=$G(LEX) Q:'$L(LEXIN) "-1^Code not passed"  S LEXS=$G(LEXS) Q:'$L(LEXS) "-1^Source not passed"
 S LEXSRC=+($O(^LEX(757.03,"ASAB",LEXS,0))),LEXSAB=$E($G(^LEX(757.03,+LEXSRC,0)),1,3)
 I +LEXSRC'>0!($L(LEXSAB)'=3) S LEXSRC=0,LEXSAB=$E($G(^LEX(757.03,+LEXS,0)),1,3) S:$L(LEXSAB) LEXSRC=+($O(^LEX(757.03,"ASAB",LEXSAB,0)))
 Q:+LEXSRC'>0!($L(LEXSAB)'=3) "-1^Invalid source passed" Q:'$D(^LEX(757.03,+LEXSRC,0))!('$D(^LEX(757.03,"ASAB",LEXSAB))) "-1^Invalid source passed"
 S LEXNOM=$P($G(^LEX(757.03,+LEXSRC,0)),"^",2) Q:'$L(LEXNOM) "-1^Invalid source on file"
 S LEXORD=(LEXIN_" "),LEXCDT=$G(LEXVDT) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 K LEXARY S LEXSIEN=" " F  S LEXSIEN=$O(^LEX(757.02,"CODE",LEXORD,LEXSIEN),-1) Q:+LEXSIEN'>0  D
 . N LEXCND,LEXHND,LEXPD,LEXHI,LEXPF
 . S LEXCND=$G(^LEX(757.02,+LEXSIEN,0)) Q:$P(LEXCND,"^",3)'=LEXSRC
 . S LEXPD=$O(^LEX(757.02,+LEXSIEN,4,"B",(LEXCDT+.000009)),-1) Q:LEXPD'?7N
 . S LEXHI=$O(^LEX(757.02,+LEXSIEN,4,"B",LEXPD," "),-1) Q:+LEXHI'>0
 . S LEXHND=$G(^LEX(757.02,+LEXSIEN,4,+LEXHI,0)) Q:$P(LEXHND,"^",2)'>0
 . S LEXPF=+($P($G(^LEX(757.02,+LEXSIEN,0)),"^",5)) Q:LEXPF'>0
 . S LEXARY(LEXSIEN,0)=LEXCND,LEXARY(LEXSIEN,4)=LEXHND
 Q:$O(LEXARY(0))'>0 ("-1^Active code/expression not found for "_LEXNOM_" code "_LEX_" on "_$$FMTE^XLFDT(LEXCDT,"5Z"))
 Q:$O(LEXARY(0))'=$O(LEXARY(" "),-1) ("-1^Multiple active preferred expressions for "_LEXNOM_" "_LEX_" on "_$$FMTE^XLFDT(LEXCDT,"5Z"))
 S LEXEXP=$O(LEXARY(0)),LEXEXP=+($G(LEXARY(+LEXEXP,0))) Q:'$D(^LEX(757.01,+LEXEXP)) ("-1^Expression not found in file 757.01")
 S LEX=LEXEXP_"^"_$P($G(^LEX(757.01,+LEXEXP,0)),"^",1)
 Q LEX
