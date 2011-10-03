RAMAG02 ;HCIOFO/SG - ORDERS/EXAMS API (EXAM REQUEST) ; 4/8/08 3:28pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;##### ORDERS/REQUESTS AN EXAM
 ;
 ; .RAPARAMS       Reference to the API descriptor
 ;                 (see the ^RA01 routine for details).
 ;
 ; RADFN           Patient IEN (DFN).
 ;
 ; RAMLC           IEN of the imaging location (file #79.1).
 ;
 ; RAPROC          Radiology procedure and modifiers
 ;                   ^01: Procedure IEN in file #71
 ;                   ^02: Optional procedure modifiers (IENs in
 ;                   ...  the PROCEDURE MODIFIERS file (#71.2))
 ;                   ^nn:
 ;
 ; RADTE           Desired date for the exam (FileMan). If time is 
 ;                 provided, it is ignored. The date must be exact.
 ;
 ; RACAT           Exam category: internal value for the CATEGORY
 ;                 OF EXAM field (4) of the RAD/NUC MED ORDERS
 ;                 file (#75.1).
 ;
 ; REQLOC          IEN of the requesting location in the HOSPITAL
 ;                 LOCATION file (#44).
 ;
 ;                 For the inpatient exam category, location should
 ;                 be either an operating room or a ward.
 ;
 ;                 For the outpatient exam category, location should
 ;                 be either an operating room or a clinic.
 ;
 ; REQPHYS         IEN of the requesting physician in the NEW PERSON
 ;                 file (#200).
 ;
 ;                 This user should be active and have the PROVIDER
 ;                 key.
 ;
 ; RAREASON        Reason for study (see the REASON FOR STUDY
 ;                 field (1.1) of the file #75.1).
 ;
 ; [.RAMISC]       Reference to a local array containing miscellaneous
 ;                 request parameters.
 ;
 ;                 See the ^RAMAG routine for additional important
 ;                 details regarding this parameter.
 ;
 ; RAMISC(
 ;
 ;   "CLINHIST",   Text for the CLINICAL HISTORY FOR EXAM field (400)
 ;     Seq#)       of the file #75.1.
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "ISOLPROC")   Internal value for the ISOLATION PROCEDURES
 ;                 field (24) of the file #75.1.
 ;                 Required: Yes
 ;                 Default:  "n" (NO)
 ;
 ;   "PREGNANT")   Internal value for the PREGNANT field (13)
 ;                 of the file #75.1.
 ;                 Required: Only for female patients
 ;                 Default:  undefined for male patients,
 ;                           "u" for female patients.
 ;
 ;   "PREOPDT")    Internal date value (FileMan) for the PRE-OP 
 ;                 SCHEDULED DATE/TIME field (12) of the file #75.1.
 ;                 If seconds are provided, they are ignored. The
 ;                 date must be exact.
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "REQNATURE")  Internal value for the NATURE OF (NEW) ORDER
 ;                 ACTIVITY field (26) of the file #75.1.
 ;                 Required: Yes
 ;                 Default:  "s" (SERVICE CORRECTION)
 ;
 ;   "REQURG")     Internal value for the REQUEST URGENCY field (6)
 ;                 of the file #75.1.
 ;                 Required: Yes
 ;                 Default:  "9" (ROUTINE)
 ;
 ;   "TRANSPMODE") Internal value for the MODE OF TRANSPORT
 ;                 field (19) of the file #75.1.
 ;                 Required: Yes
 ;                 Default:  "w" (WHEEL CHAIR) if RACAT="I",
 ;                           "a" (AMBULATORY) otherwise
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  IEN of the order in the file #75.1
 ;
ORDER(RAPARAMS,RADFN,RAMLC,RAPROC,RADTE,RACAT,REQLOC,REQPHYS,RAREASON,RAMISC) ;
 N RAIMGTYI        ; Imaging type IEN (file #79.2)
 N RAMDIV          ; Radiology division IEN (file #79)
 ;
 N RAOIFN,RC,VA,VADM
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("$$ORDER^RAMAG02","!!")
 . D VARS^RAMAGU11("RADFN,RAMLC,RAPROC")
 . D VARS^RAMAGU11("RADTE,RACAT,REQLOC,REQPHYS")
 . D VARS^RAMAGU11("RAREASON")
 . D ZW^RAUTL22("RAMISC")
 ;--- Validate parameters
 S RC=$$VALIDATE^RAMAG02A()  Q:RC<0 RC
 ;
 ;--- Make sure that the patient is registered
 S RC=$$RAPTREG^RAMAGU04(RADFN)  Q:RC<0 RC
 ;
 ;--- Request the exam
 S RAOIFN=$$ORD^RAMAG02A()  Q:RAOIFN<0 RAOIFN
 ;
 ;--- Generate the HL7 message to create the OE/RR record
 D ZOERRHL7(RADFN,+RAPROC,RAOIFN,+REQLOC)
 ;
 ;--- Return IEN of the order
 Q RAOIFN
 ;
 ;+++++ GENERATES OE/RR HL7  MESSAGE
 ;
 ; RADFN           Patient IEN (DFN)
 ; RAPIFN          Radiology procedure IEN
 ; RAOIFN          IEN of the order in file #75.1
 ; RALIFN          Requesting location IEN in file #44
 ;
 ; NOTE: This is an internal procedure. Do not call it from
 ;       outside of this routine.
 ;
ZOERRHL7(RADFN,RAPIFN,RAOIFN,RALIFN) ;
 N DA,DE,DIC,DIDEL,DIE,DINUM,DLAYGO,DQ,DR,DTOUT,DUOUT,I,ORIFN,ORIT,ORL,ORPCL,ORPK,ORPURG,ORSTRT,ORSTS,ORTX,ORVP,RABLNK,RAMOD,RAORD0,RAPRCD,RASEX,X,Y
 ;--- Prepare "old style" parameters for an old
 ;--- version of the OE/RR (just in case)
 S RASEX=$P($G(VADM(5)),U)    ; Patient's sex ("F" or "M")
 S RAORD0=^RAO(75.1,RAOIFN,0) ; 0-node of the order
 ;--- Generate the HL7 message to create the OE/RR record
 D SETORD^RAORDU
 Q
