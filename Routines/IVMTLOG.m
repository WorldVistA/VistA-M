IVMTLOG ;ALB/CJM - API for IVM TRANSMISSION LOG file; 4-SEP-97
 ;;2.0;INCOME VERIFICATION MATCH;**9**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
LOCK(IEN) ;
 ;Description: Locks a record in the IVM TRANSMISSION LOG file.
 ;Input:
 ;  IEN - ien of record  in IVM TRANSMISSION LOG file.
 ;Output:
 ;  Function Value - 1 if successful, 0 otherwise.
 ;
 I $G(IEN) L +^IVM(301.6,IEN):3
 Q $T
 ;
UNLOCK(IEN) ;
 ;Description: Unlocks a record in the IVM TRANSMISSION LOG file.
 ;Input:
 ;  IEN - ien of record in the IVM TRANSMISSION LOG file.
 ;Output: None
 ;
 I $G(IEN) L -^IVM(301.6,IEN)
 Q
 ;
SETSTAT(IEN,STATUS,ERROR) ;
 ;Description: Sets the value of the STATUS field of the
 ;  IVM TRANSMISSION LOG file for a particular record.
 ;Input:
 ;  IEN - internal entry number of a record in IVM TRANSMISSION LOG file.
 ;  STATUS - status code -  1:RECEIVED, 0:TRANSMITTED, 2:RE-TRANSMITTED, 3:ERROR IN TRANSMITTED RECORD
 ;  ERROR - optional - text error message
 ;Output:  
 ;  Function Value - 1 on success, 0 on failure.
 ;
 Q:'$$TESTVAL^DGENDBS(301.6,.03,STATUS) 0
 ;
 N DATA,RET
 Q:'$$LOCK($G(IEN)) 0
 S DATA(.03)=STATUS
 I $G(ERROR)'="" S DATA(.04)=$E(ERROR,1,80)
 ;
 ;DATE/TIME ACK RECEIVED should only be entered for appropriate status
 I (STATUS=1)!(STATUS=3) D
 .S DATA(.06)=$$NOW^XLFDT
 E  S DATA(.06)="@"
 ;
 ;ERROR PROCESSING STATUS should only be entered if error status
 I (STATUS=3) D
 .S DATA(.07)=1
 E  S DATA(.07)="@"
 ;
 S RET=$$UPD^DGENDBS(301.6,IEN,.DATA)
 D UNLOCK(IEN)
 Q RET
 ;
ERRSTAT(IEN,STATUS,ERROR) ;
 ;Description: Sets the ERROR PROCESSING STATUS field of a record in the IVM TRANSMISSION LOG file.
 ;
 ;Input:
 ;  IEN - ien of record  in IVM TRANSMISSION LOG file.
 ;  STATUS - error processing status code
 ;Output:
 ;  Function Value - 1 if successful, 0 otherwise.
 ;  ERROR - error message (optional), pass by reference - will return message on failure
 ;
 N DATA,RET
 ;
 S ERROR=""
 I '$$TESTVAL^DGENDBS(301.6,.07,STATUS) S ERROR="INVALID TRANSMISSION PROCESSING STATUS" Q 0
 I '$G(IEN) S ERROR="NO RECORD SPECIFIED" Q 0
 I $P(^IVM(301.6,IEN,0),"^",3)'=3 S ERROR="STATUS IS NOT 'ERROR IN TRANSMITTED RECORD'" Q 0
 I '$$LOCK($G(IEN)) S ERROR="COULD NOT OBTAIN LOCK ON RECORD" Q 0
 S DATA(.07)=STATUS
 S RET=$$UPD^DGENDBS(301.6,IEN,.DATA,.ERROR)
 D UNLOCK(IEN)
 Q RET
 ;
GET(IEN,TLOG) ;
 ;Description: Used to obtain a record in the IVM TRANSMISSION LOG file.  The
 ;values are returned in the TLOG() array.
 ;Input:
 ;  IEN - internal entry number of a record in the IVM TRANSMISSION LOG file.
 ;Output:
 ;  Function Value - 1 on success, 0 on failure.
 ;  TLOG() array, pass by reference.  Subscripts are
 ;    "PAT" - value of the IVM PATIENT field (#.01) which is the ien of record in the IVM PATIENT file.
 ;    "DFN" - ien, PATIENT file
 ;    "DT/TM SENT" -  value of the TRANSMISSION DATE/TIME field (#.02)
 ;    "STATUS" - value of the STATUS field (#.03)
 ;    "ERROR" -  value of the ERROR MESSAGE field (#.04)
 ;    "MSGID" - value of the MESSAGE CONTROL ID field (#.05)
 ;    "EVENTS","IVM" - value of the IVM EVENT (#30.01) field
 ;    "EVENTS","DCD" - value of the DCD EVENT (#30.02) field
 ;    "EVENTS","ENROLL" - value of the ENROLLMENT EVENT (#30.03) field
 ;    "DT/TM ACK" - value of the DATE/TIME ACK RECEIVED (#.06) field
 ;    "ERROR STATUS" - value of the ERROR PROCESSING STATUS (#.07) field
 ;    "MT STATUS" - value of the MEANS TEST STATUS field (#1.01)
 ;    "INS STATUS" - value of the INSURANCE STATUS field (#1.02)
 ;
 N NODE
 K TLOG S TLOG=""
 Q:'$G(IEN) 0
 S NODE=$G(^IVM(301.6,IEN,0))
 Q:(NODE="") 0
 S TLOG("PAT")=$P(NODE,"^")
 S TLOG("DFN")=$S(TLOG("PAT"):$P(^IVM(301.5,TLOG("PAT"),0),"^"),1:"")
 S TLOG("DT/TM SENT")=$P(NODE,"^",2)
 S TLOG("STATUS")=$P(NODE,"^",3)
 S TLOG("ERROR")=$P(NODE,"^",4)
 S TLOG("MSGID")=$P(NODE,"^",5)
 S TLOG("DT/TM ACK")=$P(NODE,"^",6)
 S TLOG("ERROR STATUS")=$P(NODE,"^",7)
 S NODE=$G(^IVM(301.6,IEN,"E"))
 S TLOG("EVENTS","IVM")=$P(NODE,"^")
 S TLOG("EVENTS","DCD")=$P(NODE,"^",2)
 S TLOG("EVENTS","ENROLL")=$P(NODE,"^",3)
 S NODE=$G(^IVM(301.6,IEN,1))
 S TLOG("MT STATUS")=$P(NODE,"^")
 S TLOG("INS STATUS")=$P(NODE,"^",2)
 Q 1
 ;
LOG(PAT,WHEN,MSGID,EVENTS,MTSTAT,INSSTAT) ;
 ;Description: Called after completing a transmission for a particular
 ;patient.  It creates a new record in the IVM TRANSMISSION LOG file.
 ;
 ;Input:
 ;  PAT - ien of record in the IVM PATIENT file.
 ;  WHEN -  date/time message sent, in FM format.
 ;  MSGID - message id used for message, in format used by MESSAGE CONTROL ID field.
 ;  EVENTS () - an array of reasons for transmission, pass by reference.
 ;  EVENTS("IVM") = 1 if transmission due to IVM criteria, 0 otherwise
 ;  EVENTS("DCD")=1 if transmission due to DCD criteria, 0 otherwise
 ;  EVENTS("ENROLL")=1 if transmission due to enrollment criteria, 0 otherwise
 ;  MTSTAT - pointer to the MEANS TEST STATUS file.  Is the status of the patient's means test at the time of the transmission for the income year of the transmission. (Optional)
 ;  INSSTAT - 1 if the patient had active insurance at the time of the transmission, 0 otherwise. (Optional)
 ;
 ;Output:
 ;  Function Value - If successful, returns the internal entry number of the record in the IVM TRANSMSISION LOG file, otherwise returns NULL.
 ;
 Q:'$$TESTVAL^DGENDBS(301.6,.01,PAT) ""
 Q:'$$TESTVAL^DGENDBS(301.6,.02,WHEN) ""
 ;
 ;skip this test - msgid is created by HL7 pkg, they can change it, so do not want to pass it by IVM's input transform
 ;Q:'$$TESTVAL^DGENDBS(301.6,.05,MSGID) ""
 ;
 I ($G(MTSTAT)'=""),'$$TESTVAL^DGENDBS(301.6,1.01,MTSTAT) Q ""
 I ($G(INSSTAT)'=""),'$$TESTVAL^DGENDBS(301.6,1.02,INSSTAT) Q ""
 ;
 N DATA
 S DATA(.01)=PAT,DATA(.02)=WHEN,DATA(.03)=0,DATA(.05)=MSGID
 S:($G(MTSTAT)'="") DATA(1.01)=MTSTAT
 S:($G(INSSTAT)'="") DATA(1.02)=INSSTAT
 S:($G(EVENTS("IVM"))=1) DATA(30.01)=1
 S:($G(EVENTS("DCD"))=1) DATA(30.02)=1
 S:($G(EVENTS("ENROLL"))=1) DATA(30.03)=1
 Q $$ADD^DGENDBS(301.6,,.DATA)
 ;
DELETE(IEN) ;
 ;Description: Used to delete a record in the IVM TRANSMISSION LOG file.
 ;
 ;Input:
 ;   IEN - the internal entry number for a record in the IVM TRANSMISSION LOG file
 ;Output:
 ;  Function Value - 1 on success, 0 on failure
 ;
 Q:'$G(IEN) 1
 ;
 Q:'$$LOCK(IEN) 0
 ;
 N DIK,DA
 S DIK="^IVM(301.6,"
 S DA=IEN
 D ^DIK
 D UNLOCK(IEN)
 Q 1
 ;
EXT(SUB,VAL) ;
 ;Description: Given the subscript used in the IVM TRANSMISSION LOG
 ;   array and a field value, returns the external representation of the
 ;   value, as defined in the fields output transform of the IVM
 ;   TRANSMISSION LOG file.
 ;Input: 
 ;  SUB - array subscript
 ;  VAL - field value
 ;Output:
 ;  Function Value - returns the external value of the field
 ;
 Q:(($G(SUB)="")!($G(VAL)="")) ""
 ;
 N FLD
 S FLD=$S(SUB="PAT":.01,SUB="DT/TM SENT":.02,SUB="STATUS":.03,SUB="ERROR":.04,SUB="MSGID":.05,SUB="DT/TM ACK":.06,SUB="ERROR STATUS":.07,SUB="IVM":30.01,SUB="DCD":30.02,SUB="ENROLL":30.03,SUB="MT STATUS":1.01,SUB="INS STATUS":1.02,1:"")
 ;
 Q:(FLD="") ""
 Q $$EXTERNAL^DILFD(301.6,FLD,"F",VAL)
