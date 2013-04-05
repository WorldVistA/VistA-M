PRCHLO5 ;WOIFO/DAP/RLL-manual run for procurement reports  ; 10/16/06 2:12pm
V ;;5.1;IFCAP;**83,98,139,172**;Oct 20, 2000;Build 2
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Patch PRC*5.1*172 are modifications to CLRS transmission processing 
 ;to support those sites that have migrated to Full LINUX OS
 ; 
ENT ;This routine tasks out the execution of the procurement extract 
 ;reports associated with PRC*5.1*83 (CLRS).
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,PRCHPRO,ZTSK,ZTREQ,PRCPMSG
 S ZTRTN="RUNEXT^PRCHLO5"
 S ZTDESC="PRCPLO CLO Procurement Reports CLRS"
 S ZTDTH=$H
 S ZTREQ="@"
 S ZTIO=""
 D ^%ZTLOAD
 S PRCHPRO=ZTSK
 ;Calls mail group message generation and screen display with success
 ;or exception notification
 I $D(PRCHPRO)[0 S PRCPMSG(1)="A task could not be created for the CLO Procurement Reports - please contact IRM." W ! D EN^DDIOL(PRCPMSG(1)) D MAIL^PRCHLO4A Q
 ; 
 S PRCPMSG(1)="Task # "_PRCHPRO_" entered for Procurement Reports."
 W !
 D EN^DDIOL(PRCPMSG(1))
 ;
 ;*98 Modified to move MAIL and MAILFTP tags to routine PRCHLO4A
 ;
 D MAIL^PRCHLO4A
 ;
 Q
PRCPCMP ; Notification of completion of building Procurement Report Data
 N PRCPMSG
 S PRCPMSG(1)="PO Procurement Data extract complete."
 D EN^DDIOL(PRCPMSG(1))
 D MAIL^PRCHLO4A
 Q
 ;
PRCPTST ; Notification of termination of building Procurement Report Data due to test system task origin (added in PRC*5.1*139)
 N PRCPMSG
 S PRCPMSG(1)="PO Procurement Data extract TERMINATED due to running on TEST system."
 D EN^DDIOL(PRCPMSG(1))
 D MAIL^PRCHLO4A
 K ^TMP($J),^TMP("PRCHLOG",$J)
 Q
 ;
RUNEXT ; Run extract reports for PO Activity
 I '$$PROD^XUPROD() G PRCPTST  ;Check added in patch PRC*139 to not execute on test systems
 N CLRSERR,CLRSTST1  ; error flag for exception handling,tst entry pt.
 ; CLRSERR will be set for the following conditions:
 ; 0 - Success, status message for completion is sent.
 ; 1 - Error creating ^TMP($J) data (i.e. disk full)
 ; 2 - Error creating Files(i.e. directory patch, VMS Space, etc.)
 ; 3 - Error creating .Com file for FTP transfer, permissions issue
 ; 4 - Error with FTP Transfer,ntwk/permissions, Report Server issue
 ; 5 - Error with file deletion/cleanup prior to processing
 ; 6 - Error, lock is present. Process already running
 S CLRSERR=0
TSTMSG ; This entry point is used to test the messaging framework
 ;  S SLRSTST1=1
 S CLRSERR=0
 ; Check for O/S version
 N CKOS
 S CKOS=$$OS^%ZOSV()
 ; use lock to prevent mult. runs
 L +^PRCP(446.7,"STATUS"):3 I $T=0 S CLRSERR=6
 I CLRSERR=0 D DELRUN^PRCHLO5
 I CLRSERR=5  D
 . N PRCPMSG
 . S PRCPMSG(1)="Error with file deletion/cleanup prior to processing. Please contact IRM."
 . S PRCPMSG(2)=" "
 . S PRCPMSG(3)="This error indicates the CLRS EXTRACT DIRECTORY has not"
 . S PRCPMSG(4)="been properly set up during the installation of this patch."
 . S PRCPMSG(5)=" "
 . S PRCPMSG(6)="(Please refer to the pre installation instructions for PRC*5.1*83)"
 . S PRCPMSG(7)=" "
 . S PRCPMSG(8)="A valid directory must be set up with the"
 . S PRCPMSG(9)="proper read/write/execute/delete privileges."
 . S PRCPMSG(10)=" "
 . S PRCPMSG(11)="In addition, the directory name which you create"
 . S PRCPMSG(12)="must be added as the CLRS EXTRACT DIRECTORY"
 . S PRCPMSG(13)="through the CLO System Parameters Option."
 . S PRCPMSG(14)="If the field is blank, you will generate this error."
 . S PRCPMSG(15)=" "
 . S PRCPMSG(16)="Please confirm all steps have been performed"
 . S PRCPMSG(17)="according to the pre installation instructions for patch PRC*5.1*83."
 . D MAILFTP^PRCHLO4A
 . Q
 ; Begin to build files
 I CLRSERR=0 D INIT^PRCHLO
 I CLRSERR=0 D PRCPCMP^PRCHLO5  ; PO activity Extract logic completed
 I $D(CLRSTST1)  D  ; test point to generate message 1
 . Q:CLRSTST1'=1
 . S CLRSERR=1
 . Q
 I CLRSERR=1  D
 . N PRCPMSG  ; error building ^TMP($J)
 . S PRCPMSG(1)="Error, No Data for PO Activity Files, contact IRM"
 . D MAILFTP^PRCHLO4A
 . Q
CRFILE ; Create .txt file to confirm write privileges to directory
 I CLRSERR=0 D TSTF^PRCHLO4  ; will return CLRSERR=2 on error
 I CLRSERR=0 D CLRSFIL^PRCHLO4
 I CLRSERR=2  D
 . N PRCPMSG
 . S PRCPMSG(1)="Error, Problem with FTP File Creation, contact IRM"
 . D MAILFTP^PRCHLO4A
 . Q
 I CLRSERR=0  D
 . N PRCPMSG
 . S PRCPMSG(1)="Built PO Activity Extracts and GIP Extracts for transfer"
 . D MAILFTP^PRCHLO4A
 . Q
 I CKOS["VMS"  D
 . I CLRSERR=0 D CRTCOM^PRCHLO4
 . Q
 I CKOS["NT"  D
 . I CLRSERR=0 D CRTWIN^PRCHLO4A
 . Q
 ;PRC*5.1*172 added check for Full Linux
 I CKOS["UNIX"  D
 . I CLRSERR=0  D
 . . D CRTUNX1^PRCHLO4
 . . Q
 . Q
 I CLRSERR=6  D
 . N PRCPMSG
 . S PRCPMSG(1)="Error encountered when attempting to run CLO PO"
 . S PRCPMSG(2)="activity reports due to other CLRS extracts in"
 . S PRCPMSG(3)="progress. Please try again later."
 . D MAILFTP^PRCHLO4A
 . Q
 I $D(CLRSTST1)  D  ; test point to generate message 3
 . Q:CLRSTST1'=3
 . S CLRSERR=3
 . Q
 I CLRSERR=0 D CKRPTSV^PRCHLO4A  ;ping report server for availability
 I CLRSERR=3  D
 . N PRCPMSG
 . S PRCPMSG(1)="Error, problem creating SETUP file for FTP Transfer, contact IRM."
 . S PRCPMSG(2)="The Report Server may be unavailable for processing."
 . D MAILFTP^PRCHLO4A
 . Q
 I CLRSERR=0  D
 . N PRCPMSG,FILEDIR
 . S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 . S PRCPMSG(1)="Final FTP Setup complete, beginning FTP Transfer"
 . S PRCPMSG(2)=" "
 . S PRCPMSG(3)="The file transfer to the report server has been initiated."
 . S PRCPMSG(4)="You will be receiving a notification that the FTP"
 . S PRCPMSG(5)="process has completed. The notification message"
 . S PRCPMSG(6)="should be received within the hour.  If you do not"
 . S PRCPMSG(7)="receive the FTP process has completed message,"
 . S PRCPMSG(8)="please contact IRM. IRM can confirm the process"
 . S PRCPMSG(9)="is still running by performing the following"
 . S PRCPMSG(10)="command:"
 . S PRCPMSG(11)=" "
 . S PRCPMSG(12)="At the MUMPS Programmer prompt, type D ^%SS"
 . S PRCPMSG(13)=" "
 . S PRCPMSG(14)="See if there are any PRCHLO* routines running."
 . S PRCPMSG(15)=" "
 . S PRCPMSG(16)="If these routines are present, the process is still"
 . S PRCPMSG(17)="running. If you waited one hour, and did not get the"
 . S PRCPMSG(18)="FTP process has completed message, a problem"
 . S PRCPMSG(19)="was encountered. Further troubleshooting can be"
 . S PRCPMSG(20)="performed by examining the LOGFILE CLRSxxxFTP1.LOG"
 . S PRCPMSG(21)="where xxx is your station ID#. The logfile is"
 . S PRCPMSG(22)="located in the following directory: "_FILEDIR
 . S PRCPMSG(23)=" "
 . D MAILFTP^PRCHLO4A
 . Q
 I CKOS["VMS"  D
 . I CLRSERR=0  D
 . . D CRTCOM1^PRCHLO4
 . . D FTPCOM^PRCHLO4
 . . Q
 . Q
 ;PRC*5.1*172 added check for Full Linux
 I CKOS["UNIX"  D
 . I CLRSERR=0  D
 . . D UNXFTP^PRCHLO4
 . . Q
 . Q
 I CKOS["NT"  D
 . I CLRSERR=0  D
 . . D CRTWIN^PRCHLO4A
 . . D FTPCOM^PRCHLO4A
 . . Q
 . Q
 ; release the lock
 L -^PRCP(446.7,"STATUS")
 I CLRSERR=4  D
 . N PRCPMSG,FILEDIR
 . S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 . S PRCPMSG(1)="An Error occurred during the FTP Transfer "_$$HTE^XLFDT($H)
 . S PRCPMSG(2)="Contact IRM to perform troubleshooting steps"
 . S PRCPMSG(3)="by examining the logfile CLRSxxxFTP1.LOG where"
 . S PRCPMSG(4)="xxx is your station number. The logfile is located"
 . S PRCPMSG(5)="the FTP directory "_FILEDIR
 . S PRCPMSG(6)=" "
 . D MAILFTP^PRCHLO4A
 . Q
 I CLRSERR=0  D
 . N PRCPMSG,FILEDIR
 . S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 . S PRCPMSG(1)="The FTP Transfer process completed, "_$$HTE^XLFDT($H)
 . S PRCPMSG(2)=" "
 . S PRCPMSG(3)="The Clinical Logistics 0ffice should examine the Report Server"
 . S PRCPMSG(4)="FTP directory for your files. If the files from your"
 . S PRCPMSG(5)="station are not found, IRM can provide additional"
 . S PRCPMSG(6)="troubleshooting steps by examining the LOGFILE"
 . S PRCPMSG(7)="CLRSxxxFTP1.LOG where xxx is your station number."
 . S PRCPMSG(8)="The logfile is located in the directory: "_FILEDIR
 . S PRCPMSG(9)=" "
 . S PRCPMSG(10)="The contents of the logfile are listed below:"
 . D LOG2FILE^PRCHLO4A
 . Q
 ; CLEAN UP
 K ^TMP($J)
 K ^TMP("PRCHLOG",$J)
 Q
DELRUN ; delete previous run at the beginning of the program
 ;
 N FILCK,FILDEL,TFILE1,TFILE2,OUTFL1,OUTFL2,POP,STID
 ; create, delete, then create files to clean up and confirm
 ; write / delete privileges to directory
 S POP=""
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S OUTFL1="CLRS"_STID_"TST.TXT"
 S OUTFL2="IFCP"_STID_"TST.TXT"
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 I FILEDIR=""  D
 . S CLRSERR=5
 . Q
 I FILEDIR=" "  D
 . S CLRSERR=5
 . Q
 I CLRSERR=0 D OPEN^%ZISH("TFILE1",FILEDIR,OUTFL1,"W")
 I POP  D
 . S CLRSERR=5
 . Q
 I CLRSERR=0  D
 . D USE^%ZISUTL("TFILE1")
 . W !,"$ ! This is a test file to confirm write/delete access"
 . W !,"$ ! once file access is confirmed, file is deleted"
 . W !,"$ EXIT"
 . D CLOSE^%ZISH("TFILE1")
 . D OPEN^%ZISH("TFILE2",FILEDIR,OUTFL2,"W")
 . D USE^%ZISUTL("TFILE2")
 . W !,"$ ! This is a test file to confirm write/delete access"
 . W !,"$ ! once file access is confirmed, file is deleted"
 . W !,"$ EXIT"
 . D CLOSE^%ZISH("TFILE2")
 . Q
 ;
DELWIN ; DELETE windows files, need to handle 1 file at a time
 ; SACC Exception received for usage of $ZF(-1) in PRC*5.1*83
 ; See IFCAP technical manual.
 I CKOS["NT" D DELWIN^PRCHLO4A
DELFILS ; Delete the files / clean-up before processing
 ;
 ; SACC Exception received for usage of $ZF(-1) in PRC*5.1*83
 ; See IFCAP technical manual
 I CKOS["VMS"  D  ;O/S IS VMS
 . Q:CLRSERR'="0"
 . N PV,PV1,XPV,XPV1
 . S XPV="S PV=$ZF(-1,""DELETE "_FILEDIR_"*"_STID_"*.*;*"")"
 . X XPV
 . Q
 ;PRC*5.1*172 added check for Full Linux
 I CKOS["UNIX"  D
 . D DELUNX^PRCHLO4A
 . Q
 Q
