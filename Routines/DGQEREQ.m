DGQEREQ ;ALB/RPM - VIC REPLACEMENT VIC REQUEST FILE ACCESS API'S ; 12/09/03
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
 ; This routine contains the functions and procedures used to access
 ; and manipulate the VIC REQUEST (#39.6) file.
 ;
 ;   $$FINDCID - locate NCMD Card ID
 ;   $$FINDLST - locate last (most recent) VIC request
 ;   $$GETREQ  - retrieve a single VIC REQUEST record
 ;   $$STOCID  - store the NCMD Card ID
 ;   $$STOSTAT - store the Card Print Release Status
 ;   $$DELREQ  - delete a single VIC REQUEST record
 ;
 Q  ;no direct entry
 ;
FINDCID(DGCID) ;locate record for a given NCMD Card ID
 ; This function performs a lookup of the VIC REQUEST (#39.6) file
 ; for a given Card ID.
 ;
 ;  Input:
 ;    DGCID - NCMD Card ID
 ;
 ;  Output:
 ;   Function value - IEN of VIC REQUEST on success;
 ;                    0 on failure
 ;
 Q:$G(DGCID)']"" 0
 Q +$O(^DGQE(39.6,"B",DGCID,""))
 ;
 ;
FINDLST(DGDFN) ;locate the IEN of the last request for a given patient
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - IEN of VIC REQUEST (#39.6) file on success,
 ;                    0 on failure
 ;
 N DGDAT
 ;
 S DGDFN=+$G(DGDFN)
 S DGDAT=+$O(^DGQE(39.6,"APDAT",DGDFN,""),-1)
 Q +$O(^DGQE(39.6,"APDAT",DGDFN,DGDAT,0))
 ;
 ;
GETREQ(DGIEN,DGREQ) ;retrieve a single record
 ; This function retrieves all fields belonging to a single record
 ; in the VIC REQUEST (#39.6) file for a given IEN.  The field data
 ; is placed in an array format.
 ;
 ;  Input:
 ;    DGIEN - VIC REQUEST (#39.6) file record number
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;    DGREQ - array of field data
 ;            Array subscripts are:
 ;             "DFN"     - pointer to patient in PATIENT (#2) file
 ;             "CARDID"  - NCMD Card ID
 ;             "NAME"    - patient name
 ;             "CPRSTAT" - card print release status
 ;             "REQDATE" - VIC Request Date in internal format
 ;       
 N DGERR   ;FM result error message
 N DGFIL   ;FM file number
 N DGFLD   ;FM result field array
 N DGIENS  ;FM IENS value
 N DGRSLT  ;Function value
 ;
 S DGRSLT=0
 S DGFIL=39.6
 ;
 I $G(DGIEN),$D(^DGQE(DGFIL,DGIEN)) D
 . S DGIENS=DGIEN_","
 . D GETS^DIQ(DGFIL,DGIENS,"*","IE","DGFLD","DGERR")
 . Q:$D(DGERR)
 . S DGREQ("CARDID")=$G(DGFLD(DGFIL,DGIENS,.01,"I"))
 . S DGREQ("DFN")=$G(DGFLD(DGFIL,DGIENS,.02,"I"))
 . S DGREQ("NAME")=$G(DGFLD(DGFIL,DGIENS,.02,"E"))
 . S DGREQ("CPRSTAT")=$G(DGFLD(DGFIL,DGIENS,.03,"I"))
 . S DGREQ("REQDT")=$G(DGFLD(DGFIL,DGIENS,.04,"I"))
 . S DGRSLT=1  ;success
 ;
 Q DGRSLT
 ;
 ;
STOCID(DGCID,DGDFN,DGSTAT) ;store the NCMD-assigned Card ID
 ; This procedure creates a record in the VIC REQUEST (#39.6) file.
 ;
 ;  Input:
 ;    DGCID  - Card ID [format: lastname_"-"_SSN_"-"_number of requests]
 ;    DGDFN  - pointer to patient in PATIENT(#2) file
 ;    DGSTAT - Card Print Release Status
 ;
 ;  Output:
 ;    none
 ;
 N DGERR
 N DGFDA
 N DGFIL
 N DGIEN
 N DGIENS
 ;
 S DGFIL=39.6
 ;
 ;validate input params
 Q:+$G(DGDFN)'>0
 Q:'$D(^DPT(DGDFN,0))
 Q:$G(DGCID)']""
 Q:$$EXTERNAL^DILFD(DGFIL,.03,"F",$G(DGSTAT),"")']""
 ;
 S DGIEN=$$FINDCID(DGCID)
 S DGIENS=$S('DGIEN:"+1,",1:DGIEN_",")
 ;
 S DGFDA(DGFIL,DGIENS,.01)=DGCID
 S DGFDA(DGFIL,DGIENS,.02)=DGDFN
 S DGFDA(DGFIL,DGIENS,.03)=DGSTAT
 S DGFDA(DGFIL,DGIENS,.04)=$$NOW^XLFDT()
 D UPDATE^DIE("","DGFDA","","DGERR")
 ;
 Q
 ;
 ;
STOSTAT(DGIEN,DGSTAT) ;update CARD PRINT RELEASE STATUS
 ; This procedure is used to update the CARD PRINT RELEASE STATUS(#.03)
 ; field of the VIC REQUEST (#39.6) file.
 ;
 ;  Input:
 ;    DGIEN  - IEN of VIC REQUEST file record
 ;    DGSTAT - card print release status
 ;
 ;  Output:
 ;    none
 ;
 N DGERR
 N DGFDA
 N DGFIL
 ;
 S DGFIL=39.6
 ;
 ;validate input parameters
 Q:'$G(DGIEN)
 Q:$G(DGSTAT)']""
 Q:$$EXTERNAL^DILFD(DGFIL,.03,"F",DGSTAT,"")']""
 ;
 S DGFDA(DGFIL,DGIEN_",",.03)=DGSTAT
 D FILE^DIE("","DGFDA","DGERR")
 Q
 ;
 ;
DELREQ(DGIEN) ;delete a single VIC REQUEST record
 ;
 ;  Input:
 ;    DGIEN - IEN of record in VIC REQUEST (#39.6) file
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;
 N DGDT    ;HL7 transmission date
 N DGERR
 N DGFDA
 N DGLIEN  ;pointer to VIC HL7 TRANSMISSION LOG (#39.7) file
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 I $G(DGIEN) D
 . S DGFDA(39.6,DGIEN_",",.01)="@"
 . D FILE^DIE("","DGFDA","DGERR")
 . Q:$D(DGERR)
 . ;
 . ;cleanup HL7 TRANSMISSION LOG
 . S DGDT=0
 . F  S DGDT=$O(^DGQE(39.7,"ADATE",DGIEN,DGDT)) Q:'DGDT  D  Q:$D(DGERR)
 . . S DGLIEN=$O(^DGQE(39.7,"ADATE",DGIEN,DGDT,0))
 . . I DGLIEN,'$$DELXMIT^DGQEHLL(DGLIEN) S DGERR=1
 . Q:$D(DGERR)
 . S DGRSLT=1  ;success
 ;
 Q DGRSLT
