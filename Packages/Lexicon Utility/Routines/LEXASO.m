LEXASO ;ISL/KER - Look-up Display String (Sources) ;05/23/2017
 ;;2.0;LEXICON UTILITY;**25,32,73,80,103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.01,        SACC 1.3
 ;    ^LEX(757.02,        SACC 1.3
 ;    ^LEX(757.03,        SACC 1.3
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$CODEN^ICDEX       ICR   5747
 ;    $$CSI^ICDEX         ICR   5747
 ;    $$CODEN^ICPTCOD     ICR   1995
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXSOA              Array of Codes
 ;               
SO(LEXX,LEXSA,LEXA,LEXVDT) ; Return string of source codes for LEXX SAB
 ;   
 ;   Input
 ;
 ;     LEXX       IEN of Expression file 757.01
 ;     LEXSA      Source abbreviation string
 ;     LEXA       ALL is a flag 
 ;                  0 - Expression codes only
 ;                  1 - Concept codes
 ;     LEXVDT     Versioning Date
 ;   
 ;   Output
 ;
 ;     $$SO       String of Source Codes i.e., 
 ;                (ICD-9-CM 799.9)
 ;       
 I +($G(LEXAFMT))>0 D SOA^LEXASO(LEXX,$G(^TMP("LEXSCH",$J,"DIS",0)),1,$G(LEXVDT),.LEXSOA) Q ""
 Q:+($G(LEXX))=0!('$L($G(LEXSA))) ""  Q:'$L($G(^LEX(757.01,LEXX,0))) ""
 N LEXCC,LEXM,LEXC,LEXMC,LEXME,LEXEX,LEXSO,LEXSC,LEXSR,LEXST D VDT^LEXU
 S LEXEX=+LEXX,LEXX="",LEXA=+($G(LEXA)),LEXMC=0
 S LEXM=$P($G(^LEX(757.01,LEXEX,1)),"^",2),LEXST=""
 ; Codes for an expression     D EXP
 I LEXM'=1!(+($G(LEXA))=0) D EXP G EXIT
 ; Codes for a major concept   D MAJ
 I LEXM=1 S LEXMC=LEXEX D MAJ
EXIT ; Clean up and quit
 Q LEXX
SOA(LEXX,LEXSA,LEXA,LEXVDT,LEXARY) ; Return array of source codes for LEXX SAB
 ;   
 ;   Input
 ;
 ;     LEXX       IEN of Expression file 757.01
 ;     LEXSA      Source abbreviation string
 ;     LEXA       ALL is a flag 
 ;                  0 - Expression codes only
 ;                  1 - Concept codes
 ;     LEXVDT     Versioning Date
 ;     LEXARY     Array passed by Reference
 ;   
 ;   Output
 ;
 ;     $$SO       Success
 ;                  0 - No codes found
 ;                  1 - Codes found
 ;               
 ;     LEXARY(X)  Array of Sources passed by Reference
 ;     
 ;                  X = Coding System (pointer to 757.03)
 ;                  
 ;                LEXARY(X,"P") =  3 Piece "^" delimited string
 ;                                   1  Code
 ;                                   2  Coding System the
 ;                                      Preferred Term of
 ;                                      the code
 ;                                   3  Variable Pointer to
 ;                                      a National file if 
 ;                                      one exist
 ;       
 ;                LEXARY(X,###) =  3 Piece "^" delimited string
 ;                                   1  Code
 ;                                   2  Coding System the 
 ;                                      an expression that is
 ;                                      not the Preferred
 ;                                      Term for the code
 ;                                   3  Variable Pointer to
 ;                                      a National file if
 ;                                      one exist
 ;     
 Q:+($G(LEXX))=0!('$L($G(LEXSA))) ""  Q:'$L($G(^LEX(757.01,LEXX,0))) ""
 N LEXCC,LEXM,LEXC,LEXMC,LEXME,LEXEX,LEXSO,LEXSC,LEXSR,LEXST,LEXAFMT D VDT^LEXU
 S LEXEX=+LEXX,LEXX="",LEXA=+($G(LEXA)),LEXMC=0,LEXAFMT=1 K LEXARY
 S LEXM=$P($G(^LEX(757.01,LEXEX,1)),"^",2),LEXST=""
 ; Codes for an expression     D EXP
 I LEXM'=1!(+($G(LEXA))=0) D EXP G EXIT
 ; Codes for a major concept   D MAJ
 I LEXM=1 S LEXMC=LEXEX D MAJ
 Q:$O(LEXARY(0))>0 1
 Q 0
EXP ; Source string for an expression
 I LEXSA'["/" D CODES(LEXEX,LEXSA,$G(LEXVDT)) S:+($G(LEXAFMT))'>0 LEXX=$$ASSEM Q
 I LEXSA["/" D  S:+($G(LEXAFMT))'>0 LEXX=$$ASSEM
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
 S:+($G(LEXAFMT))'>0 LEXX=$$ASSEM
 Q
CODES(LEXEX,LEXSA,LEXVDT) ; Get Source Codes
 Q:$L($G(LEXSA))'=3  N LEXCD,LEXCN,LEXCP,LEXCS,LEXHE,LEXHI,LEXHN,LEXHS,LEXSAI,LEXSAN,LEXSO,LEXSR,LEXST,LEXSTA
 S LEXST="",LEXSAI=+($O(^LEX(757.03,"ASAB",LEXSA,0))) Q:+LEXSAI'>0  S LEXSAN=$P($G(^LEX(757.03,+LEXSAI,0)),"^",2) Q:'$L(LEXSAN)
 S LEXSO=0 F  S LEXSO=$O(^LEX(757.02,"B",LEXEX,LEXSO)) Q:+LEXSO=0  D
 . S LEXCN=$G(^LEX(757.02,LEXSO,0)),LEXCD=$P(LEXCN,"^",2) Q:'$L(LEXCD)  S LEXCS=$P(LEXCN,"^",3) Q:+LEXCS'=+LEXSAI
 . S LEXCP=$P(LEXCN,"^",5),LEXHE=$S(+LEXVDT>0:(LEXVDT_".99999"),1:" "),LEXHE=$O(^LEX(757.02,+LEXSO,4,"B",LEXHE),-1) Q:+LEXHE'>0
 . S LEXHI=$O(^LEX(757.02,+LEXSO,4,"B",+LEXHE," "),-1)
 . S LEXHN=$G(^LEX(757.02,+LEXSO,4,+LEXHI,0)),LEXHS=$P(LEXHN,"^",2) Q:+($G(LEXHS))'>0
 . I +($G(LEXAFMT))=1 D  Q
 . . N LEXI,LEXO,LEXVP S LEXVP=""
 . . I +LEXCS=1!(+LEXCS=30) D
 . . . N LEXP,LEXS S LEXP=$$CODEN^ICDEX(LEXCD,80),LEXS=$$CSI^ICDEX(80,+LEXP) S:+LEXP>0&(LEXS=LEXCS) LEXVP=+LEXP_";ICD9("
 . . I +LEXCS=2!(+LEXCS=31) D
 . . . N LEXP,LEXS S LEXP=$$CODEN^ICDEX(LEXCD,80.1),LEXS=$$CSI^ICDEX(80.1,+LEXP) S:+LEXP>0&(LEXS=LEXCS) LEXVP=+LEXP_";ICD0("
 . . I +LEXCS=3!(+LEXCS=4) D
 . . . N LEXP S LEXP=$$CODEN^ICPTCOD(LEXCD) S:+LEXP>0 LEXVP=+LEXP_";ICPT("
 . . S LEXO=LEXCD_"^"_LEXSAN S:$L(LEXVP) LEXO=LEXO_"^"_LEXVP
 . . N LEXI I LEXCP>0 S LEXARY(+LEXCS,"P")=LEXO Q
 . . S LEXI=$O(LEXARY(+LEXCS," "),-1)+1,LEXARY(+LEXCS,+LEXI)=LEXO
 . S LEXSR=$P($G(^LEX(757.03,$P($G(^LEX(757.02,LEXSO,0)),"^",3),0)),"^",2)
 . S LEXCC(LEXSR,(($P($G(^LEX(757.02,LEXSO,0)),"^",2))_" "))=""
 . ; Primary Code Saved - p32
 . S:$P($G(^LEX(757.02,LEXSO,0)),"^",7)=1 LEXCC(LEXSR,"P",(($P($G(^LEX(757.02,LEXSO,0)),"^",2))_" "))=""
 Q
ASSEM(LEXX) ; Assemble display string  (SOURCE CODE/CODE/CODE)
 Q:'$D(LEXCC) ""  Q:$O(LEXCC(""))="" ""  N LEXSR,LEXST S LEXSR=""
 D SHELLY F  S LEXSR=$O(LEXCC(LEXSR)) Q:LEXSR=""  D
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
SHELLY ; Suppress other (non-primary) codes
 N LEXSY,LEXCD S LEXSY="" F  S LEXSY=$O(LEXCC(LEXSY)) Q:'$L(LEXSY)  D
 . N LEXPF S LEXPF=$O(LEXCC(LEXSY,"P","")) Q:'$L(LEXPF)
 . S LEXCD="" F  S LEXCD=$O(LEXCC(LEXSY,LEXCD)) Q:'$L(LEXCD)  D
 . . Q:LEXCD="P"  K:LEXCD'=LEXPF LEXCC(LEXSY,LEXCD)
 Q
TRIM(LEXX) ; Trim spaces
 F  Q:$E(LEXX,1)'=" "  S LEXX=$E(LEXX,2,$L(LEXX))
 F  Q:$E(LEXX,$L(LEXX))'=" "  S LEXX=$E(LEXX,1,($L(LEXX)-1))
 Q LEXX
