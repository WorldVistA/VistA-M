RORHL10 ;HOIFO/BH - HL7 SURGICAL PATHOLOGY DATA: OBR,OBX ; 3/13/06 9:24am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #525          Read access to the multiple #63.08 (controlled)
 ; #4343         $$SPATH^LA7UTL03 (controlled)
 ;
 Q
 ;
 ;***** SEARCHES FOR SURGICAL PATHOLOGY DATA
 ;
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; [CDSMODE]     Search the data by:
 ;                 0  completion/result date (default)
 ;                 1  specimen collection date
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
EN1(RORDFN,DXDTS,CDSMODE) ;
 N ERRCNT,IDX,LRDFN,RC,RORENDT,RORSTDT
 S (ERRCNT,RC)=0
 ;
 S LRDFN=+$$LABREF^RORUTL18(RORDFN)  Q:LRDFN'>0 0
 ;
 S IDX=0
 F  S IDX=$O(DXDTS(9,IDX))  Q:IDX'>0  D  Q:RC<0
 . S RORSTDT=$P(DXDTS(9,IDX),U),RORENDT=$P(DXDTS(9,IDX),U,2)
 . ;---
 . S RC=$S($G(CDSMODE):$$CD(),1:$$RAD())
 . S:RC>0 ERRCNT=ERRCNT+RC
 ;
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** SEARCHES BY SPECIMEN COLLECTION DATE
CD() ;
 N ENDT,ERRCNT,IDT,STDT
 S ERRCNT=0
 S STDT=9999999-RORSTDT
 S ENDT=9999999-RORENDT
 ;---
 S IDT=$O(^LR(LRDFN,"SP",STDT))
 F  S IDT=$O(^LR(LRDFN,"SP",IDT),-1)  Q:'IDT!(IDT'>ENDT)  D
 . S:$$OBROBX(IDT,LRDFN) ERRCNT=ERRCNT+1
 Q ERRCNT
 ;
 ;***** SEARCHES BY COMPLETION (RESULT) DATE
RAD() ;
 N ERRCNT,IDT,RCDT
 S ERRCNT=0
 ;---
 S IDT=0
 F  S IDT=$O(^LR(LRDFN,"SP",IDT))  Q:IDT'>0  D
 . S RCDT=$P($G(^LR(LRDFN,"SP",IDT,0)),U,3)
 . I RCDT'<RORSTDT,RCDT<RORENDT  S:$$OBROBX(IDT,LRDFN) ERRCNT=ERRCNT+1
 Q ERRCNT
 ; 
 ;***** CREATES OBR AND OBX SEGMENTS
OBROBX(RORIDT,LRDFN) ;
 N ERRCNT,RC
 S ERRCNT=0
 ;---
 S RC=$$OBR(RORIDT_","_LRDFN_",")
 I RC  S ERRCNT=ERRCNT+1  Q:RC<0 RC
 ;---
 S RC=$$OBX(LRDFN,RORIDT)
 I RC  S ERRCNT=ERRCNT+1  Q:RC<0 RC
 ;---
 Q ERRCNT
 ;
 ;***** OBR SEGMENT BUILDER
 ;
 ; RORIENS       IENS of SP Entry
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR(RORIENS) ;
 N CS,ERRCNT,FLDS,IEN,RC,RORMSG,ROROUT,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;--- Check the parameters
 S:$E(RORIENS,$L(RORIENS))'="," RORIENS=RORIENS_","
 ;
 ;--- Load the data (with a temporary fix for invalid
 ;--- output transform of the .01 field - ROR*1*8)
 D GETS^DIQ(63.08,RORIENS,".01","I","ROROUT","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-9,,,63.08,RORIENS)
 D GETS^DIQ(63.08,RORIENS,".03;.06;.07;.08","IE","ROROUT","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-9,,,63.08,RORIENS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - Surgical Pathology Acc #
 I $G(ROROUT(63.08,RORIENS,.06,"E"))=""  D  Q RC
 . S RC=$$ERROR^RORERR(-95,,,,63.08,RORIENS,.06)
 S RORSEG(3)=ROROUT(63.08,RORIENS,.06,"E")
 ;
 ;--- OBR-4 - SP CPT Code
 S RORSEG(4)="88300"_CS_"LEVEL I - SURGICAL PAT"_CS_"C4"
 ;
 ;--- OBR-7 - Date/Time Specimen Taken
 S TMP=$$FMTHL7^XLFDT($G(ROROUT(63.08,RORIENS,.01,"I")))
 Q:TMP'>0 $$ERROR^RORERR(-95,,,,63.08,RORIENS,.01)
 S RORSEG(7)=TMP
 ;
 ;--- OBR-8 - Date Report Completed
 S TMP=$G(ROROUT(63.08,RORIENS,.03,"I"))
 S RORSEG(8)=$$FM2HL^RORHL7(TMP)
 ;
 ;--- OBR-16 - Surgeon/Physican
 S RORSEG(16)=$G(ROROUT(63.08,RORIENS,.07,"I"))
 ;
 ;--- OBR-24 - Service Section ID
 S RORSEG(24)="SP"
 ;
 ; OBR-44 - Divsion
 S TMP=$G(ROROUT(63.08,RORIENS,.08,"I"))
 S IEN=$S(TMP'="":+$O(^SC("B",TMP,0)),1:0)
 S RORSEG(44)=$$DIV44^RORHLUT1(IEN,CS)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** OBX SEGMENT BUILDER
 ;
 ; LRDFN         Patient Lab DFN
 ; RORIENS       IENS of SP Entry
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(LRDFN,RORIENS) ;
 N CS,ERRCNT,RC,RORMSG,ROROUT,RORSEG,RORTMP,RPS,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS,,.RPS)
 S RORTMP=$$ALLOC^RORTMP()
 ;---
 I $$SPATH^LA7UTL03(LRDFN,RORIENS,RORTMP,"RORMSG")  D
 . D SPECIMEN
 . D SETOBXWP($$SEGID("BCH","Brief clinical History",CS),"CHIS")
 . D SETOBXWP($$SEGID("PDIAG","Preoperative Diagnosis",CS),"PREDX")
 . D SETOBXWP($$SEGID("OF","Operative Findings",CS),"OPERDX")
 . S TMP=$$SEGID("POPDIAG","Postoperative Diagnosis",CS)
 . D SETOBXWP(TMP,"POSTDX")
 . D SETOBXWP($$SEGID("GDESC","Gross Decription",CS),"GROSSD")
 . D SETOBXWP($$SEGID("MDESC","Microscopic Description",CS),"MICROD")
 . S TMP=$$SEGID("SPDIAG","Surgical Pathology Diagnosis",CS)
 . D SETOBXWP(TMP,"SURGP")
 . D ICD(RPS)
 E  D:$D(RORMSG)>1
 . N I,INFO  S TMP=""
 . F I=1:1  S TMP=$O(RORMSG(TMP))  Q:TMP=""  S INFO(I)=RORMSG(TMP)
 . S RC=$$ERROR^RORERR(-56,,.INFO,,0,"$$SPATH^LA7UTL03")
 ;---
 D FREE^RORTMP(RORTMP)
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** MAKES SPECIMEN OBX
SPECIMEN ;
 N INDEX,RORSPEC,SPECID
 S INDEX="",SPECID=$$SEGID("SPEC","Specimen",CS)
 F  S INDEX=$O(@RORTMP@("SPEC",INDEX))  Q:INDEX=""  D
 . S RORSPEC=$G(@RORTMP@("SPEC",INDEX))
 . D:RORSPEC'="" SETOBX(SPECID,RORSPEC)
 Q
 ;
 ;***** ICD-9
ICD(RPS) ;
 N CNT,ICDLST,INDEX,RORICD,TMP
 S ICDID=$$SEGID("ICD9","ICD9",CS)
 S (INDEX,RORICD)="",CNT=0
 F  S INDEX=$O(@RORTMP@("ICD9",INDEX))  Q:INDEX=""  D
 . S TMP=$G(@RORTMP@("ICD9",INDEX))
 . S:TMP'="" CNT=CNT+1,$P(RORICD,RPS,CNT)=TMP
 D:RORICD'="" SETOBX(ICDID,RORICD)
 Q
 ;
 ;***** CONSTRUCTS SEGMENT IDENTIFIER
SEGID(CODE,NAME,CS) ;
 Q CODE_CS_NAME_CS_"VA080"
 ;
 ;***** CREATE AND STORE THE OBX SEGMENTS
SETOBX(OBX3,OBX5) ;
 N RORSEG
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;--- OBX-2 - Value Type
 S RORSEG(2)="FT"
 ;--- OBX-3 - Observation Identifier
 S RORSEG(3)=OBX3
 ;--- OBX-5 - Observation Value
 S RORSEG(5)=$$ESCAPE^RORHL7(OBX5)
 ;--- OBX-11 - Observation Result Status
 S RORSEG(11)="F"
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
 ;
SETOBXWP(OBX3,SUBS) ;
 N BR,CNT,I,I1,RORSEG,TMP
 S BR=$E(HLECH,3)_".br"_$E(HLECH,3)
 Q:$D(@RORTMP@(SUBS))<10
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;--- OBX-2 - Value Type
 S RORSEG(2)="FT"
 ;--- OBX-3 - Observation Identifier
 S RORSEG(3)=OBX3
 ;--- OBX-5 - Observation Value
 S I=$O(@RORTMP@(SUBS,"")),CNT=0
 F  Q:I=""  S I1=$O(@RORTMP@(SUBS,I))  D  S I=I1
 . S TMP=$$ESCAPE^RORHL7(@RORTMP@(SUBS,I))
 . S CNT=CNT+1,RORSEG(5,CNT)=$S(I1'="":TMP_BR,1:TMP)
 ;--- OBX-11 - Observation Result Status
 S RORSEG(11)="F"
 ;--- Store the segment
 D:$D(RORSEG(5)) ADDSEG^RORHL7(.RORSEG)
 Q
