VPSAPPT2 ;SLOIFO/BT - VPS Appointment RPC;1/16/15 11:55
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**5**;Jan 16, 2015;Build 31
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #10035 - ^DPT( references      (Supported)
 ; #4433 - SDAMA301 call          (Supported)
 Q
 ; 
GETCHG(VPSAPPT,VPSQUEUE) ; VPS GET CHANGED APPOINTMENTS
 ; This RPC will return the changed appointments on the queue since the last GET^VPSAPPT or GETCHG^VPSAPPT2 invoked
 ;
 ; INPUT
 ;   VPSQUEUE : Unique Queue ID represents Vecna Appointment Queue.
 ; OUTPUT
 ;   VPSAPPT  : Name of Global array contains all retrieved appointments
 ;   Output Format: 
 ;   ^TMP("VPSAPPT",$J,SEQ)=TODO^APPOINTMENT ID^RECORD FLAG#^FIELD NAME^FIELD VALUE
 ;      TODO                    : instruct vecna to either Add, delete, update appointment and also notify for any error
 ;      APPOINTMENT ID          : represent appointment record in the VPS Appointment queue
 ;      RECORD FLAG#            : record flag number for patient (1..n)  - use only for record flag field
 ;      FIELD NAME              : Field name
 ;      FIELD VALUE             : Field value
 ;   Output Samples:
 ;      ^TMP("VPSAPPT",$J,0)=ERR^^^PARAM^error message     <--- notify Vecna for parameter error
 ;      ^TMP("VPSAPPT",$J,SEQ)=ERR^99^^ERROR^error message <--- notify Vecna that there is an issue during adding/updating entry #99 to the queue
 ;      ^TMP("VPSAPPT",$J,SEQ)=DEL^110                     <--- notify Vecna to delete entry #110 from the queue
 ;      ^TMP("VPSAPPT",$J,SEQ)=ADD^111^^<FIELD NAME>^FIELD VALUE       <--- notify Vecna to add entry #111 to the queue with those field values
 ;      ^TMP("VPSAPPT",$J,SEQ)=ADD^111^1^<FLAG FIELD NAME>^FIELD VALUE <--- notify Vecna to add record flag #1 to entry #111 to the queue
 ;      ^TMP("VPSAPPT",$J,SEQ)=UPD^97^^^FIELD NAME^FIELD VALUE          <--- notify Vecna to update entry #97 in the queue with those field values
 ;
 ;      <FIELD NAME> is a member of
 ;        CLINIC IEN^CLINIC NAME^APPT DATE
 ;        DFN^PATIENT NAME^SSN^EMAIL
 ;        APPT TYPE IEN^APPT TYPE NAME^APPT COMMENTS
 ;        APPT STATUS IEN^APPT STATUS NAME^DISPLAYED STATUS
 ;        BAD ADDRESS INDICATOR^BAD ADDRESS NAME
 ;        SENSITIVE,BALANCE,ENROLLMENT STATUS,ENROLLMENT STATUS NAME
 ;        PRE-REGISTRATION DATE CHANGED,ELIGIBILITY STATUS,ELIGIBILITY STATUS NAME
 ;        INELIGIBLE DATE^MEANS TEST STATUS^INSURANCE
 ;      <FLAG FIELD NAME> is a member of (FLAG ORIGINATION^FLAG TYPE^FLAG NAME^FLAG NARRATIVE")
 ; 
 S VPSAPPT=$NA(^TMP("VPSAPPT",$J)) K @VPSAPPT
 K ^TMP($J,"SDAMA301")
 ;
 I $G(VPSQUEUE)="" D ADDERR^VPSAPPT("ERR^^^PARAM^QUEUE ID IS REQUIRED") QUIT
 ;
 N CNT S CNT=$$POPAPPTS(VPSQUEUE) ;populate result array with new appointment and updated appointments
 I CNT D
 . D UPDQUEUE(VPSQUEUE) ; add new appointments or update modified appointments
 . D RMVAPPTS(VPSQUEUE) ; remove appointments from queue if appointments are no longer exist
 ;
 K ^TMP($J,"SDAMA301")
 QUIT
 ; 
POPAPPTS(QUEUEID) ;populate result array with new appointment and updated appointments
 ; INPUT
 ;   QUEUEID : Unique Queue ID represents Vecna Appointment Queue.
 ;
 ; -- get from, through date for the queue.
 N QINFO D GETS^DIQ(853.9,QUEUEID_",","1;2","I","QINFO")
 N FRMDT S FRMDT=$G(QINFO(853.9,QUEUEID_",",1,"I"))
 N THRDT S THRDT=$G(QINFO(853.9,QUEUEID_",",2,"I"))
 I 'FRMDT!'THRDT D ADDERR^VPSAPPT("ERR^^^GET^QUEUE has not been initialized.") QUIT 0
 ;
 ; -- populate ^TMP($J,"SDAMA301") using supported API given appointment from - through date
 QUIT $$POPAPPTS^VPSAPPT(FRMDT,THRDT)
 ;
UPDQUEUE(QUEUEID) ; add new appointments or update modified appointments
 N APPT,APPTINFO,APPTDT,TODO
 N CLIEN S CLIEN=0
 F  S CLIEN=$O(^TMP($J,"SDAMA301",CLIEN)) Q:'CLIEN  D
 . N DFN S DFN=0
 . F  S DFN=$O(^TMP($J,"SDAMA301",CLIEN,DFN)) Q:'DFN  D:$D(^DPT(DFN,0))
 . . S APPTDT=0
 . . F  S APPTDT=$O(^TMP($J,"SDAMA301",CLIEN,DFN,APPTDT)) Q:'APPTDT  D
 . . . S APPTINFO=$G(^TMP($J,"SDAMA301",CLIEN,DFN,APPTDT))
 . . . K APPT D GETAPPT^VPSAPPT(.APPT,APPTINFO)
 . . . S TODO=$$UPDATE(QUEUEID,.APPT) ; update the appointment in temporary storage (File #853.9)
 . . . D:TODO'="" ADDTMP^VPSAPPT(TODO,QUEUEID,.APPT) ; add the updated appointment to result array
 QUIT
 ;
UPDATE(QUEUEID,APPT) ; update the appointment in temporary storage (File #853.9)
 ; INPUT
 ;   QUEUEID  : Unique Queue ID represents Vecna Appointment Queue.
 ;   APPTINFO : Extended appointment information for Vecna to display in the queue
 ;              CLINIC IEN^CLINIC NAME^APPT DATE^DFN^PATIENT NAME^SSN^APPT TYPE IEN^APPT TYPE NAME^STATUS IEN^STATUS NAME^PRINTED STATUS
 ; RETURN
 ;   TODO     : ""    (no changed - nothing todo)
 ;            : "ADD" (instruct vecna to add the appointment to the queue)
 ;            : "UPD" (instruct vecna to update the appointment in the queue)
 ;            : "ERR" (notify vecna there is error during add/change appointment)
 ;
 N TODO S TODO="" ;nothing is changed
 N CLIEN S CLIEN=APPT("CLINIC IEN")
 N APPTDT S APPTDT=APPT("APPT DATE/TIME")
 N DFN S DFN=APPT("DFN")
 N APPTIEN S APPTIEN=$$GETIEN^VPSAPPT(QUEUEID,CLIEN,APPTDT,DFN) ; return the IEN for sub file 853.91 record
 ;
 ; -- Not in the queue, add the new appointment
 I 'APPTIEN D
 . S TODO=$$ADDAPPT^VPSAPPT(QUEUEID,.APPT) ;new appointment
 ;
 ; -- update the existing appointment if status or type is changed
 I APPTIEN D
 . N SAVAPPT S SAVAPPT=$G(^VPS(853.9,QUEUEID,1,APPTIEN,0))
 . N CURAPPT S CURAPPT=CLIEN_U_APPTDT_U_DFN_U_APPT("APPT TYPE IEN")_U_APPT("DISPLAYED APPT STATUS")
 . I SAVAPPT'=CURAPPT S TODO=$$UPDAPPT(QUEUEID,APPTIEN,CURAPPT) ;update appointment status/type changed
 QUIT TODO
 ;
UPDAPPT(QUEUEID,APPTIEN,APPTINFO) ;update appointment status/type changed
 ; INPUT
 ;   QUEUEID  : Unique Queue ID represents Vecna Appointment Queue.
 ;   APPTIEN  : Appointment ien in the queue
 ;   APPTINFO : Appointment information in the queue file 853.9
 ;              CLINIC IEN^APPT DATE^DFN^APPT TYPE IEN^PRINTED STATUS
 ; RETURN
 ;   TODO     : "UPD" (instruct vecna to update the appointment in the queue)
 ;            : "ERR" (notify vecna there is error during add/change appointment)
 ;
 N TODO S TODO="UPD"
 N VPSFDA
 S VPSFDA(853.91,APPTIEN_","_QUEUEID_",",3)=$P(APPTINFO,U,4) ;appt type ien
 S VPSFDA(853.91,APPTIEN_","_QUEUEID_",",4)=$P(APPTINFO,U,5) ;displayed version of appt status name
 N VPSERR D FILE^DIE("E","VPSFDA","VPSERR")
 I $D(DIERR) S TODO="ERR"_U_VPSERR("DIERR",1,"TEXT",1)
 K DIERR,VPSFDA,VPSERR
 QUIT TODO
 ;
RMVAPPTS(QUEUEID) ;remove appointment from queue if appointmentsd are no longer existed
 N APPTIEN S APPTIEN=0
 F  S APPTIEN=$O(^VPS(853.9,QUEUEID,1,APPTIEN)) QUIT:'APPTIEN  D
 . N APPTINFO S APPTINFO=^VPS(853.9,QUEUEID,1,APPTIEN,0)
 . N CLIEN S CLIEN=$P(APPTINFO,U)
 . N APPTDT S APPTDT=$P(APPTINFO,U,2)
 . N DFN S DFN=$P(APPTINFO,U,3)
 . I '$D(^TMP($J,"SDAMA301",CLIEN,DFN,APPTDT)) D
 . . D DELAPPT(QUEUEID,APPTIEN) ;delete temp appointment queue to reflect current appointments
 . . D ADDDEL(APPTIEN) ;tell vecna to remove the entry
 QUIT
 ;
DELAPPT(QUEUEID,APPTIEN) ;delete temp appointment from the queue to reflect current appointments
 ; INPUT
 ;   QUEUEID : Unique Queue ID represents Vecna Appointment Queue.
 ;   APPTIEN  : Appointment ien in the queue
 ;
 N DA S DA(1)=QUEUEID,DA=APPTIEN
 N DIK S DIK="^VPS(853.9,"_DA(1)_",1,"
 D ^DIK
 K DIK
 QUIT
 ;
ADDDEL(APPTIEN) ;notify vecna to remove the entry from the Vecna's VPS appointment queue
 ; INPUT
 ;   APPTIEN  : Appointment ien in the queue
 ;
 N SEQ S SEQ=$O(^TMP("VPSAPPT",$J," "),-1)+1
 S ^TMP("VPSAPPT",$J,SEQ)="DEL"_U_APPTIEN ;save appointment into result global array
 QUIT
