RORHL09 ;HOIFO/BH - HL7 OUTPATIENT DATA: PV1,OBR,OBX ; 3/13/06 9:24am
 ;;1.5;CLINICAL CASE REGISTRIES;**1,5**;Feb 17, 2006;Build 10
 ;
 ; 11/29/2007 BAY/KAM ROR*1.5*5 Rem Call 218601 Correct Outpatient
 ;                              CPTs not transmitting to the AAC
 ;
 ; This routine uses the following IAs:
 ;
 ; #93       Get stop code from the file #44 (controlled)
 ; #1889     Use of the ENCEVENT^PXKENC API
 ; #1995     $$CODEC^ICPTCOD (supported)
 ; #2309     Read access to the 'AA' x-ref in VISIT file (#9000010)
 ; #3990     $$CODEC^ICDCODE (supported)
 ; #10060    Read access to the file #200 (supported)
 ; #2438     Access to the file #40.8 (field #1) (controlled)
 ;
 Q
 ;
 ;***** PROCESSES DIAGNOSIS CODES
DIAGS() ;
 N DIAG,IEN,K5,OID,REC,TMP
 S OID="OICD9"_RORCS_"Diagnosis"_RORCS_"VA080"
 S K5=""
 F  S K5=$O(^TMP("PXKENC",$J,RORIEN,"POV",K5))  Q:K5=""  D
 . S REC=^TMP("PXKENC",$J,RORIEN,"POV",K5,0)
 . S IEN=+$P(REC,U)  Q:IEN'>0
 . ;---
 . S DIAG=$$CODEC^ICDCODE(IEN)
 . D:DIAG'<0 SETOBX(OID,DIAG)
 Q 0
 ;
 ;***** OUTPATIENT DATA SEGMENT BUILDER
 ;
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; RORTY         Set to either "PV1" or "OBR"
 ;
 ; The ^TMP("PXKENC",$J) and ^TMP("RORHL08",$J) global nodes are
 ; used by this function.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
EN1(RORDFN,DXDTS,RORTY) ;
 N ERRCNT,PIEN,PV1CNT,RC
 S (ERRCNT,RC)=0
 ;
 ;--- PV1 Segments
 I RORTY="PV1"  K ^TMP("PXKENC",$J),^TMP("RORHL09",$J)  D
 . N IDX,INVDT,ROREND
 . S (IDX,PV1CNT)=0
 . F  S IDX=$O(DXDTS(2,IDX))  Q:IDX'>0  D  Q:RC<0
 . . S INVDT=9999999-$$FMADD^XLFDT($P(DXDTS(2,IDX),U)\1,-1)
 . . S ROREND=9999999-$P(DXDTS(2,IDX),U,2)
 . . F  S INVDT=$O(^AUPNVSIT("AA",RORDFN,INVDT),-1)  Q:'INVDT!(INVDT'>ROREND)  D
 . . . S PIEN=""
 . . . F  S PIEN=$O(^AUPNVSIT("AA",RORDFN,INVDT,PIEN),-1)  Q:'PIEN  D
 . . . . S TMP=$$PV1(PIEN,RORDFN)
 . . . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . . . ;--- Reference for the corresponding OBR segment
 . . . . S:TMP'="S" PV1CNT=PV1CNT+1,^TMP("RORHL09",$J,PV1CNT)=PIEN
 ;
 ;--- OBR and OBX Segments
 I RORTY="OBR"  D  K ^TMP("PXKENC",$J),^TMP("RORHL09",$J)
 . S PV1CNT=0
 . F  S PV1CNT=$O(^TMP("RORHL09",$J,PV1CNT))  Q:PV1CNT'>0  D
 . . S PIEN=+$G(^TMP("RORHL09",$J,PV1CNT))  Q:PIEN'>0
 . . ;---
 . . S TMP=$$OBR(PIEN,RORDFN)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . ;---
 . . S TMP=$$OBX(PIEN,RORDFN)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ;
 ;--- Check for errors
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** OBR SEGMENT BUILDER (OUTPATIENT)
 ;
 ; RORIEN        IEN of file #9000010
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR(RORIEN,RORDFN) ;
 N CS,ERRCNT,RC,RORSEG,STN,TMP,VST0
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 S VST0=$G(^TMP("PXKENC",$J,RORIEN,"VST",RORIEN,0))
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - Order Number (IEN in the VISIT file #9000010) 
 S RORSEG(3)=RORIEN
 ;
 ;--- OBR-4 - Universal Service ID
 S RORSEG(4)="OP"_CS_"Outpatient"_CS_"C4"
 ;
 ;--- OBR-7 - Observation Date/Time (Visit Date/Time) *KEY*
 S TMP=$$FMTHL7^XLFDT($P(VST0,U))
 Q:TMP'>0 $$ERROR^RORERR(-100,,,,"No visit date","ENCEVENT^PXKENC")
 S RORSEG(7)=TMP
 ;
 ;--- OBR-24 - Diagnostic Service ID
 S RORSEG(24)="PHY"
 ;
 ;--- OBR-44 - Division
 S RORSEG(44)=$$SITE^RORUTL03(CS)
 S TMP=+$P(VST0,U,6)  ; LOC. OF ENCOUNTER (.06)
 I TMP>0  D
 . S TMP=$$NS^XUAF4(TMP),STN=$P(TMP,U,2)
 . S:STN'="" RORSEG(44)=STN_CS_$P(TMP,U)_CS_"99VA4"
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** OBX SEGMENT BUILDER (OUTPATIENT)
 ;
 ; RORIEN        IEN of file #9000010
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(RORIEN,RORDFN) ;
 N ERRCNT,RC,RORCS,RORLST,RORMSG,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.RORCS)
 ;
 ;--- Procedures
 I $D(^TMP("PXKENC",$J,RORIEN,"CPT"))>1  D  Q:RC<0 RC
 . S RC=$$PROCS()  S:RC ERRCNT=ERRCNT+1
 ;--- Diagnosis codes
 I $D(^TMP("PXKENC",$J,RORIEN,"POV"))>1  D  Q:RC<0 RC
 . S RC=$$DIAGS()  S:RC ERRCNT=ERRCNT+1
 ;
 Q ERRCNT
 ; 
 ;***** PROCESSES PROCEDURES
PROCS() ;
 N CLASS,ERRCNT,IEN,K5,OID,PROC,PRV,REC,RORMSG,TMP
 S ERRCNT=0
 S OID="OCPT"_RORCS_"Procedures"_RORCS_"VA080"
 S K5=""
 F  S K5=$O(^TMP("PXKENC",$J,RORIEN,"CPT",K5))  Q:K5=""  D
 . S REC=$G(^TMP("PXKENC",$J,RORIEN,"CPT",K5,0))
 . S IEN=+$P(REC,U)  Q:IEN'>0
 . ;---
 . S PROC=$$CODEC^ICPTCOD(IEN)
 . Q:PROC<0
 . ;---
 . S PRV=+$P($G(^TMP("PXKENC",$J,RORIEN,"CPT",K5,12)),U,4)
 . ;12/06/2007 BAY/KAM REM CALL 218601 Modified next 8 lines
 . ;---
 . I PRV>0 D
 .. S $P(PRV,RORCS,13)=$$GET1^DIQ(200,PRV_",",53.5,"E",,"RORMSG")
 .. I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 ... D DBS^RORERR("RORMSG",-99,,RORDFN,200,+PRV_",")
 . E  S PRV=""
 . ;----------> End of changes for 218601
 . ;---
 . D SETOBX(OID,PROC,PRV)
 Q ERRCNT
 ;
 ;***** PV1 SEGMENT BUILDER (OUTPATIENT)
 ;
 ; RORIEN        IEN in the file #9000010
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;      "S"  No visit data
 ;       >0  Non-fatal error(s)
 ;
PV1(RORIEN,RORDFN) ;
 N BUF,CLASS,CS,ERRCNT,IENS,KK4,RC,REC,REP,RORCLIN,RORMSG,PRV,TMP,TMP1,VST0
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS,,.REP)
 ;
 ;--- Get Visit Data
 D ENCEVENT^PXKENC(RORIEN,1)
 Q:$D(^TMP("PXKENC",$J,RORIEN))<10 "S"
 S VST0=$G(^TMP("PXKENC",$J,RORIEN,"VST",RORIEN,0))
 ;
 ;--- Do not send visits with the following service categories: Daily
 ;--- Hospitalization (D), Ancillary (X), Chart (C), Not Found (N),
 ;                    (E), Event Historical, Hospitalization (H).
 Q:"HEDXNC"[$P(VST0,U,7) "S"
 ;
 ;--- Initialize the segment
 S RORSEG(0)="PV1"
 ;
 ;--- PV1-2 - Patient Class
 S RORSEG(2)="O"  ; O - Outpatient
 ;
 ;--- PV1-3 - Assigned Patient Location (Station Number and Stop Code)
 S RORCLIN=+$P(VST0,U,22),BUF=""
 I RORCLIN>0  D
 . S IENS=RORCLIN_","
 . S TMP=$$GET1^DIQ(44,IENS,3.5,"I")  Q:TMP'>0
 . S BUF=$$GET1^DIQ(40.8,TMP,1)       Q:BUF=""  ; Station Number
 . S TMP=$$STOPCODE^RORUTL18(+RORCLIN)
 . S $P(BUF,CS,6)=$S(TMP>0:TMP,1:"")            ; Stop Code
 Q:$P(BUF,CS,6)="" "S"  ; Stop Code is required
 S RORSEG(3)=BUF
 ;
 ; PV1-4  - Admission Type
 S TMP=$P($G(^TMP("PXKENC",$J,RORIEN,"VST",RORIEN,150)),U,3)
 S RORSEG(4)=TMP
 ;
 ;--- PV1-7 - Attending Physician (User IEN and Provider Class Name)
 S (KK4,BUF)=""
 F  S KK4=$O(^TMP("PXKENC",$J,RORIEN,"PRV",KK4))  Q:KK4=""  D
 . S REC=$G(^TMP("PXKENC",$J,RORIEN,"PRV",KK4,0))
 . S PRV=+$P(REC,U)  Q:(PRV'>0)!($P(REC,U,4)'="P")
 . S $P(PRV,CS,13)=$$GET1^DIQ(200,PRV_",",53.5,"E",,"RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . D DBS^RORERR("RORMSG",-99,,RORDFN,200,PRV_",")
 . S BUF=BUF_REP_PRV
 S RORSEG(7)=$P(BUF,REP,2,999)
 ;
 ;--- PV1-19 - Visit Number (IEN in the VISIT file #9000010) *KEY*
 S RORSEG(19)=RORIEN
 ;
 ;--- PV1-44 - Admit Date/Time (Visit Date/Time) *KEY*
 S TMP=$$FMTHL7^XLFDT($P(VST0,U))
 I TMP'>0  D  Q RC
 . S RC=$$ERROR^RORERR(-100,,,,"No admission date","ENCEVENT^PXKENC")
 S RORSEG(44)=TMP
 ;
 ;--- PV1-51 - Visit Indicator (Deleted Visit Indicator)
 S TMP=$P(VST0,U,11)
 S RORSEG(51)=$S(TMP'="":TMP,1:0)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** LOW-LEVEL SEGMENT BUILDER
 ;
 ; OBX3          Observation Identifier
 ;
 ; OBX5          Observation Value
 ;
 ; [OBX16]       Procedure Provider and Provider Class Name
 ;
SETOBX(OBX3,OBX5,OBX16) ;
 N RORSEG
 S RORSEG(0)="OBX"
 ;--- OBX-2 Value Type
 S RORSEG(2)="FT"
 ;--- OBX-3 Observation Identifier
 S RORSEG(3)=OBX3
 ;--- OBX-5 Observation Value
 S RORSEG(5)=OBX5
 ;--- OBX-11 Observation Result Status
 S RORSEG(11)="F"
 ;--- OBX-16 Responsible Observer (Procedure Provider)
 S:$G(OBX16)'="" RORSEG(16)=OBX16
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
