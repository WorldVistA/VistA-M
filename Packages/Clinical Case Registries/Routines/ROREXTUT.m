ROREXTUT ;HCIOFO/SG - DATA EXTRACT UTILITIES  ; 11/25/05 3:57pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** PRINT SOME DEBUG INFORMATION
DEBUG ;
 D ZW^RORUTL01("ROREXT","Control Data")
 D ZW^RORUTL01("RORLRC","Lab Results to extract")
 W !,"Job number: ",$J,!
 Q
 ;
 ;***** ADDS THE TIME FRAME TO THE LIST
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; STDT          Start date (FileMan)
 ; ENDT          End Date   (FileMan)
 ;
 ; DTAR          Data area code (see the ROR DATA AREA file #799.33)
 ;
 ; [MAIN]        If this parameter defined and not zero, the time
 ;               frame is considered the main one.
 ;
 ; Variants of positional relationship of the existing time frames
 ; and the one that is being added to the list (STDT-ENDT):
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
DXADD(DXDTS,STDT,ENDT,DTAR,MAIN) ;
 Q:STDT>ENDT
 N DATE,EXIT,TMP
 ;--- Update the main time frame
 I $G(MAIN)  D  S DTAR=0
 . S TMP=+$P(DXDTS,U)
 . S:(TMP'>0)!(STDT<TMP) $P(DXDTS,U,1)=STDT
 . S:ENDT>$P(DXDTS,U,2) $P(DXDTS,U,2)=ENDT
 ;--- Merge the time frames if possible
 S DATE=$O(DXDTS(DTAR,ENDT)),EXIT=0
 F  S DATE=$O(DXDTS(DTAR,DATE),-1)  Q:DATE=""  D  Q:EXIT
 . S TMP=$P(DXDTS(DTAR,DATE),U,2)
 . I TMP<STDT  S EXIT=1  Q          ; (1)
 . S:TMP>ENDT ENDT=TMP              ; (2)
 . S TMP=$P(DXDTS(DTAR,DATE),U)
 . S:TMP<STDT STDT=TMP              ; (3)
 . K DXDTS(DTAR,DATE)
 ;--- Store the new time frame
 S DXDTS(DTAR,STDT)=STDT_U_ENDT
 Q
 ;
 ;***** CALCULATES THE MAIN DATA EXTRACTION TIME FRAME
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; IEN           IEN of the patient's record in the registry
 ;
 ; Return Values:
 ;        <0  Error Code
 ;         0  Ok
 ;        >0  Skip the patient
 ;
 ; If the special extraction start date for all patients is defined
 ; then it is as the start date of the main time frame. Usually,
 ; this mode is not used. ;-)
 ;
 ; If the field #9.1 of the patient record in the registry (#798)
 ; has a value then this value is used as the start date of the
 ; main time frame (data have already been extracted until that
 ; date). This field is empty for new patients.
 ;
 ; The function tries to get the earliest date when a selection rule
 ; has been triggered for the newly added patient. If the patient has
 ; been added manually and there are no selection rules in the
 ; SELECTION RULE multiple of the registry record then a date when
 ; the patient was added to the registry is used.
 ;
 ; After that, extract period for new patients (value of the field
 ; #7 of the file #798.1) is subtracted from the date and the result
 ; is used as the start date. If the extract period is not set for
 ; the registry then a default value (365) is used.
 ;
DXMAIN(DXDTS,IEN) ;
 N ENDT,IENS,LCH,RC,RORBUF,RORMSG,STDT,TMP
 S (ENDT,STDT)="",IENS=IEN_",",LCH=0
 ;--- Get the registry record data
 D GETS^DIQ(798,IENS,"1;3;3.2;4;5;9.1","I","RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798,IENS)
 S ENDT=$$FMADD^XLFDT(ROREXT("DXEND"),-$G(ROREXT("LD",1)))
 F TMP=4,5  S:$G(RORBUF(798,IENS,TMP,"I")) LCH=1
 ;--- Empty time frame for patients who are marked for deletion
 I $G(RORBUF(798,IENS,3,"I"))=5  D  Q 0
 . D DXADD(.DXDTS,ENDT,ENDT,0,1)
 ;--- Special start date for ALL patients (if defined)
 S STDT=$G(ROREXT("DXBEG"))
 I STDT'>0  D
 . ;--- Start date from the patient's registry record
 . ;--- (value of the DATA ACKNOWLEDGED UNTIL field)
 . S STDT=$G(RORBUF(798,IENS,9.1,"I"))\1  Q:STDT>0
 . ;--- If value of the DATA ACKNOWLEDGED UNTIL field is missing or
 . ;    not greater than 0, then the patient is considered new and
 . ;    the start date is calculated as date of earliest selection
 . ;    rule minus maximum value of the EXTRACT PERIOD FOR NEW
 . ;--- PATIENT field for all processed registries.
 . S STDT=$G(RORBUF(798,IENS,3.2,"I"))  Q:STDT'>0
 . S TMP=+$G(ROREXT("EXTRDAYS"))
 . S STDT=$$FMADD^XLFDT(STDT,-$S(TMP>0:TMP,1:365))\1
 ;--- Check the dates and add the time frame to the list
 I (STDT'>0)!(ENDT'>0)  D  Q RC
 . S TMP=$$GET1^DIQ(798,IENS,.01,"I",,"RORMSG")
 . S RC=$$ERROR^RORERR(-32,,,TMP,STDT,ENDT)
 S RC=0
 I STDT'<ENDT  S RC=1  S:LCH STDT=ENDT,RC=0
 D:'RC DXADD(.DXDTS,STDT,ENDT,0,1)
 Q RC
 ;
 ;***** MERGES SPECIAL TIME FRAMES INTO THE 'DATA-SPECIFIC' LISTS
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
DXMERGE(DXDTS) ;
 N DTAR,TMP
 S DTAR=0
 F  S DTAR=$O(ROREXT("DTAR",DTAR))  Q:DTAR'>0  D
 . ;--- Main time frame
 . D DXADD(.DXDTS,$P(DXDTS,U),$P(DXDTS,U,2),DTAR)
 . ;--- Data-specific time frame
 . S TMP=$G(ROREXT("DTAR",DTAR))
 . D:TMP>0 DXADD(.DXDTS,$P(TMP,U),$P(TMP,U,2),DTAR)
 Q
 ;
 ;***** ADDS DATA EXTRACTION PERIODS FOR THE PATIENT TO THE LIST
 ;
 ; .DXDTS        Reference to a local variable that the data
 ;               extraction time frames are added to. The
 ;               main time frame is returned in the root node:
 ;
 ;  DXDTS(         MainStartDate^MainEndDate  (FileMan)
 ;    DataArea,
 ;      i)         StartDate^EndDate          (FileMan)
 ;
 ; IEN           IEN of the patient record in the registry
 ;
 ; PATIEN        Patient IEN
 ;
 ; Return Values:
 ;        <0  Error Code
 ;         0  Ok
 ;        >0  Skip the patient
 ;
DXPERIOD(DXDTS,IEN,PATIEN) ;
 N AREA,ENDT,EVTDT,EVTIEN,NODE,RC,STDT,TMP
 S DXDTS=$G(DXDTS)
 ;
 ;=== Main data extraction time frame
 S RC=$$DXMAIN(.DXDTS,IEN)  Q:RC RC
 ;
 ;=== Data-specific protocols (only Inpatient at present)
 ; The Inpatient protocol is not used anymore because now the
 ; data search is performed on the PTF CLOSE OUT file instead
 ; of the PTF file (after patch ROR*1*8).
 ;S NODE=$NA(^RORDATA(798.3,+PATIEN,2))
 ;F AREA=3  D
 ;. ;--- Browse the events in the main time frame
 ;. S EVTDT=$O(@NODE@("AT",AREA,+DXDTS),-1)
 ;. S ENDT=+$P(DXDTS,U,2)
 ;. F  S EVTDT=$O(@NODE@("AT",AREA,EVTDT))  Q:'EVTDT!(EVTDT'<ENDT)  D
 ;. . S EVTIEN=""
 ;. . F  S EVTIEN=$O(@NODE@("AT",AREA,EVTDT,EVTIEN))  Q:EVTIEN=""  D
 ;. . . S TMP=$P($G(@NODE@(EVTIEN,0)),U,3)\1
 ;. . . D:TMP>0 DXADD(.DXDTS,TMP,$$FMADD^XLFDT(TMP,1),AREA)
 ;
 ;=== Data-specific 'sliding windows'
 D:$G(ROREXT("HDTIEN"))'>0
 . S STDT=$$FMADD^XLFDT($P(DXDTS,U,1),-60)
 . S ENDT=$$FMADD^XLFDT($P(DXDTS,U,2),-60)
 . D DXADD(.DXDTS,STDT,ENDT,7)  ; Autopsy
 ;
 ;=== Merge the main time frame into the data-specific ones
 D DXMERGE(.DXDTS)
 Q 0
 ;
 ;***** UPDATES DATA EXTRACTION PARAMETERS OF THE REGISTRY
 ;
 ; .REGLST       Reference to a local array containing registry names
 ;               as subscripts and optional registry IENs as values
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
TMSTMP(REGLST) ;
 N DATE,RC,REGIEN,REGIENS,REGNAME,RORFDA,RORMSG
 S RC=0,DATE=ROREXT("DXEND")\1
 ;---
 S REGNAME=""
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:RC<0
 . ;--- Get the registry IEN
 . S REGIEN=+$G(REGLST(REGNAME))
 . I REGIEN'>0  D  I REGIEN'>0  S RC=+REGIEN  Q
 . . S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . S REGIENS=REGIEN_","
 . ;--- Do not update timestamp after historical data extractions
 . I $G(ROREXT("HDTIEN"))'>0  D  Q:RC<0
 . . ;--- Check if the new date until that data has been extracted
 . . ;    is greater than that stored in the registry parameters
 . . S TMP=$$GET1^DIQ(798.1,REGIENS,2,"I",,"RORMSG")
 . . I $G(DIERR)  D  Q
 . . . S RC=$$DBS^RORERR("RORMSG",-9,,,798.1,REGIENS)
 . . S:DATE>TMP RORFDA(798.1,REGIENS,2)=DATE
 . ;--- Increment the number of attempts
 . D:$G(ROREXT("NBM"))>0
 . . S TMP=$$GET1^DIQ(798.1,REGIENS,19.3,"I",,"RORMSG")
 . . S RORFDA(798.1,REGIENS,19.3)=TMP+1
 . ;--- Update registry parameters
 . Q:$D(RORFDA)<10
 . D FILE^DIE("K","RORFDA","RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,798.1,REGIENS)
 . ;--- Reset all report stats
 . D CLEAR^RORTSK12(REGIEN)
 ;---
 Q $S(RC<0:RC,1:0)
