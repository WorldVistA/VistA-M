RORHL081 ;HOIFO/BH - HL7 INPATIENT DATA: OBX ; 10/27/05 12:32pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #92           Read access to the PTF file (Controlled)
 ;
 Q
 ;
 ;***** BED SECTION
BEDSEC(RORIEN) ;
 N DATE,ERRCNT,FLD,ICDFLST,IEN4502,IENS,IFL,NODE,OID,RORBS,RORBSED,RORBSSD,RORBUF,RORCODE,RORMSG,TMP
 S ERRCNT=0,ICDFLST="5;6;7;8;9;11;12;13;14;15"
 S OID="INBED"_RORCS_"Bedsection Diagnosis"_RORCS_"VA080"
 S NODE=$$ROOT^DILFD(45.02,","_RORIEN_",",1)
 ;---
 S DATE=$$GET1^DIQ(45,RORIEN_",",2,"I",,"RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-99,,RORDFN,45,RORIEN_",")
 S (RORBSSD,RORBSED)=$$FM2HL^RORHL7(DATE)
 ;
 S DATE=""
 F  S DATE=$O(@NODE@("AM",DATE))  Q:DATE=""  D
 . S IEN4502=0
 . F  S IEN4502=$O(@NODE@("AM",DATE,IEN4502))  Q:IEN4502'>0  D
 . . S RORBSSD=RORBSED  K RORBUF
 . . S IENS=IEN4502_","_RORIEN_","
 . . ;--- Load the data
 . . D GETS^DIQ(45.02,IENS,"2;10;"_ICDFLST,"EI","RORBUF","RORMSG")
 . . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . . D DBS^RORERR("RORMSG",-99,,RORDFN,45.02,IENS)
 . . ;--- Name of the bed section
 . . S RORBS=$$ESCAPE^RORHL7($G(RORBUF(45.02,IENS,2,"E")))
 . . ;--- End date
 . . S RORBSED=$$FM2HL^RORHL7($G(RORBUF(45.02,IENS,10,"I")))
 . . ;--- ICD-9 codes
 . . S RORCODE=""
 . . F IFL=1:1  S FLD=+$P(ICDFLST,";",IFL)  Q:'FLD  D
 . . . S TMP=$G(RORBUF(45.02,IENS,FLD,"E"))
 . . . S:TMP'="" $P(RORCODE,RORRS,IFL)=TMP
 . . ;--- Store the segment (if there is at least one ICD-9 code)
 . . D:RORCODE'="" SETOBX(OID,RORCODE,RORBS,RORBSED,RORBSSD)
 ;
 Q ERRCNT
 ;
 ;***** DISCHARGE DIAGNOSIS CODES
DDIAG(RORIEN) ;
 N ERRCNT,FLD,ICDFLST,IENS,IFL,OID,RORBUF,RORDDIAG,TMP
 S ERRCNT=0,OID="INDIS"_RORCS_"Discharge Diagnosis"_RORCS_"VA080"
 S ICDFLST="79.16;79.17;79.18;79.19;79.201;79.21;79.22;79.23;79.24"
 ;--- Load the data
 S IENS=RORIEN_","
 D GETS^DIQ(45,IENS,ICDFLST,"E","RORBUF","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-99,,RORDFN,45,IENS)
 ;--- ICD-9 codes
 S RORDDIAG=""
 F IFL=1:1  S FLD=+$P(ICDFLST,";",IFL)  Q:'FLD  D
 . S TMP=$G(RORBUF(45,IENS,FLD,"E"))
 . S:TMP'="" $P(RORDDIAG,RORRS,IFL)=TMP
 ;--- Store the segment (if there is at least one ICD-9 code)
 D:RORDDIAG'="" SETOBX(OID,RORDDIAG)
 Q ERRCNT
 ;
 ;***** OBX SEGMENT(S) BUILDER (INPATIENT)
 ;
 ; RORIEN        IEN of file #45
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(RORIEN,RORDFN) ;
 N ERRCNT,RC,RORCS,RORLST,RORMSG,RORRS,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.RORCS,,.RORRS)
 ;
 ;--- Principal diagnosis
 S RC=$$PRIN(RORIEN)
 I RC  S ERRCNT=ERRCNT+1  Q:RC<0 RC
 ;--- Primary discharge diagnosis
 S RC=$$PDISCH(RORIEN)
 I RC  S ERRCNT=ERRCNT+1  Q:RC<0 RC
 ;--- Discharge diagnosis codes
 S RC=$$DDIAG(RORIEN)
 I RC  S ERRCNT=ERRCNT+1  Q:RC<0 RC
 ;--- Bed section
 S RC=$$BEDSEC(RORIEN)
 I RC  S ERRCNT=ERRCNT+1  Q:RC<0 RC
 ;--- Surgical procedures
 S RC=$$SURGPRO(RORIEN)
 I RC  S ERRCNT=ERRCNT+1  Q:RC<0 RC
 ;--- Other diagnoses
 S RC=$$OTRPROC(RORIEN)
 I RC  S ERRCNT=ERRCNT+1  Q:RC<0 RC
 ;
 Q ERRCNT
 ;
 ;***** OTHER DIAGNOSES
OTRPROC(RORIEN) ;
 N ERRCNT,FLD,ICDFLST,IEN4505,IENS,IFL,NODE,OID,RORBUF,RORMSG,ROROPBS,ROROPCD,ROROPDTE,TMP
 S ERRCNT=0,ICDFLST="4;5;6;7;8"
 S OID="INOTR"_RORCS_"Other Diagnosis"_RORCS_"VA080"
 S NODE=$$ROOT^DILFD(45.05,","_RORIEN_",",1)
 ;
 S IEN4505=0
 F  S IEN4505=$O(@NODE@(IEN4505))  Q:IEN4505'>0  D
 . S IENS=IEN4505_","_RORIEN_","  K RORBUF
 . ;--- Load the data
 . D GETS^DIQ(45.05,IENS,".01;1;"_ICDFLST,"EI","RORBUF","RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . D DBS^RORERR("RORMSG",-99,,RORDFN,45.05,IENS)
 . ;--- Name of the facility
 . S ROROPBS=$$ESCAPE^RORHL7($G(RORBUF(45.05,IENS,1,"E")))
 . ;--- Date of the procedure
 . S ROROPDTE=$$FM2HL^RORHL7($G(RORBUF(45.05,IENS,.01,"I")))
 . ;--- ICD-9 codes
 . S ROROPCD=""
 . F IFL=1:1  S FLD=+$P(ICDFLST,";",IFL)  Q:'FLD  D
 . . S TMP=$G(RORBUF(45.05,IENS,FLD,"E"))
 . . S:TMP'="" $P(ROROPCD,RORRS,IFL)=TMP
 . ;--- Store the segment (if there is at least one ICD-9 code)
 . D:ROROPCD'="" SETOBX(OID,ROROPCD,ROROPBS,,ROROPDTE)
 ;
 Q ERRCNT
 ;
 ;***** PRIMARY DISCHARGE DIAGNOSIS
PDISCH(IEN) ;
 N ERRCNT,OID,RORDD,RORMSG,TMP
 S ERRCNT=0,OID="INPRI"_RORCS_"Primary Dis. Diagnosis"_RORCS_"VA080"
 ;--- Load the data
 S RORDD=$$GET1^DIQ(45,IEN_",",79,"E",,"RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-99,,RORDFN,45,IEN_",")
 ;--- Store the segment
 D:RORDD'="" SETOBX(OID,RORDD)
 Q ERRCNT
 ;
 ;***** PRINCIPAL DIAGNOSIS
PRIN(IEN) ;
 N ERRCNT,OID,RORMSG,RORPDIAG,TMP
 S ERRCNT=0,OID="INAD"_RORCS_"Admitting Diagnosis"_RORCS_"VA080"
 ;--- Load the data
 S RORPDIAG=$$GET1^DIQ(45,IEN_",",80,"E",,"RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-99,,RORDFN,45,IEN_",")
 ;--- Store the segment
 D:RORPDIAG'="" SETOBX(OID,RORPDIAG)
 Q ERRCNT
 ;
 ;***** LOW-LEVEL SEGMENT BUILDER
 ;
 ; OBX3          Observation Identifier
 ;
 ; OBX5          Observation Value
 ;
 ; [OBX6]        Bed Section
 ;
 ; [OBX12]       Bed Section End Date/Time
 ;
 ; [OBX14]       Bed Section Start Date, if OBX3 contains
 ;               "INBED^Bedsection Diagnosis";
 ;               Surgical Procedure Date, if OBX3 contains
 ;               "INSURG^Surgical Procedures";
 ;               Other Procedure Date, if OBX3 contains
 ;               "INOTR^Other Diagnosis".
 ;
SETOBX(OBX3,OBX5,OBX6,OBX12,OBX14) ;
 N RORSEG
 S RORSEG(0)="OBX"
 ;--- OBX-2 Value Type
 S RORSEG(2)="FT"
 ;--- OBX-3 Observation Identifier
 S RORSEG(3)=OBX3
 ;--- OBX-5 Observation Value
 S RORSEG(5)=OBX5
 ;--- OBX-6 Bed Section
 S:$G(OBX6)'="" RORSEG(6)=OBX6
 ;--- OBX-11 Observation Result Status
 S RORSEG(11)="F"
 ;--- OBX-12 Bed Section End Date/Time
 S:$G(OBX12)'="" RORSEG(12)=OBX12
 ;--- OBX-14 Bed Section Start Date/Time or Procedure Date
 S:$G(OBX14)'="" RORSEG(14)=OBX14
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
 ;
 ;***** SURGICAL PROCEDURES
SURGPRO(RORIEN) ;
 N ERRCNT,FLD,IEN4501,IENS,IFL,NODE,OID,RORBUF,RORMSG,SDTE,SPCD,SPFLST,TMP
 S ERRCNT=0,SPFLST="8;9;10;11;12"
 S OID="INSURG"_RORCS_"Surgical Procedures"_RORCS_"VA080"
 S NODE=$$ROOT^DILFD(45.01,","_RORIEN_",",1)
 ;
 S IEN4501=0
 F  S IEN4501=$O(@NODE@(IEN4501))  Q:IEN4501'>0  D
 . S IENS=IEN4501_","_RORIEN_","  K RORBUF
 . ;--- Load the data
 . D GETS^DIQ(45.01,IENS,".01;"_SPFLST,"EI","RORBUF","RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . D DBS^RORERR("RORMSG",-99,,RORDFN,45.01,IENS)
 . ;--- Date of the procedure
 . S SDTE=$$FM2HL^RORHL7($G(RORBUF(45.01,IENS,.01,"I")))
 . ;--- Procedure codes
 . S SPCD=""
 . F IFL=1:1  S FLD=+$P(SPFLST,";",IFL)  Q:'FLD  D
 . . S TMP=$G(RORBUF(45.01,IENS,FLD,"E"))
 . . S:TMP'="" $P(SPCD,RORRS,IFL)=TMP
 . ;--- Store the segment (if there is at least one code)
 . D:SPCD'="" SETOBX(OID,SPCD,,,SDTE)
 ;
 Q ERRCNT
