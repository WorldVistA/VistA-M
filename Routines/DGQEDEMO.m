DGQEDEMO ;ALB/RPM - VIC REPLACEMENT DEMOGRAPHICS GETTER API'S ; 9/19/03
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
 ; This routine contains the following patient demographic data
 ; retrieval procedures and functions:
 ;   $$GETICN   - retrieves patient's national ICN
 ;   $$GETIDS   - retrieves patient identifiers
 ;   $$GETNAMEC - retrieves patient's name components
 ;   $$GETADDR  - retrieves patient's mailing address
 ;   GETSITE    - retrieves local station name and number
 ;
 Q  ;no direct entry
 ;
GETICN(DGDFN) ;retrieve patient national ICN
 ; This function retrieves the ICN for a patient if the ICN is
 ; nationally assigned.
 ;
 ;  Supported References:
 ;    DBIA #2701: $$GETICN^MPIF001, $$IFLOCAL^MPIF001
 ;
 ;  Input:
 ;    DGDFN - (required) pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - returns National ICN on success, 0 on failure
 ;
 N DGICN
 ;
 S DGICN=0
 I $G(DGDFN)>0,$D(^DPT(DGDFN,0)) D
 . ;
 . S DGICN=$$GETICN^MPIF001(DGDFN)
 . S DGICN=$S(DGICN>0:$P(DGICN,"V",1),1:0)
 . Q:'DGICN
 . ;
 . I $$IFLOCAL^MPIF001(DGDFN) S DGICN=0
 ;
 Q DGICN
 ;
 ;
GETIDS(DGDFN,DGIDS) ;retrieve patient identifiers
 ; This function retrieves identifying information for a patient
 ; in the PATIENT (#2) file and places it in an array format.
 ;
 ; Supported Reference:
 ;   DBIA #10035: Direct global reference of patient's zero
 ;                node in the PATIENT (#2) file
 ;
 ;  Input:
 ;   DGDFN - (required) ien of patient in PATIENT (#2) file
 ;
 ; Output:
 ;  Function value - returns 1 on success, 0 on failure
 ;   DGIDS - output array containing the patient identifying information,
 ;           on success, pass by reference.
 ;            Array subscripts are:
 ;             "DFN"  - ien PATIENT (#2) file
 ;             "NAME" - patient name
 ;             "SEX"  - patient gender ("M"/"F")
 ;             "SSN"  - patient Social Security Number
 ;             "DOB"  - patient date of birth (FM format)
 ;
 N DGNODE
 N DGRSLT
 ;
 S DGRSLT=0
 ;
 I $G(DGDFN)>0,$D(^DPT(DGDFN,0)) D
 .
 . ;get zero node of patient record
 . S DGNODE=$G(^DPT(DGDFN,0))
 . ;
 . S DGIDS("DFN")=DGDFN
 . S DGIDS("NAME")=$P(DGNODE,U)
 . S DGIDS("SEX")=$P(DGNODE,U,2)
 . S DGIDS("DOB")=$P(DGNODE,U,3)
 . S DGIDS("SSN")=$P(DGNODE,U,9)
 . S DGRSLT=1  ;success
 ;
 Q DGRSLT
 ;
 ;
GETNAMC(DGDFN,DGCOMP) ;retrieve name components 
 ; This function retrieves a given patient's name components from the
 ; NAME COMPONENT (#20) file and places the components in an array
 ; format.  The supported API $$HLNAME^XLFNAME is used to retrieve the
 ; name components, since it is the only supported Name Standardization
 ; api that both reads from the NAME COMPONENT (#20) file and returns a
 ; result that can be easily parsed.
 ;
 ;  Supported Reference:
 ;    DBIA #3065: $$HLNAME^XLFNAME
 ;
 ;  Input:
 ;    DGDFN - (required) pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;    DGCOMP - name component array on success, pass by reference
 ;             Array subscripts are:
 ;             "LAST"   - Family (last) name
 ;             "FIRST"  - Given (first) name
 ;             "MIDDLE" - Middle name
 ;             "SUFFIX" - Name suffix
 ;             "PREFIX" - Name prefix
 ;
 N DGSUB     ;component array subscripts
 N DGFLD     ;component field position
 N DGNAMSTR  ;XLFNAME name component string
 N DGPAR     ;XLFNAME input parameter array
 N DGRSLT    ;function value
 ;
 S DGRSLT=0
 ;
 I $G(DGDFN)>0,$D(^DPT(DGDFN,0)) D
 . S DGFLD=0
 . S DGPAR("FILE")=2,DGPAR("FIELD")=".01",DGPAR("IENS")=DGDFN_","
 . S DGNAMSTR=$$HLNAME^XLFNAME(.DGPAR,,U)
 . F DGSUB="LAST","FIRST","MIDDLE","SUFFIX","PREFIX" D
 . . S DGFLD=DGFLD+1
 . . S DGCOMP(DGSUB)=$P(DGNAMSTR,U,DGFLD)
 . S DGRSLT=1  ;success
 ;
 Q DGRSLT
 ;
 ;
GETADDR(DGDFN,DGMADR,DGAERR) ;retrieve patient mailing address
 ; This funtion selects the mailing address for a patient from the
 ; available HIPAA confidential address, temporary address, permanent
 ; address.  If the BAD ADDRESS INDICATOR (#.121) of the PATIENT file
 ; is set, then the facility address will be selected.  The selected
 ; address is placed in an array format.
 ;
 ;  Supported Reference:
 ;    DBIA  #4080: $$BADADR^DGUTL3
 ;
 ;  Input:
 ;    DGDFN - (required) pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;     DGMADR - array of mailing address fields on success, pass by
 ;              reference
 ;              Array subscripts are:
 ;               "STREET1" - line 1 of street address
 ;               "STREET2" - line 2 of street address
 ;               "STREET3" - line 3 of street address
 ;               "CITY"    - city
 ;               "STATE"   - state
 ;               "ZIP"     - zip code
 ;               "ADRTYPE" - address type
 ;                           [1:perm.; 2:temp.; 3:conf.; 4:facility]
 ;     DGAERR - error message text defined on failure, pass by reference
 ;
 N DGADDR    ;address array in ADD^VAPDT format
 N DGRSLT    ;function value
 N DGTYPE    ;address type
 ;
 S DGRSLT=0
 S DGTYPE=0
 ;
 I $G(DGDFN)>0,$D(^DPT(DGDFN,0)) D  ;exit block on first error
 . ;
 . ;select between permanent, temporary and confidential addresses
 . S DGTYPE=$$GETPTCA^DGQEUT3(DGDFN,.DGADDR)
 . ;
 . ;get facility address when no address, foreign address, or 
 . ;bad address indicator is set
 . I 'DGTYPE!($$ISFRGN^DGQEUT3(.DGADDR))!(+$$BADADR^DGUTL3(DGDFN)>0) D
 . . S DGTYPE=4  ;facility address
 . . I '$$GETFADD^DGQEUT3(.DGADDR) D
 . . . S DGAERR="Unable to retrieve facility address."
 . Q:$D(DGAERR)
 . ;
 . ;load mailing address array with retrieved address
 . S DGMADR("STREET1")=$G(DGADDR(1))
 . S DGMADR("STREET2")=$G(DGADDR(2))
 . S DGMADR("STREET3")=$G(DGADDR(3))
 . S DGMADR("CITY")=$G(DGADDR(4))
 . S DGMADR("STATE")=$G(DGADDR(5))
 . S DGMADR("ZIP")=$G(DGADDR(6))
 . S DGMADR("ADRTYPE")=DGTYPE
 . S DGRSLT=1  ;success
 ;
 Q DGRSLT
 ;
 ;
GETSITE(DGFAC) ;retrieve the local site station number and name
 ; This procedure retrieves the local site's name and station number
 ; and places them in an array format.  A valid DUZ(2) is used to
 ; determine the station number and name.  $$SITE^VASITE() is used
 ; when DUZ(2) is undefined or invalid.
 ;
 ;  Supported References:
 ;    DBIA  #2171: $$STA^XUAF4, $$NAME^XUAF4
 ;    DBIA #10112: $$SITE^VASITE
 ;
 ;  Input:
 ;    none
 ;
 ;  Output:
 ;    DGFAC - array of facility information
 ;            Array subscripts are:
 ;             "FACNUM"  - station number
 ;             "FACNAME" - facility name
 ;
 N DGERR
 N DGIEN
 N DGINST  ;pointer to INSTITUTION (#4) file
 ;
 I $G(DUZ(2))>0,$D(^DIC(4,DUZ(2))) D
 . S DGINST=DUZ(2)
 E  D
 . S DGINST=$P($$SITE^VASITE(),U)
 ;
 S DGFAC("FACNUM")=$$STA^XUAF4(DGINST)
 S DGFAC("FACNAME")=$$NAME^XUAF4(DGINST)
 S DGFAC("VISN")=$$GETVISN(DGINST)
 ;
 Q
 ;
GETVISN(DGINST) ;retrieve VISN for an institution
 ; This function checks for a "VISN" entry in the ASSOCIATIONS
 ; (#14) multiple field in the INSTITUTION (#4) file for a given
 ; institution. If a "VISN" entry exists, then the PARENT OF ASSOCIATION
 ; (#1) subfield value is returned.
 ;
 ;  DBIA: #10090 - Read entire INSTITUTION (#4) file with FileMan
 ;
 ;  Input:
 ;    DGINST - pointer to INSTITUTION (#4) file
 ;
 ;  Output:
 ;   Function value - VISN name on success, "" on failure
 ;
 N DGERR   ;FM error array
 N DGVISN  ;function value
 ;
 S DGVISN=""
 I $G(DGINST),$D(^DIC(4,DGINST)) D
 . S DGIEN=$$FIND1^DIC(4.014,","_DGINST_",","","VISN","B","","DGERR")
 . Q:('DGIEN!($D(DGERR)))
 . ;
 . S DGVISN=$$GET1^DIQ(4.014,DGIEN_","_DGINST_",",1,"E","","DGERR")
 ;
 Q DGVISN
