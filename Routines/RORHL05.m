RORHL05 ;HOIFO/CRT - HL7 AUTOPSY: OBR ; 3/13/06 9:23am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #1995         $$CPT^ICPTCOD (supported)
 ; #3465         Access to autopsy data (private)
 ; #10040        Read the INSTITUTION field of file #44 (supported)
 ; #10090        Read access to the file #4 (supported)
 ;
 Q
 ;
 ;***** SEARCHES FOR AUTOPSY DATA
 ;
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; [FORCE]       Force the extraction of the autopsy data
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
EN1(RORDFN,DXDTS,FORCE) ;
 N ADATE,ERRCNT,RC,RORLRDFN,RORMSG
 S (ERRCNT,RC)=0
 ;
 ;--- Check if the autopsy has been performed
 S RORLRDFN=+$$LABREF^RORUTL18(RORDFN)  Q:RORLRDFN'>0 0
 S ADATE=$$GET1^DIQ(63,RORLRDFN_",",11,"I",,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,RORDFN,63,RORLRDFN_",")
 ;
 D:ADATE>0
 . ;--- Check if the autopsy data should be sent (autopsy date
 . ;    falls into one of the data extraction time frames or
 . ;--- the extraction if forced by the function parameter).
 . I '$G(FORCE)  S RC=0  D  Q:'RC
 . . N D1,D2,IDX
 . . S IDX=0
 . . F  S IDX=$O(DXDTS(7,IDX))  Q:IDX'>0  D  Q:RC
 . . . S D1=$P(DXDTS(7,IDX),U),D2=$P(DXDTS(7,IDX),U,2)
 . . . S:(ADATE'<D1)&(ADATE<D2) RC=1
 . .
 . ;--- Send the data
 . S RC=$$OBR(RORLRDFN)
 . I RC  Q:RC<0  S ERRCNT=ERRCNT+RC
 . S RC=$$OBX(RORLRDFN)
 . I RC  Q:RC<0  S ERRCNT=ERRCNT+RC
 ;
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** AUTOPSY OBR SEGMENT BUILDER
 ;
 ; RORLRDFN      IEN of Lab Patient Record in File #63
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR(RORLRDFN) ;
 N BUF,CS,ERRCNT,IEN,IENS63,RC,RORMSG,ROROUT,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 S IENS63=+$G(RORLRDFN)_","
 D GETS^DIQ(63,IENS63,"11;12.1;13.1;14;14.1;14.5;14.7","IE","ROROUT","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-9,,,63,IENS63)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - Order #
 I $G(ROROUT(63,IENS63,14,"E"))=""  D  Q RC
 . S RC=$$ERROR^RORERR(-95,,,,63,IENS63,14)
 S RORSEG(3)=ROROUT(63,IENS63,14,"E")
 ;
 ;--- OBR-4 - CPT Code
 S BUF=88099,TMP=$$CPT^ICPTCOD(BUF)
 I TMP<0  D  S ERRCNT=ERRCNT+1,TMP=""
 . D ERROR^RORERR(-57,,$P(TMP,U,2),,+TMP,"$$CPT^ICPTCOD")
 S $P(BUF,CS,2)=$$ESCAPE^RORHL7($P(TMP,U,3))
 S $P(BUF,CS,3)="C4"
 S RORSEG(4)=BUF
 ;
 ;--- OBR-7 - Autopsy Date/Time
 S TMP=$$FMTHL7^XLFDT($G(ROROUT(63,IENS63,11,"I")))
 Q:TMP'>0 $$ERROR^RORERR(-95,,,,63,IENS63,11)
 S RORSEG(7)=TMP
 ;
 ;--- OBR-8 - Date of the final autopsy diagnoses
 S RORSEG(8)=$$FMTHL7^XLFDT($G(ROROUT(63,IENS63,13.1,"I")))
 ;
 ;--- OBR-16 - Ordering Provider
 S RORSEG(16)=$G(ROROUT(63,IENS63,12.1,"I"))
 ;
 ;--- OBR-22 - Date/TIme the report is released
 S RORSEG(22)=$$FMTHL7^XLFDT($G(ROROUT(63,IENS63,14.7,"I")))
 ;
 ;--- OBR-24 - Diagnostic Service ID
 S RORSEG(24)="SP"
 ;
 ;--- OBR-44 - Division
 S TMP=$G(ROROUT(63,IENS63,14.1,"I"))
 S IEN=$S(TMP'="":+$O(^SC("B",TMP,0)),1:0)
 S RORSEG(44)=$$DIV44^RORHLUT1(IEN,CS)
 ;
 ;--- OBR-46 - Service
 S BUF=+$G(ROROUT(63,IENS63,14.5,"I"))
 D:BUF>0
 . S $P(BUF,CS,2)=$G(ROROUT(63,IENS63,14.5,"E"))
 . S RORSEG(46)=BUF
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** AUTOPSY OBX SEGMENT BUILDER
 ;
 ; RORLRDFN      IEN of Lab Patient Record in File #63
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(RORLRDFN) ;
 ;;32.2;;AUCD^Clinical Diagnosis^VA080
 ;;32.3;;AUPD^Pathological Diagnosis^VA080
 ;
 N BR,BUF,CS,ERRCNT,FLD,I,I1,ICNT,IENS63,IMF,RC,RORMSG,RORSEG,RORTXT,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 S BR=$E(HLECH,3)_".br"_$E(HLECH,3)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;
 ;--- OBX-2 - Value Type
 S RORSEG(2)="FT"
 ;
 ;--- OBX-11 - Observation Result Status
 S RORSEG(11)="F"
 ;
 ;--- Generate the OBX segments
 S IENS63=+$G(RORLRDFN)_","
 F IMF=1,2  D
 . S BUF=$T(OBX+IMF),FLD=$P(BUF,";;",2)
 . K RORMSG,RORTXT,RORSEG(5)
 . ;--- OBX-3 - Observation Identifier
 . S RORSEG(3)=$P(BUF,";;",3)
 . ;--- Load the text
 . S TMP=$$GET1^DIQ(63,IENS63,FLD,,"RORTXT","RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . D DBS^RORERR("RORMSG",-9,,,63,IENS63)
 . ;--- Process the text
 . S I=$O(RORTXT("")),ICNT=0
 . F  Q:I=""  S I1=$O(RORTXT(I))  D  S I=I1
 . . ;--- OBX-5 - Observation Value
 . . S TMP=$$ESCAPE^RORHL7(RORTXT(I))
 . . S ICNT=ICNT+1,RORSEG(5,ICNT)=$S(I1'="":TMP_BR,1:TMP)
 . ;--- Store the segment
 . D:ICNT>0 ADDSEG^RORHL7(.RORSEG)
 ;
 ;---
 Q ERRCNT
