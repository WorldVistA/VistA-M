LEXINF2 ;ISL/KER - Information - Code ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ; 
 ; Global Variables
 ;    ^LEX(757            SACC 1.3
 ;    ^LEX(757.01         SACC 1.3
 ;    ^LEX(757.018        SACC 1.3
 ;    ^LEX(757.02         SACC 1.3
 ;    ^LEX(757.03         SACC 1.3
 ;    ^LEX(757.033        SACC 1.3
 ;    ^LEX(757.21         SACC 1.3
 ;    ^LEX(757.32         SACC 1.3
 ;    ^LEX(757.33         SACC 1.3
 ;    ^LEXT(757.2         SACC 1.3
 ; 
 ; External References
 ;    $$STATCHK^LEXSRC2   ICR 4083
 ;    $$MIX^LEXXM         ICR 5781
 ;    $$DT^XLFDT          ICR  10103
 ; 
CODE(CODE,SRC,CDT,ARY,OUT) ; Information about a code
 ; 
 ; Input
 ; 
 ;   CODE     Code (file 757.02) (Required)
 ;   SRC      Source Abbr. or pointer to file 757.03 (Required)
 ;   CDT      Date used to determine status, default TODAY
 ;  .ARY      Local Array, passed by reference
 ;   OUT      Output/Display ARY (Optional)
 ;              0  Do not Display (default)
 ;              1  Display
 ; Output
 ; 
 ;   ARY
 ; 
 ;   Code
 ; 
 ;     ARY("CO")="Code"
 ;     ARY("CO",n)=<code>
 ;     ARY("CO","B",<code>,n)=""
 ;     ARY("CO",n,"I")= 6 piece "^" delimited string
 ; 
 ;       1  Status
 ;       2  Effective Date
 ;       3  Initial Activation Date
 ;       4  Pointer to CODES file #757.02
 ;       5  Coding System Nomenclature
 ;       6  Coding System
 ; 
 ;     ARY("CO",n,"MD")="Code Modifiers"
 ;     ARY("CO",n,"MD",n)=<modifier>
 ;     ARY("CO",n,"MD",n,"I")= 4 piece "^" delimited string
 ;     
 ;       1  Status
 ;       2  Effective Date
 ;       3  Modifier Name
 ;       4  Pointer to CPT MODIFIER file #81.3
 ;     
 ;     ARY("CO",n,"VA")= 4 piece "^" delimited string
 ; 
 ;       1  Status
 ;       2  Effective Date
 ;       3  VA File Number
 ;       4  Variable Pointer to VA File
 ;  
 ;   Diagnostic Categories (ICD-10-CM only)
 ; 
 ;     ARY("DC")="Diagnostic Categories"
 ;     ARY("DC",1)=<category>
 ;     ARY("DC",1,"I")= 4 piece "^" delimited string
 ; 
 ;       1  Status
 ;       2  Effective Date
 ;       3  Category Name
 ;       4  Pointer to CHARACTER POSITIONS file #757.033
 ; 
 ;   Procedure Characters Positions (ICD-10-PCS only)
 ; 
 ;     Where n is a character position number 1-7
 ; 
 ;     ARY("CP")="Procedure Characters"
 ;     ARY("CP","I")=<code>
 ;     ARY("CP",n)=<character position 1-n>
 ;     ARY("CP",n,"I")= 4 piece "^" delimited string
 ; 
 ;       1  Status
 ;       2  Effective Date
 ;       3  Name
 ;       4  Pointer to CHARACTER POSITIONS file #757.033
 ; 
 ;   Terms
 ; 
 ;     Subscript SUB can be:
 ; 
 ;       PF  Preferred Term
 ;       FS  Fully Specified Term
 ;       MC  Major Concept
 ;       SY  Synonyms
 ;       LV  Lexical Variants
 ;       OR  Orphan Text
 ; 
 ;     ARY(SUB)=type
 ;     ARY(SUB,n)=<expression>
 ;     ARY(SUB,n,"I")= 4 piece "^" delimited string
 ; 
 ;       1  Status
 ;       2  Type
 ;       3  Current/Retired
 ;       4  Pointer to EXPRESSIONS file #757.01
 ; 
 ;     ARY(SUB,n,"ID")="Designation ID"
 ;     ARY(SUB,n,"ID",n)<designation ID>
 ;     ARY(SUB,n,"ID",n,"I")= 4 piece "^" delimited string
 ; 
 ;       1  Status
 ;       2  Coding System
 ;       3  Hierarchy
 ;       4  Pointer to DESIGNATION CODE subfile #757.118
 ; 
 ;     ARY(SUB,n,"SK")="Supplemental Keywords"
 ;     ARY(SUB,n,"SK",n)=<keyword>
 ;     ARY(SUB,n,"SK",n,"I")= 4 piece "^" delimited string
 ; 
 ;       1  Status
 ;       2  Not used
 ;       3  Not used
 ;       4  Pointer to SUPPLEMENTAL subfile #757.18
 ; 
 ;   Mappings
 ; 
 ;     ARY("MP")="Mapping"
 ;     ARY("MP",n)=<map to target code>
 ;     ARY("MP",n,"I")= 6 piece "^" delimited string
 ; 
 ;       1  Status
 ;       2  Effective
 ;       3  Coding System
 ;       4  Pointer to MAPPINGS file #757.33
 ;       5  Match (full/partial)
 ;       6  Source Code
 ;       7  Source Coding System
 ; 
 ;   Subsets
 ; 
 ;     ARY("SB")="Subsets"
 ;     ARY("SB",n)=<subset>
 ;     ARY("SB",n,"I")= 5 piece "^" delimited string
 ; 
 ;       1  Status
 ;       2  Pointer to SUBSET file #757.21
 ;       3  Pointer to EXPRESSION file #757.01
 ;       4  Pointer to SUBSET DEFINITION file #757.2
 ;       5  Subset ID
 ; 
 ;   Source
 ; 
 ;     ARY("SR")="Source"
 ;     ARY("SR",n)=<source abbreviation>
 ;     ARY("SR",n,"I")= 4 piece "^" delimited string
 ;     ARY("SR","B",<source>,n)=""
 ; 
 ;       1  Source Abbreviation
 ;       2  Source Nomenclature
 ;       3  Source Title
 ;       4  Pointer to CODING SYSTEMS file #757.03
 ; 
 N LEXCDT,LEXEFF,LEXCODE,LEXDISP,LEXEIEN,LEXMIEN,LEXPF,LEXSIEN,LEXSRC,LEXST,LEXSYS,LEXTYPE K ARY S LEXDISP=+($G(OUT))
 S LEXCODE=$G(CODE),LEXSRC=$G(SRC),LEXCDT=$G(CDT) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 S:'$L(LEXSRC)&($L(LEXCODE)) LEXSRC=$$SRC^LEXINF(LEXCODE)
 S:$G(SRC)'?1N.N&($L($G(SRC))=3)&($D(^LEX(757.03,"ASAB",$G(SRC)))) LEXSRC=$O(^LEX(757.03,"ASAB",$G(SRC),0))
 I '$L(LEXCODE)!(+LEXSRC'>0) K ARY Q
 D CO(LEXCODE,LEXSRC,LEXCDT,.ARY) S LEXSIEN=$P($G(ARY("CO",1,"I")),"^",4),LEXMIEN=$P($G(^LEX(757.02,+LEXSIEN,0)),"^",4)
 S LEXEIEN=$P($G(^LEX(757.02,+LEXSIEN,0)),"^",1) I LEXSIEN'>0!(LEXMIEN'>0)!(LEXEIEN'>0) K ARY Q
 D PF(LEXCODE,.ARY) S LEXPF=$P($G(ARY("PF",1,"I")),"^",4) I LEXPF'>0 K ARY Q
 D OT(LEXEIEN,LEXPF,.ARY),SB(LEXCODE,LEXSRC,.ARY),MP(LEXCODE,LEXSRC,LEXCDT,.ARY)
 I +($G(LEXDISP))>0 D CODE^LEXINF5(.ARY)
 Q
CO(X,Y,CDT,ARY) ; Code                         CO
 N LEXCDT,LEXCODE,LEXEFF,LEXIEN,LEXINIT,LEXNOM,LEXSAB,LEXSRC,LEXST,LEXSTAT,LEXSYS,LEXTTL Q:'$L(X)  Q:'$L(Y)
 K ARY("CO"),ARY("SR") S LEXCODE=$G(X),LEXSYS=$G(Y),LEXSRC=""
 S:$G(LEXSYS)?1N.N&($D(^LEX(757.03,+($G(LEXSYS)),0))) LEXSRC=+($G(LEXSYS))
 S:$G(LEXSYS)'?1N.N&($L($G(LEXSYS))=3)&($D(^LEX(757.03,"ASAB",$G(LEXSYS)))) LEXSRC=$O(^LEX(757.03,"ASAB",$G(LEXSYS)))
 Q:LEXSRC'?1N.N  D SR(LEXSRC) Q:$L($G(LEXSAB))'=3  Q:'$L($G(LEXNOM))  Q:'$L($G(LEXTTL))
 S LEXCDT=$G(CDT) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT S LEXSTAT=$$STATCHK^LEXSRC2(LEXCODE,LEXCDT,,LEXSAB)
 S LEXST=+LEXSTAT,LEXIEN=$P(LEXSTAT,"^",2),LEXEFF=$P(LEXSTAT,"^",3),LEXINIT=$P(LEXSTAT,"^",4)
 S:LEXEFF?7N&(LEXINIT'?7N) LEXINIT=LEXEFF S ARY("CO",1)=LEXCODE
 S ARY("CO")="Code",ARY("CO",1,"I")=+LEXSTAT_"^"_LEXEFF_"^"_LEXINIT_"^"_LEXIEN_"^"_LEXNOM_"^"_LEXSRC
 S ARY("CO","B",LEXSRC,1)="" D:"^1^2^3^4^30^31^"[("^"_LEXSRC_"^") VA^LEXINF3(LEXCODE,LEXSRC,LEXCDT,1,.ARY)
 S ARY("SR")="Source",ARY("SR",1)=LEXSAB,ARY("SR",1,"I")=LEXSAB_"^"_LEXNOM_"^"_LEXTTL_"^"_LEXSRC
 S ARY("SR","B",LEXSRC,1)=""
 D:LEXSRC=3!(LEXSRC=4) MD^LEXINF3(LEXCODE,LEXCDT,1,.ARY)
 D:LEXSRC=30 DC(LEXCODE,LEXCDT,.ARY) D:LEXSRC=31 CP(LEXCODE,LEXCDT,.ARY)
 Q
MD(X,Y,I,ARY) ;   Modifiers                  CO/MD
 D MD^LEXINF3($G(X),$G(Y),$G(I),.ARY)
 Q
VA(X,Y,D,I,ARY) ;   VA File                    CO/VA 
 D VA^LEXINF3($G(X),$G(Y),$G(D),$G(I),.ARY)
 Q
PF(CODE,ARY) ; Preferred Term               PF
 N LEXCODE,LEXEFF,LEXEIEN,LEXEXP,LEXND,LEXSIEN,LEXSTA,LEXSTAT,LEXTY K ARY("PF") S LEXCODE=$G(CODE) Q:'$L(LEXCODE)
 S LEXEFF=$O(^LEX(757.02,"ACT",(LEXCODE_" "),3," "),-1) Q:LEXEFF'?7N
 S LEXSIEN=$O(^LEX(757.02,"ACT",(LEXCODE_" "),3,+LEXEFF," "),-1) Q:+LEXSIEN'>0
 S LEXND=$G(^LEX(757.02,+LEXSIEN,0)) Q:$P(LEXND,"^",5)'>0  S LEXEIEN=+LEXND Q:LEXEIEN'>0
 S LEXEXP=$G(^LEX(757.01,+LEXEIEN,0)) Q:'$L(LEXEXP)  S LEXND=$G(^LEX(757.01,+LEXEIEN,1))
 S LEXSTA=$P(LEXND,"^",5),LEXSTA=$S(LEXSTA=1:0,1:1) S LEXSTAT=$S(LEXSTA'>0:"Retired",1:"Current")
 S LEXTY=$P(LEXND,"^",2),LEXTY=$S(LEXTY=1:"Major Concept",LEXTY=3:"Variant",LEXTY=8:"Fully Specified Name",1:"Synonym")
 S ARY("PF")="Preferred Term",ARY("PF",1)=LEXEXP,ARY("PF",1,"I")=LEXSTA_"^"_LEXTY_"^"_LEXSTAT_"^"_+LEXEIEN
 D DS("PF",1,+LEXEIEN,.ARY),SK("PF",1,+LEXEIEN,.ARY),NG("PF",1,+LEXEIEN,.ARY)
 Q
OT(X,LEX,ARY) ; Other Terms                  MC/FS/SY/LV
 N LEXEIEN,LEXEX,LEXEXP,LEXMC,LEXND,LEXPF,LEXSEQ,LEXSTA,LEXTN,LEXTS,LEXTY K ARY("FS") S LEXEIEN=$G(X)
 Q:LEXEIEN'>0  S LEXMC=+($G(^LEX(757.01,+LEXEIEN,1))) Q:'$D(^LEX(757,+LEXMC,0))
 Q:'$D(^LEX(757.01,"AMC",+LEXMC))  S LEXPF=+($G(LEX)) Q:LEXPF'>0  Q:'$D(^LEX(757.01,LEXPF,0))
 S LEXEX=0 F  S LEXEX=$O(^LEX(757.01,"AMC",LEXMC,LEXEX)) Q:+LEXEX'>0  D
 . N LEXEXP,LEXND,LEXSEQ,LEXSTA,LEXSTAT,LEXTN,LEXTS,LEXTY S LEXEXP=$G(^LEX(757.01,+LEXEX,0))
 . Q:'$L(LEXEXP)  S LEXND=$G(^LEX(757.01,+LEXEX,1)),LEXSTA=$P(LEXND,"^",5)
 . S LEXSTA=$S(LEXSTA=1:0,1:1),LEXTY=$P(LEXND,"^",2),LEXSTAT=$S(LEXSTA'>0:"Retired",1:"Current")
 . S LEXTN=$S(LEXTY=1:"Major Concept",LEXTY=3:"Variant",LEXTY=8:"Fully Specified Name",1:"Synonym")
 . S LEXTS=$S(LEXTY=1:"MC",LEXTY=3:"LV",LEXTY=8:"FS",1:"SY")
 . S LEXSEQ=$O(ARY(LEXTS," "),-1)+1,ARY(LEXTS,LEXSEQ)=LEXEXP,ARY(LEXTS)=LEXTN
 . S ARY(LEXTS,LEXSEQ,"I")=LEXSTA_"^"_LEXTN_"^"_$S(LEXSTA'>0:"Retired",1:"Current")_"^"_+LEXEX
 . D DS(LEXTS,LEXSEQ,+LEXEX,.ARY),SK(LEXTS,LEXSEQ,+LEXEX,.ARY),NG(LEXTS,LEXSEQ,+LEXEX,.ARY)
 Q
DS(X,Y,LEX,ARY) ; Designation ID               ID
 N LEXC,LEXDSI,LEXH,LEXHN,LEXIEN,LEXIN,LEXND,LEXS,LEXSB,LEXSEQ,LEXSTA,LEXSYS
 S LEXSB=$G(X) Q:'$L(LEXSB)  S LEXIN=$G(Y) Q:LEXIN'>0  S LEXIEN=$G(LEX) Q:LEXIEN'>0
 S LEXSTA=+($G(ARY(LEXSB,LEXIN,"I"))),LEXDSI=0 F  S LEXDSI=$O(^LEX(757.01,+LEXIEN,7,LEXDSI)) Q:+LEXDSI'>0  D
 . N LEXC,LEXH,LEXHN,LEXND,LEXS,LEXSEQ,LEXSYS S LEXND=$G(^LEX(757.01,LEXIEN,7,LEXDSI,0))
 . S LEXC=$P(LEXND,"^",1) Q:'$L(LEXC)  S LEXS=$P(LEXND,"^",2) Q:+LEXS'>0
 . S LEXSYS=$P($G(^LEX(757.03,+LEXS,0)),"^",2),LEXH=$P(LEXND,"^",3)
 . S LEXHN=$P($G(^LEX(757.018,+LEXH,0)),"^",1),LEXSEQ=$O(ARY(LEXSB,LEXIN,"ID"," "),-1)+1
 . S ARY(LEXSB,LEXIN,"ID")="Designation ID"
 . S ARY(LEXSB,LEXIN,"ID",LEXSEQ)=LEXC
 . S ARY(LEXSB,LEXIN,"ID",LEXSEQ,"I")=LEXSTA_"^"_LEXSYS_"^"_LEXHN_"^"_+LEXDSI
 Q
SK(X,Y,LEX,ARY) ; Supplemental Keywords        SK
 N LEXC,LEXSKI,LEXH,LEXHN,LEXIEN,LEXIN,LEXND,LEXS,LEXSB,LEXSEQ,LEXSTA,LEXSYS
 S LEXSB=$G(X) Q:'$L(LEXSB)  S LEXIN=$G(Y) Q:LEXIN'>0  S LEXIEN=$G(LEX) Q:LEXIEN'>0
 S LEXSTA=+($G(ARY(LEXSB,LEXIN,"I"))),LEXSKI=0 F  S LEXSKI=$O(^LEX(757.01,+LEXIEN,5,LEXSKI)) Q:+LEXSKI'>0  D
 . N LEXK,LEXH,LEXHN,LEXND,LEXS,LEXSEQ,LEXSYS S LEXND=$G(^LEX(757.01,LEXIEN,5,LEXSKI,0))
 . S LEXK=$P(LEXND,"^",1) Q:'$L(LEXK)  S LEXSEQ=$O(ARY(LEXSB,LEXIN,"SK"," "),-1)+1
 . S ARY(LEXSB,LEXIN,"SK")="Supplemental Keywords"
 . S ARY(LEXSB,LEXIN,"SK",LEXSEQ)=LEXK
 . S ARY(LEXSB,LEXIN,"SK",LEXSEQ,"I")=LEXSTA_"^^^"_+LEXSKI
 Q
NG(X,Y,LEX,ARY) ; Negations                    NG
 N LEXC,LEXNGI,LEXH,LEXHN,LEXIEN,LEXIN,LEXND,LEXS,LEXSB,LEXSEQ,LEXSTA,LEXSYS
 S LEXSB=$G(X) Q:'$L(LEXSB)  S LEXIN=$G(Y) Q:LEXIN'>0  S LEXIEN=$G(LEX) Q:LEXIEN'>0
 S LEXSTA=+($G(ARY(LEXSB,LEXIN,"I"))),LEXNGI=0 F  S LEXNGI=$O(^LEX(757.01,+LEXIEN,4,LEXNGI)) Q:+LEXNGI'>0  D
 . N LEXK,LEXH,LEXHN,LEXND,LEXS,LEXSEQ,LEXSYS S LEXND=$G(^LEX(757.01,LEXIEN,4,LEXNGI,0))
 . S LEXK=$P(LEXND,"^",1) Q:'$L(LEXK)  S LEXSEQ=$O(ARY(LEXSB,LEXIN,"NG"," "),-1)+1
 . S ARY(LEXSB,LEXIN,"NG")="Negations"
 . S ARY(LEXSB,LEXIN,"NG",LEXSEQ)=LEXK
 . S ARY(LEXSB,LEXIN,"NG",LEXSEQ,"I")=LEXSTA_"^^^"_+LEXNGI
 Q
SR(SRC) ; Source                       SR
 S LEXSAB=$P($G(^LEX(757.03,+($G(SRC)),0)),"^",1)  Q:$L(LEXSAB)'=3
 S LEXNOM=$P($G(^LEX(757.03,+($G(SRC)),0)),"^",2)  Q:'$L(LEXNOM)
 S LEXTTL=$P($G(^LEX(757.03,+($G(SRC)),0)),"^",3)  Q:'$L(LEXTTL)
 Q
OR(X,Y,CDT,ARY) ; Orphan Text                  OR
 N LEXCDT,LEXCODE,LEXEIEN,LEXEXP,LEXND,LEXSEQ,LEXSIEN,LEXSRC,LEXSTA,LEXSTAT,LEXTY K ARY("OR")
 S LEXCODE=$G(X),LEXSYS=$G(Y),LEXSRC="" S:$G(LEXSYS)?1N.N&($D(^LEX(757.03,+($G(LEXSYS)),0))) LEXSRC=+($G(LEXSYS))
 S:$G(LEXSYS)'?1N.N&($L($G(LEXSYS))=3)&($D(^LEX(757.03,"ASAB",$G(LEXSYS)))) LEXSRC=$O(^LEX(757.03,"ASAB",$G(LEXSYS)))
 Q:LEXSRC'?1N.N  S LEXCDT=$G(CDT) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"CODE",(LEXCODE_" "),LEXSIEN)) Q:+LEXSIEN'>0  D
 . N LEXEF,LEXEIEN,LEXEXP,LEXHS,LEXND,LEXSEQ,LEXST,LEXSTA,LEXSTAT,LEXTY
 . S LEXEF=$O(^LEX(757.02,+LEXSIEN,"4","B",(LEXCDT+.00001)),-1)
 . S LEXHS=$O(^LEX(757.02,+LEXSIEN,"4","B",+LEXEF," "),-1)
 . S LEXST=$P($G(^LEX(757.02,+LEXSIEN,"4",+LEXHS,0)),"^",2)
 . S LEXND=$G(^LEX(757.02,+LEXSIEN,0)) Q:$P(LEXND,"^",5)>0  Q:$P(LEXND,"^",3)'=+($G(LEXSRC))
 . S LEXEIEN=+LEXND,LEXEXP=$G(^LEX(757.01,+LEXEIEN,0)),LEXND=$G(^LEX(757.01,+LEXEIEN,1)) Q:$P(LEXND,"^",4)'=10
 . S LEXTY="VA Derived",LEXSTA=$P(LEXND,"^",5),LEXSTAT="Current" S:LEXSTA>0 LEXSTAT="Retired"
 . S:LEXST'>0 LEXSTAT="Inactive"
 . S LEXSTA=$S(+($G(LEXST))'>0!(+($G(LEXSTA))>0):"0",1:1)
 . S LEXSEQ=$O(ARY("OR"," "),-1)+1,ARY("OR")="Orphan Text",ARY("OR",LEXSEQ)=LEXEXP
 . S ARY("OR",LEXSEQ,"I")=LEXSTA_"^"_LEXTY_"^"_LEXSTAT_"^"_+LEXEIEN
 Q
SB(X,Y,ARY) ; Subsets                      SB
 K LEX N LEXIENS,LEXEX,LEXMC,LEXIEN,LEXSO,LEXSIEN,LEXSRC,LEXSYS S LEXSO=$G(X) Q:'$L(LEXSO)  S LEXSYS=$G(Y)  Q:'$L($G(LEXSYS)) 
 S LEXSRC="" S:$G(LEXSYS)?1N.N&($D(^LEX(757.03,+($G(LEXSYS)),0))) LEXSRC=+($G(LEXSYS))
 S:$G(LEXSYS)'?1N.N&($L($G(LEXSYS))=3)&($D(^LEX(757.03,"ASAB",$G(LEXSYS)))) LEXSRC=$O(^LEX(757.03,"ASAB",$G(LEXSYS)))
 Q:'$D(^LEX(757.03,+LEXSRC,0))  S (LEXST,LEXMC)="",LEXSIEN=0
 S LEXEFF=" " F  S LEXEFF=$O(^LEX(757.02,"ACT",(LEXSO_" "),3,LEXEFF),-1) Q:'$L(LEXEFF)  D  Q:LEXMC>0
 . N LEXSIEN S LEXSIEN=" " F  S LEXSIEN=$O(^LEX(757.02,"ACT",(LEXSO_" "),3,+LEXEFF,LEXSIEN),-1) Q:+LEXSIEN'>0  D  Q:LEXMC>0
 . . N LEXND,LEXEF,LEXHS S LEXND=$G(^LEX(757.02,+LEXSIEN,0)) Q:$P(LEXND,"^",3)'=LEXSRC  Q:$P(LEXND,"^",5)'>0
 . . S LEXEF=$O(^LEX(757.02,+LEXSIEN,"4","B",(LEXCDT+.00001)),-1)
 . . S LEXHS=$O(^LEX(757.02,+LEXSIEN,"4","B",+LEXEF," "),-1)
 . . S LEXST=$P($G(^LEX(757.02,+LEXSIEN,"4",+LEXHS,0)),"^",2)
 . . S LEXMC=$P(LEXND,"^",4)
 Q:+LEXMC'>0  Q:LEXST'?1N  S LEXEX=+($G(^LEX(757,+LEXMC,0))) I $D(^LEX(757.21,"B",+LEXEX)) D  Q
 . S LEXIEN=LEXEX,LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.21,"B",+LEXEX,LEXSIEN)) Q:LEXSIEN'>0  D
 . . N LEXND,LEXSI,LEXSA,LEXSF,LEXSTR,LEXSEQ
 . . S LEXSI=$P($G(^LEX(757.21,+LEXSIEN,0)),"^",2),LEXND=$G(^LEXT(757.2,+LEXSI,0))
 . . S LEXSA=$P(LEXND,"^",2),LEXSF=$$MIX^LEXXM($P(LEXND,"^",1))
 . . S LEXSTR=+($G(LEXST)) S:+LEXSIEN>0 $P(LEXSTR,"^",2)=+LEXSIEN S:+LEXEX>0 $P(LEXSTR,"^",3)=+LEXEX
 . . S:+LEXSI>0 $P(LEXSTR,"^",4)=+LEXSI S:$L(LEXSA) $P(LEXSTR,"^",5)=LEXSA S ARY("SB")="Subsets"
 . . S LEXSEQ=$O(ARY("SB"," "),-1)+1 S ARY("SB",LEXSEQ)=LEXSF S ARY("SB",LEXSEQ,"I")=LEXSTR
 S LEXIEN=0 F  S LEXIEN=$O(^LEX(757.01,"AMC",LEXMC,LEXIEN)) Q:+LEXIEN'>0  D
 . Q:$P($G(^LEX(757.01,+LEXIEN,1)),"^",5)>0  S LEXIENS(LEXIEN)=""
 Q:$O(LEXIENS(0))'>0  S LEXIEN=0 F  S LEXIEN=$O(LEXIENS(LEXIEN)) Q:+LEXIEN'>0  D
 . Q:'$D(^LEX(757.21,"B",LEXIEN))  S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.21,"B",LEXIEN,LEXSIEN)) Q:LEXSIEN'>0  D
 . . N LEXND,LEXSI,LEXSA,LEXSF,LEXSTR,LEXSEQ
 . . S LEXSI=$P($G(^LEX(757.21,+LEXSIEN,0)),"^",2),LEXND=$G(^LEXT(757.2,+LEXSI,0))
 . . S LEXSA=$P(LEXND,"^",2),LEXSF=$$MIX^LEXXM($P(LEXND,"^",1))
 . . S LEXSTR=+($G(LEXST)) S:+LEXSIEN>0 $P(LEXSTR,"^",2)=+LEXSIEN S:+LEXIEN>0 $P(LEXSTR,"^",3)=+LEXIEN
 . . S:+LEXSI>0 $P(LEXSTR,"^",4)=+LEXSI S:$L(LEXSA) $P(LEXSTR,"^",5)=LEXSA S ARY("SB")="Subsets"
 . . S LEXSEQ=$O(ARY("SB"," "),-1)+1 S ARY("SB",LEXSEQ)=LEXSF S ARY("SB",LEXSEQ,"I")=LEXSTR
 Q
MP(X,Y,CDT,ARY) ; Mappings                     MP
 N LEXCDT,LEXCODE,LEXSRC,LEXTO S LEXCODE=$G(X),LEXSYS=$G(Y) K ARY("MP") Q:'$L(LEXCODE)  Q:'$L(LEXSYS)
 S LEXSRC="" S:$G(LEXSYS)?1N.N&($D(^LEX(757.03,+($G(LEXSYS)),0))) LEXSRC=+($G(LEXSYS))
 S:$G(LEXSYS)'?1N.N&($L($G(LEXSYS))=3)&($D(^LEX(757.03,"ASAB",$G(LEXSYS)))) LEXSRC=$O(^LEX(757.03,"ASAB",$G(LEXSYS)))
 Q:'$D(^LEX(757.03,+LEXSRC,0))  Q:LEXCODE="R69."&(LEXSRC=30)  S LEXCDT=$G(CDT) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 S LEXTO="" F  S LEXTO=$O(^LEX(757.33,"ACT",(LEXCODE_" "),LEXTO)) Q:'$L(LEXTO)  D
 . N LEXEF,LEXMCODE,LEXMDEF,LEXMIEN,LEXMMAT,LEXMNOM,LEXMSSY,LEXMTSY,LEXND,LEXSEQ,LEXST,LEXSTR
 . S LEXEF=$O(^LEX(757.33,"ACT",(LEXCODE_" "),LEXTO,(LEXCDT+.0001)),-1) Q:'$L(LEXEF)
 . S LEXST=$O(^LEX(757.33,"ACT",(LEXCODE_" "),LEXTO,LEXEF," "),-1) Q:'$L(LEXST)
 . S LEXMIEN=$O(^LEX(757.33,"ACT",(LEXCODE_" "),LEXTO,LEXEF,+LEXST," "),-1) Q:+LEXMIEN'>0
 . S LEXND=$G(^LEX(757.33,+LEXMIEN,0)),LEXMCODE=$P(LEXND,"^",3),LEXMMAT=$P(LEXND,"^",5)
 . S LEXMMAT=$S(+LEXMMAT>0:"Full",1:"Part") S LEXMDEF=$P(LEXND,"^",4)
 . S LEXMSSY=$P($G(^LEX(757.32,+LEXMDEF,2)),"^",1) Q:LEXMSSY'=LEXSRC
 . S LEXMTSY=$P($G(^LEX(757.32,+LEXMDEF,2)),"^",2),LEXMNOM=$P($G(^LEX(757.03,+LEXMTSY,0)),"^",2)
 . S LEXSTR=+LEXST,$P(LEXSTR,"^",2)=LEXEF S:$L(LEXMNOM) $P(LEXSTR,"^",3)=LEXMNOM
 . S:+LEXMIEN>0 $P(LEXSTR,"^",4)=+LEXMIEN S:$L(LEXMMAT) $P(LEXSTR,"^",5)=LEXMMAT
 . S $P(LEXSTR,"^",6)=LEXCODE,$P(LEXSTR,"^",7)=LEXMSSY,ARY("MP")="Mapping"
 . S LEXSEQ=$O(ARY("MP"," "),-1)+1,ARY("MP",LEXSEQ)=LEXMCODE,ARY("MP",LEXSEQ,"I")=LEXSTR
 Q
DC(X,CDT,ARY) ; Diagnostic Categories        DC
 K ARY("DC") N LEXCDT,LEXCID,LEXCODE,LEXI S LEXCDT=$G(CDT) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 S LEXCODE=$G(X),LEXCID="10D" F LEXI=1:1 Q:'$L($E(LEXCODE,LEXI))  D
 . N LEXCAT,LEXCIEN,LEXEF,LEXHS,LEXSEQ,LEXST,LEXSTR,LEXTD,LEXTH,LEXTX S LEXCID=LEXCID_$E(LEXCODE,LEXI)
 . S LEXCIEN=$O(^LEX(757.033,"B",LEXCID,0)) Q:+LEXCIEN'>0  S LEXCAT=$P(LEXCID,"10D",2)
 . S LEXEF=$O(^LEX(757.033,+LEXCIEN,1,"B",(LEXCDT+.0001)),-1) S LEXHS=$O(^LEX(757.033,+LEXCIEN,1,"B",+LEXEF," "),-1)
 . S LEXST=$P($G(^LEX(757.033,+LEXCIEN,1,+LEXHS,0)),"^",2) S LEXTD=$O(^LEX(757.033,+LEXCIEN,2,"B",(LEXCDT+.0001)),-1)
 . S LEXTH=$O(^LEX(757.033,+LEXCIEN,2,"B",+LEXTD," "),-1) S LEXTX=$P($G(^LEX(757.033,+LEXCIEN,2,+LEXTH,1)),"^",1)
 . S LEXSTR=LEXST S:LEXEF?7N $P(LEXSTR,"^",2)=LEXEF S:$L(LEXTX) $P(LEXSTR,"^",3)=LEXTX S $P(LEXSTR,"^",4)=+LEXCIEN
 . S LEXSEQ=$O(ARY("DC"," "),-1)+1 S ARY("DC",LEXSEQ)=LEXCAT S ARY("DC",LEXSEQ,"I")=LEXSTR
 . S ARY("DC")="Diagnostic Categories",ARY("DC","I")=LEXCODE
 Q
CP(X,CDT,ARY) ; Character Positions          CP
 K ARY("CP") N LEXCDT,LEXCID,LEXCODE,LEXI S LEXCDT=$G(CDT) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 S LEXCODE=$G(X),LEXCID="10P" F LEXI=1:1 Q:'$L($E(LEXCODE,LEXI))  D
 . N LEXCAT,LEXCIEN,LEXEF,LEXHS,LEXSEQ,LEXST,LEXSTR,LEXTD,LEXTH,LEXTX S LEXCID=LEXCID_$E(LEXCODE,LEXI)
 . S LEXCIEN=$O(^LEX(757.033,"B",LEXCID,0)) Q:+LEXCIEN'>0  S LEXCAT=$P(LEXCID,"10P",2)
 . S LEXEF=$O(^LEX(757.033,+LEXCIEN,1,"B",(LEXCDT+.0001)),-1) S LEXHS=$O(^LEX(757.033,+LEXCIEN,1,"B",+LEXEF," "),-1)
 . S LEXST=$P($G(^LEX(757.033,+LEXCIEN,1,+LEXHS,0)),"^",2) S LEXTD=$O(^LEX(757.033,+LEXCIEN,2,"B",(LEXCDT+.0001)),-1)
 . S LEXTH=$O(^LEX(757.033,+LEXCIEN,2,"B",+LEXTD," "),-1) S LEXTX=$P($G(^LEX(757.033,+LEXCIEN,2,+LEXTH,1)),"^",1)
 . S LEXSTR=LEXST S:LEXEF?7N $P(LEXSTR,"^",2)=LEXEF S:$L(LEXTX) $P(LEXSTR,"^",3)=LEXTX S $P(LEXSTR,"^",4)=+LEXCIEN
 . S LEXSEQ=$O(ARY("CP"," "),-1)+1 S ARY("CP",LEXSEQ)=LEXCAT S ARY("CP",LEXSEQ,"I")=LEXSTR
 . S ARY("CP")="Procedure Characters",ARY("CP","I")=LEXCODE
 Q
