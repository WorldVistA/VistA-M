SDES2REACTTCLIN ;ALB/TJB,MGD,JDJ,TAW - VISTA SCHEDULING REACTIVATE CLINIC RPC in HOSPITAL LOCATION FILE 44 ;AUG 25 2025
 ;;5.3;Scheduling;**861,864,877,898,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to $$GET1^DIQ is supported by IA #2056
 ; Reference to TURNON^DIAUTL is supported by IA #4397
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 Q  ;No Direct Call
 ;
 ; The parameter list for this RPC must be kept in sync.
 ; If you need to add or remove a parameter, ensure that the Remote Procedure File #8994 definition is also updated.
 ;
REACTIVATECLIN(RETURNJSON,SDCONTEXT,SDPARAM) ;Entry point for SDES2 REACTIVATE CLINIC RPC
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; SDPARAM("CLINIC IEN")=CLINIC IEN     IEN of the clinic in file 44 - Hospital location (required)
 ; SDPARAM("REACTIVATION DATE")=DATE    ISO DATE to reactivate the clinic (required)
 ;
 ;RETURN PARMETER:
 ;
 ; Output:
 ;  Successful Return:
 ;    RETURNJSON = Returns the reactivated clinic IEN along with the successful message in JSON formatted string.
 ;    Otherwise, JSON Errors will be returned for any invalid/missing parameters.
 ;
 N ERRORS,RETURNERROR,RETURN   ;temp data storage for input validation error
 N ISREACTIVATED,REACTIVATIONDATE,SDCLINICIEN
 N CLIN,IEN,PROVDUZ  ;leaking from other API calls
 ;
 ;
 K RETURNJSON ;always kill the return json array
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("ReactivateClinic",1)="" D BUILDJSON^SDES2JSON(.RETURNJSON,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 D INITVAR
 D VALCLNIENREACTDT(.ERRORS,SDCLINICIEN,REACTIVATIONDATE)
 I $O(ERRORS("Error",""))'="" D SETERRORRETURN(.ERRORS,.RETURNERROR,.RETURNJSON) Q
 D TURNON^DIAUTL(44,2506,"y") ;turn on auditing for REACTIVATE DATE field in the HOSPITAL LOCATION (#44) file
 S REACTIVATIONDATE=$$ISOTFM^SDAMUTDT(REACTIVATIONDATE,SDCLINICIEN)
 S ISREACTIVATED=$$REACTIVATE(.RETURN,SDCLINICIEN,REACTIVATIONDATE)
 I $O(ERRORS("Error",""))'="" D SETERRORRETURN(.ERRORS,.RETURNERROR,.RETURNJSON) Q  ;error occured during filing
 I ISREACTIVATED D UPDATECLNRES(SDCLINICIEN,REACTIVATIONDATE)
 D BUILDJSON^SDES2JSON(.RETURNJSON,.RETURN)
 Q
 ;
INITVAR ;Initialize input parameter
 S SDCLINICIEN=$G(SDPARAM("CLINIC IEN"))
 S REACTIVATIONDATE=$G(SDPARAM("REACTIVATION DATE"))
 Q
 ;
REACTIVATE(RETURN,SDCLINICIEN,REACTIVATIONDATE) ;Reactivate Clinic
 N SDERR,SDFDA,SDCLNNAME,ISFILED
 S ISFILED=0
 ;Only update the Reactivate Date field if the reacivation passed in is different
 I $$GET1^DIQ(44,SDCLINICIEN,2506)'=$P(REACTIVATIONDATE,".") D
 . S SDCLNNAME=$$GET1^DIQ(44,SDCLINICIEN,.01)
 . I $E(SDCLNNAME,1,2)="ZZ" S SDFDA(44,SDCLINICIEN_",",.01)=$$TRIM^XLFSTR($E($$GET1^DIQ(44,SDCLINICIEN,.01),3,32),"L")
 . S SDFDA(44,SDCLINICIEN_",",2506)=$P(REACTIVATIONDATE,".")
 . D FILE^DIE("","SDFDA","SDERR")
 . I $G(SDERR) S ISFILED=0 D ERRLOG^SDES2JSON(.ERRORS,239) Q
 . S RETURN("ReactivateClinic","IEN")=SDCLINICIEN
 . S RETURN("ReactivateClinic","SuccessMessage")="Clinic is successfully reactivated effective "_$TR($$FMTE^XLFDT(REACTIVATIONDATE,"5DF")," ","0")
 . S ISFILED=1
 Q ISFILED
 ;
UPDATECLNRES(SDCLINICIEN,REACTIVATIONDATE) ;Update REACTIVATED DATE/TIME and REACTIVATED BY USER in SDEC RESOURCE File #409.831
 N SDRESFDA,SDCLINRES
 S SDCLINRES=$$GETRES^SDES2UTIL1(SDCLINICIEN,1)
 Q:SDCLINRES=""
 S SDRESFDA(409.831,SDCLINRES_",",.025)=$P(REACTIVATIONDATE,".")
 S SDRESFDA(409.831,SDCLINRES_",",.026)=DUZ
 D FILE^DIE("","SDRESFDA")
 Q
 ;
VALCLNIENREACTDT(ERRORS,CLINICIEN,REACTIVATIONDATE) ;validate Clinic IEN and Reactivation Date (they need to go hand in hand together)
 N INACTDT,REACTDT,SDCLINNAME,SDCLNNAME
 I CLINICIEN="" D ERRLOG^SDES2JSON(.ERRORS,18)
 I CLINICIEN'="" D
 . I '$D(^SC(CLINICIEN,0)) D ERRLOG^SDES2JSON(.ERRORS,19) Q
 . I $$GET1^DIQ(44,CLINICIEN,2,"I")'="C" D ERRLOG^SDES2JSON(.ERRORS,236) Q
 ;
 S SDCLNNAME=$$GET1^DIQ(44,CLINICIEN,.01)
 ; Check to see if there is a Clinic with the same name without the "ZZ"
 I $E(SDCLNNAME,1,2)="ZZ" D
 . N SDNEWNAME,TEMPIEN S TEMPIEN=""
 . S SDNEWNAME=$$TRIM^XLFSTR($E(SDCLNNAME,3,32),"L") ; Take care of ZZ{space}NAME
 . S TEMPIEN=$O(^SC("B",SDNEWNAME,TEMPIEN))
 . I TEMPIEN'="" D ERRLOG^SDES2JSON(.ERRORS,51,"Clinic Name without leading ZZ is the same as active Clinic")
 ;
 S REACTIVATIONDATE=$$ISOTFM^SDAMUTDT(REACTIVATIONDATE,CLINICIEN)
 I REACTIVATIONDATE="" D ERRLOG^SDES2JSON(.ERRORS,240) Q
 I REACTIVATIONDATE'="",REACTIVATIONDATE<1 D ERRLOG^SDES2JSON(.ERRORS,238) Q
 S INACTDT=$$GET1^DIQ(44,CLINICIEN,2505,"I")
 S REACTDT=$$GET1^DIQ(44,CLINICIEN,2506,"I")
 I INACTDT="" D ERRLOG^SDES2JSON(.ERRORS,52,"Clinic is not inactive") Q
 I REACTIVATIONDATE<=INACTDT D ERRLOG^SDES2JSON(.ERRORS,237,"Inactivation date "_$TR($$FMTE^XLFDT(INACTDT,"5DF")," ","0")) Q
 I REACTIVATIONDATE<DT D ERRLOG^SDES2JSON(.ERRORS,52,"Reactivation date must be greater than "_$TR($$FMTE^XLFDT(DT,"5DF")," ","0")) Q
 I REACTDT'="",REACTDT>INACTDT,REACTDT=REACTIVATIONDATE D  Q
 . D ERRLOG^SDES2JSON(.ERRORS,52,"Clinic already reactivated effective "_$TR($$FMTE^XLFDT(REACTDT,"5DF")," ","0"))
 Q
 ;
SETERRORRETURN(ERRORS,RETURNERROR,RETURNJSON) ;
 M RETURNERROR=ERRORS
 D SETEMPTYOBJECT(.RETURNERROR) ;set the return object into null if an error occur
 D BUILDJSON^SDES2JSON(.RETURNJSON,.RETURNERROR)
 Q
 ;
SETEMPTYOBJECT(RETURNERROR) ;set the return object into null if an error occur
 S RETURNERROR("ReactivateClinic","IEN")=""
 S RETURNERROR("ReactivateClinic","SuccessMessage")=""
 Q
 ;
