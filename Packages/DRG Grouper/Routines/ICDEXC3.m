ICDEXC3 ;SLC/KER - ICD Extractor - Code APIs (cont) ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICD0("ADS")        N/A
 ;    ^ICD0("AST")        N/A
 ;    ^ICD9("ADS")        N/A
 ;    ^ICD9("AST")        N/A
 ;    ^UTILITY($J)        ICR  10011
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;    ^DIWP               ICR  10011
 ;               
 Q
VST(FILE,IEN,CDT)     ; Versioned Short Text
 ;
 ; Input:
 ;
 ;   FILE  Global Root/File #/Coding System/SAB
 ;   IEN   IEN  (required)
 ;   CDT   Date to use to Extract Text (default TODAY)
 ;
 ; Output:
 ; 
 ;   VST   Short Text from either file 80 or 80.1
 ;            
 N ICDF,ICDR S ICDR=$$ROOT^ICDEX($G(FILE)) Q:'$L(ICDR) ""
 S ICDF=$$FILE^ICDEX(ICDR) Q:+ICDF'>0 ""
 Q:ICDF=80 $$VSTD($G(IEN),$G(CDT))
 Q:ICDF=80.1 $$VSTP($G(IEN),$G(CDT))
 Q ""
VLT(FILE,IEN,CDT) ; Versioned Long Text
 ;
 ; Input:
 ;
 ;   FILE  Global Root/File #/Coding System/SAB
 ;   IEN   IEN  (required)
 ;   CDT   Date to use to Extract Text (default TODAY)
 ;
 ; Output:
 ; 
 ;   VLT   Long Text (description) from either file 80 or 80.1
 ;            
 N ICDF,ICDR S ICDR=$$ROOT^ICDEX($G(FILE)) Q:'$L(ICDR) ""
 S ICDF=$$FILE^ICDEX(ICDR) Q:+ICDF'>0 ""
 Q:ICDF=80 $$VLTD($G(IEN),$G(CDT))
 Q:ICDF=80.1 $$VLTP($G(IEN),$G(CDT))
 Q ""
VSTD(IEN,CDT)  ; Versioned Short Text (Dx)
 ;
 ; Input:
 ;
 ;   IEN   IEN  (required)
 ;   CDT   Date to use to Extract Text (default TODAY)
 ;
 ; Output:
 ; 
 ;   VST   Short Text from file 80
 ;            
 N ICD0,ICDC,ICDI,STD,STI,ICDT,TXT S ICDI=+($G(IEN)) Q:+ICDI'>0 ""  Q:'$D(^ICD9(+ICDI)) ""
 S ICDT=$G(CDT) S:'$L(ICDT)!(+ICDT'>0) ICDT=$$DT^XLFDT Q:$P(ICDT,".",1)'?7N ""  S ICD0=$G(^ICD9(+ICDI,0)),ICDC=$P(ICD0,U,1) Q:'$L(ICDC) ""
 S STD=$O(^ICD9("AST",(ICDC_" "),(ICDT+.000001)),-1)
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD9("AST",(ICDC_" "),STD,+ICDI," "),-1),TXT=$$TRIM($P($G(^ICD9(+ICDI,67,+STI,0)),U,2))
 S STD=$O(^ICD9(+ICDI,67,"B",0)) I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD9(+ICDI,67,"B",STD,0)),TXT=$$TRIM($P($G(^ICD9(+ICDI,67,+STI,0)),U,2))
 Q $$TRIM($P(ICD0,U,3))
VSTP(IEN,CDT) ; Return versioned Short Text (Proc)
 ;
 ; Input:
 ;
 ;   IEN   IEN  (required)
 ;   CDT   Date to use to Extract Text (default TODAY)
 ;
 ; Output:
 ; 
 ;   VST   Short Text from file 80.1
 ;            
 N ICD0,ICDC,ICDI,STD,STI,ICDT,TXT S ICDI=+($G(IEN)) Q:+ICDI'>0 ""  Q:'$D(^ICD0(+ICDI)) ""
 S ICDT=$G(CDT) S:'$L(ICDT)!(+ICDT'>0) ICDT=$$DT^XLFDT Q:$P(ICDT,".",1)'?7N ""  S ICD0=$G(^ICD0(+ICDI,0)),ICDC=$P(ICD0,U,1) Q:'$L(ICDC) ""
 S STD=$O(^ICD0("AST",(ICDC_" "),(ICDT+.000001)),-1)
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD0("AST",(ICDC_" "),STD,+ICDI," "),-1),TXT=$$TRIM($P($G(^ICD0(+ICDI,67,+STI,0)),U,2))
 S STD=$O(^ICD0(+ICDI,67,"B",0)) I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD0(+ICDI,67,"B",STD,0)),TXT=$$TRIM($P($G(^ICD0(+ICDI,67,+STI,0)),U,2))
 Q $$TRIM($P(ICD0,U,4))
VLTD(IEN,CDT) ; Versioned Description - Long Text (Dx)
 ;
 ; Input:
 ;
 ;   IEN   IEN  (required)
 ;   CDT   Date to use to Extract Text (default TODAY)
 ;
 ; Output:
 ; 
 ;   VLT   Long Text from file 80
 ;            
 N ICD0,ICDC,ICDI,STD,STI,ICDT,TXT
 S ICDI=+($G(IEN)) Q:+ICDI'>0 ""  Q:'$D(^ICD9(+ICDI)) ""
 S ICDT=$G(CDT) S:'$L(ICDT)!(+ICDT'>0) ICDT=$$DT^XLFDT Q:$P(ICDT,".",1)'?7N ""
 S ICD0=$G(^ICD9(+ICDI,0)),ICDC=$P(ICD0,U,1) Q:'$L(ICDC) ""
 S STD=$O(^ICD9("ADS",(ICDC_" "),(ICDT+.000001)),-1)
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD9("ADS",(ICDC_" "),STD,+ICDI," "),-1)
 .S TXT=$$TRIM($P($G(^ICD9(+ICDI,68,+STI,1)),U,1))
 S STD=$O(^ICD9(+ICDI,68,"B",0))
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD9(+ICDI,68,"B",STD,0))
 .S TXT=$$TRIM($P($G(^ICD9(+ICDI,68,+STI,1)),U,1))
 S TXT=$$TRIM($G(^ICD9(+ICDI,1))) Q:$L($G(TXT)) $G(TXT)
 Q $$TRIM($P(ICD0,U,3))
VLTP(IEN,CDT) ; Versioned Description - Long Text (Proc)
 ;
 ; Input:
 ;
 ;   IEN   IEN  (required)
 ;   CDT   Date to use to Extract Text (default TODAY)
 ;
 ; Output:
 ; 
 ;   VLT   Long Text from file 80.1
 ;            
 N ICD0,ICDC,ICDI,STD,STI,ICDT,TXT
 S ICDI=+($G(IEN)) Q:+ICDI'>0 ""  Q:'$D(^ICD0(+ICDI)) ""
 S ICDT=$G(CDT) S:'$L(ICDT)!(+ICDT'>0) ICDT=$$DT^XLFDT Q:$P(ICDT,".",1)'?7N ""
 S ICD0=$G(^ICD0(+ICDI,0)),ICDC=$P(ICD0,U,1) Q:'$L(ICDC) ""
 S STD=$O(^ICD0("ADS",(ICDC_" "),(ICDT+.000001)),-1)
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD0("ADS",(ICDC_" "),STD,+ICDI," "),-1)
 .S TXT=$$TRIM($P($G(^ICD0(+ICDI,68,+STI,1)),U,1))
 S STD=$O(^ICD0(+ICDI,68,"B",0))
 I +STD>0 D  Q:$L($G(TXT)) $G(TXT)
 .S STI=$O(^ICD0(+ICDI,68,"B",STD,0))
 .S TXT=$$TRIM($P($G(^ICD0(+ICDI,68,+STI,1)),U,1))
 S TXT=$$TRIM($G(^ICD0(+ICDI,1))) Q:$L($G(TXT)) $G(TXT)
 Q $$TRIM($P(ICD0,U,4))
SD(FILE,IEN,CDT,ARY,LEN) ; Short Description (formatted)
 ;            
 ; Input:
 ; 
 ;   IEN   Internal Entry Number (Required)
 ;   FILE  File Number (Required)
 ;   CDT   Date, Default TODAY (Optional)
 ;  .ARY   Array Passed by Reference (Optional)
 ;   LEN   Text Length (15-79, default 60) (Optional) 
 ;   
 ; Output:
 ; 
 ;   $$SD  Short Description OR -1 ^ Error Message
 ;   ARY   Description in segment lengths specified
 ;   
 K ARY N EFF,HIS,NOD,ROOT,TXT S IEN=+($G(IEN)),FILE=$$FILE^ICDEX($G(FILE)) Q:"^80^80.1^"'[("^"_FILE_"^") "-1^File not found"
 S CDT=$G(CDT) S:CDT'?7N CDT=$$DT^XLFDT S LEN=+($G(LEN)) S:+LEN'>0 LEN=100
 S:LEN>0&(LEN<15) LEN=15 S ROOT=$S(FILE=80:"^ICD9(",FILE=80.1:"^ICD0(",1:"")
 Q:'$L(ROOT) "-1^File not found"  S (EFF,HIS,TXT)=""
 S NOD="-1^No description found for date "_$$FMTE^XLFDT($G(CDT),"5DZ")
 S EFF=+($O(@(ROOT_+IEN_",67,""B"","_(CDT+.000001)_")"),-1))
 Q:EFF'?7N NOD  S HIS=+($O(@(ROOT_+IEN_",67,""B"","_EFF_","" "")"),-1))
 Q:+HIS'>0 NOD  S TXT=$P($G(@(ROOT_+IEN_",67,"_+HIS_",0)")),"^",2)
 Q:'$L(TXT) NOD  S ARY(1)=TXT D:+LEN>0&(LEN'=100) PAR(.ARY,LEN)
 S IEN=$O(ARY(" "),-1),ARY(0)=+IEN
 S:EFF?7N ARY(0)=$G(ARY(0))_"^"_EFF S IEN=TXT
 Q IEN
LD(FILE,IEN,CDT,ARY,LEN) ; Long Description (formatted)
 ;   
 ; Input:
 ; 
 ;   IEN   Internal Entry Number (Required)
 ;   FILE  File Number (Required)
 ;   CDT   Date, Default TODAY (Optional)
 ;  .ARY   Array Passed by Reference (Optional)
 ;   LEN   Text Length (15-79, default 245) (Optional) 
 ;   
 ; Output:
 ; 
 ;   $$LD  Long Description OR -1 ^ Error Message
 ;   ARY   Description in lengths specified
 ;   
 K ARY N EFF,HIS,NOD,ROOT,TXT S IEN=+($G(IEN)),FILE=$$FILE^ICDEX($G(FILE)) Q:"^80^80.1^"'[("^"_FILE_"^") "-1^File not found"
 S CDT=$G(CDT) S:CDT'?7N CDT=$$DT^XLFDT S LEN=+($G(LEN)) S:+LEN'>0 LEN=300
 S:LEN>0&(LEN<15) LEN=15 S ROOT=$S(FILE=80:"^ICD9(",FILE=80.1:"^ICD0(",1:"")
 Q:'$L(ROOT) "-1^File not found"  S (EFF,HIS,TXT)=""
 S NOD="-1^No long description found for date "_$$FMTE^XLFDT($G(CDT),"5DZ")
 S EFF=+($O(@(ROOT_+IEN_",68,""B"","_(CDT+.000001)_")"),-1)) Q:EFF'?7N NOD
 S HIS=+($O(@(ROOT_+IEN_",68,""B"","_EFF_","" "")"),-1)) Q:+HIS'>0 NOD
 S TXT=$G(@(ROOT_+IEN_",68,"_+HIS_",1)")) Q:'$L(TXT) NOD
 S ARY(1)=TXT D:+($G(LEN))>0&(LEN'=300) PAR(.ARY,LEN)
 S IEN=$O(ARY(" "),-1),ARY(0)=+IEN
 S:EFF?7N ARY(0)=$G(ARY(0))_"^"_EFF S IEN=TXT
 Q IEN
CC(IEN,CDT) ; Complication/Comorbidity (C/C)
 ;
 ; Input
 ; 
 ;   IEN    Internal Entry Number (Required)
 ;   CDT    Date, Default TODAY (Optional)
 ;   
 ; Output
 ; 
 ;   $$CC   A code for C/C or Error
 ;            0   Non-CC
 ;            1   CC
 ;            2   Major CC
 ;           -1 ^ error
 ;           
 N CEFF,CIEN S CDT=$S($G(CDT)?7N:$G(CDT),1:$$DT^XLFDT)
 S CEFF=$O(^ICD9(+$G(IEN),69,"B",(CDT+.000001)),-1)
 Q:CEFF'?7N ("-1^No CC for "_$$FMTE^XLFDT($G(CDT),"5DZ"))
 S CIEN=$O(^ICD9(+$G(IEN),69,"B",CEFF," "),-1)
 Q:+CIEN'>0 ("-1^No CC for "_$$FMTE^XLFDT($G(CDT),"5DZ"))
 S IEN=$P(^ICD9(+$G(IEN),69,CIEN,0),U,2)
 Q:'$L(IEN) ("-1^No CC for "_$$FMTE^XLFDT($G(CDT),"5DZ"))
 Q IEN
PAR(ARY,LEN) ; Parse Array
 ;
 ; Input:
 ;
 ;  .ARY   Array passed by reference (required)
 ;   LEN   Array String Length
 ;
 ; Output:
 ; 
 ;   ARY   Array parse with string lengths of LEN
 ;
 N %,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,Z,I,IEN,CTR,X
 K ^UTILITY($J,"W") Q:'$D(ARY)  S LEN=+($G(LEN)) S:+LEN'>0 LEN=79
 S DIWL=1,DIWF="C"_+LEN S IEN=0
 F  S IEN=$O(ARY(IEN)) Q:+IEN=0  S X=$G(ARY(IEN)) D ^DIWP
 K ARY S (CTR,IEN)=0 F  S IEN=$O(^UTILITY($J,"W",1,IEN)) Q:+IEN=0  D
 . S ARY(IEN)=$$TRIM($G(^UTILITY($J,"W",1,IEN,0))," "),CTR=CTR+1
 K ^UTILITY($J,"W")
 Q
IEN(CODE,ROOT,SYS) ; Return IEN based on Code, Root and Coding System
 ;
 ; This API is similar to $$CODEABA^ICDEX except it will
 ; also return IENs for codes excluded from lookup and 
 ; VA Local Codes.  Use with caution, and do not use in
 ; any application that requires codes and text to be 
 ; versioned (date sensitive).
 ; 
 ; Input:
 ;
 ;   CODE  ICD Code, either ICD-9 or ICD-10 (required)
 ;   ROOT  File Root (optional)
 ;            ^ICD9( or 80
 ;            ^ICD0( or 80.1
 ;   SYS   Coding System (optional)
 ;           1 = ICD-9 Diagnosis
 ;           2 = ICD-9 Procedure
 ;          30 = ICD-10 Diagnosis
 ;          31 = ICD-10 Procedure
 ;
 ; Output:
 ; 
 ;   IEN   IEN for CODE in ROOT for SYS or -1 if not found
 ;   
 N ICDC,ICDFR,ICDFS,ICDI,ICDIX,ICDR,ICDS,ICDTR,ICDTS,ICDU
 S ICDC=$TR($G(CODE)," ","") Q:'$L(ICDC) -1  Q:ICDC["""" -1
 S ICDS=+($G(SYS)),ICDU=$$UP^XLFSTR(ICDC)
 S ICDR=$$ROOT^ICDEX($G(ROOT))
 I "^ICD9(^ICD0(^"'[("^"_$E(ICDR,2,$L(ICDR))_"^") D
 . N ICDTR,ICDFR S ICDFR="" F ICDTR="^ICD9(","^ICD0(" D  Q:$L(ICDFR)
 . . N ICDIX S ICDIX=" " Q:'$L($O(@(ICDTR_""""_ICDIX_""")")))
 . . F  S ICDIX=$O(@(ICDTR_""""_ICDIX_""")")) Q:'$L(ICDIX)  D  Q:$L(ICDFR)
 . . . I $D(@(ICDTR_""""_ICDIX_""","""_(ICDU_" ")_""")")) S ICDFR=ICDTR
 . S:$L(ICDFR) ICDR=ICDFR
 Q:"^ICD9(^ICD0(^"'[("^"_$E(ICDR,2,$L(ICDR))_"^") -1
 I +($G(ICDS))'>0 D
 . N ICDTS,ICDFS S ICDFS="" S ICDTS=0
 . F  S ICDTS=$O(@(ICDR_"""ABA"","_+ICDTS_")")) Q:+ICDTS'>0  D  Q:ICDFS>0
 . . S:$D(@(ICDR_"""ABA"","_+ICDTS_","""_ICDC_" "")")) ICDFS=ICDTS
 . S:$L(ICDFS) ICDS=ICDFS
 S:+($G(ICDI))'>0&(+ICDS>0) ICDI=$O(@(ICDR_"""ABA"","_+ICDS_","""_ICDC_" "","" "")"),-1)
 S:+($G(ICDI))'>0&(+ICDS>0) ICDI=$O(@(ICDR_"""ABA"","_+ICDS_","""_ICDU_" "","" "")"),-1)
 S:+($G(ICDI))'>0 ICDI=$O(@(ICDR_"""BA"","""_ICDC_" "","" "")"),-1)
 S:+($G(ICDI))'>0 ICDI=$O(@(ICDR_"""AVA"","""_ICDC_" "","" "")"),-1)
 S:+($G(ICDI))'>0 ICDI=$O(@(ICDR_"""AEXC"","""_ICDC_" "","" "")"),-1)
 Q $S('ICDI:-1,1:ICDI)
TRIM(X,Y) ; Trim Character
 ;
 ; Input:
 ;
 ;   X     Input String
 ;   Y     Character to Trim (default " ")
 ;
 ; Output:
 ; 
 ;   X     String without Leading/Trailing character Y
 ;
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
