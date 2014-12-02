ICDCODE ;DLS/DEK/KER/FJF - ICD CODE APIS ;04/21/2014
 ;;18.0;DRG Grouper;**6,12,14,29,57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("ICDD")        SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;               
EN ; Main Entry Point
HELP ; Developer Help for an API
 D HLP^ICDEXH("LEG") Q
 ;
ICDDX(CODE,CDT,DFN,SRC) ; Return ICD Dx Code Info
 ;
 ; Input:
 ;
 ;     CODE  Code/IEN (required)
 ;     CDT   Date (default = TODAY)
 ;     DFN   Not in use
 ;     SRC   Source
 ;             0 = exclude local codes
 ;             1 = include local codes
 ;
 ; Output:
 ;
 ;     Returns an 19 piece string delimited by ^
 ;  
 ;      1  IEN of code in file 80
 ;      2  ICD-9 Dx Code (#.01)
 ;      3  Id (#2)
 ;      4  Versioned Dx (67 multiple)
 ;      5  Unacceptable as Principal Dx (#101)
 ;      6  Major Dx Cat (#5)
 ;      7  MDC13 (5.5)
 ;      8  Compl/Comorb (#70)
 ;      9  ICD Expanded (#8) 1:Yes 0:No
 ;     10  Status (66 multiple)
 ;     11  Sex (#9.5)
 ;     12  Inactive Date (66 multiple)
 ;     13  MDC24 (#5.7)
 ;     14  MDC25 (#5.9)
 ;     15  Age Low (#14)
 ;     16  Age High (#15)
 ;     17  Activation Date (.01 of 66 multiple)
 ;     18  Message
 ;     19  Versioned Complication/Comorbidity (#103)
 ;
 ;       or
 ;
 ;     -1^Error Description
 ;
 N X S X=$$ICDDX^ICDEX($S($G(CODE)?1N.N:$$CODEC^ICDEX(80,$G(CODE)),1:$G(CODE)),$G(CDT),1,,$G(SRC))
 S $P(X,"^",3)=$TR($P(X,"^",3),";","")
 Q X
ICDOP(CODE,CDT,DFN,SRC) ; Return ICD Operation/Procedure Code Info
 ;
 ; Input:
 ; 
 ;     CODE  ICD code or IEN format, (required)
 ;      CDT  Date (default = TODAY)
 ;      DFN  Not in use
 ;      SRC  Source
 ;             0 = exclude local codes
 ;             1 = include local codes
 ;
 ; Output:
 ; 
 ;     Returns an 14 piece string delimited by ^
 ;     
 ;      1  IEN of code in file 80.1
 ;      2  ICD-9 code (#.01)
 ;      3  Id (#2)
 ;      4  MDC24 (#5)
 ;      5  Versioned Oper/Proc (67 multiple)
 ;      6  <null>
 ;      7  <null>
 ;      8  <null>
 ;      9  ICD Expanded (#8) 1:Yes 0:No
 ;     10  Status (66 multiple)
 ;     11  Use with Sex (#9.5)
 ;     12  Inactive Date (66 multiple)
 ;     13  Activation Date (66 multiple)
 ;     14  Message
 ;
 ;       or
 ;
 ;     -1^Error Description
 ;
 N X S X=$$ICDOP^ICDEX($S($G(CODE)?1N.N:$$CODEC^ICDEX(80.1,$G(CODE)),1:$G(CODE)),$G(CDT),2,,$G(SRC))
 S $P(X,"^",3)=$TR($P(X,"^",3),";","")
 Q X
ICDD(CODE,OUTARR,CDT) ; returns ICD description in array
 ;
 ; Input:
 ;
 ;     CODE   ICD Code (required)
 ;     ARY    Array Name for description
 ;            e.g. "ABC" or "ABC("TEST")"
 ;            Default = ^TMP("ICDD",$J)
 ;     CDT    Date (default = TODAY)
 ;
 ; Output:
 ;
 ;     #   Number of lines in array
 ;
 ;     @ARY(1:n) - Versioned Description (68 multiple)
 ;     @ARY(n+1) - blank
 ;     @ARY(n+1) - message: CODE TEXT MAY BE INACCURATE
 ;
 ;       or
 ;
 ;     -1^Error Description
 ;
 ;     ** NOTE - USER MUST INITIALIZE ^TMP("ICDD",$J), IF USED **
 ;
 N ICDDXOUT,ICDDXARY,END,ICDDXI,ICDDXC
 S ICDDXOUT=$$ICDD^ICDEX($G(CODE),.ICDDXARY,$G(CDT))
 Q:ICDDXOUT["-1^Invalid" "-1^Invalid code"
 Q:ICDDXOUT["-1^" ICDDXOUT
 I $G(OUTARR)="" S OUTARR="^TMP(""ICDD"",$J,"
 I OUTARR'["(" S OUTARR=OUTARR_"("
 I OUTARR[")" S OUTARR=$P(OUTARR,")")
 S END=$E(OUTARR,$L(OUTARR)) I END'="("&(END'=",") S OUTARR=OUTARR_","
 I OUTARR="^TMP(""ICDD"",$J," K ^TMP("ICDD",$J)
 S (ICDDXI,ICDDXC)=0 F  S ICDDXI=$O(ICDDXARY(ICDDXI)) Q:+ICDDXI'>0  D
 . N ARR S ARR=OUTARR_ICDDXI_")",@ARR=$G(ICDDXARY(ICDDXI)),ICDDXC=ICDDXC+1
 Q ICDDXC
CODEN(CODE,FILE) ; return ien of ICD code
 ;
 ; Input:
 ; 
 ;     CODE   ICD code (required)
 ;     FILE   File Number to search for code
 ;               80 = ICD Dx file
 ;               80.1 = ICD Oper/Proc file
 ;
 ; Output:
 ; 
 ;     IEN~global root
 ;       or
 ;     -1~error message
 ;
 N X S X=$$CODEN^ICDEX($G(CODE),$G(FILE))
 Q:X["-1~Invalid" "-1~Invalid code"
 Q X
CODEC(IEN,FILE) ;return the ICD code of an ien
 ;Input:
 ;  IEN    IEN of ICD code    REQUIRED
 ;  FILE   File Number to search for code
 ;         80 = ICD Dx file
 ;         80.1 = ICD Oper/Proc file
 ;
 ;Output: ICD code, -1 if not found
 ;
 S:+($G(FILE))'>0 FILE=80
 Q $$CODEC^ICDEX($G(FILE),$G(IEN))
CODEZ(CODE,ROOT,FLG) ; Based on IEN/root:
 N Y,ICDL            ; if 'FLG return code existence, else zero node - piece 1
 S Y=$P($G(@(ROOT_CODE_",0)")),U),ICDL=$L(Y) I ICDL,'$G(FLG) Q CODE
 Q $S('ICDL:-1,1:Y)
CODEBA(CODE,ROOT) ; Return IEN based on code/root
 ;
 ; Input:
 ;
 ;   CODE  ICD Code, either ICD-9 or ICD-10 (required)
 ;   ROOT  File Root or Number (required)
 ;
 ; Output:
 ; 
 ;   IEN   IEN for CODE in ROOT or -1 if not found
 ;   
 Q $$CODEBA^ICDEX($G(CODE),$G(ROOT))
COMCOM(IEN,VDT) ; Return versioned complication/comorbidity
 Q $$VCC^ICDEX($G(IEN),$G(CDT))
VST(IEN,VDT,FILE)     ; Versioned Short Text
 Q $$VST^ICDEX($G(FILE),$G(IEN),$G(CDT))
VSTD(IEN,VDT)  ; Versioned Short Text (Dx)
 Q $$VSTD^ICDEX($G(IEN),$G(CDT))
VSTP(IEN,VDT) ; Versioned Short Text (Proc)
 Q $$VSTP^ICDEX($G(IEN),$G(CDT))
VLT(IEN,VDT,FILE) ; Version Description - Long Text
 Q $$VLT^ICDEX($G(FILE),$G(IEN),$G(CDT))
VLTD(IEN,VDT) ; Versioned Description - Long Text (Dx)
 Q $$VLTD^ICDEX($G(IEN),$G(CDT))
VLTP(IEN,VDT) ; Versioned Description - Long Text (Proc)
 Q $$VLTP^ICDEX($G(IEN),$G(CDT))
