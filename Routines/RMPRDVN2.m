RMPRDVN2 ;HOIFO/SPS - MANDATORY PATIENT NOTIFICATION ;12/11/07
 ;;3.0;PROSTHETICS;**125**;Feb 09, 1996;Build 21
 ;
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
RUNEXT ; Run extract report for PO Activity
 N RMPRERR ; error flag for exception handling,tst entry pt.
 ; RMPRERR will be set for the following conditions:
 ; 0 - Success, status message for completion is sent.
 ; 1 - Error creating ^TMP($J) data (i.e. disk full)
 ; 2 - Error creating Files(i.e. directory patch, VMS Space, etc.)
 ; 3 - Error creating .Com file for FTP transfer, permissions issue
 ; 4 - Error with FTP Transfer,ntwk/permissions, Report Server issue
 ; 5 - Error with file deletion/cleanup prior to processing
 ; 6 - Error, lock is present. Process already running
 S RMPRERR=0
TSTMSG ; This entry point is used to test the messaging framework
 ;  S SLRSTST1=1
 S RMPRERR=0
 ; Check for O/S version
 N CKOS
 S CKOS=$$OS^%ZOSV()
 ; Begin to build files
CRFILE ; Create .txt file to confirm write privileges to directory
 I RMPRERR=0 D TSTF^RMPRDVN1  ; will return RMPRERR=2 on error
 I RMPRERR=0 D DVNSFIL^RMPRDVN1
 I CKOS["VMS"  D
 . I RMPRERR=0 D CRTCOM^RMPRDVN1
 . Q
 ;I CKOS["NT"  D
 ;. I RMPRERR=0 D CRTWIN^RMPRDVN3
 ;. Q
 I RMPRERR=0 D CKRPTSV^RMPRDVN3  ;ping report server for availability
 I CKOS["VMS"  D
 . I RMPRERR=0  D
 . . D CRTCOM1^RMPRDVN1
 . . D FTPCOM^RMPRDVN1
 . . Q
 . Q
 I CKOS["NT"  D
 . I RMPRERR=0  D
 . . D CRTWIN1^RMPRDVN3
 . . D FTPCOM^RMPRDVN3
 . . Q
 . Q
 K ^TMP($J)
 Q
DELRUN ; delete previous run at the beginning of the program
 ;
 N FILCK,FILDEL,TFILE1,TFILE2,OUTFL1,OUTFL2,POP
 ; create, delete, then create files to clean up and confirm
 ; write / delete privileges to directory
 I '$D(CKOS) S CKOS="VMS"
 S POP="",RMPRERR=0
 S OUTFL1="RMPRDVN"_STID_"TST.TXT"
 S OUTFL2="RMPR"_STID_"TST.TXT"
 I FILEDIR=""  D
 . S RMPRERR=5
 . Q
 I RMPRERR=0 D OPEN^%ZISH("TFILE1",FILEDIR,OUTFL1,"W")
 I POP  D
 . S RMPRERR=5
 . Q
 I RMPRERR=0  D
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
 ; SACC Exception received for usage of $ZF(-1) in
 I CKOS["NT" D DELWIN^RMPRDVN3
DELFILS ; Delete the files / clean-up before processing
 ;
 ; SACC Exception received for usage of $ZF(-1) in 
 I CKOS["VMS"  D  ;O/S IS VMS
 . Q:RMPRERR'="0"
 . N PV,PV1,XPV,XPV1
 . S XPV="S PV=$ZF(-1,""DELETE "_FILEDIR_"*"_STID_"*.*;*"")"
 . X XPV
 . Q
 Q
