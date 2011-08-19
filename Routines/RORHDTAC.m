RORHDTAC ;HCIOFO/SG - DATA EXTRACTION ACTION CONFIRMATIONS ; 3/14/06 11:07am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 Q
 ;
 ;***** CONFIRMATION TO CREATE A NEW TASK TABLE
 ;
 ; HDEIEN        Data Extract IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;        1  Cancel
 ;
CREATE(HDEIEN) ;
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IENS,RC,RORBUF,RORMSG,X,Y
 ;--- Display status of the data extract
 S RC=$$STATUS^RORHDT01(HDEIEN)  Q:RC<0 RC
 ;--- Check if registry task table is not empty
 S IENS=","_(+HDEIEN)_","
 D LIST^DIC(799.64,IENS,"@","Q",1,,,"B",,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.64,IENS)
 ;--- Ask for a confirmation to overwrite
 I $G(RORBUF("DILIST",0))>0  D  Q:RC 1
 . K DIR  S DIR(0)="Y"
 . S DIR("A")="Overwrite the existing task table"
 . S DIR("B")="NO"
 . W !  D ^DIR  S RC=$D(DIRUT)!'$G(Y)
 Q 0
 ;
 ;***** CONFIRMATIONS TO START THE TASK
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ; .FAM          File Access Mode is returned via this parameter
 ; .SDT          Start Date/Time is returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;        1  Cancel
 ;
START(HDEIEN,TASKIEN,FAM,SDT) ;
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILE,OUTDIR,RC,RORDST,RORSRC,STATUS,X,Y
 S FAM="",SDT=""
 ;--- Check status of the task
 S STATUS=+$$TASKSTAT^RORHDTUT(HDEIEN,TASKIEN)
 I STATUS=1  D  Q:RC $S(RC<0:RC,1:1)
 . K DIR  S DIR(0)="Y"
 . S DIR("A")="The task is pending. Do you want to reschedule it"
 . S DIR("B")="NO"
 . D ^DIR  S RC=$D(DIRUT)!'$G(Y)
 . S:'RC RC=$$STOP^RORHDT03(HDEIEN,TASKIEN)
 I STATUS=2  D  Q 1
 . W !,"The task is running already"
 I STATUS=3  D  Q:RC 1
 . K DIR  S DIR(0)="Y"
 . S DIR("A")="The task is completed. Do you want to rerun it"
 . S DIR("B")="NO"
 . D ^DIR  S RC=$D(DIRUT)!'$G(Y)
 ;--- Ask the user for the start date/time
 K DIR
 S X=$$FMADD^XLFDT($$DT^XLFDT,30)
 S DIR(0)="D^NOW:"_X_":AEFNRSX",DIR("B")="NOW"
 S DIR("A")="Run the task"
 D ^DIR  Q:$D(DIRUT)!'$G(Y) 1
 S SDT=+Y
 ;--- Check if the output file exists already
 S RC=$$TASKFILE^RORHDTUT(HDEIEN,TASKIEN,.OUTDIR,.FILE)  Q:RC<0 RC
 S RORSRC(FILE)=""
 S RC=$$LIST^%ZISH(OUTDIR,"RORSRC","RORDST")
 I RC  S:$D(RORDST)>1 FAM="N"
 ;--- Generate the new file name
 I FAM["N"  D  Q:RC<0 RC
 . S RC=$$NEWFILE^RORHDTUT(HDEIEN,TASKIEN,.FILE)
 . W:'RC !,"Data will be written to the '"_FILE_"' file."
 ;---
 Q 0
 ;
 ;***** CONFIRMATION TO STOP THE TASK
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Stop the task
 ;        1  Cancel
 ;
STOP(HDEIEN,TASKIEN) ;
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IENS,STATUS,X,Y,ZTSK
 ;--- Check status of the task
 S STATUS=+$$TASKSTAT^RORHDTUT(HDEIEN,TASKIEN)
 ;--- Quit if the task is not running, pending, nor suspended
 Q:(STATUS'=1)&(STATUS'=2)&(STATUS'=102) 1
 ;--- Get the task number
 S IENS=(+TASKIEN)_","_(+HDEIEN)_","
 S ZTSK=$$GET1^DIQ(799.64,IENS,.02,,,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.64,IENS)
 ;--- Ask for the final confirmation
 K DIR  S DIR(0)="Y"
 S DIR("A")=$S(STATUS=1:"Dequeue",1:"Stop")_" the task #"_ZTSK
 S DIR("B")="NO"
 D ^DIR
 Q $D(DIRUT)!'$G(Y)
