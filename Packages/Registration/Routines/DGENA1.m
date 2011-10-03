DGENA1 ;ALB/CJM,ISA/KWP - Enrollment API - File Data ;3/31/08 12:18pm
 ;;5.3;Registration;**121,147,232,671**;Aug 13,1993;Build 27
 ;PHASE II moved CHECK and TESTVAL to DGENA3
LOCK(DFN) ;
 ;Description: This lock is used to prevent another process from editing
 ;     a patient's enrollment, including the current enrollment and the
 ;     enrollment history.
 ;Input:
 ;  DFN - Patient IEN
 ;Output:
 ;  Function Value - Returns 1 if the lock was successful, 0 otherwise
 ;
 I $G(DFN) L +^DPT("ENROLLMENT",DFN):10
 Q $T
UNLOCK(DFN) ;
 ;Description: Used to release a lock created by $$LOCK.
 ;Input:
 ;  DFN - Patient IEN
 ;Output: None
 ;
 I $G(DFN) L -^DPT("ENROLLMENT",DFN)
 Q
STORE(DGENR,NOCHECK,ERRMSG) ;
 ;Description: Used to file a PATIENT ENROLLMENT record.  Consistency
 ;     checks are done unless NOCHECK=1.If the
 ;     enrollment passes the consistency checks specified the
 ;     PATIENT ENROLLMENT record will be created and the ien returned.
 ;     If the consistency checks are not passed, or a record can not
 ;     be created, 0 is returned. This call does NOT lock the record - 
 ;     call LOCK prior to STORE if the record needs to be locked. 
 ;Input :
 ;  DGENR - this local array represents a PATIENT ENROLLMENT (pass by reference)
 ;  NOCHECK - a flag, if NOCHECK=1 it means the consistency checks were done already, so do not do them again. (optional)
 ;  ERRMSG - error message on failure (optional, pass by reference)
 ;Output:
 ;  Function Value - returns the ien of the PATIENT ENROLLMENT record
 ;     created if successful , 0 otherwise
 N DIC,DA,DIE,Y,DR,DO,DD
 ;check that enrollment is valid before storing
 I $G(NOCHECK)'=1 Q:'$$CHECK^DGENA3(.DGENR,,.ERRMSG) 0
 ;create a new record
 S DIC(0)="",X=DGENR("APP"),DIC="^DGEN(27.11,"
 D FILE^DICN
 I Y=-1 S ERRMSG="FILEMAN UNABLE TO CREATE ENROLLMENT RECORD" Q 0
 S DA=+Y
 ;if failed to store record, exit
 Q:'DA 0
 ;edit the record
 I '$$EDIT^DGENA1A(DA,.DGENR) Q 0
 Q DA
STORECUR(DGENR,NOCHECK,ERRMSG) ;
 ;Description: Used to store an enrollment that has already been created
 ;     as a local array  into  the PATIENT ENROLLMENT file as the
 ;     patient's current enrollment.  If the enrollment passes the
 ;     consistency checks specified the enrollment record will be
 ;     created and the internal entry number returned. If the
 ;     consistency checks are not passed, or a record can not be
 ;     created, 0 will be returned
 ;Input :
 ;  DGENR - this local array represents a PATIENT ENROLLMENT and should
 ;     be passed by reference.
 ;  NOCHECK - a flag, if NOCHECK=1 it means the consistency checks were done already, so do not do them again. (optional)
 ;Output:
 ;  Function Value - returns the internal entry number of the PATIENT
 ;     ENROLLMENT record created if successful , 0 otherwise
 ;  ERRMSG - error message on failure (optional, pass by reference)
 N DGENRIEN,OK
 S OK=1
 I '$$LOCK($G(DGENR("DFN"))) S OK=0
 D:OK
 .S DGENRIEN=$$STORE(.DGENR,$G(NOCHECK),.ERRMSG)
 .I 'DGENRIEN S OK=0
 .D:OK
 ..N PRIOR
 ..;link enrollment record to the prior enrollment
 ..D:DGENR("PRIORREC") KILL^DGENA1A(27.11,DGENRIEN,.09,DGENR("PRIORREC"))
 ..S PRIOR=$$FINDCUR^DGENA(DGENR("DFN"))
 ..S $P(^DGEN(27.11,DGENRIEN,0),"^",9)=PRIOR
 ..D:PRIOR SET^DGENA1A(27.11,DGENRIEN,.09,PRIOR)
 ..;now link the patient record to the new current enrollment
 ..D:PRIOR KILL^DGENA1A(2,DGENR("DFN"),27.01,PRIOR)
 ..N DGENFDA
 ..S DGENFDA(2,DGENR("DFN")_",",27.01)=DGENRIEN
 ..D UPDATE^DIE("","DGENFDA","","ERR")
 D UNLOCK(DGENR("DFN"))
 Q $S(OK:DGENRIEN,1:0)
EDITCUR(DGENR) ;
 ;Description: Used to store an enrollment that has already been created
 ;     as a local array  into  the PATIENT ENROLLMENT file as the
 ;     patient's current enrollment. If the enrollment passes the
 ;     consistency checks specified the current enrollment record, if
 ;     it exists, will be overlaid by the enrollment contained in
 ;     DGENR, otherwise, if there is no current enrollment, a new
 ;     patient enrollment record will be created as the current
 ;     enrollment. If the consistency checks are not passed, or a
 ;     record can not be created, NULL will be returned.
 ;Input :
 ;  DGENR - this local array represents a PATIENT ENROLLMENT and
 ;     should be passed by reference.
 ;Output:
 ;  Function Value - returns the internal entry number of the PATIENT
 ;     ENROLLMENT record created if successful , 0 otherwise
 N DGENRIEN,OK
 S OK=$$LOCK($G(DGENR("DFN")))
 D:OK
 .S DGENRIEN=$$FINDCUR^DGENA(DGENR("DFN"))
 .I 'DGENRIEN D
 ..S OK=$$STORECUR(.DGENR)
 .E  D
 ..S OK=$$CHECK^DGENA3(.DGENR)
 ..I OK S OK=$$EDIT^DGENA1A(DGENRIEN,.DGENR)
 D UNLOCK(DGENR("DFN"))
 Q $S(OK:DGENRIEN,1:0)
