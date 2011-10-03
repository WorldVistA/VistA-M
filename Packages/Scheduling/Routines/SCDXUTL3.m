SCDXUTL3 ;ALB/JRP - ACRP ERROR CODE UTILITIES;08-OCT-1996
 ;;5.3;Scheduling;**68**;AUG 13, 1993
DEMOCODE(PTRCODE) ;Determine if NPCDB error code is related to a
 ; patient's demographic data or if it is related to the encounter data
 ;
 ;Input  : PTRCODE - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER ERROR CODE file (#409.76)
 ;Output : 1 - Error is related to patient's demographic data
 ;         0 - Error is related to the encounter data
 ;         0 - Bad input
 ;
 ;Check input
 S PTRCODE=+$G(PTRCODE)
 Q:('$D(^SD(409.76,PTRCODE,0))) 0
 ;Declare variables
 N ERRCODE,TMP,DEMOCODE,DEMOGRP
 ;Convert pointer to error code
 S ERRCODE=$P($G(^SD(409.76,PTRCODE,0)),"^",1)
 Q:(ERRCODE="") 0
 ;Establish series of codes that relate to patient demographic data
 F TMP=200,300,400,700,800,"000","B00","C00" S DEMOGRP(TMP)=1
 ;Convert error code to it's series range and determine if that range
 ;relates to patient demographic data
 S TMP=$E(ERRCODE,1)_"00"
 S DEMOCODE=+$G(DEMOGRP(TMP))
 ;Done
 Q DEMOCODE
 ;
DEMOERR(PTRERR) ;Determine if error is related to a patient's demographic
 ; data or if it is related to the encounter data
 ;
 ;Input  : PTRERR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                  ENCOUNTER ERROR file (#409.75)
 ;Output : 1 - Error is related to patient's demographic data
 ;         0 - Error is related to the encounter data
 ;         0 - Bad input
 ;
 ;Check input
 S PTRERR=+$G(PTRERR)
 Q:('$D(^SD(409.75,PTRERR,0))) 0
 ;Declare variables
 N PTRCODE,NODE
 ;Get pointer to TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file
 S NODE=$G(^SD(409.75,PTRERR,0))
 S PTRCODE=+$P(NODE,"^",2)
 ;Return whether or not error code is related to demographic data
 Q $$DEMOCODE(PTRCODE)
 ;
REJ4DEMO(XMITPTR) ;Determine if encounter was rejected due to a
 ; demographic error
 ;
 ;Input  : XMITPTR - Pointer to TRANSMITTED OUTPATIENT ENCOUNTER
 ;                   file (#409.73)
 ;Output : 1 - At least one of the error codes listed for the
 ;             encounter is related to the patient's demographic data
 ;         0 - None of the error codes listed for the encounter are
 ;             related to the patient's demographic data
 ;         0 - Bad input/no error codes listed
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) 0
 ;Declare variables
 N PTRERR,PTRCODE,NODE,REJ4DEMO
 S REJ4DEMO=0
 ;Loop through TRANSMITTED OUTPATIENT ENCOUNTER ERROR file (#409.75)
 S PTRERR=""
 F  S PTRERR=+$O(^SD(409.75,"B",XMITPTR,PTRERR)) Q:('PTRERR)  D  Q:(REJ4DEMO)
 .;Get pointer to error code
 .S NODE=$G(^SD(409.75,PTRERR,0))
 .S PTRCODE=+$P(NODE,"^",2)
 .Q:('PTRCODE)
 .;Determine if code is based on demographic data
 .S REJ4DEMO=+$$DEMOCODE(PTRCODE)
 ;Done
 Q REJ4DEMO
