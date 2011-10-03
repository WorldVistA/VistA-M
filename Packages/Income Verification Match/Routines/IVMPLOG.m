IVMPLOG ;ALB/CJM,RTK,ERC - API for IVM PATIENT file; ; 8/15/08 12:49pm
 ;;2.0;INCOME VERIFICATION MATCH;**9,19,12,21,17,28,36,40,49,68,115**; 21-OCT-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
FIND(DFN,YEAR) ;
 ;Description: Looks up an entry in the IVM PATIENT file (#301.5).
 ;Input:
 ;  DFN - IEN in the PATIENT file.
 ;  YEAR - value for the INCOME YEAR field, a year in FM format.
 ;Output:
 ;  Function Value - returns IEN of record if found, NULL otherwise.
 ;
 Q:('$G(DFN)!'$G(YEAR)) ""
 ;
 N YR
 S YR=$E(YEAR,1,3)_"0000"
 Q $O(^IVM(301.5,"APT",DFN,YR,0))
 ;
LOCK(IEN) ;
 ;Description: Locks a record in the IVM PATIENT file.
 ;Input:
 ;  IEN - ien of record  in IVM PATIENT file.
 ;Output:
 ;  Function Value - 1 if successful, 0 otherwise.
 ;
 I $G(IEN) L +^IVM(301.5,IEN):3
 Q $T
 ;
UNLOCK(IEN) ;
 ;Description: Unlocks a record in the IVM PATIENT file.
 ;Input:
 ;  IEN - ien of record in the IVM PATIENT file.
 ;Output: None
 ;
 I $G(IEN) L -^IVM(301.5,IEN)
 Q
 ;
STATUS(IEN,EVENTS) ;
 ;Description: Returns the value of the TRANSMISSION STATUS field of the 
 ;  IVM PATIENT file.
 ;
 ;Input:
 ;  IEN - internal entry number of a record in the IVM PATIENT file
 ;Output:
 ;  Function Value -returns the value of the TRANSMISSION STATUS field
 ;  EVENTS - optional, pass by reference.  Will return the types of events logged.
 ;  EVENTS("IVM") - value of IVM EVENT field
 ;  EVENTS("DCD") - value of DCD EVENT field
 ;  EVENTS("ENROLL") - value of ENROLLMENT EVENT field
 ;
 ;
 S EVENTS("IVM")=""
 S EVENTS("DCD")=""
 S EVENTS("ENROLL")=""
 ;
 Q:'$G(IEN) ""
 ;
 N NODE
 S NODE=$G(^IVM(301.5,IEN,"E"))
 S EVENTS("IVM")=$P(NODE,"^")
 S EVENTS("DCD")=$P(NODE,"^",2)
 S EVENTS("ENROLL")=$P(NODE,"^",3)
 Q $P($G(^IVM(301.5,IEN,0)),"^",3)
 ;
SETSTAT(IEN,EVENTS,ERRMSG) ;
 ;Description: Sets the value of the TRANSMISSION STATUS field of the
 ;  IVM PATIENT file for a particular record to 0, meaning transmission
 ;  is requested.  If the case is closed, depending on the event types,
 ;  the TRANSMISSION STATUS may not be set.
 ;Input:
 ;  IEN - internal entry number of a record in the IVM PATIENT file.
 ;  EVENTS () - an array of reasons for transmission, pass by reference.
 ;  EVENTS("IVM") = 1 if transmission due to IVM criteria, 0 otherwise
 ;  EVENTS("DCD")=1 if transmission due to DCD criteria, 0 otherwise
 ;  EVENTS("ENROLL")=1 if transmission due to enrollment criteria, 0 otherwise
 ;Output:  
 ;  Function Value - 1 on success, 0 on failure.
 ;  ERRMSG - optional, pass by reference if needed, returns message on failure
 ;
 N DATA,CLOSED,SUCCESS
 ;
 I ($G(DGENUPLD)="ENROLLMENT/ELIGIBILITY UPLOAD IN PROGRESS") S ERRMSG="ENROLLMENT UPLOAD IN PROGRESS" Q 0
 ;
 I '$$LOCK($G(IEN)) S ERRMSG="UNABLE TO OBTAIN LOCK ON IVM PATIENT, TRY AGAIN LATTER" Q 0
 S CLOSED=$$CLOSED(IEN)
 S SUCCESS=0
 I ('CLOSED)!(1=$G(EVENTS("ENROLL"))) D
 .S DATA(.03)=0
 .I 'CLOSED D
 ..I $G(EVENTS("IVM"))=1 S DATA(30.01)=1
 ..I $G(EVENTS("DCD"))=1 S DATA(30.02)=1
 .I $G(EVENTS("ENROLL"))=1 S DATA(30.03)=1
 .S SUCCESS=$$UPD^DGENDBS(301.5,IEN,.DATA,.ERRMSG)
 E  S SUCCESS=0,ERRMSG="CASE IS CLOSED"
 D UNLOCK(IEN)
 Q SUCCESS
 ;
CLEAR(IEN,WHEN) ;
 ; Description: Sets the value of the TRANSMISSION STATUS field of the
 ;IVM PATIENT file for a particular record to 1, meaning transmission
 ;already occurred.
 ;
 ;Input:
 ;  IEN - internal entry number of record in IVM PATIENT file
 ;  WHEN - optional, date/time in FM format that transmission occurred
 ;Output:
 ;  Function Value - 1 on success, 0 on failure
 ; 
 N SUCCESS,PLOG,DATA
 Q:'$$LOCK($G(IEN)) 0
 Q:'$$GET(IEN,.PLOG) 0
 S DATA(.03)=1
 I PLOG("EVENTS","IVM")=1 S DATA(30.01)=2
 I PLOG("EVENTS","DCD")=1 S DATA(30.02)=2
 I PLOG("EVENTS","ENROLL")=1 S DATA(30.03)=2
 I $G(WHEN),((PLOG("FIRST")'>0)!(WHEN<PLOG("FIRST"))) S DATA(.05)=WHEN
 S SUCCESS=$$UPD^DGENDBS(301.5,IEN,.DATA)
 D UNLOCK(IEN)
 Q SUCCESS
 ;
GET(IEN,PLOG) ;
 ;Description: Used to obtain a record in the IVM PATIENT file.  The
 ;values are returned in the PLOG() array.
 ;Input:
 ;  IEN - internal entry number of a record in the IVM PATIENT file.
 ;Output:
 ;  Function Value - 1 on success, 0 on failure.
 ;  PLOG() array, pass by reference.  Subscripts are
 ;  "DFN" - value of the PATIENT field (#.01) which is the ien of record in the PATIENT file.
 ;  "YEAR" -  value of the INCOME YEAR field (#.02)
 ;  "STATUS" - value from the TRANSMISSIONS STATUS field (#.03)
 ;  "FIRST" -  value from the QUERY TRANSMISSION DATE/TIME field (#.05)
 ;  "CLOSE" - value from the STOP FLAG field (#.04)
 ;  "CLOSE","REASON" -  value from the CLOSURE REASON field (#301.93)
 ;  "CLOSE","SOURCE" - value of the CLOSURE SOURCE  field (#1.02)
 ;  "CLOSE","TIME" - value of the CLOSURE DATE/TIME field (#1.03)
 ;  "EVENTS","IVM" - value of the IVM EVENT field
 ;  "EVENTS","DCD" - value of the DCD EVENT field
 ;  "EVENTS","ENROLL" - value of the ENROLLMENT EVENT field
 ;
 N NODE
 Q:'$G(IEN) 0
 S NODE=$G(^IVM(301.5,IEN,0))
 Q:(NODE="") 0
 S PLOG("DFN")=$P(NODE,"^")
 S PLOG("YEAR")=$P(NODE,"^",2)
 S PLOG("STATUS")=$P(NODE,"^",3)
 S PLOG("FIRST")=$P(NODE,"^",5)
 S PLOG("CLOSE")=$P(NODE,"^",4)
 S NODE=$G(^IVM(301.5,IEN,1))
 S PLOG("CLOSE","REASON")=$P(NODE,"^")
 S PLOG("CLOSE","SOURCE")=$P(NODE,"^",2)
 S PLOG("CLOSE","TIME")=$P(NODE,"^",3)
 S NODE=$G(^IVM(301.5,IEN,"E"))
 S PLOG("EVENTS","IVM")=$P(NODE,"^")
 S PLOG("EVENTS","DCD")=$P(NODE,"^",2)
 S PLOG("EVENTS","ENROLL")=$P(NODE,"^",3)
 Q 1
 ;
CLOSED(IEN) ;
 ;Description: Returns the value of the STOP FLAG field of the
 ;IVM PATIENT file for a particular record, which indicates whether
 ;transmissions for certain events (but not enrollment events) should
 ;take place.
 ;
 ;Input:
 ;  IEN - internal entry number of a record in the IVM PATIENT file.
 ;Output:
 ;  Function Value - The value of the STOP FLAG field.
 ;
 Q:'$G(IEN) ""
 Q $P($G(^IVM(301.5,IEN,0)),"^",4)
 ;
LOG(DFN,YEAR,EVENTS) ;
 ;Description: Used to queue a patient for the nightly full transmission
 ;for a particular income year. If EVENTS is not passed, an entry in the 
 ;IVM PATIENT file will be created if it does not already exist, but
 ;the flag for transmission will not be set.
 ;
 ;Input:
 ;  DFN - ien of record in the PATIENT file.
 ;  YEAR -  income year in FM format.  This is the year that is to be
 ;  used when creating the full transmission message.
 ;  EVENTS () - an array of reasons for transmission, pass by reference.
 ;    EVENTS("IVM") = 1 if transmission due to IVM criteria, 0 otherwise
 ;    EVENTS(" "DCD")=1 if transmission due to DCD criteria, 0 otherwise
 ;    EVENTS("ENROLL")=1 if transmission due to enrollment criteria, 0 otherwise
 ;Output:
 ;  Function Value - internal entry number of the IVM PATIENT file record, or NULL if record could not be found or created.
 ;
 N IEN
 ;
 ;if the eligibility/enrollment upload is in progess, do nothing
 Q:($G(DGENUPLD)="ENROLLMENT/ELIGIBILITY UPLOAD IN PROGRESS") ""
 ;
 ;to be compatable with current software - in some places,
 ;YEAR passed is just 3 digits
 S:YEAR YEAR=$E(YEAR,1,3)_"0000"
 ;
 Q:'$$TESTVAL^DGENDBS(301.5,.01,DFN) ""
 Q:'$$TESTVAL^DGENDBS(301.5,.02,YEAR) ""
 ;
 ; check for an existing record in 301.5 for this income year...
 S IEN=$$FIND(DFN,YEAR)
 I 'IEN D
 .;need to create a new record
 .N DATA
 .L +^IVM(301.5,0):3
 .Q:'$T
 .S IEN=$$FIND(DFN,YEAR)
 .I IEN L -^IVM(301.5,0) Q
 .S DATA(.01)=DFN,DATA(.02)=YEAR,DATA(.04)=1,DATA(1.01)=5,DATA(1.02)=2,DATA(1.03)=$$NOW^XLFDT
 .S IEN=$$ADD^DGENDBS(301.5,,.DATA)
 .L -^IVM(301.5,0)
 I IEN,$D(EVENTS),$$SETSTAT(IEN,.EVENTS)
 Q IEN
 ;
DELETE(DFN,TESTDATE,MT,RX,HARDSHIP,LTC) ;
 ;Description: Used to notify HEC that deletion of a MT,RX Copay test,
 ;LTC copay exemption test or hardship has occurred
 ;
 ;Input:
 ;  DFN - ien of record in the PATIENT file.
 ;  TESTDATE - date of test
 ;  MT - if $D(MT),MT then a MT was deleted
 ;  RX - if $D(RX),RX then a RX copay test was deleted
 ;  HARDSHIP - if $D(HARDSHIP),HARDSHIP then a hardship was deleted
 ;  LTC - if $G(LTC) then a LTC copay exemption test was deleted
 ;Output: none
 ;
 N YEAR,IEN,DATA
 ;
 S YEAR=($E(TESTDATE,1,3)-1)_"0000"
 ;
 ;
 S IEN=$$FIND(DFN,YEAR)
 Q:'IEN
 I $D(HARDSHIP),HARDSHIP S DATA(.1)=TESTDATE
 I $D(MT),MT S DATA(.08)=TESTDATE
 I $D(RX),RX S DATA(.09)=TESTDATE
 I $G(LTC) S DATA(.11)=TESTDATE
 I $$UPD^DGENDBS(301.5,IEN,.DATA)
 Q
 ;
EVENT(DFN) ;
 ;Description: Called in response to enrollment events. Determines
 ;whether for this patient transmission is appropriate, and if so the
 ;patient is logged for transmission.
 ;
 ;Input: DFN
 ;Output: none
 ;
 Q:'$G(DFN)
 ;
 Q:'$$ON^IVMUPAR1  ;quit if enrollment events turned off
 ;
 ;don't want to log event if called due to file re-indexing
 I $D(DIU(0))!($D(DIK)&$D(DIKJ)&$D(DIKLK)&$D(DIKS)&$D(DIN)) Q
 ;
 ;if the eligibility/enrollment upload is in progess, or there is no enrollment, do nothing
 Q:($G(DGENUPLD)="ENROLLMENT/ELIGIBILITY UPLOAD IN PROGRESS")
 ;remove screen for non-vets, IVM 115 - ERC
 I '$$VET1^DGENPTA(DFN) S EVENTS("ENROLL")=1 I $$LOG(DFN,$$YEAR(DFN),.EVENTS) Q 
 I ('$$FINDCUR^DGENA(DFN)),('$$VET^DGENPTA(DFN)) Q
 N STATUS
 S STATUS=$$STATUS^DGENA(DFN)
 ; Purple Heart added status 21
 I $$VET1^DGENPTA(DFN)!(STATUS=1)!(STATUS=2)!(STATUS=9)!(STATUS=15)!(STATUS=16)!(STATUS=17)!(STATUS=18)!(STATUS=19)!(STATUS=20)!(STATUS=21)!(STATUS=23) D
 .N EVENTS
 .S EVENTS("ENROLL")=1
 .I $$LOG(DFN,$$YEAR(DFN),.EVENTS) ;no need to inform on success or failure
 Q
 ;
YEAR(DFN) ;
 ;Determines the income year to be used in the transmission 
 ;
 N YEAR
 S YEAR=$$LD^IVMUFNC4(DFN)
 S:YEAR YEAR=($E(YEAR,1,3)-1)_"0000"
 S:'YEAR YEAR=($E(DT,1,3)-1)_"0000"
 Q YEAR
