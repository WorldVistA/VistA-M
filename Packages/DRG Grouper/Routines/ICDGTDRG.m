ICDGTDRG ;ALB/ADL - COLLECTION OF DRG APIS ;07/19/2012
 ;;18.0;DRG Grouper;**7,12,14,17,57,64**;Oct 20, 2000;Build 103
 ;   Collection of API's for accessing new "DRG" level
 ;   of files #80, #80.1, and #80.2.  These new levels
 ;   were added for the Code Set Versioning Project
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    ^ICDDRG0            ICR  N/A
 ;    $$CODEN^ICDEX       ICR  N/A
 ;    $$DRG^ICDEX         ICR  N/A
 ;    $$DRGD^ICDEX        ICR  N/A
 ;    $$DRGDES^ICDEX      ICR  N/A
 ;    $$DRGN^ICDEX        ICR  N/A
 ;    $$GETDATE^ICDEX     ICR  N/A
 ;    $$GETDRG^ICDEX      ICR  N/A
 ;    $$ISVALID^ICDEX     ICR  N/A
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     EFFD,ICDMDC
 ;     
GETDRG(CODE,DGNDT,FILE) ; Get DRG or DRG string associated with a Code
 ;
 ;  Input:
 ;     CODE  - IEN number
 ;     DRGDT - Effective date of the Code
 ;     FILE  - File to check : 9 - ICD9 (file #80)
 ;                                   0 - ICD0 (file 80.1)
 ;  Output:
 ;     DRGS - DRG or string of DRG's (delimited
 ;            by "^") or -1 if not defined
 ;
 ;            Effective date or error message; 
 ;            status flag (1=Active;0=Inactive)
 ;            Delimited by ";" because DRG's can be
 ;            multiple and are already delimited by "^"
 ;            
 ;  NOTE:  For ICD Procedures, it uses the additional variable ICDMDC
 ;
 Q $$GETDRG^ICDEX($G(FILE),$G(CODE),$P($G(DGNDT),".",1),$G(ICDMDC))
DRG(CODE,EDT)   ; Returns a string of information from the DRG file (#80.2)
 ; Input:   CODE   DRG code, internal or external format (Required)
 ;          CDT    Date to check status for, FileMan format (default = TODAY)
 ;                   If CDT < 10/1/1978, use 10/1/1978
 ;                   If CDT > DT, validate with In/Activation Dates
 ;                   If CDT is year only, use first of the year
 ;                   If CDT is year and month, use first of the month
 ; 
 ; Output:  Returns an 22 piece string delimited by the up-arrow (^), where the
 ;          pieces are:
 ;            1  DRG name (field #.01)
 ;            2  Weight (field #2)
 ;            3  Low Trim (days) (field #3)
 ;            4  High Trim (days) (field #4)
 ;            5  MDC (field #5)
 ;            6  Surgery Flag (field #.06)
 ;            7  <null>
 ;            8  Avg Length of Stay (days) (field 10)
 ;            9  Local Low Trim Days (field #11)
 ;           10  Local High Trim Days (field #12)
 ;           11  <null>
 ;           12  Local Breakeven (field #13)
 ;           13  Activation Date (.01 field of the 66 multiple)
 ;           14  Status (.03 field of the 66 multiple)
 ;           15  Inactivation Date (.01 field of the 66 multiple)
 ;           16  Effective date (.01 field of the 66 multiple)
 ;           17  Internal Entry Number (IEN)
 ;           18  Effective date of CSV (.01 field of the 66 multiple)
 ;           19  Reference (field #900)
 ;           20  Weight (Non Affil) (field #7)
 ;           21  Weight (Int Affil) (field #7.5)
 ;           22  Message
 ; 
 ;            or 
 ; 
 ;           -1^Error Description
 ; 
 Q $$DRG^ICDEX($G(CODE),$G(EDT))
CODEI(CODE)     ; Returns the IEN of an ICD code
 Q +($$CODEN^ICDEX($G(CODE),80))
GETDATE(PATNUM) ; Find the correct "EFFECTIVE DATE" for locating the DRG/ICD/CPT codes
 ;
 ;  Input:    PATNUM - PTF Record Number
 ;  Output:   "effective date" to use
 ;
 Q $$GETDATE^ICDEX($G(PATNUM))
ISVALID(CODE,EDATE,FILE) ; Is an ICD/CPT code Valid
 ; This is a function call to be used in DIC("S") FileMan
 ; calls to check the validation of a ICD/CPT code
 ; Input:
 ;    CODE   - ICD/CPT code (ien)
 ;    EDATE  - Effective date to be used
 ;    FILE   - File to use: 0 - ICD0; 9 - ICD9
 ;
 ; Output:
 ;    OUT    - 1 if valid; 0 if not
 ;
 Q $$ISVALID^ICDEX($G(FILE),$G(CODE),$G(EDATE))
DRGD(CODE,OUTARR,DFN,CDT) ; returns DRG description in array
 ; Input:   CODE   ICD Code, Internal or External Format (required)
 ;          ARY    Output Array Name for description 
 ;                   e.g. "ABC" or "ABC("TEST")" 
 ;                   Default = ^TMP("DRGD",$J)
 ;          DFN    Not in use but included in anticipation of future need
 ;          CDT    Date to screen against (default = TODAY)
 ;                   If CDT < 10/1/1978, use 10/1/1978
 ;                   If CDT > DT, use DT
 ;                   If CDT is year only, use first of the year
 ;                   If CDT is year and month only, use first of the month
 ; 
 ; Output:  #      Number of lines in description output array
 ;          @ARY(1:n) - Versioned Description (lines 1-n) (from the 68 multiple)
 ;          @ARY(n+1) - Blank
 ;          @ARY(n+1) - A message stating: CODE TEXT MAY BE INACCURATE
 ; 
 ;           or
 ; 
 ;          -1^Error Description
 ; 
 ; ** NOTE - USER MUST INITIALIZE ^TMP("DRGD",$J), IF USED **
 Q $$DRGD^ICDEX($G(CODE),$G(OUTARR),$G(CDT))
VLTDR(IEN,VDATE,ARY) ; Versioned Description - Long Text
 ; Input:
 ;    IEN    - Internal Entry Number file 80.2
 ;    VDATE  - Effective/Versioning date to be used
 ;    .ARY   - Array for output, passed by reference
 ;
 ; Output:
 ;    ARY()  - Local array containing versioned description
 ;
 Q $$DRGDES^ICDEX($G(IEN),$G(VDATE),.ARY)
CODEN(CODE) ; Return the IEN of DRG
 ;
 ;   Input:  DRG code
 ;  Output:  IEN of code
 ;
 Q $$DRGN^ICDEX($G(CODE))
