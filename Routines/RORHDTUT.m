RORHDTUT ;HCIOFO/SG - HISTORICAL DATA EXTRACTION UTILITIES ; 1/23/06 8:16am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** RETURNS THE DATA EXTRACTION TIME FRAME(S)
 ;
 ; HDEIEN        Data Extract IEN
 ;
 ; .DXDTF        Reference to a local array where the time frame(s)
 ;               will be returned to.
 ;
 ;  DXTDF(       A single time frame if no specific parameters are
 ;               defined for the data area(s)
 ;                 ^01: Start Date
 ;                 ^02: End Date
 ;    DataArea)  Time frame for the data area:
 ;                 ^01: Start Date
 ;                 ^02: End Date
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
DXDTF(HDEIEN,DXDTF) ;
 N BUF,DAC,ENDT,IENS,RORBUF,RORMSG,STDT,TMP
 K DXDTF
 ;--- Load the time frame(s) from the data extract definition
 S IENS=(+HDEIEN)_","
 D GETS^DIQ(799.6,IENS,".03;.04;1*","I","RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.6,IENS)
 ;--- Get the main time frame (if defined)
 S STDT=$G(RORBUF(799.6,IENS,.03,"I"))\1  ; Start Date
 S ENDT=$G(RORBUF(799.6,IENS,.04,"I"))\1  ; End Date
 ;--- Check for data area time frames
 S IENS=""
 F  S IENS=$O(RORBUF(799.61,IENS))  Q:IENS=""  D
 . S DAC=+$G(RORBUF(799.61,IENS,.01,"I"))  Q:DAC'>0
 . S BUF=""
 . ;--- Start Date
 . S TMP=$G(RORBUF(799.61,IENS,.02,"I"))\1
 . I TMP'>0  S TMP=STDT  Q:TMP'>0
 . S $P(BUF,U,1)=TMP
 . ;--- End Date
 . S TMP=$G(RORBUF(799.61,IENS,.03,"I"))\1
 . I TMP'>0  S TMP=ENDT  Q:TMP'>0
 . S $P(BUF,U,2)=TMP
 . ;--- Store the time frame
 . S DXDTF(DAC)=BUF
 ;--- Otherwise, return the main time frame
 S:$D(DXDTF)<10 DXDTF=STDT_U_ENDT
 ;--- Success
 Q 0
 ;
 ;***** GENERATES A NEW UNUSED FILE NAME FOR THE TASK
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ; [.FILE]       New name is returned via this parameter
 ; [GNONLY]      Only generate a new name but do not store it into
 ;               task record
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
NEWFILE(HDEIEN,TASKIEN,FILE,GNONLY) ;
 N BASE,EXT,FN,IENS,NAME,OUTDIR,RC,RORBUF,RORLST,RORMSG,TMP
 S RC=$$TASKFILE(HDEIEN,TASKIEN,.OUTDIR,.FILE)  Q:RC<0 RC
 S BASE=$P($P(FILE,"."),"-",1,3),EXT=$P($P(FILE,".",2),";")
 ;--- Get a list of files in the output directory
 S RORBUF(BASE_"*."_EXT)=""
 Q:'$$LIST^%ZISH(OUTDIR,"RORBUF","RORLST") 0
 Q:$D(RORLST)<10 0
 K RORBUF
 ;--- Generate a new name
 S NAME="",FN=0
 F  S NAME=$O(RORLST(NAME))  Q:NAME=""  D
 . S TMP=+$P(NAME,"-",4)  S:TMP>FN FN=TMP
 S FILE=BASE,$P(FILE,"-",4)=$TR($J(FN+1,2)," ","0")
 S FILE=FILE_"."_EXT
 Q:$G(GNONLY) 0
 K RORLST
 ;--- Store it to the task record
 S IENS=(+TASKIEN)_","_(+HDEIEN)_","
 S RORBUF(799.64,IENS,.05)=FILE
 D FILE^DIE(,"RORBUF","RORMSG")
 Q $$DBS^RORERR("RORMSG",-9,,,799.64,IENS)
 ;
 ;***** PAUSES THE OUTPUT AT PAGE END
 ;
 ; Return values:
 ;       -2  Timeout
 ;       -1  User entered a '^'
 ;        0  Continue
 ;
PAGE() ;
 I $G(IOST)'["C-"  S $Y=0  Q:$QUIT 0  Q
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E"  D ^DIR  S $Y=0
 Q:$QUIT $S($D(DUOUT):-1,$D(DTOUT):-2,1:0)
 Q
 ;
 ;***** SELECTS/ADDS A HISTORICAL DATA EXTRACTION DEFINITION
 ;
 ; [FLAGS]       Flags that control the processing
 ;                 "A"  Allow addition of new entries
 ;
 ; [.NAME]       Data extract name is returned via this parameter
 ;
 ; [.NATIONAL]   This parameter is set to 1 if a national data
 ;               extraction is selected
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  "^" has been entered or timeout
 ;        0  Nothing has been selected
 ;       >0  IEN of the selected definition (file #799.6)
 ;
SELHDE(FLAGS,NAME,NATIONAL) ;
 N DA,DIC,DLAYGO,DTOUT,DUOUT,X,Y
 S NAME="",NATIONAL=0,FLAGS=$G(FLAGS)
 S DIC=799.6,DIC(0)="AENQZ"
 I FLAGS["A"  D  S DIC(0)=DIC(0)_"L",DLAYGO=DIC
 . S DIC("DR")="[RORHDT EDIT EXTRACTION]"
 S DIC("A")="Select a Data Extraction: "
 S DIC("S")="I $P($G(^(0)),U,2)=2"  ; Only "Manual" type
 W !  D ^DIC  Q:$D(DTOUT)!$D(DUOUT) ""
 I Y>0  S NAME=Y(0,0),NATIONAL=+$P(Y(0),U,9)  Q +Y
 Q 0
 ;
 ;***** SELECTS A DATA EXTRACTION TASK
 ;
 ; RORHDIEN      Data Extraction Definition IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  "^" has been entered or timeout
 ;        0  Nothing has been selected
 ;       >0  IEN of the selected task (multiple #4 of file #799.6)
 ;
SELTASK(RORHDIEN) ;
 N DA,DIR,DTOUT,DUOUT,IENS,RC,ROROOT,X,Y
 ;--- Display status of the data extraction
 S RC=$$STATUS^RORHDT01(RORHDIEN)  Q:RC<0 RC
 ;--- Select a task
 S ROROOT=$$ROOT^DILFD(799.64,","_RORHDIEN_",",1)
 S TMP=+$O(@ROROOT@(" "),-1)
 S DIR(0)="NO^1:"_TMP_":0^K:'$D(@ROROOT@(X,0)) X"
 S DIR("A")="Task ID"
 S DIR("?")="^I $$TASKLIST^RORHDTUT(RORHDIEN)"
 W !  D ^DIR
 Q $S($D(DTOUT)!$D(DUOUT):"",Y>0:+Y,1:0)
 ;
 ;***** GETS THE NAME OF THE TASK OUTPUT FILE
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ; .OUTDIR       Output directory is returned via this parameter
 ; .FILE         File name is returned via the parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
TASKFILE(HDEIEN,TASKIEN,OUTDIR,FILE) ;
 N IENS,RC,RORMSG
 S (OUTDIR,FILE)=""
 ;--- Get the output directory
 S IENS=(+HDEIEN)_","
 S OUTDIR=$$GET1^DIQ(799.6,IENS,2,,,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.6,IENS)
 ;--- Get the file name
 S IENS=(+TASKIEN)_","_(+HDEIEN)_","
 S FILE=$$GET1^DIQ(799.64,IENS,.05,,,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.6,IENS)
 ;--- Success
 Q 0
 ;
 ;***** DISPLAYS THE TASK LIST
 ;
 ; HDEIEN        Data Extract IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
TASKLIST(HDEIEN) ;
 N IENS,IT,RC,RORBUF,RORMNL,RORMSG,TASKIEN,TS
 ;--- Get the list of tasks
 S IENS=","_(+HDEIEN)_",",TMP="@;.01;.02;.05"
 D LIST^DIC(799.64,IENS,TMP,"Q",,,,"B",,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.64,IENS)
 I $G(RORBUF("DILIST",0))<1  D  Q 0
 . W !,?10,"No tasks have been defined"
 ;--- Get status of the tasks
 S IT=""
 F  S IT=$O(RORBUF("DILIST","ID",IT))  Q:IT=""  D
 . S TASKIEN=+RORBUF("DILIST",2,IT)
 . S TS=$$TASKSTAT(HDEIEN,TASKIEN)
 . S RORBUF("DILIST","ID",IT,.03)=$P(TS,U,2)
 ;--- Display the task table
 S RORMNL=$S($G(IOSL)>3:IOSL-3,1:20),$Y=0
 D TASKLP()  W !
 S IT="",RC=0
 F  S IT=$O(RORBUF("DILIST","ID",IT))  Q:IT=""  D  Q:RC
 . D TASKLP(IT)  S:$Y'<RORMNL RC=$$PAGE()
 ;--- Success
 Q 0
 ;
 ;***** DISPLAYS A LINE OF THE TASK TABLE
 ;
 ; RORBUF        Field values from the record of the file #798.5
 ;               returned by LIST^DIC
 ;
 ; IT            Index in the table
 ;
TASKLP(IT) ;
 ;;!?2^ID^$J($G(RORBUF("DILIST",2,IT)),2)
 ;;?6^File Name^$G(RORBUF("DILIST","ID",IT,.05))
 ;;?39^Task^$G(RORBUF("DILIST","ID",IT,.02))
 ;;?49^Status^$G(RORBUF("DILIST","ID",IT,.03))
 ;
 N I,TMP
 ;--- Display the headers
 I '$G(IT)  D  Q
 . F I=1:1  S TMP=$P($T(TASKLP+I),";;",2,999)  Q:TMP=""  D
 . . W @$TR($P(TMP,"^")," "),$P(TMP,"^",2)
 ;--- Display the values
 F I=1:1  S TMP=$P($T(TASKLP+I),";;",2,999)  Q:TMP=""  D
 . W @$TR($P(TMP,"^")," "),@$P(TMP,"^",3)
 Q
 ;
 ;***** RETURNS THE TASK NUMBER
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  No task defined
 ;       >0  Task Number
 ;
TASKNUM(HDEIEN,TASKIEN) ;
 N IENS,RORMSG,TASK
 S IENS=(+TASKIEN)_","_(+HDEIEN)_","
 S TASK=+$$GET1^DIQ(799.64,IENS,.02,"I",,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.64,IENS)
 Q TASK
 ;
 ;***** RETURNS STATUS OF THE TASK
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ; [LTO]         LOCK timeout
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Unknown Status
 ;       >0  Status (Code^Description)
 ;
 ;               1  Active: Pending
 ;               2  Active: Running
 ;               3  Inactive: Finished
 ;               4  Inactive: Available
 ;               5  Inactive: Interrupted
 ;
 ;             100  Inactive: Crashed
 ;             101  Inactive: Errors
 ;             102  Active: Suspended
 ;             103  Active: Stopping
 ;
TASKSTAT(HDEIEN,TASKIEN,LTO) ;
 N IENS,RORBUF,RORFDA,RORMSG,STATUS,TASK,TMP
 S IENS=(+TASKIEN)_","_(+HDEIEN)_","
 ;--- Get the task number and its last known status
 D GETS^DIQ(799.64,IENS,".02;.03","EI","RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.64,IENS)
 S TASK=$G(RORBUF(799.64,IENS,.02,"I"))
 Q:TASK="" 0
 ;--- Try to get status of the task
 S STATUS=$$STATUS^RORTSK02(TASK,$G(LTO))
 Q:STATUS<0 STATUS
 ;--- If the  task record exists, then update the task STATUS
 ;--- field if necessary and return the current task status
 I STATUS>0  D:+STATUS'=$G(RORBUF(799.64,IENS,.03,"I"))  Q STATUS
 . S RORFDA(799.64,IENS,.03)=+STATUS
 . D FILE^DIE(,"RORFDA","RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,799.64,IENS)
 ;--- Otherwise, return the last known status
 S STATUS=+$G(RORBUF(799.64,IENS,.03,"I"))
 Q:STATUS'>0 0
 S TMP=$TR($G(RORBUF(799.64,IENS,.03,"E")),">",":")
 Q STATUS_U_TMP
