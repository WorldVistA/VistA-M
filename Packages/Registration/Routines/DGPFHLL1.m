DGPFHLL1 ;ALB/RPM - PRF HL7 EVENT LOG API'S ; 2/23/06
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 Q
 ;
GETEVNT(DGLIEN,DGPFL) ;retrieve a given record from PRF HL7 EVENT LOG (#26.21)
 ;
 ;  Input:
 ;    DGLIEN - IEN of PRF HL7 EVENT (#26.21)
 ;
 ;  Output:
 ;   Function value - 1 on success; 0 on failure
 ;    DGPFL - array of event data fields
 ;            Subscript  Field#
 ;            ---------  ------
 ;            "DFN"      .01
 ;            "EDT"      .02
 ;            "STAT"     .03
 ;
 N DGERR   ;error array
 N DGFLDS  ;field result array
 N DGIENS  ;FM IENS string
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 I $G(DGLIEN),$D(^DGPF(26.21,DGLIEN)) D
 . S DGIENS=DGLIEN_","
 . D GETS^DIQ(26.21,DGIENS,"**","IEZ","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . S DGRSLT=1
 . S DGPFL("DFN")=$G(DGFLDS(26.21,DGIENS,.01,"I"))_U_$G(DGFLDS(26.21,DGIENS,.01,"E"))
 . S DGPFL("EDT")=$G(DGFLDS(26.21,DGIENS,.02,"I"))_U_$G(DGFLDS(26.21,DGIENS,.02,"E"))
 . S DGPFL("STAT")=$G(DGFLDS(26.21,DGIENS,.03,"I"))_U_$G(DGFLDS(26.21,DGIENS,.03,"E"))
 ;
 Q DGRSLT
 ;
GETSTAT(DGDFN) ;retrieve event status for a given patient
 ;This function retrieves the internal value of the CURRENT STATUS
 ;(#.03) field in the PRF HL7 EVENT (#26.21) file and returns it as the
 ;function value.
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - returns CURRENT STATUS field value in Internal
 ;                    format on success; otherwise returns ""
 ;
 N DGERR  ;DIQ error array
 ;
 Q:'+$G(DGDFN) ""
 Q $$GET1^DIQ(26.21,$$FNDEVNT(DGDFN)_",",.03,"I","","DGERR")
 ;
FNDEVNT(DGDFN) ;find PRF HL7 EVENT (#26.21) file record number
 ;This function finds and returns the PRF HL7 EVENT (#26.21) file record
 ;number for a given patient.
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - IEN of PRF HL7 EVENT (#26.21) file on success;
 ;                    0 on failure
 ;
 N DGIEN  ;function value
 ;
 I +$G(DGDFN) D
 . S DGIEN=$O(^DGPF(26.21,"B",DGDFN,0))
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
STOEVNT(DGDFN,DGSTAT,DGERR) ;store event in PRF HL7 EVENT (#26.21) file
 ;
 ;  Input:
 ;    DGDFN - (required) pointer to patient in PATIENT (#2) file
 ;   DGSTAT - (optional) event status [default = INCOMPLETE]
 ;    DGERR - (optional) passed by reference to hold any FM errors
 ;
 ;  Output:
 ;    DGERR - only defined when FM call fails
 ;
 N DGFDA     ;FM FDA array
 N DGFDAIEN  ;UPDATE^DIE result
 N DGLIEN    ;PRF HL7 EVENT (#26.21) file IEN
 N DGRSLT    ;CHK^DIE result
 ;
 S DGSTAT=$S($G(DGSTAT)]"":DGSTAT,1:"I")
 I $G(DGDFN),$D(^DPT(DGDFN,0)) D
 . S DGLIEN=$$FNDEVNT(DGDFN)
 . D CHK^DIE(26.21,.03,,DGSTAT,.DGRSLT,"DGERR")
 . Q:$D(DGERR)
 . I DGLIEN D
 . . S DGFDA(26.21,DGLIEN_",",.03)=DGSTAT
 . . D FILE^DIE("","DGFDA","DGERR")
 . E  D
 . . S DGFDA(26.21,"+1,",.01)=DGDFN
 . . S DGFDA(26.21,"+1,",.02)=$$NOW^XLFDT()
 . . S DGFDA(26.21,"+1,",.03)=DGSTAT
 . . D UPDATE^DIE("","DGFDA","DGFDAIEN","DGERR")
 ;
 Q
 ;
LOCK(DGIEN) ;lock HL7 event record
 ;This function locks a single PRF HL7 EVENT (#26.21) file record
 ;to prevent more than one PRF query being run at a time.
 ;
 ;  Input:
 ;    DGIEN - IEN of PRF HL7 EVENT (#26.21) file record
 ;
 ;  Output:
 ;   Function value - 1 on success; 0 on failure
 ;
 I $G(DGIEN) L +^DGPF(26.21,DGIEN):2
 ;
 Q $T
 ;
UNLOCK(DGIEN) ;unlock HL7 event record
 ;This procedure releases a lock on a PRF HL7 EVENT (#26.21) file record
 ;created by $$LOCK.
 ;
 ;  Input:
 ;    DGIEN - IEN of PRF HL7 EVENT (#26.21) file record
 ;
 ;  Output:
 ;
 I $G(DGIEN) L -^DGPF(26.21,DGIEN)
 Q
 ;
ISINCOMP(DGIEN) ;is the HL7 event status INCOMPLETE?
 ;
 ;  Input:
 ;    DGIEN - IEN of PRF HL7 EVENT (#26.21) file record
 ;
 ;  Output:
 ;   Function value - return "1" when status is INCOMPLETE;
 ;                    otherwise return "0".
 ;
 Q $D(^DGPF(26.21,"ASTAT","I",+$G(DGIEN)))
