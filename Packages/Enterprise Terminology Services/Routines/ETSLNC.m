ETSLNC ;O-OIFO/FM23 - LOINC APIs ;01/31/2017
 ;;1.0;Enterprise Terminology Service;**1**;Mar 20, 2017;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;               
HIST(ETSCODE,ETSSYS,ARY) ; Get Activation History for a Code
 ;                      
 ; Input:
 ; 
 ;    ETSCODE   LOINC Code with Check Digit (required)
 ;    ETSSYS    Coding System (required) [hard coded to LNC]
 ;   .ARY       Array, passed by Reference (required)
 ;                      
 ; Output:
 ;    
 ;    $$HIST  Number of Histories Found
 ;              or
 ;            -1 ^ error message
 ;    
 ;    ARY(0) = Number of Activation History
 ;    ARY(0,0) = Code ^ "LNC" ^ "LOINC"
 ;    ARY(<date>,<status>) = Comment
 ;
 ;Note:
 ;  This software was written based upon the current
 ;  standard of a 1 to 1 relationship between the LOINC
 ;  Code and its associated IEN. 
 ;
 N ETSSI,ETSTD,ETSSTAT,ETSDATE,ETSIEN,ETSN,ETSFLG
 N ETSDIEN,ETSDATA
 K ARY
 ;
 ;Validate the input
 Q:'$G(ETSCODE) "-1^Code missing"
 ;
 ; Check for valid LOINC Code and retrieve the IEN
 S ETSIEN=$$CHKCODE^ETSLNC1(ETSCODE)
 Q:(+ETSIEN=-1) ETSIEN
 ;
 S:$G(ETSSYS)="" ETSSYS="LNC"
 Q:ETSSYS'="LNC" "-1^Invalid source"
 ;
 S ETSSI="LNC^LOINC"
 S ETSTD=$$DT^XLFDT
 ;
 ; Loop through Activation History Multiple to get the information.
 S ETSDATE=0
 F  S ETSDATE=$O(^ETSLNC(129.1,ETSIEN,"SS","B",ETSDATE)) Q:'ETSDATE  D
 . S ETSDIEN=0
 . F  S ETSDIEN=$O(^ETSLNC(129.1,ETSIEN,"SS","B",ETSDATE,ETSDIEN)) Q:'ETSDIEN  D
 . . S ETSDATA=$G(^ETSLNC(129.1,ETSIEN,"SS",ETSDIEN,0))
 . . Q:ETSDATA=""   ; validate that the IEN and history exists
 . . S ETSSTAT=$P(ETSDATA,U,2)
 . . I '$D(ARY(ETSDATE,ETSSTAT)) D
 . . . S ARY(0)=+($G(ARY(0)))+1
 . . . S ARY(ETSDATE,ETSSTAT)=""
 ;
 ; Loop through and update the comment portion of the array
 S ETSDATE=0,ETSFLG=0
 F  S ETSDATE=$O(ARY(ETSDATE)) Q:+ETSDATE'>0  D
 . S ETSSTAT=""
 . F  S ETSSTAT=$O(ARY(ETSDATE,ETSSTAT)) Q:'$L(ETSSTAT)  D
 . . I +ETSSTAT>0,ETSFLG'=1 S ARY(ETSDATE,ETSSTAT)="Activated",ETSFLG=1 Q
 . . I +ETSSTAT'>0 S ARY(ETSDATE,ETSSTAT)="Inactivated" Q
 . . I +ETSSTAT>0 D
 . . . S ARY(ETSDATE,ETSSTAT)="Re-activated"
 . . . I $D(ARY(ETSDATE,0)) D
 . . . . S ARY(ETSDATE,ETSSTAT)="Revised" K ARY(ETSDATE,0)
 ;
 ; Count the # entries and update the comments for any future changes with the word Pending.
 K ARY(0)
 S ETSN=0,ETSDATE=""
 F  S ETSDATE=$O(ARY(ETSDATE)) Q:'$L(ETSDATE)  D
 . S ETSSTAT="" F  S ETSSTAT=$O(ARY(ETSDATE,ETSSTAT)) Q:'$L(ETSSTAT)  D
 . . I ETSSTAT?1N,ETSDATE?7N,ETSDATE>ETSTD,$L($G(ARY(ETSDATE,ETSSTAT))) D
 . . . S ARY(ETSDATE,ETSSTAT)=$G(ARY(ETSDATE,ETSSTAT))_" (Pending)"
 . . S ETSN=ETSN+1
 ;
 Q:+ETSN'>0 "-1^No History Found"
 ;
 S ARY(0)=ETSN
 S:ETSN>0&($L(ETSSI))&($L(ETSCODE)) ARY(0,0)=ETSCODE_"^"_ETSSI
 Q ETSN
 ;
PERIOD(ETSCODE,ETSSYS,ARY) ; Get Activation/Inactivation Periods for a Code
 ;
 ; Input:
 ; 
 ;    ETSCODE   LOINC Code with Check digit (required)
 ;    ETSSYS    Coding System (Hardcode to look for LNC, required)
 ;   .ARY       Array, passed by Reference (required)
 ;
 ; Output:
 ; 
 ;   $$PERIOD   Multiple piece "^" delimited string
 ;   
 ;              1  Number of Activation Periods found
 ;              2  NULL
 ;              3  "LNC"
 ;              4  "LOINC"
 ;              5  "Logical Observation Identifier Names and Codes"
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
 ;              2  n/a
 ;               
 ;              3  Variable Pointer IEN;ETSLNC(129.1,
 ;                  
 ;              4  Long Common Name (field #83)
 ;
 ;   ARY(Activation Date,0) = Fully Specified Name (field #80
 ;   
 ; Looks through the Activation History to build the information
 ; 
 N ETSACT,ETSINA,ETSDT,ETSIEN,ETSIDT,ETSPER,ETSFSN
 N ETSCT,ETSLCN,ETSSD,ETSVP,ETSDATE
 ;
 Q:'$L($G(ETSCODE)) "-1^Missing Code"
 ;
 ; Check for valid LOINC Code and retrieve the IEN
 S ETSIEN=$$CHKCODE^ETSLNC1(ETSCODE)
 Q:(+ETSIEN=-1) ETSIEN
 ;
 S:$G(ETSSYS)="" ETSSYS="LNC"
 Q:ETSSYS'="LNC" "-1^Missing/Invalid Coding System"
 ;
 ; Hardcode the Coding system information for now.
 S ETSSD="LNC^LOINC^Logical Observation Identifier Names and Codes"
 K ARY
 ;
 ;Retrieve the entries
 S ETSDIEN=0
 F  S ETSDIEN=$O(^ETSLNC(129.1,ETSIEN,"SS",ETSDIEN)) Q:'ETSDIEN  D
 . S ETSDATA=$G(^ETSLNC(129.1,ETSIEN,"SS",ETSDIEN,0))
 . Q:ETSDATA=""
 . S ETSSTAT=$P(ETSDATA,U,2),ETSDATE=$P(ETSDATA,U)
 . ;If status is active, update active array
 . I ETSSTAT S ETSACT(ETSDATE)="" Q
 . ;Else update inactive array
 . S ETSINA(ETSDATE)=""
 ;
 ;Check for activation periods - if none, quit
 I '$D(ETSACT) D  Q ARY(0)
 .  S ARY(0)="-1^No activation periods found"
 ;
 ;Build the temp array for return to the user
 S ETSDT=""
 F  S ETSDT=$O(ETSACT(ETSDT)) Q:'$L(ETSDT)  D
 . ; Inactive Date
 . S ETSIDT=$O(ETSINA(ETSDT))
 . ; if no future inactivation, check for same day
 . S:ETSIDT="" ETSIDT=$G(ETSINA(ETSDT))
 . ; Fully specified name and Long Common Name
 . S ETSFSN=$G(^ETSLNC(129.1,+ETSIEN,80))
 . S ETSLCN=$G(^ETSLNC(129.1,+ETSIEN,83))
 . ; Kill inactive entry
 . K:ETSIDT?7N ETSINA(ETSIDT)
 . ; Variable Pointer
 . S ETSVP=ETSIEN_";ETSLNC(129.1,"
 . ; Set array
 . S ETSPER(ETSDT)=ETSIDT_"^^"_ETSVP_"^"_ETSLCN
 . S:$L(ETSFSN) ETSPER(ETSDT,0)=ETSFSN
 ;
 ;Count the # of entries
 S (ETSDT,ETSCT)=0 F  S ETSDT=$O(ETSPER(ETSDT)) Q:ETSDT'?7N  S ETSCT=ETSCT+1
 ;
 ;If no entries, exit with error message
 I ETSCT'>0 S ARY(0)="-1^No activation periods found" Q
 ;
 ;Merge the temp array to the returning array and set the 0 node.
 M ARY=ETSPER
 S ARY(0)=ETSCT_U_U_ETSSD
 ;
 ;Exit with the Number of entries
 Q $G(ARY(0))
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
 ;     A 13 piece caret (^) delimited string 
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
 S:$G(ETSSYS)="" ETSSYS="LNC"
 Q:ETSSYS'="LNC" "-1^Invalid Coding System"
 S ETSDATA="^LNC^LNC^LOINC^Logical Observation Identifier Names and Codes^Duke University Medical Center"
 S $P(ETSDATA,U,12)=$P($G(^DD(129.1,0,"VRRV")),U)  ;Get the Current Version
 S $P(ETSDATA,U,13)=$P($G(^DD(129.1,0,"VRRV")),U,2)  ;Get the Current Version implementation date
 S $P(ETSDATA,U,14)=20000    ; Search Max similar to LEX Lookup threshold
 Q ETSDATA
 ;
CSDATA(ETSCODE,ETSCSYS,ETSCDT,ARY) ; Get Information about a Code
 ;
 ; Input:
 ;
 ;   ETSCODE  LOINC Code with Check Digit (Required)
 ;   ETSCSYS  "LNC" hardcoded for LOINC
 ;   ETSCDT   Code Set Versioning Date in 
 ;            FileMan date Format (default = TODAY)
 ;   .ARY     Output array passed by reference
 ;
 ; Output: 
 ; 
 ;   $$CSDATA   1 if successful (in LOINC Table)
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
 ;       ARY("LEX",1)         IEN ^ Preferred Term
 ;       ARY("LEX",2)         Status ^ Effective Date
 ;       ARY("LEX",8)         Deactivated Concept Flag
 ;      
 ;    Coding System Data
 ;    
 ;       ARY("SYS",1)         IEN
 ;       ARY("SYS",2)         Long Common Name
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
 ;                       "SYS" for Coding System data
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
 N ETSIEN,ETSDATA,ETSX,ETSHDATA,ETSHDT,ETSHIEN,ETSHIEN2
 ;
 ; Clear array in case older information present
 K ARY
 ;
 Q:'$L($G(ETSCODE)) "-1^Code missing"
 ;
 ; Check for valid LOINC Code and retrieve the IEN
 S ETSIEN=$$CHKCODE^ETSLNC1(ETSCODE)
 Q:(+ETSIEN=-1) ETSIEN
 ;
 S:$G(ETSCSYS)="" ETSCSYS="LNC"
 Q:ETSCSYS'="LNC" "-1^Invalid source"
 ;
 ; Set default date if no date sent
 I $G(ETSCDT)="" S ETSCDT=$$DT^XLFDT
 ;
 ; Make sure Date is a valid FileMan Date
 Q:+$$CHKDATE(ETSCDT)=-1 "-1^Invalid Date"
 ;
 ; Lex Node
 ;
 ; IEN and Fully specified Name
 S ARY("LEX",1)=ETSIEN_U_$G(^ETSLNC(129.1,ETSIEN,80))
 S ARY("LEX",1,"N")="IEN ^ Fully Specified Name"
 ;
 ; Activation Status information
 S ETSSTAT=0
 ;
 ; Get the activation status based on the date
 ; Locate the correct activation status - if activation occurred on the day sent in use that date
 S ETSHDT=""
 S:$D(^ETSLNC(129.1,ETSIEN,"SS","B",ETSCDT)) ETSHDT=ETSCDT
 ; or get the last activation
 S:'ETSHDT ETSHDT=$O(^ETSLNC(129.1,ETSIEN,"SS","B",ETSCDT),-1)
 ;
 ; Only process if activation history found
 I ETSHDT'="" D
 . S ETSHIEN=$O(^ETSLNC(129.1,ETSIEN,"SS","B",ETSHDT,""))
 . ;
 . ; If node not corrupted
 . I ETSHIEN'="" D
 . . ; get the node data
 . . S ETSHDATA=$G(^ETSLNC(129.1,ETSIEN,"SS",ETSHIEN,0))
 . . ; if data is present, set the 2nd node of LEX
 . . I ETSHDATA'="" D
 . . . S ETSSTAT=$P(ETSHDATA,U,2)
 . . . I ETSSTAT=0 D
 . . . . S ETSHIEN2=$O(^ETSLNC(129.1,ETSIEN,"SS","B",ETSHDT,ETSHIEN))
 . . . . I ETSHIEN2'="" S ETSSTAT=$P(^ETSLNC(129.1,ETSIEN,"SS",ETSHIEN2,0),U,2)
 . . . S ARY("LEX",2)=ETSSTAT_U_ETSHDT
 . . S ARY("LEX",2,"N")="Status ^ Effective Date"
 ;
 ; Status Flag (1 if status INACTIVE, otherwise "")
 S ARY("LEX",8)=$S(ETSSTAT=0:1,1:"")
 S ARY("LEX",8,"N")="Deactivated Concept"
 ;
 ; SYS Node
 S ARY("SYS",1)=ETSIEN
 S ARY("SYS",1,"N")="IEN"
 ;
 ; Long Common Name
 S ARY("SYS",2)=$G(^ETSLNC(129.1,ETSIEN,83))
 S ARY("SYS",2,"N")="Long Common Name"
 ;
 Q 1
 ;
TAX(ETSX,ETSSRC,ETSDT,ETSSUB,ETSVER) ; Taxonomy lookup for Clinical Reminders
 ;Redirecting to ETSLNCTX for processing
 Q $$TAX^ETSLNCTX($G(ETSX),$G(ETSSRC),$G(ETSDT),$G(ETSSUB),$G(ETSVER))
 ;
CHKDATE(ETSX) ;Check to see if the date is in proper FileMan format
 ;
 N %DT,X,Y,DTOUT
 S %DT="X",X=ETSX D ^%DT
 S:$G(DTOUT)'="" Y=-1   ;set error condition if timeout occurs
 Q Y
 ;
CHKCODE(ETSCODE) ;Entry point for routine $$CHKCODE
 ;Check for missing variable, exit if not defined
 I $G(ETSCODE)="" Q "-1^LOINC Code missing"
 ;
 ;Redirect to ETSLNC1 where the code resides
 Q $$CHKCODE^ETSLNC1(ETSCODE)
 ;
GETCODE(ETSIEN) ;Entry point for routine $$GETCODE
 ;Check for missing variable, exit if not defined
 Q:$G(ETSIEN)="" "-1^Missing Parameter"
 ;
 ;Redirect to ETSLNC1 where the code resides
 Q $$GETCODE^ETSLNC1(ETSIEN)
 ;
GETNAME(ETSINPT,ETSINTY,NAME) ;Entry point for routine $$GETNAME
 ;Redirect to ETSLNC1 where the code resides
 Q $$GETNAME^ETSLNC1($G(ETSINPT),$G(ETSINTY),.NAME)
 ;
GETSTAT(ETSINPT,ETSINTY) ;Entry point for routine $$GETSTAT
 ;Redirect to ETSLNC1 where the code resides
 Q $$GETSTAT^ETSLNC1($G(ETSINPT),$G(ETSINTY))
 ;
GETREC(ETSINPT,ETSINTY,ETSSUB) ;Entry point for routine $$GETREC
 ;Redirect to ETSLNC1 where the code resides
 Q $$GETREC^ETSLNC3($G(ETSINPT),$G(ETSINTY),$G(ETSSUB))
 ;
VERSION() ;Entry point for routine $$VERSION
 ;Redirect to ETSLNC1 where the code resides
 Q $$VERSION^ETSLNC2()
 ;
COMLST(ETSCOM,ETSTYP,ETSSUB) ;Entry point for routine $$COMLST
 ;Redirect to ETSLNC2 where the code resides
 Q $$COMLST^ETSLNC2($G(ETSCOM),$G(ETSTYP),$G(ETSSUB))
 ;
DEPLST(ETSSUB) ;Entry point for routine $$DEPLST
 ;Redirect to ETSLNC1 where the code resides
 Q $$DEPLST^ETSLNC2($G(ETSSUB))
 ;
