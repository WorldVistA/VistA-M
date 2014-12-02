ICDSUPT ;DLS/DEK - ICD SUPPORT FOR APIS ;04/21/2014
 ;;18.0;DRG Grouper;**6,57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;               
EN ; Main Entry Point
HELP ; Developer Help for an API
 D HLP^ICDEXH("LEG") Q
 ;
EFF(FILE,IEN,CDT) ; returns effective date and status for code/modifier
 ;
 ; Input:
 ; 
 ;    FILE   File number (required)
 ;           80 = ICD DX
 ;           80.1 = ICD O/P
 ;    IEN    ICD IEN (required)
 ;    CDT    Date to check (FileMan format) (required)
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
 ;
 ;   3 piece "^" delimited string
 ;   
 ;      1  Status
 ;      2  Activation Date
 ;      3  Inactivation Date
 ;
 N ICDD,ICDF,ICDI,ICDR,ICDX,ICDY
 I $G(IEN)="" Q "-1^No Code Selected"
 S ICDF=$$FILE^ICDEX($G(FILE)) Q:+($G(ICDF))'>0 "-1^Invalid File Selected"
 S ICDR=$$ROOT^ICDEX($G(ICDF)) Q:'$L(ICDR) "-1^Invalid File Selected"
 S ICDI=+($G(IEN)) Q:+ICDI'>0 "-1^IEN Invalid"
 S ICDY=$P($G(@(ICDR_+ICDI_",1)")),"^",1) Q:+ICDY'>0 "-1^Invalid Coding System"
 S ICDD=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDEX($G(CDT),,ICDY))
 S ICDX=$P($$SAI^ICDEX($G(ICDF),$G(ICDI),$G(ICDD)),"^",1,3)
 Q $S($L(ICDX,"^")=3:($P(ICDX,"^",1)_"^"_$P(ICDX,"^",3)_"^"_$P(ICDX,"^",2)),1:"-1^Not found")
LA(IEN,FILE,CDT) ; Last Current Activation Date
 ;
 ; Input:
 ; 
 ;   IEN    Internal Entry Number (Required)
 ;   FILE   Global Root/File Number (Required)
 ;   CDT    Date (default = TODAY) (Optional)
 ;   
 ; Output:
 ; 
 ;   $$LA   Last Current Activation Date OR -1 ^ Error Message
 ;   
 Q $$LA^ICDEX($G(FILE),$G(IEN),$G(CDT))
LI(IEN,FILE,CDT) ; Last Current Inactivation Date
 ; 
 ; Input:
 ; 
 ;   IEN    Internal Entry Number (Required)
 ;   FILE   Global Root/File Number (Required)
 ;   CDT    Date (default = TODAY) (Optional)
 ;   
 ; Output:
 ; 
 ;   $$LI   Last Current Inactivation Date OR -1 ^ Error Message
 ;   
 Q $$LI^ICDEX($G(FILE),$G(IEN),$G(CDT))
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
 Q $$NUM^ICDEX($G(CODE))
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
 Q $$COD^ICDEX($G(NUM))
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
 Q $$FILE^ICDEX($G(X))
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
 Q $$ROOT^ICDEX($G(X))
SNAM(X) ; System Name
 ;
 ; Input:
 ;
 ;   X     Numeric System Identifier (field 1.1)
 ;
 ; Output:
 ; 
 ;   X     Character System Identifier
 ;
 Q $$SNAM^ICDEX($G(X))
