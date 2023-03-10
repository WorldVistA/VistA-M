SDESREACTVTCLIN ;ALB/RRM - VISTA SCHEDULING REACTIVATE CLINIC RPC in HOSPITAL LOCATION FILE 44 ;July 21, 2022
 ;;5.3;Scheduling;**823**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to $$GET1^DIQ is supported by IA #2056
 ; Reference to TURNON^DIAUTL is supported by IA #4397
 ;
 Q  ;No Direct Call
 ;
 ; The parameter list for this RPC must be kept in sync.
 ; If you need to add or remove a parameter, ensure that the Remote Procedure File #8994 definition is also updated.
 ;
REACTIVATECLIN(RETURNJSON,SDCLINICIEN,REACTIVATIONDATE,SDEAS) ;Entry point for SDES REACTIVATE CLINIC RPC
 ; Input:
 ;   SDCLINICIEN [Required]      - The CLINIC IEN from the HOSPITAL LOCATION FILE #44
 ;   REACTIVATIONDATE [Required] - The Clinic reactivation date in ISO FORMAT. It must have been previously inactivated.
 ;   SDEAS       [optional]      - The Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
 ;
 ; Output:
 ;  Successful Return:
 ;    RETURNJSON = Returns the reactivated clinic IEN along with the successful message in JSON formatted string.
 ;    Otherwise, JSON Errors will be returned for any invalid/missing parameters.
 ;
 N ERRORS,RETURNERROR,RETURN   ;temp data storage for input validation error
 N ISREACTIVATED
 ;
 K RETURNJSON ;always kill the return json array
 ;
 D INITVAR
 D VALCLNIENREACTDT(.ERRORS,SDCLINICIEN,REACTIVATIONDATE)
 D VALIDATEEAS^SDESINPUTVALUTL(.ERRORS,SDEAS)
 I $O(ERRORS("Error",""))'="" D SETERRORRETURN(.ERRORS,.RETURNERROR,.RETURNJSON) Q
 D TURNON^DIAUTL(44,2506,"y") ;turn on auditing for REACTIVATE DATE field in the HOSPITAL LOCATION (#44) file
 S REACTIVATIONDATE=$$ISOTFM^SDAMUTDT(REACTIVATIONDATE,SDCLINICIEN)
 S ISREACTIVATED=$$REACTIVATE(.RETURN,SDCLINICIEN,REACTIVATIONDATE)
 I $O(ERRORS("Error",""))'="" D SETERRORRETURN(.ERRORS,.RETURNERROR,.RETURNJSON) Q  ;error occured during filing
 I ISREACTIVATED D UPDATECLNRES(SDCLINICIEN,REACTIVATIONDATE)
 D BUILDJSON^SDESBUILDJSON(.RETURNJSON,.RETURN)
 Q
 ;
INITVAR ;Initialize input parameter
 S SDCLINICIEN=$G(SDCLINICIEN)
 S SDEAS=$G(SDEAS)
 S REACTIVATIONDATE=$G(REACTIVATIONDATE)
 Q
 ;
REACTIVATE(RETURN,SDCLINICIEN,REACTIVATIONDATE) ;Reactivate Clinic
 N SDERR,SDFDA,SDCLNNAME,ISFILED
 S ISFILED=0
 ;Only update the Reactivate Date field if the reacivation passed in is different
 I $$GET1^DIQ(44,SDCLINICIEN,2506)'=$P(REACTIVATIONDATE,".") D
 . S SDCLNNAME=$$GET1^DIQ(44,SDCLINICIEN,.01)
 . I $E(SDCLNNAME,1,2)="ZZ" S SDFDA(44,SDCLINICIEN_",",.01)=$E($$GET1^DIQ(44,SDCLINICIEN,.01),3,32)
 . S SDFDA(44,SDCLINICIEN_",",2506)=$P(REACTIVATIONDATE,".")
 . D FILE^DIE("","SDFDA","SDERR")
 . I $G(SDERR) S ISFILED=0 D ERRLOG^SDESJSON(.ERRORS,239) Q
 . S RETURN("Clinic","IEN")=SDCLINICIEN
 . S RETURN("Clinic","SuccessMessage")="Clinic is successfully reactivated effective "_$TR($$FMTE^XLFDT(REACTIVATIONDATE,"5DF")," ","0")
 . S ISFILED=1
 Q ISFILED
 ;
UPDATECLNRES(SDCLINICIEN,REACTIVATIONDATE) ;Update REACTIVATED DATE/TIME and REACTIVATED BY USER in SDEC RESOURCE File #409.831
 N SDRESFDA,SDCLINRES
 S SDCLINRES=$$GETRES^SDECUTL(SDCLINICIEN,1)
 Q:SDCLINRES=""
 S SDRESFDA(409.831,SDCLINRES_",",.025)=$P(REACTIVATIONDATE,".")
 S SDRESFDA(409.831,SDCLINRES_",",.026)=DUZ
 D FILE^DIE("","SDRESFDA")
 Q
 ;
VALCLNIENREACTDT(ERRORS,CLINICIEN,REACTIVATIONDATE) ;validate Clinic IEN and Reactivation Date (they need to go hand in hand together)
 N INACTDT,REACTDT
 I CLINICIEN="" D ERRLOG^SDESJSON(.ERRORS,18)
 I CLINICIEN'="" D
 . I '$D(^SC(CLINICIEN,0)) D ERRLOG^SDESJSON(.ERRORS,19) Q
 . I $P(^SC(CLINICIEN,0),"^",3)'="C" D ERRLOG^SDESJSON(.ERRORS,236) Q
 . I $S('$D(^SC(CLINICIEN,"I")):1,'$P(^SC(CLINICIEN,"I"),"^",1):1,1:0) D ERRLOG^SDESJSON(.ERRORS,235)
 ;
 I REACTIVATIONDATE="" D ERRLOG^SDESJSON(.ERRORS,240)
 I REACTIVATIONDATE'="",$$ISOTFM^SDAMUTDT(REACTIVATIONDATE,SDCLINICIEN)<1 D ERRLOG^SDESJSON(.ERRORS,238) Q
 I REACTIVATIONDATE'="" D
 . S REACTIVATIONDATE=$$ISOTFM^SDAMUTDT(REACTIVATIONDATE,SDCLINICIEN)
 . I REACTIVATIONDATE=-1 D ERRLOG^SDESJSON(.ERRORS,238) Q
 . Q:CLINICIEN=""
 . Q:'$D(^SC(CLINICIEN,0))
 . S INACTDT=$P($G(^SC(CLINICIEN,"I")),"^")
 . S REACTDT=$P($G(^SC(CLINICIEN,"I")),"^",2)
 . I $P(REACTIVATIONDATE,".")'>$G(INACTDT) D ERRLOG^SDESJSON(.ERRORS,237) Q
 . I $$GET1^DIQ(44,CLINICIEN,2506,"I")=$P(REACTIVATIONDATE,".") D  Q
 . . S ERRORS("Error",1)="Clinic already reactivated effective "_$TR($$FMTE^XLFDT(REACTIVATIONDATE,"5DF")," ","0")
 . I $G(REACTDT)>DT D  Q
 . . S ERRORS("Error",1)="Clinic is inactive as of "_$TR($$FMTE^XLFDT(INACTDT,"5DF")," ","0")
 . . S ERRORS("Error",1)=ERRORS("Error",1)_" and is already scheduled to be reactivated as of "_$TR($$FMTE^XLFDT(REACTDT,"5DF")," ","0")
 Q
 ;
SETERRORRETURN(ERRORS,RETURNERROR,RETURNJSON) ;
 M RETURNERROR=ERRORS
 D SETEMPTYOBJECT(.RETURNERROR) ;set the return object into null if an error occur
 D BUILDJSON^SDESBUILDJSON(.RETURNJSON,.RETURNERROR)
 Q
 ;
SETEMPTYOBJECT(RETURNERROR) ;set the return object into null if an error occur
 S RETURNERROR("Clinic","IEN")=""
 S RETURNERROR("Clinic","SuccessMessage")=""
 Q
 ;
