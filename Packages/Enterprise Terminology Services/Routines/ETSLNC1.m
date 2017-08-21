ETSLNC1 ;O-OIFO/FM23 - LOINC APIs 2 ;01/31/2017
 ;;1.0;Enterprise Terminology Services;;Mar 20, 2017;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CHKCODE(ETSCODE) ;Check if LOINC Code exists
 ; Input  -- ETSCODE   LOINC Code
 ; Output ?- $$CHKCODE Response
 ;                     0 - Does Not Exist [Default]
 ;                     1 - Exists
 ;                     -1^<error message> - Error
 N ETSCIEN       ; Loop variable
 ; 
 ;Initialize output
 S ETSCIEN=""
 ; 
 ;Check for missing variable, exit if not defined
 I $G(ETSCODE)="" Q "-1^LOINC Code missing"
 ;
 ;Set-up LOINC IEN to return
 S ETSCIEN=$O(^ETSLNC(129.1,"B",ETSCODE,ETSCIEN))
 ;
 ;If no IEN found for code, return a NULL
 Q:$G(ETSCIEN)="" 0
 I '$G(^ETSLNC(129.1,ETSCIEN,0)) Q "-1^LOINC Code data missing"
 Q 1
GETCODE(ETSIEN) ;Get LOINC Code by IEN
 ; Input  -- ETSIEN   LOINC file IEN
 ; Output ? $$GETCODE
 ;            LOINC Code
 ;               or
 ;            -1^<error message> - Error
 ;
 ;Initialize default output
 N ETSANS
 S ETSANS="-1^LOINC Code not found"
 ;
 ;Check for missing variable, exit if not defined
 Q:$G(ETSIEN)="" "-1^Missing Parameter"
 ;
 ;Set-up LOINC Code to return
 I $D(^ETSLNC(129.1,ETSIEN,0)) S ETSANS=$P($G(^ETSLNC(129.1,ETSIEN,0)),"^",1)
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
 Q:'$D(NAME) "-1^Missing return array"
 ;
 ;Clear array pieces and re-initialize result array
 K NAME("FULLNAME"),NAME("LONGNAME")
 ;
 ;Check for existence of an IEN/Code
 Q:$G(ETSINPT)="" "-1^Missing Code or IEN"
 ;
 ;Set Input Type to default of "C", if not defined
 S:$G(ETSINTY)="" ETSINTY="C"
 I (ETSINTY'="C"),(ETSINTY'="I") Q "-1^Invalid Input Type"
 ; 
 ;Check input for LOINC Code or IEN
 ;Assume the input type is an IEN
 S:ETSINTY="I" ETSCIEN=ETSINPT
 ;if the input type was a code, retrieve the IEN. 
 S:ETSINTY="C" ETSCIEN=$$GETIEN(ETSINPT)
 ; 
 ;Exit if the IEN was either not passed in or not found.
 Q:ETSCIEN="" 0
 ;
 ;Set-up LOINC Name array to return
 S NAME("FULLNAME")=$G(^ETSLNC(129.1,ETSCIEN,80))
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
 I ETSTYP="C" S ETSINPT=$$UP^XLFSTR(ETSINPT),ETSCIEN=$$GETIEN(ETSINPT)
 ; 
 ;Exit if the IEN was either not passed in or not found.
 Q:ETSCIEN="" "-1^LOINC Code not found"
 ;
 ;Exit if IEN, but no data for IEN
 Q:'$D(^ETSLNC(129.1,ETSCIEN,0)) "-1^LOINC data missing"
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
