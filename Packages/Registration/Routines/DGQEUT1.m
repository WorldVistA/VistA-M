DGQEUT1 ;ALB/RPM - VIC REPLACEMENT UTILITIES #1 ; 10/03/05
 ;;5.3;Registration;**571,679,732**;Aug 13, 1993;Build 2
 ;
 ; This routine contains the following VIC Redesign API's:
 ;   INITARR   - initialize data array
 ;   $$GETPAT  - build Patient data array
 ;   $$GETELIG - build Patient Eligibility data array
 ;   $$GETPH   - determine Purple Heart status
 ;   $$GETPOW  - determine Prisoner of War status
 ;   $$FNDPOW  - search for Prisoner of War eligibility code
 ;   $$ISENRPND - is enrollment status pending
 ;
 Q  ;no direct entry
 ;
INITARR(DGVIC) ;Procedure used to initialize VIC data array nodes.
 ;
 ;  Input:
 ;   none
 ;
 ; Output:
 ;   DGVIC - array of VIC data (pass by reference)
 ;
 N DGSUB ;array subscript
 ;
 ;init patient identifier nodes
 S DGVIC("DFN")=""
 F DGSUB="NAME","SSN","DOB","LAST","FIRST","MIDDLE","SUFFIX","PREFIX" D
 . S DGVIC(DGSUB)=""
 ;
 ;init address nodes
 F DGSUB="STREET1","STREET2","STREET3","CITY","STATE","ZIP","ADRTYPE" D
 . S DGVIC(DGSUB)=""
 ;
 ;init vic eligibility nodes
 F DGSUB="SC","ENRSTAT","ELIGSTAT","MST","COMBVET","POW","PH" D
 . S DGVIC(DGSUB)=""
 ;
 ;init facility nodes
 F DGSUB="FACNUM","FACNAME","VISN" D
 . S DGVIC(DGSUB)=""
 ;
 ;init card print release status node
 S DGVIC("STAT")=""
 ;
 ;init document type node
 S DGVIC("DOCTYPE")="VIC"
 ;
 Q
 ;
 ;
GETPAT(DGDFN,DGPAT) ;build Patient object
 ; This function retrieves patient demographic data needed to produce
 ; a Veteran ID Card and returns the data in an array format.
 ;
 ;  Supported Reference:
 ;    DBIA #10103: $$FMTE^XLFDT
 ;
 ;  Input:
 ;    DGDFN - (required) pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;    Function value - returns 1 on success, 0 on failure
 ;    DGPAT - array of patient demographics, pass by reference
 ;            Array subscripts are:
 ;             "DFN"     - Pointer to patient in PATIENT (#2) file
 ;             "NAME"    - Patient Full Name
 ;             "SSN"     - Social Security Number
 ;             "DOB"     - Date of Birth (mmddyyyy)
 ;             "LAST"    - Family Name from name components
 ;             "FIRST"   - Given Name from name components
 ;             "MIDDLE"  - Middle Name from name components
 ;             "SUFFIX"  - Suffix from name components
 ;             "PREFIX"  - Prefix from name components
 ;             "STREET1" - Line 1 of mailing address
 ;             "STREET2" - Line 2 of mailing address
 ;             "STREET3" - Line 3 of mailing address
 ;             "CITY"    - Mailing address city
 ;             "STATE"   - Mailing address state
 ;             "ZIP"     - Mailing address ZIP code
 ;             "ADRTYPE" - Mailing address type
 ;                            [0:unable to determine,1:permanent,
 ;                             2:temporary,3:confidential,4:facility]
 ;             "ICN"     - Integration Control Number
 ;             "FACNUM"  - Local Station number
 ;             "FACNAME" - Local Facility name
 ;             "VISN"    - Local Facility's VISN
 ;
 N DGRSLT
 ;
 S DGRSLT=0
 ;
 I $G(DGDFN)>0,$D(^DPT(DGDFN,0)) D  ;drop out of block on first failure
 . ;
 . ;get name, ssn, dob, dfn
 . Q:'$$GETIDS^DGQEDEMO(DGDFN,.DGPAT)
 . ;
 . ;format Date of Birth to mmddyyyy
 . S DGPAT("DOB")=$TR($$FMTE^XLFDT(DGPAT("DOB"),"5Z"),"/","")
 . ;
 . ;get name components
 . Q:'$$GETNAMC^DGQEDEMO(DGDFN,.DGPAT)
 . ;
 . ;get mailing address
 . Q:'$$GETADDR^DGQEDEMO(DGDFN,.DGPAT)
 . ;
 . ;get national ICN
 . S DGPAT("ICN")=$$GETICN^DGQEDEMO(DGDFN)
 . ;
 . ;get facility info
 . D GETSITE^DGQEDEMO(.DGPAT)
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
 ;
GETELIG(DGDFN,DGELG) ;build Patient Eligibility object
 ; This function retrieves patient data needed to determine the
 ; patient's VIC eligibility and returns the data in an array format.
 ;
 ;  Supported References:
 ;    DBIA #10061: ELIG^VADPT
 ;    DBIA  #2716: $$GETSTAT^DGMSTAPI
 ;    DBIA  #4156: $$CVEDT^DGCV
 ;
 ;  Input:
 ;    DGDFN - (required) pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;    Function value - returns 1 on success, 0 on failure
 ;    DGELG - array of eligibility indicators, pass by reference
 ;            Array subscripts are:
 ;             "SC"       - Service Connected indicator
 ;             "ENRSTAT"  - Enrollment Status
 ;             "ELIGSTAT" - Eligibility Status
 ;             "MST"      - Military Sexual Trauma Status
 ;             "COMBVET"  - Combat Veteran Status
 ;             "POW"      - Prisoner of War Indicator
 ;             "PH"       - Purple Heart Indicator
 ;
 N DFN     ;input parameter to ELIG^VADPT
 N DGRSLT  ;function value
 N VAEL    ;VADPT return array
 N VAERR   ;VADPT error value
 ;
 S DGRSLT=0
 ;
 I $G(DGDFN)>0,$D(^DPT(DGDFN,0)) D
 . ;
 . ;get Eligibility Status and Service Connection
 . S DFN=DGDFN
 . D ELIG^VADPT
 . S DGELG("ELIGSTAT")=$P($G(VAEL(8)),U)
 . S DGELG("SC")=+$G(VAEL(3))
 . ;
 . ;get current Enrollment Status
 . S DGELG("ENRSTAT")=$$STATUS^DGENA(DGDFN)
 . ;
 . ;get MST Status
 . S DGELG("MST")=$P($$GETSTAT^DGMSTAPI(DGDFN),U,2)
 . ;
 . ;get Combat Veteran Status
 . S DGELG("COMBVET")=+$$CVEDT^DGCV(DGDFN)
 . ;
 . ;get Purple Heart Indicator
 . S DGELG("PH")=$$GETPH(DGDFN)
 . ;
 . ;get POW indicator
 . S DGELG("POW")=$S($$ISENRPND(DGELG("ENRSTAT")):"P",1:$$FNDPOW(.VAEL))
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
 ;
GETPH(DGDFN) ;get purple heart indicator
 ;This function retrieves the Current PH Indicator and Current PH
 ;Status and returns a single interpretation value.
 ;
 ;  Supported References:
 ;    DBIA #10061: SVC^VADPT
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - returns "Y" to print indicator on VIC; "N" to
 ;                    not print indicator on VIC; "P" to hold request
 ;                    until confirmation; "" when Registration interview
 ;                    question is unanswered.
 ;
 N DFN       ;input parameter to SVC^VADPT
 N DGPHIND   ;current purple heart indicator
 N DGPHSTAT  ;current purple heart status
 N DGRSLT    ;function value
 N VAERR     ;VADPT error value
 N VASV      ;VADPT return array
 ;
 S DGRSLT=""
 ;
 I $G(DGDFN)>0,$D(^DPT(DGDFN)) D
 . ;
 . ;get purple heart indicator and status
 . S DFN=DGDFN
 . D SVC^VADPT
 . S DGPHIND=$G(VASV(9))
 . S DGPHSTAT=$P($G(VASV(9,1)),U,2)
 . ;
 . ;interpret status
 . I DGPHIND=1 S DGRSLT=$S(DGPHSTAT="CONFIRMED":"Y",1:"P")
 . I DGPHIND=0 S DGRSLT="N"
 ;
 Q DGRSLT
 ;
GETPOW(DGDFN) ;get POW indicator
 ;This function retrieves the eligibility codes for a given patient and
 ;returns the POW indicator.
 ;
 ;  Supported References:
 ;    DBIA #10061: ELIG^VADPT
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - returns results from call to $$FNDPOW
 ;
 N DFN
 N VAEL    ;VADPT result array
 N VAERR   ;VADPT error message
 ;
 S DFN=$G(DGDFN)
 D ELIG^VADPT
 ;
 Q $$FNDPOW(.VAEL)
 ;
FNDPOW(DGEL) ;find POW eligibility code
 ;This function searches a list of eligibility codes for PRISONER OF
 ;WAR and returns the boolean result.
 ;
 ;  Input:
 ;    DGEL - result array from call to ELIG^VADPT
 ;
 ;  Output:
 ;   Function value - returns "Y" when PRISONER OF WAR found;
 ;                    otherwise "N"
 ;
 N DGEC    ;eligibility code number
 N DGRSLT  ;function value
 ;
 S DGRSLT="N"
 ;
 ;Check primary eligibility code
 I $P($G(DGEL(1)),U,2)="PRISONER OF WAR" Q "Y"
 ;
 S DGEC=0
 F  S DGEC=$O(DGEL(1,DGEC)) Q:'DGEC  D  Q:DGRSLT="Y"
 . I $P(DGEL(1,DGEC),U,2)="PRISONER OF WAR" S DGRSLT="Y"
 ;
 Q DGRSLT
 ;
ISENRPND(DGST) ;is veteran's enrollment status pending?
 ;
 ;  Input:
 ;    DGST - pointer to enrollment status in ENROLLMENT STATUS (#27.15)
 ;           file.
 ;
 ;  Output:
 ;   Function value - returns 1 when status is pending; otherwise 0
 ;
 S DGST=+$G(DGST)
 Q $S('DGST:1,DGST=1:1,DGST=15:1,DGST=16:1,DGST=17:1,DGST=18:1,1:0)
