RORUPD09 ;HCIOFO/SG - PROCESSING OF THE 'PTF' FILE  ;8/3/05 9:50am
 ;;1.5;CLINICAL CASE REGISTRIES;**18,25,26,37**;Feb 17, 2006;Build 9
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*18   APR 2012    C RAY        Modified PTF RULE to use B xref #798.5
 ;ROR*1.5*25   FEB 2015    T KOPP       Modified PTF rule to add new Diagnosis
 ;                                      fields for ICD-10 PTF expansion.
 ;ROR*1.5*26   MAR 2015    T KOPP       Added rule for PTF procedure codes check
 ;                                      in API #3
 ;ROR*1.5*37   SEP 2020    F TRAXLER    Added ALLPAT subroutine
 ;*****************************************************************************
 ;*****************************************************************************
 ; This routine uses the following IAs:
 ;
 ; #3157         RPC^DGPTFAPI
 ; #3545         Access to the "AAD" cross-reference and the field 80
 ; #10103        $$FMADD^XLFDT (supported)
 ; #2171         $$IEN^XUAF4 (supported)
 ;
 ;
 Q
 ;
 ;***** LOADS DATA ELEMENT VALUES
 ;
 ; IENS          IENS of the current record
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOAD(IENS) ;
 N RC  S RC=0
 ;--- API #1 or #3
 I $S($D(RORUPD("SR",RORFILE,"F",1)):1,1:$D(RORUPD("SR",RORFILE,"F",3))) D  Q:RC<0 RC
 . S RC=$$LOADFLDS^RORUPDUT(RORFILE,IENS)
 ;--- API #2
 I $D(RORUPD("SR",RORFILE,"F",2))  D  Q:RC<0 RC
 . N API,DE,IN,IP,RORBUF,VT
 . D RPC^DGPTFAPI(.RORBUF,+IENS)
 . I $G(RORBUF(0))<0  S API="RPC^DGPTFAPI"  D  Q
 . . S RC=$$ERROR^RORERR(-57,,,,RORBUF(0),API)
 . ;---
 . S DE=""
 . F  S DE=$O(RORUPD("SR",RORFILE,"F",2,DE))  Q:DE=""  D
 . . S VT=""
 . . F  S VT=$O(RORUPD("SR",RORFILE,"F",2,DE,VT))  Q:VT=""  D
 . . . S IP=+$P(RORUPD("SR",RORFILE,"F",2,DE,VT),U,1)  Q:IP'>0
 . . . S IN=+$P(RORUPD("SR",RORFILE,"F",2,DE,VT),U,2)
 . . . S RORVALS("DV",RORFILE,DE,VT)=$P($G(RORBUF(IN)),U,IP)
 Q 0
 ;
 ;***** PROCESSING OF THE 'PTF' FILE
 ;
 ; UPDSTART      Date of the earliest update
 ; PATIEN        Patient IEN
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Continue processing of the current patient
 ;        1  Stop processing
 ;
PTF(UPDSTART,PATIEN) ;
 N RORFILE       ; File number
 ;
 N ADMDT,ADMIENS,EDT,IEN,LOCATION,NODE,RC,TMP
 S RORFILE=45,EDT=RORUPD("DSEND")
 ;--- Check the event references if the events are enabled
 I $G(RORUPD("FLAGS"))["E"  D  Q:RC'>0 RC
 . S RC=$$GET^RORUPP02(PATIEN,3,.UPDSTART,.EDT)
 . S:RC>1 UPDSTART=UPDSTART\1,EDT=$$FMADD^XLFDT(EDT\1,1)
 ;--- Subtract 1 second from the start date to include
 ;    it into the interval
 S ADMDT=$$FMADD^XLFDT(UPDSTART,,,,-1)
 ;
 ;--- Browse through the admissions
 S NODE=RORUPD("ROOT",RORFILE),NODE=$NA(@NODE@("AAD",PATIEN))
 S RC=0
 F  S ADMDT=$O(@NODE@(ADMDT))  Q:(ADMDT="")!(ADMDT'<EDT)  D  Q:RC
 . S IEN=""
 . F  S IEN=$O(@NODE@(ADMDT,IEN))  Q:IEN=""  D  Q:RC
 . . S ADMIENS=IEN_","
 . . ;--- Load necessary data elements
 . . I $D(RORUPD("SR",RORFILE,"F"))>1  D  I TMP<0 D INCEC^RORUPDUT() Q
 . . . S TMP=$$LOAD(ADMIENS)
 . . . S TMP=$$GETDE^RORUPDUT(45,131)_$$GETDE^RORUPDUT(45,132)
 . . . S LOCATION=$S(TMP'="":$$IEN^XUAF4(TMP),1:"")
 . . ;--- Apply "before" rules
 . . S RC=$$APLRULES^RORUPDUT(RORFILE,ADMIENS,"B",ADMDT,$G(LOCATION))
 . . I RC  D INCEC^RORUPDUT(.RC)  Q
 . . ;--- Apply "after" rules
 . . S RC=$$APLRULES^RORUPDUT(RORFILE,ADMIENS,"A",ADMDT,$G(LOCATION))
 . . I RC  D INCEC^RORUPDUT(.RC)  Q
 ;
 D CLRDES^RORUPDUT(RORFILE)
 Q RC
 ;
 ;***** IMPLEMENTATION OF THE 'PTF' Diagnosis RULE
PTFRULE(ICD) ;
 N DATELMT,RC
 S RC=0
 F DATELMT=111,101:1:110,131:1:147  D  Q:RC
 . S RC=+$D(^ROR(798.5,REGIEN,1,"B",+$G(RORVALS("DV",45,DATELMT,"I"))))
 Q RC
 ;
 ;***** IMPLEMENTATION OF THE 'PTF' Procedure RULE for ICD and CPT
PTFRULE1(REGIEN) ;
 N ROR
 S RC=0
 I $D(^ROR(798.5,REGIEN,2,"B")) D  Q:RC  ;ICD procedure codes
 . S ROR=0 F  S ROR=$O(RORVALS("PPTF","I",ROR)) Q:'ROR  I +$D(^ROR(798.5,REGIEN,2,"B",+$G(RORVALS("PPTF","I",ROR,"I")))) S RC=1 Q
 I 'RC,$D(^ROR(798.5,REGIEN,3,"B")) D  ;CPT procedure codes
 . S ROR=0 F  S ROR=$O(RORVALS("PPTF","C",ROR)) Q:'ROR  I +$D(^ROR(798.5,REGIEN,3,"B",+$G(RORVALS("PPTF","C",ROR,"I")))) S RC=1 Q
 Q RC
 ;
ALLPAT(REGIEN) ;Is Admission Date (#2) value less than 2 years old
 N RC,ROR2YRS
 S RC=0,ROR2YRS=DT-20000
 I $D(RORVALS("DV",45,154,"I")) D
 . I RORVALS("DV",45,154,"I")>ROR2YRS S RC=1
 Q RC
 ;
