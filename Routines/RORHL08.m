RORHL08 ;HOIFO/BH - HL7 INPATIENT DATA: PV1,OBR ; 3/13/06 9:24am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #92           Read access to the PTF file (controlled)
 ; #994          Read access to the PTF CLOSE OUT file (controlled)
 ;
 Q
 ;
 ;***** INPATIENT DATA SEGMENT BUILDER
 ;
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; RORTY         Set to either "PV1" or "OBR"
 ;
 ; The ^TMP("RORHL08",$J) global node is used by this function.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
EN1(RORDFN,DXDTS,RORTY) ;
 N ERRCNT,IENS,INIEN,PV1CNT,RC,RORMSG,TMP
 S (ERRCNT,RC)=0
 ;
 ;--- PV1 Segments
 I RORTY="PV1"  K ^TMP("RORHL08",$J)  D
 . N DATE,ENDT,IDX,STDT,TYPE,XREF
 . S XREF=$NA(^TMP("RORPTF",$J,"PDI",RORDFN))
 . S (IDX,PV1CNT)=0
 . F  S IDX=$O(DXDTS(3,IDX))  Q:IDX'>0  D  Q:RC<0
 . . S STDT=$P(DXDTS(3,IDX),U),ENDT=$P(DXDTS(3,IDX),U,2)
 . . ;---
 . . S TMP=$$UPDNDX(STDT,ENDT)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . ;---
 . . S DATE=$O(@XREF@(STDT),-1)
 . . F  S DATE=$O(@XREF@(DATE))  Q:'DATE!(DATE'<ENDT)  D
 . . . S INIEN=""
 . . . F  S INIEN=$O(@XREF@(DATE,INIEN))  Q:'INIEN  D
 . . . . S IENS=INIEN_","
 . . . . ;--- Skip non-PTF records
 . . . . S TYPE=$$GET1^DIQ(45,IENS,11,"I",,"RORMSG")
 . . . . I $G(DIERR)  D  S ERRCNT=ERRCNT+1  Q
 . . . . . D DBS^RORERR("RORMSG",-9,,RORDFN,45,IENS)
 . . . . Q:TYPE'="1"
 . . . . ;--- Generate the PV1 segment
 . . . . S TMP=$$PV1(INIEN,RORDFN)
 . . . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . . . ;--- Reference for the corresponding OBR and OBX segments
 . . . . S:TMP'="S" PV1CNT=PV1CNT+1,^TMP("RORHL08",$J,PV1CNT)=INIEN
 ;
 ;--- OBR and OBX Segments
 I RORTY="OBR"  D  K ^TMP("RORHL08",$J)
 . S PV1CNT=0
 . F  S PV1CNT=$O(^TMP("RORHL08",$J,PV1CNT))  Q:PV1CNT'>0  D
 . . S INIEN=+$G(^TMP("RORHL08",$J,PV1CNT))  Q:INIEN'>0
 . . ;---
 . . S TMP=$$OBR(INIEN,RORDFN)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . ;---
 . . S TMP=$$OBX^RORHL081(INIEN,RORDFN)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ;
 ;--- Check for errors
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** MERGES THE TIME FRAME INTO THE LIST
 ;
 ; .DXDTS        Reference to a local array where the time frames
 ;               are returned: DXDTS(StartDT)=StartDT^EndDT.
 ;
 ; STDT          Start date
 ; ENDT          End date
 ;
 ; This procedure merges the provided time frame [STDT,ENDT[ into
 ; the list stored in the ^TMP("RORPTF",$J,"DTF") global node and
 ; returns a list of time frames that should be updated into a
 ; local array defined by the DXDTS parameter.
 ;
 ; Variants of positional relationship of the existing time frames
 ; and the one that is being added to the list:
 ;
 ; (1)  +--------TMP                      +----------+
 ;                     STDT--------ENDT
 ;
 ; (2)           +--------TMP
 ;      STDT--------ENDT
 ;
 ; (3)  TMP--------+
 ;           STDT--------ENDT
 ;
 ; (4)         +--------+
 ;      STDT------------------ENDT
 ;
MERGEDTF(DXDTS,STDT,ENDT) ;
 N DATE,DXE,DXS,ENDT0,EXIT,STDT0,TMP  K DXDTS
 Q:STDT>ENDT
 S STDT0=STDT,(DXE,ENDT0)=ENDT
 ;--- Merge time frames if possible
 S DATE=$O(^TMP("RORPTF",$J,"DTF",ENDT)),EXIT=0
 F  S DATE=$O(^TMP("RORPTF",$J,"DTF",DATE),-1)  Q:DATE=""  D  Q:EXIT
 . S DXS=$P(^TMP("RORPTF",$J,"DTF",DATE),U,2)
 . I DXS<STDT  S EXIT=1  Q         ; (1)
 . S:DXS>ENDT ENDT=DXS,DFLT=0      ; (2)
 . S:DXS<DXE DXDTS(DXS)=DXS_U_DXE
 . S DXE=$P(^TMP("RORPTF",$J,"DTF",DATE),U)
 . S:DXE<STDT STDT=DXE,DFLT=0      ; (3)
 . K ^TMP("RORPTF",$J,"DTF",DATE)
 S:DXE>STDT0 DXDTS(STDT0)=STDT0_U_DXE
 ;--- Store the new time frame
 S ^TMP("RORPTF",$J,"DTF",STDT)=STDT_U_ENDT
 Q
 ;
 ;***** OBR SEGMENT BUILDER (INPATIENT)
 ;
 ; RORIEN        IEN of file #45
 ;
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR(RORIEN,RORDFN) ;
 N CS,ERRCNT,IENS,OBDT,RC,RORMSG,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - Order Number (IEN in the PTF file #45)
 S RORSEG(3)=RORIEN
 ;
 ;--- OBR-4 - Universal Service ID
 S RORSEG(4)="IP"_CS_"Inpatient"_CS_"C4"
 ;
 ;--- OBR-7 -Observation Date/Time (Admission Date/Time) *KEY*
 S IENS=RORIEN_","
 S OBDT=$$GET1^DIQ(45,IENS,2,"I",,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,RORDFN,45,IENS)
 ;---
 S OBDT=$$FMTHL7^XLFDT(OBDT)
 Q:OBDT'>0 $$ERROR^RORERR(-95,,,RORDFN,45,IENS,2)
 S RORSEG(7)=OBDT
 ;
 ;--- OBR-24 - Diagnostic Service ID
 S RORSEG(24)="PHY"
 ;
 ;--- OBR-44 - Division
 S RORSEG(44)=$$SITE^RORUTL03(CS)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** PV1 SEGMENT BUILDER (INPATIENT)
 ;
 ; RORIEN        IEN of file #45
 ;
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;      "S"  No inpatient data
 ;       >0  Non-fatal error(s)
 ;
PV1(RORIEN,RORDFN) ;
 N BUF,CS,ERRCNT,IENS,RC,RORBUF,RORMSG,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;--- Load the data
 S IENS=RORIEN_","
 D GETS^DIQ(45,IENS,"2;70;71;72","I","RORBUF","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-9,,RORDFN,45,IENS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="PV1"
 ;
 ;--- PV1-2 - Patient Class
 S RORSEG(2)="I"  ; I - Inpatient
 ;
 ;--- PV1-3 - Assigned Patient Location (Station Number)
 S TMP=$E($P($$SITE^VASITE,U,3),1,3)  ; Strip the suffix
 Q:TMP'>0 $$ERROR^RORERR(-100,,,,"No station number","$$SITE^VASITE")
 S RORSEG(3)=TMP
 ;
 ;--- PV1-6 - Prior Patient Location (Bed Section at Discharge)
 I $G(RORBUF(45,IENS,71,"I"))>0  D
 . S BUF=""
 . S $P(BUF,CS,3)=RORBUF(45,IENS,71,"I")  ; Bed Section IEN
 . S TMP=$$EXTERNAL^DILFD(45,71,,$P(BUF,CS,3),"RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1  Q
 . . D DBS^RORERR("RORMSG",-99,,RORDFN,45,IENS)
 . S $P(BUF,CS,9)=$$ESCAPE^RORHL7(TMP)    ; Bed Section Name
 . S RORSEG(6)=BUF
 ;
 ;--- PV1-19 - Visit Number (IEN in the PTF file #45) *KEY*
 S RORSEG(19)=RORIEN
 ;
 ;--- PV1-36 - Discharge Disposition
 S RORSEG(36)=$G(RORBUF(45,IENS,72,"I"))
 ;
 ;--- PV1-44 - Admit Date/Time *KEY*
 S TMP=$$FMTHL7^XLFDT($G(RORBUF(45,IENS,2,"I")))
 Q:TMP'>0 $$ERROR^RORERR(-95,,,RORDFN,45,IENS,2)
 S RORSEG(44)=TMP
 ;
 ;--- PV1-45 - Discharge Date/Time
 S RORSEG(45)=$$FM2HL^RORHL7($G(RORBUF(45,IENS,70,"I")))
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** UPDATES TEMPORARY PTF INDEX
 ;
 ; STDT          Start date
 ; ENDT          End date
 ;
 ; This function updates the temporary PTF index with records
 ; closed in the provided time frame.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
UPDNDX(STDT,ENDT) ;
 N DATE,DXDTS,IDX,IEN,PATIEN,RC,RORMSG,TMP
 ;--- Get time frames that should be processed
 D MERGEDTF(.DXDTS,STDT,ENDT)  Q:$D(DXDTS)<10 0
 ;--- Update the index
 S IDX=0
 F  S IDX=$O(DXDTS(IDX))  Q:IDX'>0  D
 . S STDT=$P(DXDTS(IDX),U),ENDT=$P(DXDTS(IDX),U,2)
 . S DATE=$O(^DGP(45.84,"AC",STDT),-1)
 . F  S DATE=$O(^DGP(45.84,"AC",DATE))  Q:'DATE!(DATE'<ENDT)  D
 . . S IEN=0
 . . F  S IEN=$O(^DGP(45.84,"AC",DATE,IEN))  Q:IEN'>0  D
 . . . ;--- Patient IEN (entries of file #45.84 are DINUM'ed)
 . . . S PATIEN=$$GET1^DIQ(45,IEN,.01,"I",,"RORMSG")
 . . . I $G(DIERR)  D DBS^RORERR("RORMSG",-99,,,45,IEN)  Q
 . . . ;--- Create index entry
 . . . S:PATIEN>0 ^TMP("RORPTF",$J,"PDI",PATIEN,DATE,IEN)=""
 ;---
 Q 0
