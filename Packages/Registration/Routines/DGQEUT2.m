DGQEUT2 ;ALB/RPM - VIC REPLACEMENT UTILITIES #2 ; 3/13/06 11:12am
 ;;5.3;Registration;**571,641,679**;Aug 13, 1993
 ;
 ; This routine contains the following VIC Redesign API's:
 ;   CPRSTAT   - determine Card Print Release Status
 ;   $$PENDDT  - checks for pending requests and returns request date
 ;   $$REQFLD  - checks for required fields
 ;   $$HOLD    - checks for pending ICN and/or Enrollment
 ;   $$VICELIG - determines applicant's VIC eligibility
 ;
 Q  ;no direct entry
 ;
 ;
CPRSTAT(DGVIC) ;determine card print release status
 ; This procedure is used to determine Card Print Release Status from
 ; the data contained in the input array (DGVIC).  Once determined, the
 ; status and remarks are placed into the VIC data array.
 ;
 ;  Input:
 ;   DGVIC - VIC data array (pass by reference)
 ;
 ; Output: None
 ;
 N DGERR
 ;
 D  ;drop out of DO block when DGVIC("STAT") is known
 . ;
 . ;check if DFN is valid
 . ;set card print release status="C"ancel if not valid
 . I '$D(^DPT(+$G(DGVIC("DFN")),0)) D
 . . S DGVIC("STAT")="C"
 . . S DGVIC("REMARKS")="Unable to find veteran in the database"
 . Q:DGVIC("STAT")]""
 . ;
 . ;check for required fields
 . ;set card print release status="C"ancel if req field is missing
 . I '$$REQFLD(.DGVIC,.DGERR) D
 . . S DGVIC("STAT")="C"
 . . S DGVIC("REMARKS")=$G(DGERR)
 . Q:DGVIC("STAT")]""
 . ;
 . ;check for pending conditions
 . ;set card print release status="H"old if pending conditions exist
 . I $$HOLD(.DGVIC,.DGERR) D
 . . S DGVIC("STAT")="H"
 . . S DGVIC("REMARKS")=$G(DGERR)
 . Q:DGVIC("STAT")]""
 . ;
 . ;check if pt is eligible for VIC
 . ;set card print release status="P"rint if eligible, else "I"neligible
 . I $$VICELIG(.DGVIC) S DGVIC("STAT")="P"
 . E  D
 . . S DGVIC("STAT")="I"
 . . S DGVIC("REMARKS")="Veteran does not meet VIC eligibility requirements."
 ;
 Q
 ;
 ;
PENDDT(DGDFN) ;check for pending request date
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - FM format request date on success, 0 on failure
 ;
 N DGDAT   ;function value
 N DGRIEN  ;VIC REQUEST pointer
 N DGREQ   ;array of request data
 ;
 S DGDAT=0
 ;
 ;get last request
 S DGRIEN=$$FINDLST^DGQEREQ(DGDFN)
 I DGRIEN D
 . Q:'$$GETREQ^DGQEREQ(DGRIEN,.DGREQ)
 . ;
 . ;check Card Print Release Status
 . I $G(DGREQ("CPRSTAT"))="H" S DGDAT=+$G(DGREQ("REQDT"))
 ;
 Q DGDAT
 ;
 ;
REQFLD(DGVIC,DGERR) ;required field check
 ; This function is used to check for required fields in the VIC data
 ; array.
 ;
 ;  Input:
 ;   DGVIC - VIC data array (pass by reference)
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure.
 ;   DGERR - error msg returned on failure
 ;
 N DGTYPE ;mailing address type
 N DGSUB  ;array subscript
 ;
 D  ;quit DO block on first error
 . ;
 . ;check for required SSN
 . I $G(DGVIC("SSN"))="" S DGERR="Unable to determine veteran's Social Security Number"
 . Q:$D(DGERR)
 . ;
 . ;check for required DOB to include month and day
 . I +$G(DGVIC("DOB"))>0 D
 . . I +$E(DGVIC("DOB"),1,2)<1!(+$E(DGVIC("DOB"),3,4)<1) S DGERR="Unable to determine veteran's complete Date of Birth"
 . E  S DGERR="Unable to determine veteran's Date of Birth"
 . Q:$D(DGERR)
 . ;
 . ;check for required name components
 . F DGSUB="NAME","LAST" D  Q:$D(DGERR)
 . . I $G(DGVIC(DGSUB))="" S DGERR="Unable to determine veteran's Name"
 . . ;
 . . ;prevent submission of incomplete patient merges
 . . I DGSUB="NAME",DGVIC(DGSUB)["MERGING INTO" S DGERR="Incomplete patient record merge"
 . Q:$D(DGERR)
 . ;
 . ;check for address selection type
 . I '$G(DGVIC("ADRTYPE")) S DGERR="Unable to determine a mailing address"
 . Q:$D(DGERR)
 . ;
 . ;check for required pt address components
 . F DGSUB="STREET1","CITY","STATE","ZIP" D  Q:$D(DGERR)
 . . I $G(DGVIC(DGSUB))="" D
 . . . S DGTYPE=$S(DGVIC("ADRTYPE")=1:"permanent",DGVIC("ADRTYPE")=2:"temporary",DGVIC("ADRTYPE")=3:"confidential",1:"facility")
 . . . S DGERR="Unable to determine the "_DGSUB_" field of the "_DGTYPE_" mailing address"
 . Q:$D(DGERR)
 . ;
 . ;check for required VIC eligibility factors
 . F DGSUB="SC" D  Q:$D(DGERR)
 . . I $G(DGVIC(DGSUB))="" S DGERR="Unable to determine veteran's Service Connected Indicator"
 . Q:$D(DGERR)
 . ;
 . ;check for required facility data elements
 . F DGSUB="FACNUM","FACNAME","VISN" D  Q:$D(DGERR)
 . . I $G(DGVIC(DGSUB))="" S DGERR="Unable to determine a source facility"
 ;
 Q $S($D(DGERR):0,1:1)
 ;
 ;
HOLD(DGVIC,DGMSG) ;check for pending ICN, Enrollment Status, Purple Heart
 ; This function checks for a pending ICN, Enrollment Status, and/or
 ; Purple Heart confirmation and builds the appropriate message text
 ; when a pending condition exists.
 ;
 ;  Input:
 ;    DGVIC - VIC data array, pass by reference
 ;      Array subscripts are:
 ;          "ICN" - integration control number
 ;                  Note: Must be in format returned by $$GETICN^DGQEDEMO
 ;      "ENRSTAT" - enrollment status
 ;                  Note: Must be in format returned by $$STATUS^DGENA 
 ;           "PH" - purple heart status
 ;                  Note: Must be in format returned by $$GETPH^DGQEUT1
 ;
 ;  Output:
 ;   Function value - returns 1 when a pending condition exists;
 ;                    otherwise, returns 0
 ;
 ;    DGMSG - Message text returned when function value=1 listing 
 ;            pending data items; pass by reference
 ;
 N DGI      ;generic index
 N DGENRST  ;enrollment status value
 N DGCNT    ;pending item count
 N DGRSLT   ;function value
 ;
 S DGRSLT=0
 S DGCNT=0
 S DGENRST=+$G(DGVIC("ENRSTAT"))
 ;
 ;is national ICN missing
 I '+$G(DGVIC("ICN")) D
 . S DGRSLT=1
 . S DGCNT=DGCNT+1
 . S DGMSG(DGCNT)="Veteran does not have a National ICN"
 ;
 ;is enrollment status
 I $$ISENRPND^DGQEUT1(DGENRST) D
 . S DGRSLT=1
 . S DGCNT=DGCNT+1
 . S DGMSG(DGCNT)="Veteran is pending verification"
 ;
 ;is purple heart pending
 I $G(DGVIC("PH"))="P" D
 . S DGRSLT=1
 . S DGCNT=DGCNT+1
 . S DGMSG(DGCNT)="Veteran's Purple Heart status is pending confirmation"
 ;
 ;format message text
 I DGCNT D
 . S DGMSG=""
 . F DGI=1:1:DGCNT S DGMSG=DGMSG_$S(DGI>1&(DGI<DGCNT):", ",DGI>1&(DGI=DGCNT):" and ",1:"")_DGMSG(DGI)
 . S DGMSG=DGMSG_"."
 ;
 Q DGRSLT
 ;
 ;
VICELIG(DGELG) ;is applicant eligible for a Veteran ID Card?
 ; This function determines if an applicant is eligible for a Veteran
 ; Identification Card (VIC).
 ;
 ;  Input:
 ;    DGELG - eligibility data object array
 ;
 ; Output:
 ;  Function Value - returns 1 if the applicant is eligible for VIC,
 ;                   0 if not eligible 
 ;
 N DGRSLT ;function result
 ;
 ;set default, not eligible
 S DGRSLT=0
 ;
 D  ;apply VIC eligibilty rules
 . I (DGELG("ENRSTAT")=2)!(DGELG("ENRSTAT")=21) S DGRSLT=1 Q
 . ;
 . I (DGELG("ENRSTAT")=7)!(DGELG("ENRSTAT")=19)!(DGELG("ENRSTAT")=20) D  Q:DGRSLT
 . . Q:DGELG("ELIGSTAT")'="V"
 . . I DGELG("MST")="Y" S DGRSLT=1 Q
 . . I DGELG("SC")=1 S DGRSLT=1 Q
 . ;
 . I (DGELG("ENRSTAT")=11)!(DGELG("ENRSTAT")=12)!(DGELG("ENRSTAT")=13)!(DGELG("ENRSTAT")=14)!(DGELG("ENRSTAT")=22) D  Q:DGRSLT
 . . Q:DGELG("ELIGSTAT")'="V"
 . . I DGELG("COMBVET")=1 S DGRSLT=1 Q
 . . I DGELG("SC")=1 S DGRSLT=1 Q
 . . I DGELG("MST")="Y" S DGRSLT=1 Q
 ;
 Q DGRSLT
