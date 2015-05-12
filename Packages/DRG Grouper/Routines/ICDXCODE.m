ICDXCODE ;ISL/KER - ICD basic data API's ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;
 ; ICD wrapper APIs
 ;
EN ; Main Entry Point
HELP ; Developer Help for an API
 D HLP^ICDEXH("SDD") Q
 ;
ICDDATA(CSYS,CODE,DATE,FRMT,LOC) ; ICD data for code
 ;
 ; Input:
 ;
 ;   CSYS   Coding system                           Required     
 ;   CODE   Code/IEN/variable pointer               Required
 ;   DATE   Code Set Date (default = TODAY)
 ;   FRMT   Code format   "E" external (default)    
 ;                        "I" internal (IEN)
 ;   LOC    Local codes    1 = Yes
 ;                         0 = No (default)
 ;                      
 ; Output:
 ; 
 ;  Diagnosis returns an 22 piece string delimited by "^"
 ;  
 ;    1  IEN of code in file 80
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
 ;   Procedures returns A 14 piece string delimited by "^"
 ;   
 ;    1  IEN of code in file 80.1
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
 N ROOT,SYS
 S DATE=$P($G(DATE),".",1),SYS=$$SYS^ICDEX($G(CSYS),$G(DATE)) S:+SYS'>0 SYS=$$SYS^ICDEX($G(CODE))
 Q:+SYS'>0 "-1^Invalid coding system specified"
 S ROOT=$$ROOT^ICDEX(SYS) Q:'$L(ROOT) "-1^Invalid Global Root"
 S:CODE[";"&($P(CODE,";",2)=$TR(ROOT,"^",""))&($L($P(CODE,";",1))) FRMT="I",CODE=$P(CODE,";",1)
 S:'$L($G(FRMT)) FRMT=$$IE^ICDEX($G(CODE))
 Q:ROOT["ICD9" $$ICDDX^ICDEX($G(CODE),$G(DATE),$G(SYS),$G(FRMT),$G(LOC))
 Q:ROOT["ICD0" $$ICDOP^ICDEX($G(CODE),$G(DATE),$G(SYS),$G(FRMT),$G(LOC))
 Q "-1^Not found"
 ;
ICDDESC(CSYS,CODE,DATE,OUTARR) ; ICD description
 ;
 ; Input:
 ;
 ;   CSYS     Coding system
 ;   CODE     ICD Code (required)
 ;   DATE     Date (default = TODAY)
 ;  .OUTARR   Array Name passed by reference
 ;   
 ; Output:
 ; 
 ;   $$ICDDESC  Number of lines in array
 ;
 ;          @ARY(1) - Versioned Description (68 multiple)
 ;          @ARY(2) - blank
 ;          @ARY(3) - message: CODE TEXT MAY BE INACCURATE
 ;          
 Q $$ICDD^ICDEX($G(CODE),.OUTARR,$G(DATE),$G(CSYS))
 ;
STATCHK(CSYS,CODE,DATE) ; Check status for code
 ;
 ; Input:
 ; 
 ;   CSYS    Coding system
 ;   CODE    Code (IEN not allowed)
 ;   DATE    Date (default = TODAY)
 ; 
 ; Output: 
 ; 
 ;    2-Piece String containing the code's status
 ;    and the IEN if the code exists, else -1.
 ;    The following are possible outputs:
 ;    
 ;           1^IEN^Effective Date    Active Code
 ;           0^IEN^Effective Date    Inactive Code
 ;           0^-1                    Code not Found
 ;
 Q $$STATCHK^ICDEX($G(CODE),$G(DATE),$G(CSYS))
 ;
PREV(CSYS,CODE) ; Previous ICD Code
 ;
 ; Input:
 ; 
 ;     CSYS    Coding system                    Required
 ;     CODE    ICD-10 Code (IEN not allowed)    Required
 ;     
 ; Output:
 ; 
 ;    $$PREV  The Previous ICD Code, Null if none
 ;    
 Q $$PREV^ICDEX($G(CODE),$G(CSYS))
 ;
NEXT(CSYS,CODE) ; Next ICD Code
 ;
 ; Input:
 ; 
 ;     CSYS    Coding system                    Required
 ;     CODE    ICD-10 Code (IEN not allowed)    Required
 ;     
 ; Output:
 ; 
 ;    $$NEXT  The Next ICD Code, Null if none
 ;    
 Q $$NEXT^ICDEX($G(CODE),$G(CSYS))
 ;
HIST(CSYS,CODE,ARRAY) ; Activation History
 ;
 ; Input:
 ; 
 ;    CSYS     Coding system                     Required
 ;    CODE     ICD Code (IEN not allowed)        Required
 ;   .ARRAY    Array, passed by Reference        Required
 ;   
 ; Output:
 ; 
 ;    $$HIST   Mirrors ARRAY(0) or, -1 on error
 ;    ARRAY(0)      =  Number of Activation History Entries
 ;    ARRAY(<date>) =  Status    where: 1 is Active
 ;    ARRAY("IEN")  =  <ien>
 ;    
 Q $$HIST^ICDEX($G(CODE),.ARRAY,$G(CSYS))
 ;
PERIOD(CSYS,CODE,ARY) ; Activation Periods
 ; Input:
 ; 
 ;    CSYS     Coding system                     Required
 ;    CODE     ICD Code (IEN not allowed)        Required
 ;   .ARY      Array, passed by Reference        Required
 ;   
 ; Output:
 ; 
 ;    ARY(0) = IEN ^ Selectable ^ Error Message
 ;          
 ;       Where IEN = -1 if error
 ;       Selectable = 0 for unselectable
 ;       Error Message if applicable
 ;            
 ;    ARY(Activation Date) = Inactivation Date^Short Name
 ;
 ;       Where the Short Name is versioned as follows:
 ;
 ;       Period is active   - Text for TODAY's date
 ;       Period is inactive - Text for inactivation date
 ;    
 Q $$PERIOD^ICDEX($G(CODE),.ARY,$G(CSYS))
