DGENUPL5 ;ALB/KCL/GSN - PROCESS INCOMING (Z11 EVENT TYPE) HL7 MESSAGES ; 5/6/03 2:45pm
 ;;5.3;Registration;**222,504,952**;08/13/93;Build 160
 ;
 ;DG*5.3*504 - Now, only updates the DG SECURITY LOG file #38.1 Zero
 ;             node, when SECURITY LEVEL [#2] goes from a Non-sensitive
 ;             value to a Sensitive value, i.e. (null or 0) to 1.
GETLOCKS(DFN) ;
 ; Description - Locks first the patient enrollment history, then the patient record. Used to synchronize the upload with registration and load/edit.
 ;
 ;Input: DFN - ien of patient record.
 ;Output: none
 ;
 N COUNT,DGIEN33
 F COUNT=1:1:500 Q:$$BEGUPLD^DGENUPL3(DFN)
 F COUNT=1:1:500 Q:$$LOCK^DGENA1(DFN)
 F COUNT=1:1:500 Q:$$LOCK^DGENPTA1(DFN)
 S DGIEN33=+$O(^DGOTH(33,"B",DFN,"")) I DGIEN33 F COUNT=1:1:500 Q:$$LOCK^DGOTHUT1(DGIEN33)  ; DG*5.3*952
 Q
 ;
 ;
UNLOCK(DFN) ;
 ; Description: releases the locks obtained by GETLOCKS()
 ;
 ;Input: DFN - ien of patient record
 ;Output: none
 ;
 N DGIEN33
 D ENDUPLD^DGENUPL3(DFN)
 D UNLOCK^DGENA1(DFN)
 D UNLOCK^DGENPTA1(DFN)
 S DGIEN33=+$O(^DGOTH(33,"B",DFN,"")) I DGIEN33 D UNLOCK^DGOTHUT1(DGIEN33) ; DG*5.3*952
 Q
 ;
 ;
SECUPLD(DFN,DGSEC,OLDSEC) ;
 ; Description: Upload a patient security record receieved from the
 ;              HEC. The consistency checks on the record are assumed
 ;              to have been completed.
 ;
 ;  Input:
 ;     DFN - PATIENT ien
 ;   DGSEC - as array containing the patient security record, pass
 ;           by reference
 ;
 ; Output:
 ;  OLDSEC - as array containing the patient security record, prior
 ;           to upload of security data from HEC, pass by reference
 ;   
 ;
 N SECIEN
 ;
 ; is there a local security log record for the patient?
 S SECIEN=$$FINDSEC^DGENSEC(DFN)
 ;
 ; if local security record, obtain record prior to upload
 I $$GET^DGENSEC(SECIEN,.OLDSEC)
 ;
 ; if no local security log record for the patient, create a new
 ; security log entry with HEC security
 I 'SECIEN D
 .I $$STORE^DGENSEC(.DGSEC)
 E  D
 .; otherwise update the existing security log entry with HEC security
 .; if new level = Yes and old level Not = Yes          (DG*5.3*504)
 .I $G(DGSEC("LEVEL"))=1,$G(OLDSEC("LEVEL"))'=1 D
 ..I $$UPDATE^DGENSEC(DFN,.DGSEC)
 .E  D
 ..; since no update occurring, then set arrays the same to prevent an
 ..; Audit record from being created later.
 ..M DGSEC=OLDSEC
 ;
 Q
