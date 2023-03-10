SDESCANCELAPPT ;ALB/BLB,ANU,MGD - VISTA SCHEDULING RPCS ;June 17, 2022
 ;;5.3;Scheduling;**801,804,805,819**;Aug 13, 1993;Build 5
 ;;Per VHA Directive 6402, this routine should not be modified;
 ;
CANCELAPPT(SDECY,APPTIEN,STATUS,CANREAS,USER,EAS) ;
 ;APPTIEN - (required) pointer to SDEC APPOINTMENT file
 ;STATUS   - (required) appointment Status valid values:
 ;                          C=CANCELLED BY CLINIC
 ;                         PC=CANCELLED BY PATIENT
 ;CANREAS - (required) pointer to cancel reason file
 ;USER    - (optional) DUZ of user cancelling appt
 ;EAS     - (optional) EAS Tracking Number
 N FDA,ERROR,SDAPPT,DATETIME
 S ERROR=0
 I $G(APPTIEN)="" D ERRLOG^SDESJSON(.SDAPPT,14) S ERROR=1 ; missing appt IEN
 I $G(APPTIEN)'="",'$D(^SDEC(409.84,APPTIEN,0)) D ERRLOG^SDESJSON(.SDAPPT,15) S ERROR=1  ; invalid appt IEN
 S DATETIME=$$NOW^XLFDT
 I $G(STATUS)=""  D ERRLOG^SDESJSON(.SDAPPT,38) S ERROR=1 ; missing status
 I $G(STATUS)'="" D
 .I $G(STATUS)'="C",$G(STATUS)'="PC" D ERRLOG^SDESJSON(.SDAPPT,30) S ERROR=1 ; invalid cancel status
 I USER'="" I '$D(^VA(200,+USER,0)) S USER=""
 I $G(USER)="" S USER=$G(DUZ)
 I $G(CANREAS)=""  D ERRLOG^SDESJSON(.SDAPPT,128) S ERROR=1 ; missing cancellation reason
 I $G(CANREAS)'="",'$D(^SD(409.2,CANREAS,0)) D ERRLOG^SDESJSON(.SDAPPT,129) S ERROR=1 ; invalid cancellation reason
 S EAS=$G(EAS,"")
 I $L(EAS) S EAS=$$EASVALIDATE^SDESUTIL(EAS)
 I EAS=-1 D ERRLOG^SDESJSON(.SDAPPT,142) S ERROR=1
 ;
 I '$G(ERROR) D
 .S FDA(409.84,APPTIEN_",",.12)=$G(DATETIME)
 .S FDA(409.84,APPTIEN_",",.121)=$G(DUZ)
 .S FDA(409.84,APPTIEN_",",.17)=$G(STATUS)
 .;SD*5.3*804 - Not delete VVS ID when called from SDES CANCEL APPT RPC
 .;S FDA(409.84,APPTIEN_",",2)="@" ;patch SD*5.3*796, delete VVS appointment ID if appoinment is cancelled
 .S FDA(409.84,APPTIEN_",",.122)=$G(CANREAS)
 .S FDA(409.84,APPTIEN_",",100)=$G(EAS)
 .D FILE^DIE(,"FDA","ERR")
 .S SDAPPT("CancelAppt","Success")=1
 D BUILDER
 Q
 ;
BUILDER ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDAPPT,.SDECY,.JSONERR)
 Q
