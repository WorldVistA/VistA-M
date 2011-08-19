RMPRDVN3 ;HOIFO/SPS - MANDATORY PATIENT NOTIFICATION WIN FILE CREATE;12/11/07 [6/8/09 3:31pm]
 ;;3.0;PROSTHETICS;**125**;Feb 09, 1996;Build 21
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CRTWIN ; Create RMPRDVNxxxWFTP.TXT  file to transfer file
 N POP,OUTFLL1
 S POP=""  ; POP is returned by OPEN^%ZISH
 S RMPRERR=0
 S OUTFLL1="RMPRDVN"_STID_"WFTP.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFLL1,"W")
 I POP  D
 .S RMPRERR=3
 .Q
 I RMPRERR'=3 D
 .D USE^%ZISUTL("FILE1")
 .W "put RMPRDVN"_STID_"F1.TXT",!
 .W "exit",!  ; Exit SFTP
 .D CLOSE^%ZISH("FILE1")
 .Q
 Q
 ;
CRTWIN1 ; Run RMPRDVNSTIDFTP1.TXT
 ;
 N OUTFLL2
 S OUTFLL2="RMPRDVN"_STID_"WFTP.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFLL2,"W")
 D USE^%ZISUTL("FILE1")
 W "put "_FILEDIR_"RMPRDVN"_STID_"F1.TXT",!  ; WLS/MPLS 5/26/09 ADD 'FILEDIR
 W "bye"
 D CLOSE^%ZISH("FILE1")
 ;
 Q
CKRPTSV ; Check for availability of report server
 ; Several steps need to be performed
 ; 1. Set up script to perform PING
 ; 2. Capture log file during PING
 ; 3. Read logfile into working global
 ; 4. Determine Success/Failure of PING to server
 ; 5. If successful, continue processing (RMPRERR=0)
 ; 6. If problem occurs, S RMPRERR=3 and generate message
 ;
 I CKOS["VMS" D VMSPING  ; CKOS set in RMPRDVN2
 I CKOS["NT" D WINPING  ; CKOS set in RMPRDVN2
 Q
VMSPING ; need to PING report server to make sure it is available
 ;
 ; 1. Create .COM file to execute
 N OUTFLL2
 ;
 S OUTFLL2="RMPRDVN"_STID_"PING.COM"
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
 S XPV1="S PV=$ZF(-1,""@"_FILEDIR_"RMPRDVN"_STID_"PING.COM/OUTPUT="_FILEDIR_"RMPRDVN"_STID_"PING.LOG"")"
 X XPV1  ; Run the .com file
 ;
 ; 3. Read Logfile into working global
 N FNAME,XLOG
 S FNAME="RMPRDVN"_STID_"PING.LOG"
 S XLOG=$$FTG^%ZISH(FILEDIR,FNAME,$NAME(^TMP("RMPRLOG",$J,1)),3)
 ; Check global for %SYSTEM or 0 packets received
 N PNG,PNG1,PNG2,PNG3
 S PNG=0,PNG1=0,PNG2=0
 F  S PNG=$O(^TMP("RMPRLOG",$J,PNG)) Q:PNG=""  D
 . S PNG1=$G(^TMP("RMPRLOG",$J,PNG))
 . I PNG1["0 packets received" S RMPRERR=3
 . I PNG1["%SYSTEM" S RMPRERR=3
 . Q
 Q
WINPING ; PING report server to make sure it is available
 N PV,XPV1,XLOG
 ;
 S XPV1="S PV=$ZF(-1,""PING "_ADDR_">"_FILEDIR_"RMPRDVN"_STID_"PING.LOG"")"
 X XPV1
 S FNAME="RMPRDVN"_STID_"PING.LOG"
 S XLOG=$$FTG^%ZISH(FILEDIR,FNAME,$NAME(^TMP("RMPRLOG",$J,1)),3)
 N PNG,PNG1,PNG2,PNG3
 S PNG=0,PNG1=0,PNG2=0
 F  S PNG=$O(^TMP("RMPRLOG",$J,PNG)) Q:PNG=""  D
 . S PNG1=$G(^TMP("RMPRLOG",$J,PNG))
 . I PNG1["Received = 0" S RMPRERR=3
 . Q
 Q
FTPCOM ; Issue the FTP command after RMPRDVNxxxWFTP.TXT file is built
 ; remain in CACHE during FTP Process using
 ; $ZF(-1) call
 N PV,XPV1
 ;
 ; SACC Exception received for usage of $ZF(-1)
 S XPV1="S PV=$ZF(-1,""sftp -i "_FILEDIR_".ssh\rAgentkeys -B "_FILEDIR_"RMPRDVN"_STID_"WFTP.TXT RMPRFTP@VHAMACAPPT.V21.MED.VA.GOV"")" ; WLS/MPLS 5/28/09
 X XPV1  ; FTP the files, Comment out for testing
 ;
 ; error flag logic
 I PV=-1  D  ; Note, this error is logged on system error during xfer
 . S RMPRERR=1
 . Q
 Q
DELWIN ; Delete windows files
 ;
 ;
 I CKOS["NT" D DELFTPF Q
DELFTPF ; Delete the FTP files, logs , and .TXT files
 ;
 N XPV
 ; delete previous extract
 S XPV="S PV=$ZF(-1,""DEL "_FILEDIR_"RMPRDVN"_STID_".TXT"")"
 X XPV  ; comment out for testing
 ; delete previous logfile
 ;
 S XPV="S PV=$ZF(-1,""DEL "_FILEDIR_"RMPRDVN"_STID_"FTP1.LOG"")"
 X XPV  ; comment out for testing
 ; delete previous ftp file for transfer
 ;
 S XPV="S PV=$ZF(-1,""DEL "_FILEDIR_"RMPRDVN"_STID_"WFTP.TXT"")"
 X XPV
 Q
