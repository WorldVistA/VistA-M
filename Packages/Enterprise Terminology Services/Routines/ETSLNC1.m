ETSLNC1 ;O-OIFO/FM23 - LOINC APIs 2 ;01/31/2017
 ;;1.0;Enterprise Terminology Service;**1**;Mar 20, 2017;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CHKCODE(ETSLOINC) ;Check if LOINC Code exists
 ;
 ;Input
 ;   ETSLOINC:   LOINC Code with Check digit in a nnnnn-n format (i.e. 12345-6, 1-8, etc.)
 ;
 ;Output
 ;   $$CHKCODE:   IEN of the Valid Code
 ;                    or
 ;                -1^error message
 ;
 N ETSCKDGT,ETSCODE,ETSIEN
 ;
 ;Validate that the LOINC Code is in the correct format
 I ETSLOINC'?1.5N1"-"1N Q "-1^Invalid LOINC Code"
 ;
 ;Look for the LOINC code in the database
 S ETSCKDGT=$P(ETSLOINC,"-",2),ETSCODE=$P(ETSLOINC,"-")
 I '$D(^ETSLNC(129.1,"B",ETSCODE)) Q "-1^LOINC Code not found"
 ;
 ; Validate that the Code is defined in the Database
 S ETSIEN=$O(^ETSLNC(129.1,"B",ETSCODE,""))
 S ETSDATA=$G(^ETSLNC(129.1,ETSIEN,0))
 I ETSDATA="" Q "-1^LOINC Code data missing"
 ;
 ;Validate the Check Digit
 I $P(ETSDATA,U,15)'=ETSCKDGT Q "-1^Invalid Check digit"
 ;
 ;Code is valid, return the IEN
 Q ETSIEN
 ;
GETCODE(ETSIEN) ;Get LOINC Code by IEN
 ; Input  -- ETSIEN   LOINC file IEN
 ; Output -- $$GETCODE
 ;            LOINC Code with check digit
 ;               or
 ;            -1^<error message> - Error
 ;
 ;Initialize default output
 N ETSANS,ETSDATA
 S ETSANS="-1^LOINC Code not found"
 ;
 ;Check for missing variable, exit if not defined
 Q:$G(ETSIEN)="" "-1^Missing Parameter"
 ;
 ;Set-up LOINC Code to return
 S ETSDATA=$G(^ETSLNC(129.1,ETSIEN,0))
 I ETSDATA'="" S ETSANS=$P(ETSDATA,U,1)_"-"_$P(ETSDATA,U,15)
 Q $G(ETSANS)
 ;
GETNAME(ETSINPT,ETSINTY,NAME) ;Get LOINC Name Array by Code or IEN
 ; Input  -- ETSINPT   LOINC Code or IEN
 ;           ETSINTY   Input Type  (Optional- Default "C")
 ;                     "C"=LOINC Code
 ;                     "I"=LOINC IEN
 ;
 ; Output -- NAME LOINC Name Array subscripts: (array will be cleared upon entry)
 ;                  ("FULLNAME")=Fully Specified Name field (#80)
 ;                  ("SHORTNAME")=ShortName field (#81)
 ;                  ("LONGNAME")=Long Common Name field (#83)
 ;                         or
 ;           $$GETNAME    1 for success and results found
 ;                        0 no results found
 ;                         or
 ;                       -1^<error message>
 ;
 N ETSCIEN,ETSCODE
 ;
 ;Check for result array , exit if not defined
 Q:'$D(NAME) "-1^Missing Return Array"
 ;
 ;Clear array pieces and re-initialize result array
 K NAME("FULLNAME"),NAME("LONGNAME"),NAME("SHORTNAME")
 ;
 ;Check for existence of an IEN/Code
 Q:$G(ETSINPT)="" "-1^Missing Code or IEN"
 ;
 ;Set Input Type to default of "C", if not defined
 S:$G(ETSINTY)="" ETSINTY="C"
 I (ETSINTY'="C"),(ETSINTY'="I") Q "-1^Invalid Input Type"
 ; 
 S ETSCIEN=""  ; initialize the IEN.
 ;
 ;Check input for LOINC Code or IEN
 ;Assume the input type is an IEN
 I ETSINTY="I" D  Q:(ETSCIEN="") "-1^Invalid LOINC IEN"
 . S:$D(^ETSLNC(129.1,ETSINPT,0)) ETSCIEN=ETSINPT
 ;if the input type was a code, retrieve the IEN. 
 I ETSINTY="C" D  Q:(+ETSCIEN=-1) ETSCIEN
 . S ETSCIEN=$$CHKCODE(ETSINPT)
 ; 
 ;Set-up LOINC Name array to return
 S NAME("FULLNAME")=$G(^ETSLNC(129.1,ETSCIEN,80))
 S NAME("SHORTNAME")=$G(^ETSLNC(129.1,ETSCIEN,81))
 S NAME("LONGNAME")=$G(^ETSLNC(129.1,ETSCIEN,83))
 Q 1
 ;
GETIEN(ETSCODE) ;Retrieve the IEN if given a code.
 Q:$G(ETSCODE)="" ""   ;Return "" if code not sent in
 Q $O(^ETSLNC(129.1,"B",ETSCODE,""))  ;No duplicates so return code
 ;
GETSTAT(ETSINPT,ETSTYP) ; Retrieves the current Status.
 ;
 ;Input
 ;   ETSINPT:   LOINC Code or LOINC IEN
 ;   ETSTYP:    Input Type, either C for Code (default) or I for IEN
 ;
 ;Output
 ;   $$GETSTAT:   Current Status (Internal format^External Format)
 ;                    or
 ;                -1^error code
 ;
 N ETSCIEN,ETSCODE,ETSSTATI,ETSANS
 ;
 ;Check for missing variable, exit if not defined
 Q:$G(ETSINPT)="" "-1^Missing LOINC Code"
 ;
 ;Set Input Type to default of "C", if not defined
 S:$G(ETSTYP)="" ETSTYP="C"
 S ETSTYP=$$UP^XLFSTR(ETSTYP)
 I (ETSTYP'="C"),(ETSTYP'="I") Q "-1^Invalid Input Type"
 ; 
 ;Check input for LOINC Code or IEN
 ;Assume the input type is an IEN
 S:ETSTYP="I" ETSCIEN=ETSINPT
 ;
 ;if the input type was a code, retrieve the IEN. 
 I ETSTYP="C" S ETSINPT=$$UP^XLFSTR(ETSINPT),ETSCIEN=$$CHKCODE(ETSINPT)
 ; 
 ;Exit if the IEN was either not passed in or not found.
 Q:(+ETSCIEN=-1) ETSCIEN
 ;
 ;Exit if IEN, but no data for IEN
 Q:'$D(^ETSLNC(129.1,ETSCIEN,0)) "-1^LOINC IEN Not Found"
 ;
 ;Get LOINC Status
 S ETSSTATI=$P($G(^ETSLNC(129.1,ETSCIEN,4)),"^",1)
 ;
 ;Set-up LOINC Status to return
 ;return Active if no status found (per field definition)
 Q:ETSSTATI="" "^ACTIVE"
 ;
 ;return status (Internal^external) if found
 S ETSANS=ETSSTATI_"^"_$$EXTERNAL^DILFD(129.1,20,"",ETSSTATI)
 Q $G(ETSANS)
 ;
