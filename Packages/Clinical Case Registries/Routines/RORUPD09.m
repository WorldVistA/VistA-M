RORUPD09 ;HCIOFO/SG - PROCESSING OF THE 'PTF' FILE  ; 8/3/05 9:50am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #3157         RPC^DGPTFAPI
 ; #3545         Access to the "AAD" cross-reference and the field 80
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
 ;--- API #1
 I $D(RORUPD("SR",RORFILE,"F",1))  D  Q:RC<0 RC
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
 ;***** IMPLEMENTATION OF THE 'VA HEPC PTF' RULE
PTFRULE(ICD) ;
 N DATELMT,RC
 S RC=0
 F DATELMT=111,101,102,103,104,105,106,107,108,109,110  D  Q:RC
 . S RC=ICD[(","_$G(RORVALS("DV",45,DATELMT,"E"))_",")
 Q RC
