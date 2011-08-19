DGQEHLL ;ALB/RPM - VIC REPLACEMENT VIC HL7 TRAN LOG FILE ACCESS API'S ; 12/09/03
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
 ; This routine contains the functions and procedures used to access
 ; and manipulate the VIC HL7 TRANSMISSION LOG (#39.7) file.
 ;
 ;   $$FINDMID - locate transmission record for a given HL7 message ID
 ;   $$FINDLST - locate last transmission record for a given request
 ;   $$GETLOG  - retrieve a single VIC HL7 TRANSMISSION LOG record
 ;   STOXMIT   - store a new VIC HL7 TRANSMISSION LOG record
 ;   STOACK    - store acknowledgment status and date
 ;   $$DELXMIT - delete a single VIC HL7 TRANSMISSION LOG record
 ;
 Q  ;no direct entry
 ;
FINDMID(DGMID) ;locate record for a given HL7 message ID
 ; This function performs a lookup of the VIC HL7 TRANSMISSION LOG
 ; (#39.7) file for a given HL7 Message ID.
 ;
 ;  Input:
 ;    DGMID - HL7 message ID
 ;
 ;  Output:
 ;   Function value - IEN of VIC HL7 TRANSMISSION LOG (#39.7) on success;
 ;                    0 on failure
 ;
 S DGMID=+$G(DGMID)
 Q +$O(^DGQE(39.7,"B",DGMID,""))
 ;
 ;
FINDLST(DGREQ) ;locate the last transmission record for a given request
 ;
 ;  Input:
 ;    DGIEN - pointer to VIC REQUEST (#39.6) file
 ;
 ;  Output:
 ;   Function value - IEN of VIC HL7 TRANSMISSION LOG (#39.7) on success,
 ;                    0 on failure
 ;
 N DGDAT
 ;
 S DGDAT=+$O(^DGQE(39.7,"ADATE",DGREQ,""),-1)
 Q +$O(^DGQE(39.7,"ADATE",DGREQ,DGDAT,0))
 ;
 ;
GETLOG(DGIEN,DGLOG) ;retrieve a single record
 ; This function retrieves all fields belonging to a single record
 ; in the VIC HL7 TRANSMISSION LOG (#39.7) file for a given IEN.
 ; The field data is placed in an array format.
 ;
 ;  Input:
 ;    DGIEN - VIC HL7 TRANSMISSION LOG (#39.7) file record number
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;    DGLOG - array of field data
 ;            Array subscripts are:
 ;             "HLMID"  - HL7 Message ID
 ;             "REQIEN" - pointer to request in VIC REQUEST (#39.6) file
 ;             "XMITDT" - HL7 Transmission date/time
 ;             "XMSTAT" - Transmission status
 ;             "ACKDT"  - ACK received date/time
 ;
 N DGERR   ;FM result error message
 N DGFIL   ;FM file number
 N DGFLD   ;FM result field array
 N DGIENS  ;FM IENS value
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 S DGFIL=39.7
 ;
 I $G(DGIEN),$D(^DGQE(DGFIL,DGIEN)) D
 . S DGIENS=DGIEN_","
 . D GETS^DIQ(DGFIL,DGIENS,"*","I","DGFLD","DGERR")
 . Q:$D(DGERR)
 . S DGLOG("HLMID")=$G(DGFLD(DGFIL,DGIENS,.01,"I"))
 . S DGLOG("REQIEN")=$G(DGFLD(DGFIL,DGIENS,.02,"I"))
 . S DGLOG("XMITDT")=$G(DGFLD(DGFIL,DGIENS,.03,"I"))
 . S DGLOG("XMSTAT")=$G(DGFLD(DGFIL,DGIENS,.04,"I"))
 . S DGLOG("ACKDT")=$G(DGFLD(DGFIL,DGIENS,.05,"I"))
 . S DGRSLT=1  ;success
 ;
 Q DGRSLT
 ;
 ;
STOXMIT(DGMID,DGRIEN) ;create a transmit record
 ; This procedure creates a record in the VIC HL7 TRANSMISSION LOG
 ; (#39.7) file.
 ;
 ;  Input:
 ;    DGMID  - HL7 Message Control ID
 ;    DGRIEN - IEN of record in VIC REQUEST (#39.6) file
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
 ;validate input params
 Q:$G(DGMID)'>0
 Q:'$G(DGRIEN)
 Q:'$D(^DGQE(39.6,DGRIEN))
 ;
 S DGFIL=39.7
 S DGIEN=$$FINDMID(DGMID)
 S DGIENS=$S('DGIEN:"+1,",1:DGIEN_",")
 ;
 S DGFDA(DGFIL,DGIENS,.01)=DGMID
 S DGFDA(DGFIL,DGIENS,.02)=DGRIEN
 S DGFDA(DGFIL,DGIENS,.03)=$$NOW^XLFDT()
 S DGFDA(DGFIL,DGIENS,.04)="T"  ;transmitted
 D UPDATE^DIE("","DGFDA","","DGERR")
 ;
 Q
 ;
 ;
STOACK(DGIEN,DGSTAT) ;update STATUS
 ; This procedure updates the STATUS (#.04) field of the VIC HL7
 ; TRANSMISSION LOG (#39.7) file
 ;
 ;  Input:
 ;    DGIEN  - IEN of record in VIC HL7 TRANSMISSION LOG (#39.7) file
 ;    DGSTAT - transmission status ("A":Accepted,"RJ":Rejected)
 ;
 ;  Output:
 ;    none
 ;
 N DGERR
 N DGFDA
 N DGIENS
 ;
 ;validate input params
 Q:'$G(DGIEN)
 Q:$G(DGSTAT)']""
 Q:$$EXTERNAL^DILFD(39.7,.04,"F",DGSTAT,"")']""
 ;
 S DGIENS=DGIEN_","
 S DGFDA(39.7,DGIENS,.04)=DGSTAT
 S DGFDA(39.7,DGIENS,.05)=$$NOW^XLFDT()
 D FILE^DIE("","DGFDA","DGERR")
 Q
 ;
 ;
DELXMIT(DGIEN) ;delete a single VIC HL7 TRANSMISSION LOG record
 ;
 ;  Input:
 ;    DGIEN - IEN of record in VIC HL7 TRANSMISSION LOG (#39.7) file
 ;
 ;  Output:
 ;    Function value - 1 on success, 0 on failure
 ;
 N DGERR
 N DGFDA
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 I $G(DGIEN) D
 . S DGFDA(39.7,DGIEN_",",.01)="@"
 . D FILE^DIE("","DGFDA","DGERR")
 . Q:$D(DGERR)
 . S DGRSLT=1  ;success
 ;
 Q DGRSLT
