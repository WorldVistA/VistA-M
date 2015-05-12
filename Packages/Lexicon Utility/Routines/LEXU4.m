LEXU4 ;ISL/KER - Miscellaneous Lexicon Utilities ;12/19/2014
 ;;2.0;LEXICON UTILITY;**80,86**;Sep 23, 1996;Build 1
 ;               
 ;               
 ; Global Variables
 ;    ^ICPT("BA"
 ;               
 ; External References
 ;    $$CODEABA^ICDEX     ICR   5747
 ;    $$ICDDX^ICDEX       ICR   5747
 ;    $$ICDOP^ICDEX       ICR   5747
 ;    $$ROOT^ICDEX        ICR   5747
 ;    $$CPT^ICPTCOD       ICR   1995
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$DT^XLFDT          ICR  10103
 ;               
HIST(CODE,SYS,ARY) ; Get Activation History for a Code
 ;                      
 ; Input:
 ; 
 ;    CODE   ICD Code (required)
 ;    SYS    Coding System
 ;   .ARY    Array, passed by Reference (required)
 ;                      
 ; Output:
 ;    
 ;    $$HIST  Number of Histories Found
 ;              or
 ;            -1 ^ error message
 ;    
 ;    ARY(0) = Number of Activation History
 ;    ARY(0,0) = Code ^ Source Abbreviation ^ Source Nomenclature
 ;    ARY(<date>,<status>) = Comment
 ;
 N LEXA,LEXC,LEXE,LEXI,LEXN,LEXNOM,LEXP,LEXS,LEXSAB,LEXSI,LEXSO,LEXSRC,LEXTD,X
 S LEXSO=$G(CODE) K ARY Q:'$L(LEXSO) "-1^Code missing"
 Q:'$D(^LEX(757.02,"ACT",(LEXSO_" "))) "-1^Invalid code missing"
 S LEXSAB=$G(SYS),LEXSRC=+($$CSYS^LEXU(LEXSAB))
 S:LEXSRC'>0 LEXSRC=$$SYSC(LEXSO) Q:+LEXSRC'>0 "-1^Invalid source"
 S LEXNOM=$P($G(^LEX(757.03,+LEXSRC,0)),"^",2)
 S (LEXSI,LEXSAB)=$$CSYS^LEXU(+LEXSRC)
 S LEXSI=$P(LEXSI,"^",3,4)
 S LEXSAB=$P(LEXSAB,"^",2) Q:$L(LEXSAB)'=3 "-1^Invalid source"
 S LEXTD=$$DT^XLFDT F LEXI=0,1 D
 . N LEXE S LEXE=0
 . F  S LEXE=$O(^LEX(757.02,"ACT",(LEXSO_" "),LEXI,LEXE)) Q:+LEXE'>0  D
 . . N LEXS S LEXS=0
 . . F  S LEXS=$O(^LEX(757.02,"ACT",(LEXSO_" "),LEXI,LEXE,LEXS)) Q:+LEXS'>0  D
 . . . N LEXN,LEXC S LEXN=$G(^LEX(757.02,LEXS,0))
 . . . S LEXC=+($P(LEXN,"^",3)) Q:+LEXC'=LEXSRC
 . . . S:'$D(ARY(LEXE,LEXI)) ARY(0)=+($G(ARY(0)))+1
 . . . S ARY(LEXE,LEXI)=""
 S LEXA=0,LEXE=0 F  S LEXE=$O(ARY(LEXE)) Q:+LEXE'>0  D
 . S LEXS="" F  S LEXS=$O(ARY(LEXE,LEXS)) Q:'$L(LEXS)  D
 . . S:+LEXS>0 LEXA=1  K:+LEXA'>0 ARY(LEXE,LEXS)
 S LEXA=0,LEXE=0 F  S LEXE=$O(ARY(LEXE)) Q:+LEXE'>0  D
 . S LEXS="" F  S LEXS=$O(ARY(LEXE,LEXS)) Q:'$L(LEXS)  D
 . . S:+LEXS>0 LEXA=LEXA+1
 . . I +LEXS>0,LEXA=1 S ARY(LEXE,LEXS)="Activated" Q
 . . I +LEXS'>0 S ARY(LEXE,LEXS)="Inactivated" Q
 . . I +LEXS>0 D
 . . . S ARY(LEXE,LEXS)="Re-activated"
 . . . I $D(ARY(LEXE,0)) D  Q
 . . . . S ARY(LEXE,LEXS)="Revised" K ARY(LEXE,0)
 . . . S LEXP=$O(ARY(LEXE),-1) I +LEXP>0 D
 . . . . I $O(ARY(LEXE," "),-1)'>0 S ARY(LEXE,LEXS)="Re-Used" K ARY(LEXE,0)
 K ARY(0) S LEXN=0,LEXC="" F  S LEXC=$O(ARY(LEXC)) Q:'$L(LEXC)  D
 . S LEXI="" F  S LEXI=$O(ARY(LEXC,LEXI)) Q:'$L(LEXI)  D
 . . I LEXI?1N,LEXC?7N,LEXC>LEXTD,$L($G(ARY(LEXC,LEXI))) D
 . . . S ARY(LEXC,LEXI)=$G(ARY(LEXC,LEXI))_" (Pending)"
 . . S LEXN=LEXN+1
 S X=+($G(LEXN)) S:LEXN>0 ARY(0)=+($G(LEXN)) S:X'>0 X="-1^No History Found"
 S:LEXN>0&($L(LEXSI))&($L(LEXSO)) ARY(0,0)=LEXSO_"^"_LEXSI
 Q X
PERIOD(CODE,SYS,ARY) ; Get Activation/Inactivation Periods for a Code
 ;
 ; Input:
 ; 
 ;    CODE   ICD Code (required)
 ;    SYS    Coding System
 ;   .ARY    Array, passed by Reference (required)
 ;
 ; Output:
 ; 
 ;   $$PERIOD   Multiple piece "^" delimited string
 ;   
 ;              1  Number of Activation Periods found
 ;              2  Coding System (interal)
 ;              3  Source Abbreviation
 ;              4  Coding System Nomenclature
 ;              5  Coding System Name
 ;              
 ;                or
 ;              
 ;              -1^ Message (no period or error message)
 ;            
 ;   ARY(0)     Same as $$PERIOD (above)
 ;   
 ;   ARY(Activation Date) = 4 piece "^" delimited string
 ;   
 ;              1  Inactivation Date
 ;                 (conditional)
 ;            
 ;              2  Pointer to Expression file 757.01
 ;                 for the code in piece #2 above 
 ;                 (required)
 ;               
 ;              3  Variable Pointer IEN;Root of a 
 ;                 national file (see below)  Include
 ;                 when the code exist in an national
 ;                 file (conditional)
 ;                
 ;                   CPT/HCPCS Procedure code  IEN;ICPT(
 ;                   ICD Diagnosis code        IEN;ICD9(
 ;                   ICD Procedure code        IEN;ICD0(
 ;                  
 ;              4  Short Description from the SDO file
 ;                 (CPT or ICD)
 ;
 ;   ARY(Activation Date,0) = Lexicon Expression
 ;   
 ; Functions like PERIOD^ICDAPIU, except it can include
 ; any coding system in the Lexicon, not just ICD.
 ; 
 N LEXACT,LEXC,LEXD,LEXDT,LEXEF,LEXEXI,LEXEXP,LEXI,LEXIDT,LEXIEN
 N LEXINA,LEXND,LEXPDT,LEXPER,LEXSD,LEXSO,LEXSY,LEXSYS,LEXVP
 S LEXSO=$G(CODE) Q:'$L(LEXSO) "-1^Missing Code"
 Q:'$D(^LEX(757.02,"CODE",(LEXSO_" "))) "-1^Invalid Code"
 S (LEXSD,LEXSYS)=$$CSYS^LEXU(SYS),LEXSYS=+LEXSYS
 Q:+LEXSYS'>0 "-1^Missing/Invalid Coding System"
 Q:'$D(^LEX(757.03,+LEXSYS,0)) "-1^Invalid Coding System"
 Q:+($$CODSAB^LEXU2(LEXSO,LEXSYS))'>0 "-1^Invalid source for code"
 K ARY,LEXACT,LEXINA
 S LEXDT="" F  S LEXDT=$O(^LEX(757.02,"ACT",(LEXSO_" "),3,LEXDT)) Q:'$L(LEXDT)  D
 . N LEXIEN S LEXIEN=0 F  S LEXIEN=$O(^LEX(757.02,"ACT",(LEXSO_" "),3,LEXDT,LEXIEN)) Q:+LEXIEN'>0  D
 . . N LEXND,LEXSY,LEXEXI S LEXND=$G(^LEX(757.02,+LEXIEN,0)),LEXSY=$P(LEXND,"^",3),LEXEXI=+LEXND
 . . Q:LEXSY'=LEXSYS  S LEXACT(LEXDT)=LEXEXI
 S LEXDT="" F  S LEXDT=$O(^LEX(757.02,"ACT",(LEXSO_" "),2,LEXDT)) Q:'$L(LEXDT)  D
 . N LEXIEN S LEXIEN=0 F  S LEXIEN=$O(^LEX(757.02,"ACT",(LEXSO_" "),2,LEXDT,LEXIEN)) Q:+LEXIEN'>0  D
 . . N LEXND,LEXSY,LEXEXI S LEXND=$G(^LEX(757.02,+LEXIEN,0)),LEXSY=$P(LEXND,"^",3),LEXEXI=+LEXND
 . . Q:LEXSY'=LEXSYS  S LEXINA(LEXDT)=LEXEXI
 S LEXDT="" F  S LEXDT=$O(LEXACT(LEXDT)) Q:'$L(LEXDT)  D
 . I $D(LEXINA(LEXDT)) D
 . . N LEXEXI,LEXPDT
 . . S LEXEXI=$G(LEXACT(LEXDT)),LEXPDT=$O(LEXACT(LEXDT),-1)
 . . S:LEXPDT?7N&(LEXEXI>0) LEXACT(LEXPDT)=LEXEXI
 . . K LEXACT(LEXDT),LEXINA(LEXDT)
 S LEXDT="" F  S LEXDT=$O(LEXACT(LEXDT)) Q:'$L(LEXDT)  D
 . N LEXIDT,LEXEXI,LEXEXP,LEXEF,LEXVP
 . ; Inactive Date
 . S LEXIDT=$O(LEXINA(LEXDT))
 . ; Lexicon Expression
 . S LEXEXI=$G(LEXACT(LEXDT))
 . S:LEXIDT?7N LEXEXI=$G(LEXINA(LEXIDT))
 . S LEXEXP="" S:+LEXEXI>0 LEXEXP=$G(^LEX(757.01,+LEXEXI,0))
 . ; Kill
 . K:LEXIDT?7N LEXINA(LEXIDT)
 . ; Effective Date
 . S LEXEF=$$DT^XLFDT S:LEXIDT?7N LEXEF=LEXIDT
 . ; Variable Pointer
 . S LEXVP=$$VP(LEXSO,LEXSYS,LEXEF)
 . ; Set array
 . S:LEXIDT'?7N LEXIDT=""
 . S LEXPER(LEXDT)=LEXIDT_"^"_LEXEXI_"^"_LEXVP
 . S:$L(LEXEXP) LEXPER(LEXDT,0)=LEXEXP
 K ARY M ARY=LEXPER
 S (LEXEF,LEXC)=0 F  S LEXEF=$O(ARY(LEXEF)) Q:LEXEF'?7N  S LEXC=LEXC+1
 S:+LEXC>0 ARY(0)=LEXC S:+LEXC'>0 ARY(0)="-1^No activation periods found for code"
 S:LEXSYS>0&($L($P($G(LEXSD),"^",3,5)))&(LEXC>0) ARY(0)=LEXC_U_LEXSYS_U_$P($G(LEXSD),"^",3,5)
 Q $G(ARY(0))
VP(CODE,SYS,EFF) ; Variable Pointer ^ Description
 N LEXDES,LEXEF,LEXI,LEXR,LEXSO,LEXSYS,LEXVP
 S LEXSO=$G(CODE),LEXSYS=+($G(SYS))
 Q:'$L(LEXSO) ""  Q:"^1^2^3^4^30^31^"'[("^"_LEXSYS_"^") ""
 S (LEXVP,LEXDES)="" S LEXEF=$G(EFF) S:LEXEF'?7N LEXEF=$$DT^XLFDT
 I LEXSYS=1!(LEXSYS=30) D
 . N LEXI,LEXR S LEXI=+($$CODEABA^ICDEX(LEXSO,80,LEXSYS)) Q:+LEXI'>0
 . S LEXR=$TR($$ROOT^ICDEX(80),"^","") Q:'$L(LEXR)
 . S LEXVP=LEXI_";"_LEXR
 . S LEXDES=$P($$ICDDX^ICDEX(LEXSO,(LEXEF+.001),LEXSYS,"E"),U,4)
 I LEXSYS=2!(LEXSYS=31) D
 . N LEXI,LEXR S LEXI=+($$CODEABA^ICDEX(LEXSO,80.1,LEXSYS)) Q:+LEXI'>0
 . S LEXR=$TR($$ROOT^ICDEX(80.1),"^","") Q:'$L(LEXR)  S LEXVP=LEXI_";"_LEXR
 . S LEXDES=$P($$ICDOP^ICDEX(LEXSO,(LEXEF+.001),LEXSYS,"E"),U,5)
 I LEXSYS=3!(LEXSYS=4) D
 . N LEXI,LEXR S LEXI=$O(^ICPT("BA",(LEXSO_" "),0)) Q:+LEXI'>0
 . S LEXR="ICPT(",LEXVP=LEXI_";"_LEXR
 . S LEXDES=$P($$CPT^ICPTCOD(LEXSO,(LEXEF+.001)),U,3)
 Q:$L(LEXVP)&($L(LEXDES)) (LEXVP_"^"_LEXDES)
 Q ""
REUSE(X,SYS) ; Is a code "re-used"
 ;
 ; Input
 ; 
 ;    X         Code
 ;    SYS       Coding System
 ;   
 ; Output
 ; 
 ;   $$REUSE    2 Piece "^" delimited string
 ;                 1  Boolean flag
 ;                     1 if the code was reused
 ;                     0 if the code has not been reused
 ;                 2  If reused, the date it was reused
 ;    
 N LEXA,LEXAC,LEXEF,LEXH,LEXHARY,LEXI,LEXRU,LEXSO,LEXSRC,LEXSYS,LEXTD,LEXREU,LEXRD
 S (LEXA,LEXI)=0,LEXTD=$G(DT) S:LEXTD'?7N LEXTD=$$DT^XLFDT S LEXSO=$G(X),LEXSYS=$G(SYS)
 S LEXSRC=+($$CSYS^LEXU(LEXSYS)),LEXH=$$ACT($G(LEXSO),$G(LEXSYS),.LEXHARY) K LEXHARY(0,0),LEXHARY(0)
 S LEXREU=0,(LEXRD,LEXD)=" " F  S LEXD=$O(LEXHARY(LEXD),-1) Q:'$L(LEXD)  D  Q:LEXREU>0
 . N LEXS,LEXE,LEXPD,LEXPS,LEXPE,LEXDIF
 . S LEXS=$O(LEXHARY(+LEXD," "),-1),LEXE=$G(LEXHARY(+LEXD,+LEXS))
 . S LEXPD=$O(LEXHARY(LEXD),-1),LEXPS=$O(LEXHARY(+LEXPD," "),-1)
 . S LEXPE=$G(LEXHARY(+LEXPD,+LEXPS))
 . Q:LEXS'?1N  Q:LEXD'?7N  Q:LEXPS'?1N  Q:LEXPD'?7N
 . S LEXDIF=$$FMDIFF^XLFDT(LEXD,LEXPD,1) Q:LEXDIF'>10
 . I LEXS=1,LEXPS=0,LEXD'=LEXPD,LEXE'=LEXPE S LEXREU=1,LEXRD=LEXD
 S X=LEXREU S:+X>0&(LEXRD?7N) $P(X,"^",2)=LEXRD
 Q X
REVISE(X,SYS) ; Is a code "revised"
 ;
 ; Input
 ; 
 ;    X         Code
 ;    SYS       Coding System
 ;   
 ;   $$REVISE   2 Piece "^" delimited string
 ;                 1  Boolean flag
 ;                     1 if the code was reused
 ;                     0 if the code has not been reused
 ;                 2  If reused, the date it was reused
 ;    
 N LEXA,LEXAC,LEXEF,LEXH,LEXHARY,LEXI,LEXRU,LEXSO,LEXSRC,LEXSYS,LEXTD,LEXREV,LEXRD
 S (LEXA,LEXI)=0,LEXTD=$G(DT) S:LEXTD'?7N LEXTD=$$DT^XLFDT S LEXSO=$G(X),LEXSYS=$G(SYS)
 S LEXSRC=+($$CSYS^LEXU(LEXSYS)),LEXH=$$ACT($G(LEXSO),$G(LEXSYS),.LEXHARY) K LEXHARY(0,0),LEXHARY(0)
 S LEXREV=0,(LEXRD,LEXD)=" " F  S LEXD=$O(LEXHARY(LEXD),-1) Q:'$L(LEXD)  D  Q:LEXREV>0
 . N LEXS,LEXE,LEXPD,LEXPS,LEXPE,LEXDIF
 . S LEXS=$O(LEXHARY(+LEXD," "),-1),LEXE=$G(LEXHARY(+LEXD,+LEXS))
 . S LEXPD=$O(LEXHARY(LEXD),-1),LEXPS=$O(LEXHARY(+LEXPD," "),-1)
 . S LEXPE=$G(LEXHARY(+LEXPD,+LEXPS))
 . Q:LEXS'?1N  Q:LEXD'?7N  Q:LEXPS'?1N  Q:LEXPD'?7N
 . I LEXPS=LEXS,LEXPD'=LEXD,LEXPE'=LEXE S LEXREV=1,LEXRD=LEXD
 S X=LEXREV S:+X>0&(LEXRD?7N) $P(X,"^",2)=LEXRD
 Q X
LAST(X,SYS,CDT) ; Last Activation ^ Inactivation
 ;
 ; Input
 ; 
 ;    X         Code
 ;    SYS       Coding System
 ;    CDT       Versioning Date
 ;   
 ;   $$LAST     2 Piece "^" delimited string
 ;                 1  Last Activation Date
 ;                 2  Last Inactivation Date
 ;              
 ;              or -1 on error/no dates found
 ;    
 N LEXARY,LEXDT,LEXLA,LEXLI,LEXO,LEXSO,LEXT,LEXTD S LEXTD=$$DT^XLFDT,LEXDT=$G(CDT) S:LEXDT'?7N LEXDT=LEXTD
 S LEXSO=$G(X) S X=$$PERIOD^LEXU4($G(LEXSO),$G(SYS),.LEXARY) Q:+($G(LEXARY(0)))'>0 -1
 S (LEXLA,LEXLI)="",LEXO=0 F  S LEXO=$O(LEXARY(LEXO)) Q:+LEXO'>0  D
 . N LEXT S LEXT=$P($G(LEXARY(LEXO)),"^",1)
 . I LEXO?7N,LEXO'>LEXDT S LEXLA=LEXO
 . I LEXT?7N,LEXT'>LEXDT S:+LEXT>+LEXLI LEXLI=LEXT
 Q:+LEXLA'>0 -1  S X=LEXLA S:LEXLI>0 X=X_"^"_LEXLI
 Q X
ACT(CODE,SYS,ARY) ; Get Activations
 N LEXA,LEXC,LEXE,LEXI,LEXN,LEXNOM,LEXP,LEXS,LEXSAB,LEXSI,LEXSO,LEXSRC,LEXTD,X S X=0
 S LEXSO=$G(CODE) K ARY Q:'$L(LEXSO) "-1^Code missing"
 Q:'$D(^LEX(757.02,"ACT",(LEXSO_" "))) "-1^Invalid code missing"
 S LEXSAB=$G(SYS),LEXSRC=+($$CSYS^LEXU(LEXSAB))
 S:LEXSRC'>0 LEXSRC=$$SYSC(LEXSO) Q:+LEXSRC'>0 "-1^Invalid source"
 S LEXNOM=$P($G(^LEX(757.03,+LEXSRC,0)),"^",2)
 S (LEXSI,LEXSAB)=$$CSYS^LEXU(+LEXSRC)
 S LEXSI=$P(LEXSI,"^",3,4)
 S LEXSAB=$P(LEXSAB,"^",2) Q:$L(LEXSAB)'=3 "-1^Invalid source"
 S LEXTD=$$DT^XLFDT F LEXI=0,1 D
 . N LEXE,LEXSTA S LEXE=0,LEXSTA=LEXI
 . F  S LEXE=$O(^LEX(757.02,"ACT",(LEXSO_" "),LEXI,LEXE)) Q:+LEXE'>0  D
 . . N LEXS S LEXS=0
 . . F  S LEXS=$O(^LEX(757.02,"ACT",(LEXSO_" "),LEXI,LEXE,LEXS)) Q:+LEXS'>0  D
 . . . N LEXN,LEXC S LEXN=$G(^LEX(757.02,LEXS,0))
 . . . S LEXC=+($P(LEXN,"^",3)) Q:+LEXC'=LEXSRC
 . . . S:'$D(ARY(LEXE,LEXSTA)) ARY(0)=+($G(ARY(0)))+1
 . . . S ARY(LEXE,LEXSTA)=+LEXN
 S LEXA=0,LEXE=0 F  S LEXE=$O(ARY(LEXE)) Q:+LEXE'>0  D
 . S LEXS="" F  S LEXS=$O(ARY(LEXE,LEXS)) Q:'$L(LEXS)  D
 . . K:+LEXS>0 ARY(LEXE,0)
 S LEXE=0 F  S LEXE=$O(ARY(LEXE)) Q:+LEXE'>0  D
 . N LEXS S LEXS="" F  S LEXS=$O(ARY(LEXE,LEXS)) Q:'$L(LEXS)  S X=X+1
 Q X
PFI(FRAG,CDT,ARY) ; Get Procedure Fragment Info
 ;
 ; Input
 ; 
 ;   FRAG    ICD-10-PCS Code Fragment
 ;    CDT    Versioning date (busines rules apply)
 ;   .ARY    Local Array passed by reference
 ;   
 ; Output
 ; 
 ;   $$PFI   1 if successful
 ;          -1 ^ Error Message if unsuccessful
 ;   ARY
 ;    
 ;          ARY(0)   5 piece "^" delimited strig
 ;                   1  Unique Id
 ;                   2  Code Fragment
 ;                   3  Date Entered
 ;                   4  Source
 ;                   5  Details
 ;                
 ;          ARY(1)   4 piece "^" delimited string
 ;                   1  Effective Date
 ;                   2  Status
 ;                   3  Effective Date External
 ;                   4  Status External
 ;                
 ;          ARY(2)    Name/Title
 ;          ARY(3)    Description
 ;          ARY(4)    Explanation
 ;          ARY(5,0)  # of synonyms included
 ;          ARY(5,n)  included synonyms
 ;    
 N LEXF,LEXI,LEXE,LEXC,LEXD,LEXN,X S LEXF=$G(FRAG) K ARY
 S LEXI=$$IMPDATE^LEXU(31) S LEXD=$G(CDT) S:'$L(LEXD) LEXD=$$DT^XLFDT
 S:LEXD?7N&(LEXI?7N)&(LEXD<LEXI) LEXD=LEXI
 Q:'$D(^LEX(757.033,"AFRAG",31,(LEXF_" "))) "-1^Invalid procedure code fragment"
 S LEXE=$O(^LEX(757.033,"AFRAG",31,(LEXF_" "),(LEXD+.001)),-1)
 Q:LEXE'?7N "-1^Fragment not active"
 S LEXN=$O(^LEX(757.033,"AFRAG",31,(LEXF_" "),+LEXE," "),-1)
 Q:+LEXN'>0 "-1^Fragment not found"
 K ARY S X=$$FIN^LEX10PR(LEXN,LEXD,.ARY)
 Q X
SYSC(X) ; System from Code (must be unique)
 ;
 ; Input:
 ;
 ;   X       Classification Code (required)
 ;
 ; Output: 
 ; 
 ;   $$SYSC  Pointer to CODING SYSTEMS file 757.03
 ;   
 ;   or 
 ;   
 ;   -1 ^ error message
 ;  
 N LEXS,LEXSIEN,LEXSO S LEXSO=$G(X) Q:'$L(LEXSO) "-1^Code missing"
 Q:'$D(^LEX(757.02,"CODE",(LEXSO_" "))) "-1^Invalid code missing"
 K LEXS S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"CODE",(LEXSO_" "),LEXSIEN)) Q:+LEXSIEN'>0  D
 . S LEXS(+($P($G(^LEX(757.02,+LEXSIEN,0)),"^",3)))=""
 I $O(LEXS(0))>0,$O(LEXS(0))=$O(LEXS(" "),-1) S X=$O(LEXS(0)) Q X
 Q "-1^Unable to resolve coding system"
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
