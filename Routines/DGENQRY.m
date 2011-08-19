DGENQRY ;ALB/CJM - API for ENROLLMENT QUERIES; 11/17/00 12:07pm ; 12/6/00 5:32pm
 ;;5.3;REGISTRATION;**147,222,232,314**;Aug 13,1993
 ;
QRY(DFN) ;
 ;Description: Used to implment the automatic querying of HEC for
 ;enrollment/eligibility data.
 ;
 ;Input:
 ;  DGQRY - this array should contain values for all the subscripts
 ;          defined for the DGQRY array.  (pass by reference)
 ;
 ;Output:
 ;  Function Value - If successful, returns the ien of the newly created
 ;                    record, otherwise returns 0.
 ;
 N STATUS
 Q:'$G(DFN) 0
 Q:'$$VET^DGENPTA(DFN) 0
 Q:$$PENDING^DGENQRY(DFN) 0
 S STATUS=$$STATUS^DGENA(DFN)
 ; Purple Heart added status 21
 Q:((STATUS=1)!(STATUS=2)!(STATUS=9)!(STATUS=15)!(STATUS=16)!(STATUS=17)!(STATUS=18)!(STATUS=21)) 0
 Q $$SEND^DGENQRY1(DFN)
 ;
LOCK(DFN) ;
 ;Description: Locks a record in the ENROLLMENT QUERY file.
 ;Input:
 ;  DFN - ien of record  in PATIENT file.
 ;Output:
 ;  Function Value - 1 if successful, 0 otherwise.
 ;
 I $G(DFN) L +^DGEN(27.12,DFN):3
 Q $T
 ;
UNLOCK(DFN) ;
 ;Description: Releases a lock set by $$LOCK.
 ;Input:
 ;  DFN - ien of record in the PATIENT file.
 ;Output: None
 ;
 I $G(DFN) L -^DGEN(27.12,DFN)
 Q
 ;
PENDING(DFN) ;
 ;Description: Used to determine if, for a given patient, there is
 ;an enrollment query pending (STATUS=TRANSMITTED).
 ;
 N DGQRY,PENDING
 S PENDING=0
 I $$GET^DGENQRY($$FINDLAST($G(DFN)),.DGQRY) I 'DGQRY("STATUS") S PENDING=1
 Q PENDING
 ;
FINDMSG(MSGID) ;
 ;Description: Used to find a record in the ENROLLMENT QUERY LOG file,
 ;give the unique message id assigned to the query by the HL7 package.
 ;
 ;Input:
 ;  MSGID - the unique id assigned to the query by the HL7 package and stored in the ENROLLMENT QUERY LOG as the MESSAGE ID field.
 ;
 ;Output:
 ;  Function Value - If successful, returns the ien of the record in the file, otherwise returns 0 on failure.
 Q:($G(MSGID)="") 0
 Q $O(^DGEN(27.12,"C",MSGID,0))
 ;
FINDLAST(DFN) ;
 ;
 ;Description:  Finds the last query sent for a patient.
 ;Input:
 ;  DFN - ien of record in the PATIENT file, identifies the patient to
 ;        find the query for.
 ;Output:
 ;  Function Value - If successful, returns the ien of the record in the
 ;   file, otherwise returns 0 on failure.
 ;
 Q:'$G(DFN) 0
 N TIME
 S TIME=$O(^DGEN(27.12,"ADT",DFN,9999999.999999),-1)
 Q:'TIME 0
 Q $O(^DGEN(27.12,"ADT",DFN,TIME,0))
 ;
GET(IEN,DGQRY) ;
 ;Description: Used to obtain a record in the ENROLLMENT QUERY LOG file
 ;The values are returned in the PLOG() array.
 ;
 ;Input:
 ;  IEN -of a record in the ENROLLMENT QUERY LOG file.
 ;
 ;Output:
 ;  Function Value - 1 on success, 0 on failure.
 ;  DGQRY() array, pass by reference.  Subscripts are
 ;   "DFN" - PATIENT field
 ;   "SENT" - DT/TM SENT field
 ;   "STATUS" - STATUS field
 ;   "MSGID" - MESSAGE ID field
 ;   "RESPONSE" - DT/TM RESPONSE
 ;   "RESPONSE ID" - MSG ID OF RESPONSE
 ;   "NOTIFY" - NOTIFY field
 ;   "FIRST" - FIRST DT/TM field
 ;
 ;
 N NODE,SUCCESS
 K DGQRY
 S SUCCESS=1
 I '$G(IEN) S SUCCESS=0
 S NODE=$S(SUCCESS:$G(^DGEN(27.12,IEN,0)),1:"")
 S DGQRY("DFN")=$P(NODE,"^")
 S DGQRY("SENT")=$P(NODE,"^",2)
 S DGQRY("STATUS")=$P(NODE,"^",3)
 S DGQRY("MSGID")=$P(NODE,"^",5)
 S DGQRY("RESPONSE")=$P(NODE,"^",6)
 S DGQRY("RESPONSEID")=$P(NODE,"^",7)
 S DGQRY("NOTIFY")=$P(NODE,"^",8)
 S DGQRY("FIRST")=$P(NODE,"^",9)
 S DGQRY("ERROR")=$P($G(^DGEN(27.12,IEN,10)),"^")
 Q SUCCESS
 ;
LOG(DGQRY) ;
 ;Description: Creates a record in the ENROLLMENT QUERY LOG file from the
 ;values contained in the DGQRY() array.  Note: this function does not
 ;lock the ENROLLMENT QUERY LOG file for the patient.  It should be
 ;locked before calling this function.
 ;
 ;Input:
 ;  DGQRY - this array should contain values for all the subscripts
 ;          defined for the DGQRY array.  (pass by reference)
 ;
 ;Output:
 ;  Function Value - If successful, returns the ien of the newly created
 ;                    record, otherwise returns 0.
 ;
 N DATA
 S DATA(.01)=DGQRY("DFN")
 S DATA(.02)=DGQRY("SENT")
 S DATA(.03)=DGQRY("STATUS")
 S DATA(.05)=DGQRY("MSGID")
 S DATA(.06)=DGQRY("RESPONSE")
 S DATA(.07)=DGQRY("RESPONSEID")
 S DATA(.08)=DGQRY("NOTIFY")
 S DATA(.09)=DGQRY("FIRST")
 Q $$ADD^DGENDBS(27.12,,.DATA)
 ;
DELETE(IEN) ;
 ;Description:  Deletes the record in the ENROLLMENT QUERY LOG file whose ien=IEN.
 ;
 ;Input:
 ;  IEN - the internal entry number of the record.
 ;
 ;Output:
 ;  Function Value - 1 on success, 0 on failure.
 ;
 Q:'$G(IEN) 0
 N DIK,DA
 S DIK="^DGEN(27.12,"
 S DA=IEN
 D ^DIK
 Q 1
 ;
SETADT1(IEN,DFN) ;
 ;set logic for the ADT x-ref of the ENROLLMENT QUERY LOG
 ;
 Q:'DFN
 N SENT
 S SENT=$P($G(^DGEN(27.12,IEN,0)),"^",2)
 Q:'SENT
 S ^DGEN(27.12,"ADT",DFN,SENT,IEN)=""
 Q
KILLADT1(IEN,DFN) ;
 ;kill logic for the ADT x-ref of the ENROLLMENT QUERY LOG
 ;
 Q:'DFN
 N SENT
 S SENT=$P($G(^DGEN(27.12,IEN,0)),"^",2)
 Q:'SENT
 K ^DGEN(27.12,"ADT",DFN,SENT,IEN)
 Q
SETADT2(IEN,SENT) ;
 ;set logic for the ADT x-ref of the ENROLLMENT QUERY LOG
 ;
 Q:'SENT
 N DFN
 S DFN=$P($G(^DGEN(27.12,IEN,0)),"^")
 Q:'DFN
 S ^DGEN(27.12,"ADT",DFN,SENT,IEN)=""
 Q
 ;
KILLADT2(IEN,SENT) ;
 ;kill logic for the ADT x-ref of the ENROLLMENT QUERY LOG
 ;
 Q:'SENT
 N DFN
 S DFN=$P($G(^DGEN(27.12,IEN,0)),"^")
 Q:'DFN
 K ^DGEN(27.12,"ADT",DFN,SENT,IEN)
 Q
 ;
SETADS1(IEN,STATUS) ;
 ;set logic for the ADS x-ref of the ENROLLMENT QUERY LOG
 ;
 Q:STATUS
 N SENT
 S SENT=$P($P($G(^DGEN(27.12,IEN,0)),"^",2),".")
 Q:'SENT
 S ^DGEN(27.12,"ADS",SENT,IEN)=""
 Q
KILLADS1(IEN,STATUS) ;
 ;kill logic for the ADS x-ref of the ENROLLMENT QUERY LOG
 ;
 Q:STATUS
 N SENT
 S SENT=$P($P($G(^DGEN(27.12,IEN,0)),"^",2),".")
 Q:'SENT
 K ^DGEN(27.12,"ADS",SENT,IEN)
 Q
SETADS2(IEN,SENT) ;
 ;set logic for the ADS x-ref of the ENROLLMENT QUERY LOG
 ;
 S SENT=$P(SENT,".")
 Q:'SENT
 N STATUS
 S STATUS=$P($G(^DGEN(27.12,IEN,0)),"^",3)
 Q:STATUS
 S ^DGEN(27.12,"ADS",SENT,IEN)=""
 Q
 ;
KILLADS2(IEN,SENT) ;
 ;kill logic for the ADS x-ref of the ENROLLMENT QUERY LOG
 ;
 S SENT=$P(SENT,".")
 Q:'SENT
 N STATUS
 S STATUS=$P($G(^DGEN(27.12,IEN,0)),"^",3)
 Q:STATUS
 K ^DGEN(27.12,"ADS",SENT,IEN)
 Q
 ;
ON(DGON) ;
 ;check to see if the ENROLLMENT QUERY ACTIVE? switch is on or off
 ;returns 0 if not set to transmit queries to HEC
 ;returns 1 if set to transmit queries to HEC
 ;
 N DGON,DA
 S DGON=0
 S DA=$O(^IVM(301.9,0))
 I DA,$P($G(^IVM(301.9,DA,15)),"^") S DGON=1
 Q DGON
 ;
TURNON ;put 1 in the new ENROLLMENT QUERY ACTIVE? field (#15) of the
 ;IVM SITE PARAMETER file (#301.9)
 ;
 N DA,DATA
 S DA=$O(^IVM(301.9,0))
 S DATA(15)=1
 I $$UPD^DGENDBS(301.9,DA,.DATA) ;else the update failed
 Q
 ;
TURNOFF ;put 0 in the new ENROLLMENT QUERY ACTIVE? field (#15) of the
 ;IVM SITE PARAMETER file (#301.9)
 ;
 N DA,DATA
 S DA=$O(^IVM(301.9,0))
 S DATA(15)=0
 I $$UPD^DGENDBS(301.9,DA,.DATA) ;else the update failed
 Q
