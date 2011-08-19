MAGIPS93 ;WOIFO/SG - INSTALL CODE FOR MAG*3*93 ; 5/13/09 10:01am
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;
 ; There are no environment checks here but the MAGIPS93 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;+++++ UPDATES/FIXES THE DELETED IMAGE ENTRY
 ;
 ; MAGIEN        IEN of an entry of the IMAGE AUDIT file (#2005.1)
 ;
 ; Input Variables
 ; ===============
 ;   MAGSTAT
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Ok
 ;
MAGAUDIT(MAGIEN) ;
 N MAGNODE,MAGRC,STC,SUB,TMP
 S MAGNODE=$NA(^MAG(2005.1,MAGIEN))
 Q:$D(@MAGNODE)<10 $$ERROR^MAGUERR(-22,,2005.1,MAGIEN_",")
 S STC=$P($G(@MAGNODE@(100)),U,8)  Q:STC=12 0  ; STATUS (113)
 S MAGRC=0
 ;
 ;=== Fix the subfile headers
 F SUB="1^2005.14P","4^2005.1106DA","5^2005.11PA","6^2005.1111A","99^2005.199D"  D
 . S TMP=$P(SUB,U)  Q:'($D(^MAG(2005.1,MAGIEN,TMP,0))#2)
 . S $P(^MAG(2005.1,MAGIEN,TMP,0),U,2)=$P(SUB,U,2)
 . Q
 ;
 ;=== Update STATUS field and create the corresponding audit record
 S TMP=+$P($G(@MAGNODE@(30)),U,2)   ; DELETED DATE (30.1)
 I TMP>0  D  Q:MAGRC<0 MAGRC
 . N IENS,MAGFDA,MAGMSG
 . S IENS="+1,"_MAGIEN_","
 . S MAGFDA(2005.199,IENS,.01)=TMP  ; DATE/TIME RECORDED
 . S MAGFDA(2005.199,IENS,.02)=113  ; FIELD NUMBER
 . ;--- USER = DELETED BY (30)
 . S MAGFDA(2005.199,IENS,.03)=$P($G(@MAGNODE@(30)),U)
 . ;--- OLD INTERNAL VALUE and OLD EXTERNAL VALUE
 . D:STC>0
 . . S MAGFDA(2005.199,IENS,1)=STC
 . . S:$G(MAGSTAT(STC))'="" MAGFDA(2005.199,IENS,2)=MAGSTAT(STC)
 . . Q
 . ;--- Create audit record for the status update
 . D UPDATE^DIE(,"MAGFDA",,"MAGMSG")
 . S:$G(DIERR) MAGRC=$$DBS^MAGUERR("MAGMSG",2005.1,MAGIEN_",")
 . Q
 S $P(@MAGNODE@(100),U,8)=12  ; STATUS = 'Deleted'
 ;
 ;===
 Q MAGRC
 ;
 ;+++++ BUILDS NEW INDEXES IN FILES #2005 AND #2005.1
 ;
 ; MAGSUSPEND    Task suspension parameters
 ;                 ^01: Suspend the task (0|1)
 ;                 ^02: Suspension start time (e.g. 7am: .07)
 ;                 ^03: Suspension end time (e.g. 8pm: .2)
 ;
 ; Input Variables
 ; ===============
 ;   XPDNM, ZTQUEUED
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Ok
 ;
 ; Notes
 ; =====
 ;
 ; This function also populates the STATUS field (113) and fixes
 ; headers of all multiples of the IMAGE AUDIT file (#2005.1).
 ;
NDXBLD(MAGSUSPEND) ;
 N MAGFILE       ; Number of the file that is being processed
 N MAGNOFMAUDIT  ; Controls image audit indexes (see AUDIT^MAGUXRF)
 N MAGROOT       ; Closed root of the file that is being processed
 N MAGSTAT       ; List of status codes and their descriptions
 ;
 N DTNEXT,MAGCNT,MAGIEN,MAGRC,SILENT,TH,TMP
 S SILENT=$S($G(XPDNM)'="":0,1:$D(ZTQUEUED)),MAGRC=0
 D:'SILENT BMES^MAGKIDS("Building new image indexes...")
 ;
 ;=== Get the image status codes
 D
 . N BUF,I
 . S BUF=$$GET1^DID(2005,113,,"POINTER")
 . F I=1:1  S TMP=$P(BUF,";",I)  Q:TMP=""  D
 . . S MAGSTAT(+TMP)=$P(TMP,":",2)
 . . Q
 . Q
 ;
 ;=== Do not update the AUDIT multiple (99)
 S MAGNOFMAUDIT=1
 ;
 ;=== Build the indexes
 F MAGFILE=2005,2005.1  D  Q:MAGRC<0
 . I 'SILENT  D  D MES^MAGKIDS(TMP_" file (#"_MAGFILE_")")
 . . S TMP=$$GET1^DID(MAGFILE,,,"NAME")
 . . Q
 . ;--- Check if the file has been processed already
 . I $$PRD^MAGKIDS(MAGFILE,93)  D:'SILENT  Q
 . . D MES^MAGKIDS("This file is already processed.")
 . . Q
 . ;--- Initialize
 . S XPDIDTOT=$$GET1^DID(MAGFILE,,,"ENTRIES")
 . I XPDIDTOT'>0  D:'SILENT MES^MAGKIDS("This file is empty.")  Q
 . S MAGROOT=$$ROOT^DILFD(MAGFILE,,1),DIK=$$OREF^DILF(MAGROOT)
 . ;--- Delete the indexes (in case of restart)
 . K @MAGROOT@("APDT")
 . K:MAGFILE=2005.1 @MAGROOT@("AGP"),^("APDTPX")
 . ;--- Process the file
 . S (MAGCNT,MAGIEN)=0
 . F  S MAGIEN=$O(@MAGROOT@(MAGIEN))  Q:'MAGIEN  D  Q:MAGRC<0
 . . I '(MAGCNT#1000)  D  Q:MAGRC<0
 . . . I '$D(ZTQUEUED)  D PROGRESS(MAGCNT)  Q
 . . . ;--- Check if task stop has been requested
 . . . I $$S^%ZTLOAD  S MAGRC=$$ERROR^MAGUERR(-1)  Q
 . . . ;--- Check if the task should be suspended
 . . . Q:'$G(MAGSUSPEND)
 . . . Q:$$NOW^XLFDT<$G(DTNEXT)
 . . . Q:'$$SUSPEND(.DTNEXT)
 . . . ;--- Suspend the task during the peak hours
 . . . F  D  Q:'TH!MAGRC<0
 . . . . S TH=$$FMDIFF^XLFDT(DTNEXT,$$NOW^XLFDT,2)
 . . . . I TH<60  S TH=0  Q       ; Do not HANG for less than a
 . . . . H $S(TH>3600:3600,1:TH)  ; minute and more than an hour
 . . . . ;--- Check if task stop has been requested
 . . . . S:$$S^%ZTLOAD MAGRC=$$ERROR^MAGUERR(-1)
 . . . . Q
 . . . Q
 . . S MAGCNT=MAGCNT+1
 . . ;--- Additional processing for IMAGE AUDIT record
 . . I MAGFILE=2005.1  S MAGRC=$$MAGAUDIT(MAGIEN)  Q:MAGRC<0
 . . ;--- Re-index the record
 . . D XREF(MAGFILE,MAGIEN)
 . . Q
 . ;--- Indicate the final state of the process
 . D:'$D(ZTQUEUED) PROGRESS(MAGCNT)
 . D PRD^MAGKIDS(MAGFILE,93,"A")
 . Q
 Q:MAGRC<0 MAGRC
 ;
 ;=== Success
 D:'SILENT MES^MAGKIDS("The indexes have been successfully built.")
 Q 0
 ;
 ;+++++ CALLBACK FUNCTION FOR THE IMGAGE INDEX CHECKPOINT
 ;
 ; Input Variables
 ; ===============
 ;   DUZ, XPDQUES, ZTQUEUED
 ;
NDXCP() ;
 N MAGRC
 S MAGRC=0
 ;
 ;=== Schedule a separate task that will build image indexes
 I $G(XPDQUES("POS02-MODE"))  D  Q MAGRC
 . N MSG,ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTKIL,ZTPRI
 . N ZTRTN,ZTSAVE,ZTSK,ZTSYNC,ZTUCI
 . S ZTSAVE("MAGDUZ")=$G(DUZ)
 . S:$G(XPDQUES("POS10-SUSPEND")) ZTSAVE("MAGSUSPEND")="1^.07^.2"
 . S ZTRTN="NDXTASK^"_$T(+0),ZTIO=""
 . S ZTDESC="Image index builder (MAG*3*93)"
 . S ZTDTH=$G(XPDQUES("POS05-SCHEDULEAT"))
 . S:ZTDTH'>0 ZTDTH=$$NOW^XLFDT
 . D ^%ZTLOAD
 . I $G(ZTSK)=""  S MAGRC=$$ERROR^MAGUERR(-39)  Q
 . ;--- Display the confirmation message
 . S MSG(1)="It will rebuild indexes in the IMAGE (#2005) and IMAGE AUDIT (#2005.1)"
 . S MSG(2)="files and perform other post-processing actions."
 . D BMES^MAGKIDS("Task #"_ZTSK_" has been scheduled.",.MSG)
 . Q
 ;
 ;=== Build the indexes as part of the patch post-install
 Q $$NDXBLD()
 ;
 ;***** FORMATS AND PRINTS THE HELP TEXT FOR THE INDEX TASK MODE
NDXHLP(DIR,KIDS) ;
 ;;Patch MAG*3*93 defines new indexes for the IMAGE (#2005) and IMAGE 
 ;;AUDIT (#2005.1) files. These indexes can be built as a part of the
 ;;patch KIDS build installation or the post-install code can schedule
 ;;a separate task that will build the indexes.
 ;;
 ;;However, it appears that the Taskman is not running on this system.
 ;;As the result, you will not be given a choice and the indexes will
 ;;be built as part of the post-install. If you want to schedule a
 ;;separate indexing task, abort the installation, start the Taskman,
 ;;and restart the patch installation.
NDXHLP1 ;
 ;;Patch MAG*3*93 defines new indexes for the IMAGE (#2005) and IMAGE 
 ;;AUDIT (#2005.1) files. These indexes can be built in the current
 ;;session (this will block it for quite a long time) or a separate
 ;;task can be scheduled.
 ;;
 ;;However, it appears that the Taskman is not running on this system.
 ;;If you want to schedule a separate indexing task, exit this option,
 ;;start the Taskman, and run the option again.
 ;
 N DIWF,DIWL,DIWR,MAGI,MAGTAG,X
 S MAGTAG=$S($G(KIDS):"NDXHLP",1:"NDXHLP1")
 S DIWF="",DIWL=4,DIWR=$G(IOM,80)-DIWL+1
 K ^UTILITY($J,"W"),DIR("?")
 ;--- Format the main help text
 F MAGI=1:1  S X=$P($T(@MAGTAG+MAGI),";;",2)  Q:X=""  D ^DIWP
 S X=" "  D ^DIWP
 ;--- Add the warning if the Taskman is not running
 I '$$TM^%ZTLOAD  D
 . F MAGI=MAGI+1:1  S X=$P($T(@MAGTAG+MAGI),";;",2)  Q:X=""  D ^DIWP
 . Q
 E  D
 . S X="Enter 'Y' or 'N'; enter '^' to cancel. "  D ^DIWP
 . Q
 ;--- Load the help text into the ^DIR parameter and print it
 S MAGI=0
 F  S MAGI=$O(^UTILITY($J,"W",DIWL,MAGI))  Q:MAGI'>0  D
 . S DIR("?",MAGI)=$J("",DIWL-1)_^UTILITY($J,"W",DIWL,MAGI,0)
 . W !,DIR("?",MAGI)
 . Q
 W !
 ;--- Special processing for the last line of the help text
 S MAGI=+$O(DIR("?",""),-1)
 I MAGI>0  S DIR("?")=DIR("?",MAGI)  K DIR("?",MAGI)
 ;--- Cleanup
 K ^UTILITY($J,"W")
 Q
 ;
 ;+++++ RETURNS THE MESSAGE DESCRIBING RESULTS OF THE INDEX BUILD
 ;
 ; RC            Error descriptor (see the $$ERROR^MAGUERR)
 ;
NDXMSG(RC) ;
 N PREFIX
 S PREFIX="MAG*3*93: "
 ;--- Error
 Q:RC<-1 PREFIX_RC
 ;--- Stopped by user
 Q:+RC=-1 PREFIX_"Image indexing task was stopped by the user."
 ;--- Success
 Q PREFIX_"New indexes of the image files have been built."
 ;
 ;***** BACKGROUND TASK THAT BUILDS THE IMAGE INDEXES
 ;
 ; Input Variables
 ; ===============
 ;
 ; MAGDUZ        Identifier of the user who started the task and who
 ;               will receive the alert when the task finishes (IEN
 ;               in the NEW PERSON file (#200)).
 ;
 ; MAGSUSPEND    Controls suspension of the task on working days
 ;                 ^01: Suspend the task (0|1)
 ;                 ^02: Start time (FileMan)
 ;                 ^03: End time (FileMan)
 ;
NDXTASK ;
 N MAGRC
 ;--- Build the indexes
 S MAGRC=$$NDXBLD($G(MAGSUSPEND))
 ;--- Send the alert
 D:$G(MAGDUZ)>0
 . N TMP,XQA,XQAARCH,XQACNDEL,XQADATA,XQAFLG,XQAGUID,XQAID
 . N XQAMSG,XQAOPT,XQAREVUE,XQAROU,XQASUPV,XQASURO,XQATEXT
 . S XQAMSG=$$NDXMSG(MAGRC)
 . S XQATEXT(1)=""
 . S XQATEXT(2)="Date/Time of completion: "_$$FMTE^XLFDT($$NOW^XLFDT)
 . S XQA(+MAGDUZ)="",XQAFLG="D"
 . S TMP=$$SETUP1^XQALERT
 . Q
 ;--- Keep the task descriptor only in case of error(s)
 S:MAGRC'<0 ZTREQ="@"
 K MAGDUZ,MAGSUSPEND
 Q
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 ;
 ;--- Link new remote procedures to the Broker context option
 S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCLST^"_$T(+0),"MAG WINDOWS"))
 I $$CP^MAGKIDS("MAG ATTACH RPCS",CALLBACK)<0  D ERROR  Q
 ;
 ;--- Enable version checking for all sites
 S CALLBACK="$$VERCHKON^MAGKIDS1"
 I $$CP^MAGKIDS("MAG VERSION CHECK",CALLBACK)<0  D ERROR  Q
 ;
 ;--- Restart the Imaging Utilization Report task
 I $$CP^MAGKIDS("MAG REPORT TASK","$$RPTSKCP^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- Build new indexes in the files #2005 and #2005.1
 I $$CP^MAGKIDS("MAG IMAGE INDEXES","$$NDXCP^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- Send the notification e-mail
 I $$CP^MAGKIDS("MAG NOTIFICATION","$$NOTIFY^MAGKIDS1")<0  D ERROR  Q
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 ;--- Delete the field #4; it will be replaced by the field #5.5
 D DELFLDS^MAGKIDS(2006.81,"4")
 Q
 ;
 ;+++++ UPDATES THE PROGRESS INDICATOR
PROGRESS(CNT) ;
 ;--- Reset the progress indicator
 I $G(CNT)'>0  D  Q
 . I '$D(XPDNM)  W !,"   0.00%"  Q
 . N XPDIDTOT
 . S XPDIDTOT=0  D UPDATE^XPDID(0)
 . Q
 ;--- Make sure that we never see more than 100%
 I $G(XPDIDTOT)>0  S:CNT>XPDIDTOT CNT=XPDIDTOT
 ;--- Update the indicator
 I $D(XPDNM)  D UPDATE^XPDID(CNT)  Q
 I $G(XPDIDTOT)>0  S $X=0  W *13,?3,$J(CNT/XPDIDTOT*100,0,2)_"%"
 Q
 ;
 ;***** MANUAL STARTER OF THE INDEX BUILDER TASK
REINDEX ;
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,EXIT,SCHEDULE,X,Y,ZTSAVE
 D CLEAR^MAGUERR(1)
 S SCHEDULE=0
 ;
 ;=== Request parameter values from the user
 S EXIT=0  D  Q:EXIT
 . ;--- Select the index building mode
 . K DIR  S DIR(0)="Y"
 . S DIR("A")="Schedule the task that builds the indexes"
 . D NDXHLP(.DIR)
 . D ^DIR  I $D(DIRUT)  S EXIT=1  Q
 . Q:'Y
 . ;--- The task will be scheduled
 . S SCHEDULE=1,ZTSAVE("MAGDUZ")=$G(DUZ)
 . ;--- Prompt for the task suspension mode
 . K DIR  S DIR(0)="Y",DIR("B")="YES"
 . S DIR("A")="Suspend the task during business hours (7am - 8pm)"
 . D ^DIR  I $D(DIRUT)  S EXIT=1  Q
 . S:Y ZTSAVE("MAGSUSPEND")="1^.07^.2"
 . Q
 ;
 ;=== Schedule the task that will build the indexes
 I SCHEDULE  D  Q
 . N ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTKIL,ZTPRI,ZTRTN,ZTSK,ZTSYNC,ZTUCI
 . S ZTRTN="NDXTASK^"_$T(+0),ZTIO=""
 . S ZTDESC="Image index builder (MAG*3*93)"
 . D ^%ZTLOAD  W !
 . I $G(ZTSK)=""  D ERROR^MAGUERR(-39),DUMP^MAGUERR1()  Q
 . W !,"Task #"_ZTSK_" has been scheduled."
 . Q
 ;
 ;=== Build the indexes in the current session
 K DIR  S DIR(0)="Y"
 S DIR("A")="Build the image indexes now"
 D ^DIR  Q:$D(DIRUT)
 I Y,$$NDXBLD()<0  W !  D DUMP^MAGUERR1()
 Q
 ;
 ;+++++ LIST OF NEW REMOTE PROCEDURES
RPCLST ;
 ;;MAG4 IMAGE LIST
 ;;MAGG IMAGE LOCK
 ;;MAGG IMAGE GET PROPERTIES
 ;;MAGG IMAGE SET PROPERTIES
 ;;MAGG IMAGE STATISTICS
 ;;MAGG IMAGE UNLOCK
 ;;MAGG REASON GET PROPERTIES
 ;;MAGG REASON LIST
 ;;MAGG CAPTURE USERS
 Q
 ;
 ;+++++ RESTARTS THE IMAGING UTILIZATION REPORT TASK
RPTSKCP() ;
 D REMTASK^MAGQE4,STTASK^MAGQE4
 Q 0
 ;
 ;+++++ CHECKS IF THE TASK SHOULD BE SUSPENDED
 ;
 ; .DTNEXT       Date/Time of the next event (suspend/resume)
 ;               is returned via this parameter
 ;
 ; Input Variables
 ; ===============
 ;   MAGSUSPEND
 ;
 ; Return Values
 ; =============
 ;            0  Continue/Resume
 ;            1  Suspend
 ;
SUSPEND(DTNEXT) ;
 N DATE,NOW,SUSPEND,TIME,TR,TS
 S TS=$P(MAGSUSPEND,U,2),TR=$P(MAGSUSPEND,U,3)
 S NOW=$$NOW^XLFDT,DATE=NOW\1
 ;--- A work day
 I $$WDCHK^MAGUTL03(DATE)  D  Q SUSPEND
 . S TIME=NOW-DATE,SUSPEND=0
 . I TIME<TS   S DTNEXT=DATE+TS  Q
 . I TIME'<TR  S DTNEXT=$$WDNEXT^MAGUTL03(DATE)+TS  Q
 . S DTNEXT=DATE+TR,SUSPEND=1
 . Q
 ;--- Saturday, Sunday or Holiday
 S DTNEXT=$$WDNEXT^MAGUTL03(DATE)+TS
 Q 0
 ;
 ;+++++ RE-INDEXES THE IMAGE RECORD
XREF(MAGFILE,MAGIEN) ;
 N GRPIEN,TMP,X0,X2
 S X0=$G(^MAG(MAGFILE,MAGIEN,0)),X2=$G(^(2))
 S GRPIEN=+$P(X0,U,10)  ; GROUP PARENT (14)
 ;---
 I GRPIEN  D:MAGFILE=2005.1
 . ;--- AGP
 . S ^MAG(MAGFILE,"AGP",GRPIEN,MAGIEN)=""
 . Q
 E  D
 . N DFN,PDT
 . S PDT=$P(X2,U,5)  Q:'PDT    ; PROCEDURE/EXAM DATE/TIME (15)
 . ;--- APDT
 . S ^MAG(MAGFILE,"APDT",PDT,MAGIEN)=""
 . ;--- IMAGE file (#2005) already has the APDTPX index
 . Q:MAGFILE=2005
 . ;--- APDTPX
 . S DFN=$P(X0,U,7)  Q:'DFN    ; PATIENT (5)
 . S TMP=$P(X0,U,8)  Q:TMP=""  ; PROCEDURE (6)
 . S ^MAG(MAGFILE,"APDTPX",DFN,9999999.9999-PDT,TMP,MAGIEN)=""
 . Q
 ;--- ACA
 D:'$P(X2,U,12)  ; CAPTURE APPLICATION (8.1)
 . N X100,PACS
 . S X100=$G(^MAG(MAGFILE,MAGIEN,100)),PACS=$G(^("PACS"))
 . S TMP=$TR($P(PACS,U,1,3),"^ ")  ; Fields 60, 61, and 62
 . S $P(^MAG(MAGFILE,MAGIEN,2),U,12)=$S($P(X100,U,5)'="":"I",TMP'="":"D",1:"C")
 . Q
 ;--- Done
 Q
