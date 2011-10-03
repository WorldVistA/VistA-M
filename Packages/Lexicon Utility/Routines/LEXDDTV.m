LEXDDTV ; ISL Display Defaults - Vocabulary        ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
SUB ; Select between Logical and Physical Subsets
 ; Required LEXSUB  Optional LEXDICS
 N LEXTCTR,LEXTD,LEXTI,LEXTIC,LEXTL,LEXTN,LEXTSTR,LEXT,LEXTV
 K LEX S:'$L($G(LEXSUB)) LEX="WRD"
 S:$L($G(LEXSUB)) LEX=LEXSUB
 S:'$D(LEXSTLN) LEXSTLN=56
 S LEXTI=0,(LEXTIC,LEXTN,LEXTV,LEXTD)="" D INT
 K:LEXSTLN=56 LEXSTLN Q
INT ; Interpret string
 ;     LEXSUB is an Application Subset "AB"
 I $D(^LEXT(757.2,"AB",LEX)) D
 . S LEXTIC=$O(^LEXT(757.2,"AB",LEX,0))
 . S LEXTN=$P($G(^LEXT(757.2,+LEXTIC,0)),"^",1)
 . I +LEXTIC'=1 S LEXTN=LEXTN_" Subset"
 ;     LEXSUB is a Compiled Subset "AA"
 I $D(^LEXT(757.2,"AA",LEX)) D
 . S LEXTIC=$O(^LEXT(757.2,"AA",LEX,0))
 . S LEXTN=$P($G(^LEXT(757.2,+LEXTIC,0)),"^",1)
 . I +LEXTIC'=1 S LEXTN=LEXTN_" Subset"
 ;     View of a Subset - DIC("S") with LEXSUB
 I $L($G(LEXDICS)) D
 . S LEXTD=""
 . F  S LEXTD=$O(^LEXT(757.2,"AB",LEXTD)) Q:LEXTD=""!(LEXTV'="")  D
 . . S LEXTL=$O(^LEXT(757.2,"AB",LEXTD,0)) Q:+LEXTL'>0
 . . I $G(^LEXT(757.2,+LEXTL,6))=LEXDICS D
 . . . S LEXTV=$P($G(^LEXT(757.2,+LEXTL,0)),"^",1)
 ;     Build temporary phrase
 I LEXTV'="",LEXTN'="" S LEX("V",1)=LEXTV_" view of the "_LEXTN
 I LEXTV="",LEXTN'="" K LEX("V")
 ;     Process phrase 
 I $D(LEX("V",1)) D
 . S LEX("V",0)=1,LEXT="V",LEXTCTR=0,LEXTSTR=""
 . D CONCAT^LEXDDT2 K LEX("V")
 . I $E(LEXTSTR,$L(LEXTSTR))?1P S LEXTSTR=$E(LEXTSTR,1,($L(LEXTSTR)-1))
 . I $E(LEXTSTR,$L(LEXTSTR))?1P S LEXTSTR=$E(LEXTSTR,1,($L(LEXTSTR)-1))
 . D EOC^LEXDDT2
 Q
