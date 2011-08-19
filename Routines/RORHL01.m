RORHL01 ;HOIFO/CRT - HL7 PATIENT DATA: PID,ZSP,ZRD ; 6/19/06 2:08pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #263          $$EN^VAFHLPID (controlled)
 ; #3630         BLDPID^VAFCQRY (controlled)
 ; #4535         EN^VAFHLZRD (private)
 ; #4536         $$EN^VAFHLZSP (private)
 ; #10035        Read access to the PATIENT file (supported)
 ;
 Q
 ;
 ;***** PID SEGMENT BUILDER
 ;
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
PID(RORDFN) ;
 N CS,ERRCNT,I,PTID,RC,RORBUF,RORMSG,RPS,SCS,SEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS,.SCS,.RPS)
 ;
 ;--- Check if the patient exists
 S RORDFN=+$G(RORDFN)
 I '$D(^DPT(RORDFN,0))  D  Q RC
 . S RC=$$ERROR^RORERR(-36,,,RORDFN,2)
 ;
 ;--- Call Standard PID Segment builder
 S TMP="3,5,7,8,10,11,19,22,29"
 D BLDPID^VAFCQRY(RORDFN,"",TMP,.RORBUF,.RORHL,.RORMSG)
 ;---
 D LOADSEG^RORHL7A(.SEG,"RORBUF")
 ;
 ;--- PID-3 Patient Identifiers
 S PTID=""
 F I=1:1  S TMP=$P(SEG(3),RPS,I)  Q:TMP=""  D
 . S:"NI,PI"[$P(TMP,CS,5) PTID=PTID_RPS_TMP
 S SEG(3)=$P(PTID,RPS,2,99)
 ;
 ;--- PID-5 Remove the Patient Name
 S SEG(5)=""
 ;
 ;--- PID-10 Send the old race if the new format is not available
 I $G(SEG(10))?.""""  D
 . N VAFPID
 . S TMP=$$EN^VAFHLPID(RORDFN,"10")
 . S:$G(VAFPID(1))'="" RORSEG=RORSEG_VAFPID(1)
 . S SEG(10)=$P(TMP,HLFS,11)
 ;
 ;--- PID-11 Remove Address (leave ZIP only)
 S SEG(11)=CS_CS_CS_CS_$P($G(SEG(11)),CS,5)
 ;
 ;--- PID-19 Encrypt SSN
 S SEG(19)=$$XOR^RORUTL03($G(SEG(19)))
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.SEG)
 Q ERRCNT
 ;
 ;***** ZSP SEGMENT BUILDER
 ;
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
ZSP(RORDFN) ;
 N RC,RORFLDS,RORSEG
 S RC=0
 ;
 ;--- Check if the patient exists
 S RORDFN=+$G(RORDFN)
 I '$D(^DPT(RORDFN,0))  D  Q RC
 . S RC=$$ERROR^RORERR(-36,,,RORDFN,2)
 ;
 S RORFLDS="1,2,3,4" ; Default HL7 fields
 ;
 ;--- Call Standard ZSP Segment Builder
 S RORSEG=$$EN^VAFHLZSP(RORDFN)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG,"C")
 Q $S(RC<0:RC,1:0)
 ;
 ;***** ZRD SEGMENT BUILDER
 ;
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
ZRD(RORDFN) ;
 N I,RC,RORFLDS,RORSEG
 S RC=0
 ;
 ;--- Check if the patient exists
 S RORDFN=+$G(RORDFN)
 I '$D(^DPT(RORDFN,0))  D  Q RC
 . S RC=$$ERROR^RORERR(-36,,,RORDFN,2)
 ;
 S RORFLDS="1,2,3,4" ; Default HL7 fields
 ;
 ;--- Call Standard ZRD Segment Builder
 D EN^VAFHLZRD(RORDFN,RORFLDS,,HLFS,"RORSEG")
 ;
 ;--- Store the segment(s)
 S I=""
 F  S I=$O(RORSEG(I))  Q:I=""  Q:$P($G(RORSEG(I,0)),HLFS,3)=""  D
 . D ADDSEG^RORHL7(RORSEG(I,0),"C")
 Q $S(RC<0:RC,1:0)
