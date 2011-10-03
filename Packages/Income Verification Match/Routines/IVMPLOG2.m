IVMPLOG2 ;ALB/CJM - API for IVM PATIENT file; 4-SEP-97
 ;;2.0;INCOME VERIFICATION MATCH;**9,17**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
CLOSE(IEN,REASON,SOURCE) ;
 ;Description: Sets the value of the STOP FLAG field to 1 for a
 ;particular record in  the IVM PATIENT file, as well as setting related
 ;fields. This has the effect of stopping updates to a particular
 ;IVM PATIENT record for some types of events, but not for enrollment
 ;events.
 ;
 ;Input:
 ;  IEN - internal entry number of a record in the IVM PATIENT file.
 ;  REASON - ien of record in the IVM CASE CLOSURE REASON file (#301.93)
 ;  SOURCE - set of codes, 1= IVM CENTER (HEC), 2 = DHCP (local site)
 ;
 ;Output:  
 ;  Function Value - 1 on success, 0 on failure.
 ;
 N DATA,ERROR
 I $G(REASON)'="",'$$TESTVAL^DGENDBS(301.5,1.01,REASON) Q 0
 I $G(SOURCE)'="",'$$TESTVAL^DGENDBS(301.5,1.02,SOURCE) Q 0
 Q:'$$LOCK^IVMPLOG($G(IEN)) 0
 S DATA(.04)=1
 S DATA(1.01)=$G(REASON)
 S DATA(1.02)=$G(SOURCE)
 S DATA(1.03)=$$NOW^XLFDT
 S ERROR=$$UPD^DGENDBS(301.5,IEN,.DATA)
 D UNLOCK^IVMPLOG(IEN)
 Q ERROR
 ;
DELETE(IEN) ;
 ;Description: Used to delete a record in the IVM PATIENT file.
 ;
 ;Input:
 ;   IEN - the internal entry number for a record in the IVM PATIENT file
 ;Output:
 ;  Function Value - 1 on success, 0 on failure
 ;
 Q:'$G(IEN) 1
 ;
 Q:'$$LOCK^IVMPLOG(IEN) 0
 ;
 N DIK,DA
 S DIK="^IVM(301.5,"
 S DA=IEN
 D ^DIK
 D UNLOCK^IVMPLOG(IEN)
 Q 1
 ;
ADDFUTR(MTIEN) ;
 ;Adds a future test to the IVM Patient file.  MTIEN is the ien
 ;of the future test in the Annual Means Test file
 ;
 Q:'$G(MTIEN)
 ;
 N NODE,DFN,DATE,IVMPAT,DATA,YEAR,TYPE
 S NODE=$G(^DGMT(408.31,MTIEN,0))
 S DATE=+NODE
 Q:'DATE
 S YEAR=($E(DATE,1,3)-1)
 S DFN=$P(NODE,"^",2)
 Q:('DFN)
 S TYPE=$P(NODE,"^",19)
 I TYPE'=1,TYPE'=2 Q
 S IVMPAT=$$LOG^IVMPLOG(DFN,YEAR)
 Q:'IVMPAT
 S:(TYPE=1) DATA(.06)=MTIEN
 S:(TYPE=2) DATA(.07)=MTIEN
 I $$UPD^DGENDBS(301.5,IVMPAT,.DATA)
 Q
