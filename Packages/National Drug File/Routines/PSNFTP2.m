PSNFTP2 ;HP/ART - PPS-N National Drug File Updates File Transfer ;09/25/2015
 ;;4.0;NATIONAL DRUG FILE;**513,573**; 30 Oct 98;Build 6
 ;Supported ICRs/IAs
 ;External reference to ^%ZISH supported by DBIA 2320
 ;External reference to ^%ZISUTL supported by DBIA 2119
 ;External reference to ^XLFSTR supported by DBIA 10104
 ;Reference to ^PS(59.7 supported by DBIA 2613
 ;
VMSFTP(PSRC,PSADDR,PSNUSER,PSWRKDIR,PSLOCDIR,PSREMDIR,PSREMFIL,PSCOMFIL,PSLOGFIL,PSDATFIL,PSERRMSG) ; VMS FTP
 ;        ALL PARARMETERS ARE REQUIRED EXCEPT PASSWORD
 ;Inputs: PSRC - return code, by reference
 ;        PSADDR - remote server address
 ;        PSNUSER - target system user name
 ;        PSWRKDIR - local work directory name
 ;        PSLOCDIR - local directory name
 ;        PSREMDIR - remote directory name
 ;        PSREMFIL - remote file name
 ;        PSCOMFIL - ftp .com file name
 ;        PSLOGFIL - ftp log file name
 ;        PSDATFIL - sftp commands file name
 ;Output: PSRC - populated return code
 ;
 ;check parameters
 I $G(PSADDR)="" S PSRC="0^no target server address" Q
 I $G(PSNUSER)="" S PSRC="0^no user name" Q
 I $G(PSWRKDIR)="" S PSRC="0^no local work directory name" Q
 I $G(PSLOCDIR)="" S PSRC="0^no local directory name" Q
 I $G(PSREMDIR)="" S PSRC="0^no remote directory name" Q
 I $G(PSREMFIL)="" S PSRC="0^no remote file name" Q
 I $G(PSCOMFIL)="" S PSRC="0^no ftp .com file name" Q
 I $G(PSLOGFIL)="" S PSRC="0^no ftp log file name" Q
 I $G(PSDATFIL)="" S PSRC="0^no sftp commands file name" Q
 ;
 ;create .dat file with sftp commands
 D CREATDAT^PSNFTP(.PSRC,PSDATFIL,PSWRKDIR,PSREMDIR,PSREMFIL) Q:'+PSRC
 ;
 ;create .com file
 N POP,FTPPORT S FTPPORT=""
 D OPEN^%ZISH("FILE1",PSWRKDIR,PSCOMFIL,"W")
 I POP S PSRC="0^failed to open ftp .com file" Q
 D USE^%ZISUTL("FILE1")
 W "$ set verify=(PROCEDURE,IMAGE)",!
 W "$ set default ",PSLOCDIR,!
 W "$ sftp"_$S(FTPPORT:" -oPort="_FTPPORT,1:"")_" -oIdentityFile="""_$$XVMSDIR(PSWRKDIR)_"VSSHID."" -""B"" "_PSWRKDIR_PSDATFIL_" -oUser="_PSNUSER_" "_PSADDR,!
 W "$ exit",!
 D CLOSE^%ZISH("FILE1")
 ;
 D OPEN^%ZISH("VSSHID",PSWRKDIR,"VSSHID.","W")
 I POP S PSRC="-1^FTP Script file <"_PSWRKDIR_"VSSHID.> could not be created." Q
 D USE^%ZISUTL("VSSHID")
 W "IDKEY "_$$XVMSDIR(PSWRKDIR)_"VSSHKEY"
 D CLOSE^%ZISH("VSSHID")
 ;
EXECUTE ;Execute .COM file, create logfile
 N PSZFRC
 S PSZFRC=$ZF(-1,"@"_PSWRKDIR_PSCOMFIL_"/OUTPUT="_PSWRKDIR_PSLOGFIL)
 ; Error check
 I PSZFRC=-1 S PSRC="0^VMS OS command execution failed" Q
 ;
 ; Read Logfile into working global
 K ^TMP("PSNFTPLOG",$J)
 N PSXLOG
 S PSXLOG=$$FTG^%ZISH(PSWRKDIR,PSLOGFIL,$NA(^TMP("PSNFTPLOG",$J,1)),3)
 ; Check for error during ftp
 N PSPNG,PSPNG1,PSSTOP
 S PSPNG="",PSPNG1=0,PSSTOP=0
 F  S PSPNG=$O(^TMP("PSNFTPLOG",$J,PSPNG)) Q:PSPNG=""!PSSTOP  D
 . S PSPNG1=$G(^TMP("PSNFTPLOG",$J,PSPNG))
 . I PSPNG1["%TCPIP-E-SSH_FC_ERR_NO_S, file doesn't exist" S PSRC="0^Remote file was not found",PSSTOP=1 Q
 . I PSPNG1["%TCPIP-F-SSH_FATAL" S PSRC="0^non-specific fatal error",PSSTOP=1 Q
 . I PSPNG1["530 Login incorrect" S PSRC="0^server login failure",PSSTOP=1 Q
 . I PSPNG1["550-Failed to open" S PSRC="-1^remote file not found",PSSTOP=1 Q
 . I PSPNG1["550 file not found" S PSRC="-1^remote file not found",PSSTOP=1 Q
 . I PSPNG1["no such file" S PSRC="-1^remote file not found",PSSTOP=1 Q
 . I PSPNG1["No such file" S PSRC="-1^remote file not found",PSSTOP=1 Q
 . I PSPNG1["error processing output file" S PSRC="-1^remote file already downloaded",PSSTOP=1 Q
 . I PSPNG1["insufficient privilege" S PSRC="-1^remote file already downloaded",PSSTOP=1 Q
 . I PSPNG1["%SET-F-SEARCHFAIL" S PSRC="0^local file not found - change file permission",PSSTOP=1 Q
 . I PSPNG1["%TCPIP-E-SSH_FC_ERR_DEST" S PSRC="0^destination is not directory or does not exist",PSSTOP=1 Q
 . I PSPNG1["%TCPIP-E-SSH_FC_ERROR" S PSRC="0^destination is not directory or does not exist",PSSTOP=1 Q
 I PSSTOP=0 S PSERRMSG(1)="1^File Transfer is complete"
 D DELFILES($G(PSWRKDIR),$G(PSLOGFIL),$G(PSCOMFIL),$G(PSDATFIL))
 Q
 ;
LINUXFTP(PSRC,PSADDR,PSNUSER,PSWRKDIR,PSLOCDIR,PSREMDIR,PSREMFIL,PSSHFILE,PSLOGFIL,PSDATFIL) ; Linux FTP
 ;        ALL PARARMETERS ARE REQUIRED EXCEPT PASSWORD
 ;Inputs: PSRC - return code, by reference
 ;        PSADDR - remote server address
 ;        PSNUSER - target system user name
 ;        PSWRKDIR - local work directory name
 ;        PSLOCDIR - local directory name
 ;        PSREMDIR - remote directory name
 ;        PSREMFIL - remote file name
 ;        PSSHFILE - ftp .sh file name
 ;        PSLOGFIL - ftp log file name
 ;        PSDATFIL - sftp commands file name
 ;Output: PSRC - populated return code
 ;
 ;check parameters
 I $G(PSADDR)="" S PSRC="0^no target server address" Q
 I $G(PSNUSER)="" S PSRC="0^no user name" Q
 I $G(PSWRKDIR)="" S PSRC="0^no local work directory name" Q
 I $G(PSLOCDIR)="" S PSRC="0^no local directory name" Q
 I $G(PSREMDIR)="" S PSRC="0^no remote directory name" Q
 I $G(PSREMFIL)="" S PSRC="0^no remote file name" Q
 I $G(PSSHFILE)="" S PSRC="0^no ftp .sh file name" Q
 I $G(PSLOGFIL)="" S PSRC="0^no ftp log file name" Q
 I $G(PSDATFIL)="" S PSRC="0^no sftp commands file name" Q
 ;
 ;create .dat file with sftp commands
 D CREATDAT^PSNFTP(.PSRC,PSDATFIL,PSWRKDIR,PSREMDIR,PSREMFIL) Q:'+PSRC
 ;create .sh file
 N POP,DEBUG1 S DEBUG1=1
 D OPEN^%ZISH("FILE1",PSWRKDIR,PSSHFILE,"W")
 I POP S PSRC="0^failed to open ftp .sh file" Q
 D USE^%ZISUTL("FILE1")
 ; Linux .sh commands
 W "#!/bin/bash",!!
 W "cd ",PSWRKDIR,!
 W "sftp"_" -oIdentityFile="""""_PSWRKDIR_"uxsshkey"""" -b "_PSWRKDIR_PSDATFIL_" -oStrictHostKeyChecking=no -oUser="_PSNUSER_" "_PSADDR_" >> "_PSWRKDIR_PSLOGFIL
 W !,"exit",!
 D CLOSE^%ZISH("FILE1")
 ;
 ; Execute .sh file, create logfile
 N PSZFRC
 S PSZFRC=$ZF(-1,PSWRKDIR_PSSHFILE_" >"_PSWRKDIR_PSLOGFIL)
 ; Error check
 I PSZFRC=-1 S PSRC="0^Linux OS command execution failed" Q
 ;
 ; Read Logfile into working global
 K ^TMP("PSNFTPLOG",$J)
 N PSXLOG
 S PSXLOG=$$FTG^%ZISH(PSWRKDIR,PSLOGFIL,$NA(^TMP("PSNFTPLOG",$J,1)),3)
 ; Check for error during ftp
 N PSPNG,PSPNG1,PSSTOP,UXEXIT
 S PSPNG="",(PSPNG1,PSSTOP,UXEXIT)=0
 F  S PSPNG=$O(^TMP("PSNFTPLOG",$J,PSPNG)) Q:PSPNG=""!PSSTOP  D
 . S PSPNG1=$G(^TMP("PSNFTPLOG",$J,PSPNG))
 . I $$UP^XLFSTR(PSPNG1)["SFTP> EXIT" S UXEXIT=1 Q
 . I PSPNG1["425 Not logged in" S PSRC="0^Login incorrect",PSSTOP=1 Q
 . I PSPNG1["530 Login incorrect" S PSRC="0^Login incorrect",PSSTOP=1 Q
 . I PSPNG1["550-Failed to open" S PSRC="-1^remote file not found",PSSTOP=1 Q
 . I PSPNG1["550 file not found" S PSRC="-1^remote file not found",PSSTOP=1 Q
 . I PSPNG1["no such file" S PSRC="-1^remote file not found",PSSTOP=1 Q
 . I PSPNG1["No such file" S PSRC="-1^remote file not found",PSSTOP=1 Q
 I UXEXIT=0 S PSRC="-1^Remote file was not found",PSSTOP=1 Q
 I PSSTOP=0,UXEXIT S PSERRMSG(1)="1^File Transfer is complete"
 D DELFILES($G(PSWRKDIR),$G(PSLOGFIL),$G(PSCOMFIL),$G(PSDATFIL))
 Q
 ;
WINFTP(PSRC,PSADDR,PSUID,PSWRKDIR,PSLOCDIR,PSREMDIR,PSREMFIL,PSCMDFIL,PSLOGFIL) ; Windows FTP
 ;        ALL PARARMETERS ARE REQUIRED EXCEPT PASSWORD
 ;Inputs: PSRC - return code, by reference
 ;        PSADDR - remote server address
 ;        PSUID - target system user name
 ;        PSWRKDIR - local work directory name
 ;        PSLOCDIR - local directory name
 ;        PSREMDIR - remote directory name
 ;        PSREMFIL - remote file name
 ;        PSCMDFIL - ftp commands file name
 ;        PSLOGFIL - ftp log file name
 ;Output: PSRC - populated return code
 ;
 ;check parameters
 I $G(PSADDR)="" S PSRC="0^no target server address" Q
 I $G(PSUID)="" S PSRC="0^no user name" Q
 I $G(PSWRKDIR)="" S PSRC="0^no local work directory name" Q
 I $G(PSLOCDIR)="" S PSRC="0^no local directory name" Q
 I $G(PSREMDIR)="" S PSRC="0^no remote directory name" Q
 I $G(PSREMFIL)="" S PSRC="0^no remote file name" Q
 I $G(PSCMDFIL)="" S PSRC="0^no ftp commands file name" Q
 I $G(PSLOGFIL)="" S PSRC="0^no ftp log file name" Q
 ;create ftp commands file
 N POP
 D OPEN^%ZISH("FILE1",PSWRKDIR,PSCMDFIL,"W")
 I POP S PSRC="0^failed to open ftp commands file" Q
 D USE^%ZISUTL("FILE1")
 W "open ",PSADDR,!
 W PSUID,!
 W "lcd ",PSLOCDIR,!
 W "cd ",PSREMDIR,!
 W "ascii",!
 W "get ",PSREMFIL,!
 W "quit",!
 D CLOSE^%ZISH("FILE1")
 ; Execute ftp file, create logfile
 N PSZFRC
 S PSZFRC=$ZF(-1,"sftp -s:"_PSWRKDIR_PSCMDFIL_" >"_PSWRKDIR_PSLOGFIL)
 ; Error check
 I PSZFRC=-1 S PSRC="0^Windows OS command execution failed" Q
 ; Read Logfile into working global
 K ^TMP("PSNFTPLOG",$J)
 N PSXLOG
 S PSXLOG=$$FTG^%ZISH(PSWRKDIR,PSLOGFIL,$NA(^TMP("PSNFTPLOG",$J,1)),3)
 ; Check for error during ftp
 N PSPNG,PSPNG1,PSSTOP
 S PSPNG=""
 S PSPNG1=0
 S PSSTOP=0
 F  S PSPNG=$O(^TMP("PSNFTPLOG",$J,PSPNG)) Q:PSPNG=""!PSSTOP  D
 . S PSPNG1=$G(^TMP("PSNFTPLOG",$J,PSPNG))
 . I PSPNG1["530 Login incorrect" S PSRC="0^Login incorrect",PSSTOP=1 Q
 . I PSPNG1["425 Not logged in" S PSRC="0^Login incorrect",PSSTOP=1 Q
 . I PSPNG1["550-Failed to open" S PSRC="-1^remote file not found",PSSTOP=1 Q
 . I PSPNG1["550 file not found" S PSRC="-1^remote file not found",PSSTOP=1 Q
 . I PSPNG1["no such file" S PSRC="-1^remote file not found",PSSTOP=1 Q
 . I PSPNG1["No such file" S PSRC="-1^remote file not found",PSSTOP=1 Q
 Q
 ;
FILSIZE(PSDIR,PSFILE,PSSIZE,PSNFLAG1) ;get the file size after retrieval
 N PSDIR,PSFSIZL,PSFSIZL2,DIE,DA,D0,DR,PSXLOG,PSSEQ,PSSEQD,PSIEN,ERROR,PSOS,X
 S PSOS=$$GETOS^PSNFTP
 S:'$D(PSDIR) PSDIR=$$GETD^PSNFTP()
 S PSFSIZL="PSFSIZE.LOG"
 S X=$ZF(-1,"DIR/SIZE=UNITS=BYTES "_PSDIR_PSFILE,PSDIR_PSFSIZL)
 S PSXLOG="",PSXLOG=$$FTG^%ZISH(PSDIR,PSFSIZL,$NA(^TMP("PSNFSIZELOG",$J,1)),3)
 S (PSSEQ,PSSEQD,PSIEN,DIE,DR,DA)=""
 F  S PSSEQ=$O(^TMP("PSNFSIZELOG",$J,PSSEQ)) Q:PSSEQ=""  D
 . S PSSEQD=$G(^TMP("PSNFSIZELOG",$J,PSSEQ))
 . I PSSEQD["Total of" S PSSIZE=$P(PSSEQD,",",2)
 S PSFSIZL2="PSFSIZE2.LOG"
 S X=$ZF(-1,"DIR/SIZE "_PSDIR_PSFILE,PSDIR_PSFSIZL2)
 S PSXLOG="",PSXLOG=$$FTG^%ZISH(PSDIR,PSFSIZL2,$NA(^TMP("PSNFSIZELOG2",$J,1)),3)
 S (PSSEQ,PSSEQD,PSIEN,DIE,DR,DA)=""
 F  S PSSEQ=$O(^TMP("PSNFSIZELOG2",$J,PSSEQ)) Q:PSSEQ=""  D
 . S PSSEQD=$G(^TMP("PSNFSIZELOG2",$J,PSSEQ))
 . I PSSEQD["Total of" S PSSIZE=PSSIZE_" or"_$P($P(PSSEQD,",",2),".")
 G:$G(PSNFLAG1) FILSIZQ
 S PSIEN="",PSIEN=$O(^PS(57.23,1,4,"B",PSFILE_";1",PSIEN))
 G FILSIZQ:PSIEN=""
 I '$G(PSNFLAG1) S DIE="^PS(57.23,1,4,",DA=PSIEN,DR="3///"_PSSIZE D ^DIE
FILSIZQ ;
 I '$G(PSOS) S PSOS=$$GETOS^PSNFTP
 I PSOS["VMS" D
 . D VMSDEL(1,PSDIR,PSFSIZL)
 . D VMSDEL(1,PSDIR,PSFSIZL2)
 K ^TMP("PSNFSIZELOG",$J)
 Q
 ;
VMSDEL(PSRC,PSDIR,PSFILE) ;Delete Local Host File
 ;Inputs: PSRC - return code, by reference
 ;        PSDIR - directory name
 ;        PSFILE - file name
 ;Output: PSRC - populated return code
 ;
 ;check parameters
 I $G(PSDIR)="" S PSRC="0^no directory name" Q
 I $G(PSFILE)="" S PSRC="0^no file name" Q
 S PSZFRC=$ZF(-1,"delete "_PSDIR_PSFILE_";*")
 I PSZFRC=-1 S PSRC="0^VMS OS command execution failed" Q
 Q
 ;
SAVEKEYS(LOCDIR) ; Saves Key to local directory
 ;Input: LOCDIR - Local directory where the keys should be saved to      
 N WLN,XPV
 I $$GET1^DIQ(57.23,1,39,"I")="SSH2" D
 . ;Saving the Private SSH Key
 . D OPEN^%ZISH("VSSHKEY",LOCDIR,"VSSHKEY","W")
 . D USE^%ZISUTL("VSSHKEY")
 . F WLN=1:1 Q:'$D(^PS(57.23,1,"PRVKEY",WLN))  D
 . . W $$DECRYP^XUSRB1(^PS(57.23,1,"PRVKEY",WLN,0)),!
 . D CLOSE^%ZISH("VSSHKEY")
 ;
 I $$OS^%ZOSV()["VMS" D  Q
 . ;Saving the Public SSH Key (Assuming SSH2 format) - VMS Only
 . D OPEN^%ZISH("VSSHKEY",LOCDIR,"VSSHKEY.PUB","W")
 . D USE^%ZISUTL("VSSHKEY")
 . F WLN=1:1 Q:'$D(^PS(57.23,1,"PUBKEY",WLN))  D
 . . W $$DECRYP^XUSRB1(^PS(57.23,1,"PUBKEY",WLN,0)),!
 . D CLOSE^%ZISH("VSSHKEY")
 ;
 I $$OS^%ZOSV()["UNIX" D  Q
 . ;If Key format is SSH2, convert VSSHKEY to OpenSSH format; Otherwise write directly from VistA
 . I $$GET1^DIQ(57.23,1,39,"I")="SSH2" D
 . . S XPV="S PV=$ZF(-1,""ssh-keygen -i -f "_LOCDIR_"VSSHKEY > "_LOCDIR_"uxsshkey"")"
 . . X XPV
 . E  D
 . . ;Saving the Private SSH Key (OpenSSH Format)
 . . D OPEN^%ZISH("uxsshkey",LOCDIR,"uxsshkey","W")
 . . D USE^%ZISUTL("uxsshkey")
 . . F WLN=1:1 Q:'$D(^PS(57.23,1,"PRVKEY",WLN))  D
 . . . W $$DECRYP^XUSRB1(^PS(57.23,1,"PRVKEY",WLN,0)),!
 . . D CLOSE^%ZISH("uxsshkey")
 . S XPV="S PV=$ZF(-1,""chmod 600 "_LOCDIR_"uxsshkey"")"
 . X XPV
 Q
DIREXIST(DIR) ; Returns whether the Linux Directory for sFTP already exists
 ;Input: DIR - Linux Directory name to be checked
 ;*573 Added condition check for IRIS
 N DIREXIST,PSNVER
 S PSNVER=$$UP^XLFSTR($$VERSION^%ZOSV(1))
 I DIR="" Q 0
 I $$OS^%ZOSV()'="UNIX" Q 0
 I PSNVER'["CACHE",PSNVER'["IRIS" Q 0
 I $E(DIR,$L(DIR))="/" S $E(DIR,$L(DIR))=""
 X "S DIREXIST=$ZSEARCH(DIR)"
 Q $S(DIREXIST="":0,1:1)
 ;
MAKEDIR(DIR) ; Create a new directory
 ;Input: DIR - Linux Directory name to be created
 ;*573 Added condition check for IRIS
 N MKDIR,PSNVER
 S PSNVER=$$UP^XLFSTR($$VERSION^%ZOSV(1))
 I $$OS^%ZOSV()'="UNIX" Q
 I PSNVER'["CACHE",PSNVER'["IRIS" Q
 I $$DIREXIST(DIR) Q
 X "S MKDIR=$ZF(-1,""mkdir ""_DIR)"
 I 'MKDIR X "S MKDIR=$ZF(-1,""chmod 777 ""_DIR)"
 Q
 ;
DELFILES(LOCDIR,LOGFILE,PSCOMFIL,PSDATFIL) ; Delete Files
 ;Input: LOCDIR   - Local Directory
 ;
 N FILE2DEL,PSOOS
 I $G(LOCDIR)="" Q
 S PSOOS=$$OS^%ZOSV()
 S:$G(LOGFILE)'="" FILE2DEL(LOGFILE)=""
 S:$G(PSCOMFIL)'="" FILE2DEL(PSCOMFIL)=""
 S:$G(PSDATFIL)'="" FILE2DEL(PSDATFIL)=""
 I PSOOS["VMS" S FILE2DEL("VSSHID.")="",FILE2DEL("VSSHKEY.")="",FILE2DEL("VSSHKEY.PUB")=""
 I PSOOS["UNIX" S FILE2DEL("PSNSIZE.DAT")="",FILE2DEL("VSSHKEY")="",FILE2DEL("uxsshkey")=""
 I PSOOS["NT" S FILE2DEL("VSSHKEY")="",FILE2DEL("VSSHKEY.PUB")=""
 D DEL^%ZISH(LOCDIR,"FILE2DEL")
 Q
 ;
XVMSDIR(VMSDIR) ; Converts a VMS directory
 ; Input: VMSDIR    - OpenVMS directory name (e.g., "USER$:[SFTP.PPSN]")
 ; Output: $$XVMSDIR - Converted VMS directory (e.g., "/USER$/PPSN/")
 ;
 Q "/"_$TR(VMSDIR,".[]:","///")
 ;
