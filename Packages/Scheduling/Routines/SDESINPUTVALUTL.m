SDESINPUTVALUTL  ;ALB/RRM - VISTA SCHEDULING INPUT VALIDATION UTILITY; Jun 10, 2022@15:02
 ;;5.3;Scheduling;**819,823,824,827,828**;Aug 13, 1993;Build 8
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$GETS^DIQ       is supported by IA #2056
 ; Reference to GETS^DIQ         is supported by IA #2056
 ; Reference to $$FIND1^DIC      is supported by IA #2051
 ; Reference to ENCODE^XLFJSON   is supported by IA #6682
 ; Reference to $$GETICN^MPIF001 is supported by IA #2701
 ; Reference to ^ICDEX           is supported by IA #5747
 ;
 Q  ;No Direct Call
 ;
VALIDATEMODALITY(SDAPTREQ,MODALITY) ;Retrieve the Modality set of codes
 ; Input : MODALITY - The internal/external set of code value
 ; Output: None
 ;
 N SDERR,I,SDMODSOC,YY,RESULT,ERROR,FOUND
 S (ERROR,FOUND)=0
 S SDMODSOC=$$GET1^DID(409.85,6,,"SET OF CODES",,"SDERR")
 I $D(SDERR) S ERROR=1 D ERRLOG^SDESJSON(.SDAPTREQ,224) Q ERROR
 ;check if the modality set of code passed in are valid
 F I=1:1:$L(SDMODSOC,":") D
 . S YY=$P($P(SDMODSOC,";",I),":")
 . I YY=MODALITY S MODALITY=YY,FOUND=1
 I $G(MODALITY)'="",'FOUND S ERROR=1 D ERRLOG^SDESJSON(.SDAPTREQ,224)
 Q ERROR
 ;
GETRES(SDCL,INACT)  ;get resource for clinic - SDEC RESOURCE
 N SDHLN,SDI,SDNOD,SDRES,SDRES1
 S (SDRES,SDRES1)=""
 S SDHLN=$P($G(^SC(SDCL,0)),U,1)
 Q:SDHLN="" ""
 S SDI="" F  S SDI=$O(^SDEC(409.831,"ALOC",SDCL,SDI)) Q:SDI=""  D  Q:SDRES'=""
 . S SDNOD=$G(^SDEC(409.831,SDI,0))
 . I '$G(INACT) Q:$$GET1^DIQ(409.831,SDI_",",.02)="YES"
 . S:SDRES1="" SDRES1=SDI
 . Q:$P($P(SDNOD,U,11),";",2)'="SC("
 . S SDRES=SDI
 I SDRES="",SDRES1'="" S SDRES=SDRES1
 Q SDRES
 ;
VALIDATEEAS(ERRORS,SDEAS) ;Validate SDEAS
 S SDEAS=$G(SDEAS,"")
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL(SDEAS)
 I SDEAS=-1 D ERRLOG^SDESJSON(.ERRORS,142) Q
 Q
 ;
LAST4SSN(DFN) ;Retrieve the last 4 SSN of a patient
 N LAST4SSN
 S LAST4SSN=$$GET1^DIQ(2,DFN_",",.09,"E")
 I LAST4SSN["P" S LAST4SSN=$E(LAST4SSN,6,10) Q LAST4SSN
 S LAST4SSN=$E(LAST4SSN,6,9)
 Q LAST4SSN
 ;
GETPATICN(DFN) ;Retrieve Patient ICN
 N PATIENTICN
 S PATIENTICN=$$GETICN^MPIF001(DFN)
 S PATIENTICN=$S(+PATIENTICN>0:PATIENTICN,1:"")
 Q PATIENTICN
 ;
VALIDATEDFN(ERRORS,DFN) ;
 I DFN="" D ERRLOG^SDESJSON(.ERRORS,1) Q
 I DFN'="",'$D(^DPT(DFN,0)) D ERRLOG^SDESJSON(.ERRORS,2) Q
 Q
 ;
GETDIAGSTAT(DIAG) ;Get the current Diagnosis status
 N DIAGCODENUM,DIAGCODESTAT
 S DIAGCODENUM=$$GET1^DIQ(80,$S(+DIAG:DIAG,1:+$$CODEN^ICDEX(DIAG,80)),.01)
 S DIAGCODESTAT=$P($$ICDDX^ICDEX(DIAGCODENUM),"^",10)
 Q +DIAGCODESTAT
 ;
DELDIAGNOSIS(SCIEN) ;Remove existing Diagnosis prior to updating new ones
 N DIK,DA
 Q:$G(SCIEN)=""
 S DA(1)=SCIEN
 S DIK="^SC("_DA(1)_",""DX"","
 S DA=0 F  S DA=$O(^SC(SCIEN,"DX",DA)) Q:'DA  D ^DIK
 Q
 ;
