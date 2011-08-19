RAMAGHL ;HCIOFO/SG - ORDERS/EXAMS API (HL7 UTILITIES) ; 2/25/09 3:30pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 ; This routine uses the following IAs:
 ;
 ; #872          Access to the file #101 (controlled)
 ;
 Q
 ;
 ;***** RETURNS THE LIST OF ACTIVE HL7 APPLICATIONS
 ;
 ; .APPLST         Reference to a local variable where the list
 ;                 of active HL7 applications associated with the
 ;                 RA REG*, RA EXAMINED*, RA CANCEL*, and RA RPT*
 ;                 HL7 protocols (as receiving applications) will
 ;                 be returned to.
 ; APPLST(
 ;   HL7AppIEN)    HL7 application name
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Ok
 ;
APPLST(APPLST) ;
 N IEN,NAME,PART,PIEN,PL,RAMSG,ROOT,SUBSLST
 K APPLST
 ;--- Build the list of subscriber IENs
 S ROOT=$$ROOT^DILFD(101,,1)
 F PART="RA REG","RA EXAMINED","RA CANCEL","RA RPT"  D
 . S NAME=$O(@ROOT@("B",PART),-1),PL=$L(PART)
 . F  S NAME=$O(@ROOT@("B",NAME))  Q:$E(NAME,1,PL)'=PART  D
 . . S PIEN=0
 . . F  S PIEN=$O(@ROOT@("B",NAME,PIEN))  Q:PIEN'>0  D
 . . . S IEN=0
 . . . F  S IEN=$O(@ROOT@(PIEN,775,IEN))  Q:IEN'>0  D
 . . . . S SUBSLST(+@ROOT@(PIEN,775,IEN,0))=""
 ;--- Build the list of receiving application IENs
 S PIEN=0
 F  S PIEN=$O(SUBSLST(PIEN))  Q:PIEN'>0  D
 . S IEN=+$$GET1^DIQ(101,PIEN_",",770.2,"I",,"RAMSG")
 . S:IEN>0 APPLST(IEN)=""
 ;--- Check if the applications are active and get their names
 S IEN=0
 F  S IEN=$O(APPLST(IEN))  Q:IEN'>0  D
 . I $P($$GETAPP^HLCS2(IEN),U,2)="i"  K APPLST(IEN)  Q
 . S APPLST(IEN)=$$GET1^DIQ(771,IEN_",",.01,,,"RAMSG")
 ;---
 Q 0
 ;
 ;***** SENDS "EXAMINED" HL7 MESSAGES (ORM)
 ; 
 ; RACASE          Exam/case identifiers
 ;                   ^01: IEN of the patient in the file #70   (RADFN)
 ;                   ^02: IEN in the REGISTERED EXAMS multiple (RADTI)
 ;                   ^03: IEN in the EXAMINATIONS multiple     (RACNI)
 ;
 ; [RAFLAGS]       Flags that control the execution (can be combined):
 ;
 ;                   S  Do not send the message to speech recognition
 ;                      (dictation) systems
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Ok
 ;
EXAMINED(RACASE,RAFLAGS) ;
 N RACNI,RADFN,RADTI,RAEXEDT,RASSS,RASSSX,RC,TMP
 S RADFN=$P(RACASE,U),RADTI=$P(RACASE,U,2),RACNI=$P(RACASE,U,3)
 S RAFLAGS=$G(RAFLAGS)
 ;
 ;--- Exclude speech recognition (dictation) systems if necessary
 I RAFLAGS["S"  S RC=$$SPRSUBS(.RASSSX)  Q:RC $S(RC<0:RC,1:0)
 ;
 ;--- Generate and send the message
 S RAEXEDT=1  D EXM^RAHLRPC
 Q 0
 ;
 ;***** SENDS "REPORT" HL7 MESSAGES (ORU)
 ; 
 ; RACASE          Exam/case identifiers
 ;                   ^01: IEN of the patient in the file #70   (RADFN)
 ;                   ^02: IEN in the REGISTERED EXAMS multiple (RADTI)
 ;                   ^03: IEN in the EXAMINATIONS multiple     (RACNI)
 ;
 ; [RAFLAGS]       Flags that control the execution (can be combined):
 ;
 ;                   S  Do not send the message to speech recognition
 ;                      (dictation) systems
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Ok
 ;
REPORT(RACASE,RAFLAGS) ;
 N RACNI,RADFN,RADTI,RAMSG,RASSS,RASSSX,RC,RPTIEN,TMP
 S RADFN=$P(RACASE,U),RADTI=$P(RACASE,U,2),RACNI=$P(RACASE,U,3)
 S RAFLAGS=$G(RAFLAGS)
 ;
 ;--- Get the report IEN
 S TMP=$$EXAMIENS^RAMAGU04(RACASE)
 S RPTIEN=$$GET1^DIQ(70.03,TMP,17,"I",,"RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.03,TMP)
 Q:RPTIEN'>0 0  ; No report yet
 ;
 ;--- Send messages only for verified or released reports
 S TMP=$$RPTSTAT^RAMAGU12(RPTIEN)  Q:TMP<0 TMP
 S TMP=$P(TMP,U)  Q:(TMP'="V")&(TMP'="R")&(TMP'="EF") 0
 ;
 ;--- Exclude speech recognition (dictation) systems if necessary
 I RAFLAGS["S"  S RC=$$SPRSUBS(.RASSSX)  Q:RC $S(RC<0:RC,1:0)
 ;
 ;--- Generate and send the message
 D RPT^RAHLRPC
 Q 0
 ;
 ;***** COMPILES A LIST OF SPEACH RECOGNITION SUBSCRIBERS
 ;
 ; .RASSSX         Reference to a local array where the list of
 ;                 speech recognition subscribers is returned to:
 ;
 ;                   RASSSX(EvtDrvrIEN,SubscriberIEN) = EvtDrvrName
 ;
 ;                 EvtDrvrIEN and SubscriberIEN are record numbers
 ;                 in the PROTOCOL file (#101).
 ;
 ; [.RASSS]        Reference to a local array where the list of
 ;                 related HL7 applications is returned to:
 ;
 ;                   RASSS(HL7AppIEN) = ""
 ;
 ;                 HL7AppIEN is a record number in the HL7
 ;                 APPLICATION PARAMETER file (#771).
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Ok
 ;       >0  Nowhere to send
 ;
SPRSUBS(RASSSX,RASSS) ;
 N APPLST,IEN,RABUF,RAMSG,RC
 K RASSS,RASSSX
 S RC=$$APPLST(.APPLST)  Q:RC<0 RC
 ;--- Select only those HL7 applications that do not have
 ;    'S:Speech Recognition' in the APPLICATION TYPE field of
 ;--- the RAD/NUC MED HL7 APPLICATION EXCEPTION file (#79.7).
 S IEN=0
 F  S IEN=$O(APPLST(IEN))  Q:IEN'>0  D
 . I $D(^RA(79.7,IEN,0))  D  Q:RC="S"
 . . S RC=$$GET1^DIQ(79.7,IEN_",",1.3,"I",,"RAMSG")
 . S RASSS(IEN)=""
 ;--- Quit if all recipients should be skipped
 Q:$D(RASSS)<10 1
 ;--- Build the list of excluded subscriber protocols
 D GETSUB^RAHLRS1(.RASSS,.RASSSX)
 Q 0
