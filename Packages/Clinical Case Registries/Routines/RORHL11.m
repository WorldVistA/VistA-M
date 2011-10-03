RORHL11 ;HOIFO/BH,SG - HL7 CYTOPATHOLOGY DATA: OBR,OBX ; 3/13/06 9:24am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #4344         $$CYPATH^LA7UTL02 (controlled)
 ;
 Q
 ;
 ;***** SEARCHES BY SPECIMEN COLLECTION DATE
CD() ;
 N ENDT,ERRCNT,IDT,STDT
 S ERRCNT=0
 S STDT=9999999-RORSTDT
 S ENDT=9999999-RORENDT
 S IDT=$O(^LR(LRDFN,"CY",STDT))
 F  S IDT=$O(^LR(LRDFN,"CY",IDT),-1)  Q:'IDT!(IDT'>ENDT)  D
 . S:$$OBROBX(IDT) ERRCNT=ERRCNT+1
 Q ERRCNT
 ;
 ;***** SEARCHES FOR CYTOPATHOLOGY DATA
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
EN1(RORDFN,DXDTS,CDSMODE,RORPTR,RORFILE,HLFS,HLECH) ;
 N ERRCNT,IDX,LRDFN,RC,RORENDT,RORIEN,RORSTDT
 S (ERRCNT,RC)=0
 ;
 S LRDFN=+$$LABREF^RORUTL18(RORDFN)  Q:LRDFN'>0 0
 ;
 S IDX=0
 F  S IDX=$O(DXDTS(10,IDX))  Q:IDX'>0  D  Q:RC<0
 . S RORSTDT=$P(DXDTS(10,IDX),U),RORENDT=$P(DXDTS(10,IDX),U,2)
 . ;---
 . S RC=$S($G(CDSMODE):$$CD(),1:$$RAD())
 . S:RC>0 ERRCNT=ERRCNT+RC
 ;
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;*****
ICD(RPS) ;
 Q:$D(@RORTMP@("ICD9"))<10
 N CNT,ICDLST,INDEX,RORICD,TMP
 S ICDID=$$SEGID("ICD9","ICD9",CS)
 S (INDEX,RORICD)="",CNT=0
 F  S INDEX=$O(@RORTMP@("ICD9",INDEX))  Q:INDEX=""  D
 . S TMP=$G(@RORTMP@("ICD9",INDEX))
 . S:TMP'="" CNT=CNT+1,$P(RORICD,RPS,CNT)=TMP
 D:RORICD'="" SETOBX(ICDID,RORICD)
 Q
 ;
 ;***** CREATES OBR AND OBX SEGMENTS
OBROBX(RORIDT) ;
 N ERRCNT,RC,RORMSG,RORTMP,TMP
 S (ERRCNT,RC)=0
 S RORTMP=$$ALLOC^RORTMP()
 ;---
 I $$CYPATH^LA7UTL02(LRDFN,RORIDT,RORTMP,"RORMSG")  D
 . S RC=$$OBR(RORTMP,RORIDT)
 . I RC  S ERRCNT=ERRCNT+1  Q:RC<0
 . ;---
 . S RC=$$OBX(RORTMP)
 . I RC  S ERRCNT=ERRCNT+1  Q:RC<0
 E  D:$D(RORMSG)>1
 . N I,INFO  S TMP=""
 . F I=1:1  S TMP=$O(RORMSG(TMP))  Q:TMP=""  S INFO(I)=RORMSG(TMP)
 . S RC=$$ERROR^RORERR(-56,,.INFO,,0,"$$CYPATH^LA7UTL02")
 ;---
 D FREE^RORTMP(RORTMP)
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** CYTOPATHOLOGY OBR SEGMENT BUILDER
 ;
 ; RORTMP        Closed root of the array holding lab data
 ; RORIEN        IEN of Cyto Visit
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR(RORTMP,RORIEN) ;
 N CS,CPA,ERRCNT,RC,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - Cyto Path Acc #
 S CPA=$P($G(@RORTMP@("DEMO",RORIEN)),U,2)  Q:CPA="" 0
 S RORSEG(3)=CPA
 ;
 ;--- OBR-4
 S RORSEG(4)="88108"_CS_"CYTOPATHOLOGY, CONCENT"_CS_"C4"
 ;
 ;--- OBR-7 - Date/Time Specimen Taken
 S TMP=$$FMTHL7^XLFDT($P(@RORTMP@("DEMO",RORIEN),U))
 I TMP'>0  D  Q RC
 . S RC=$$ERROR^RORERR(-100,,,,"No specimen date","$$CYPATH^LA7UTL02")
 S RORSEG(7)=TMP
 ;
 ;--- OBR-24 - Service Section ID
 S RORSEG(24)="CP"
 ;
 ;--- OBR-44 - Divsion
 S RORSEG(44)=$$SITE^RORUTL03(CS)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** CYTOPATHOLOGY OBX SEGMENT BUILDER
 ;
 ; RORTMP        Closed root of the array holding lab data
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(RORTMP) ;
 N CS,ERRCNT,RC,RPS,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS,,.RPS)
 ;
 D:$D(@RORTMP@("SPEC")) SPECIMEN
 D SETOBXWP($$SEGID("BCH","Brief clinical History",CS),"CHIS")
 D SETOBXWP($$SEGID("PDIAG","Preoperative Diagnosis",CS),"PREDX")
 D SETOBXWP($$SEGID("OF","Operative Findings",CS),"OPERDX")
 D SETOBXWP($$SEGID("POPDIAG","Postoperative Diagnosis",CS),"POSTDX")
 D SETOBXWP($$SEGID("MICRO","Microscopic Examination",CS),"MICRO")
 D SETOBXWP($$SEGID("CDIAG","Cytopathology Diagnosis",CS),"CYTODX")
 D ICD(RPS)
 ;
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** SEARCHES BY COMPLETION (RESULT) DATE
RAD() ;
 N ERRCNT,IDT,RCDT
 S (ERRCNT,IDT)=0
 F  S IDT=$O(^LR(LRDFN,"CY",IDT))  Q:'IDT  D
 . S RCDT=$P($G(^LR(LRDFN,"CY",IDT,0)),U,3)
 . I RCDT'<RORSTDT,RCDT<RORENDT  S:$$OBROBX(IDT) ERRCNT=ERRCNT+1
 Q ERRCNT
 ;
 ;***** CONSTRUCTS SEGMENT IDENTIFIER
SEGID(PONE,PTWO,CS) ; Create segment identifier
 Q PONE_CS_PTWO_CS_"VA080"
 ;
 ;***** CREATE AND STORE THE OBX SEGMENTS
SETOBX(OBX3,OBX5) ;
 N RORSEG
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;--- OBX-2
 S RORSEG(2)="FT"
 ;--- OBX-3
 S RORSEG(3)=OBX3
 ;--- OBX-5
 S RORSEG(5)=$$ESCAPE^RORHL7(OBX5)
 ;--- OBX-11
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
 ;
 ;***** MAKES SPECIMEN OBX
SPECIMEN ;
 N INDEX,RORSPEC,SPECID
 S SPECID=$$SEGID("SPEC","Specimen",CS)
 S INDEX=""
 F  S INDEX=$O(@RORTMP@("SPEC",INDEX))  Q:INDEX=""  D
 . S RORSPEC=$G(@RORTMP@("SPEC",INDEX))
 . D:RORSPEC'="" SETOBX(SPECID,RORSPEC)
 Q
