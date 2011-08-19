LEXASO ;ISL/KER - Look-up Display String (Sources) ;01/03/2011
 ;;2.0;LEXICON UTILITY;**25,32,73**;Sep 23, 1996;Build 10
 ;
 ; Entry S X=$$SO^LEXASO(IEN,SAB,ALL,DATE)
 ;
 ;       IEN is an internal entry number in file 757.01
 ;           representing an expression
 ;
 ;       SAB is the source abbreviation of the classification
 ;           coding system, i.e., ICD, CPT, DSM, etc.
 ;
 ;       ALL is a flag 
 ;
 ;           0 - do not display all codes associated of the
 ;               major concept, display the codes only for the
 ;               expression
 ;
 ;           1 - display all codes associated for the major 
 ;               concept
 ;
 ;       DATE is used to screen out inactive codes
 ;
 ; LEXCC(   Array of classification codes
 ;
 ; LEXA     Flag - 1 All codes, 0 only the expression codes
 ; LEXM     Flag - M Major Concept
 ;
 ; LEXC     Counter, # $Piece of string LEXSA (SAB)
 ;
 ; LEXMC    IEN in file 757      Major Concept
 ; LEXME    IEN in file 757.01   Major Concept Expression
 ; LEXEX    IEN in file 757.01   Expression
 ; LEXSO    IEN in file 757.02   Sources
 ;
 ; LEXSA    Source Abbreviation i.e., ICD or ICD/CPT
 ; LEXSC    Source Classification Code
 ; LEXSR    Source Abbreviation single only i.e., ICD, CPT
 ; LEXST    String of classification sources and codes
 ;
 ; LEXX     Return value
 ;
SO(LEXX,LEXSA,LEXA,LEXVDT) ; Return string of source codes for LEXX SAB
 Q:+($G(LEXX))=0!('$L($G(LEXSA))) ""
 Q:'$L($G(^LEX(757.01,LEXX,0))) ""
 ;
 N LEXCC,LEXM,LEXC,LEXMC,LEXME,LEXEX,LEXSO,LEXSC,LEXSR,LEXST
 ;
 S LEXEX=+LEXX,LEXX="",LEXA=+($G(LEXA)),LEXMC=0
 S LEXM=$P($G(^LEX(757.01,LEXEX,1)),"^",2),LEXST=""
 ; Codes for an expression     D EXP
 I LEXM'=1!(+($G(LEXA))=0) D EXP G EXIT
 ; Codes for a major concept   D MAJ
 I LEXM=1 S LEXMC=LEXEX D MAJ
EXIT ; Clean up and quit
 Q LEXX
EXP ; Source string for an expression
 I LEXSA'["/" D CODES(LEXEX,LEXSA,$G(LEXVDT)) S LEXX=$$ASSEM Q
 I LEXSA["/" D  S LEXX=$$ASSEM
 . N LEXC F LEXC=1:1:$L(LEXSA,"/") D
 . . D CODES(LEXEX,$P(LEXSA,"/",LEXC),$G(LEXVDT))
 Q
MAJ ; Source string for a major concept
 S LEXMC=$P($G(^LEX(757.01,LEXEX,1)),"^",1),LEXEX=0
 S LEXEX=0 F  S LEXEX=$O(^LEX(757.02,"AMC",LEXMC,LEXEX)) Q:+LEXEX=0  D
 . N LEXME S LEXME=+($G(^LEX(757.02,LEXEX,0)))
 . I LEXSA'["/" D CODES(LEXME,LEXSA,$G(LEXVDT)) Q
 . I LEXSA["/" D  Q
 . . N LEXC F LEXC=1:1:$L(LEXSA,"/") D
 . . . D CODES(LEXME,$P(LEXSA,"/",LEXC),$G(LEXVDT))
 S LEXX=$$ASSEM
 Q
CODES(LEXEX,LEXSA,LEXVDT) ; Get Source Codes
 Q:$L($G(LEXSA))'=3  N LEXCD,LEXCN,LEXCS,LEXHE,LEXHI,LEXHN,LEXHS,LEXSAI,LEXSO,LEXSR,LEXST,LEXSTA
 S LEXST="",LEXSAI=+($O(^LEX(757.03,"ASAB",LEXSA,0))) Q:+LEXSAI'>0  S LEXSO=0 F  S LEXSO=$O(^LEX(757.02,"B",LEXEX,LEXSO)) Q:+LEXSO=0  D
 . S LEXCN=$G(^LEX(757.02,LEXSO,0)),LEXCD=$P(LEXCN,"^",2) Q:'$L(LEXCD)  S LEXCS=$P(LEXCN,"^",3) Q:+LEXCS'=+LEXSAI
 . S LEXHE=$S(+LEXVDT>0:(LEXVDT_".99999"),1:" "),LEXHE=$O(^LEX(757.02,+LEXSO,4,"B",LEXHE),-1) Q:+LEXHE'>0
 . S LEXHI=$O(^LEX(757.02,+LEXSO,4,"B",+LEXHE," "),-1)
 . S LEXHN=$G(^LEX(757.02,+LEXSO,4,+LEXHI,0)),LEXHS=$P(LEXHN,"^",2) Q:+($G(LEXHS))'>0
 . S LEXSR=$P($G(^LEX(757.03,$P($G(^LEX(757.02,LEXSO,0)),"^",3),0)),"^",2)
 . S LEXCC(LEXSR,(($P($G(^LEX(757.02,LEXSO,0)),"^",2))_" "))=""
 . ; Primary Code Saved - p32
 . S:$P($G(^LEX(757.02,LEXSO,0)),"^",7)=1 LEXCC(LEXSR,"P",(($P($G(^LEX(757.02,LEXSO,0)),"^",2))_" "))=""
 Q
ASSEM(LEXX) ; Assemble display string  (SOURCE CODE/CODE/CODE)
 Q:'$D(LEXCC) ""
 Q:$O(LEXCC(""))="" ""
 N LEXSR,LEXST S LEXSR=""
 F  S LEXSR=$O(LEXCC(LEXSR)) Q:LEXSR=""  D
 . N LEXSC S LEXSC="",LEXST="("_LEXSR_" "
 . ; Primary Code listed first - p32
 . I $D(LEXCC(LEXSR,"P")) D
 . . N LEXSC S LEXSC=$O(LEXCC(LEXSR,"P",""))
 . . S:$L(LEXSC) LEXST=LEXST_$$TRIM(LEXSC)_"/"
 . . K LEXCC(LEXSR,"P") K:$L(LEXSC) LEXCC(LEXSR,LEXSC)
 . S LEXSC="" F  S LEXSC=$O(LEXCC(LEXSR,LEXSC)) Q:LEXSC=""  D
 . . S LEXST=LEXST_$$TRIM(LEXSC)_"/"
 . . K LEXCC(LEXSR,LEXSC)
 . S LEXCC(LEXSR)=$E(LEXST,1,($L(LEXST)-1))_")"
 S (LEXST,LEXSR)=""
 F  S LEXSR=$O(LEXCC(LEXSR)) Q:LEXSR=""  D
 . S LEXST=LEXST_" "_LEXCC(LEXSR)
 F  Q:$E(LEXST,1)'=" "  S LEXST=$E(LEXST,2,$L(LEXST))
 S LEXX=LEXST Q LEXX
TRIM(LEXX) ; Trim spaces
 F  Q:$E(LEXX,1)'=" "  S LEXX=$E(LEXX,2,$L(LEXX))
 F  Q:$E(LEXX,$L(LEXX))'=" "  S LEXX=$E(LEXX,1,($L(LEXX)-1))
 Q LEXX
