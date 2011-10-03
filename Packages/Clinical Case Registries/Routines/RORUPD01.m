RORUPD01 ;HCIOFO/SG - PROCESSING OF THE FILES ;7/21/03 10:19am
 ;;1.5;CLINICAL CASE REGISTRIES;**14**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IA's:
 ;
 ; #3646         $$EMPL^DGSEC4
 ; #10035        Browse through IENs of the file #2
 Q
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*14   APR  2011   A SAUNDERS   Tags HCVLOAD and HCVLIST added for auto-
 ;                                      confirm functionality.  PROCESS: call
 ;                                      to tag HCVLOAD is added.
 ;******************************************************************************
 ;******************************************************************************
 ;
 ;
 ;***** CHECKS FOR A STOP REQUESTS (TASKMAN & PROPRIETARY)
 ;
 ; Return Values:
 ;        0  Continue running
 ;        1  Stop the subtask
 ;
CHKSTOP() ;
 Q:'$G(RORUPD("JOB")) $$S^%ZTLOAD
 L +@RORUPDPI@("T",0):0
 I  L -@RORUPDPI@("T",0)  Q 1
 Q $$S^%ZTLOAD
 ;
 ;***** LOAD DATA ELEMENTS
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
 I $D(RORUPD("SR",2,"F",1))  D  Q:RC<0 RC
 . S RC=$$LOADFLDS^RORUPDUT(2,IENS)
 ;--- API #2
 Q 0
 ;
 ;***** INITIALIZES LOOP CONTROL LISTS
 ;
 ; PATIEN        Patient IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
 ; The RORUPD("LM",1,Rule Name) list contains names of the top level
 ; rules that have not been triggered by now.
 ;
 ; The RORUPD("LM",2,Registry#) list contains IENs of the registries
 ; that do not contain the patient by now.
 ;
 ; If the patient is an employee and the registry must not include
 ; employees (see the EXCLUDE EMPLOYEES field of the ROR REGISTRY
 ; PARAMETERS file), the function initializes the corresponding items
 ; of control lists as if the patient were already in the registry.
 ; Therefore, the patient will not be added to this registry.
 ;
LOOPINIT(PATIEN) ;
 N I,EMPL,REGIEN
 K RORUPD("LM",1),RORUPD("LM",2)
 S EMPL=$$EMPL^DGSEC4(PATIEN,"P")
 M RORUPD("LM",1)=RORUPD("LM1")
 S REGIEN=""
 F  S REGIEN=$O(RORUPD("LM2",REGIEN))  Q:REGIEN=""  D
 . S $P(RORUPD("LM2",REGIEN),U)=0
 . ;--- Check if the patient is already in the registry
 . Q:$D(^RORDATA(798,"KEY",PATIEN,REGIEN))
 . ;--- Check if the patient is an employee and the
 . ;--- employees must not be added to the registry
 . I EMPL  Q:$P(RORUPD("LM2",REGIEN),U,2)
 . ;--- Initialize the items of control lists
 . S $P(RORUPD("LM2",REGIEN),U)=1,RORUPD("LM",2,REGIEN)=""
 Q 0
 ;
 ;***** PROCESS EVERY PATIENT IN THE 'PATIENT' FILE
 ;
 ; BEGIEN        Start IEN in the PATIENT file
 ; ENDIEN        End IEN in the PATIENT file
 ;
 ; Return Values:
 ;       <0  Error code
 ;      >=0  Statistics
 ;             ^1: Total number of processed patients
 ;             ^2: Number of patients processed with errors
 ;
 ; If there is an error in processing of a patient, routine behavior
 ; depends on the mode of execution:
 ;
 ; In the normal mode program logs the errors, adds a record to the
 ; ROR PATIENT EVENTS file (#798.3), and continues processing of
 ; the remaining patients. Next registry update wil start data scan
 ; for this patient from the date stored in the file #798.3.
 ;
 ; In the debug mode 3 program is aborted if there is an error
 ; during processing of a patient.
 ;
PROCESS(BEGIEN,ENDIEN) ;
 ;Patch 14 adds functionality to automatically confirm patients with
 ;certain HCV LOINCs.  A list of the LOINCs are loaded into an array
 ;for future comparison
 D HCVLOAD ;Load list of HCV LOINCs into an array for use in HCV^RORUPD04
 N CNT,DTNEXT,ECNT,EXIT,PATIEN,RC,TH,TMP
 ;--- Loop through the patients
 S:$G(ENDIEN)'>0 ENDIEN=0
 S PATIEN=$S($G(BEGIEN)>0:$O(^DPT(BEGIEN),-1),1:0)
 S (CNT,ECNT,EXIT,RC)=0
 F  S PATIEN=$O(^DPT(PATIEN))  Q:PATIEN'>0  D  Q:EXIT!(RC<0)
 . I ENDIEN,PATIEN'<ENDIEN  S EXIT=1  Q
 . ;--- For a queued task only
 . I $D(ZTQUEUED)  S RC=0  D  Q:RC<0
 . . ;--- Check if task stop has been requested
 . . I $$CHKSTOP()  S RC=$$ERROR^RORERR(-42)  Q
 . . ;--- Check if the task should be suspended
 . . Q:'$G(RORUPD("SUSPEND"))
 . . Q:$$NOW^XLFDT<$G(DTNEXT)
 . . Q:'$$SUSPEND(.DTNEXT)
 . . ;--- Suspend the task during the peak hours
 . . F  D  Q:'TH!(RC<0)
 . . . S TH=$$FMDIFF^XLFDT(DTNEXT,$$NOW^XLFDT,2)
 . . . I TH<60  S TH=0  Q       ; Do not HANG for less than a
 . . . H $S(TH>3600:3600,1:TH)  ; minute and more than an hour
 . . . ;--- Check if task stop has been requested
 . . . S:$$CHKSTOP() RC=$$ERROR^RORERR(-42)
 . ;--- Update the progress indicator
 . S CNT=CNT+1
 . I $G(RORPARM("DEBUG"))>1  W:$E($G(IOST),1,2)="C-" *13,CNT
 . ;--- Process the patient
 . S RC=$$PROCPAT(PATIEN)
 . I $G(RORPARM("SETUP"))  D:'(CNT#1000)
 . . D LOG^RORLOG(2,"Number of patients processed by now: "_CNT)
 . ;--- Process the error (if any)
 . I RC<0  D  S:$G(RORPARM("DEBUG"))<3 RC=0
 . . I RC=-66  S RC=0  Q        ; Counter in the file #798.3
 . . S ECNT=ECNT+1
 . . S RC=$$ERROR^RORERR(-15,,,PATIEN)
 . . ;--- Create a record in the file #798.3
 . . S TMP=$$ADD^RORUPP01(PATIEN,RORUPD("DSBEG"))
 . . S:TMP<0 RC=TMP
 K ^TMP("ROR HCV LIST"),^TMP("ROR HCV CONFIRM")
 Q $S(RC<0:RC,1:CNT_"^"_ECNT)
 ;
 ;***** PROCESSES PATIENT'S DATA (EXCEPT DEMOGRAPHIC DATA)
 ;
 ; PATIEN        Patient IEN
 ; [NOUPD]       Disable registry update (0 by default)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
 ; If there is a record for the patient in the ROR PATIENT EVENTS
 ; file (#798.3) and date in that record is less than a value of the
 ; RORUPD("DSBEG") then it is used as a start date of the data scan
 ; for the patient. Otherwise, the RORUPD("DSBEG") is used.
 ;
PROCPAT(PATIEN,NOUPD) ;
 ;--- Quit if the patient has already been processed
 Q:$D(@RORUPDPI@("U",PATIEN)) 0
 ;--- Quit if the patient's record has been merged
 Q:$G(^DPT(PATIEN,-9)) 0
 ;--- Do not update the registries with a "test patient"
 I '$G(NOUPD),$$TESTPAT^RORUTL01(PATIEN) D  Q 0
 . S @RORUPDPI@("U",PATIEN)=""
 ;
 N RORERRDL      ; Default error location
 ;
 N PATIENS,RC,RLST,RORMSG,SDSDT,TMP,UPDREG,UPDSTART
 S PATIENS=PATIEN_","
 ;--- Initialize the variables
 D CLEAR^RORERR("PROCPAT^RORUPD01"),CLREC^RORUPDUT
 K RORVALS ; Clear all calculated values
 S RC=$$LOOPINIT(PATIEN)  Q:RC<0 RC
 ;
 ;--- If the loop control list of registries is empty, the patient
 ;    is already in all the registries that we are going to process.
 S UPDREG=0
 I $D(RORUPD("LM",2))>1  S RC=0  D  G:RC<0 PPEX  S UPDREG='$G(NOUPD)
 . ;--- Determine start date of the data scan
 . S UPDSTART=RORUPD("DSBEG")
 . S SDSDT=$$SDSDATE^RORUPP01(PATIEN)
 . I SDSDT<0  S RC=SDSDT  Q
 . I SDSDT  S:SDSDT<UPDSTART UPDSTART=SDSDT
 . S UPDSTART=$$FMADD^XLFDT(UPDSTART\1,-RORUPD("LD",1))
 . ;--- Load necessary data elements
 . I $D(RORUPD("SR",2,"F"))>1  D  Q:RC<0
 . . S RC=$$LOAD(PATIENS)
 . D SETVAL^RORUPDUT("ROR DFN",PATIEN)
 . ;--- Apply "before" rules
 . S RC=$$APLRULES^RORUPDUT(2,PATIENS,"B")  Q:RC
 . ;
 . ;--- Process patient data from other VistA files
 . I $D(RORUPD("SR",9000010))  D  Q:RC
 . . S RC=$$VISIT^RORUPD08(UPDSTART,PATIEN)
 . I $D(RORUPD("SR",9000011))  D  Q:RC
 . . S RC=$$PROBLEM^RORUPD07(UPDSTART,PATIEN)
 . I $D(RORUPD("SR",45))  D       Q:RC
 . . S RC=$$PTF^RORUPD09(UPDSTART,PATIEN)
 . I $D(RORUPD("SR",63))  D       Q:RC
 . . S RC=$$LAB^RORUPD04(UPDSTART,PATIEN)
 . ; <--- Insert processing of other files here. Do not forget to add
 . ;      definitions of these files into the 'ROR METADATA' file.
 . ;
 . ;--- Apply "after" rules
 . S RC=$$APLRULES^RORUPDUT(2,PATIENS,"A")  Q:RC
 ;
 ;--- Update the registries if necessary
 I UPDREG  S RC=$$UPDREG^RORUPD50(PATIEN)  G:RC<0 PPEX
 ;--- Error processing
 I $$GETEC^RORUPDUT  D  S RC=-15
 . S RLST=$NA(@RORUPDPI@("U",PATIEN,2))
 E  S RLST="",RC=0
 ;--- If there are records in the file #798.3 for the patient,
 ;    remove them (log a warning if cannot remove). If the patient
 ;    has been processed with errors, remove only records associated
 ;--- with the registries that the patient has been added to.
 D:$G(SDSDT)
 . S TMP=$$REMOVE^RORUPP01(PATIEN,RLST)
 . S:TMP<0 TMP=$$ERROR^RORERR(-31,,,PATIEN)
 ;--- Mark the patient as processed
 S @RORUPDPI@("U",PATIEN)=""
PPEX ;--- Cleanup
 D CLRDES^RORUPDUT(2)
 Q RC
 ;
 ;***** CHECKS IF THE TASK SHOULD BE SUSPENDED
 ;
 ; .DTNEXT       Date/Time of the next event (suspend/resume)
 ;               is returned via this parameter
 ;
 ; Return Values:
 ;        0  Continue/Resume
 ;        1  Suspend
 ;
SUSPEND(DTNEXT) ;
 N DATE,NOW,SUSPEND,TIME,TS,TR
 S TS=$P(RORUPD("SUSPEND"),U,1)
 S TR=$P(RORUPD("SUSPEND"),U,2)
 S NOW=$$NOW^XLFDT,DATE=NOW\1
 ;--- A working day
 I $$WDCHK^RORUTL01(DATE)  D  Q SUSPEND
 . S TIME=NOW-DATE,SUSPEND=0
 . I TIME<TS   S DTNEXT=DATE+TS  Q
 . I TIME'<TR  S DTNEXT=$$WDNEXT^RORUTL01(DATE)+TS  Q
 . S DTNEXT=DATE+TR,SUSPEND=1
 ;--- Saturday, Sunday or Holiday
 S DTNEXT=$$WDNEXT^RORUTL01(DATE)+TS
 Q 0
 ;
 ;***** UPDATES REGISTRY UPDATE PARAMETERS
 ;
 ; .REGLST       Reference to a local array containing registry names
 ;               as subscripts and optional registry IENs as values
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
TMSTMP(REGLST) ;
 N DATE,RC,REGIEN,REGIENS,REGNAME,RORFDA,RORMSG,TMP
 S REGNAME="",RC=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:RC<0
 . S REGIEN=+$G(REGLST(REGNAME))
 . I REGIEN'>0  D  I REGIEN'>0  S RC=+REGIEN  Q
 . . S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . S REGIENS=REGIEN_","
 . ;--- Check if the new date until that registry is updated is
 . ;    greater than that stored in the registry parameters
 . S TMP=$$GET1^DIQ(798.1,REGIENS,1,"I",,"RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,798.1,REGIENS)
 . S DATE=RORUPD("DSEND")\1
 . S:DATE>TMP RORFDA(798.1,REGIENS,1)=DATE
 . ;--- Update registry parameters (if necessary)
 . Q:$D(RORFDA)<10
 . D FILE^DIE("K","RORFDA","RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,798.1,REGIENS)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** LOAD LIST OF HCV LOINCS INTO AN ARRAY FOR USE IN ADD^RORUPD50
 ;
HCVLOAD ;
 K ^TMP("ROR HCV LIST") ;initialize HCV arrays
 N I,RORDONE,RORLOINC
 S RORDONE=0
 F I=1:1 S RORLOINC=$P($T(HCVLIST+I),";;",2) Q:RORDONE  D
 . I (($G(RORLOINC)="END OF LIST")!($G(RORLOINC)="")) S RORDONE=1 Q
 . S ^TMP("ROR HCV LIST",$J,RORLOINC)="" ;add LOINC to array
 ;
 Q
 ;LIST OF HCV LOINCS
 ;Patients with a positive value in any of these HCV LOINCs will be confirmed into
 ;the registry during the nightly update.  If a LOINC needs to be added to the
 ;list, add it above the 'end of list' entry.
HCVLIST ;
 ;;11011-4
 ;;29609-5
 ;;34703-9
 ;;34704-7
 ;;10676-5
 ;;20416-4
 ;;20571-6
 ;;49758-6
 ;;50023-1
 ;;END OF LIST
