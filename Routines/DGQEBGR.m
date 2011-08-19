DGQEBGR ;ALB/RPM - VIC REPLACEMENT BACKGROUND JOB PROCESSOR ; 1/2/2004
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
 Q  ;no direct entry
 ;
EN ;main entry point
 ;
 D PURGE   ;purge completed requests over 7 days old
 D CKHOLD  ;check "H"old status requests and update if needed
 D SNDHL7  ;send queued HL7 messages
 Q
 ;
PURGE ;purge completed VIC requests
 ; This subroutine deletes all VIC REQUEST (#39.6) records and their
 ; associated VIC HL7 TRANSMISSION LOG (#39.7) records for all VIC
 ; requests that fulfill the following conditions:
 ;   1. VIC request Card Print Release Status is not "H"old
 ;   2. VIC request is over 7 days old
 ;   3. Last HL7 transmission status associated with the request is
 ;      an Accept acknowledgment
 ;  
 ;  Supported DBIA#: 10103 - $$FMADD^XLFDT, $$NOW^XLFDT
 ;
 ;  Input: none
 ;
 ;  Output: none
 ;
 N DGSTAT  ;card print release status
 N DGCODT  ;purge cutoff date
 N DGIEN   ;VIC REQUEST IEN
 N DGLIEN  ;VIC HL7 TRANSMISSION LOG IEN
 N DGLOG   ;VIC HL7 TRANSMISSION LOG data array
 N DGRQDT  ;VIC request date
 ;
 S DGCODT=$$FMADD^XLFDT($$NOW^XLFDT(),-$$PRGDAYS())
 F DGSTAT="C","I","P" D
 . S DGRQDT=0
 . F  S DGRQDT=$O(^DGQE(39.6,"ASTAT",DGSTAT,DGRQDT)) Q:('DGRQDT!(DGRQDT>DGCODT))  D
 . . S DGIEN=0
 . . F  S DGIEN=$O(^DGQE(39.6,"ASTAT",DGSTAT,DGRQDT,DGIEN)) Q:'DGIEN  D
 . . . S DGLIEN=$$FINDLST^DGQEHLL(DGIEN)
 . . . I $$GETLOG^DGQEHLL(DGLIEN,.DGLOG),$G(DGLOG("XMSTAT"))="A" D
 . . . . ;
 . . . . ;delete the request and HL7 transmission records
 . . . . I $$DELREQ^DGQEREQ(DGIEN)
 ;
 Q
 ;
 ;
CKHOLD ;check all "H"old status requests for updates
 ; This subroutine evaluates the VIC eligibility for all VIC requests
 ; that have a "H"old Card Print Release Status and updates the Status
 ; if needed.  When a VIC request retains a "H"old Card Print Release
 ; Status for more than the value returned by $$EXPDAYS^DGQEUT2(),
 ; the Card Print Release Status is changed to "C"ancel.
 ;
 ;  Supported DBIA: #10103 - $$FMADD^XLFDT, $$NOW^XLFDT
 ;
 ;  Input: none
 ;
 ;  Output: none
 ;
 N DGCODT  ;cutoff date
 N DGDAT   ;request date
 N DGELG   ;eligibility data array
 N DGIEN   ;VIC REQUEST ien
 N DGREQ   ;VIC REQUEST data array
 N DGSTAT  ;card print release status
 ;
 ;set cutoff date for "H"old request expiration
 S DGCODT=$$FMADD^XLFDT($$NOW^XLFDT(),-$$EXPDAYS)
 S DGDAT=0
 F  S DGDAT=$O(^DGQE(39.6,"ASTAT","H",DGDAT)) Q:'DGDAT  D
 . S DGIEN=0
 . F  S DGIEN=$O(^DGQE(39.6,"ASTAT","H",DGDAT,DGIEN)) Q:'DGIEN  D
 . . ;drop out of block on first failure
 . . ;
 . . S DGSTAT=""
 . . ;
 . . ;get request record
 . . Q:'$$GETREQ^DGQEREQ(DGIEN,.DGREQ)
 . . Q:'$G(DGREQ("DFN"))
 . . ;
 . . ;build eligibility data array
 . . Q:'$$GETELIG^DGQEUT1(DGREQ("DFN"),.DGELG)
 . . S DGELG("ICN")=$$GETICN^DGQEDEMO(DGREQ("DFN"))  ;add ICN to array
 . . ;
 . . ;re-evaluate Card Print Release Status
 . . I $$HOLD^DGQEUT2(.DGELG) D
 . . . ;
 . . . ;set Status to "C"ancel when "H"old request expires
 . . . I $G(DGREQ("REQDT"))>0,DGREQ("REQDT")<DGCODT S DGSTAT="C"
 . . E  D
 . . . S DGSTAT=$S($$VICELIG^DGQEUT2(.DGELG):"P",1:"I")
 . . ;
 . . ;store status and queue HL7 message
 . . I DGSTAT]"" D STOSTAT^DGQEREQ(DGIEN,DGSTAT)
 ;
 Q
 ;
 ;
SNDHL7 ;send queued General Order (ORM~O01) HL7 messages to NCMD
 ; This subroutine transmits a General Order (ORM~O01) HL7 message
 ; to the National Card Management Directory for each entry in the
 ; "XMIT" index of the VIC REQUEST (#39.6) file.
 ;
 ;  Input: none
 ;
 ;  Output: none
 ;
 N DGIEN
 ;
 S DGIEN=0
 F  S DGIEN=$O(^DGQE(39.6,"AXMIT",DGIEN)) Q:'DGIEN  D
 . I $$SND^DGQEHLS(DGIEN)
 Q
 ;
EXPDAYS() ;return VIC request expiration days
 ; This function returns the number of days that a pending VIC request
 ; is retained before being automatically cancelled.  The value is
 ; contained in the PACKAGE ("PKG") entity of the DGQE VIC REQUEST
 ; EXPIRATION parameter.
 ;
 ;  Input:
 ;    none
 ;
 ;  Output:
 ;   Function value - DGQE VIC REQUEST EXPIRATION parameter [DEFAULT=90]
 ;
 N DGVAL
 S DGVAL=$$GET^XPAR("PKG","DGQE VIC REQUEST EXPIRATION",1,"Q")
 Q $S(DGVAL="":90,1:DGVAL)
 ;
PRGDAYS() ;return VIC request purge days
 ; This function returns the number of days that a completed VIC request
 ; is retained before being purged.  The value is contained in the
 ; PACKAGE ("PKG") entity of the DGQE VIC REQUEST PURGE parameter.
 ;
 ;  Input:
 ;    none
 ;
 ;  Output:
 ;   Function value - DGQE VIC REQUEST PURGE parameter [DEFAULT=7]
 ;
 N DGVAL
 S DGVAL=$$GET^XPAR("PKG","DGQE VIC REQUEST PURGE",1,"Q")
 Q $S(DGVAL="":7,1:DGVAL)
