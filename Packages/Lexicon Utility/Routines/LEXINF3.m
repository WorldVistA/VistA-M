LEXINF3 ;ISL/KER - Information - Term ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ; 
 ; Global Variables
 ; ^LEX(757            SACC 1.3
 ; ^LEX(757.01         SACC 1.3
 ; ^LEX(757.018        SACC 1.3
 ; ^LEX(757.02         SACC 1.3
 ; ^LEX(757.03         SACC 1.3
 ; ^LEX(757.033        SACC 1.3
 ; ^LEX(757.21         SACC 1.3
 ; ^LEX(757.32         SACC 1.3
 ; ^LEX(757.33         SACC 1.3
 ; ^LEXT(757.2         SACC 1.3
 ; 
 ; External References
 ; $$STATCHK^LEXSRC2   ICR   4083
 ; $$MIX^LEXXM         ICR   5781
 ; $$DT^XLFDT          ICR  10103
 ; 
TERM(IEN,CDT,ARY,OUT) ; Information about a Term
 ; 
 ; Input
 ; 
 ;   IEN      Expression IEN (file 757.01)
 ;   CDT      Date used to determine status, default TODAY
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
 ;       MC  Major Concept
 ;       FS  Fully Specified Term
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
 ;    ARY("SR")="Source"
 ;    ARY("SR",n)=<source abbreviation>
 ;    ARY("SR","B",<source>,n)=""
 ;    ARY("SR",n,"I")= 4 piece "^" delimited string
 ; 
 ;       1  Source Abbreviation
 ;       2  Source Nomenclature
 ;       3  Source Title
 ;       4  Pointer to CODING SYSTEMS file #757.03
 ; 
 N LEXEFF,LEXD,LEXDISP,LEXEIEN,LEXMIEN,LEXST,LEXSYS,LEXTYPE K ARY S LEXDISP=$G(OUT),LEXEIEN=$G(IEN),LEXD=$G(CDT) S:LEXD'?7N LEXD=$$DT^XLFDT
 S LEXMIEN=$P($G(^LEX(757.01,+LEXEIEN,1)),"^",1) I '$D(^LEX(757.01,+LEXEIEN,0)) K ARY Q
 D CO(LEXEIEN,LEXD,.ARY),EX(LEXEIEN,.ARY),SB(LEXEIEN,.ARY) D:+($G(LEXDISP))>0&($O(ARY("MC",0))>0) TERM^LEXINF5(.ARY)
 Q
CO(X,CDT,ARY) ; Codes                        CO
 N LEXCODE,LEXEF,LEXEIEN,LEXHS,LEXIEN,LEXINIT,LEXND,LEXNOM,LEXSAB,LEXSEQ,LEXSIEN,LEXSO,LEXSRC,LEXST,LEXTMP,LEXTTL
 K ARY("CO"),ARY("SR") S LEXEIEN=$G(X),LEXMIEN=+($G(^LEX(757.01,+LEXEIEN,1))) Q:+LEXMIEN'>0  S LEXD=$G(CDT) S:LEXD'?7N LEXD=$$DT^XLFDT
 S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"AMC",LEXMIEN,LEXSIEN)) Q:+LEXSIEN'>0  D
 . N LEXCODE,LEXEF,LEXHS,LEXIEN,LEXINIT,LEXND,LEXNOM,LEXSAB,LEXSRC,LEXST,LEXTMP,LEXTTL S LEXND=$G(^LEX(757.02,+LEXSIEN,0)) Q:$P(LEXND,"^",5)'>0
 . S LEXIEN=+LEXND Q:LEXIEN'>0  S LEXEF=$O(^LEX(757.02,+LEXSIEN,4,"B",(LEXD+.0001)),-1),LEXHS=$O(^LEX(757.02,+LEXSIEN,4,"B",+LEXEF," "),-1)
 . S LEXST=$P($G(^LEX(757.02,+LEXSIEN,4,+LEXHS,0)),"^",2) Q:LEXST'>0  S LEXCODE=$P(LEXND,"^",2) Q:'$L(LEXCODE)  S LEXSRC=$P(LEXND,"^",3) Q:LEXSRC'>0
 . S LEXSAB=$P($G(^LEX(757.03,+LEXSRC,0)),"^",1)  Q:$L(LEXSAB)'=3  S LEXNOM=$P($G(^LEX(757.03,+LEXSRC,0)),"^",2)  Q:'$L(LEXNOM)
 . S LEXTTL=$P($G(^LEX(757.03,+LEXSRC,0)),"^",3)  Q:'$L(LEXTTL)  S LEXTMP=$$STATCHK^LEXSRC2(LEXCODE,LEXD,,LEXSAB),LEXINIT=$P(LEXTMP,"^",4)
 . S LEXSO(LEXCODE,LEXSRC)=LEXSIEN_"^"_LEXIEN_"^"_LEXST_"^"_LEXEF_"^"_LEXSAB_"^"_LEXNOM_"^"_LEXTTL_"^"_LEXINIT
 S LEXCODE="" F  S LEXCODE=$O(LEXSO(LEXCODE)) Q:'$L(LEXCODE)  S LEXSRC=0 F  S LEXSRC=$O(LEXSO(LEXCODE,LEXSRC)) Q:+LEXSRC'>0  D
 . N LEXEF,LEXEIEN,LEXINIT,LEXND,LEXNOM,LEXSAB,LEXSEQ,LEXSIEN,LEXST,LEXTTL S LEXND=$G(LEXSO(LEXCODE,LEXSRC))
 . S LEXSIEN=+LEXND Q:LEXSIEN'>0  S LEXEIEN=$P(LEXND,"^",2) Q:LEXEIEN'>0  S LEXST=$P(LEXND,"^",3) Q:LEXST'?1N
 . S LEXEF=$P(LEXND,"^",4) Q:LEXEF'?7N  S LEXSAB=$P(LEXND,"^",5) Q:$L(LEXSAB)'=3  S LEXNOM=$P(LEXND,"^",6) Q:'$L(LEXNOM)
 . S LEXTTL=$P(LEXND,"^",7) Q:'$L(LEXTTL)  S LEXINIT=$P(LEXND,"^",7) S:LEXINIT'?7N LEXINIT="" S:LEXEF?7N&(LEXINIT'?7N) LEXINIT=LEXEF
 . S LEXSEQ=$O(ARY("CO"," "),-1)+1 S ARY("CO")="Code",ARY("CO",LEXSEQ)=LEXCODE,ARY("CO",LEXSEQ,"I")=+LEXST_"^"_LEXEF_"^"_LEXINIT_"^"_LEXSIEN_"^"_LEXNOM_"^"_LEXSRC
 . D:LEXSRC=3!(LEXSRC=4) MD(LEXCODE,LEXCDT,LEXSEQ,.ARY)
 . D:"^1^2^3^4^30^31^"[("^"_LEXSRC_"^") VA(LEXCODE,LEXSRC,LEXD,LEXSEQ,.ARY) S ARY("CO","B",LEXSRC,LEXSEQ)="" I '$D(ARY("SR","B",LEXSRC)) D
 . . N LEXSEQ S ARY("SR")="Source",LEXSEQ=$O(ARY("SR"," "),-1)+1 S ARY("SR",LEXSEQ)=LEXSAB S ARY("SR",LEXSEQ,"I")=LEXSAB_"^"_LEXNOM_"^"_LEXTTL_"^"_LEXSRC
 . . S ARY("SR","B",LEXSRC,LEXSEQ)=""
 . D MP(LEXCODE,LEXSRC,LEXD,.ARY) D:LEXSRC=30 OR(LEXCODE,LEXSRC,LEXD,.ARY) D:LEXSRC=30 DC(LEXCODE,LEXD,.ARY) D:LEXSRC=31 CP(LEXCODE,LEXD,.ARY)
 Q
MD(X,Y,IEN,ARY) ;   Modifiers                  CO/MD 
 N LEXCODE,LEXCDT,LEXCPT,LEXENT,LEXO,LEXST,LEXEF,LEXDS,LEXIE
 S LEXCODE=$G(X),LEXCDT=$G(Y) Q:$L(LEXCODE)'=5  S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 S LEXENT=$G(IEN) Q:LEXENT'>0  D MODA^ICPTMOD(LEXCODE,LEXCDT,.LEXCPT)
 S LEXO="" F  S LEXO=$O(LEXCPT("A",LEXO)) Q:'$L(LEXO)  D
 . N LEXND,LEXIE,LEXDS,LEXAR,LEXIR,LEXEF,LEXSEQ
 . S LEXEF="",LEXND=$G(LEXCPT("A",LEXO))
 . S LEXIE=+($P(LEXND,"^",1)) Q:'$D(^DIC(81.3,+LEXIE,0))  Q:$P($G(^DIC(81.3,+LEXIE,0)),"^",1)'=LEXO
 . S LEXDS=$P(LEXND,"^",2) Q:'$L(LEXDS)
 . S LEXAR=$P(LEXND,"^",6),LEXIR=$P(LEXND,"^",7)
 . S:LEXAR?7N&('$L(LEXIR)) LEXST=1,LEXEF=LEXAR
 . S:LEXAR?7N&(LEXIR?7N)&(LEXIR'<LEXAR) LEXST=0,LEXEF=LEXIR
 . S:LEXAR?7N&(LEXIR?7N)&(LEXIR<LEXAR) LEXST=1,LEXEF=LEXAR
 . Q:LEXEF'?7N
 . S LEXSEQ=$O(ARY("CO",LEXENT,"MD"," "),-1)+1
 . S ARY("CO",LEXENT,"MD")="Code Modifiers"
 . S ARY("CO",LEXENT,"MD",LEXSEQ)=LEXO
 . S ARY("CO",LEXENT,"MD",LEXSEQ,"I")=LEXST_"^"_LEXEF_"^"_LEXDS_"^"_LEXIE
 Q
VA(X,Y,D,I,ARY) ;   VA File                    CO/VA 
 N LEXCODE,LEXSRC,LEXCDT,LEXENT,LEXTMP,LEXIEN,LEXSTA,LEXEFF,LEXFI,LEXRT
 S LEXCODE=$G(X),LEXSRC=+($G(Y)),LEXCDT=$G(D),LEXENT=$G(I) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 Q:'$L(LEXCODE)  Q:'$D(^LEX(757.02,"CODE",(LEXCODE_" ")))  Q:LEXSRC'>0  Q:'$D(^LEX(757.03,+LEXSRC,0))
 Q:"^1^2^3^4^30^31^"'[("^"_LEXSRC_"^")  Q:+($G(LEXENT))'>0
 S:LEXSRC=1 LEXTMP=$$STATCHK^ICDEX(LEXCODE,LEXCDT,LEXSRC),LEXFI=80,LEXRT="^ICD9("
 S:LEXSRC=30 LEXTMP=$$STATCHK^ICDEX(LEXCODE,LEXCDT,LEXSRC),LEXFI=80,LEXRT="^ICD9("
 S:LEXSRC=2 LEXTMP=$$STATCHK^ICDEX(LEXCODE,LEXCDT,LEXSRC),LEXFI=80.1,LEXRT="^ICD0("
 S:LEXSRC=31 LEXTMP=$$STATCHK^ICDEX(LEXCODE,LEXCDT,LEXSRC),LEXFI=80.1,LEXRT="^ICD0("
 I LEXSRC=3!(LEXSRC=4) D  Q:'$L($G(LEXTMP))
 . S LEXTMP=$$STATCHK^ICPTAPIU(LEXCODE,LEXCDT) S LEXIEN=$P(LEXTMP,"^",2) I LEXIEN'>0 K LEXTMP Q
 . N LEXD S LEXD=$$CPT^ICPTCOD(LEXIEN,LEXCDT,1) Q:+LEXD'>0  S LEXFI=81,LEXRT="^ICPT("
 . S LEXTMP=+($P(LEXD,"^",7))_"^"_LEXIEN_"^"_$P(LEXD,"^",6)
 I $L(LEXTMP) D
 . S LEXSTA=$P(LEXTMP,"^",1) Q:"^1^0^"'[("^"_LEXSTA_"^")
 . S LEXIEN=$P(LEXTMP,"^",2) Q:+LEXIEN'>0  Q:'$D(@(LEXRT_+LEXIEN_",0)"))
 . S LEXEFF=$P(LEXTMP,"^",3) S:LEXEFF'?7N LEXEFF=""
 . S LEXTMP=LEXSTA_"^"_LEXEFF_"^"_LEXFI_"^"_LEXIEN S:$L($TR($G(LEXRT),"^","")) LEXTMP=LEXTMP_";"_$TR($G(LEXRT),"^","")
 . S ARY("CO",+LEXENT,"VA")=LEXTMP
 Q
EX(X,ARY) ; Expressions                  MC/FS/SY/LV
 N LEXEIEN,LEXEX,LEXEXP,LEXMC,LEXMIEN,LEXND,LEXSEQ,LEXSTA,LEXSTAT,LEXTN,LEXTS,LEXTY
 K ARY("MC"),ARY("LV"),ARY("FS"),ARY("SY") S LEXEIEN=$G(X),LEXMIEN=+($G(^LEX(757.01,+LEXEIEN,1))) Q:+LEXMIEN'>0
 S LEXMIEN=+($G(^LEX(757.01,+LEXEIEN,1))) Q:'$D(^LEX(757,+LEXMIEN,0))
 Q:'$D(^LEX(757.01,"AMC",+LEXMIEN))
 S LEXEX=0 F  S LEXEX=$O(^LEX(757.01,"AMC",LEXMIEN,LEXEX)) Q:+LEXEX'>0  D
 . N LEXEXP,LEXND,LEXSEQ,LEXSTA,LEXSTAT,LEXTN,LEXTS,LEXTY S LEXEXP=$G(^LEX(757.01,+LEXEX,0))
 . Q:'$L(LEXEXP)  S LEXND=$G(^LEX(757.01,+LEXEX,1)),LEXSTA=$P(LEXND,"^",5)
 . S LEXSTA=$S(LEXSTA=1:0,1:1),LEXTY=$P(LEXND,"^",2),LEXSTAT=$S(LEXSTA'>0:"Retired",1:"Current")
 . S LEXTN=$S(LEXTY=1:"Major Concept",LEXTY=3:"Variant",LEXTY=8:"Fully Specified Name",1:"Synonym")
 . S LEXTS=$S(LEXTY=1:"MC",LEXTY=3:"LV",LEXTY=8:"FS",1:"SY")
 . S LEXSEQ=$O(ARY(LEXTS," "),-1)+1,ARY(LEXTS,LEXSEQ)=LEXEXP,ARY(LEXTS)=LEXTN
 . S ARY(LEXTS,LEXSEQ,"I")=LEXSTA_"^"_LEXTN_"^"_$S(LEXSTA'>0:"Retired",1:"Current")_"^"_+LEXEX
 . D DS(LEXTS,LEXSEQ,+LEXEX,.ARY)
 . D SK(LEXTS,LEXSEQ,+LEXEX,.ARY)
 . D NG(LEXTS,LEXSEQ,+LEXEX,.ARY)
 Q
DS(X,Y,IEN,ARY) ;   Designation ID             ID
 N LEXC,LEXDSI,LEXH,LEXHN,LEXIEN,LEXIN,LEXND,LEXS,LEXSB,LEXSEQ,LEXSTA,LEXSYS
 S LEXSB=$G(X) Q:'$L(LEXSB)  S LEXIN=$G(Y) Q:LEXIN'>0  S LEXIEN=$G(IEN) Q:LEXIEN'>0
 S LEXSTA=+($G(ARY(LEXSB,LEXIN,"I"))),LEXDSI=0 F  S LEXDSI=$O(^LEX(757.01,+LEXIEN,7,LEXDSI)) Q:+LEXDSI'>0  D
 . N LEXC,LEXH,LEXHN,LEXND,LEXS,LEXSEQ,LEXSYS S LEXND=$G(^LEX(757.01,LEXIEN,7,LEXDSI,0))
 . S LEXC=$P(LEXND,"^",1) Q:'$L(LEXC)  S LEXS=$P(LEXND,"^",2) Q:+LEXS'>0
 . S LEXSYS=$P($G(^LEX(757.03,+LEXS,0)),"^",2),LEXH=$P(LEXND,"^",3)
 . S LEXHN=$P($G(^LEX(757.018,+LEXH,0)),"^",1),LEXSEQ=$O(ARY(LEXSB,LEXIN,"ID"," "),-1)+1
 . S ARY(LEXSB,LEXIN,"ID")="Designation ID"
 . S ARY(LEXSB,LEXIN,"ID",LEXSEQ)=LEXC
 . S ARY(LEXSB,LEXIN,"ID",LEXSEQ,"I")=LEXSTA_"^"_LEXSYS_"^"_LEXHN_"^"_+LEXDSI
 Q
SK(X,Y,IEN,ARY) ;   Supplemental Keywords      SK
 N LEXC,LEXSKI,LEXH,LEXHN,LEXIEN,LEXIN,LEXND,LEXS,LEXSB,LEXSEQ,LEXSTA,LEXSYS
 S LEXSB=$G(X) Q:'$L(LEXSB)  S LEXIN=$G(Y) Q:LEXIN'>0  S LEXIEN=$G(IEN) Q:LEXIEN'>0
 S LEXSTA=+($G(ARY(LEXSB,LEXIN,"I"))),LEXSKI=0 F  S LEXSKI=$O(^LEX(757.01,+LEXIEN,5,LEXSKI)) Q:+LEXSKI'>0  D
 . N LEXK,LEXH,LEXHN,LEXND,LEXS,LEXSEQ,LEXSYS S LEXND=$G(^LEX(757.01,LEXIEN,5,LEXSKI,0))
 . S LEXK=$P(LEXND,"^",1) Q:'$L(LEXK)  S LEXSEQ=$O(ARY(LEXSB,LEXIN,"SK"," "),-1)+1
 . S ARY(LEXSB,LEXIN,"SK")="Supplemental Keywords"
 . S ARY(LEXSB,LEXIN,"SK",LEXSEQ)=LEXK
 . S ARY(LEXSB,LEXIN,"SK",LEXSEQ,"I")=LEXSTA_"^^^"_+LEXSKI
 Q
NG(X,Y,IEN,ARY) ;   Negations                  NG
 N LEXC,LEXNGI,LEXH,LEXHN,LEXIEN,LEXIN,LEXND,LEXS,LEXSB,LEXSEQ,LEXSTA,LEXSYS
 S LEXSB=$G(X) Q:'$L(LEXSB)  S LEXIN=$G(Y) Q:LEXIN'>0  S LEXIEN=$G(IEN) Q:LEXIEN'>0
 S LEXSTA=+($G(ARY(LEXSB,LEXIN,"I"))),LEXNGI=0 F  S LEXNGI=$O(^LEX(757.01,+LEXIEN,4,LEXNGI)) Q:+LEXNGI'>0  D
 . N LEXK,LEXH,LEXHN,LEXND,LEXS,LEXSEQ,LEXSYS S LEXND=$G(^LEX(757.01,LEXIEN,4,LEXNGI,0))
 . S LEXK=$P(LEXND,"^",1) Q:'$L(LEXK)  S LEXSEQ=$O(ARY(LEXSB,LEXIN,"NG"," "),-1)+1
 . S ARY(LEXSB,LEXIN,"NG")="Negations"
 . S ARY(LEXSB,LEXIN,"NG",LEXSEQ)=LEXK
 . S ARY(LEXSB,LEXIN,"NG",LEXSEQ,"I")=LEXSTA_"^^^"_+LEXNGI
 Q
OR(X,Y,CDT,ARY) ; Orphan Text                  OR
 N LEXD,LEXCODE,LEXEIEN,LEXEXP,LEXND,LEXSEQ,LEXSIEN,LEXSRC,LEXSTA,LEXSTAT,LEXSYS,LEXTY K ARY("OR")
 S LEXCODE=$G(X),LEXSYS=$G(Y),LEXSRC="" S:$G(LEXSYS)?1N.N&($D(^LEX(757.03,+($G(LEXSYS)),0))) LEXSRC=+($G(LEXSYS))
 S:$G(LEXSYS)'?1N.N&($L($G(LEXSYS))=3)&($D(^LEX(757.03,"ASAB",$G(LEXSYS)))) LEXSRC=$O(^LEX(757.03,"ASAB",$G(LEXSYS)))
 Q:LEXSRC'?1N.N  S LEXD=$G(CDT) S:LEXD'?7N LEXD=$$DT^XLFDT
 S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"CODE",(LEXCODE_" "),LEXSIEN)) Q:+LEXSIEN'>0  D
 . N LEXEF,LEXEIEN,LEXEXP,LEXHS,LEXND,LEXSEQ,LEXST,LEXSTA,LEXSTAT,LEXTY
 . S LEXEF=$O(^LEX(757.02,+LEXSIEN,"4","B",(LEXD+.00001)),-1)
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
MP(X,Y,CDT,ARY) ; Mappings                     MP
 N LEXD,LEXCODE,LEXSRC,LEXSYS,LEXTO S LEXCODE=$G(X),LEXSYS=$G(Y) K ARY("MP") Q:'$L(LEXCODE)  Q:'$L(LEXSYS)
 S LEXSRC="" S:$G(LEXSYS)?1N.N&($D(^LEX(757.03,+($G(LEXSYS)),0))) LEXSRC=+($G(LEXSYS))
 S:$G(LEXSYS)'?1N.N&($L($G(LEXSYS))=3)&($D(^LEX(757.03,"ASAB",$G(LEXSYS)))) LEXSRC=$O(^LEX(757.03,"ASAB",$G(LEXSYS)))
 Q:'$D(^LEX(757.03,+LEXSRC,0))  Q:LEXCODE="R69."&(LEXSRC=30)  S LEXD=$G(CDT) S:LEXD'?7N LEXD=$$DT^XLFDT
 S LEXTO="" F  S LEXTO=$O(^LEX(757.33,"ACT",(LEXCODE_" "),LEXTO)) Q:'$L(LEXTO)  D
 . N LEXEF,LEXMCODE,LEXMDEF,LEXMIEN,LEXMMAT,LEXMNOM,LEXMSSY,LEXMTSY,LEXND,LEXSEQ,LEXST,LEXSTR
 . S LEXEF=$O(^LEX(757.33,"ACT",(LEXCODE_" "),LEXTO,(LEXD+.0001)),-1) Q:'$L(LEXEF)
 . S LEXST=$O(^LEX(757.33,"ACT",(LEXCODE_" "),LEXTO,LEXEF," "),-1) Q:'$L(LEXST)
 . S LEXMIEN=$O(^LEX(757.33,"ACT",(LEXCODE_" "),LEXTO,LEXEF,+LEXST," "),-1) Q:+LEXMIEN'>0
 . S LEXND=$G(^LEX(757.33,+LEXMIEN,0)),LEXMCODE=$P(LEXND,"^",3),LEXMMAT=$P(LEXND,"^",5)
 . S LEXMMAT=$S(+LEXMMAT>0:"Full",1:"Part") S LEXMDEF=$P(LEXND,"^",4)
 . S LEXMSSY=$P($G(^LEX(757.32,+LEXMDEF,2)),"^",1) Q:LEXMSSY'=LEXSRC  S LEXMTSY=$P($G(^LEX(757.32,+LEXMDEF,2)),"^",2)
 . S LEXMNOM=$P($G(^LEX(757.03,+LEXMTSY,0)),"^",2),LEXSTR=+LEXST,$P(LEXSTR,"^",2)=LEXEF S:$L(LEXMNOM) $P(LEXSTR,"^",3)=LEXMNOM
 . S:+LEXMIEN>0 $P(LEXSTR,"^",4)=+LEXMIEN S:$L(LEXMMAT) $P(LEXSTR,"^",5)=LEXMMAT S $P(LEXSTR,"^",6)=LEXCODE
 . S $P(LEXSTR,"^",7)=LEXMSSY S ARY("MP")="Mapping",LEXSEQ=$O(ARY("MP"," "),-1)+1,ARY("MP",LEXSEQ)=LEXMCODE
 . S ARY("MP",LEXSEQ,"I")=LEXSTR
 Q
SB(X,ARY) ; Subsets                      SB
 N LEXIENS,LEXEX,LEXMC,LEXDA,LEXIEN,LEXSO,LEXSIEN,LEXSRC,LEXSYS
 S LEXEX=+($G(X)),LEXMC=+($P($G(^LEX(757.01,+LEXEX,1)),"^",1)),LEXDA=+($P($G(^LEX(757.01,+LEXEX,1)),"^",5))
 Q:+LEXEX'>0  Q:+LEXMC'>0  Q:LEXDA'?1N  Q:+LEXDA>0
 S LEXEX=+($G(^LEX(757,+LEXMC,0))) I $D(^LEX(757.21,"B",+LEXEX)) D  Q
 . N LEXIEN,LEXSIEN S LEXIEN=LEXEX,LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.21,"B",+LEXEX,LEXSIEN)) Q:LEXSIEN'>0  D
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
DC(X,CDT,ARY) ; Diagnostic Categories        DC
 D DC^LEXINF2($G(X),$G(CDT),.ARY)
 Q
CP(X,CDT,ARY) ; Character Positions          CP
 D CP^LEXINF2($G(X),$G(CDT),.ARY)
 Q
