ICDEXD ;SLC/KER - ICD Extractor - DRG APIs ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICD0(              N/A
 ;    ^ICD9(              N/A
 ;    ^ICD9("ACC"         N/A
 ;               
 ; External References
 ;    ^%DT                ICR  10003
 ;    $$DT^XLFDT          ICR  10103
 ;               
 Q
GETDRG(FILE,IEN,CDT,MDC) ; DRGs for an Fiscal Year (FY)
 ;
 ; Input
 ; 
 ;    FILE   ICD file number to used to retrieve 
 ;       
 ;    IEN    Internal Entry Number (IEN) (Required)
 ;           
 ;    CDT    This is the Code Set Versioning date 
 ;           (Fileman format, optional, default TODAY)
 ;           
 ;    MDC    Major Diagnostic Category (pointer to
 ;           file 80.1) used as a screen to limit 
 ;           the DRGs to a MDC.  This input parameter
 ;           only applies to the OPERATIONS/PROCEDURE 
 ;           file 80.1 which has multiple MDCs, each
 ;           with a possibility of multiple DRGs.
 ;
 ; Output
 ;
 ;    3 piece semi-colon delimited string
 ;
 ;        1  DRGs delimited by ^
 ;        2  Fiscal Year
 ;        3  Status flag
 ;             0 inactive
 ;             1 active
 ;
 ;        Example output:
 ;        
 ;           907^908^909^;3071001;1
 ;        
 ;        On Error:
 ;        
 ;           -1;No DRG level;0
 ;           
 N FY,MD,OUT S OUT="",FILE=$G(FILE),IEN=$G(IEN)
 S FILE=$S(FILE="9":80,FILE="0":80.1,1:FILE)
 S FILE=$$FILE^ICDEX(FILE)
 Q:"^80^80.1^"'[("^"_$G(FILE)_"^") "-1;Invalid file specified;0"
 Q:$G(IEN)'?1N.N "-1;Invalid IEN specified;0"
 D MD^ICDEXD2(FILE,IEN,CDT,.MD)
 S FY=$O(MD(""))
 Q:FY'?7N "-1;No DRG level;0"
 I FILE=80.1,$L($G(MDC)) D  Q OUT
 . S OUT=$G(MD(FY,MDC))
 . S:+($P($G(OUT),";",1))'>0 OUT="-1;No DRG level;0"
 I FILE=80.1,'$L($G(MDC)) D  Q OUT
 . N MDC S MDC=$O(MD(FY,"")) I $L(MDC),MDC=$O(MD(FY," "),-1) S OUT=$G(MD(FY,MDC))
 . S:+($P($G(OUT),";",1))'>0 OUT="-1;No DRG level;0"
 I FILE=80 D  Q OUT
 . N MDC S MDC=$O(MD(FY,"")) I $L(MDC),MDC=$O(MD(FY," "),-1) S OUT=$G(MD(FY,MDC))
 . S:+($P($G(OUT),";",1))'>0 OUT="-1;No DRG level;0"
 Q $S($L(OUT):OUT,1:"-1;No DRG level;0")
GETPRE(IEN,MDC) ; Get MDC for Op/Pro ICD for Previous Years
 ;
 ; Input
 ;
 ;    IEN   Internal Entry Number (80.1) (required)
 ;    MDC   Major Diagnostic Category (required)
 ;
 ; Output
 ;
 ;   2 piece "^" delimited string
 ;
 ;          1  Internal entry number for fiscal year
 ;          2  Internal entry number for MDC
 ;
 ;   OR -1 if not found
 ;
 N ICDF,ICDFI,ICDI,MDCIEN S ICDI=+($G(IEN)),MDC=$G(MDC) Q:+ICDI'>0!('$L(MDC)) -1  S (ICDFI,MDCIEN)=0,ICDF=""
 F  S ICDF=$O(^ICD0(ICDI,2,"B",ICDF),-1) Q:'ICDF!(MDCIEN>0)  D  Q:MDCIEN>0
 . S ICDFI=$O(^ICD0(ICDI,2,"B",+$G(ICDF),0))
 . S MDCIEN=$O(^ICD0(ICDI,2,+ICDFI,1,"B",MDC,0))
 Q:+ICDFI'>0!(+MDCIEN'>0) -1
 Q (ICDFI_"^"_MDCIEN)
 ;
LEMDC(FILE,IEN,CDT,MDC) ; Last Effective MDC
 ;
 ; Input
 ;    FILE   File 80 or 80.1
 ;    IEN    Internal Entry Number in FILE
 ;    CDT    Code Set Versioning Date
 ;    MDC    Major Diagnostic Category (file 80.1 only)
 ;           If the file is 80.1, and MDC is not provided,
 ;           then the first MDC is returned.
 ;
 ; Output
 ;
 ;    2 piece "^" delimited string
 ;           1   Fiscal Year (Fileman Format)
 ;           2   MDC (pointer to file 80.3
 ;
 ;    or    -1^error message    on error
 ;
 N OUT,ROOT S FILE=$G(FILE) S:FILE=9!(FILE["ICD9") FILE=80  S:FILE=0!(FILE["ICD0") FILE=80.1
 Q:"^80^80.1^"'[("^"_FILE_"^") "-1;Invalid file selected"
 S IEN=+($G(IEN)),CDT=$P($G(CDT),".",1)
 S ROOT=$$ROOT^ICDEX(FILE) S:CDT'?7N CDT=$$DT^XLFDT
 Q:'$L(ROOT) "-1;Invalid file selected"
 Q:'$D(@(ROOT_+IEN_",0)")) "-1;No such entry"
 S OUT="" I FILE=80.1 D
 . N TMDC,FY,FYIEN S FY=$O(^ICD0(+IEN,2,"B",(CDT+.001)),-1)
 . ; get previous from today
 . S:FY'?7N FY=$O(^ICD0(+IEN,2,"B"," "),-1)
 . S:FY'?7N OUT="-1^FY not found" Q:FY'?7N
 . S FYIEN=$O(^ICD0(IEN,2,"B",FY,0))
 . S:FYIEN'>0 OUT="-1^FY not found" Q:+FYIEN'>0
 . S TMDC=+($G(MDC))
 . I TMDC'>0!('$D(^ICD0(IEN,2,FYIEN,1,"B",TMDC))) D  Q
 . . S OUT="-1^MDC not specified"
 . S OUT=FY_"^"_TMDC
 Q:$L($G(OUT)) OUT
 I FILE=80 D
 . N TMDC,FY,FYIEN S FY=$O(^ICD9(+IEN,4,"B",(CDT+.001)),-1)
 . S:FY'?7N FY=$O(^ICD9(+IEN,4,"B"," "),-1)
 . S:FY'?7N OUT="-1^FY not found" Q:FY'?7N
 . S FYIEN=$O(^ICD9(IEN,4,"B",FY,0))
 . S:FYIEN'>0 OUT="-1^FY not found" Q:+FYIEN'>0
 . S TMDC=$P($G(^ICD9(IEN,4,FYIEN,0)),"^",2)
 . S:TMDC'>0 OUT="-1^MDC not found" Q:+TMDC'>0
 . S OUT=FY_"^"_TMDC
 Q:$L($G(OUT)) OUT
 Q "-1^Last Effective MDC not found"
EXIST(IEN,FIELD) ; Does a condition Exist
 ;
 ; Input:
 ;
 ;   IEN    Internal Entry to file 80
 ;   FIELD  Type of condition to check
 ;
 ;           20   Code Not Used With
 ;           30   Code Required With
 ;           40   Code Not Considered CC With
 ;           
 ; Output:
 ;
 ;   $$EXIST  Boolean value
 ;
 ;          1   Yes/True
 ;          0   No/False
 ;
 ;    Field   Answers the Question
 ;    -----   -------------------------------------------------        
 ;    20      Are there any codes required with this code (IEN)
 ;    30      Are there any codes that should not be used
 ;            with this code (IEN)
 ;    40      Are there any codes that are not considered
 ;            Complication/Comorbidity (CC) with this code
 ;            (IEN)
 ;
 N ICDI,ICDF,ICDT,ICDO S ICDI=$G(IEN),ICDF=$G(FIELD) Q:+ICDI'>0 0  Q:+ICDF'>0 0
 S ICDT=$S(ICDF=20:"N",ICDF=30:"R",ICDF=40:2,1:"") Q:'$L(ICDT) 0
 S ICDI=+($O(^ICD9(ICDI,ICDT," "),-1))
 Q $S(ICDI>0:1,1:0)
ISA(IEN1,IEN2,FIELD) ; Is Code 1 a condition of Code 2 (this code)
 ;
 ; Input:
 ;
 ;   IEN1   This is the internal entry number (IEN) of a
 ;          code in file 80 that has a relationship with 
 ;          the code at IEN2  IEN1 is equivalent to 
 ;          Fileman's DA and identifies a code stored in
 ;          a multiple in field 20, 30, 40 or pointed to
 ;          by field 1.11.
 ;
 ;   IEN2   This is the internal entry number (IEN) of a
 ;          code in file 80 that may have other codes (IEN1)
 ;          associated with it.  IEN2 is equivalent to 
 ;          Fileman's DA(1) and identifies the code in 
 ;          the .01 field.
 ;
 ;   FIELD  This is a field number in file 80 that contains 
 ;          one or more ICD codes that have a relationship to
 ;          the main entry.   Acceptable field numbers and
 ;          the type of relationships to check include:
 ;
 ;           Field       Relationship
 ;           20          Code 1 Not Used With Code 2
 ;           30          Code 1 Required With Code 2
 ;           40 or 1.11  Code 1 Not Considered CC With Code 2
 ;
 ; Output:
 ;
 ;   $$ISA  Boolean value
 ;
 ;          1   Yes/The relationship is True
 ;          0   No/The relationship is False
 ;
 ;    Field        Answers the Question
 ;    -----        ---------------------------------------------
 ;    20           Code 1 (identified by IEN1) is not used with
 ;                 Code 2 (identified by IEN2)
 ;
 ;    30           Code 1 (identified by IEN1) is required with
 ;                 Code 2 (identified by IEN2)
 ;
 ;    40 or 1.11   Code 1 (identified by IEN1) is not considered
 ;                 Complication/Comorbidity (CC) with Code 2
 ;                 (identified by IEN2)
 ; 
 N ICD1,ICD2,ICDF,ICDT,ICDO,ICDCS S ICDO=0,ICD1=+($G(IEN1)),ICD2=+($G(IEN2)),ICDF=$G(FIELD)
 Q:+ICDF'>0 ICDO  S ICDT=$S(ICDF=20:"N",ICDF=30:"R",ICDF=40:1,ICDF=1.11:1,1:"")
 Q:'$L(ICDT) 0  Q:'$D(^ICD9(ICD2,ICDT)) 0
 S ICDCS=$P($G(^ICD9(ICD2,1)),"^",1)
 I ICDF=20!(ICDF=30) D  Q ICDO
 . S ICDO=$S($D(^ICD9(ICD2,ICDT,"B",ICD1)):1,1:0)
 I ICDF=40!(ICDF=1.11) D  Q ICDO
 . N ICDPDXE S ICD0=0 S ICDPDXE=$$PDXE^ICDEX(ICD2) I ICDPDXE>0 D  Q
 . . S:$D(^ICDCCEX(ICDPDXE,1,"B",ICD1)) ICDO=1
 . I ICDCS=1!(ICDCS=2) S:$D(^ICD9("ACC",ICD2,ICD1)) ICDO=1
 Q ICDO
DRGMDC(X) ; DRG MDC
 ;
 ; Input:
 ;
 ;   X      Internal Entry Number DRG file 80.2
 ;
 ; Output:
 ;
 ;   $$X    Internal Entry Number MDC file 80.3
 ;          -1 on error
 ;
 N MDC S MDC=$P($G(^ICD(+($G(X)),0)),"^",5) S X=$S(MDC>0:MDC,1:-1)
 Q X
