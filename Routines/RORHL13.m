RORHL13 ;HOIFO/BH,SG - HL7 MEDICAL PROCEDURES (EKG): OBR,OBX ; 8/25/05 11:32am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #3780         GET^MCARAPI (private)
 ; #3854         GET^MDAPI1 (private)
 ;
 Q
 ;
 ;***** CONVERTS THE DATE FROM EXTERNAL TO HL7 FORMAT
DATE(DATE) ;
 N RES
 D DT^DILF(,$P(DATE,"@"),.RES)
 Q $$FM2HL^RORHL7($G(RES))
 ;
 ;***** SEARCHES FOR MEDICAL PROCEDURES (EKG)
 ;
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
EN1(RORDFN,DXDTS) ;
 N ERRCNT,IDX,RC,RORENDT,RORESULT,RORIENS,RORSTDT,SF,TMP
 S (ERRCNT,RC)=0
 S RORESULT=$$ALLOC^RORTMP()
 ;
 S IDX=0
 F  S IDX=$O(DXDTS(12,IDX))  Q:IDX'>0  D  Q:RC<0
 . S RORSTDT=$P(DXDTS(12,IDX),U),RORENDT=$P(DXDTS(12,IDX),U,2)
 . K @RORESULT
 . ;
 . ;--- Check if Clinical Procedures patch has been installed,
 . ;--- if not call the API associated with the Medicine Patch.
 . S TMP=".01;.02;11;14;20;21;18"
 . I $D(ROREXT("PATCH","MD*1.0*1"))  D
 . . D GET^MDAPI1(RORESULT,RORDFN,RORSTDT,RORENDT,TMP)
 . E  I $D(ROREXT("PATCH","MC*2.3*34"))  D
 . . D GET^MCARAPI(RORESULT,RORDFN,RORSTDT,RORENDT,TMP)
 . E  S ERRCNT=ERRCNT+1  Q
 . ;
 . ;--- Build the index
 . F SF=691.54  S TMP=""  D
 . . F  S TMP=$O(@RORESULT@(SF,TMP))  Q:TMP=""  D
 . . . S @RORESULT@("A",SF,$P(TMP,",",2)_",",TMP)=""
 . ;
 . ;--- Process the data
 . S RORIENS=""
 . F  S RORIENS=$O(@RORESULT@(691.5,RORIENS))  Q:RORIENS=""  D
 . . S TMP=$$OBR(RORIENS)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . S TMP=$$OBX(RORIENS)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ;
 D FREE^RORTMP(RORESULT)
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** MEDICAL PROCEDURE (EKG) OBR SEGMENT BUILDER
 ;
 ; RORIENS       Medical Procedure Record IENS
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR(RORIENS) ;
 N CS,ERRCNT,IEN,RC,ROROUT,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - IEN in the ELECTROCARDIOGRAM (EKG) file #691.5
 S RORSEG(3)=$TR(RORIENS,",")
 ;
 ;--- OBR-4 - Universal Service ID
 S RORSEG(4)="93000"_CS_"ELECTROCARDIOGRAM"_CS_"C4"
 ;
 ;--- OBR-6 - Requested Date/time (date of the EKG)
 S TMP=$$DATE($G(@RORESULT@(691.5,RORIENS,.01,"E")))
 Q:TMP'>0 $$ERROR^RORERR(-95,,,,691.5,RORIENS,.01)
 S RORSEG(6)=TMP
 ;
 ;--- OBR-7 - Observation Date/Time (when received from an instrument)
 S RORSEG(7)=$$DATE($G(@RORESULT@(691.5,RORIENS,21,"E")))
 ;
 ;--- OBR-24 - Diagnostic Service ID
 S RORSEG(24)="EC"
 ;
 ;--- OBR-25 - Confirmation Status
 S TMP=$G(@RORESULT@(691.5,RORIENS,11,"E"))
 I TMP'=""  D  S RORSEG(25)=TMP
 . S TMP=$S(TMP="CONFIRMED":"F",TMP="UNCONFIRMED":"R",1:"")
 ;
 ;--- OBR-44 - Division
 S TMP=$G(@RORESULT@(691.5,RORIENS,18,"E"))
 S IEN=$S(TMP'="":+$O(^SC("B",TMP,0)),1:0)
 S RORSEG(44)=$$DIV44^RORHLUT1(IEN,CS)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** MEDICAL PROCEDURE (EKG) OBX SEGMENT(S) BUILDER
 ;
 ; RORIENS       Medical Procedure Record IENS
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(RORIENS) ;
 N CS,ERRCNT,RC,RORID,RORINT,RORKEY,RORMOD,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;--- Process any interpretation data
 S RORID="INT"_CS_"Interpretation"_CS_"VA080"
 S RORKEY=""
 F  S RORKEY=$O(@RORESULT@("A",691.54,RORIENS,RORKEY))  Q:RORKEY=""  D
 . S RORINT=$G(@RORESULT@(691.54,RORKEY,.01,"E"))
 . Q:RORINT=""
 . S RORMOD=$G(@RORESULT@(691.54,RORKEY,1,"E"))
 . D SETOBX(RORID,RORMOD,RORINT)
 ;
 ;--- Process auto instrument data
 S RORID="AUTO"_CS_"Auto Instrument"_CS_"VA080"
 D SETOBXWP^RORHLUT1($NA(@RORESULT@(691.5,RORIENS,20)),RORID)
 ;
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** CREATES AND STORES THE OBX SEGMENT
SETOBX(OBX3,OBX4,OBX5) ;
 N RORSEG
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;--- OBX-2 - Value Type
 S RORSEG(2)="FT"
 ;--- OBX-3 - Observation Identiifer
 S RORSEG(3)=OBX3
 ;--- OBX-4 - Observation Sub-ID (Interpretation Code Modifier)
 S:$G(OBX4)'="" RORSEG(4)=OBX4
 ;--- OBX-5 - Observation Value
 S RORSEG(5)=$$ESCAPE^RORHL7(OBX5)
 ;--- OBX-11 - Observation Result Status
 S RORSEG(11)="F"
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
