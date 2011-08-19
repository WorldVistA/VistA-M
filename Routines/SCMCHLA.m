SCMCHLA ;ALB/KCL - PCMM HL7 Transmission Log File API'S ;25-JAN-2000
 ;;5.3;Scheduling;**210,272**;AUG 13, 1993
 ;
LOCK(SCTLIEN) ; Description: Used to lock a record in the PCMM HL7
 ; TANSMISSION LOG file.
 ;
 ;  Input:
 ;   SCTLIEN - ien of a record in the PCMM HL7 TRANSMISSION LOG file
 ;
 ; Output:
 ;  Function Value: Returns 1 on success, 0 on faliure
 ;
 I $G(SCTLIEN) L +^SCPT(404.471,SCTLIEN):3
 ;
 Q $T
 ;
 ;
UNLOCK(SCTLIEN) ; Description: Used to unlock a record in the PCMM HL7
 ; TANSMISSION LOG file.
 ;
 ;  Input:
 ;   SCTLIEN - ien of a record in the PCMM HL7 TRANSMISSION LOG file
 ;
 ; Output: None
 ;
 I $G(SCTLIEN) L -^SCPT(404.471,SCTLIEN)
 Q
 ;
 ;
GETLOG(SCTLIEN,SCECIEN,TLOG) ;
 ; Description: Used to obtain a record in the PCMM HL7 TRANSMISSION LOG
 ; file and a record in the Error Code subfile.  The field values will
 ; be returned in the TLOG array.
 ;
 ;  Input:
 ;   SCTLIEN - ien of a record in the PCMM HL7 TRANSMISSION LOG file
 ;   SCECIEN - ien of record in the Error Code subfile
 ;
 ; Output:
 ;  Function Value: Returns 1 on success, 0 on faliure
 ;  TLOG - this is the name of a local array, it should be passed by
 ;         reference.  If the function is successful the array will
 ;         contain the PCMM HL7 TRANSMISSION LOG record and the
 ;         Error Code subfile record.
 ;
 ;         subscript           field name
 ;         ---------           ----------
 ;         "MSGID"             Message Control ID
 ;         "DFN"               Patient
 ;         "TRANS"             Transmission Date/Time
 ;         "STATUS"            Status
 ;         "ACK DT/TM"         ACK Received Date/Time
 ;
 ;  Error Code subfile record:
 ;         "ERR","CODE"        Error Code
 ;         "ERR","SEG"         Segment
 ;         "ERR","SEQ"         Sequence
 ;         "ERR","ZPCID"       ZPC ID
 ;         "ERR","EPS"         Error Processing Status
 ;
 N NODE
 K TLOG S TLOG=""
 Q:'$G(SCTLIEN) 0
 ;
 S NODE=$G(^SCPT(404.471,SCTLIEN,0))
 Q:(NODE="") 0
 S TLOG("MSGID")=$P(NODE,"^")
 S TLOG("DFN")=$P(NODE,"^",2)
 S TLOG("TRANS")=$P(NODE,"^",3)
 S TLOG("STATUS")=$P(NODE,"^",4)
 S TLOG("ACK DT/TM")=$P(NODE,"^",5)
 S TLOG("WORK")=$P(NODE,"^",7)
 ;
 S TLOG("ERR")=""
 I $G(SCECIEN) D
 .S NODE=$G(^SCPT(404.471,SCTLIEN,"ERR",SCECIEN,0))
 .S TLOG("ERR","CODE")=$P(NODE,"^")
 .S TLOG("ERR","SEG")=$P(NODE,"^",2)
 .S TLOG("ERR","SEQ")=$P(NODE,"^",3)
 .S TLOG("ERR","ZPCID")=$P(NODE,"^",5)
 .S TLOG("ERR","EPS")=$P(NODE,"^",6)
 ;
 Q 1
 ;
 ;
STATUS(SCTLIEN) ;
 ; Description: Used to get STATUS field for record in PCMM HL7
 ; TRANSMISSION LOG file.
 ;
 ;  Input:
 ;   SCTLIEN - IEN of PCM HL7 TRANSMISSION LOG file
 ;
 ; Output:
 ;  Funtion Value: Returns STATUS field value, null otherwise.
 ;
 Q:'$G(SCTLIEN) ""
 Q $P($G(^SCPT(404.471,SCTLIEN,0)),"^",4)
 ;
 ;
UPDSTAT(SCTLIEN,STATUS,ERROR) ;
 ; Description: Used to update the STATUS field of record in PCMM HL7
 ; TRANSMISSION LOG file.
 ;
 ;  Input:
 ;   SCTLIEN - IEN of PCM HL7 TRANSMISSION LOG file
 ;    STATUS - T=Transmitted, A=Accepted, RJ=Rejected,
 ;             M=Marked for re-transmission, RT=Re-transmitted
 ;
 ; Output:
 ;  Funtion Value: Returns 1 on success, 0 on failure.
 ;  ERROR - returns error message on failure, pass by reference 
 ;
 N SCERR,SCFDA,SCIENS
 ;
 S ERROR=""
 ;
 I '$G(SCTLIEN) S ERROR="NO RECORD SPECIFIED" Q 0
 I '$$LOCK(SCTLIEN) S ERROR="UNABLE TO OBTAIN LOCK ON RECORD" Q 0
 I ",T,A,RJ,M,RT,"'[(","_$G(STATUS)_",") S ERROR="INVALID STATUS" Q 0
 ;
 S SCIENS=SCTLIEN_","
 S SCFDA(404.471,SCIENS,.04)=STATUS  ; Status
 D FILE^DIE("","SCFDA","SCERR")
 ;
 D UNLOCK(SCTLIEN)
 ;
 ; if error returned from DBS call, unable to file data
 I $G(SCERR) S ERROR="UNABLE TO UPDATE STATUS FIELD" Q 0
 ;
 Q 1
 ;
 ;
INCLUDE(SCTLIEN) ;
 ; Description: Used to get INCLUDED IN REJECT BULLETIN? field for
 ; record in PCMM HL7 TRANSMISSION LOG file.
 ;
 ;  Input:
 ;   SCTLIEN - IEN of PCM HL7 TRANSMISSION LOG file
 ;
 ; Output:
 ;  Funtion Value: Returns INCLUDED IN REJECT BULLETIN? field value, null otherwise.
 ;
 Q:'$G(SCTLIEN) ""
 Q $P($G(^SCPT(404.471,SCTLIEN,0)),"^",6)
 ;
 ;
UPDINCL(SCTLIEN,SCINCL,ERROR) ;
 ; Description: Used to update the INCLUDED IN REJECT BULLETIN? field of
 ; record in the PCMM HL7 TRANSMISSION LOG file.
 ;
 ;  Input:
 ;    SCTLIEN - IEN of record in PCMM HL7 TRANSMISSION LOG file
 ;     SCINCL - 'Y'=YES
 ;
 ; Output:
 ;  Funtion Value: Returns 1 on success, 0 on failure.
 ;  ERROR - returns error message on failure, pass by reference 
 ;
 N SCERR,SCFDA,SCIENS
 ;
 S ERROR=""
 ;
 I '$G(SCTLIEN) S ERROR="NO RECORD SPECIFIED" Q 0
 I $G(SCINCL)'="Y" S ERROR="INVALID FIELD VALUE" Q 0
 I '$$LOCK(SCTLIEN) S ERROR="UNABLE TO OBTAIN LOCK ON RECORD" Q 0
 ;
 S SCIENS=SCTLIEN_","
 S SCFDA(404.471,SCIENS,.06)=SCINCL  ; Included In Reject Bulletin?
 D FILE^DIE("","SCFDA","SCERR")
 ;
 D UNLOCK(SCTLIEN)
 ;
 ; if error returned from DBS call, unable to file data
 I $G(SCERR) S ERROR="UNABLE TO UPDATE 'INCLUDED IN REJECT BULLETIN?' FIELD" Q 0
 ;
 Q 1
 ;
 ;
ACK(SCTLIEN) ;
 ; Description: Used to get ACK RECEIVED DATE/TIME field for
 ; record in PCMM HL7 TRANSMISSION LOG file.
 ;
 ;  Input:
 ;   SCTLIEN - IEN of PCM HL7 TRANSMISSION LOG file
 ;
 ; Output:
 ;  Funtion Value: Returns ACK RECEIVED DATE/TIME field value, 0 otherwise.
 ;
 Q:'$G(SCTLIEN) 0
 Q $P($G(^SCPT(404.471,SCTLIEN,0)),"^",5)
 ;
 ;
UPDEPS(SCTLIEN,SCERIEN,EPSTAT,ERROR) ;
 ; Description: Used to update the ERROR PROCESSING STATUS field of
 ; record in the Error Code (#404.47142) subfile.
 ;
 ;  Input:
 ;    SCTLIEN - IEN of record in PCMM HL7 TRANSMISSION LOG file
 ;    SCERIEN - IEN record in ERROR CODE (#404.47142) subfile
 ;     EPSTAT - 1=NEW, 2=CHECKED
 ;
 ; Output:
 ;  Funtion Value: Returns 1 on success, 0 on failure.
 ;  ERROR - returns error message on failure, pass by reference 
 ;
 N SCERR,SCFDA,SCIENS,STATUS
 ;
 S ERROR=""
 ;
 I '$G(SCTLIEN) S ERROR="NO RECORD SPECIFIED" Q 0
 I '$G(SCERIEN) S ERROR="NO SUB-RECORD SPECIFIED" Q 0
 I '$G(EPSTAT) S ERROR="INVALID ERROR PROCESSING STATUS" Q 0
 S STATUS=$$STATUS(SCTLIEN)
 I (STATUS'="RJ")&(STATUS'="M") S ERROR="STATUS IS NOT 'REJECTED' OR 'MARKED FOR RE-TRANSMIT'" Q 0
 I '$$LOCK(SCTLIEN) S ERROR="UNABLE TO OBTAIN LOCK ON RECORD" Q 0
 ;
 S SCIENS=SCERIEN_","_SCTLIEN_","
 S SCFDA(404.47142,SCIENS,.06)=EPSTAT  ; Error Processing Status
 D FILE^DIE("","SCFDA","SCERR")
 ;
 D UNLOCK(SCTLIEN)
 ;
 ; if error returned from DBS call, unable to file data
 I $G(SCERR) S ERROR="UNABLE TO UPDATE STATUS FIELD" Q 0
 ;
 Q 1
