ICDEXD2 ;SLC/KER - ICD Extractor - DRG APIs (cont) ;12/19/2014
 ;;18.0;DRG Grouper;**57,67,82**;Oct 20, 2000;Build 21
 ;               
 ; Global Variables
 ;    ^ICDS(              N/A
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    ^%DT                ICR  10003
 ;    ^DIR                ICR  10026
 ;               
 Q
MD(FILE,IEN,CDT,ARY,FLAG) ; MDC DRGs
 ;
 ; Input
 ;
 ;    FILE   File Number/Identifier
 ;    IEN    Internal entry in file
 ;    CDT    Code Set Versioning Date
 ;   .ARY    Array name passed by reference
 ;    FLAG   Flag   I=Internal (default)
 ;                  E=External
 ;
 ; Output
 ;
 ;   ICD Procedures file 80.1 (multiple MDC)
 ;   
 ;      ARY(<fiscal year>,<MDC>)=DRG^;FY;STA
 ;      ARY(<fiscal year>,<MDC>)="DRG^DRG^;FY;STA
 ;   
 ;      If Flag contains "E"
 ;      ARY(<fiscal year>,"E",<MDC>)=MDC Name
 ;      ARY(<fiscal year>,"E",<MDC>,<DRG>)=DRG Name
 ;      ARY(<fiscal year>,"E",<MDC>)=MDC Name
 ;      ARY(<fiscal year>,"E",<MDC>,<DRG>)=DRG Name
 ;      ARY(<fiscal year>,"E",<MDC>,<DRG>)=DRG Name
 ;      ARY(<fiscal year>,"E","FY")=External FY
 ;   
 ;   ICD Diagnosis file 80 (single MDC)
 ;   
 ;      ARY(<fiscal year>,<MDC>)="DRG^DRG^;FY;STA
 ;   
 ;      If Flag contains "E"
 ;      ARY(<fiscal year>,"E",<MDC>)=MDC Name
 ;      ARY(<fiscal year>,"E",<MDC>,<DRG>)=DRG Name
 ;      ARY(<fiscal year>,"E",<MDC>,<DRG>)=DRG Name
 ;      ARY(<fiscal year>,"E","FY")=External FY
 ;   
 ;   NOTE:  If no Fiscal Year found for the input 
 ;   date then the first (earliest) Fiscal Year is 
 ;   used.
 ;
 N DRG,FY,FYIEN,MDC,MDCIEN,MY,MYIEN,ROOT,STA,STR S FLAG=$G(FLAG) S:'$L(FLAG) FLAG="I"
 S FILE=$G(FILE) S:FILE=9!(FILE["ICD9") FILE=80  S:FILE=0!(FILE["ICD0") FILE=80.1
 Q:"^80^80.1^"'[("^"_FILE_"^") "-1;Invalid file selected"
 S IEN=+($G(IEN)),CDT=$P($G(CDT),".",1)
 S ROOT=$$ROOT^ICDEX(FILE) S:CDT'?7N CDT=$$DT^XLFDT
 Q:'$L(ROOT) "-1;Invalid file selected"
 K ARY I FILE=80.1 D
 . S STA=1,FY=$O(^ICD0(IEN,2,"B",(CDT+.001)),-1)
 . S:FY'?7N STA=0,FY=$O(^ICD0(IEN,2,"B","")) Q:FY'?7N
 . S FYIEN=$O(^ICD0(IEN,2,"B",+$G(FY),0)) Q:+FYIEN'>0
 . S MDC=0 F  S MDC=$O(^ICD0(IEN,2,FYIEN,1,"B",MDC)) Q:'$L(MDC)  D
 . . S MDCIEN=0 F  S MDCIEN=$O(^ICD0(IEN,2,FYIEN,1,"B",MDC,MDCIEN)) Q:+MDCIEN'>0  D
 . . . S STR="",DRG=""
 . . . F  S DRG=$O(^ICD0(IEN,2,FYIEN,1,MDCIEN,1,"B",DRG)) Q:'$L(DRG)  S STR=STR_DRG_"^"
 . . S ARY(FY,MDC)=STR_";"_FY_";"_STA
 . . I FLAG["E" D
 . . . N ED,EMDC,DRGI,IDRG,DRGOUT
 . . . S ED=$$FMTE^XLFDT(FY,"5DZ"),EMDC=$P($G(^ICM(+MDC,0)),"^",1)
 . . . S ARY(FY,"E","FY")=ED,ARY(FY,"E",MDC)=EMDC
 . . . F DRGI=1:1 Q:'$L($P($G(STR),"^",DRGI))  D
 . . . . N IDRG,DRGOUT S IDRG=$P($G(STR),"^",DRGI) Q:+IDRG'>0
 . . . . K DRGOUT D DRGD^ICDGTDRG(IDRG,"DRGOUT",,$G(CDT))
 . . . . S:$L($G(DRGOUT(1)))&(+DRGI>0) ARY(FY,"E",MDC,IDRG)=$G(DRGOUT(1))
 I FILE=80 D
 . S STA=1,FY=$O(^ICD9(IEN,3,"B",(CDT+.001)),-1)
 . S:FY'?7N STA=0,FY=$O(^ICD9(IEN,3,"B","")) Q:FY'?7N
 . S MY=$O(^ICD9(IEN,4,"B",(FY+.001)))
 . S:MY'?7N MY=$O(^ICD9(IEN,4,"B",""))
 . S MYIEN=$O(^ICD9(IEN,4,"B",+$G(MY),0))
 . S MDC=$P($G(^ICD9(IEN,4,+MYIEN,0)),"^",2)
 . S FYIEN=$O(^ICD9(IEN,3,"B",+$G(FY),0)) Q:+FYIEN'>0
 . S STR="",DRG=""
 . F  S DRG=$O(^ICD9(IEN,3,FYIEN,1,"B",DRG)) Q:'$L(DRG)  S STR=STR_DRG_"^"
 . I +MDC'>0 S MDC=$$DRGMDC^ICDEXD(+STR)
 . S ARY(FY,MDC)=STR_";"_FY_";"_STA
 . I FLAG["E" D
 . . N ED,EMDC,DRGI,IDRG,DRGOUT
 . . S ED=$$FMTE^XLFDT(FY,"5DZ"),EMDC=$P($G(^ICM(+MDC,0)),"^",1)
 . . S ARY(FY,"E","FY")=ED,ARY(FY,"E",MDC)=EMDC
 . . F DRGI=1:1 Q:'$L($P($G(STR),"^",DRGI))  D
 . . . N IDRG,DRGOUT S IDRG=$P($G(STR),"^",DRGI) Q:+IDRG'>0
 . . . K DRGOUT D DRGD^ICDGTDRG(IDRG,"DRGOUT",,$G(CDT))
 . . . S:$L($G(DRGOUT(1)))&(+DRGI>0) ARY(FY,"E",MDC,IDRG)=$G(DRGOUT(1))
 Q
VMDCDX(IEN,CDT) ; Get versioned MDC for Diagnosis Code
 ;
 ; Input
 ;
 ;    IEN    Internal Entry Number file 80
 ;    CDT    Code Set Versioning Date
 ;
 ; Output
 ;
 ;   $$VMDCDX  Versioned MDC
 ;
 N ICDI,ICDD,ICDS,ICDM,ICDY S ICDI=+($G(IEN)) Q:'$D(^ICD9(ICDI,4,"B")) ""
 S ICDS=$P($G(^ICD9(+ICDI,1)),"^",1),ICDD=$$DTBR^ICDEX($G(CDT),0,ICDS)
 S (ICDM,ICDY)="",ICDY=$O(^ICD9(+ICDI,4,"B",(ICDD+.0001)),-1)
 S ICDM=$O(^ICD9(ICDI,4,"B",+ICDY,ICDM))
 Q $P($G(^ICD9(ICDI,4,+ICDM,0)),U,2)
VMDCOP(IEN,MDC,CDT) ; Get versioned MDC for Op/Pro ICD code from previous years
 ;
 ; Input
 ;
 ;    IEN    Internal Entry Number file 80.1
 ;    MDC    Major Diagnostic Category
 ;    CDT    Code Set Versioning Date
 ;
 ; Output
 ;
 ;   $$VMDCOP  4 piece "^" delimited string
 ;
 ;             1   Fiscal Year  Fileman format
 ;             2   MDC          Pointer to file 80.3
 ;             3   Fiscal Year  pointer to sub-file 80.171
 ;                              (formerly known as DADRGFY)
 ;             4   MDC          pointer to sub-file 80.1711
 ;                                (formerly known as DAMDC)
 ;
 N ICDI,ICDC,ICDD,ICDO,ICDY,ICDM,ICDS S ICDI=+($G(IEN)) Q:'$D(^ICD0(ICDI,2,"B")) ""
 S ICDC=$G(MDC) Q:'$L(MDC) ""  S ICDS=$P($G(^ICD0(+ICDI,1)),"^",1)
 S ICDD=$$DTBR^ICDEX($G(CDT),0,ICDS) S (ICDM,ICDY)=""
 S ICDD=ICDD+.0001 F  S ICDD=$O(^ICD0(ICDI,2,"B",ICDD),-1) Q:'ICDD!(ICDM>0)  D
 . S ICDY=$O(^ICD0(ICDI,2,"B",+$G(ICDD),ICDY)),ICDO=ICDD
 . S ICDM=$O(^ICD0(ICDI,2,+ICDY,1,"B",ICDC,ICDM))
 Q:'$L($G(ICDO)) ""
 Q (ICDO_"^"_ICDC_"^"_ICDY_"^"_ICDM)
 ;
MDCG(IEN,CDT,ARY) ; Set up ICDMDC() array
 ;
 ; Input
 ;
 ;    IEN    ICD Diagnosis (IEN)
 ;    CDT    Code Set Versioning Date
 ;   .ARY    Array name passed by reference
 ;
 ; Output
 ;
 ;    ARY    Array listing MDCs for all DRGs
 ;
 ;      ARY=MDC
 ;      ARY(MDC)=""
 ;
 N I,ICDC,ICDO,ICDTMP,ICDS,ICDD,DRGS S IEN=$G(IEN) Q:+IEN'>0  S ICDS=$P($G(^ICD9(+IEN,1)),"^",1)
 S ICDD=$$DTBR^ICDEX($G(CDT),0,ICDS) Q:'$L(IEN)  S ICDO=$G(ARY) K ARY S:$L(ICDO) ARY=ICDO
 S ICDTMP=$$GETDRG^ICDEX(80,IEN,ICDD) Q:'$P(ICDTMP,";",3)  S DRGS=$P(ICDTMP,";")
 F I=1:1 Q:'$L($P(DRGS,"^",I))  Q:'$P(DRGS,"^",I)  D
 . N DRG,MDC S DRG=$P(DRGS,"^",I) Q:DRG=""  S MDC=$P($$DRG^ICDGTDRG(DRG,ICDD),"^",5) Q:MDC=""  S ARY(MDC)=""
 Q
MDCT(IEN,CDT,ARY,FMT) ; For Multiple MDC DX Codes
 ;
 ; Input:
 ;
 ;    IEN  Internal Entry Number for file 80.1
 ;    CDT  Code Set Versioning Date
 ;   .ARY  Array of MDCs passed by reference (required)
 ;    FMT  Output Format (optional)
 ;
 ;           0   Boolean value only (default)
 ;           1   2 piece "^" delimited string
 ;                  1   Boolean value
 ;                  2   String of matching MDCs delimited by ";"
 ; Output:
 ;
 ;  $$MDCT  Boolean value
 ;
 ;           0  The ICD Procedure code identified by IEN
 ;              does not include any of the MDCs passed 
 ;              in .ARY(MDC) on the date specified (CDT)
 ;
 ;           1  The ICD Procedure code identified by IEN 
 ;              includes one or more of the MDCs passed
 ;              in .ARY(MDC) on the date specified (CDT)
 ;
 N FY,FYI,I,MD,MDC,OK,STR
 S IEN=+($G(IEN)) Q:'$D(^ICD0(+IEN,0)) 0
 Q:$P($G(^ICD0(IEN,1)),"^",7)>0 0
 S CDT=$G(CDT) S:CDT'?7N CDT=$$DT^XLFDT
 S FMT=+($G(FMT)),(STR,MD)="",OK=0 F I=1:1 S MD=$O(ARY(MD)) Q:MD=""  D
 . N FY,FYI,MDC S FY=$O(^ICD0(IEN,2,"B",(+CDT+.001)),-1) Q:FY'?7N
 . S FYI=$O(^ICD0(IEN,2,"B",+FY,0))
 . S MDC=$D(^ICD0(IEN,2,+FYI,1,"B",MD))
 . S:MDC>0 STR=STR_";"_MD
 . S:MDC>0 OK=1
 F  Q:$E(STR,1)'=";"  S STR=$E(STR,2,$L(STR))
 S OK=+OK S:FMT>0&($L(STR)) OK=OK_"^"_STR
 Q OK
MDCD(IEN,MDC,CDT) ; Check for default MDC
 ;
 ; Input:
 ;
 ;    IEN  Internal Entry Number for file 80.1
 ;    MDC  Major Diagnostic Category
 ;    CDT  Code Set Versioning Date (optional)
 ;         If not passed, the first FY is used
 ;
 ; Output:
 ;
 ;   $$MDCD  Boolean value
 ;
 ;           0  MDC Does not exist
 ;           1  MDC Exist
 ;
 N ICDY,ICDM,ICDD,ICDF S ICDY=+($G(IEN)) Q:'$D(^ICD0(+IEN,2,1,1)) 0  S ICDM=$G(MDC) Q:'$L(ICDM) 0
 S ICDD=$G(CDT),ICDF=$O(^ICD0(+ICDY,2,"B",(ICDD+.001)),-1) S:ICDF'?7N ICDF=$O(^ICD0(+ICDY,2,"B",""))
 S ICDF=$O(^ICD0(+ICDY,2,"B",+ICDF,0)) Q:ICDF'>0 $S($D(^ICD0(ICDY,2,1,1,"B",ICDM))>0:1,1:0)
 Q:ICDF>0 $S($D(^ICD0(ICDY,2,+ICDF,1,"B",ICDM))>0:1,1:0)
MDCN(IEN) ; Major Diagnostic Category Name
 ;
 ; Input:
 ;
 ;    IEN    Internal Entry Number for file 80.3
 ;
 ; Output:
 ;
 ;   $$MDCN  Major Diagnostic Category Name
 ;
 ; Replaces ICR 1586
 ; 
 Q $P($G(^ICM(+($G(IEN)),0)),"^",1)
MOR(IEN) ; Major O.R. Procedure
 ;
 ; Input:
 ;
 ;    IEN   Internal Entry Number for file 80.1
 ;
 ; Output:
 ;
 ;   $$MOR  Major O.R. Procedure
 ;
 Q $G(^ICD0(+($G(IEN)),"M"))
 ;
ISVALID(FILE,IEN,CDT) ; Is an ICD code Valid
 ;
 ; Input:
 ; 
 ;    FILE        File or global root
 ;    IEN         Internal Entry Number
 ;    CDT         Effective date to use (default TODAY)
 ;
 ; Output:
 ; 
 ;    $$ISVALID   This is a Boolean value
 ;  
 ;                  1 if the code is valid
 ;                  0 if the code is not valid
 ;
 N ICDO,ICDD,ICDF,ICDT,ICDX,ICDI,ICDR S ICDO=0
 S FILE=$S(FILE="9":80,FILE="0":80.1,1:FILE)
 S ICDD=$P($G(CDT),".",1) S:ICDD'?7N ICDD=$$DT^XLFDT
 S ICDF=$$FILE^ICDEX(FILE) Q:"^80^80.1^"'[("^"_FILE_"^") ICDO
 S ICDR=$$ROOT^ICDEX(FILE),ICDI=+($G(IEN)) Q:+ICDI'>0 ICDO
 Q:'$D(@(ICDR_+ICDI_",0)")) ICDO  S ICDX=$$EXC^ICDEX(ICDF,ICDI) Q:ICDX>0 ICDO
 S ICDT=$$LS^ICDEX(ICDF,ICDI,ICDD) I ICDT>0 S ICDO=1
 Q ICDO
REF(IEN,CDT) ; Return Reference Table
 ;
 ;  Input:
 ;  
 ;    IEN    Internal Entry Number
 ;    CDT    Effective date to use (default TODAY)
 ;
 ;  Output:
 ;  
 ;    $$REF  Table reference associated DRG entry
 ;           or null if not found
 ; 
 N ICDI,ICDD,ICDR,ICDFY,ICDR
 S ICDI=+($G(IEN)) Q:+IEN'>0!('$D(^ICD(IEN,2))) ""
 S (ICDFY,ICDR)="",ICDD=$P($G(CDT),".",1)
 S:ICDD'?7N ICDD=$$DT^XLFDT
 S ICDFY=$O(^ICD(ICDI,2,"B",(+ICDD+.01)),-1)
 S ICDR=$O(^ICD(ICDI,2,"B",+ICDFY,ICDR))
 S ICDR=$P($G(^ICD(ICDI,2,+ICDR,0)),U,3)
 Q ICDR
