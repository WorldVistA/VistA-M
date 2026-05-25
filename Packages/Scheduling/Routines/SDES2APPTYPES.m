SDES2APPTYPES ;ALB/TJB,AGW - VISTA SCHEDULING SDES2 GET APPOINTMENT TYPES RPC in APPOINTMENT TYPES FILE 409.1 ;July 2, 2025
 ;;5.3;Scheduling;**864,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to $$GET1^DIQ is supported by IA #2056
 ; ; Reference to ^DPT( is supported by IAs #7030,7029,1476,10035
 ;
 Q  ;No Direct Call
 ;
 ; The parameter list for this RPC must be kept in sync.
 ; If you need to add or remove a parameter, ensure that the Remote Procedure File #8994 definition is also updated.
 ;
GETAPPTYPES(RETURNJSON,SDCONTEXT,SDPARAM) ;Entry point
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; SDPARAM("APP TYPE STATUS")="A|I|B"  Appointmet Type Status (optional)
 ;                             A - Active Only, I - Inactive only, B - Both Active and Inactive
 ;                             Default is Active only
 ;
 ;RETURN PARMETER:
 ;
 ; Output:
 ;  Successful Return:
 ;    RETURNJSON = Returns the list of Appointment Types from File 409.1 in JSON formatted string.
 ;    Otherwise, JSON Errors will be returned for any invalid/missing parameters.
 ;
 N ERRORS,RETURN   ;temp data storage for input validation error
 N SDAPPTSTATUS
 ;
 K RETURNJSON ;always kill the return json array
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("AppointmentTypes",1)="" D BUILDJSON^SDES2JSON(.RETURNJSON,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 D INITVAR(.SDPARAM,.SDAPPTSTATUS)
 D VALINPUTPARAM(.ERRORS,SDAPPTSTATUS)
 I $D(ERRORS) S ERRORS("AppointmentTypes",1)="" D BUILDJSON^SDES2JSON(.RETURNJSON,.ERRORS) Q
 ;
 D APPTYPES(.RETURN,SDAPPTSTATUS) ; Return appropriate entries from APPOINTMENT TYPES FILE 409.1
 D BUILDJSON^SDES2JSON(.RETURNJSON,.RETURN)
 ;
 Q
 ;
INITVAR(PARAM,STATUS) ;
 S STATUS=$S($G(PARAM("APP TYPE STATUS"))'="":PARAM("APP TYPE STATUS"),1:"A")
 Q
 ;
VALINPUTPARAM(ERRORS,APPTSTATUS) ;
 N T1
 I APPTSTATUS="" D ERRLOG^SDES2JSON(.ERRORS,52,"Appointment Type status missing")
 I APPTSTATUS'="" S T1=","_APPTSTATUS_","
 I ",A,B,I,"']T1 D ERRLOG^SDES2JSON(.ERRORS,52,"Appointment Type status incorrect. Valid values are A, B, I")
 Q
 ;
GETAPTYDFN(RETURNJSON,SDCONTEXT,SDPARAM) ;Entry point
 ; SDCONTEXT is the same as above
 ; SDPARAM("DFN")=DFN     Patient (File #2) DFN used to show Appointment Types for this Patient (required)
 ;
 ;RETURN PARMETER:
 ; Output:
 ;  Successful Return:
 ;    RETURNJSON = Returns the list of Appointment Types from File 409.1 in JSON formatted string.
 ;    Otherwise, JSON Errors will be returned for any invalid/missing parameters.
 ;
 N ERRORS,RETURN,VRETURN
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("AppointmentTypes",1)="" D BUILDJSON^SDES2JSON(.RETURNJSON,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 D VALFILEIEN^SDES2VALUTIL(.VRETURN,.ERRORS,2,$G(SDPARAM("DFN")),1,,1,2) ; Validate the Patient (file #2) DFN is correct
 I $D(ERRORS) S ERRORS("AppointmentTypes",1)="" D BUILDJSON^SDES2JSON(.RETURNJSON,.ERRORS) Q
 ;
 D DFNAPPTYPS(.RETURN,$G(SDPARAM("DFN"))) ; Return the active APPOINTMENT TYPES FILE 409.1 entries which the Patient DFN is eligible
 D BUILDJSON^SDES2JSON(.RETURNJSON,.RETURN)
 Q
 ;
APPTYPES(RET,APPTSTAT) ; EP for SDEC APPTYPES
 ;APPTYPES(RET,DFN)  external parameter tag is in SDEC
 ; Return the different appointment types
 N APTINACT,APTYIEN,APTYNAME,COUNT
 S COUNT=0
 S APTYIEN="" F  S APTYIEN=$O(^SD(409.1,APTYIEN)) Q:'APTYIEN  D
 . S APTINACT=$$GET1^DIQ(409.1,APTYIEN,3,"I")
 . I APPTSTAT="A" Q:APTINACT  ; Quit if the INACTIVE [0;3] Field 3 is set and we want only Active APP TYPES
 . I (APPTSTAT'="A")!(APPTSTAT'="B") Q:'APTINACT  ; Quit if we only want the INACTIVE APP TYPES
 . S COUNT=COUNT+1
 . S RET("AppointmentTypes",COUNT,"AppTypeIEN")=APTYIEN
 . S RET("AppointmentTypes",COUNT,"AppTypeName")=$$GET1^DIQ(409.1,APTYIEN,.01,"E")
 ;
 Q
 ;
DFNAPPTYPS(RET,DFN) ; Return all the eligible active APPTYPES for a specific Patient DFN
 N APTYDATA,APTYIEN,COUNT,SDEC,DUALELIG,DEFAULTELIG
 N VAEL D ELIG^VADPT ; Get Patient Eligibility
 S SDEC=$$GET1^DIQ(8,+VAEL(1),4,"I")
 S COUNT=0
 S APTYIEN=0 F  S APTYIEN=$O(^SD(409.1,APTYIEN)) Q:'APTYIEN  D
 . Q:$$GET1^DIQ(409.1,APTYIEN,3,"I")  ; Quit if the INACTIVE [0;3] Field 3 is set
 . S DUALELIG=$$GET1^DIQ(409.1,APTYIEN,5,"I")
 . S DEFAULTELIG=$$GET1^DIQ(409.1,APTYIEN,6,"I")
 . I $S(SDEC["Y":1,1:DUALELIG),$S('DEFAULTELIG:1,$D(VAEL(1,+DEFAULTELIG)):1,+VAEL(1)=DEFAULTELIG:1,1:0) D
 .. S COUNT=COUNT+1
 .. S RET("AppointmentTypes",COUNT,"AppTypeIEN")=APTYIEN
 .. S RET("AppointmentTypes",COUNT,"AppTypeName")=$$GET1^DIQ(409.1,APTYIEN,.01) ; $P(APTYDATA,U)
 ;
 Q
