RORUPD08 ;HCIOFO/SG - PROCESSING OF 'VISIT' & 'V POV' FILES  ; 10/27/05 11:08am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #1554         POV^PXAPIIB
 ; #1905         SELECTED^VSIT
 ; #1906         LOOKUP^VSIT
 ; #3990         $$CODEC^ICDCODE (supported)
 ;
 Q
 ;
 ;***** LOADS 'V POV' DATA ELEMENTS
 ;
 ; IENS          IENS of the current record
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOADVPOV(IENS) ;
 N RC  S RC=0
 ;--- API #1
 I $D(RORUPD("SR",RORFILE,"F",1))  D  Q:RC<0 RC
 . S RC=$$LOADFLDS^RORUPDUT(RORFILE,IENS)
 ;--- API #2
 I $D(RORUPD("SR",RORFILE,"F",2))  D  Q:RC<0 RC
 . N BUF,DE,IP,RORMSG,TMP,VT
 . S BUF=$G(RORVPLST(+IENS)),DE=""
 . F  S DE=$O(RORUPD("SR",RORFILE,"F",2,DE))  Q:DE=""  D
 . . S VT=""
 . . F  S VT=$O(RORUPD("SR",RORFILE,"F",2,DE,VT))  Q:VT=""  D
 . . . S IP=+$P(RORUPD("SR",RORFILE,"F",2,DE,VT),U)
 . . . S:IP>0 RORVALS("DV",RORFILE,DE,VT)=$P(BUF,U,IP)
 . ;--- External value of the POV field (.01)
 . I $D(RORUPD("SR",RORFILE,"F",2,112,"E"))  D  Q:RC<0
 . . S TMP=+$P(BUF,U)  Q:TMP'>0
 . . S TMP=$$CODEC^ICDCODE(TMP)
 . . S RORVALS("DV",RORFILE,112,"E")=$S(TMP'<0:TMP,1:"")
 Q 0
 ;
 ;***** LOAD 'VISIT' DATA ELEMENTS
 ;
 ; IENS          IENS of the current record
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOADVSIT(IENS) ;
 N RC  S RC=0
 ;--- API #1
 I $D(RORUPD("SR",RORFILE,"F",1))  D  Q:RC<0 RC
 . S RC=$$LOADFLDS^RORUPDUT(RORFILE,IENS)
 ;--- API #2
 I $D(RORUPD("SR",RORFILE,"F",2))  D  Q:RC<0 RC
 . N API,DE,IN,IP,TMP,VSIT,VT
 . S TMP=$$LOOKUP^VSIT(+IENS,"B",0)
 . I TMP<0  S API="$$LOOKUP^VSIT"  D  Q
 . . S RC=$$ERROR^RORERR(-57,,,,TMP,API)
 . ;---
 . S DE=""
 . F  S DE=$O(RORUPD("SR",RORFILE,"F",2,DE))  Q:DE=""  D
 . . S VT=""
 . . F  S VT=$O(RORUPD("SR",RORFILE,"F",2,DE,VT))  Q:VT=""  D
 . . . S IP=+$P(RORUPD("SR",RORFILE,"F",2,DE,VT),U)  Q:IP'>0
 . . . S IN=$P(RORUPD("SR",RORFILE,"F",2,DE,VT),U,2)
 . . . S RORVALS("DV",RORFILE,DE,VT)=$P($G(VSIT(IN)),U,IP)
 . ;---
 Q 0
 ;
 ;***** PROCESSING OF THE 'VISIT' FILE
 ;
 ; UPDSTART      Date of the earliest update
 ; PATIEN        Patient IEN
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Continue processing of the current patient
 ;        1  Stop processing
 ;
 ; The function uses the ^TMP("VSIT",$J) global node.
 ;
VISIT(UPDSTART,PATIEN) ;
 N RORFILE       ; File number
 ;
 N DATE,DSEND,IEN,LOCATION,RC,TMP,VISIENS
 S RORFILE=9000010,DSEND=RORUPD("DSEND")
 ;--- Check the event references if the events are enabled
 I $G(RORUPD("FLAGS"))["E"  D  Q:RC'>0 RC
 . S RC=$$GET^RORUPP02(PATIEN,2,.UPDSTART,.DSEND)
 . S:RC>1 UPDSTART=UPDSTART\1,DSEND=$$FMADD^XLFDT(DSEND\1,1)
 ;--- Get a list of visits
 D SELECTED^VSIT(PATIEN,UPDSTART,DSEND)
 ;
 ;--- Browse through the visits
 S (IEN,RC)=0
 F  S IEN=$O(^TMP("VSIT",$J,IEN))  Q:IEN=""  D  Q:RC
 . S VISIENS=IEN_",",TMP=+$O(^TMP("VSIT",$J,IEN,""))
 . S DATE=$P($G(^TMP("VSIT",$J,IEN,TMP)),U)
 . ;--- Load necessary data elements
 . I $D(RORUPD("SR",RORFILE,"F"))>1  D  I TMP<0 D INCEC^RORUPDUT() Q
 . . S TMP=$$LOADVSIT(VISIENS)  Q:TMP<0
 . . S LOCATION=$$GETDE^RORUPDUT(RORFILE,129)
 . ;--- Apply "before" rules
 . S RC=$$APLRULES^RORUPDUT(RORFILE,VISIENS,"B",DATE,$G(LOCATION))
 . I RC  D INCEC^RORUPDUT(.RC)  Q
 . ;
 . ;--- Process V POV file
 . I $D(RORUPD("SR",9000010.07))  D  I RC  D INCEC^RORUPDUT(.RC)  Q
 . . S RC=$$VPOV(IEN,DATE,$G(LOCATION))
 . ;
 . ;--- Apply "after" rules
 . S RC=$$APLRULES^RORUPDUT(RORFILE,VISIENS,"A",DATE,$G(LOCATION))
 . I RC  D INCEC^RORUPDUT(.RC)  Q
 ;
 K ^TMP("VSIT",$J)
 D CLRDES^RORUPDUT(RORFILE)
 Q RC
 ;
 ;***** PROCESSING OF THE 'V POV' FILE
 ;
 ; VISITIEN      IEN of the visit (in the "VISIT" file)
 ; DATE          Visit date
 ; LOCATION      Institution IEN
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Continue processing of the current patient
 ;        1  Stop processing
 ;
VPOV(VISITIEN,DATE,LOCATION) ;
 N RORFILE       ; File number
 N RORVPLST      ; List of records in the file
 ;
 N IEN,NODE,RC,TMP,VPIENS
 S RORFILE=9000010.07
 D CLRVALS^RORUPDUT(RORFILE)
 ;--- Get a list of records
 D POV^PXAPIIB(VISITIEN,.RORVPLST)
 ;
 S (IEN,RC)=0
 F  S IEN=$O(RORVPLST(IEN))  Q:IEN=""  D  Q:RC
 . S VPIENS=IEN_","
 . ;--- Load necessary data elements
 . I $D(RORUPD("SR",RORFILE,"F"))>1  D  I TMP<0 D INCEC^RORUPDUT() Q
 . . S TMP=$$LOADVPOV(VPIENS)
 . ;--- Apply "before" rules
 . S RC=$$APLRULES^RORUPDUT(RORFILE,VPIENS,"B",DATE,LOCATION)
 . I RC  D INCEC^RORUPDUT(.RC)  Q
 . ;--- Apply "after" rules
 . S RC=$$APLRULES^RORUPDUT(RORFILE,VPIENS,"A",DATE,LOCATION)
 . I RC  D INCEC^RORUPDUT(.RC)  Q
 ;
 D CLRDES^RORUPDUT(RORFILE)
 Q RC
