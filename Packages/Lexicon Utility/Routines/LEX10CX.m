LEX10CX ;ISL/KER - ICD-10 Cross-Over - Main ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    None
 ;    
EN ; Suggested Code (Code and Source are unknown, interactive)
 ;
 ; Input
 ; 
 ;     None.  Interactive API.  The variable LEXSAB can
 ;     be preset to a coding system (.01 field in file 
 ;     757.03), else wise the user will be prompted for
 ;     a coding system.
 ; 
 ; Output
 ; 
 ;     X    Source - 4 piece "^" delimited string
 ;     
 ;            1  Lexicon IEN for file 757.02
 ;            2  Expression
 ;            3  Code in selected Coding System
 ;            4  Coding System nomenclature
 ;            
 ;            or null if search fails
 ;            
 ;     Y    Target - 4 piece "^" delimited string
 ;     
 ;            1  Lexicon IEN for file 757.02
 ;            2  Expression
 ;            3  ICD-10 Diagnostic Code
 ;            4  ICD-10-CM
 ;            
 ;            or -1 if search fails
 ;            
 ; Example Output:
 ; 
 ;    ICD-9 to ICD-10
 ; 
 ;       X="119899^Tobacco Use Disorder^305.1^ICD-9-CM"
 ;       Y="5003360^Nicotine Dependence, unspecified, 
 ;          Uncomplicated^F17.200^ICD-10-CM"
 ;    
 ;    SNOMED CT to ICD-10
 ;    
 ;       X="7078519^Diabetes mellitus type 2^44054006^SNOMED CT"
 ;       Y="5002666^Type 2 Diabetes Mellitus without 
 ;          Complications^E11.9^ICD-10-CM"
 ; 
 N LEX0FND,LEX0SEL,LEX0REV,LEXEFF,LEXIT,LEXERR,LEXEXP,LEXIEN,LEXLAD
 N LEXNOM,LEXSRC,LEXSRI,LEXTCOD,LEXTGT,LEXTMP,LEXTTXT,DIROUT,DIRUT
 N DTOUT,DUOUT K X,Y S (LEXIT,LEX0FND,LEX0SEL,LEX0REV)=0
 S LEXERR="Coding system not selected or specified"
 S LEXSAB=$$SAB($G(LEXSAB)) S:$L(LEXSAB)'=3 LEXSAB=$$SAB^LEX10CX4
 I $L(LEXSAB)'=3 D ERR(LEXERR) Q
 S LEXTMP=LEXSAB K LEXSAB N LEXSAB S LEXSAB=LEXTMP
 S LEXSRI=$$SRC(LEXSAB) I +LEXSRI'>0 D ERR(LEXERR) Q
 S LEXNOM=$P($G(^LEX(757.03,+LEXSRI,0)),"^",2)
 I '$L(LEXNOM) D ERR(LEXERR) Q
 S X=$$SRL^LEX10CX2(LEXSAB,.LEXSRC)
 D CX(.LEXSRC)
 Q
EN2(CODE,SYS) ; Suggested Code (Source is known, interactive)
 ;
 ; Input
 ; 
 ;     CODE   Code
 ;     SYS    Coding System Abbreviation
 ; 
 ; Output
 ; 
 ;     X      Source - 4 piece "^" delimited string
 ;     
 ;              1  Lexicon IEN for file 757.02
 ;              2  Expression
 ;              3  Code in selected Coding System
 ;              4  Coding System nomenclature
 ;            
 ;              or null if search fails
 ;            
 ;     Y      Target - 4 piece "^" delimited string
 ;     
 ;              1  Lexicon IEN for file 757.02
 ;              2  Expression
 ;              3  ICD-10 Diagnostic Code
 ;              4  ICD-10-CM
 ;            
 ;              or -1 if search fails
 ;            
 ; Example Output:
 ; 
 ;    ICD-9 to ICD-10
 ; 
 ;       X="119899^Tobacco Use Disorder^305.1^ICD-9-CM"
 ;       Y="5003360^Nicotine Dependence, unspecified, 
 ;          Uncomplicated^F17.200^ICD-10-CM"
 ;    
 ;    SNOMED CT to ICD-10
 ;    
 ;       X="7078519^Diabetes mellitus type 2^44054006^SNOMED CT"
 ;       Y="5002666^Type 2 Diabetes Mellitus without 
 ;          Complications^E11.9^ICD-10-CM"
 ; 
 N LEX0FND,LEX0SEL,LEX0REV,LEXEFF,LEXIT,LEXERR,LEXEXP,LEXIEN,LEXLAD
 N LEXNOM,LEXSRC,LEXSRI,LEXTCOD,LEXTGT,LEXTMP,LEXTTXT,DIROUT,DIRUT
 N DTOUT,DUOUT S (LEXIT,LEX0FND,LEX0SEL,LEX0REV)=0
 S LEXERR="Coding system not selected or specified" S LEXSAB=$$SAB($G(SYS))
 I $L(LEXSAB)'=3 D ERR(LEXERR) Q
 S LEXTMP=LEXSAB K LEXSAB N LEXSAB S LEXSAB=LEXTMP,LEXSRI=$$SRC(LEXSAB)
 I +LEXSRI'>0 D ERR(LEXERR) Q
 S LEXNOM=$P($G(^LEX(757.03,+LEXSRI,0)),"^",2)
 I '$L(LEXNOM) D ERR(LEXERR) Q
 S LEXERR=LEXNOM_" code not selected"
 S LEXTCOD=$G(CODE) I '$L(LEXTCOD) D ERR(LEXERR) Q
 K X,Y D SRA^LEX10CX2(LEXTCOD,LEXSAB,.LEXSRC)
 D CX(.LEXSRC)
 Q
EN3(CODE,SYS,ARY,MAX) ; Suggested Code (Code and Source are known, silent/GUI)
 ;
 ; Input
 ; 
 ;   CODE  Code (required)
 ;   SYS   Coding System Abbreviation (required)
 ;   ARY   Local Array passed by reference (required)
 ;   MAX   Maximum # of suggestions (optional, default 100)
 ; 
 ; Output
 ; 
 ;   ARY   Array, passed by reference
 ;     
 ;         ARY("X")     Input
 ;         ARY("Y",0)   Output   Number of Suggested Entries
 ;         ARY("Y",1)   Output   First Suggestion
 ;         ARY("Y",n)   Output   nth Suggestion
 ;                         
 ;         ARY("E")     Error message
 ;
 ;            Both ARY("X") and ARY("Y",#) are 4 piece "^"
 ;            delimited strings:
 ;                
 ;               1  Internal Entry Number (IEN) file 757.01
 ;               2  Expression (file 757.01, field .01)
 ;               3  Code (file 757.02, field 1)
 ;               4  Nomenclature (file 757.03, field 1)
 ;                  i.e., SNOMED CT, ICD-9-CM or ICD-10-CM
 ; 
 N LEXC,LEX0FND,LEX0SEL,LEX0REV,LEXEFF,LEXI,LEXIT,LEXERR,LEXERRT,LEXEXP,LEXIEN,LEXLAD
 N LEXNASK,LEXNASKM,LEXNOM,LEXQT,LEXSRC,LEXSRI,LEXTCOD,LEXTGT,LEXTMP,LEXTTXT,DIROUT
 N DIRUT,DTOUT,DUOUT S:+($G(MAX))'>0 MAX=100 S LEXNASK=1,LEXNASKM=+($G(MAX))
 K:+LEXNASKM'>0 LEXNASKM S LEXQT=1,LEXERRT=""
 D EN2($G(CODE),$G(SYS)) S LEXNOM=$$SRN("10D") K ARY
 S:$L(LEXERRT) ARY("E")=LEXERRT S (LEXC,LEXI)=0
 F  S LEXI=$O(LEXNASK(LEXI)) Q:+LEXI'>0  D
 . N LEXT S LEXT=$G(LEXNASK(LEXI)) Q:'$L(LEXT)
 . S:$L(LEXNOM) $P(LEXT,"^",4)=LEXNOM
 . S LEXC=LEXC+1 Q:+($G(LEXNASKM))>0&(LEXC>+($G(LEXNASKM)))
 . S ARY("Y",LEXC)=LEXT,ARY("Y",0)=LEXC
 I +($G(ARY("Y",0)))'>0 D
 . S LEXSRC=$G(ARY("X"))
 . K ARY S ARY("Y",0)=0
 . S:$L(LEXSRC) ARY("X")=LEXSRC
 S:$L(LEXERRT) ARY("E")=LEXERRT
 S:$L($G(LEXNASK("X"))) ARY("X")=$G(LEXNASK("X"))
 Q
 ;
CX(LEXSRC) ; Convert to ICD-10
 S LEXNOM=$G(LEXSRC("SOURCE","SRC"))
 I '$D(LEXSRC("SOURCE")) D  Q
 . D ERR("Invalid code for coding system")
 I '$L(LEXNOM) D  Q
 . D ERR(("Invalid coding system passed "_$S($L($G(LEXNOM)):" - ",1:"")_LEXNOM))
 S LEXERR=LEXNOM_" code not selected"
 S LEXIEN=+($G(LEXSRC("SOURCE","Y")))
 I +LEXIEN'>0 D ERR((LEXERR_" (IEN) "_LEXIEN)) Q
 S LEXEXP=$P($G(LEXSRC("SOURCE","Y")),"^",2)
 I '$L(LEXEXP) D ERR((LEXERR_" (Expression) ")) Q
 S LEXERR="Invalid "_LEXNOM_" code selected"
 S LEXTCOD=$G(LEXSRC("SOURCE","SOE"))
 I '$L(LEXTCOD) D ERR((LEXERR_" (Code) "_LEXTCOD)) Q
 I '$D(^LEX(757.01,+LEXIEN,0)) D ERR((LEXERR_" (Expression) ")) Q
 S LEXERR="Invalid coding system"
 S LEXSAB=$G(LEXSRC("SOURCE","SAB"))
 I '$L(LEXSAB) D ERR((LEXERR_" (SAB) "_LEXSAB)) Q
 S LEXERR="Invalid "_LEXNOM_" code selected"
 S LEXLAD=$P($$LA^LEX10CX5(LEXTCOD,LEXSAB),".",1)
 I LEXLAD'?7N D ERR((LEXERR_" (Last Activation Date) "_LEXLAD)) Q
 S LEXEFF=$$FMADD^XLFDT(LEXLAD,3)
 S LEXERR="Invalid text for code"
 S LEXTTXT=$$UP^XLFSTR($G(LEXSRC("SOURCE","EXP")))
 I '$L(LEXTTXT) D ERR((LEXERR_" (Text) ")) Q
 D SEG^LEX10CX5(,.LEXSRC)
 I $O(LEXSRC("SEG",0))'>0 D ERR((LEXERR_" (Segments) ")) Q
 S X=$$FIND1^LEX10CX3(LEXTCOD,.LEXSRC,.LEXTGT) S:+X'>0 X=""
 I +X'>0 S X=$$FIND2^LEX10CX3(LEXTTXT,.LEXSRC,.LEXTGT) S:+X'>0 X=""
 I $G(LEXNASK)>0 D  Q
 . N LEXI,LEXC S LEXC=0 F LEXI=1:1:100 Q:'$L($G(LEXTGT(LEXI)))  D
 . . N LEXT S LEXT=$G(LEXTGT(LEXI)),LEXC=LEXC+1
 . . I +($G(LEXNASKM))>0,+LEXC>+($G(LEXNASKM)) Q
 . . S LEXNASK(LEXC)=LEXT
 . I $L($G(LEXSRC("SOURCE","Y")),"^")=3 D
 . . N LEXT,LEX4 S LEXT=$G(LEXSRC("SOURCE","Y"))
 . . S LEX4=$G(LEXSRC("SOURCE","SRC"))
 . . S:$L(LEX4) $P(LEXT,"^",4)=LEX4
 . . S LEXNASK("X")=LEXT
 . I $L($G(LEXSRC("SOURCE","Y")),"^")'=3 D
 . . N LEX1,LEX2,LEX3,LEX4,LEXT
 . . S LEX1=+($G(LEXSRC("SOURCE","EXI"))) Q:LEX1'>0
 . . S LEX2=$G(LEXSRC("SOURCE","EXP")) Q:'$L(LEX2)
 . . S LEX3=$G(LEXSRC("SOURCE","SOE")) Q:'$L(LEX3)
 . . S LEX4=$G(LEXSRC("SOURCE","SRC"))
 . . S LEXT=LEX1_"^"_LEX2_"^"_LEX3
 . . S:$L(LEX4) $P(LEXT,"^",4)=LEX4
 . . S LEXNASK("X")=LEXT
 S LEXIT=0 I +($G(X))>0 D  Q:LEXIT>0
 . N DIR K DIROUT,DIRUT,DUOUT,DTOUT D ASK^LEX10CX4(.LEXSRC,.LEXTGT)
 . I $D(DIROUT) S (LEX0FND,LEX0REV,LEX0SEL)=0,LEXIT=1
 . K:$G(LEX0FND)>0&($G(LEX0REV)>0)&('$L($G(X))) DIROUT,DIRUT,DUOUT,DTOUT
 . I $D(DIROUT)!($D(DIRUT))!($D(DUOUT))!($D(DTOUT)) D  Q
 . . S X="^",Y=-1 S:$D(DIROUT) LEXIT=1
 . D:+($G(X))>0&(+($G(Y))>0) OUT($G(X),$G(Y))
 . S:+($G(X))>0&(+($G(Y))>0) LEXIT=1
 . S:$G(LEX0FND)>0&($G(LEX0SEL)'>0) LEXIT=0
 . I +($G(X))'>0!($G(Y)=-1) S X="",Y=-1
 I $D(LEXTEST) D
 . W:'$D(LEXQT) !! D SA^LEX10CX5("LEXSRC")
 . W:'$D(LEXQT) !! D SA^LEX10CX5("LEXTGT") N LEXTEST
 I +X'>0 D
 . S X=$$FIND3^LEX10CX3(.LEXSRC,.LEXTGT) S:+X'>0 X=""
 . I $G(LEXTGT(0))=1,$L($G(LEXTGT(1))) D
 . . D X^LEX10CX4(.LEXSRC),Y^LEX10CX4(1,.LEXTGT)
 . . D:+($G(X))>0&(+($G(Y))>0) OUT($G(X),$G(Y))
 S:+($G(X))'>0 X="" S:+($G(Y))'>0 Y=-1
 Q
OUT(X,Y) ; Display Output - Interactive, Positive Results only
 N LEXSI,LEXST,LEXSC,LEXSN,LEXSD,LEXTI,LEXTT,LEXTC,LEXTN
 N LEXTD,LEXL,LEXI S X=$G(X) Q:+X'>0  S Y=$G(Y) Q:+Y'>0
 S LEXSI=$P(X,"^",1) Q:LEXSI'>0  S LEXST(1)=$P(X,"^",2) Q:'$L(LEXST(1))
 S LEXSC=$P(X,"^",3) Q:'$L(LEXSC)  S LEXSN=$P(X,"^",4) Q:'$L(LEXSN)
 S LEXTI=$P(Y,"^",1) Q:LEXTI'>0  S LEXTT(1)=$P(Y,"^",2) Q:'$L(LEXTT(1))
 S LEXTC=$P(Y,"^",3) Q:'$L(LEXTC)  S LEXTN=$P(Y,"^",4) Q:'$L(LEXTN)
 S LEXSD=LEXSN_"   "_LEXSC S LEXTD=LEXTN_"  "_LEXTC
 S LEXL=$L(LEXSD)+5 S:($L(LEXTD)+5)>LEXL LEXL=$L(LEXTD)+5
 D PAR^LEX10CX4(.LEXST,(78-LEXL)),PAR^LEX10CX4(.LEXTT,(78-LEXL))
 W:'$D(LEXQT) !!," ",LEXSD,?LEXL,$G(LEXST(1))
 S LEXI=1 F  S LEXI=$O(LEXST(LEXI)) Q:+LEXI'>0  D
 . W:$L($G(LEXST(LEXI))) !,?LEXL,$G(LEXST(LEXI))
 W:'$D(LEXQT) !," ",LEXTD,?LEXL,$G(LEXTT(1))
 S LEXI=1 F  S LEXI=$O(LEXTT(LEXI)) Q:+LEXI'>0  D
 . W:$L($G(LEXTT(LEXI))) !,?LEXL,$G(LEXTT(LEXI))
 W:'$D(LEXQT) !
 Q
ERR(X) ; Error
 Q:'$L($G(X))  W:'$D(LEXQT) !,?2,$G(X),! S:$D(LEXQT) LEXERRT=$G(X)
 Q
SAB(X) ; Resolve SAB to 3 character Abbreviation
 N LEXSAB,LEXCI,LEXCS S LEXCS=$G(X) Q:'$L(LEXCS) ""
 I LEXCS?1N.N Q:$D(^LEX(757.03,+LEXCS,0)) $E($G(^LEX(757.03,+LEXCS,0)),1,3)
 S LEXCI=$O(^LEX(757.03,"B",$$UP^XLFSTR(LEXCS),0)) Q:$D(^LEX(757.03,+LEXCI,0)) $E($G(^LEX(757.03,+LEXCI,0)),1,3)
 S LEXCI=$O(^LEX(757.03,"ASAB",$$UP^XLFSTR(LEXCS),0)) Q:$D(^LEX(757.03,+LEXCI,0)) $E($G(^LEX(757.03,+LEXCI,0)),1,3)
 S LEXCI=$O(^LEX(757.03,"C",LEXCS,0)) Q:$D(^LEX(757.03,+LEXCI,0)) $E($G(^LEX(757.03,+LEXCI,0)),1,3)
 Q ""
SRC(X) ; Resolve Source (pointer for SAB in 757.03)
 N LEXSAB,LEXCI,LEXCS S LEXCS=$G(X) Q:'$L(LEXCS) ""  S LEXSAB=$$SAB(LEXCS) Q:$L(LEXSAB)'=3 ""
 S X=$O(^LEX(757.03,"ASAB",LEXSAB,0)) S:'$D(^LEX(757.03,+X,0)) X=""
 Q X
SRN(X) ; Resolve Source (pointer for SAB in 757.03)
 N LEXNOM,LEXCI,LEXCS S LEXCS=$G(X) Q:'$L(LEXCS) ""  S LEXCI=$$SRC(LEXCS)
 Q:'$D(^LEX(757.03,+LEXCI,0)) ""  S X=$P($G(^LEX(757.03,+LEXCI,0)),"^",2)
 Q X
