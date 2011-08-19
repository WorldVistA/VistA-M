RORUPD07 ;HCIOFO/SG - PROCESSING OF THE 'PROBLEM' FILE  ; 8/3/05 9:46am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #928          ACTIVE^GMPLUTL
 ; #2977         GETFLDS^GMPLEDT3
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
 . N DE,GMPFLD,GMPORIG,GMPROV,GMVAMC,IN,IP,VT
 . S (GMPVAMC,GMPROV)=0
 . D GETFLDS^GMPLEDT3(+IENS)
 . ;---
 . S DE=""
 . F  S DE=$O(RORUPD("SR",RORFILE,"F",2,DE))  Q:DE=""  D
 . . S VT=""
 . . F  S VT=$O(RORUPD("SR",RORFILE,"F",2,DE,VT))  Q:VT=""  D
 . . . S IP=+$P(RORUPD("SR",RORFILE,"F",2,DE,VT),U,1)  Q:IP'>0
 . . . S IN=+$P(RORUPD("SR",RORFILE,"F",2,DE,VT),U,2)
 . . . S RORVALS("DV",RORFILE,DE,VT)=$P($G(GMPFLD(IN)),U,IP)
 Q 0
 ;
 ;***** PROCESSING OF THE 'PROBLEM' FILE
 ;
 ; UPDSTART      Date of the earliest update
 ; PATIEN        Patient IEN
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Continue processing of the current patient
 ;        1  Stop processing
 ;
PROBLEM(UPDSTART,PATIEN) ;
 N RORFILE       ; File number
 N RORPLST       ; List of patient problems
 ;
 N DATE,IS,LOCATION,PROBIENS,RC,TMP
 S RORFILE=9000011
 ;--- Check if the problem list has been modified in
 ;    the data scan period of the patient.
 Q:$$MOD^GMPLUTL3(PATIEN)<UPDSTART 0
 ;--- Load a list of active problems
 D ACTIVE^GMPLUTL(PATIEN,.RORPLST)
 ;
 ;--- Browse through the problems
 S (IS,RC)=0
 F  S IS=$O(RORPLST(IS))  Q:IS=""  D  Q:RC
 . S PROBIENS=+RORPLST(IS,0)_","
 . ;--- Load necessary data elements
 . I $D(RORUPD("SR",RORFILE,"F"))>1  D  I TMP<0 D INCEC^RORUPDUT() Q
 . . S TMP=$$LOAD(PROBIENS)  Q:TMP<0
 . . S TMP=$$GETDE^RORUPDUT(RORFILE,130)
 . . S LOCATION=$S(TMP>0:$$IEN4^RORUTL18(TMP),1:"")
 . ;--- Ignore problems entered not in the data scan period
 . S DATE=$$GETDE^RORUPDUT(RORFILE,118)
 . Q:(DATE<UPDSTART)!(DATE'<RORUPD("DSEND"))
 . ;--- Apply "before" rules
 . S RC=$$APLRULES^RORUPDUT(RORFILE,PROBIENS,"B",DATE,$G(LOCATION))
 . I RC  D INCEC^RORUPDUT(.RC)  Q
 . ;--- Apply "after" rules
 . S RC=$$APLRULES^RORUPDUT(RORFILE,PROBIENS,"A",DATE,$G(LOCATION))
 . I RC  D INCEC^RORUPDUT(.RC)  Q
 ;
 D CLRDES^RORUPDUT(RORFILE)
 Q RC
