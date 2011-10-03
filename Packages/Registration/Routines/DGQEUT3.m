DGQEUT3 ;ALB/RPM - VIC REPLACEMENT UTILITIES #3 ; 12/22/03
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
 ; This routine contains the following address selection and retrieval
 ; utilities:
 ;  $$GETFADD - retrieves facility address
 ;  $$GETPTCA - retrieves a confidential, temporary or permanent address
 ;  $$ISCONF  - determines if confidential address is active
 ;  $$ISTEMP  - determines if temporary address active
 ;  $$ISFRGN  - determines if selected address is a foreign address
 ;  $$GETABRV - converts pointer to STATE(#5) file to state abbreviation
 ;
 Q  ;no direct entry
 ;
GETFADD(DGFADD) ;retrieve facility address
 ; This function retrieves a facility's address from the INSTITUTION(#4)
 ; file and places the address in an array mapped to be compatible with
 ; the ADD^VADPT call.  A valid DUZ(2) is used to determine the
 ; pointer to the INSTITUTION(#4) file, otherwise, $$SITE^VASITE() is
 ; used.
 ;
 ;  Supported References:
 ;    DBIA  #2171: $$PADD^XUAF4
 ;    DBIA #10112: $$SITE^VASITE
 ;
 ;  Input:
 ;    none
 ;
 ;  Output:
 ;    DGFADD - facility address array, pass by reference
 ;             Array subscripts are:
 ;               "1" - Street Line 1
 ;               "2" - null
 ;               "3" - null
 ;               "4" - City
 ;               "5" - State (2 character abbreviation)
 ;               "6" - Zip
 ;   Function value - address type on success [4:facility]; 0 on failure
 ;
 N DGADR   ;return value of $$PADD api
 N DGINST  ;INSTITUTION (#4) file pointer
 N DGTYPE  ;function value address type
 ;
 S DGTYPE=0
 ;
 I $G(DUZ(2))>0 S DGINST=DUZ(2)
 E  S DGINST=$P($$SITE^VASITE(),U,1)
 ;
 I $D(^DIC(4,DGINST)) D
 . S DGADR=$$PADD^XUAF4(DGINST)
 . ;
 . S DGFADD(1)=$P(DGADR,U,1)   ;street 1
 . S DGFADD(2)=""              ;placeholder
 . S DGFADD(3)=""              ;placeholder
 . S DGFADD(4)=$P(DGADR,U,2)   ;city
 . S DGFADD(5)=$P(DGADR,U,3)   ;state
 . S DGFADD(6)=$P(DGADR,U,4)   ;zip
 . ;
 . ;success
 . S DGTYPE=4
 ;
 Q DGTYPE
 ;
GETPTCA(DGDFN,DGADDR) ;select confidential, temporary or permanent address
 ; This function uses ADD^VADPT to retrieve a patient address array and
 ; selects the address to be used for mailing.  The address selection
 ; priority is as follows:
 ;   1) Active "ELIGIBILITY/ENROLLMENT"-category Confidential Address
 ;   2) Active Temporary Address
 ;   3) Permanent Address
 ; The selected address is returned in an array format.
 ;
 ;  Supported Reference:
 ;    DBIA #10061: ADD^VADPT
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;    DGADDR - selected address array, pass by reference
 ;             Array subscripts are:
 ;              "1" - Street Line 1
 ;              "2" - Street Line 2
 ;              "3" - Street Line 3
 ;              "4" - City
 ;              "5" - State (abbreviation)
 ;              "6" - Zip
 ;              "7" - County
 ;    Function value - set of codes for address type [1:permanent,
 ;                     2:temporary,3:confidential]
 ;
 N DFN      ;input parameter for ADD^VADPT
 N DGI      ;generic counter
 N DGLINE1  ;array node of Street Line 1
 N DGSUB    ;return array subscript
 N DGTYPE   ;function value - address type
 N VAERR    ;error return from VADPT
 N VAPA     ;result array from VADPT
 ;
 S DGTYPE=0
 ;
 I $G(DGDFN)>0,$D(^DPT(DGDFN,0)) D
 . S DFN=DGDFN
 . D ADD^VADPT
 . ;
 . ;determine address type
 . S DGTYPE=$S($$ISCONF(.VAPA,"ELIGIBILITY/ENROLLMENT"):3,$$ISTEMP(.VAPA):2,1:1)
 . ;
 . ;copy VADPT array into return array
 . S DGLINE1=$S(DGTYPE=3:13,1:1)
 . S DGSUB=0
 . F DGI=DGLINE1:1:DGLINE1+6 D
 . . S DGSUB=DGSUB+1
 . . I DGSUB=5 D  ;get state abbreviation
 . . . S DGADDR(DGSUB)=$$GETABRV($P(VAPA(DGI),U))
 . . E  D
 . . . S DGADDR(DGSUB)=$P(VAPA(DGI),U)
 ;
 Q DGTYPE
 ;
 ;
ISCONF(DGADD,DGCAT) ;is confidential address active?
 ; This function accepts an address array returned from a call to 
 ; ADD^VADPT and determines if an active confidential address exists
 ; for the given category.
 ;
 ;  DGADD - VAPA address array from ADD^VADPT
 ;  DGCAT - confidential address category
 ;
 ;  Output:
 ;   Function value - 1:confidential address active,0:confidential
 ;                    address inactive
 ;
 N DGI     ;generic counter
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 I $G(DGADD(12)),$G(DGCAT)]"" D
 . S DGI=0
 . F  S DGI=$O(DGADD(22,DGI)) Q:'DGI  D  Q:DGRSLT
 . . Q:$P($G(DGADD(22,DGI)),U,2)'=DGCAT
 . . Q:$P($G(DGADD(22,DGI)),U,3)'="Y"
 . . S DGRSLT=1
 ;
 Q DGRSLT
 ;
 ;
ISTEMP(DGADD) ;is temporary address active?
 ; This function determines if an active temporary address exists.
 ;
 ;  Input:
 ;    DGADD - address array in VADPT VAPA format
 ;
 ;  Output:
 ;   Function value - 1 on active temp address, 0 on failure
 ;
 Q $G(DGADD(9))>0
 ;
 ; 
ISFRGN(DGADD) ;is selected address foreign?
 ; This function determines if the address selected by VADPT is a
 ; foreign address.
 ;
 ;  Input:
 ;    DGADD - address aray in VADPT VAPA format
 ;
 ;  Output:
 ;   Function value - returns 1 on foreign address, 0 not a foreign
 ;                    address
 ;
 Q $G(DGADD(7))="999"
 ;
 ;
GETABRV(DGIEN) ;retrieve state abbreviation
 ; This function retrieves the abbreviation for a state from the STAT
 ; (#5) file for a given IEN.
 ;
 ;  Supported Reference:
 ;    DBIA #10056: FileMan Read access to STATE (#5) file
 ;
 ;  Input:
 ;    DGIEN - pointer to a state in the STATE (#5) file
 ;
 ;  Output:
 ;   Function value - state abbreviation on success, "" on failure
 ;
 N DGABRV  ;function value
 N DGERR   ;FM error value
 ;
 S DGABRV=""
 ;
 I $G(DGIEN)>0,$D(^DIC(5,DGIEN,0)) D
 . S DGABRV=$$GET1^DIQ(5,DGIEN_",",1,"","","DGERR")
 . S:$D(DGERR) DGABRV=""
 ;
 Q DGABRV
