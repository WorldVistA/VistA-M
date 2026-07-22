SDES2GETNEXTSLOT ;ALB/JAS - SDES2 GET NEXT CLINIC SLOT ; Apr 6, 2026
 ;;5.3;Scheduling;**942**;Aug 13, 1993;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 ; The SDCONTEXT array is controlled by the Acheron application and its fields are
 ; needed for the storage of the required auditing information.
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; Note: SDINPUT("CLINIC IEN",1) is required. Additional clinics can be specified, but are optional
 ; SDINPUT("CLINIC IEN",1)=IEN1   The clinic IEN from HOSPITAL LOCATION (#44) to list appointments (required)
 ; SDINPUT("CLINIC IEN",2)=IEN2   (optional)
 ; SDINPUT("CLINIC IEN",3)=IEN3   (optional)
 ; SDINPUT("SEARCH LIMIT")=90     How many days into the future to search if availability is not being found (optional)
 ;                                If not passed will default to each clinic's MAX # DAYS FOR FUTURE BOOKING (#2002) field
 ;                                from the HOSPITAL LOCATION (#44) file.
 Q
 ;
GETNEXTSLOT(JSONRETURN,SDCONTEXT,SDINPUT) ;
 ; This RPC returns the first available appointment slot for a list of clinics in JSON format.
 ;
 N %DT,DIERR,ERRORS,I,RETURN
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("nextAvailableTimeSlot",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 D VALPARAM(.ERRORS,.SDINPUT)
 I $D(ERRORS) S ERRORS("nextAvailableTimeSlot",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 ;
 D BUILDDATA(.RETURN,.SDINPUT)
 I '$D(RETURN("nextAvailableTimeSlot")) S RETURN("nextAvailableTimeSlot",1)=""
 ;
 D BUILDJSON^SDES2JSON(.JSONRETURN,.RETURN)
 Q
 ;
VALPARAM(ERRORS,SDINPUT) ; Validate the clinics in SDINPUT
 I $D(SDINPUT("CLINIC IEN"))'>1 D ERRLOG^SDES2JSON(.ERRORS,18) Q  ; no clinic array to build
 Q
 ;
BUILDDATA(RETURN,SDINPUT) ;retrieve clinic availability data
 N CLINICIEN,ENDDATE,ERRORS,DAYSINFUTURE,INDEX,RESOURCEIEN,SLOTARRAY,STARTDATE
 S INDEX=0,SLOTARRAY=$NA(^TMP($J,"CLNCAVAIL"))
 K @SLOTARRAY
 ;
 F  S INDEX=$O(SDINPUT("CLINIC IEN",INDEX)) Q:'INDEX  D
 . S CLINICIEN=SDINPUT("CLINIC IEN",INDEX)
 . ;
 . ; Check the clinic IEN to make sure it's valid
 . D VALCLINIEN^SDES2VAL44(.ERRORS,CLINICIEN,1,0) I $D(ERRORS) D  Q
 . . S RETURN("Error",INDEX)="ClinicIEN "_CLINICIEN_": "_ERRORS("Error",1) K ERRORS
 . ;
 . ; Retrieve the resource IEN for the clinic
 . S RESOURCEIEN=$$GETRES^SDES2UTIL1(CLINICIEN,1)
 . I RESOURCEIEN="" D ERRLOG^SDES2JSON(.ERRORS,70) D  Q  ;invalid clinic resource id
 . . S RETURN("Error",INDEX)="ClinicIEN "_CLINICIEN_": "_ERRORS("Error",1) K ERRORS
 . ;
 . ; Initialize search criteria
 . S STARTDATE=$$NOW^XLFDT()
 . S DAYSINFUTURE=$S(+$G(SDINPUT("SEARCH LIMIT"))>0:SDINPUT("SEARCH LIMIT"),+$$GET1^DIQ(44,CLINICIEN,2002):$$GET1^DIQ(44,CLINICIEN,2002),1:99)
 . S ENDDATE=$$FMADD^XLFDT(DT,DAYSINFUTURE)_".999999"
 . ;
 . ; Search for clinic slots and build return array
 . D GETSLOTS^SDEC57(SLOTARRAY,RESOURCEIEN,$P(STARTDATE,"."),$P(ENDDATE,"."))
 . D BUILDRET(.RETURN,CLINICIEN,SLOTARRAY,STARTDATE,ENDDATE,INDEX)
 . K @SLOTARRAY
 Q
 ;
BUILDRET(RETURN,CLINICIEN,SLOTARRAY,STARTDATE,ENDDATE,INDEX) ;
 N COUNT,FOUND,FMDATE,FMTIME,HASAVAIL,ISODATE,OPENSLOTS,SLOTSTARTDTTM,SLOTENDDTTM,SDSLOTS,SDENDDTTM,SDSTARTDTTM,TOTALFND
 S (FOUND,HASAVAIL)=0
 ;
 ; Adjust STARTDATE for clinic's time zone
 S ISODATE=$$FMTISO^SDAMUTDT(STARTDATE)
 S STARTDATE=$$ISOTFM^SDAMUTDT(ISODATE,CLINICIEN)
 ;
 ; If no results, set return for no availability
 I $O(@SLOTARRAY@(""))="" D  Q
 . S RETURN("nextAvailableTimeSlot",INDEX,"clinicIEN")=CLINICIEN
 . S RETURN("nextAvailableTimeSlot",INDEX,"hasAvailability")=HASAVAIL
 ;
 S TOTALFND=@SLOTARRAY@("CNT")
 F COUNT=1:1:TOTALFND D  Q:FOUND
 . S SLOTSTARTDTTM=$P(@SLOTARRAY@(COUNT),U,2) ;start date
 . S SLOTENDDTTM=$P(@SLOTARRAY@(COUNT),U,3) ;end date
 . I (SLOTSTARTDTTM<STARTDATE)!(SLOTSTARTDTTM>ENDDATE) Q
 . S OPENSLOTS=+$P(@SLOTARRAY@(COUNT),U,4) ;open slots available
 . Q:'OPENSLOTS
 . ;
 . ; Availability has been found, set return with availability data
 . S HASAVAIL=1,FOUND=1
 . I $P(SLOTSTARTDTTM,".",2)=""!($P(SLOTSTARTDTTM,".",2)="00") S $P(SLOTSTARTDTTM,".",2)="0001"
 . ;
 . ; Adjust start date/time if time is greater than 24, so it will pass $$FMTISO^SDAMUTDT
 . I $E($P(SLOTSTARTDTTM,".",2),1,2)=24,($E($P(SLOTSTARTDTTM,".",2),3,6))>0 D
 . . N FMDATE,FMTIME
 . . S FMDATE=$P(SLOTSTARTDTTM,".",1),FMTIME=$P(SLOTSTARTDTTM,".",2)
 . . S FMDATE=$$FMADD^XLFDT(FMDATE,1)
 . . S SLOTSTARTDTTM=FMDATE_".00"_$E(FMTIME,3,6)
 . ;
 . S SDSTARTDTTM=$$FMTISO^SDAMUTDT(SLOTSTARTDTTM,CLINICIEN)
 . S SDENDDTTM=$$FMTISO^SDAMUTDT(SLOTENDDTTM,CLINICIEN)
 . S RETURN("nextAvailableTimeSlot",INDEX,"clinicIEN")=CLINICIEN
 . S RETURN("nextAvailableTimeSlot",INDEX,"hasAvailability")=HASAVAIL
 . S RETURN("nextAvailableTimeSlot",INDEX,"beginDateTime")=SDSTARTDTTM
 . S RETURN("nextAvailableTimeSlot",INDEX,"endDateTime")=SDENDDTTM
 ;
 ; If no availability found, set return for no availability
 I 'FOUND D
 . S RETURN("nextAvailableTimeSlot",INDEX,"clinicIEN")=CLINICIEN
 . S RETURN("nextAvailableTimeSlot",INDEX,"hasAvailability")=HASAVAIL
 Q
