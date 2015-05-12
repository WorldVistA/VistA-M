ICDEX ;SLC/KER - ICD Extractor - Main Entry Points ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;
 ; Global Variables
 ;    None
 ;
 ; External References
 ;    None
 ;
 ; Parameters for listed APIs
 ;
 ;    ARY     A local array passed by reference .ARY
 ;
 ;    CDT     This is the Code Set Versioning Date (Fileman
 ;            format) and is used to resolve the correct 
 ;            entry of a file or sub-file.
 ;
 ;    EDT     External Date allowed by Fileman
 ;
 ;    CODE    This is an ICD Diagnostic or Procedural code
 ;
 ;    FIELD   This is a field number from either file 80 or 80.1
 ;
 ;    FILE    File Number 80 or 80.1
 ;
 ;    FMT     Input format "I"=Internal "E"=External
 ;
 ;    IEN     Internal Entry Number of file 80 or 80.1
 ;
 ;    IEN1    Internal Entry Number of a specified sub-file
 ;
 ;    IEN2    Internal Entry Number of file 80 or 80.1
 ;
 ;    LEN     Length of the string of text in an array.
 ;            When passed, the short description or long
 ;            description will be parsed into string
 ;            lengths not to exceed the length passed.
 ;
 ;    MDC     Major Diagnostic Category (pointer to 
 ;            file #80.3)
 ;
 ;    NUM     Converts a code to a numeric representation 
 ;            of the code (used on the AN cross-reference)
 ;            for the $$NEXT and $$PREV APIs
 ;
 ;    REV     Directionality flag for $ORDER
 ;
 ;               0    $Order Forwards (default)
 ;               1    $Order in Reverse
 ;
 ;    ROOT    Global Root ^ICD9( or ^ICD0(
 ;
 ;    STD     Coding Standard
 ;
 ;               0    ICD (default)
 ;               1    CPT/HCPCS
 ;               2    DRG
 ;               3    LEX
 ;
 ;    SYS     Coding System
 ;
 ;               1    ICD     ICD-9-CM
 ;               2    ICP     ICD-9-PCS
 ;              30    1OD     ICD-10-CM
 ;              31    10P     ICD-10-PCS
 ;
 ;    TYPE    This is any identifier that can determine the
 ;            type of ICD code (diagnosis or procedure) that
 ;            is being used.  It can be a:
 ;
 ;              File Number           80 or 80.1
 ;              Global Root           ^ICD9( or ^ICD0(
 ;              Source Abbreviation   ICD, ICP, 10D OR 10P
 ;              Coding System         1, 2, 30, 31
 ;              Code                  250.01, B58.81, 50.11
 ;
 ;    TXT     Text String to search for in file 80/80.1
 ;
 ;    VER     Versioning flag
 ;
 ;               0  Unversioned search, return active/inactive codes
 ;               1  Versioned search, return only active codes
 ;
 ;    WORD    This is a single word parsed from a string
 ;
EN ; Main Entry Point
HELP ; Developer Help for an API
 D EN^ICDEXH Q
 ; 
 ; Code APIs
ICDDX(CODE,CDT,SYS,FMT,LOC) ; Dx Code Info
 Q $$ICDDX^ICDEXC($G(CODE),$P($G(CDT),".",1),$G(SYS),$G(FMT),$G(LOC))
ICDOP(CODE,CDT,SYS,FMT,LOC) ; Procedure Code Info
 Q $$ICDOP^ICDEXC($G(CODE),$P($G(CDT),".",1),$G(SYS),$G(FMT),$G(LOC))
ICDD(CODE,ARY,CDT,SYS,LEN) ; Description in Array
 Q $$ICDD^ICDEXC($G(CODE),.ARY,$P($G(CDT),".",1),$G(SYS),+($G(LEN)))
CODEN(CODE,FILE) ; IEN of code
 Q $$CODEN^ICDEXC($G(CODE),$G(FILE))
CODEC(FILE,IEN) ; Code from an IEN
 Q $$CODE^ICDEXC($G(FILE),$G(IEN))
CODEBA(CODE,ROOT) ; IEN from Code/Root
 Q $$CODEBA^ICDEXC($G(CODE),$G(ROOT))
CODEABA(CODE,ROOT,SYS) ; IEN from Code/Root/Coding System
 Q $$CODEABA^ICDEXC($G(CODE),$G(ROOT),$G(SYS))
RDX(CODE,CDT) ; Resolve Diagnosis Code Fragment
 Q $$RDX^ICDEXC4($G(CODE),$G(CDT))
 ;  
 ; Code APIs (code data/versioned data)
CODEFI(CODE) ; File for code
 Q $$CODEFI^ICDEXC2($G(CODE))
CODECS(CODE,FILE,CDT) ; Coding system for code/file
 Q $$CODECS^ICDEXC2($G(CODE),$G(FILE),$P($G(CDT),".",1))
CSI(FILE,IEN) ; Coding system for IEN
 Q $$CSI^ICDEXC2($G(FILE),$G(IEN))
VMDC(IEN,CDT,FMT) ; Major Diagnostic Category
 Q $$VMDC^ICDEXC2($G(IEN),$P($G(CDT),".",1),$G(FMT))
VAGEL(IEN,CDT,FMT) ; Age Low
 Q $$VAGEL^ICDEXC2($G(IEN),$P($G(CDT),".",1),$G(FMT))
VAGEH(IEN,CDT,FMT) ; Age High
 Q $$VAGEH^ICDEXC2($G(IEN),$P($G(CDT),".",1),$G(FMT))
VCC(IEN,CDT,FMT) ; Complication/Comorbidity
 Q $$VCC^ICDEXC2($G(IEN),$P($G(CDT),".",1),$G(FMT))
VCCP(IEN,CDT,FMT) ; CC Primary Flag
 Q $$VCCP^ICDEXC2($G(IEN),$P($G(CDT),".",1),$G(FMT))
VSEX(FILE,IEN,CDT,FMT) ; Sex for file
 Q $$VSEX^ICDEXC2($G(FILE),$G(IEN),$P($G(CDT),".",1),$G(FMT))
SAI(FILE,IEN,CDT) ; Status/Active/Inactive Dates
 Q $$SAI^ICDEXC2($G(FILE),$G(IEN),$P($G(CDT),".",1))
 ;  
 ; Code APIs (text/strings)
VST(FILE,IEN,CDT)     ; Short Text
 Q $$VST^ICDEXC3($G(FILE),$G(IEN),$P($G(CDT),".",1))
VLT(FILE,IEN,CDT) ; Long Text
 Q $$VLT^ICDEXC3($G(FILE),$G(IEN),$P($G(CDT),".",1))
VSTD(IEN,CDT)  ; Short Text - Diagnosis
 Q $$VSTD^ICDEXC3($G(IEN),$P($G(CDT),".",1))
VSTP(IEN,CDT) ; Short Text - Procedures
 Q $$VSTP^ICDEXC3($G(IEN),$P($G(CDT),".",1))
VLTD(IEN,CDT) ; Description - Diagnosis
 Q $$VLTD^ICDEXC3($G(IEN),$P($G(CDT),".",1))
VLTP(IEN,CDT) ; Description - Procedures
 Q $$VLTP^ICDEXC3($G(IEN),$P($G(CDT),".",1))
SD(FILE,IEN,CDT,ARY,LEN) ; Short Description (formatted)
 Q $$SD^ICDEXC3($G(FILE),$G(IEN),$P($G(CDT),".",1),.ARY,$G(LEN))
LD(FILE,IEN,CDT,ARY,LEN) ; Long Description (formatted)
 Q $$LD^ICDEXC3($G(FILE),$G(IEN),$P($G(CDT),".",1),.ARY,$G(LEN))
SDH(FILE,IEN,ARY) ; Short Description History
 Q $$SDH^ICDEXC4($G(FILE),$G(IEN),.ARY)
LDH(FILE,IEN,ARY) ; Long Description History
 Q $$LDH^ICDEXC4($G(FILE),$G(IEN),.ARY)
PAR(ARY,LEN) ; Parse Array
 D PAR^ICDEXC3(.ARY,$G(LEN)) Q
IEN(CODE,ROOT,SYS) ; IEN from Code/Root/Coding System
 Q $$IEN^ICDEXC3($G(CODE),$G(ROOT),$G(SYS))
 ;  
 ; API Support
STATCHK(CODE,CDT,SYS) ; Status of ICD Code
 Q $$STATCHK^ICDEXA($G(CODE),$P($G(CDT),".",1),$G(SYS))
DTBR(CDT,STD,SYS) ; Date Business Rules
 Q $$DTBR^ICDEXA($P($G(CDT),".",1),$G(STD),$G(SYS))
IMP(SYS,CDT) ; Implementation Date
 Q $$IMP^ICDEXA($G(SYS),$P($G(CDT),".",1))
MSG(CDT,STD,SYS) ; Warning Message
 Q $$MSG^ICDEXA($P($G(CDT),".",1),$G(STD),$G(SYS))
SEL(FILE,IEN) ; Entry is Selectable
 Q $$SEL^ICDEXA($G(FILE),$G(IEN))
NEXT(CODE,SYS,CDT) ; Next Code
 Q $$NEXT^ICDEXA2($G(CODE),$G(SYS),$P($G(CDT),".",1))
PREV(CODE,SYS,CDT) ; Previous Code
 Q $$PREV^ICDEXA2($G(CODE),$G(SYS),$P($G(CDT),".",1))
HIST(CODE,ARY,SYS) ; Activation History
 Q $$HIST^ICDEXA2($G(CODE),.ARY,$G(SYS))
PERIOD(CODE,ARY,SYS) ; Activation Periods
 Q $$PERIOD^ICDEXA2($G(CODE),.ARY,$G(SYS))
OBA(FILE,CODE,SYS,REV) ; $Order BA/ABA
 Q $$OBA^ICDEXA3($G(FILE),$G(CODE),$G(SYS),$G(REV))
OD(FILE,WORD,SYS,REV) ; $Order D/AD
 Q $$OD^ICDEXA3($G(FILE),$G(WORD),$G(SYS),$G(REV))
DLM(FILE,IEN,FIELD,CDT) ; Date Last Modified
 Q $$DLM^ICDEXA3($G(FILE),$G(IEN),$G(FIELD),$P($G(CDT),".",1))
CS(FILE,FMT,CDT) ; Select Coding System (lookup)
 Q $$CS^ICDEXA3($G(FILE),$G(FMT),$P($G(CDT),".",1))
 ;  
 ; Data Extraction Support
EFF(FILE,IEN,CDT) ; Effective date and status
 Q $$EFF^ICDEXS($G(FILE),$G(IEN),$P($G(CDT),".",1))
IA(FILE,IEN) ; Initial Activation Date
 Q $$IA^ICDEXS($G(FILE),$G(IEN))
LA(FILE,IEN,CDT) ; Last Activation Date
 Q $$LA^ICDEXS($G(FILE),$G(IEN),$P($G(CDT),".",1))
LI(FILE,IEN,CDT) ; Last Inactivation Date
 Q $$LI^ICDEXS($G(FILE),$G(IEN),$P($G(CDT),".",1))
LS(FILE,IEN,CDT,FMT) ; Last Status
 Q $$LS^ICDEXS($G(FILE),$G(IEN),$P($G(CDT),".",1),$G(FMT))
NUM(CODE) ; Convert Code to a Numeric
 Q $$NUM^ICDEXS($G(CODE))
COD(NUM) ; Convert Numeric to a Code
 Q $$COD^ICDEXS($G(NUM))
IE(CODE) ; Internal or External Format
 Q $$IE^ICDEXS($G(CODE))
FILE(SYS) ; File Number from System
 Q $$FILE^ICDEXS($G(SYS))
ROOT(SYS) ; Global Root
 Q $$ROOT^ICDEXS($G(SYS))
SYS(SYS,CDT,FMT) ; Resolve System (uses file 80.4)
 Q $$SYS^ICDEXS($G(SYS),$P($G(CDT),".",1),$G(FMT))
SINFO(SYS,CDT) ; System Info (uses file 80.4)
 Q $$SINFO^ICDEXS($G(SYS),$P($G(CDT),".",1))
SNAM(SYS) ; System Name from Coding System
 Q $$SNAM^ICDEXS($G(SYS))
SAB(SYS,CDT) ; Source Abbreviation
 Q $$SAB^ICDEXS($G(SYS),$P($G(CDT),".",1))
EXC(FILE,IEN) ; Exclude From lookup
 Q $$EXC^ICDEXS($G(FILE),$G(IEN))
VER(SYS,REL) ; Coding System Version
 Q $$VER^ICDEXS2($G(SYS),$G(REL))
HDR(FILE) ; File Header Node
 Q $$HDR^ICDEXS2($G(FILE))
 ;  
 ; DRG Grouper Extraction Support
ISA(IEN1,IEN2,FIELD) ; Is Code 1 a condition of Code 2 (ICDDRG)
 Q $$ISA^ICDEXD($G(IEN1),$G(IEN2),$G(FIELD))
ISVALID(FILE,IEN,CDT) ; Is an ICD code Valid
 Q $$ISVALID^ICDEXD2($G(FILE),$G(IEN),$G(CDT))
EXIST(IEN,FIELD) ; Does a condition Exist (ICDDRGX)
 Q $$EXIST^ICDEXD($G(IEN),$G(FIELD))
GETDRG(FILE,IEN,CDT,MDC) ; DRGs for an Fiscal Year (ICDGTDRG)
 Q $$GETDRG^ICDEXD($G(FILE),$G(IEN),$P($G(CDT),".",1),$G(MDC))
MD(FILE,IEN,CDT,ARY,FLAG) ; MDC DRGs
 D MD^ICDEXD2($G(FILE),$G(IEN),$P($G(CDT),".",1),.ARY,$G(FLAG))
EFM(EDT) ; Convert External Date to FM (ICDGTDRG)
 Q $$EFM^ICDEXD6($G(EDT))
FY(CDT) ; FY 4 digit year (ICDGTDRG)
 Q $$FY^ICDEXD6($P($G(CDT),".",1))
VMDCDX(IEN,CDT) ; Versioned MDC for DX (ICDREF)
 Q $$VMDCDX^ICDEXD2($G(IEN),$P($G(CDT),".",1))
VMDCOP(IEN,MDC,CDT) ; Versioned MDC for Op/Pro (ICDREF)
 Q $$VMDCOP^ICDEXD2($G(IEN),$G(MDC),$P($G(CDT),".",1))
REF(IEN,CDT) ; Return Reference Table (ICDREF)
 Q $$REF^ICDEXD2($G(IEN),$G(CDT))
MDCG(IEN,CDT,ARY) ; Set up array of MDCs (ICDDRG)
 D MDCG^ICDEXD2($G(IEN),$P($G(CDT),".",1),.ARY) Q
MDCT(IEN,CDT,ARY,FMT) ; For Multiple MDC DX Codes (ICDDRG)
 Q $$MDCT^ICDEXD2($G(IEN),$P($G(CDT),".",1),.ARY,$G(FMT))
MDCD(IEN,MDC,CDT) ; Check for default MDC (ICDDRG)
 Q $$MDCD^ICDEXD2($G(IEN),$G(MDC),$G(CDT))
MDCN(IEN) ; Major Diagnostic Category Name
 Q $$MDCN^ICDEXD2(+($G(IEN)))
MOR(IEN) ; Major O.R. Procedure (ICDDRG)
 Q $$MOR^ICDEXD2($G(IEN))
UPDX(IEN) ; Unacceptable as Principle DX
 Q $$UPDX^ICDEXD6($G(IEN))
POAE(IEN) ; Present on Admission Exempt
 Q $$POAE^ICDEXD6($G(IEN))
HAC(IEN) ; Hospital Acquired Conditions
 Q $$HAC^ICDEXD6($G(IEN))
NOT(IEN,SUB,FMT) ; Codes not Used With
 Q $$NOT^ICDEXD3($G(IEN),$G(SUB),$G(FMT))
REQ(IEN,SUB,FMT) ; Codes Required With
 Q $$REQ^ICDEXD3($G(IEN),$G(SUB),$G(FMT))
NCC(IEN,SUB,FMT) ; Codes not Considered CC With
 Q $$NCC^ICDEXD3($G(IEN),$G(SUB),$G(FMT))
ICDID(FILE,ID,CODE) ; Check if ICD identifier exist
 Q $$ICDID^ICDEXD4($G(FILE),$G(ID),$G(CODE))
IDSTR(FILE,IEN) ; ICD identifier string (legacy)
 Q $$IDSTR^ICDEXD4($G(FILE),$G(IEN))
ICDIDS(FILE,IEN,ARY) ; Returns array of ICD identifiers
 Q $$ICDIDS^ICDEXD4($G(FILE),$G(IEN),.ARY)
ISOWNCC(IEN,CDT,FMT) ; Return CC if DX is Own CC
 Q $$ISOWNCC^ICDEXD4($G(IEN),$G(CDT),$G(FMT))
ICDRGCC(DRG,CDT) ; Get CC/MCC flag from DRG
 Q $$ICDRGCC^ICDEXD4($G(DRG),$G(CDT))
INQ ; Inquire to the ICD Files
 D INQ^ICDEXD4 Q
EFD(X) ; Get Effective date in range (interactive)
 Q $$EFD^ICDEXD6
PDXE(IEN) ; Primary DX Exclusion Code
 Q $$PDXE^ICDEXD3($G(IEN))
DRG(CODE,CDT) ; Returns information about a DRG
 Q $$DRG^ICDEXD5($G(CODE),$G(CDT))
DRGW(IEN) ; DRG Weighted Work Unit (WWU)
 Q $$DRGW^ICDEXD6($G(IEN))
DRGDES(IEN,CDT,ARY,LEN) ; Formatted DRG Description
 Q $$DRGDES^ICDEXD5($G(IEN),$G(CDT),.ARY,$G(LEN))
DRGD(CODE,OUTARR,CDT) ; Unformatted DRG Description
 Q $$DRGD^ICDEXD5($G(CODE),$G(OUTARR),$G(CDT))
DRGN(CODE) ; Return the IEN of DRG
 Q $$DRGN^ICDEXD6($G(CODE))
DRGC(IEN) ; DRG Code
 Q $$DRGC^ICDEXD6($G(IEN))
GETDATE(IEN) ; Calculate Effective Date
 Q $$GETDATE^ICDEXD5($G(IEN))
 ;  
 ; Lookup
LK ; Special Lookup (called by DIC)
 D LK^ICDEXLK Q
LKTX(X,ROOT,CDT,SYS,VER,OUT) ; Lookup Text in ROOT (silent)
 Q $$LK^ICDEXLK3($G(X),$G(ROOT),$P($G(CDT),".",1),$G(SYS),$G(VER),$G(OUT))
Y(ROOT,IEN,CDT,FMT) ; Output Variable Y from Lookup
 D Y^ICDEXLK2($G(ROOT),$G(IEN),$P($G(CDT),".",1),$G(FMT)) Q
TOKEN(X,ROOT,SYS,ARY) ; Parse Text into Words
 D TOKEN^ICDTOKN($G(X),$G(ROOT),$G(SYS),.ARY) Q
WORD(X,ROOT,SYS) ; Word is Found
 Q $$WORD^ICDEXLK3($G(X),$G(ROOT),$G(SYS))
