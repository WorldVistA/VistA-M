RORHL14 ;HOIFO/BH,SG - HL7 ALLERGY DATA: OBR,OBX ; 8/26/05 2:43pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #2167         Read access to the file #120.83 (controlled)
 ; #4531         ZERO^PSN50P41
 ; #4543         IEN^PSN50P65
 ; #10060        Read access to the file #200 (supported)
 ;
 ;
 Q
 ;
 ;***** SEARCHES FOR ALLERGY DATA
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
 N ERRCNT,IDX,RC,RORARR,RORDTE,RORENDT,RORIEN,RORSTDT,TMP
 S (ERRCNT,RC)=0
 ;
 S IDX=0
 F  S IDX=$O(DXDTS(13,IDX))  Q:IDX'>0  D  Q:RC<0
 . S RORSTDT=$P(DXDTS(13,IDX),U),RORENDT=$P(DXDTS(13,IDX),U,2)
 . ;---
 . S RORDTE=$O(^GMR(120.8,"AODT",RORSTDT),-1)
 . F  S RORDTE=$O(^GMR(120.8,"AODT",RORDTE))  Q:'RORDTE!(RORDTE'<RORENDT)  D
 . . S RORIEN=0
 . . F  S RORIEN=$O(^GMR(120.8,"AODT",RORDTE,RORIEN))  Q:'RORIEN  D
 . . . S:$D(^GMR(120.8,"B",RORDFN,RORIEN)) RORARR(RORIEN)=""
 . I $D(RORARR)<10  S ERRCNT=ERRCNT+1  Q
 . ;
 . S RORIEN=0
 . F  S RORIEN=$O(RORARR(RORIEN))  Q:'RORIEN  D
 . . S TMP=$$OBR(RORIEN,RORDFN)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . S TMP=$$OBX(RORIEN,RORDFN)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ;
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** ALLERGY OBR SEGMENT BUILDER
 ;
 ; RORAIEN       IEN of Allergy entry
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR(RORAIEN,RORDFN) ;
 N BUF,CS,ERRCNT,RC,RORLST,RORMSG,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 S RORAIEN=RORAIEN_","
 D GETS^DIQ(120.8,RORAIEN,".02;3.1;4;5;6","EI","RORLST","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-9,,RORDFN,120.8,RORAIEN)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - IEN of the record
 S RORSEG(3)=$P(RORAIEN,",")
 ;
 ;--- OBR-4 - Sevice ID
 S RORSEG(4)="95000"_CS_"ALLERGY"_CS_"C4"
 ;
 ;--- OBR-7 - Observation Date/Time (Origination Date)
 S TMP=$$FMTHL7^XLFDT($G(RORLST(120.8,RORAIEN,4,"I")))
 Q:TMP'>0 $$ERROR^RORERR(-95,,,RORDFN,120.8,RORAIEN,4)
 S RORSEG(7)=TMP
 ;
 ;--- OBR-13 - Relevant Clinical Info. (Reactant)
 S RORSEG(13)=$G(RORLST(120.8,RORAIEN,.02,"E"))
 ;
 ;--- OBR-16 - Ordering Provider
 S BUF=$G(RORLST(120.8,RORAIEN,5,"I"))
 I BUF>0  D
 . S $P(BUF,CS,13)=$$GET1^DIQ(200,+BUF_",",53.5,"E",,"RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1  Q
 . . D DBS^RORERR("RORMSG",-99,,RORDFN,200,+BUF_",")
 . S RORSEG(16)=BUF
 ;
 ;--- OBR-20 - Filler Field 1 (Allergy Type)
 S RORSEG(20)=$G(RORLST(120.8,RORAIEN,3.1,"E"))
 ;
 ;--- OBR-24 - Diagnostic Service ID
 S RORSEG(24)="TX"
 ;
 ;--- OBR-25 - Result Status (Observed/Historical)
 S TMP=$G(RORLST(120.8,RORAIEN,6,"E"))
 I TMP'=""  D  S RORSEG(25)=TMP
 . S TMP=$S(TMP="HISTORICAL":"R",TMP="OBSERVED":"F",1:"")
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** ALLERGY OBX SEGMENT(S) BUILDER
 ;
 ; RORAIEN       IEN of Allergy entry
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(RORAIEN,RORDFN) ;
 N BUF,CS,DTE,ERRCNT,IEN,RC,REAC,RORID,RORIENS,RORKEY,RORLST,RORMSG,RORSEG,RORTMP,RORTS,RPS,TMP
 S (ERRCNT,RC)=0,RORIENS=","_RORAIEN_","
 D ECH^RORHL7(.CS,,.RPS)
 ;
 ;=== Ingredients
 K RORLST,RORMSG
 D LIST^DIC(120.802,RORIENS,"@;.01","I",,,,,,,"RORLST","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,RORDFN,120.802,RORIENS)
 S RORID="INGR"_CS_"Ingredients"_CS_"VA080"
 ;---
 S RORTMP=$$ALLOC^RORTMP(.RORTS)
 S RORKEY=0
 F  S RORKEY=$O(RORLST("DILIST","ID",RORKEY))  Q:'RORKEY  D
 . S IEN=+$G(RORLST("DILIST","ID",RORKEY,.01))  Q:IEN'>0
 . D ZERO^PSN50P41(IEN,,,RORTS)
 . S TMP=$G(@RORTMP@(IEN,.01))
 . D:TMP'="" SETOBX(TMP,RORID)
 D FREE^RORTMP(RORTMP)
 ;
 ;=== Classes
 K RORLST,RORMSG
 D LIST^DIC(120.803,RORIENS,"@;.01","I",,,,,,,"RORLST","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,RORDFN,120.803,RORIENS)
 ;---
 S RORTMP=$$ALLOC^RORTMP(.RORTS)
 S (CNT,RORKEY)=0,BUF=""
 F  S RORKEY=$O(RORLST("DILIST","ID",RORKEY))  Q:'RORKEY  D
 . S IEN=+$G(RORLST("DILIST","ID",RORKEY,.01))  Q:IEN'>0
 . D IEN^PSN50P65(IEN,,RORTS)
 . S TMP=$G(@RORTMP@(IEN,.01))
 . S:TMP'="" BUF=BUF_$S(BUF'="":RPS_TMP,1:TMP)
 D:BUF'="" SETOBX(BUF,"CLAS"_CS_"Drug Class"_CS_"VA080")
 D FREE^RORTMP(RORTMP)
 ;
 ;=== Reactions
 K RORLST,RORMSG
 D LIST^DIC(120.81,RORIENS,"@;.01;3","I",,,,,,,"RORLST","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,RORDFN,120.81,RORIENS)
 S RORID="RCTS"_CS_"Reactions"_CS_"VA080"
 ;---
 S RORKEY=0
 F  S RORKEY=$O(RORLST("DILIST","ID",RORKEY))  Q:'RORKEY  D
 . S IEN=RORLST("DILIST","ID",RORKEY,.01)  Q:IEN'>0
 . S REAC=$$GET1^DIQ(120.83,IEN_",",.01,"E",,"RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1  Q
 . . D DBS^RORERR("RORMSG",-99,,RORDFN,120.83,IEN_",")
 . Q:REAC=""
 . S DTE=$$FM2HL^RORHL7($G(RORLST("DILIST","ID",RORKEY,3)))
 . D SETOBX(REAC,RORID,DTE)
 ;
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** CREATES AND STORES THE OBX SEGMENT
SETOBX(OBX5,OBX3,OBX12) ;
 N RORSEG
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;--- OBX-2 - Value Type
 S RORSEG(2)="FT"
 ;--- OBX-3 - Observation Identifier
 S RORSEG(3)=OBX3
 ;--- OBX-5 - Observation Value
 S RORSEG(5)=OBX5
 ;--- OBX-11 - Observation Result Status
 S RORSEG(11)="F"
 ;--- OBX-12 - Reactions Date/Time Entered
 S:$G(OBX12)'="" RORSEG(12)=OBX12
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
