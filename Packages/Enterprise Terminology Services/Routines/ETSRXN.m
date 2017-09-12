ETSRXN ;O-OIFO/FM23 - RxNorm APIs ;03/06/2017
 ;;1.0;Enterprise Terminology Service;**1**;Mar 20, 2017;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
HIST(ETSCODE,ETSSYS,ARY) ; Get Activation History for a Code
 ;                      
 ; Input:
 ; 
 ;    ETSCODE   RXCUI (required)
 ;    ETSSYS    Coding System (required) [hard coded to RXN]
 ;   .ARY       Array, passed by Reference (required)
 ;                      
 ; Output:
 ;    
 ;    $$HIST  Number of Histories Found
 ;              or
 ;            -1 ^ error message
 ;    
 ;    ARY(0) = Number of Activation History
 ;    ARY(0,0) = IEN ^ "RXN" ^ "RXNORM" ^ IEN (file 129.2)
 ;               ^ TTY (file 129.2, #.03)
 ;    ARY(0,1) = STR (file 129.2, #1)
 ;    ARY(<date>,<status>) = Comment
 ;
 ;
 N ETSSI,ETSSTAT,ETSDATE,ETSIEN,ETSN
 ;
 ;Clear any older data
 K ARY
 ;
 ;Validate the input
 Q:'$G(ETSCODE) "-1^Code missing"
 S:$G(ETSSYS)="" ETSSYS="RXN"
 Q:ETSSYS'="RXN" "-1^Invalid source"
 ;
 S ETSSI="RXN^RXNORM"
 ;
 ; Find the most relevant entry for the RXCUI
 ;  Need to look at TTYs PSN, SCD, SBD, GPACK
 ;  and BPACK in that order of preference for
 ;  the RXNORM source.  Entry is also not 
 ;  suppressed (129.2,field .05 = "N")
 S ETSIEN=$$GETIEN(ETSCODE,1,"")
 ;
 ; quit if RXCUI is not defined for any of the preferred TTYs
 Q:ETSIEN="" "-1^RXCUI Not Found"
 ;
 ;Get the activation date and count
 S ETSSTAT=1,ETSN=1
 S ETSDATE=$$GET1^DIQ(129.2,ETSIEN_", ",91,"I")
 ;
 Q:ETSDATE="" "-1^Activation Date Not Found"
 ;
 S ARY(ETSDATE,ETSSTAT)="Activated"
 ;
 S ARY(0)=ETSN
 S ARY(0,0)=ETSSI_"^"_ETSIEN_"^"
 S ARY(0,0)=ARY(0,0)_$$GET1^DIQ(129.2,ETSIEN_", ",.03,"I")
 S ARY(0,1)=$$GET1^DIQ(129.2,ETSIEN_", ",1,"I")
 Q ETSN
 ;
GETIEN(ETSRXC,ETSACT,ETSDT) ;
 ; Input - ETSRXC - RXCUI (required)
 ;         ETSACT - (Optional) Active only (default is 1)
 ;         ETSDT  - (Optional) Date to filter on
 ;
 ; Output - $$GETIEN - IEN of the most relevant entry
 ;                      or NULL
 ; Find the most relevant entry for the RXCUI
 ;  Need to look at TTYs PSN, SCD, SBD, GPACK
 ;  and BPACK in that order of preference for
 ;  the RXNORM source.  Entry is also not 
 ;  suppressed (129.2,field .05 = "N")
 N ETSIEN,TTY,FLG,ETSFDT
 ;
 S ETSFDT=$G(ETSDT)
 S ETSIEN=""
 S:$G(ETSACT)="" ETSACT=1
 ;
 ; Loop through the VA requested TTYs.
 S FLG=0
 F TTY="PSN","SCD","SBD","GPACK","BPACK" D  Q:FLG
 . S ETSIEN=$O(^ETSRXN(129.2,"C","RXNORM",ETSCODE,TTY,""))
 . Q:ETSIEN=""
 . ;Check the suppress flag
 . S FLG=1
 . I ETSACT D  Q
 .. I $$GET1^DIQ(129.2,ETSIEN_", ",.05,"I")'="N" S FLG=0 Q  ; RXCUI Suppressed
 .. S:'$$ACTFLG(ETSFDT,ETSIEN) FLG=0  ;Date requsted before activation date 
 . I 'ETSACT D  Q
 .. S:'$$ACTFLG(ETSFDT,ETSIEN) FLG=0  ;Date requsted before activation date 
 ;
 ; Return null if Inactive, not found or suppressed
 Q:'FLG ""
 ;
 ; Return IEN if found and Active
 Q ETSIEN
 ;
ACTFLG(ETSFDT,ETSIEN)  ;determine if RXCUI is active
 ;
 ; Input:  ETSFDT - Date user wishes to check for active status
 ;         ETSIEN - IEN of the requested RXCUI
 ;
 ; Output: $$ACTFLG - 1 (Active) or 0 (Date before activation)
 ;
 N ETSADT,ETSFLG
 ;
 S ETSFLG=1  ; Defaut is active
 I $G(ETSFDT)'="" D
 . S ETSADT=$$GET1^DIQ(129.2,$G(ETSIEN)_", ",91,"I")
 . I ETSADT="" S ETSFLG=0 Q
 . I ETSFDT<ETSADT S ETSFLG=0 Q
 Q ETSFLG
 ;
PERIOD(ETSCODE,ETSSYS,ARY) ; Get Activation/Inactivation Periods for a Code
 ;
 ; Input:
 ; 
 ;    ETSCODE   RXCUI (required)
 ;    ETSSYS    Coding System (Hardcode to look for RXN, default is RXN)
 ;   .ARY       Array, passed by Reference (required)
 ;
 ; Output:
 ; 
 ;   $$PERIOD   Multiple piece "^" delimited string
 ;   
 ;              1  Number of Activation Periods found (should only be 1
 ;              2  TTY
 ;              3  "RXN"
 ;              4  "RXNORM"
 ;              5  "RXNORM"
 ;              
 ;                or
 ;              
 ;              -1^Message (no entries or other error message)
 ;            
 ;   ARY(0)     Same as $$PERIOD (above)
 ;   
 ;   ARY(Activation Date) = 4 piece "^" delimited string
 ;   
 ;              1  Inactivation Date
 ;                 (conditional)
 ;            
 ;              2  not used
 ;               
 ;              3  Variable Pointer IEN;ETSRXN(129.2,
 ;                  
 ;              4  not used
 ;
 ;   ARY(Activation Date,0) = STR
 ;   
 ; Looks through the Activation History to build the information
 ; 
 N ETSSD,ETSIEN,ETSADT
 ;
 Q:'$L($G(ETSCODE)) "-1^Missing RXCUI"
 S:$G(ETSSYS)="" ETSSYS="RXN"
 Q:ETSSYS'="RXN" "-1^Missing/Invalid Coding System"
 Q:'$D(ARY) "-1^Return Array Not Defined"
 ;
 ; Hardcode the Coding system information for now.
 S ETSSD="RXN^RXNORM^RXNORM"
 K ARY
 ;
 ; Retrieve the IEN for the code
 S ETSIEN=$$GETIEN(ETSCODE,1,"")
 Q:ETSIEN="" "-1^RXCUI Not Found"
 ;
 S ARY(0)="1"_U_$$GET1^DIQ(129.2,ETSIEN_", ",.03,"I")_U_ETSSD
 ;
 ;set the activation date nodes
 S ETSADT=$$GET1^DIQ(129.2,ETSIEN_", ",91,"I")
 Q:ETSADT="" "-1^Activation Date not found"
 ;
 S ARY(ETSADT)=U_U_ETSIEN_";ETSRXN(129.2"_U
 S ARY(ETSADT,0)=$$GET1^DIQ(129.2,ETSIEN_", ",1,"I")
 Q ARY(0)
 ;
CSYS(ETSSYS) ;Retrieve the Coding System Information
 ; Hardcoded to specifically provide LEXICON users System Information
 ; Currently hardcoded - ETS does not have a Coding System dictionary
 ;
 ; Input
 ; 
 ;   ETSSYS       Coding System Abbreviation (757.03,.01)
 ;             or pointer to file 757.03
 ;    
 ; Output
 ; 
 ;     A 14 piece caret (^) delimited string 
 ;     
 ;      1    Not Used
 ;      2    SAB (3 character source abbreviation) 
 ;      3    Source Abbreviation (3-7 char) 
 ;      4    Nomenclature (2-11 char) 
 ;      5    Source Title (2-52 char) 
 ;      6    Source (2-50 char) 
 ;   7-11    Not used
 ;     12    Version Id (1-40 char) [optional]
 ;     13    Implementation Date (date)  [optional]
 ;     14    Lookup Threshold
 ;
 N ETSDATA
 S ETSDATA=""
 S:$G(ETSSYS)="" ETSSYS="RXN"
 Q:ETSSYS'="RXN" "-1^Invalid Coding System"
 S ETSDATA="^RXN^RxNorm^RxNorm^RxNorm^National Library of Medicine"
 Q ETSDATA
 ;
CSDATA(ETSCODE,ETSCSYS,ETSCDT,ARY) ; Get Information about a Code
 ;
 ; Input:
 ;
 ;   ETSCODE  Classification Code (Required)
 ;   ETSCSYS  "RXN" hardcoded for RxNorm
 ;   ETSCDT   Code Set Versioning Date in 
 ;            FileMan date Format (default = TODAY)
 ;   .ARY     Output array passed by reference
 ;
 ; Output: 
 ; 
 ;   $$CSDATA   1 if successful (in RxNorm Concept Table #129.2)
 ;              0 if unsuccessful
 ;               
 ;               or
 ;               
 ;              -1 ^ Error Message
 ;              
 ;          
 ;   ARY()
 ; 
 ;
 ;    Lexicon Data
 ;    
 ;       ARY("LEX",1)         IEN ^ STR
 ;       ARY("LEX",2)         Status ^ Effective Date
 ;       ARY("LEX",8)         Deactivated Concept Flag
 ;      
 ;    RXNORM Data
 ;    
 ;       ARY("RXN",1)         Term Type (TTY) ^ Suppression Flag (Suppress) ^ Content View Flag (CVF)
 ;
 ;    Each data element will be in the following format:
 ;      
 ;       ARY(ID,SUB) = DATA
 ;       ARY(ID,SUB,"N") = NAME of the Data Element
 ; 
 ;         Where
 ;
 ;           ID      Identifier, may be:
 ;           
 ;                       "LEX" for Lexicon data
 ;                       "RXN" for RXNORM specific data
 ;                     
 ;           SUB     Numeric Subscript
 ;           
 ;           DATA    This may be:
 ;           
 ;                       A value if it applies and is found
 ;                       Null if it applies but not found
 ;                       N/A if it does not apply
 ;                     
 ;           NAME    This is the common name given to the 
 ;                   data element
 ;       
 N ETSIEN,ETSARY,ETSDATA,ETSX,ETSEFDT,ETSDFLG,ETSSTAT
 ;
 Q:'$L($G(ETSCODE)) "-1^Code missing"
 S:$G(ETSCSYS)="" ETSCSYS="RXN"
 Q:ETSCSYS'="RXN" "-1^Invalid source"
 ;
 I $G(ETSCDT)="" S ETSCDT=$$DT^XLFDT
 ; Make sure Date is a valid FileMan Date
 Q:+$$CHKDATE(ETSCDT)=-1 "-1^Invalid Date"
 ;
 ; Clear array in case older information present
 K ARY
 ;
 ; Retrieve the IEN for the code
 S ETSIEN=$$GETIEN(ETSCODE,1,"")
 Q:ETSIEN="" "-1^RXCUI Not Found"
 ;
 ;Get the DATA
 D GETS^DIQ(129.2,ETSIEN,"**","IE","ETSARY")
 ;
 ; Default Activation Status information, Deactivation Flag
 S ETSSTAT=1,ETSDFLG=""
 ;
 ;Get the Activation Effective Date
 S ETSEFDT=ETSARY(129.2,ETSIEN_",",91,"I")
 ;
 ; If the activation date is newer than the date requested
 ; correct the Activation Date and the Deactivated concept flag 
 S:ETSEFDT>ETSCDT ETSEFDT="",ETSDFLG=1
 ;
 ; Lex Node
 ;
 ; IEN and the Text of the concept
 S ARY("LEX",1)=ETSIEN_U_ETSARY(129.2,ETSIEN_",",1,"E")
 S ARY("LEX",1,"N")="IEN ^ Text (STR)"
 ;
 ; set the activation status
 I ETSEFDT'="" D
 . S ARY("LEX",2)=ETSSTAT_U_ETSEFDT
 . S ARY("LEX",2,"N")="Status ^ Effective Date"
 ;
 ; Status Flag (always active, so always "")
 S ARY("LEX",8)=ETSDFLG
 S ARY("LEX",8,"N")="Deactivated Concept"
 ;
 ; RXN Node
 S ARY("RXN",1)=ETSARY(129.2,ETSIEN_",",.03,"I")_U   ;TTY
 S ARY("RXN",1)=ARY("RXN",1)_ETSARY(129.2,ETSIEN_",",.05,"I")   ;SUPPRESS FLAG
 S ARY("RXN",1)=ARY("RXN",1)_U_ETSARY(129.2,ETSIEN_",",.06,"I")   ;CVF
 S ARY("RXN",1,"N")="Term Type (TTY) ^ Suppression Flag (Suppress) ^ Content View Flag (CVF)"
 ;
 Q 1
 ;
VUICLASS(ETSVUID,ETSSUB) ;Entry point for function $$VUICLASS
 ;Redirecting to ETSRXNTX for processing
 Q $$TAX^ETSRXNTX($G(ETSVUID),$G(ETSSUB),1)
 ;
TAX(ETSVUID,ETSSUB) ; Taxonomy lookup for Clinical Reminders
 ;Redirecting to ETSRXNTX for processing
 Q $$TAX^ETSRXNTX($G(ETSVUID),$G(ETSSUB),0)
 ;
CHKDATE(ETSX) ;Check to see if the date is in proper FileMan format
 ;
 N %DT,X,Y,DTOUT
 S %DT="X",X=ETSX D ^%DT
 S:$G(DTOUT)'="" Y=-1   ;set error condition if timeout occurs
 Q Y
 ;
VUI2RXN(ETSVUID,ETSTTY,ETSSUB) ;Entry point for function $$VUI2RXN
 ;Redirect to ETSRXN1 where the code resides
 Q $$VUI2RXN^ETSRXN1($G(ETSVUID),$G(ETSTTY),$G(ETSSUB))
 ;
NDC2RXN(ETSNDC,ETSSUB) ;Entry point for function $$NDC2RXN
 ;Redirect to ETSRXN1 where the code resides
 Q $$NDC2RXN^ETSRXN1($G(ETSNDC),$G(ETSSUB))
 ;
RXN2OUT(ETSRXCUI,ETSSUB) ;Entry point for function $$RXN2OUT
 ;Redirect to ETSRXN1 where the code resides
 Q $$RXN2OUT^ETSRXN1($G(ETSRXCUI),$G(ETSSUB))
 ;
GETDATA(ETSRXCUI,ETSSUB) ;Entry point for function $$GETDATA
 ;Redirect to ETSRXN1 where the code resides
 Q $$GETDATA^ETSRXN1($G(ETSRXCUI),$G(ETSSUB))
 ;
