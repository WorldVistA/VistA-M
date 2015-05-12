EDPLEX ;ALB/DRP - EDIS API'S ;8/28/2012
 ;;2.0;EMERGENCY DEPARTMENT;**2**;Feb 24, 2012;Build 23
 ;
 ; API's used for ICD10 implementation created for patch EDP*2.0*2
 ;    $$IMPDATE^LEXU      ICR   5679
 ;    $$FREQ^LEXU         ICR   5679
 ;    $$MAX^LEXU          ICR   5679
 ;    $$ICDOP^ICDEX       ICR   5747
 ;    $$ICDDX^ICDEX       ICR   5747
 ;
VER(EDPCSYS) ; CODING SYSTEM is passed in
 ;Input: Coding System Identifier (ICD,10D)
 ;Output: Returns the Nomenclature string used by GUI displays.
 N IMPDT,EDPCSTR S EDPCSTR=-1
 S:EDPCSYS="ICD" EDPCSTR=$S($D(^LEX(757.03,1,0))#10:$P($G(^LEX(757.03,1,0)),U,2),1:"ICD-9-CM")
 S:EDPCSYS="10D" EDPCSTR=$S($D(^LEX(757.03,30,0))#10:$P(^LEX(757.03,30,0),U,2),1:"ICD-10-CM")
 Q EDPCSTR
 ;
CSYS(EDPEDDT) ; Select proper Coding system based on Implementation date
 ; input    Date of Interest
 ; output...coding system active for date.
 ;
 Q:$G(EDPEDDT)="" "-1^"_$ZN_" Date In, Parameter not optional."
 N EDPLIMPDT,EDPLCSYS
 S EDPLCSYS="10D"
 S EDPLIMPDT=$$IMPDATE^LEXU(EDPLCSYS)
 S:EDPEDDT<EDPLIMPDT EDPLCSYS="ICD"
 Q EDPLCSYS
 ;
IMPDATE(EDPCSYS) ; Returns Implementation date of the ICD code set
 ;Input       CSYS = System abbreviation for the coding system
 ;Output      Implementation Date
 ;
 Q $$IMPDATE^LEXU(EDPCSYS)
 ;
TOOHI(X,EDPCSYS,EDPLMT) ; CHECK TERM FOR FREQUENCY AGAINST MAX ALLOWED - RETURN WARNING IF TOO LARGE
 ; Input     Search string         (X)
 ;           Coding system         (CSYS)
 ;           Honor Threshold Flag  (EDPLMT)
 ; Output    Threshold exceeded Message flag (with Message if failed)
 ;
 N EDPLCOUNT,EDPLALLOWED,EDPLRTN
 S EDPLCOUNT=$$FREQ^LEXU(X),EDPLALLOWED=$$MAX^LEXU(EDPCSYS),EDPLRTN=0
 I EDPLMT,EDPLCOUNT>EDPLALLOWED D
 .S EDPLRTN="1^Searching for "_X_" requires inspecting "_EDPLCOUNT_" records to determine if they match the search criteria. This could take quite some time. Suggest refining the search by further specifying "_X_".  Do you wish to continue?"
 .Q
 Q EDPLRTN
 ;
ICDDATA(EDPCSYS,EDPCODE,EDPDATE,EDPFRMT) ; ICD data for code
 ;Moved here from ICDXCODE, as that API will be retired
 ;
 ; Input:
 ;
 ;   EDPCSYS   Coding system                           Required     
 ;   EDPCODE   Code/IEN/variable pointer               Required
 ;   EDPDATE   Code Set Date (default = TODAY)
 ;   EDPFRMT   Code format "I" internal (IEN - DEFAULT)    
 ;                      "E" external (CODE)
 ;                      
 ; Output:
 ; 
 ;  Diagnosis returns an 20 piece string delimited by "^"
 ;  
 ;    1  IEN of code in file 80
 ;    2  ICD Dx Code                  (#.01)
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
 S EDPDATE=$P($G(EDPDATE),".",1),SYS=$$SYS^ICDEX($G(EDPCSYS),$G(EDPDATE)) S:+SYS'>0 SYS=$$SYS^ICDEX($G(EDPCODE))
 Q:+SYS'>0 "-1^Invalid coding system specified"
 S ROOT=$$ROOT^ICDEX(SYS) Q:'$L(ROOT) "-1^Invalid Global Root"
 Q:ROOT["ICD9" $$ICDDX^ICDEX($G(EDPCODE),$G(EDPDATE),$G(SYS),$G(EDPFRMT,"I"))
 Q:ROOT["ICD0" $$ICDOP^ICDEX($G(EDPCODE),$G(EDPDATE),$G(SYS),$G(EDPFRMT,"I"))
 Q "-1^Not found"
 ;
ICDDX(EDPCODE,EDPCDT,EDPDFN,EDPSRC) ; Return ICD Dx Code Info
 ;Moved here from ICDXCODE, as that API will be retired
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
 Q $$ICDDX^ICDEX($G(EDPCODE),$G(EDPCDT),1,$G(EDPSRC,"I"))
