ICDEXC2 ;SLC/KER - ICD Extractor - Code APIs (cont) ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICD0("BA")         N/A
 ;    ^ICD0("ABA")        N/A
 ;    ^ICD9("BA")         N/A
 ;    ^ICD9("ABA")        N/A
 ;    ^ICDS(              N/A
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$GET1^DIQ          ICR   2056
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 Q
CODEFI(CODE) ; Return file where code is found (exact match)
 ;
 ; Input:
 ;
 ;   CODE  ICD code (required)
 ;
 ; Output:
 ; 
 ;   FILE  File Number
 ;           80   = ICD Dx file
 ;           80.1 = ICD Oper/Proc file
 ;           Null
 ;            
 N ICDU,ICDO,ICDT S CODE=$G(CODE) Q:'$L(CODE) ""  S ICDU=$$UP^XLFSTR(CODE)
 S ICDO=0 F ICDT=CODE,ICDU D  Q:+ICDO>0
 . S:$O(^ICD9("BA",(ICDT_" "),0))>0&($O(^ICD0("BA",(ICDT_" "),0))'>0) ICDO=80
 . S:$O(^ICD0("BA",(ICDT_" "),0))>0&($O(^ICD9("BA",(ICDT_" "),0))'>0) ICDO=80.1
 . S:$O(^ICD9("BA",(ICDT_" "),0))>0 ICDO=80
 . S:$O(^ICD0("BA",(ICDT_" "),0))>0 ICDO=80.1
 Q $S(ICDO>0:ICDO,1:"")
CODECS(CODE,FILE,CDT) ; Return coding system where code is found (exact match)
 ;
 ; Input:
 ;
 ;   CODE  ICD code/IEN (required)
 ;   FILE  File Number (required)
 ;            80   = ICD Dx file
 ;            80.1 = ICD Oper/Proc file
 ;   CDT   Date used to determine Coding
 ;         System (optional, default TODAY)
 ;
 ; Output:
 ; 
 ;   SYS   2 piece ^ delimited string
 ;            1   Coding System
 ;            2   Coding Nomenclature
 ;            
 ;                 1  ^  ICD-9-CM
 ;                 2  ^  ICD-9 Proc
 ;                30  ^  ICD-10-CM
 ;                31  ^  ICD-10-PCS
 ;         
 ;         or null if not found
 ;   
 N ICDFI,ICDCS,ICDT,ICDID,ICD10,ICDU,ICDC S CODE=$TR($G(CODE)," ",""),ICDCS="",ICD10=+($$IMP^ICDEX(30)) Q:'$L(CODE) ""
 S ICDU=$$UP^XLFSTR(CODE),ICDFI=+($G(FILE)) S:"^80^80.1^"'[("^"_$G(ICDFI)_"^") ICDFI=+($$CODEFI(CODE))
 S ICDT=$G(CDT) S:ICDT'?7N ICDT=$$DT^XLFDT F ICDID=(CODE_" "),(ICDU_" ") D  Q:$L(ICDCS)
 . I ICDFI=80 D  Q:$L(ICDCS)
 . . I $O(^ICD9("ABA",1,ICDID,0))>0,$O(^ICD9("ABA",30,ICDID,0))'>0 S ICDCS="1^ICD-9-CM" Q
 . . I $O(^ICD9("ABA",30,ICDID,0))>0,$O(^ICD9("ABA",1,ICDID,0))'>0 S ICDCS="30^ICD-10-CM" Q
 . . I $O(^ICD9("ABA",30,ICDID,0))>0,$O(^ICD9("ABA",1,ICDID,0))>0,ICDT<ICD10 S ICDCS="1^ICD-9-CM" Q
 . . I $O(^ICD9("ABA",30,ICDID,0))>0,$O(^ICD9("ABA",1,ICDID,0))>0,ICDT'<ICD10 S ICDCS="30^ICD-10-CM" Q
 . . Q  S:ICDT<ICD10 ICDCS="1^ICD-9-CM" S:ICDT'<ICD10 ICDCS="30^ICD-10-CM"
 . I ICDFI=80.1 D  Q:$L(ICDCS)
 . . I $O(^ICD0("ABA",2,ICDID,0))>0,$O(^ICD0("ABA",31,ICDID,0))'>0 S ICDCS="2^ICD-9 Proc" Q
 . . I $O(^ICD0("ABA",31,ICDID,0))>0,$O(^ICD0("ABA",2,ICDID,0))'>0 S ICDCS="31^ICD-10-PCS" Q
 . . I $O(^ICD0("ABA",31,ICDID,0))>0,$O(^ICD0("ABA",2,ICDID,0))>0,ICDT<ICD10 S ICDCS="2^ICD-9 Proc" Q
 . . I $O(^ICD0("ABA",31,ICDID,0))>0,$O(^ICD0("ABA",2,ICDID,0))>0,ICDT'<ICD10 S ICDCS="31^ICD-10-PCS" Q
 . . Q  S:ICDT<ICD10 ICDCS="2^ICD-9 Proc" S:ICDT'<ICD10 ICDCS="31^ICD-10-PCS"
 Q:$L(ICDCS) ICDCS
 Q ""
CSI(FILE,IEN) ; Coding System for file and IEN
 ;
 ; Input:
 ;
 ;   FILE   File Number (required)
 ;   IEN    IEN in file 80/80.1 (required)
 ;
 ; Output:
 ; 
 ;   $$CSI  Coding System (pointer to file 80.4)
 ;          or null if not found
 ;   
 N ICDI,ICDRT,ICDCS S ICDRT=$$ROOT^ICDEX(+($G(FILE))) Q:'$L(ICDRT) ""
 S ICDI=+($G(IEN)) Q:+ICDI'>0 ""  S ICDCS=+($P($G(@(ICDRT_+ICDI_",1)")),"^",1)) Q:+ICDCS'>0 ""
 Q ICDCS
VMDC(IEN,CDT,FMT) ; Versioned Major Diagnostic Category
 ;
 ; Input:
 ;
 ;   IEN   IEN in file 80 (required)
 ;   CDT   Date to use to Extract MDC (default TODAY)
 ;   FMT   Output Format
 ;           0 = MDC only (default)
 ;           1 = MDC ^ Effective Date
 ;
 ; Output:
 ; 
 ;   MDC   Major Diagnostic Category
 ;            
 N MDC,DRGFY,ICDY,ICDD,ICDM,ICDOUT Q:+($G(IEN))'>0 ""  S FMT=+($G(FMT)) S:FMT'=1 FMT=0
 S ICDY=$P($G(^ICD9(IEN,1)),"^",1) Q:+ICDY'>0 "-1^Invalid Coding System"
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDEX($G(CDT),,ICDY)) Q:CDT'?7N ""
 S (MDC,DRGFY)="" S DRGFY=$O(^ICD9(+($G(IEN)),4,"B",(CDT+.001)),-1),MDC=$O(^ICD9(+($G(IEN)),4,"B",+DRGFY,MDC))
 S ICDOUT=$P($G(^ICD9(+($G(IEN)),4,+MDC,0)),U,2) S:FMT>0 ICDOUT=ICDOUT_"^"_$P($G(^ICD9(+($G(IEN)),4,+MDC,0)),U,1)
 Q ICDOUT
VSEX(FILE,IEN,CDT,FMT) ; Versioned Sex
 ;
 ; Input:
 ;
 ;   FILE  File
 ;           80    ICD Diagnosis file
 ;           80.1  ICD Operation/Procedure file
 ;   IEN   IEN (required)
 ;   CDT   Date to use to Extract Sex (default TODAY)
 ;   FMT   Output Format
 ;           0 = Sex only (default)
 ;           1 = Sex ^ Effective Date
 ;
 ; Output:
 ; 
 ;   SEX   Sex
 ;           M   Male
 ;           F   Female
 ;           Null
 ;            
 N ICDI,ICDR,ICDN,ICDD,ICDE,ICDS,ICDY,ICDOUT S ICDI=+($G(IEN)) Q:+ICDI'>0 ""
 S FMT=+($G(FMT)) S:FMT'=1 FMT=0 S ICDR=$$ROOT^ICDEX($G(FILE)) Q:'$L(ICDR) ""
 S ICDN=$S(ICDR="^ICD9(":5,ICDR="^ICD0(":3,1:"") Q:+ICDN'>0 ""
 S ICDY=$P($G(@(ICDR_+ICDI_",1)")),"^",1) Q:+ICDY'>0 "-1^Invalid Coding System"
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDEX($G(CDT),,ICDY)) Q:CDT'?7N ""
 S ICDE=$O(@(ICDR_ICDI_","_ICDN_",""B"","_(CDT+.001)_")"),-1) Q:ICDE'?7N ""
 S ICDS=$O(@(ICDR_ICDI_","_ICDN_",""B"","_ICDE_","" "")"),-1) Q:+ICDS'>0 ""
 S ICDS=$G(@(ICDR_ICDI_","_ICDN_","_ICDS_",0)"))
 Q:'$L(ICDS) ""
 S ICDD=$P(ICDS,"^",1),ICDS=$P(ICDS,"^",2) Q:"^M^F^"'[("^"_ICDS_"^") ""
 S ICDOUT=ICDS S:FMT>0 ICDOUT=ICDOUT_"^"_ICDD
 Q ICDOUT
SAI(FILE,IEN,CDT) ; Status/Activation/Inactivation
 ;
 ; Input:
 ;
 ;   FILE  File
 ;           80    ICD Diagnosis file
 ;           80.1  ICD Operation/Procedure file
 ;   IEN   IEN or code (required)
 ;   CDT   Date to use to Extract Status (default TODAY)
 ;
 ; Output:
 ; 
 ;   5 piece "^" delimited string
 ;   
 ;      1  Status
 ;      2  Activation Date
 ;      3  Inactivation Date
 ;      4  IEN
 ;      5  Code
 ;      6  Short Text
 ;      
 ;         If the status is active, the short
 ;         text will be the most recent.
 ;   
 ;         If the status is inactive, the short
 ;         text will be the text in use on the
 ;         date it was inactivated.
 ;  
 ;         Null if no status for date.
 ;      
 N ICDI,ICDCD,ICDR,ICDN,ICDE,ICDS,ICDY,EFF,ACT,STA,INA,NAM S ICDI=$G(IEN) Q:'$L(ICDI)
 S ICDR=$$ROOT^ICDEX($G(FILE)) Q:'$L(ICDR) ""
 S ICDCD=$$CODEC^ICDEX(FILE,ICDI)
 I '$D(@(ICDR_ICDI_",1)")) D
 . N ICDE S ICDE=0 F  S ICDE=$O(^ICDS(ICDE)) Q:+ICDE'>0  D
 . . N ICDT S ICDT=$O(@(ICDR_"""ABA"","_+ICDE_","""_(ICDI_" ")_""",0)")) Q:ICDT'>0
 . . S:ICDT?1N.N&(ICDI'?1N.N) ICDI=ICDT
 S ICDY=$P($G(@(ICDR_+ICDI_",1)")),"^",1) Q:+ICDY'>0 "-1^Invalid Coding System"
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:CDT) Q:CDT'?7N ""
 S ICDE=$O(@(ICDR_ICDI_",66,""B"","_(CDT+.001)_")"),-1) Q:ICDE'?7N ""
 S ICDS=$O(@(ICDR_ICDI_",66,""B"","_ICDE_","" "")"),-1) Q:+ICDS'>0 ""
 S ICDS=$G(@(ICDR_ICDI_",66,"_ICDS_",0)")) Q:'$L(ICDS) ""
 S (ACT,INA,NAM)="" S EFF=$P(ICDS,"^",1),STA=$P(ICDS,"^",2)
 S:STA>0 ACT=EFF S:STA'>0 INA=EFF
 I STA'>0,INA?7N D
 . S ICDE=$O(@(ICDR_ICDI_",66,""B"","_INA_")"),-1) Q:ICDE'?7N
 . S ICDS=$O(@(ICDR_ICDI_",66,""B"","_ICDE_","" "")"),-1) Q:+ICDS'>0
 . S ICDS=$G(@(ICDR_ICDI_",66,"_ICDS_",0)")) Q:'$L(ICDS)
 . S:$P(ICDS,"^",2)>0&($P(ICDS,"^",1)?7N) ACT=$P(ICDS,"^",1)
 I ACT?7N D
 . S ICDE=$O(@(ICDR_ICDI_",67,""B"","_(9999999+.001)_")"),-1) Q:ICDE'?7N
 . S ICDS=$O(@(ICDR_ICDI_",67,""B"","_ICDE_","" "")"),-1) Q:+ICDS'>0
 . S ICDS=$G(@(ICDR_ICDI_",67,"_ICDS_",0)")) Q:'$L(ICDS)
 . S:$L($P(ICDS,"^",2))>0 NAM=$P(ICDS,"^",2)
 S ICDS=+($G(STA)) S:$G(ACT)?7N $P(ICDS,"^",2)=$G(ACT)
 S:$G(INA)?7N $P(ICDS,"^",3)=$G(INA)
 S:ICDI?1N.N $P(ICDS,"^",4)=ICDI
 S:$L(ICDCD) $P(ICDS,"^",5)=ICDCD
 S:$L(NAM) $P(ICDS,"^",6)=NAM
 Q ICDS
VAGEL(IEN,CDT,FMT) ; Versioned Age Low
 ;
 ; Input:
 ;
 ;   IEN   IEN in file 80 (required)
 ;   CDT   Date to use to Extract Age Low (default TODAY)
 ;   FMT   Output Format
 ;           0 = Age Low only (default)
 ;           1 = Age Low ^ Effective Date
 ;
 ; Output:
 ; 
 ;   AGEL  Age Low
 ;            
 N AGEL,DRGFY,ICDY,ICDOUT Q:+($G(IEN))'>0 ""  S FMT=+($G(FMT)) S:FMT'=1 FMT=0
 S ICDY=$P($G(^ICD9(IEN,1)),"^",1) Q:+ICDY'>0 "-1^Invalid Coding System"
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDEX($G(CDT),,ICDY)) Q:CDT'?7N ""
 S (AGEL,DRGFY)="" S DRGFY=$O(^ICD9(+($G(IEN)),6,"B",(CDT+.001)),-1),AGEL=$O(^ICD9(+($G(IEN)),6,"B",+DRGFY,AGEL))
 S ICDOUT=$P($G(^ICD9(+($G(IEN)),6,+AGEL,0)),U,2) S:FMT>0 ICDOUT=ICDOUT_"^"_$P($G(^ICD9(+($G(IEN)),6,+AGEL,0)),U,1)
 Q ICDOUT
VAGEH(IEN,CDT,FMT) ; Versioned Age High
 ;
 ; Input:
 ;
 ;   IEN   IEN in file 80 (required)
 ;   CDT   Date to use to Extract Age High (default TODAY)
 ;   FMT   Output Format
 ;           0 = Age High only (default)
 ;           1 = Age High ^ Effective Date
 ;
 ; Output:
 ; 
 ;   AGEH  Age High
 ;            
 N AGEH,DRGFY,ICDY,ICDOUT Q:+($G(IEN))'>0 ""  S FMT=+($G(FMT)) S:FMT'=1 FMT=0
 S ICDY=$P($G(^ICD9(IEN,1)),"^",1) Q:+ICDY'>0 "-1^Invalid Coding System"
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDEX($G(CDT),,ICDY)) Q:CDT'?7N ""
 S (AGEH,DRGFY)="" S DRGFY=$O(^ICD9(+($G(IEN)),7,"B",(CDT+.001)),-1),AGEH=$O(^ICD9(+($G(IEN)),7,"B",+DRGFY,AGEH))
 S ICDOUT=$P($G(^ICD9(+($G(IEN)),7,+AGEH,0)),U,2) S:FMT>0 ICDOUT=ICDOUT_"^"_$P($G(^ICD9(+($G(IEN)),7,+AGEH,0)),U,1)
 Q ICDOUT
VCC(IEN,CDT,FMT) ; Return versioned Complication/Comorbidity
 ;
 ; Input:
 ;
 ;   IEN   IEN in file 80 (required)
 ;   CDT   Date to use to Extract CC (default TODAY)
 ;   FMT   Output Format
 ;           0 = CC only (default)
 ;           1 = CC ^ Effective Date ^ External Value
 ;
 ; Output:
 ; 
 ;   $$VCC  Complication/Comorbidity (FMT=0)
 ;          Complication/Comorbidity^Effective Date (FMT=1)
 ;            
 N ICDD,ICDI,ICDIC,ICDIC,ICDO,ICDE,ICDF S ICDF=+($G(FMT)),ICDI=+($G(IEN))
 S:ICDF'=1 ICDF=0 S ICDD=$O(^ICD9(ICDI,69,"B",CDT+.0001),-1) Q:'$L(ICDD) ""
 S ICDIC=$O(^ICD9(ICDI,69,"B",ICDD,""),-1) S ICDE=""
 S ICDO=$P(^ICD9(ICDI,69,ICDIC,0),U,2)
 S ICDD=$P(^ICD9(ICDI,69,ICDIC,0),U,1)
 S:ICDF>0&($L(ICDO)) ICDE=$$GET1^DIQ(80.0103,(ICDIC_","_ICDI_","),1)
 S:ICDF>0&($L(ICDO)) $P(ICDO,"^",2)=ICDD
 S:ICDF>0&($L(ICDO))&($L(ICDE)) $P(ICDO,"^",3)=ICDE
 Q ICDO
VCCP(IEN,CDT,FMT) ; Return versioned CC Primary Flag
 ;
 ; Input:
 ;
 ;   IEN     IEN in file 80 (required)
 ;   CDT     Date to use to Extract CC Primary Flag (default TODAY)
 ;   FMT     Output Format
 ;             0 = CC Primary Flag only (default)
 ;             1 = CC Primary Flag ^ Effective Date ^ External Value
 ;
 ; Output:
 ; 
 ;   $$VCCP  Complication/Comorbidity (FMT=0)
 ;           Complication/Comorbidity^Effective Date (FMT=1)
 ;            
 N ICDD,ICDI,ICDIC,ICDIC,ICDO,ICDE,ICDF S ICDF=+($G(FMT)),ICDI=+($G(IEN))
 S:ICDF'=1 ICDF=0 S ICDD=$O(^ICD9(ICDI,69,"B",CDT+.0001),-1) Q:'$L(ICDD) ""
 S ICDIC=$O(^ICD9(ICDI,69,"B",ICDD,""),-1) S ICDE=""
 S ICDO=$P(^ICD9(ICDI,69,ICDIC,0),U,3)
 S ICDD=$P(^ICD9(ICDI,69,ICDIC,0),U,1)
 S:ICDF>0&($L(ICDO)) ICDE=$$GET1^DIQ(80.0103,(ICDIC_","_ICDI_","),2)
 S:ICDF>0&($L(ICDO)) $P(ICDO,"^",2)=ICDD
 S:ICDF>0&($L(ICDO))&($L(ICDE)) $P(ICDO,"^",3)=ICDE
 Q ICDO
