ICDEXC ;SLC/KER - ICD Extractor - Code APIs ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
ICDDX(CODE,CDT,SYS,FMT,LOC) ; Return ICD Dx Code Info
 ;
 ; Input:
 ;
 ;   CODE  Code/IEN (required)
 ;    CDT  Date (default = TODAY)
 ;    SYS  Coding System (taken from file 80.4)
 ;           1 = ICD-9 Diagnosis
 ;          30 = ICD-10 Diagnosis
 ;    FMT  Format
 ;           E = External (default)
 ;           I = Internal Entry Number
 ;    LOC  Use Local codes
 ;           1 = Yes
 ;           0 = No (default)
 ;
 ; Output:
 ;
 ;  Returns an 22 piece string delimited by ^
 ;  
 ;    1  IEN of code in ^ICD9(
 ;    2  ICD-9 Dx Code                (#.01)
 ;    3  Identifier                   (#1.2)
 ;    4  Versioned Dx                 (67 multiple)
 ;    5  Unacceptable as Principal Dx (#1.3)
 ;    6  Major Dx Cat                 (72 multiple)
 ;    7  MDC13                        (#1.4)
 ;    8  Compl/Comorb                 (103 multiple)
 ;    9  ICD Expanded                 (#1.7)
 ;    10 Status                       (66 multiple)
 ;    11 Sex                          (10 multiple)
 ;    12 Inactive Date                (66 multiple)
 ;    13 MDC24                        (#1.5)
 ;    14 MDC25                        (#1.6)
 ;    15 Age Low                      (11 multiple)
 ;    16 Age High                     (12 multiple)
 ;    17 Activation Date              (66 multiple)
 ;    18 Message                      
 ;    19 Complication/Comorbidity     (103 multiple)
 ;    20 Coding System                (#1.1)
 ;    21 Primary CC Flag              (103 multiple)
 ;    22 PDX Exclusion Code           (#1.11)
 ;
 ;    or
 ;
 ;    -1^Error Description
 ;
 N IEN,NODE,OUT,SAI,ROOT,SNAM,ICDY,UPC S FMT=$G(FMT) S:'$L(FMT) FMT="E"
 S ROOT=$$ROOT^ICDEX(80),CODE=$G(CODE) Q:'$L(CODE) "-1^No Code Selected"
 Q:FMT="I"&(CODE'?1N.N) "-1^Code not in correct format"
 I FMT="I",CODE?1N.N S IEN=CODE,CODE=$P($G(^ICD9(IEN,0)),"^",1)
 Q:'$L(CODE) "-1^No Code Selected"  S SYS=$$SYS^ICDEX(+($G(SYS)))
 S UPC=$$UP^XLFSTR(CODE) S:+SYS'>0 SYS=$$SYS^ICDEX($G(UPC))  I +SYS'>0 D
 . N FILE S FILE=$$CODEFI^ICDEX(UPC),SYS=$P($$CODECS^ICDEX(UPC,FILE),"^",1)
 Q:+SYS>0&('$D(@(ROOT_"""ABA"","_+SYS_")"))) "-1^Invalid Coding System"
 S SNAM=$$SNAM^ICDEX(+SYS),LOC=+($G(LOC))
 S IEN=$S(+SYS>0:$$CODEABA(CODE,ROOT,SYS),1:$$CODEBA(CODE,ROOT))
 S:+IEN'>0 IEN=$S(+SYS>0:$$CODEABA(UPC,ROOT,SYS),1:$$CODEBA(UPC,ROOT))
 S:+IEN'>0&($G(LOC)>0)&($D(^ICD9("AVA",(CODE_" ")))) IEN=$O(^ICD9("AVA",(CODE_" "),0))
 Q:'$G(LOC)&($D(^ICD9("AVA",(CODE_" ")))) ("-1^VA Local Code ("_CODE_")")
 Q:IEN<1&(+SYS>0)&($L(SNAM))&('$D(^ICD9("AVA",(CODE_" ")))) ("-1^Invalid Code (not found in the "_SNAM_" system)")
 Q:IEN<1 "-1^Invalid Code"  Q:'$D(^ICD9(IEN,0)) "-1^Invalid Code (not found)"
 S ICDY=$P($G(^ICD9(IEN,1)),"^",1) Q:+ICDY'>0 "-1^Invalid Coding System"
 S CDT=$P($G(CDT),".",1) S:'$L($G(CDT)) CDT=$$DT^XLFDT
 S CDT=$$DTBR^ICDEX($G(CDT),,ICDY) Q:CDT'?7N "-1^No Date Provided"
 S NODE=$P($G(^ICD9(IEN,0)),"^",1) Q:'$L(NODE) "-1^Code not found"
 Q:'$G(LOC)&($L(NODE))&($P(^ICD9(IEN,1),U,7)) ("-1^VA Local Code ("_NODE_")")
 S OUT=IEN_"^"_NODE,SAI=$$SAI^ICDEX(80,IEN,CDT)
 S NODE=$G(^ICD9(IEN,1)) Q:'$L(NODE) "-1^Data not found"
 S $P(OUT,"^",3)=$$IDSTR^ICDEX(80,IEN)
 S $P(OUT,"^",4)=$$VSTD^ICDEX(IEN,CDT)
 S $P(OUT,"^",5)=$P(NODE,"^",3)
 S $P(OUT,"^",6)=$$VMDC^ICDEX(IEN,CDT)
 S $P(OUT,"^",7)=$P(NODE,"^",4)
 S $P(OUT,"^",8)=$$VCC^ICDEX(IEN,CDT)
 S:$P(NODE,"^",7)>0 $P(OUT,"^",9)=$P(NODE,"^",7)
 S $P(OUT,"^",10)=$S(+$P($G(SAI),"^",1)>0:1,1:0)
 S $P(OUT,"^",11)=$$VSEX^ICDEX(80,IEN,CDT)
 S $P(OUT,"^",12)=$S($P($G(SAI),"^",3)?7N:$P($G(SAI),"^",3),1:"")
 S $P(OUT,"^",13)=$P(NODE,"^",5)
 S $P(OUT,"^",14)=$P(NODE,"^",6)
 S $P(OUT,"^",15)=$$VAGEL^ICDEX(IEN,CDT)
 S $P(OUT,"^",16)=$$VAGEH^ICDEX(IEN,CDT)
 S $P(OUT,"^",17)=$S($P($G(SAI),"^",2)?7N:$P($G(SAI),"^",2),1:"")
 S $P(OUT,"^",18)=$$MSG^ICDEX(CDT)
 S $P(OUT,"^",19)=$$VCC^ICDEX(IEN,CDT)
 S:+($G(^ICD9(+IEN,1)))>0 $P(OUT,"^",20)=+($G(^ICD9(+IEN,1)))
 S $P(OUT,"^",21)=$$VCCP^ICDEX(IEN,CDT)
 S $P(OUT,"^",22)=$$PDXE^ICDEX(IEN)
 Q OUT
 ;
ICDOP(CODE,CDT,SYS,FMT,LOC) ; Return ICD Operation/Procedure Code Info
 ;
 ; Input:
 ;
 ;   CODE  Code/IEN (required)
 ;    CDT  Date (default = TODAY)
 ;    SYS  Coding System (taken from file 757.03)
 ;           2 = ICD-9 Procedure
 ;          31 = ICD-10 Procedure
 ;    FMT  Format
 ;           E = External (default)
 ;           I = Internal Entry Number
 ;    LOC  Use Local codes
 ;           1 = Yes
 ;           0 = No (default)
 ;
 ; Output:
 ;
 ;  Returns an 14 piece string delimited by ^
 ;  
 ;    1  IEN of code in ^ICD0(
 ;    2  ICD procedure code           (#.01)
 ;    3  Identifier                   (#1.2)
 ;    4  MDC24                        (#1.5)
 ;    5  Versioned Oper/Proc          (67 multiple)
 ;    6  <null>
 ;    7  <null>
 ;    8  <null>
 ;    9  ICD Expanded                 (#1.7)
 ;    10 Status                       (66 multiple)
 ;    11 Use with Sex                 (10 multiple)
 ;    12 Inactive Date                (66 multiple)
 ;    13 Activation Date              (66 multiple)
 ;    14 Message
 ;    15 Coding System                (#1.1)
 ;
 ;    or
 ;
 ;    -1^Error Description
 ;
 N IEN,NODE,OUT,ROOT,SNAM,SAI,ICDY S FMT=$G(FMT) S:'$L(FMT) FMT="E"
 S ROOT=$$ROOT^ICDEX(80.1),CODE=$G(CODE) Q:'$L(CODE) "-1^No Code Selected"
 Q:FMT="I"&(CODE'?1N.N) "-1^Code not in correct format"
 I FMT="I",CODE?1N.N S IEN=CODE,CODE=$P($G(^ICD0(+IEN,0)),"^",1),FMT="E"
 Q:'$L(CODE) "-1^No Code Selected"
 S SYS=$$SYS^ICDEX(+($G(SYS))),LOC=+($G(LOC)) I +SYS'>0 D
 . N FILE S FILE=$$CODEFI^ICDEX(CODE),SYS=$P($$CODECS^ICDEX(CODE,FILE),"^",1)
 Q:+SYS>0&('$D(@(ROOT_"""ABA"","_+SYS_")"))) "-1^Invalid Coding System"
 S SNAM=$$SNAM^ICDEX(+SYS),IEN=$S(+SYS>0:$$CODEABA(CODE,ROOT,SYS),1:$$CODEBA(CODE,ROOT))
 S:+IEN'>0&(+($G(LOC))>0)&($D(^ICD0("AVA",(CODE_" ")))) IEN=$O(^ICD0("AVA",(CODE_" "),0))
 Q:'$G(LOC)&($D(^ICD0("AVA",(CODE_" ")))) ("-1^VA Local Code ("_CODE_")")
 Q:IEN<1&(+SYS>0)&($L(SNAM)) ("-1^Invalid Code (not found in the "_SNAM_" system)")
 Q:IEN<1 "-1^Invalid Code"  Q:'$D(^ICD0(IEN,0)) "-1^Invalid Code (not found)"
 S ICDY=$P($G(^ICD0(IEN,1)),"^",1) Q:+ICDY'>0 "-1^Invalid Coding System"
 S CDT=$P($G(CDT),".",1) S:'$L($G(CDT)) CDT=$$DT^XLFDT
 S CDT=$$DTBR^ICDEX($G(CDT),,ICDY) Q:CDT'?7N "-1^No Date Provided"
 S NODE=$P($G(^ICD0(+IEN,0)),"^",1) Q:'$L(NODE) "-1^Code not found"
 Q:'$G(LOC)&($P(^ICD0(IEN,1),U,7)) ("-1^VA Local Code Selected ("_NODE_")")
 S OUT=IEN_"^"_NODE,SAI=$$SAI^ICDEX(80.1,IEN,CDT)
 S NODE=$G(^ICD0(IEN,1)) Q:'$L(NODE) "-1^Data not found"
 S $P(OUT,"^",3)=$$IDSTR^ICDEX(80.1,IEN)
 S $P(OUT,"^",4)=$P(NODE,"^",5)
 S $P(OUT,"^",5)=$$VSTP^ICDEX(IEN,CDT)
 S:$P(NODE,"^",7)>0 $P(OUT,"^",9)=$P(NODE,"^",7)
 S $P(OUT,"^",10)=$S(+$P($G(SAI),"^",1)>0:1,1:0)
 S $P(OUT,"^",11)=$$VSEX^ICDEX(80.1,IEN,CDT)
 S $P(OUT,"^",12)=$S($P($G(SAI),"^",3)?7N:$P($G(SAI),"^",3),1:"")
 S $P(OUT,"^",13)=$S($P($G(SAI),"^",2)?7N:$P($G(SAI),"^",2),1:"")
 S $P(OUT,"^",14)=$$MSG^ICDEX(CDT)
 S:+($G(^ICD0(+IEN,1)))>0 $P(OUT,"^",15)=+($G(^ICD0(+IEN,1)))
 Q OUT
ICDD(CODE,ARY,CDT,SYS,LEN) ; Returns ICD description in array
 ;
 ; Input:
 ;
 ;   CODE  Code, external format (required)
 ;   ARY   Array Name passed by reference (required)
 ;   CDT   Date (optional, default = TODAY)
 ;   SYS   Coding System (optional)
 ;   LEN   Sting Length (optional, > 27, default 245)
 ;
 ; Output:
 ; 
 ;   #   Number of lines in array
 ;
 ;   ARY(1) - Versioned Description (68 multiple)
 ;   
 ;   If there is a warning message (ICD-9 only):
 ;   
 ;     ARY(n+1) - blank
 ;     ARY(n+2) - warning message: CODE TEXT MAY BE INACCURATE
 ;
 ;   or
 ;
 ;   -1^Error Description
 ;
 ;
 N ARR,END,I,N,ROOT,SNAM,VAR,IEN,ICDY
 Q:'$L($G(CODE)) "-1^Missing required input parameter CODE"
 S SYS=$$SYS^ICDEX(+($G(SYS))) I +SYS'>0 D
 . N FILE S FILE=$$CODEFI^ICDEX(CODE),SYS=$P($$CODECS^ICDEX(CODE,FILE),"^",1)
 S ROOT=$$ROOT^ICDEX(+SYS)
 Q:"^ICD9(^ICD0(^"'[("^"_$E(ROOT,2,$L(ROOT))_"^")!('$L(ROOT)) "-1^Invalid Coding System"
 Q:+SYS>0&('$D(@(ROOT_"""ABA"","_+SYS_")"))) "-1^Invalid Coding System"
 S SNAM=$$SNAM^ICDEX(+SYS),IEN=$S(+SYS>0:$$CODEABA(CODE,ROOT,SYS),1:$$CODEBA(CODE,ROOT))
 Q:+IEN<1!('$L(ROOT)) "-1^Invalid Code"  Q:'$D(@(ROOT_IEN_",0)")) "-1^Code not found"
 S LEN=+($G(LEN)) S:LEN'>0 LEN=245  S:LEN<28 LEN=245 K ARY
 S ICDY=$P($G(@(ROOT_+IEN_",1)")),"^",1)
 Q:+ICDY'>0 "-1^Invalid Coding System"
 S I=0,N=0
 S CDT=$P($G(CDT),".",1) S:'$L($G(CDT)) CDT=$$DT^XLFDT
 S CDT=$$DTBR^ICDEX($G(CDT),,ICDY) Q:CDT'?7N "-1^No Date Provided"
 S ARY(1)=$$VLT^ICDEX(ROOT,IEN,CDT)
 I LEN>27,LEN<245 D PAR^ICDEX(.ARY,LEN)
 S N=$O(ARY(" "),-1) I +ICDY<3 D
 . N MSG S MSG=$$MSG^ICDEX(CDT) Q:'$L(MSG)  S ARY(N+1)=" ",ARY(N+2)=MSG
 S N=+($O(ARY(" "),-1))
 Q N
CODEN(CODE,FILE) ; Return IEN of ICD code
 ;
 ; Input:
 ; 
 ;   CODE  ICD code (required)
 ;   FILE  File Number to search for code
 ;            80 = ICD Dx file
 ;            80.1 = ICD Oper/Proc file
 ;  
 ; Output:
 ; 
 ;   IEN~Global Root    or    -1~error message
 ;
 N ROOT,IEN,ERR,EIEN,ICDU S ERR=""
 Q:$G(CODE)="" "-1~Missing required input parameter CODE"
 S CODE=$TR(CODE," ",""),ICDU=$$UP^XLFSTR(CODE)
 S:"^80^80.1^"'[("^"_$G(FILE)_"^") FILE=$$CODEFI^ICDEX(CODE)
 S ROOT=$$ROOT^ICDEX($G(FILE)) Q:'$L(ROOT) "-1~Invalid File"
 S IEN=$$CODEBA(CODE,ROOT) S:+IEN'>0 ERR="-1~Invalid or Code not found"
 I $D(ICDVP),CODE?1N.N,+ERR<0,$L(ROOT) S:$D(@(ROOT_+CODE_",0)")) IEN=+CODE,ERR="" N ICDVP
 I +IEN>0,$D(@(ROOT_"""AEXC"","""_ICDU_" "","_+IEN_")")) D
 . S ERR="-1~IEN "_+IEN_" is excluded from lookup"
 Q:+ERR<0 ERR  Q (IEN_"~"_ROOT)
CODE(FILE,IEN) ; Replaces Direct Global Read of Code
 ;
 ; Input:
 ; 
 ;    IEN     Internal Entry Number (required)
 ;    FILE    File Number 80 or 80.1 (required)
 ;    
 ; Output:
 ; 
 ;    $$CODE  An ICD Diagnosis or Procedure code
 ;    
 ;           or -1 ^ message on error
 ;    
 ;  Retire IA 280, 365, 582, 5388, 5404
 ;  
 N ICDC,ICDF,ICDI,ICDR,ICDE S ICDI=$G(IEN) Q:+ICDI'>0 "-1^Invalid IEN"
 S ICDF=$G(FILE) Q:"^80^80.1^"'[("^"_ICDF_"^") "-1^Invalid File"
 S ICDR=$$ROOT^ICDEX(ICDF) Q:'$L(ICDR) "-1^Invalid File Root"
 Q:'$D(@(ICDR_+ICDI_")")) "-1^Invalid IEN for File"
 S ICDC=$P($G(@(ICDR_+ICDI_",0)")),"^",1)
 Q $S($L(ICDC):ICDC,1:"-1^Code Not Found")
CODEBA(CODE,ROOT) ; Return IEN based on Code and Root
 ;
 ; Input:
 ;
 ;   CODE  ICD Code, either ICD-9 or ICD-10 (required)
 ;   ROOT  File Root or Number (required)
 ;            ^ICD9( or 80
 ;            ^ICD0( or 80.1
 ;
 ; Output:
 ; 
 ;   IEN   IEN for CODE in ROOT or -1 if not found
 ;   
 Q:'$L($G(CODE)) -1  S:$TR($G(ROOT),".","")?1N.N ROOT=$$ROOT^ICDEX(ROOT) Q:'$L($G(ROOT)) -1
 N IEN,OUT,FILE,TMP,ICDU,VIEN,EIEN S IEN=0,OUT="",FILE=$$FILE^ICDEX(ROOT) Q:+FILE'>0 -1
 S ICDU=$$UP^XLFSTR(CODE) S EIEN=$O(@(ROOT_"""AEXC"","""_ICDU_" "",0)"))
 S VIEN=$O(@(ROOT_"""AVA"","""_ICDU_" "",0)"))
 I +IEN'>0,CODE?1N.N,$L(ROOT) D
 . I $D(ICDVP) S:$D(@(ROOT_+CODE_",0)")) (IEN,OUT)=+CODE N ICDVP
 I IEN'>0 S OUT="",IEN=0 F TMP=CODE,ICDU D
 . S IEN=0 F  S IEN=$O(@(ROOT_"""BA"","""_TMP_" "","_IEN_")")) Q:+IEN'>0  Q:+OUT>0  D
 . . N EXC S EXC=$$EXC^ICDEX(FILE,IEN) S:+EXC'>0 OUT=IEN
 S IEN=+($G(OUT))
 I +IEN>0,$D(@(ROOT_"""AEXC"","""_ICDU_" "","_+IEN_")")) Q ("-1^IEN "_+EIEN_" is excluded from lookup")
 I +IEN'>0,+EIEN>0 Q ("-1^Code "_ICDU_", IEN "_+EIEN_" is excluded from lookup")
 I +IEN'>0,+VIEN>0 Q ("-1^Code "_ICDU_", IEN "_+VIEN_" is a VA local code, not used")
 Q $S('IEN:-1,1:IEN)
CODEABA(CODE,ROOT,SYS) ; Return IEN based on Code, Root and Coding System
 ;
 ; Input:
 ;
 ;   CODE  ICD Code, either ICD-9 or ICD-10 (required)
 ;   ROOT  File Root or Number (Optional if SYS is supplied)
 ;            ^ICD9( or 80
 ;            ^ICD0( or 80.1
 ;   SYS   Coding System (required)
 ;           1 = ICD-9 Diagnosis
 ;           2 = ICD-9 Procedure
 ;          30 = ICD-10 Diagnosis
 ;          31 = ICD-10 Procedure
 ;
 ; Output:
 ; 
 ;   IEN   IEN for CODE in ROOT for SYS 
 ;         or 
 ;         -1 ^ error message if not found
 ;   
 N IEN,ICDF,ICDR,ICDI,ICDS,ICDU,ICDE,ICDV S CODE=$TR($G(CODE)," ","")
 Q:'$L(CODE) "-1^Code missing"  Q:CODE["""" "-1^Invalid code"
 S (ICDS,SYS)=+($G(SYS)),ICDU=$$UP^XLFSTR(CODE)
 I ICDS'>0 D
 . N ICDF S ICDF=$$CODEFI^ICDEX(CODE),(ICDS,SYS)=$P($$CODECS^ICDEX(CODE,ICDF),"^",1)
 Q:+ICDS'>0 "-1^Invalid coding system"
 S ICDR="" S ICDR=$$ROOT^ICDEX($G(ROOT))
 S:'$L(ICDR) ICDR=$$ROOT^ICDEX(+($G(SYS)))
 S:'$L(ICDR) ICDR=$$ROOT^ICDEX(+($G(ICDS)))
 Q:'$L(ICDR) "-1^Invalid file/root"
 S ICDE=$O(@(ICDR_"""AEXC"","""_ICDU_" "",0)"))
 S ICDV=$O(@(ICDR_"""AVA"","""_ICDU_" "",0)"))
 S:+($G(IEN))'>0 IEN=$O(@(ICDR_"""ABA"","_+ICDS_","""_CODE_" "","" "")"),-1)
 S:+($G(IEN))'>0 IEN=$O(@(ICDR_"""ABA"","_+ICDS_","""_ICDU_" "","" "")"),-1)
 I IEN'>0,+ICDE>0 Q ("-1^IEN "_+ICDE_" is excluded from lookup")
 I IEN'>0,+ICDV>0 Q ("-1^CODE "_ICDU_", IEN "_+ICDE_" is a VA local code, not used")
 Q $S('IEN:"-1^IEN/Code not found",1:IEN)
