DGENSEC ;ALB/KCL/CKN - Patient Security API's ; 5/11/05 12:02pm
 ;;5.3;Registration;**222,653**;Aug 13,1993;Build 2
 ;
 ;
LOCK(DFN) ;
 ; Description: Used to lock the DG SECURITY LOG record for a patient
 ;
 ;  Input:
 ;   DFN - internal entry number of record in the DG SECURITY LOG file
 ;
 ; Output:
 ;   Function Value: Returns 1 if the DG SECURITY LOG record can be
 ;     locked, otherwise returns 0 on failure
 ;
 I $G(DFN) L +^DGSL(38.1,DFN,0):2
 Q $T
 ;
 ;
UNLOCK(DFN) ;
 ; Description: Used to unlock the DG SECURITY LOG record for a patient
 ;
 ;  Input:
 ;   DFN - internal entry number of record in the DG SECURITY LOG file
 ;
 ; Output:
 ;   None
 ;
 I $G(DFN) L -^DGSL(38.1,DFN,0)
 Q
 ;
 ;
FINDSEC(DFN) ;
 ; Description: Used to find a record in the DG SECURITY LOG file
 ;
 ;  Input:
 ;   DFN - Patient IEN
 ;
 ; Output:
 ;   Function Value: If successful, returns internal entry number of
 ;              DG SECURITY LOG file, otherwise returns 0 on failure
 ;
 Q:'$G(DFN)="" 0
 Q +$O(^DGSL(38.1,"B",DFN,0))
 ;
 ;
GET(SECIEN,DGSEC) ;
 ; Description: Used to obtain a record in the DG SECURITY LOG file.  The values will be returned in the DGSEC() array.
 ;
 ;  Input:
 ;   SECIEN - internal entry number of record in the DG SECURITY LOG file
 ;
 ; Output:     
 ;  DGSEC - the patient security array, passed by reference
 ;   subscripts are:
 ;      "DFN"        Patient
 ;      "LEVEL"      Security Level
 ;      "USER"       Security Assigned By
 ;      "DATETIME"   Date/Time Security Assigned
 ;      "SOURCE"     Secuity Source
 ;
 N SUB,NODE0
 K DGSEC S DGSEC=""
 ;
 I '$G(SECIEN) D  Q 0
 .F SUB="DFN","LEVEL","USER","DATETIME","SOURCE" S DGSEC(SUB)=""
 ;
 S NODE0=$G(^DGSL(38.1,SECIEN,0))
 S DGSEC("DFN")=$P(NODE0,"^")
 S DGSEC("LEVEL")=$P(NODE0,"^",2)
 S DGSEC("USER")=$P(NODE0,"^",3)
 S DGSEC("DATETIME")=$P(NODE0,"^",4)
 S DGSEC("SOURCE")=$P(NODE0,"^",5)
 Q 1
 ;
 ;
STORE(DGSEC,ERROR) ;
 ; Description: Creates a new entry in the DG SECURITY LOG file.
 ;
 ;  Input:
 ;   DGSEC - as array containing the DG SECURITY LOG record,
 ;           passed by reference
 ;
 ; Output:
 ;   Function Value: Returns internal entry number of the entry created,
 ;                   otherwise 0 is returned
 ;           ERROR - (optional) if not successful, an error msg is
 ;                    returned, pass by reference
 ;
 N DA,DD,DIC,DIE,DLAYGO,DO,DR,X,Y
 S DIC(0)="L",(X,DINUM)=DGSEC("DFN"),DIC="^DGSL(38.1,",DLAYGO=38.1
 D FILE^DICN
 I Y=-1 S ERROR="FILEMAN UNABLE TO CREATE DG SECURITY LOG RECORD" Q 0
 S DA=+Y
 ;
 I 'DA S ERROR="FILEMAN UNABLE TO CREATE DG SECURITY LOG RECORD" Q 0
 ;
 ; edit/update the new record
 I '$$UPDATE(DA,.DGSEC,.ERROR) S ERROR="FILEMAN UNABLE TO CREATE DG SECURITY LOG RECORD" Q 0
 ;
 ; quit with ien
 Q DA
 ;
 ;
UPDATE(DFN,DGSEC,ERROR) ;
 ; Description: Updates a DG SECURITY LOG record for a patient. This
 ;  function locks the DG SECURITY LOG record and releases the lock
 ;  when the update is complete. 
 ;
 ;  Input:
 ;   DFN   - internal entry number of record in the DG SECURITY LOG file
 ;   DGSEC - the DG SECURITY LOG array, passed by reference
 ;
 ; Output:
 ;  Function Value - Returns 1 if successful, otherwise 0
 ;           ERROR - if not successful, an error message is returned,
 ;                   pass by reference
 ;
 N SUCCESS,DATA
 S SUCCESS=1
 S ERROR=""
 ;
 D  ; drops out if an invalid condition is found
 .I $G(DFN),$D(^DGSL(38.1,DFN,0))
 .E  S SUCCESS=0,ERROR="DG SECURITY LOG RECORD NOT FOUND" Q
 .I '$$LOCK(DFN) S SUCCESS=0,ERROR="SECURITY LOG RECORD IS LOCKED, CAN NOT BE EDITED" Q
 .S DATA(2)=DGSEC("LEVEL")
 .S DATA(3)=DGSEC("USER")
 .S DATA(4)=DGSEC("DATETIME")
 .S DATA(5)=DGSEC("SOURCE")
 .I '$$UPD^DGENDBS(38.1,DFN,.DATA) S ERROR="FILEMAN UNABLE TO PERFORM UPDATE",SUCCESS=0 Q
 ;
 D UNLOCK(DFN)
 ;
 Q SUCCESS
 ;
 ;
CHECK(DGSEC,ERROR) ;
 ; Description: Performs validation checks on DG SECURITY LOG record
 ;  contained in the DGSEC array.
 ;
 ;  Input:
 ;   DGSEC - as the patient security array, passed by reference
 ;
 ; Output:
 ;   Function Value - Returns 1 if validation checks passed, 0 otherwise
 ;            ERROR - if validation checks fail, an error message is
 ;                    returned, pass by reference
 ;
 N VALID,RESULT,EXTERNAL
 S VALID=1,ERROR=""
 ;
 D  ; drops out of block if an invalid condition is found
 .;
 .I '$G(DGSEC("DFN")) S VALID=0,ERROR="PATIENT NOT FOUND IN DATABASE" Q
 .I '$D(^DPT(DGSEC("DFN"),0)) S VALID=0,ERROR="PATIENT NOT FOUND IN DATABASE" Q
 .;
 .; check for required fields
 .I $G(DGSEC("LEVEL"))="" S VALID=0,ERROR="REQUIRED FIELD 'SECURITY LEVEL' MISSING" Q
 .I $G(DGSEC("USER"))="" S VALID=0,ERROR="REQUIRED FIELD 'SECURITY ASSIGNED BY' MISSING" Q
 .I $G(DGSEC("DATETIME"))="" S VALID=0,ERROR="REQUIRED FIELD 'DATE/TIME SECURITY ASSIGNED' MISSING" Q
 .I $G(DGSEC("SOURCE"))="" S VALID=0,ERROR="REQUIRED FIELD 'SECURITY SOURCE' MISSING" Q
 .;
 .; apply consistency rules
 .I DGSEC("LEVEL")'=1 S VALID=0,ERROR="'SECURITY LEVEL' OTHER THAN SENSITIVE NOT ALLOWED" Q
 .;Remove consistency check for SOURCE - DG*5.3*653
 .;I DGSEC("SOURCE")'="AAC" S VALID=0,ERROR="'SECURITY SOURCE' OTHER THAN AAC NOT ALLOWED" Q
 .;
 .; check if field values are valid
 .S EXTERNAL=$$EXTERNAL^DILFD(38.1,2,"",DGSEC("LEVEL"))
 .I EXTERNAL="" S VALID=0,ERROR="'SECURITY LEVEL' NOT VALID" Q
 .S EXTERNAL=$$EXTERNAL^DILFD(38.1,4,"",DGSEC("DATETIME"))
 .I EXTERNAL="" S VALID=0,ERROR="'DATE/TIME SECURITY ASSIGNED' NOT VALID" Q
 .I ($L($G(DGSEC("SOURCE")))<1)!($L($G(DGSEC("SOURCE")))>65) S VALID=0,ERROR="'SECURITY SOURCE' NOT VALID" Q
 ;
 Q VALID
 ;
 ;
EXT(SUB,VALUE) ; Description: Given the subscript used in the PATIENT SECURITY
 ; array and a field value, this function returns the external
 ; representation of the value, as defined in the fields output
 ; transform of the DG SECURITY LOG file.
 ;
 ;  Input:
 ;     SUB - array subscript defined for the PATIENT SECURITY object
 ;   VALUE - field value
 ;
 ; Output:
 ;  Function Value - Returns the external value of the field
 ;
 Q:(('$G(SUB)="")!($G(VALUE)="")) ""
 ;
 N FIELD
 S FIELD=$S(SUB="DFN":.01,SUB="LEVEL":2,SUB="USER":3,SUB="DATETIME":4,SUB="SOURCE":5,1:"")
 ;
 Q:(FIELD="") ""
 ;
 Q $$EXTERNAL^DILFD(38.1,FIELD,"F",VALUE)
