ICDEXS ;SLC/KER - ICD Extractor - Support ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICD0(              N/A
 ;    ^ICD9(              N/A
 ;    ^ICDS(              N/A
 ;               
 ; External References
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
EFF(FILE,IEN,EDT) ; returns effective date and status for code/modifier
 ;
 ; Input:
 ; 
 ;    FILE   File number 80/80.1 (required)
 ;    IEN    ICD IEN (required)
 ;    EDT    Date to check (FileMan format) (required)
 ;
 ; Output:  
 ; 
 ;   A 3 piece "^" delimited string
 ;   
 ;          1   Status
 ;                1 - Active
 ;                0 - Inactive  
 ;          2   Inactivation Date
 ;          3   Activation Date
 ;     -or-
 ;          -1^error message
 ;
 N EFF,EFFB,EFFDOS,EFFDT,EFFN,EFFST,EFILE,ICDY,ROOT,STR
 I $G(IEN)=""!(IEN'?1N.N) Q "-1^No Code Selected"
 S FILE=$$FILE($G(FILE)) Q:+FILE'>0 "-1^Invalid File"
 S ROOT=$$ROOT(FILE)
 Q:"^ICD9(^ICD0(^"'[("^"_$E(ROOT,2,$L(ROOT))_"^") "-1^Invalid Global"
 Q:'$G(EDT) "-1^No Date Selected" S EDT=$P(EDT,".",1)
 Q:EDT'?7N "-1^Invalid Date Selected"
 S IEN=+($G(IEN)) Q:+IEN'>0 "-1^IEN Invalid"  S EFILE=ROOT_IEN_",66,"
 S ICDY=$P($G(@(ROOT_+IEN_",1)")),"^",1) Q:+ICDY'>0 "-1^Invalid Coding System"
 S EDT=$S($G(EDT)="":$$DT^XLFDT,1:$$DTBR^ICDEX(EDT,,ICDY))+.001
 S EFF=$O(@(EFILE_"""B"","_EDT_")"),-1) Q:'EFF "0^^"
 S EFFN=$O(@(EFILE_"""B"","_EFF_",0)")),STR=$G(@(EFILE_EFFN_",0)")) Q:STR="" "0^^"
 S EFFDT=$P(STR,"^"),EFFST=$P(STR,"^",2),EFFB=0,EFF=+EFF
 F  S EFF=$O(@(EFILE_"""B"","_EFF_")"),-1) Q:'EFF!EFFB  D
 . S EFFN=$O(@(EFILE_"""B"","_EFF_",0)")) I 'EFFN S EFFB=1 Q
 . S EFFDOS=$G(@(EFILE_EFFN_",0)")) I 'EFFDOS S EFFB=1 Q
 . S EFFB=(EFFST'=$P(EFFDOS,"^",2))
 S EFFDOS=$P($G(EFFDOS),"^")
 I EFFST S $P(STR,"^",3,4)=(EFFDOS)_"^"_EFFDT
 E  S $P(STR,"^",3,4)=EFFDT_"^"_(EFFDOS)
 Q $P(STR,"^",2,4)
IA(FILE,IEN) ; Initial Activation Date
 ;
 ; Input:
 ; 
 ;   FILE   Global Root/File Number (Required)
 ;   IEN    Internal Entry Number (Required)
 ;   
 ; Output:
 ; 
 ;   $$IA   Initial Activation Date OR -1 ^ Error Message
 ;   
 N ROOT,EFF,HIS,NOD,ACT,INA
 S FILE=$$FILE($G(FILE)) Q:+FILE'>0 "-1^Invalid File"  S ROOT=$$ROOT(FILE)
 Q:"^ICD9(^ICD0(^"'[("^"_$E(ROOT,2,$L(ROOT))_"^") "-1^Invalid Global"
 S IEN=$G(IEN) Q:+IEN'>0!('$D(@(ROOT_+IEN_")"))) "-1^Invalid Code"
 S ACT="",EFF=""
 F  S EFF=$O(@(ROOT_+IEN_",66,""B"","""_EFF_""")")) Q:(EFF'?7N)!($L(ACT))  D  Q:$L(ACT)
 . S HIS=" " F  S HIS=$O(@(ROOT_+IEN_",66,""B"","_EFF_","""_HIS_""")"),-1) Q:+HIS'>0  D  Q:$L(ACT)
 . . N NOD,STA S NOD=$G(@(ROOT_+IEN_",66,"_+HIS_",0)"))
 . . S STA=$P(NOD,"^",2) S:STA?1N&(+STA>0)&('$L(ACT)) ACT=EFF
 S:'$L(ACT) ACT="-1^Initial activation date not found"
 Q ACT
LA(FILE,IEN,CDT) ; Last Current Activation Date
 ;
 ; Input:
 ; 
 ;   FILE   Global Root/File Number (Required)
 ;   IEN    Internal Entry Number (Required)
 ;   CDT    Date (default = TODAY) (Optional)
 ;   
 ; Output:
 ; 
 ;   $$LA   Last Activation Date OR -1 ^ Error Message
 ;   
 N ROOT,EFF,HIS,NOD,ACT,INA,ICDF
 S FILE=$$FILE($G(FILE)) Q:+FILE'>0 "-1^Invalid File"  S ROOT=$$ROOT(FILE)
 Q:"^ICD9(^ICD0(^"'[("^"_$E(ROOT,2,$L(ROOT))_"^") "-1^Invalid Global"
 S CDT=$G(CDT) S:CDT'?7N CDT=$$DT^XLFDT S IEN=$G(IEN)
 Q:+IEN'>0!('$D(@(ROOT_+IEN_")"))) "-1^Invalid Code"
 S ACT="",EFF=CDT+.000001
 F  S EFF=$O(@(ROOT_+IEN_",66,""B"","""_EFF_""")"),-1) Q:(EFF'?7N)!($L(ACT))  D  Q:$L(ACT)
 . S HIS=" " F  S HIS=$O(@(ROOT_+IEN_",66,""B"","_EFF_","""_HIS_""")"),-1) Q:+HIS'>0  D  Q:$L(ACT)
 . . N NOD,STA S NOD=$G(@(ROOT_+IEN_",66,"_+HIS_",0)"))
 . . S STA=$P(NOD,"^",2) S:STA?1N&(+STA>0)&('$L(ACT)) ACT=EFF
 S:'$L(ACT) ACT="-1^Not activated on or before "_$$FMTE^XLFDT($G(CDT),"5DZ")
 Q ACT
LI(FILE,IEN,CDT) ; Last Current Inactivation Date
 ; 
 ; Input:
 ; 
 ;   IEN    Internal Entry Number (Required)
 ;   FILE   Global Root/File Number (Required)
 ;   CDT    Date (default = TODAY) (Optional)
 ;   
 ; Output:
 ; 
 ;   $$LI   Last Inactivation Date OR -1 ^ Error Message
 ;   
 N ROOT,EFF,HIS,NOD,ACT,INA
 S FILE=$$FILE($G(FILE)) Q:+FILE'>0 "-12^Invalid File"  S ROOT=$$ROOT(FILE)
 Q:"^ICD9(^ICD0(^"'[("^"_$E(ROOT,2,$L(ROOT))_"^") "-1^Invalid Global"
 S CDT=$G(CDT) S:CDT'?7N CDT=$$DT^XLFDT S IEN=$G(IEN)
 Q:+IEN'>0!('$D(@(ROOT_+IEN_")"))) "-1^Invalid Code"
 S INA="",EFF=CDT+.000001
 F  S EFF=$O(@(ROOT_+IEN_",66,""B"","""_EFF_""")"),-1) Q:'$L(EFF)!(EFF'?7N)!($L(INA))  D  Q:$L(INA)
 . S HIS=" " F  S HIS=$O(@(ROOT_+IEN_",66,""B"","_EFF_","""_HIS_""")"),-1) Q:+HIS'>0  D  Q:$L(INA)
 . . N NOD,STA S NOD=$G(@(ROOT_+IEN_",66,"_+HIS_",0)"))
 . . S STA=$P(NOD,"^",2) S:STA?1N&(+STA'>0)&('$L(INA)) INA=EFF
 S:'$L(INA) INA="-1^Not inactivated on or before "_$$FMTE^XLFDT($G(CDT),"5DZ")
 Q INA
LS(FILE,IEN,CDT,FMT) ; Last Status
 ; 
 ; Input:
 ; 
 ;   FILE   Global Root/File Number (Required)
 ;   IEN    Internal Entry Number (Required)
 ;   CDT    Date (default = TODAY) (Optional)
 ;   FMT    Format 
 ;            0  Last Status only (default)
 ;            1  Last Status ^ Effective Date
 ;   
 ; Output:
 ; 
 ;   $$LS   Last Status (1/0) OR -1 ^ Error Message
 ;   
 N ROOT,EFF,HIS,NOD,ACT,INA,LEF,STA
 S FILE=$$FILE($G(FILE)) Q:+FILE'>0 "-12^Invalid File"  S ROOT=$$ROOT(FILE)
 Q:"^ICD9(^ICD0(^"'[("^"_$E(ROOT,2,$L(ROOT))_"^") "-1^Invalid Global"
 S CDT=$G(CDT) S:CDT'?7N CDT=$$DT^XLFDT S IEN=$G(IEN)
 Q:+IEN'>0!('$D(@(ROOT_+IEN_")"))) "-1^Invalid Code"
 S INA="",EFF=CDT+.000001 S EFF=$O(@(ROOT_+IEN_",66,""B"","""_EFF_""")"),-1)
 Q:'$L(EFF)!(EFF'?7N) "-1^No status on or before "_$$FMTE^XLFDT($G(CDT),"5DZ")
 S HIS="~",HIS=$O(@(ROOT_+IEN_",66,""B"","_EFF_","""_HIS_""")"),-1)
 Q:+HIS'>0 "-1^No status on or before "_$$FMTE^XLFDT($G(CDT),"5DZ")
 S NOD=$G(@(ROOT_+IEN_",66,"_+HIS_",0)")),STA=$P(NOD,"^",2),LEF=$P(NOD,"^",1)
 Q:"^0^1^"'[("^"_STA_"^") "-1^No status on or before "_$$FMTE^XLFDT($G(CDT),"5DZ")
 S:+($G(FMT))>0&($G(LEF)?7N) STA=STA_"^"_LEF
 Q STA
 ;
NUM(CODE) ; Convert Code to a Numeric Value (opposite of $$COD)
 ;
 ; Input:
 ; 
 ;    CODE   ICD CODE (required)
 ;
 ; Output:  
 ; 
 ;    NUM    Numerical representation of CODE
 ;    
 ;           or
 ;           
 ;           -1 on error
 ;  
 S CODE=$G(CODE) Q:'$L($G(CODE)) 0
 N PSN,OUT,CHR,ERR S ERR=0,OUT="" F PSN=1:1:9 D
 . S CHR=$E(CODE,PSN) S CHR=$S($L(CHR):$A(CHR),1:32),CHR=CHR-30
 . S:CHR'>0 ERR=1 F  Q:$L(CHR)>1  S CHR="0"_CHR
 . S:$L(CHR)'=2 ERR=1 S OUT=OUT_CHR
 Q:ERR -1  S:+OUT>0 OUT="1"_OUT
 Q OUT
COD(NUM) ; Convert Numeric Value to a Code (opposite of $$NUM)
 ;
 ; Input:
 ; 
 ;    NUM    Numerical representation of an ICD Code (required)
 ;
 ; Output:  
 ; 
 ;    CODE   ICD Code
 ;    
 ;           or
 ;           
 ;           null on error
 ;  
 Q:'$L(NUM) ""  Q:$E(NUM,1)'=1 ""  S NUM=$E(NUM,2,$L(NUM))
 N PSN,OUT,CHR,ADD S OUT=""
 F PSN=1:2 S CHR=$E(NUM,PSN,(PSN+1)) Q:'$L(CHR)  D
 . S CHR=+CHR+30 S ADD="" S:CHR'=32 ADD=$C(CHR) S:$L(ADD) OUT=OUT_ADD
 Q OUT
IE(X) ; Internal or External
 ;
 ; Input:
 ;
 ;   X     ICD code or IEN
 ;
 ; Output:
 ; 
 ;   $$IE  Set of Codes
 ;   
 ;           I  Internal format (IEN)
 ;           E  External format (Code)
 ;           
 ;           Null on error
 ;
 N IN,OUT
 S IN=$G(X) Q:'$L(X) ""
 Q:IN?1N.N&('$D(^ICD9("BA",(IN_" "))))&('$D(^ICD0("BA",(IN_" ")))) "I"
 Q:$D(^ICD9("BA",(IN_" ")))!($D(^ICD0("BA",(IN_" ")))) "E"
 Q ""
FILE(X) ; File Number
 ;
 ; Input:   
 ; 
 ;   X     File/Identifier/Coding System/Code (required)
 ;   
 ; Output:  
 ; 
 ;   FILE  File Number or -1 on error
 ;   
 N ICDX,ICDF S (ICDX,X)=$G(X) Q:'$L(X) -1  N ICDR
 I X?1N.N Q:X?1N&(+X=0) 80.1  Q:X?1N&(+X=9) 80
 S ICDR=$$ROOT(X) Q:$D(^ICD9("BA",(X_" "))) 80  Q:$D(^ICD0("BA",(X_" "))) 80.1
 Q:X=80 80  Q:X=80.1 80.1  Q:X["ICD9" 80  Q:X["ICD0" 80.1  Q:X["DX"!(X["DIAG") 80  Q:X["PR"!(X["PROC")!(X["OP")!(X["PCS") 80.1
 I ICDX?1N.N I ICDX'["." Q:$D(^ICD9("ABA",+ICDX)) 80 Q:$D(^ICD0("ABA",+ICDX)) 80.1
 Q:$D(^ICD9("BA",(X_" "))) 80  Q:$D(^ICD0("BA",(X_" "))) 80.1
 Q:$D(^ICD9("AVA",(X_" "))) 80  Q:$D(^ICD0("AVA",(X_" "))) 80.1
 Q:$D(^ICD9("AEXC",(X_" "))) 80  Q:$D(^ICD0("AEXC",(X_" "))) 80.1
 Q:ICDR["ICD9" 80  Q:ICDR["ICD0" 80.1
 Q -1
ROOT(X) ; Global Root
 ;
 ; Input:   
 ; 
 ;   X     File Number, File Name, Root, Identifier
 ;         or Coding System (required)
 ;   
 ; Output:  
 ; 
 ;   ROOT  Global Root for File or null
 ;   
 N ICDR,ICDF S ICDR=$$RY($G(X)) Q:$L(ICDR) ICDR
 S ICDR=$$RC($G(X)) Q:$L(ICDR) ICDR  S X=$$UP^XLFSTR($G(X))
 S ICDR=$$RF($G(X)) Q:$L(ICDR) ICDR
 S ICDR=$$RR($G(X)) Q:$L(ICDR) ICDR
 S:X?1N.N ICDR=$$RS(+($G(X))) Q:$L(ICDR) ICDR
 Q ""
RY(SYS) ; Global Root from System
 N FILE,ROOT S SYS=$G(SYS) Q:SYS'?1N.N ""  Q:SYS=80!(SYS=80.1) ""  Q:'$D(^ICDS(+SYS)) ""
 S FILE=$P($G(^ICDS(+SYS,0)),"^",3) Q:+FILE'>0 ""  S ROOT=$$RF(FILE) Q:$L(ROOT) ROOT
 Q ""
RF(FILE) ; Global Root from File
 Q:$G(FILE)=80 "^ICD9("  Q:$G(FILE)=80.1 "^ICD0("
 Q ""
RR(ID) ; Global Root from Root or Identifier
 Q:ID["ICD9" "^ICD9(" Q:ID["ICD0" "^ICD0("  Q:ID="DX"!(ID["DIA") "^ICD9("  Q:ID="PR"!(ID["PRO")!(ID["OP") "^ICD0("
 Q:ID="ICD"!(ID="10D") "^ICD9("  Q:ID="ICP"!(ID="10P") "^ICD0("
 Q ""
RS(SYS) ; Global Root from Coding System
 S SYS=$TR(SYS," ","")  Q:$D(^ICD9("ABA",+SYS)) "^ICD9(" Q:$D(^ICD0("ABA",+SYS)) "^ICD0("
 Q ""
RC(COD) ; Global Root from Code
 Q:$D(^ICD9("BA",($G(COD)_" "))) "^ICD9("  Q:$D(^ICD0("BA",($G(COD)_" "))) "^ICD0("
 Q:$D(^ICD9("AVA",(X_" "))) "^ICD9("  Q:$D(^ICD0("AVA",(X_" "))) "^ICD0("
 Q:$D(^ICD9("AEXC",(X_" "))) "^ICD9("  Q:$D(^ICD0("AEXC",(X_" "))) "^ICD0("
 Q ""
 ; 
SYS(SYS,CDT,FMT) ; Resolve System (uses file 80.4)
 ;
 ; Input:
 ;
 ;   SYS     System/Source Abbreviation/System Identifier/Code
 ;   CDT     Date (optional)
 ;   FMT     Output Format (optional)
 ;   
 ;            I  Internal (default)
 ;            E  External
 ;            B  Both Internal ^ External
 ;
 ; Output:
 ; 
 ;   $$SYS System (numeric or alpha)
 ;   
 ;            Internal  External
 ;               1      ICD-9-CM
 ;               2      ICD-9 Proc
 ;              30      ICD-10-CM
 ;              31      ICD-10-PCS
 ;         or
 ;            -1   on error
 ;            
 N ICDC,ICDD,ICDF,ICDI,ICDO,ICDT,ICDU,ICDX,ICDT S ICDI=$G(SYS) Q:'$L(ICDI) -1
 S ICDD=$P($G(CDT),".",1) S ICDF=$$UP^XLFSTR($G(FMT)) S:'$L(ICDF) ICDF="I"
 S:"^E^B^"'[("^"_ICDF_"^") ICDF="I" S ICDU=$$UP^XLFSTR(ICDI)
 S ICDO=$$SC(ICDI) Q:+ICDO>0 $S(ICDF["B":(+ICDO_"^"_$$SNAM(+ICDO)),ICDF["E":$$SNAM(+ICDO),1:+ICDO)
 I ICDI?1N.N Q:$D(^ICDS(+ICDI)) $S(ICDF["B":(+ICDI_"^"_$$SNAM(+ICDI)),ICDF["E":$$SNAM(+ICDI),1:+ICDI)
 S ICDO=$$SS(ICDI) Q:+ICDO>0 $S(ICDF["B":(+ICDO_"^"_$$SNAM(+ICDO)),ICDF["E":$$SNAM(+ICDO),1:+ICDO)
 S ICDO=$$SM(ICDI,ICDD) Q:+ICDO>0 $S(ICDF["B":(+ICDO_"^"_$$SNAM(+ICDO)),ICDF["E":$$SNAM(+ICDO),1:+ICDO)
 S ICDO=$$SP(ICDI) Q:+ICDO>0 $S(ICDF["B":(+ICDO_"^"_$$SNAM(+ICDO)),ICDF["E":$$SNAM(+ICDO),1:+ICDO)
 Q -1
SS(X) ; System from Coding System file 80.4
 N ICDC,ICDI,ICDO,ICDU S ICDI=$G(X) Q:'$L(ICDI) ""  S ICDU=$$UP^XLFSTR(ICDI)
 S ICDO="",ICDC="AZ" F  S ICDC=$O(^ICDS(ICDC)) Q:'$L(ICDC)  D  Q:+ICDO>0
 . Q:ICDC="F"  N ICDT S ICDT=$O(^ICDS(ICDC,ICDI,0))
 . S:+ICDT'>0 ICDT=$O(^ICDS(ICDC,ICDU,0)) S:+ICDT>0 ICDO=ICDT
 Q ICDO
SM(X,CDT) ; System from a Mnemonic
 N ICDD,ICDX,ICDO,ICDU S ICDU=$$UP^XLFSTR($G(X)) Q:'$L(ICDU) ""  S ICDD=$G(CDT) S:ICDD'?7N ICDD=$$DT^XLFDT
 S ICDX=$P($G(^ICDS(30,0)),"^",4),ICDO=""
 I (ICDU["DIAG"!(ICDU["ICD9")!(ICDU="80")!(ICDU="DX")) I ICDD?7N,ICDX?7N S ICDO=$S(ICDD<ICDX:1,1:30)
 I (ICDU["PROC"!(ICDU["OPER")!(ICDU["ICD0")!(ICDU["ICP9")!(ICDU="80.1")!(ICDU="PR")) I ICDD?7N,ICDX?7N S ICDO=$S(ICDD<ICDX:2,1:31)
 Q ICDO
SP(X) ; System from Pattern Match
 N ICDT,ICDI,ICDO S ICDO="",ICDT=$$UP^XLFSTR($G(X)) Q:'$L(ICDT) ""
 F  Q:ICDT'["ICD"  S ICDT=$P(ICDT,"ICD",1)_$P(ICDT,"ICD",2)
 Q:'$L(ICDT) ""  S ICDI="" F  S ICDI=$O(^ICDS("B",ICDI)) Q:'$L(ICDI)  D  Q:+ICDO>0
 . S:ICDT["9"&(ICDT["D")&(ICDT'["P")&(ICDI["9")&(ICDI["CM") ICDO=$O(^ICDS("B",ICDI,0)) Q:ICDO>0
 . S:ICDT["9"&((ICDT["P")!(ICDT["O"))&(ICDI["9")&(ICDI["P") ICDO=$O(^ICDS("B",ICDI,0)) Q:ICDO>0
 . S:ICDT["10"&(ICDT["D")&(ICDT'["P")&(ICDI["10")&(ICDI["CM") ICDO=$O(^ICDS("B",ICDI,0)) Q:ICDO>0
 . S:ICDT["10"&((ICDT["P")!(ICDT["O"))&(ICDI["10")&(ICDI["P") ICDO=$O(^ICDS("B",ICDI,0)) Q:ICDO>0
 Q ICDO
SC(X) ; System from Code
 N ICDI,ICDC,ICDO,ICDR,ICDU S ICDI=$G(X) S ICDC=$TR(ICDI," ","") Q:'$L(ICDC) ""
 S ICDU=$$UP^XLFSTR(ICDC) S ICDO="" F ICDR="^ICD9(","^ICD0(" D  Q:+ICDO>0
 . N TMP F TMP=ICDC,ICDU D  Q:+ICDO>0
 . . N ICDS,ICDV,ICDE S ICDS=0 F  S ICDS=$O(@(ICDR_"""ABA"","_ICDS_")")) Q:+ICDS'>0  D  Q:ICDO>0
 . . . S:$D(@(ICDR_"""ABA"","_ICDS_","""_TMP_" "")")) ICDO=ICDS
 . . Q:ICDO>0  S ICDV=$O(@(ICDR_"""AVA"","""_TMP_" "",0)"))
 . . S:+ICDV>0 ICDO=$P($G(@(ICDR_+ICDV_",1)")),"^",1) Q:ICDO>0
 . . S ICDE=$O(@(ICDR_"""AEXC"","""_TMP_" "",0)"))
 . . S:+ICDE>0 ICDO=$P($G(@(ICDR_+ICDE_",1)")),"^",1) Q:ICDO>0
 Q ICDO
SINFO(SYS,CDT) ; System Info (uses file 80.4)
 ;
 ; Input:
 ;
 ;   SYS      System/Source Abbreviation/System Identifier/Code
 ;   CDT      Date (optional)
 ;
 ; Output:
 ; 
 ;   $$SINFO System Info (numeric or alpha)
 ;   
 ;            Internal  External
 ;               1      IEN to file 80.4
 ;               2      Coding System
 ;               3      Abbreviation
 ;               4      File Number
 ;               5      Implementation Date
 ;               6      Content
 ;               
 ;         or
 ;            -1   on error
 ;            
 N ICDD,ICDS,ICDN,ICDT
 S ICDD=$S($G(CDT)'?7N:$$DT^XLFDT,1:$G(CDT))
 S ICDS=$$SYS($G(SYS),ICDD,"I")
 Q:+ICDS'>0 "-1^Coding System Unknown"
 S ICDN=$G(^ICDS(+ICDS,0)) Q:'$L(ICDN) "-1^Coding System not found"
 S ICDT=$S($P(ICDN,"^",3)=80:"Diagnosis",$P(ICDN,"^",3)=80.1:"Procedure",1:"")
 S SYS=ICDS_"^"_ICDN S:$L(ICDT) SYS=SYS_"^"_ICDT
 Q SYS
SNAM(SYS) ; System Name
 ;
 ; Input:
 ;
 ;   SYS    Numeric System Identifier (field 1.1)
 ;
 ; Output:
 ; 
 ;   $$SYS  Character System Name
 ;
 ;          or  -1   on error
 ;            
 S SYS=+($G(SYS)) S SYS=$P($G(^ICDS(+SYS,0)),"^",1)
 Q $S($L(SYS):SYS,1:-1)
SAB(X,Y) ; Source Abbreviation
 ;
 ; Input:
 ;
 ;   X     Source Abbreviation or Identifier
 ;   Y     Date used to determine SAB
 ;
 ; Output:
 ;
 ;   $$SAB 3 Character System Identifier
 ;
 N SYS,CDT,TY,VR,OUT,TMP,ICD10 S SYS=$G(X),CDT=$G(Y)
 S:CDT'?7N CDT=$$DT^XLFDT S ICD10=+($$IMP^ICDEX(30))
 S TMP=$$SYS(SYS,CDT) S:+TMP>0&($D(^ICDS(+TMP,0))) SYS=TMP
 Q:+SYS=1 "ICD"  Q:+SYS=2 "ICP"  Q:+SYS=30 "10D"  Q:+SYS=31 "10P"
 Q:SYS="DIAG" $S(CDT'<ICD10:"10D",1:"ICD")
 Q:SYS["ICD9" $S(CDT'<ICD10:"10D",1:"ICD")
 Q:SYS="PROC" $S(CDT'<ICD10:"10P",1:"ICP")
 Q:SYS["ICD0" $S(CDT'<ICD10:"10P",1:"ICP")
 Q:"^ICD^ICP^10D^10P^"[("^"_SYS_"^") SYS
 Q ""
EXC(FILE,IEN) ; Exclude From lookup
 ;
 ; Input:
 ;
 ;   FILE   File number 80 or 80.1
 ;   IEN    Internal Entry Number
 ;
 ; Output:
 ;
 ;   $$EXC  Boolean value 1 = Yes  0 = No
 ;
 N ICDF,ICDI,ICDR S ICDF=+($G(FILE)),ICDI=+($G(IEN)) Q:"^80^80.1^"'[("^"_ICDF_"^") 0
 S ICDR=$$ROOT(ICDF) Q:"^ICD9(^ICD0(^"'[("^"_$E(ICDR,2,$L(ICDR))_"^") 0  Q:'$D(@(ICDR_+ICDI_",0)")) 0
 Q $S(+($$GET1^DIQ(ICDF,(+ICDI_","),1.8))'>0:0,1:1)
