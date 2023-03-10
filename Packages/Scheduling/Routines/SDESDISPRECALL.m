SDESDISPRECALL ;ALB/KML,KML,MGD - VISTA SCHEDULING RPCS ;July 19, 2022
 ;;5.3;Scheduling;**803,805,815,819,820**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 Q
 ;
DISPRECALL(SDECY,RECALLIEN,REASON,COMMENT,EAS) ; add a disposition and DELETE an entry from the RECALL REMINDERS file 403.5 - SDES RECALL rpc
 ;INPUT:
 ;   RECALLIEN - (required) IEN pointer to RECALL REMINDERS
 ;   REASON   - (optional) Recall Disposition used to populate the
 ;                          DELETE REASON field in the RECALL REMINDERS
 ;                          REMOVED file 403.56 when an entry is removed
 ;                          from RECALL REMINDERS file. Valid Values are:
 ;                            FAILURE TO RESPOND
 ;                            MOVED
 ;                            DECEASED
 ;                            DOESN'T WANT VA SERVICES
 ;                            RECEIVED CARE AT ANOTHER VA
 ;                            OTHER
 ;                            APPT SCHEDULED
 ;                            VET SELF-CANCEL
 ;   COMMENT  - (optional) Text to replace the text in the COMMENT
 ;                        Field 2.5 in RECALL REMINDERS prior to the
 ;                       delete which moves the data including this
 ;                       comment to RECALL REMINDERS REMOVED
 ;   EAS - (optional) EAS TRACKING NUMBER
 ;RETURN: SDECY
 N SDRECALL,SDRRFTR,PROVIDER,SDFDA,ERROR,NOKEY,SDMSG
 D VALIDATE
 I ERROR D BLDJSON Q
 D EDIT
 S NOKEY=$$KEY(RECALLIEN,PROVIDER)
 I NOKEY D ERRLOG^SDESJSON(.SDRECALL,NOKEY),BLDJSON Q  ; cannot move/delete if security key isn't present
 D DELETE
 Q
 ;
VALIDATE ;
 S ERROR=0
 S RECALLIEN=$G(RECALLIEN)
 ;check IEN of RECALL REMINDERS (required)
 I RECALLIEN="" D ERRLOG^SDESJSON(.SDRECALL,16) S ERROR=1
 I '$D(^SD(403.5,+RECALLIEN)) D ERRLOG^SDESJSON(.SDRECALL,17) S ERROR=1
 ;check disposition (optional)
 S SDRRFTR=$G(REASON) ;refer to the A66201 new-style xref defined 403.5 for detail; SDRRFTR is referenced in DELETE^SDRRISRU
 I SDRRFTR'="" D
 .S SDRRFTR=$S(SDRRFTR="FAILURE TO RESPOND":1,SDRRFTR="MOVED":2,SDRRFTR="DECEASED":3,SDRRFTR="DOESN'T WANT VA SERVICES":4,SDRRFTR="RECEIVED CARE AT ANOTHER VA":5,SDRRFTR="OTHER":6,SDRRFTR="APPT SCHEDULED":7,SDRRFTR="VET SELF-CANCEL":8,1:"")
 I SDRRFTR="" K SDRRFTR
 ;check provider (required)
 S PROVIDER=$$GET1^DIQ(403.5,RECALLIEN_",",4) ; RECALL provider
 I '$D(^SD(403.54,+PROVIDER)) D ERRLOG^SDESJSON(.SDRECALL,131) S ERROR=1
 ;validate EAS
 S EAS=$G(EAS,"")
 I $L(EAS) S EAS=$$EASVALIDATE^SDESUTIL(EAS)
 I EAS=-1 D ERRLOG^SDESJSON(.SDRECALL,142) S ERROR=1
 Q
 ;
EDIT ;
 ;replace existing comment and EAS tracking number before calling move/delete
 S COMMENT=$G(COMMENT)
 S SDFDA(403.5,RECALLIEN_",",2.5)=$E(COMMENT,1,80)
 S SDFDA(403.5,RECALLIEN_",",100)=$G(EAS)
 D FILE^DIE("","SDFDA")
 K SDFDA
 Q
 ;
DELETE ;delete and move entry to RECALL REMINDERS REMOVED file (403.56)
 S SDFDA(403.5,RECALLIEN_",",.01)="@"
 D UPDATE^DIE("","SDFDA","SDIEN","SDMSG")
 I $D(SDMSG) D ERRLOG^SDESJSON(.SDRECALL,136,"for IEN "_RECALLIEN)
 I '$D(SDMSG) S SDRECALL("PtCSchReqDisposition","IEN")=RECALLIEN
 D BLDJSON
 Q
 ;
BLDJSON ;
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDRECALL,.SDECY,.JSONERR)
 Q
 ;
KEY(RECALLIEN,RRPROVIEN) ;check that user has the correct SECURITY KEY
 ;INPUT:
 ; RECALLIEN - ien of the entry in RECALL REMINDERS file (403.5)
 ; RRPROVIEN - ien of the entry in the RECALL REMINDERS PROVIDERS file 403.54
 ;RETURN
 ;  0=User has the correct SECURITY KEY
 ;  "-1^<text>" = User does not have the correct SECURITY KEY
 N KEY,RET,VALUE
 S RET=135
 I RRPROVIEN="" S RET=0
 I RRPROVIEN'="" D
 . S KEY=$P($G(^SD(403.54,RRPROVIEN,0)),U,7)
 . I KEY="" S RET=0 Q
 . S VALUE=$$LKUP^XPDKEY(KEY) N KY D OWNSKEY^XUSRB(.KY,VALUE,DUZ)
 . I $G(KY(0))'=0 S RET=0
 Q RET
