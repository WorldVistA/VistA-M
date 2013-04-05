PRCHLO4A ;WOIFO/RLL/DAP-EXTRACT ROUTINE CLO REPORT SERVER ;12/30/10  14:58
 ;;5.1;IFCAP;**83,104,98,130,154,172**;Oct 20, 2000;Build 2
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; Continuation of PRCHLO4
 ;
 ; PRCHLO4A routines are used to Write out the Header and data
 ;
 ;Patch PRC*5.1*172 are modifications to CLRS transmission processing 
 ;to support those sites that have migrated to Full LINUX OS
 ; 
 Q
GETDIR ; Get directory from PRCPLO EXTRACT DIRECTORY system parameter for CLRS
 N FILEDIR,STID
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 ;
 Q
 ;
CRTWIN ; Create CLRSxxxWFTP.TXT  file to transfer file(s)
 ;*98 Modified to work with PRC CLRS ADDRESS parameter
 N FILEDIR,POP,STID,OUTFLL1,ADDR
 ; PRC*5.1*130 begin
 N PRCHUSN,PRCHPSW
 ; PRC*5.1*130 end
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S POP=""  ; POP is returned by OPEN^%ZISH
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 ; RLL/PRC*5.1*104 change logic to create separate FTP
 ; transfer files (1 for each file for Windows/Cache)
 S ADDR=$$GET^XPAR("SYS","PRC CLRS ADDRESS",1,"Q")
 I ADDR="" S PRCPMSG(1)="There is no address identified in the CLRS Adress Parameter.",PRCPMSG(2)="Please correct and retry." D MAILFTP S CLRSERR=1 Q
 ; PRC*5.1*130 begin
 S PRCHUSN=$$GET^XPAR("SYS","PRCPLO USER NAME",1,"Q")
 I PRCHUSN="" S PRCPMSG(1)="There is no user name identified in the CLRS USER NAME Parameter.",PRCPMSG(2)="Please correct and retry." D MAILFTP S CLRSERR=1 Q
 S PRCHUSN=$$DECRYP^XUSRB1(PRCHUSN)
 S PRCHPSW=$$GET^XPAR("SYS","PRCPLO PASSWORD",1,"Q")
 I PRCHPSW="" S PRCPMSG(1)="There is no password identified in the CLRS PASSWORD Parameter.",PRCPMSG(2)="Please correct and retry." D MAILFTP S CLRSERR=1 Q
 S PRCHPSW=$$DECRYP^XUSRB1(PRCHPSW)
 ; PRC*5.1*130 end
 ;
 I CLRSERR'=3  D
 . N PONN  ; File number for File type
 . S PONN=1
 . F PONN=1:1:27  D
 . . N FTY  ; File type F=Po Activity , G=GIP
 . . ;
 . . S FTY="F"
 . . S OUTFLL1="CLRS"_STID_FTY_PONN_"WFTP.TXT"
 . . D OPEN^%ZISH("FILE1",FILEDIR,OUTFLL1,"W")
 . . I POP  D
 . . . S CLRSERR=3
 . . . Q
 . . D USE^%ZISUTL("FILE1")
 . . D BLDF1
 . . D CLOSE^%ZISH("FILE1")
 . . Q
 . Q
 ;
 I CLRSERR'=3  D
 . ; RLL/PRC*5.1*104 change logic to create separate FTP
 . ; tranfer files (1 for each file for Windows/Cache)
 . N PONN  ; File number for file type
 . S PONN=1
 . F PONN=1:1:2  D
 . . N FTY  ; File type F=Po Activity , G=GIP
 . . S FTY="G"
 . . S OUTFLL1="CLRS"_STID_FTY_PONN_"WFTP.TXT"
 . . D OPEN^%ZISH("FILE1",FILEDIR,OUTFLL1,"W")
 . . I POP  D
 . . . S CLRSERR=3
 . . . Q
 . . D USE^%ZISUTL("FILE1")
 . . D BLDF1
 . . D CLOSE^%ZISH("FILE1")
 . . Q
 . Q
 Q
BLDF1 ; RLL/PRC*5.1*104 added logic to create separate FTP
 ; transfers (1 for each file)
 ;
 W "open "_ADDR,!  ;Connect to the Report Server
 ; PRC*5.1*130 begin
 ; Enter user name for Report Server Login
 W PRCHUSN,!
 ; Enter P/W for Report Server Login
 W PRCHPSW,!
 ; PRC*5.1*130 end
 W "PUT "_FILEDIR_"IFCP"_STID_FTY_PONN_".TXT",!
 W "bye",!  ; Exit FTP
 ;
 Q
CKRPTSV ; Check for availability of report server
 ; Several steps need to be performed
 ; 1. Set up script to perform PING
 ; 2. Capture log file during PING
 ; 3. Read logfile into working global
 ; 4. Determine Success/Failure of PING to server
 ; 5. If successful, continue processing (CLRSERR=0)
 ; 6. If problem occurs, S CLRSERR=3 and generate message
 ;
 I CKOS["VMS" D VMSPING  ; CKOS set in PRCHLO5
 I CKOS["NT" D WINPING  ; CKOS set in PRCHLO5
 I CKOS["UNIX" D UNXPING ; added for UNIX LINUX PING   ;PRC*5.1*172 added check for Full Linux
 Q
VMSPING ; need to PING report server to make sure it is available
 ;
 ; 1. Create .COM file to execute
 ;*98 Modified to work with PRC CLRS ADDRESS parameter
 N FILEDIR,STID,OUTFLL2,ADDR
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S ADDR=$$GET^XPAR("SYS","PRC CLRS ADDRESS",1,"Q")
 I ADDR="" S PRCPMSG(1)="There is no address identified in the CLRS Address Parameter.",PRCPMSG(2)="Please correct and retry." D MAILFTP S CLRSERR=1 Q
 ;
 S OUTFLL2="CLRS"_STID_"PING.COM"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFLL2,"W")
 D USE^%ZISUTL("FILE1")
 W "$ SET VERIFY=(PROCEDURE,IMAGE)",!
 W "$ SET DEFAULT "_FILEDIR,!
 W "$ TCPIP",!
 W "PING "_ADDR,!
 W "EXIT",!
 W "$ EXIT 3",!
 D CLOSE^%ZISH("FILE1")
 ;
 ; 2. Execute .COM file, create logfile
 S XPV1="S PV=$ZF(-1,""@"_FILEDIR_"CLRS"_STID_"PING.COM/OUTPUT="_FILEDIR_"CLRS"_STID_"PING.LOG"")"
 X XPV1  ; Run the .com file
 ;
 ; 3. Read Logfile into working global
 N FNAME,XLOG
 S FNAME="CLRS"_STID_"PING.LOG"
 S XLOG=$$FTG^%ZISH(FILEDIR,FNAME,$NAME(^TMP("PRCLRSLOG",$J,1)),3)
 ; Check global for %SYSTEM or 0 packets received
 N PNG,PNG1,PNG2,PNG3
 S PNG=0,PNG1=0,PNG2=0
 F  S PNG=$O(^TMP("PRCLRSLOG",$J,PNG)) Q:PNG=""  D
 . S PNG1=$G(^TMP("PRCLRSLOG",$J,PNG))
 . I PNG1["0 packets received" S CLRSERR=3
 . I PNG1["%SYSTEM" S CLRSERR=3
 . Q
 Q
UNXPING ;PRC*5.1*172 added logic for Full Linux
 ; UNIX/LINUX PING
 ;
 ; PING report server to make sure it is available
 ;*98 Modified to work with PRC CLRS ADDRESS parameter 
 N PV,XPV1,FILEDIR,STID,XLOG,ADDR
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S ADDR=$$GET^XPAR("SYS","PRC CLRS ADDRESS",1,"Q")
 I ADDR="" S PRCPMSG(1)="There is no address identified in the CLRS Adress Parameter.",PRCPMSG(2)="Please correct and retry." D MAILFTP S CLRSERR=1 Q
 ;
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S XPV1="S PV=$ZF(-1,""ping -c 3 "_ADDR_">"_FILEDIR_"CLRS"_STID_"PING.LOG"")"
 X XPV1
 S FNAME="CLRS"_STID_"PING.LOG"
 S XLOG=$$FTG^%ZISH(FILEDIR,FNAME,$NAME(^TMP("PRCLRSLOG",$J,1)),3)
 N PNG,PNG1,PNG2,PNG3
 S PNG=0,PNG1=0,PNG2=0
 F  S PNG=$O(^TMP("PRCLRSLOG",$J,PNG)) Q:PNG=""  D
 . S PNG1=$G(^TMP("PRCLRSLOG",$J,PNG))
 . I PNG1["0 received" S CLRSERR=3
 . Q
 Q
 ;
WINPING ; PING report server to make sure it is available
 ;*98 Modified to work with PRC CLRS ADDRESS parameter 
 N PV,XPV1,FILEDIR,STID,XLOG,ADDR
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S ADDR=$$GET^XPAR("SYS","PRC CLRS ADDRESS",1,"Q")
 I ADDR="" S PRCPMSG(1)="There is no address identified in the CLRS Adress Parameter.",PRCPMSG(2)="Please correct and retry." D MAILFTP S CLRSERR=1 Q
 ;
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S XPV1="S PV=$ZF(-1,""PING "_ADDR_">"_FILEDIR_"CLRS"_STID_"PING.LOG"")"
 X XPV1
 S FNAME="CLRS"_STID_"PING.LOG"
 S XLOG=$$FTG^%ZISH(FILEDIR,FNAME,$NAME(^TMP("PRCLRSLOG",$J,1)),3)
 N PNG,PNG1,PNG2,PNG3
 S PNG=0,PNG1=0,PNG2=0
 F  S PNG=$O(^TMP("PRCLRSLOG",$J,PNG)) Q:PNG=""  D
 . S PNG1=$G(^TMP("PRCLRSLOG",$J,PNG))
 . I PNG1["Received = 0" S CLRSERR=3
 . Q
 Q
 ;
LOG2FILE ; Set logfile to global, add to mail message
 ;
 ;
 N FILEDIR,STID,FNAME,XLOG
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 I CKOS["VMS" S FNAME="CLRS"_STID_"FTP1.LOG"
 I CKOS["NT" S FNAME="CLRS"_STID_"F1FTP1.LOG"
 I CKOS["UNIX" S FNAME="UNIXFTP.LOG"     ;PRC*5.1*172 added check for Full Linux
 S XLOG=$$FTG^%ZISH(FILEDIR,FNAME,$NAME(^TMP("PRCHLOG",$J,1)),3)
 ; Log file is in the global ^TMP("PRCHLOG", lets put it in
 ; the message beginning at PRCPMSG(11)
 ;
 N LG1,LG2,LG3,LG4,LGCNT
 S LG1=0,LG2=0,LG3=0,LG4=0,LGCNT=11
 F  S LG1=$O(^TMP("PRCHLOG",$J,LG1)) Q:LG1=""  D
 . S LG3=$G(^TMP("PRCHLOG",$J,LG1))
 . S PRCPMSG(LGCNT)=LG3
 . S LGCNT=LGCNT+1
 . Q
 D MAILFTP
 Q
FTPCOM ; Issue the FTP command after CLRSxxxWFTP.TXT file is built
 ; remain in CACHE during FTP Process using
 ; $ZF(-1) call
 ;
 ; rll/ 8/30/2006 Change logic to initiate transfer one file
 ; at a time to the report server for Windows/Cache stations
 ; This was done after a hang was observed between transfers.
 ;
 N LPP1,LPP2
 S LPP1=0,LPP2="F"
 F LPP1=1:1:27  D  ; run the FTP command for the 27 PO files
 . D RUNFTPT
 . Q
 S LPP1=0,LPP2="G"
 F LPP1=1:1:2  D  ; run the FTP command for the 2 GIP files
 . D RUNFTPT
 . Q
 Q
 ;
RUNFTPT ; Run the FTP transfer for Windows
 N PV,XPV1,FILEDIR,STID
 ;
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 ; SACC Exception received for usage of $ZF(-1) in PRC*5.1*83
 ; See IFCAP Technical Manual
 S XPV1="S PV=$ZF(-1,""ftp -s:"_FILEDIR_"CLRS"_STID_LPP2_LPP1_"WFTP.TXT>"_FILEDIR_"CLRS"_STID_LPP2_LPP1_"FTP1.LOG"")"
 X XPV1  ; FTP the files, Comment out for testing
 ;
 ; error flag logic
 I PV=-1  D  ; Note, this error is logged on system error during xfer
 . S CLRSERR=1
 . Q
 Q
DELWIN ; Delete windows files
 ;
 ;
 I CKOS["NT"  D
 . N LPP1,LPP2
 . S LPP1=0,LPP2="F"
 . F LPP1=1:1:27  D  ; run the FTP command for the 27 PO files
 . . D DELFTPF
 . . Q
 . Q
 S LPP1=0,LPP2="G"
 F LPP1=1:1:2  D
 . D DELFTPF  ; Delete the GIP files
 . Q
 Q
DELUNX ;PRC*5.1*172 added logic for Full Linux
 ; Delete the FTP files, logs , and .TXT files
 ;
 S OUTFLL2="CLRSCLNUP.SH"
 N FILEDIR,STID,XPV
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 ; delete previous extract
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFLL2,"W")
 D USE^%ZISUTL("FILE1")
 ; add syntax here to create shell script
 ;
 ;
 ;
 ; add Linux code below
 W "#!/bin/bash",!
 W !
 W "cd ",FILEDIR,!
 ; W !
 W "rm -f CLRS*.TXT",!
 W "rm -f IFCP*.TXT",!
 W "rm -f CLRS*UNX*",!
 W "rm -f CLRSCLNUP*",!
 W "exit 0",!
 D CLOSE^%ZISH("FILE1")
 ; get ready to delete files
 ;
 ; NOTE: This is a test entry point if problems occur with directory permissions
 ; if the directory is set up properly, the begin/end code in not needed
 ; this code was left in for troubleshooting via M/Cache
 ; begin troubleshooting code
 ; peform CHMOD on SHELL SCRIPT to make it executable
 ; S XPV1="S PV=$ZF(-1,""CHMOD 755 "_FILEDIR_"CLRS"_"CLNUP.SH"")"
 ; S XPV1="S PV=$ZF(-1,"""_FILEDIR_"CLRS"_"CLNUP.SH"")"
 ; X XPV1
 ; end troubleshooting code
 D DELUNX1
 Q
 ; 
 ;
 ;
DELUNX1 ;PRC*5.1*172 added logic for Full Linux
 ; Delete UNIX Files
 ;
 ; S XPV1="S PV=$ZF(-1,"""_FILEDIR_"CLRS"_STID_"UNX.SH"")"
 S XPV1="S PV=$ZF(-1,"""_FILEDIR_"CLRS"_"CLNUP.SH"")"
 X XPV1
 Q
DELFTPF ; Delete the FTP files, logs , and .TXT files
 ;
 N FILEDIR,STID,XPV
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 ; delete previous extract
 S XPV="S PV=$ZF(-1,""DEL "_FILEDIR_"IFCP"_STID_LPP2_LPP1_".TXT"")"
 X XPV  ; comment out for testing
 ; delete previous logfile
 ;
 S XPV="S PV=$ZF(-1,""DEL "_FILEDIR_"CLRS"_STID_LPP2_LPP1_"FTP1.LOG"")"
 X XPV  ; comment out for testing
 ; delete previous ftp file for transfer
 ;
 S XPV="S PV=$ZF(-1,""DEL "_FILEDIR_"CLRS"_STID_LPP2_LPP1_"WFTP.TXT"")"
 X XPV
 Q
 ;
MAIL ;Builds mail messages to a defined mail group to notify users of the
 ;success or failure of the TaskMan scheduling for the CLO Procurement
 ;Reports
 ;
 ;*98 Modified code to work with PRC CLRS OUTLOOK MAILGROUP parameter
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,PRCPMG,PRCPMG2
 S XMSUB="CLO Procurement Report Status for "_$$HTE^XLFDT($H)
 S XMDUZ="Clinical Logistics Report Server"
 S XMTEXT="PRCPMSG("
 S XMY("G.PRCPLO CLRS NOTIFICATIONS")=""
 S PRCPMG=$$GET^XPAR("SYS","PRC CLRS OUTLOOK MAILGROUP",1,"Q")
 S:$G(PRCPMG)'="" PRCPMG2="S XMY("""_PRCPMG_""")=""""" X PRCPMG2
 ;
 D ^XMD
 Q
 ;
MAILFTP ;Builds mail messages to a defined mail group to notify users of
 ;the success or failure of issues pertaining to FTP Transfer and
 ;file permissions/protections associated with VMS Directories
 ;
 ;*98 Modified code to work with PRC CLRS OUTLOOK MAILGROUP parameter
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,PRCPMG,PRCPMG2
 S XMSUB="CLO Environment Check & Data Transfer for OS / FTP , "_$$HTE^XLFDT($H)
 S XMDUZ="Clinical Logistics Report Server"
 S XMTEXT="PRCPMSG("
 S XMY("G.PRCPLO CLRS NOTIFICATIONS")=""
 S PRCPMG=$$GET^XPAR("SYS","PRC CLRS OUTLOOK MAILGROUP",1,"Q")
 S:$G(PRCPMG)'="" PRCPMG2="S XMY("""_PRCPMG_""")=""""" X PRCPMG2
 ;
 D ^XMD
 Q
