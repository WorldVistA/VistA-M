RORHL081 ;HOIFO/BH - HL7 INPATIENT DATA: OBX ;10/27/05 12:32pm
 ;;1.5;CLINICAL CASE REGISTRIES;**19,25**;Feb 17, 2006;Build 19
 ;
 ; This routine uses the following IAs:
 ;
 ; #92           Read access to the PTF file (Controlled)
 ; #6130         PTFICD^DGPTFUT         
 ;
 ;******************************************************************************
 ;******************************************************************************
 ; --- ROUTINE MODIFICATION LOG ---
 ; 
 ;PKG/PATCH   DATE       DEVELOPER   MODIFICATION
 ;----------- ---------- ----------- ----------------------------------------
 ;ROR*1.5*19  MAY 2012   K GUPTA     Support for ICD-10 Coding System.
 ;ROR*1.5*25  OCT 2014   T KOPP      Support for expanded # of PTF diagnoses
 ;                                    and procedures for ICD-10
 ;
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** BED SECTION (501 segment)
BEDSEC(RORIEN) ;
 N DATE,ERRCNT,FLD,IEN4502,IENS,NODE,OID,RORBS,RORBSED,RORBSSD,RORBUF,RORIBUF,RORCODE,RORMSG,TMP,RORICDSNAM,DIERR
 S ERRCNT=0
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
 . . D GETS^DIQ(45.02,IENS,"2;10","EI","RORBUF","RORMSG")
 . . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . . D DBS^RORERR("RORMSG",-99,,RORDFN,45.02,IENS)
 . . ;--- Name of the bed section
 . . S RORBS=$$ESCAPE^RORHL7($G(RORBUF(45.02,IENS,2,"E")))
 . . ;--- End date
 . . S RORBSED=$$FM2HL^RORHL7($G(RORBUF(45.02,IENS,10,"I")))
 . . ;--- ICD codes
 . . S (RORCODE,RORICDSNAM)=""
 . . D GETICD(501,RORIEN,IEN4502,"",.RORCODE,.RORICDSNAM)
 . . ;--- Store the segment (if there is at least one ICD code)
 . . D:RORCODE'="" SETOBX(OID,RORICDSNAM_":"_RORCODE,RORBS,RORBSED,RORBSSD)
 ;
 Q ERRCNT
 ;
 ;***** DISCHARGE DIAGNOSIS CODES (701 segment)
DDIAG(RORIEN) ;
 N ERRCNT,FLD,IFL,OID,RORIBUF,RORDDIAG,TMP,RORICDSNAM
 S ERRCNT=0,OID="INDIS"_RORCS_"Discharge Diagnosis"_RORCS_"VA080"
 ;--- ICD codes
 S (RORDDIAG,RORICDSNAM)=""
 D GETICD(701,RORIEN,"",0,.RORDDIAG,.RORICDSNAM)
 ;--- Store the segment (if there is at least one ICD code)
 D:RORDDIAG'="" SETOBX(OID,RORICDSNAM_":"_RORDDIAG)
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
 N ERRCNT,FLD,IEN4505,IENS,IFL,NODE,OID,RORBUF,RORMSG,ROROPBS,ROROPCD,ROROPDTE,TMP,RORICDSNAM
 S ERRCNT=0
 S OID="INOTR"_RORCS_"Other Diagnosis"_RORCS_"VA080"
 S NODE=$$ROOT^DILFD(45.05,","_RORIEN_",",1)
 ;
 S IEN4505=0
 F  S IEN4505=$O(@NODE@(IEN4505))  Q:IEN4505'>0  D
 . S IENS=IEN4505_","_RORIEN_","  K RORBUF
 . ;--- Load the data
 . D GETS^DIQ(45.05,IENS,".01;1;","EI","RORBUF","RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . D DBS^RORERR("RORMSG",-99,,RORDFN,45.05,IENS)
 . ;--- Name of the facility
 . S ROROPBS=$$ESCAPE^RORHL7($G(RORBUF(45.05,IENS,1,"E")))
 . ;--- Date of the procedure
 . S ROROPDTE=$$FM2HL^RORHL7($G(RORBUF(45.05,IENS,.01,"I")))
 . ;--- ICD codes
 . S (ROROPCD,RORICDSNAM)=""
 . D GETICD(601,RORIEN,IEN4505,"",.ROROPCD,.RORICDSNAM)
 . ;--- Store the segment (if there is at least one ICD code)
 . D:ROROPCD'="" SETOBX(OID,RORICDSNAM_":"_ROROPCD,ROROPBS,,ROROPDTE)
 ;
 Q ERRCNT
 ;
 ;***** PRIMARY DISCHARGE DIAGNOSIS
PDISCH(IEN) ;
 N ERRCNT,OID,RORDD,RORMSG,TMP,RORICDSNAM,RORBUF
 S ERRCNT=0,OID="INPRI"_RORCS_"Primary Dis. Diagnosis"_RORCS_"VA080"
 ;--- Load the data
 S IEN=IEN_","
 D GETS^DIQ(45,IEN,79,"EI","RORBUF","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-99,,RORDFN,45,IEN)
 S RORDD=$G(RORBUF(45,IEN,79,"E"))
 ;--- Store the segment
 I RORDD'="" D
 . S RORICDSNAM=$$CSNAME^RORHLUT1(80,$G(RORBUF(45,IEN,79,"I")))
 . D SETOBX(OID,RORICDSNAM_":"_RORDD)
 Q ERRCNT
 ;
 ;***** PRINCIPAL DIAGNOSIS
PRIN(IEN) ;
 N ERRCNT,OID,RORMSG,RORPDIAG,TMP,RORICDSNAM,RORBUF,RORFLD
 S ERRCNT=0,OID="INAD"_RORCS_"Admitting Diagnosis"_RORCS_"VA080"
 ;--- Load the data
 S IEN=IEN_","
 D GETS^DIQ(45,IEN,79,"EI","RORBUF","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-99,,RORDFN,45,IEN)
 S RORPDIAG=$G(RORBUF(45,IEN,79,"E")),RORFLD=79
 ; Look at pre-1986 Dx only if PRIMARY DIAGNOSIS is missing
 I RORPDIAG="" D
 . K RORBUF,RORMSG
 . D GETS^DIQ(45,IEN,80,"EI","RORBUF","RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 .. D DBS^RORERR("RORMSG",-99,,RORDFN,45,IEN)
 . S RORPDIAG=$G(RORBUF(45,IEN,80,"E")),RORFLD=80
 ;--- Store the segment
 I RORPDIAG'="" D
 . S RORICDSNAM=$$CSNAME^RORHLUT1(80,$G(RORBUF(45,IEN,RORFLD,"I")))
 . D SETOBX(OID,RORICDSNAM_":"_RORPDIAG)
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
 ;***** SURGICAL PROCEDURES  (401 segment)
SURGPRO(RORIEN) ;
 N ERRCNT,FLD,IEN4501,IENS,IFL,NODE,OID,RORBUF,RORIBUF,RORMSG,SDTE,SPCD,TMP,RORICDSNAM
 S ERRCNT=0
 ;S SPFLST="8;9;10;11;12"
 S OID="INSURG"_RORCS_"Surgical Procedures"_RORCS_"VA080"
 S NODE=$$ROOT^DILFD(45.01,","_RORIEN_",",1)
 ;
 S IEN4501=0
 F  S IEN4501=$O(@NODE@(IEN4501))  Q:IEN4501'>0  D
 . S IENS=IEN4501_","_RORIEN_","  K RORBUF
 . ;--- Load the data
 . D GETS^DIQ(45.01,IENS,".01;","EI","RORBUF","RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . D DBS^RORERR("RORMSG",-99,,RORDFN,45.01,IENS)
 . ;--- Date of the procedure
 . S SDTE=$$FM2HL^RORHL7($G(RORBUF(45.01,IENS,.01,"I")))
 . ;--- Procedure codes
 . S (SPCD,RORICDSNAM)="",IFL=0
 . D GETICD(401,RORIEN,IEN4501,"",.SPCD,.RORICDSNAM)
 . ;--- Store the segment (if there is at least one code)
 . D:SPCD'="" SETOBX(OID,RORICDSNAM_":"_SPCD,,,SDTE)
 ;
 Q ERRCNT
 ;
GETICD(RORSEG,RORIEN,RORIEN1,RORSTART,RORCODE,RORICDSNAM) ;  Extract Dx or proc
 N RORIBUF,IFL,FLD,TMP
 ;--- Get ICD codes
 D PTFICD^DGPTFUT(RORSEG,RORIEN,RORIEN1,.RORIBUF)
 S (RORCODE,RORICDSNAM)="",IFL=0
 S FLD=$G(RORSTART) F  S FLD=$O(RORIBUF(FLD)) Q:FLD=""  I $G(RORIBUF(FLD))'="" D
 . S TMP=$P(RORIBUF(FLD),U,3) Q:TMP=""
 . S IFL=IFL+1,$P(RORCODE,RORRS,IFL)=TMP
 . S:RORICDSNAM="" RORICDSNAM=$$CSNAME^RORHLUT1(80,$P(RORIBUF(FLD),U))
 Q
 ;
