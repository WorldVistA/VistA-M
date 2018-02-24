PSNFTP ;HP/ART - PPS-N National Drug File Updates File Transfer ;09/25/2015
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;Supported ICRs/IAs
 ;External reference to $$DECRYP^XUSRB1() supported by DBIA 2241
 ;External reference to ^%ZISH supported by DBIA 2320
 ;External reference to USE^%ZISUTL supported by DBIA 2119
 ;External reference to $$OS^%ZOSV supported by DBIA 10097
 ;External reference to ^XLFDT supported by DBIA 10103
 ;External reference to ^XMD supported by DBIA 10070
 ;External reference to ^PS(59.7 supported by DBIA #2613
 ;External reference to ^XUSEC supported by DBIA #10076
 ;
 ;SAC Exemption For use of Cache function $ZF(-1, was granted 10/23/15 by SACC committee
 ;
EN ; Main Entry Point for PPS-N National Drug File Updates File Transfer
 ;If a scheduled job initiates the PSNSCJOB=1 will be defined.
 I $$GET1^DIQ(57.23,1,9,"I")="Y" Q
 ;
 N PSRC,PSOS,PSREMFIL,PSFILE,PSFFND,DIE,DA,DR,LOCDIR,PSUID,PSNDNLDB
 N PSPREV,PSLAST,PSNEW,PSERRMSG,PSSIZE,PSWRKDIR,PSOLDF,PSFDCNT,PSOS2,PRSC,PSNPS,PSOUNXLD,X,XPV
 D NOW^%DTC S PSNDNLDB=%
 S PSFFND=0,(PSFDCNT,PSRC)=1
 S PSOS=$$GETOS
 S (PSFILE,PSREMFIL,PSOLDF)=""
 S PSWRKDIR=$$GETD()
 I PSOS["UNIX",'$$DIREXIST^PSNFTP2(PSWRKDIR) D MAKEDIR^PSNFTP2(PSWRKDIR)
 K DIE,DA,DR
 S DIE="^PS(57.23,",DA=1,DR="9///Y" D ^DIE K DIE,DA,DR
 F  D  Q:+PSRC<1
 . S PSERRMSG(1)="0^RETRIEVAL VERSION in PPS-N UPDATE CONTROL (#57.23) file is not defined"
 . ;last file downloaded
 . S PSLAST=$$GET1^DIQ(57.23,1,8)
 . I PSLAST="" D  Q
 . . S PSRC=PSERRMSG(1)
 . . D MAILFTP(0,"undeterminedFileName","",$P(PSRC,U,2))
 . . W "Determine remote file name failed ",PSOS," rc=",PSRC,!
 . ;
 . S PSNEW=PSLAST+1
 . S (PSFILE,PSREMFIL)="PPS_"_PSLAST_"PRV_"_PSNEW_"NEW.DAT"
 . I PSFDCNT=1 S PSOLDF=PSFILE
 . S PSFDCNT=PSFDCNT+1
 . I 'PSFFND W !!,"Beginning download for Update file name: ",PSREMFIL
 . I PSFFND W !!,"Continuing with the next file sequence. Attempting download",!," for: "_PSREMFIL
 . W !!
 . ;ping the remote server
 . D PING(.PSRC,PSOS)
 . USE 0
 . I '+PSRC D  Q
 . . D MAILFTP(0,PSREMFIL,"",$P(PSRC,U,2)) W "Server ping failed ",PSOS," rc=",PSRC,!
 . W "Server ping successful ",PSOS," rc=",PSRC,!
 . S PSOS2="",PSOS2=$S(PSOS["VMS":"VMS",PSOS["UNIX":"LINIX",1:"LINUX")_"DEL"
 . I PSOS["VMS" D
 . . ;D @PSOS2^PSNFTP2(PSRC,PSWRKDIR,"PSNPING.COM")
 . . ;D @PSOS2^PSNFTP2(PSRC,PSWRKDIR,"PSNPING.LOG")
 . ;
 . I PSOS["LINIX" D
 . . D @PSOS2^PSNFTP2(PSRC,PSWRKDIR,"PSNPING.LOG")
 . ;
 . ;transfer a file
 . S PSRC=PSERRMSG(1)
 . D FTP(.PSRC,PSOS,PSREMFIL,.PSERRMSG)
 . U 0
 . I +PSOS=1 D
 . . ;D VMSDEL^PSNFTP2(PSRC,PSWRKDIR,"PSNFTP.COM")
 . . ;D VMSDEL^PSNFTP2(PSRC,PSWRKDIR,"PSNFTP.LOG")
 . . ;D VMSDEL^PSNFTP2(PSRC,PSWRKDIR,"PSNSFTP.DAT")
 . I +PSOS=3 D
 . . D LINUXDEL(PSRC,PSWRKDIR,"PSNFTP.sh")
 . . D LINUXDEL(PSRC,PSWRKDIR,"PSNFTP.LOG")
 . . D LINUXDEL(PSRC,PSWRKDIR,"PSNSFTP.DAT")
 . . D LINUXDEL(PSRC,PSWRKDIR,"PSNPING.LOG")
 . ;
 . I +PSRC=0&(PSFFND) D  Q
 . . W !!,PSREMFIL_" does not exist.",!!,"PPS-N/NDF Download process is complete.",!
 . ;
 . I +PSRC=0&('PSFFND) D  Q
 . . D MAILFTP(0,PSREMFIL,"",$P(PSRC,U,2))
 . . Q:PSOLDF=PSREMFIL
 . . W "file transfer failed ",PSOS," rc=",PSRC,!
 . ;
 . I +PSRC=-1&('PSFFND) D  Q
 . . D MAILFTP(0,PSREMFIL,"",$P(PSRC,U,2))
 . . Q:PSOLDF=PSREMFIL
 . . W "remote file not found ",PSOS," rc=",PSRC,!
 . ;
 . ;update PPS-N UPDATE CONTROL:RETRIEVAL VERSION (#57.23:8)
 . I +PSRC=1 W "file transfer successful ",PSOS," rc=",PSRC,!
 . Q:+PSRC'=1
 . S PSFFND=1
 . K DIE,DA,DR
 . S DIE="^PS(57.23,",DA=1,DR="8///"_PSNEW D ^DIE K DIE,DA,DR
 . S PSSIZE=""
 . ;
 . ;**VMS file size
 . I +PSOS=1 D FILSIZE^PSNFTP2(PSWRKDIR,PSFILE,.PSSIZE,"")
 . ;
 . ;**linux file size
 . I +PSOS=3 D
 . . S XPV="S PV=$ZF(-1,""stat -c%s "_PSWRKDIR_PSFILE_">"_PSWRKDIR_"PSNSIZE.DAT"")"
 . . X XPV
 . . S PSXLOG="",PSXLOG=$$FTG^%ZISH(PSWRKDIR,"PSNSIZE.DAT",$NAME(^TMP("PSNFSIZELOG",$J,1)),3)
 . . I $D(^TMP("PSNFSIZELOG",$J,1)) S PSSIZE=^TMP("PSNFSIZELOG",$J,1)
 . ;
 . D MAILFTP(1,PSFILE,PSSIZE,""),DELFILES^PSNFTP2(PSWRKDIR)
 . W !!,"Completed download for: ",PSREMFIL,!!
 . D UPDTCTRL
 . S PRSC=0
 K DIE,DA,DR
 S DIE="^PS(57.23,",DA=1,DR="9///N" D ^DIE K DIE,DA,DR
 D NOW^%DTC S DIE="^PS(57.23,1,4,",DA=1,DR="3///"_% D ^DIE K DIE,DA,DR
 K DIE,DA,DR
 Q
 ;
PING(PSRC,PSOS) ; Check for availability of server (ping)
 ;Inputs: PSRC - reference to return code
 ;        PSOS - current OS
 ;Output: PSRC - populated return code
 ;
 N PSERRMSG,PSADDR,PSCOMFIL,PSLOGFIL,PSFILES
 S PSERRMSG(1)="0^Remote Server Address in the PPS-N Site Parameters is not defined or invalid"
 S PSERRMSG(2)="0^"_$S($$GETOS["VMS":"VMS",$$GETOS["LINUX":"Unix/Linux",1:"")_" Local Directory in the PPS-N Site Parameters is not defined or invalid"
 ;S PSERRMSG(2)="0^Local Directory in the PPS-N Site Parameters is not defined or invalid"
 S PSRC=1
 S PSADDR=$$GET1^DIQ(57.23,1,20) I PSADDR="" S PSRC=PSERRMSG(1) Q
 ;S PSWRKDIR="USER$:[SFTP.PPSN]"
 S PSWRKDIR=$$GETD() I PSWRKDIR="" S PSRC=PSERRMSG(2) Q
 S PSCOMFIL="PSNPING.COM"
 S PSLOGFIL="PSNPING.LOG"
 ;
 ;VMS
 I +PSOS=1 D
 . D VMSPING(.PSRC,PSADDR,PSWRKDIR,PSCOMFIL,PSLOGFIL)
 . S PSFILES(PSCOMFIL)=""
 . I '$$DELFILES(PSWRKDIR,.PSFILES) W !,"File cleanup/delete failed.",!
 ;
 ;Linux
 I +PSOS=3 D LINXPING(.PSRC,PSADDR,PSWRKDIR,PSLOGFIL)
 ;
 ;Windows
 I +PSOS=2 D WINPING(.PSRC,PSADDR,PSWRKDIR,PSLOGFIL)
 Q
 ;
FTP(PSRC,PSOS,PSREMFIL,PSERRMSG) ; ftp (get) a file
 ;Inputs: PSRC - reference to return code
 ;        PSOS - current OS
 ;        PSREMFIL - remote file name
 ;Output: PSRC - populated return code
 ;
 N PSADDR,PSNUSER,PSREMDIR,PSCOMFIL,PSSHFILE
 N PSLOCDIR,PSCMDFIL,PSLOGFIL,PSDATFIL
 S PSERRMSG(1)="0^REMOTE SERVER ADDRESS in PPS-N UPDATE CONTROL (#57.23) file is not defined"
 S PSERRMSG(2)="0^REMOTE SFTP USER ID in PPS-N UPDATE CONTROL (#57.23) file is not defined"
 S PSERRMSG(3)="0^PRIMARY HFS DIRECTORY in KERNEL SYSTEM PARAMETERS (#8989.3) file is not defined"
 S PSERRMSG(4)="0^DIRECTORY PATH in PPS-N UPDATE CONTROL (#57.23) file is not defined"
 S PSERRMSG(5)="0^REMOTE DIRECTORY ACCESS in PPS-N UPDATE CONTROL (#57.23) file is not defined"
 S PSRC=1
 S PSADDR=$$GET1^DIQ(57.23,1,20) I PSADDR="" S PSRC=PSERRMSG(1) Q
 S PSNUSER=$$GET1^DIQ(57.23,1,22) I PSNUSER="" S PSRC=PSERRMSG(2) Q
 S PSWRKDIR=$$GETD() I PSWRKDIR="" S PSRC=PSERRMSG(3) Q
 S PSLOCDIR=$$GETD() I PSLOCDIR="" S PSRC=PSERRMSG(4) Q
 S PSREMDIR=$$GET1^DIQ(57.23,1,21) I PSREMDIR="" S PSRC=PSERRMSG(5) Q
 S PSCOMFIL="PSNFTP.COM"
 S PSSHFILE="PSNFTP.sh"
 S PSCMDFIL="PSNFTPCMDS.txt"
 S PSLOGFIL="PSNFTP.LOG"
 S PSDATFIL="PSNSFTP.DAT"
 D SAVEKEYS^PSNFTP2(PSWRKDIR)
 ;
 ;VMS
 I +PSOS=1 D
 . D VMSFTP^PSNFTP2(.PSRC,PSADDR,PSNUSER,PSWRKDIR,PSLOCDIR,PSREMDIR,PSREMFIL,PSCOMFIL,PSLOGFIL,PSDATFIL,.PSERRMSG)
 . S PSFILES(PSCOMFIL)="",PSFILES("VSSHID.")="",PSFILES("VSSHKEY.")="",PSFILES("VSSHKEY.PUB")=""
 . I '$$DELFILES(PSWRKDIR,.PSFILES) W !,"File cleanup/delete failed.",!
 ;
 ;Linux
 I +PSOS=3 D
 . S PSLOCDIR=$E(PSLOCDIR,1,($L(PSLOCDIR)-1)) ; chop off trailing /
 . D LINUXFTP^PSNFTP2(.PSRC,PSADDR,PSNUSER,PSWRKDIR,PSLOCDIR,PSREMDIR,PSREMFIL,PSSHFILE,PSLOGFIL,PSDATFIL)
 . S PSFILES(PSSHFILE)="",PSFILES("VSSHKEY")="",PSFILES("uxsshkey")=""
 . I '$$DELFILES(PSWRKDIR,.PSFILES) W !,"File cleanup/delete failed.",!
 ;
 ;Windows
 I +PSOS=2 D
 . S PSLOCDIR=$E(PSLOCDIR,1,($L(PSLOCDIR)-1)) ; chop off trailing \
 . D WINFTP^PSNFTP2(.PSRC,PSADDR,PSUID,PSWRKDIR,PSLOCDIR,PSREMDIR,PSREMFIL,PSCMDFIL,PSLOGFIL)
 . S PSFILES(PSCMDFIL)=""
 . I '$$DELFILES(PSWRKDIR,.PSFILES) WRITE !,"File cleanup/delete failed.",!
 Q
 ;
GETOS() ;Determine OS
 ;Returns: PSOS - local OS
 N PSOS S PSOS=$$OS^%ZOSV()
 S PSOS=$S(PSOS["VMS":"1-VMS",PSOS["NT":"2-MSW",PSOS["UNIX":"3-LINUX",1:"0-")
 Q PSOS
 ;
VMSPING(PSRC,PSADDR,PSWRKDIR,PSCOMFIL,PSLOGFIL) ; PING VMS server to ensure it is available
 ;Inputs: PSRC - return code, by reference
 ;        PSADDR - remote server address
 ;        PSWRKDIR - local work directory name
 ;        PSCOMFIL - .com file name
 ;        PSLOGFIL - log file name
 ;Output: PSRC - populated return code
 ;
 ;check parameters
 I $G(PSADDR)="" S PSRC="0^no target server address" Q
 I $G(PSWRKDIR)="" S PSRC="0^no local work directory name" Q
 I $G(PSCOMFIL)="" S PSRC="0^no .com file name" Q
 I $G(PSLOGFIL)="" S PSRC="0^no log file name" Q
 ; Create .COM file
 N POP
 D OPEN^%ZISH("FILE1",PSWRKDIR,PSCOMFIL,"W")
 I POP S PSRC="0^failed to open ping .com file" Q
 D USE^%ZISUTL("FILE1")
 W "$ SET VERIFY=(PROCEDURE,IMAGE)",!
 W "$ SET DEFAULT "_PSWRKDIR,!
 W "$ TCPIP",!
 W "PING "_PSADDR,!
 W "EXIT",!
 W "$ EXIT 3",!
 D CLOSE^%ZISH("FILE1")
 ; Execute .COM file, create logfile
 N PSZFRC
 S PSZFRC=$ZF(-1,"@"_PSWRKDIR_PSCOMFIL_"/OUTPUT="_PSWRKDIR_PSLOGFIL)
 ; Error check
 I PSZFRC=-1 S PSRC="0^VMS OS command execution failed" Q
 ; Read Logfile into working global, check for error
 K ^TMP("PSNPINGLOG",$J)
 N PSXLOG,PSPNG,PSPNG1
 S PSXLOG=$$FTG^%ZISH(PSWRKDIR,PSLOGFIL,$NAME(^TMP("PSNPINGLOG",$J,1)),3)
 S PSPNG="",PSPNG1=0
 F  S PSPNG=$O(^TMP("PSNPINGLOG",$J,PSPNG)) Q:PSPNG=""  D
 . S PSPNG1=$G(^TMP("PSNPINGLOG",$J,PSPNG))
 . I PSPNG1["0 packets received" S PSRC="0^Remote server - "_PSADDR_" - did not respond"
 . I PSPNG1["%SYSTEM" S PSRC="0^Remote server - "_PSADDR_" - did not respond"
 D DELFILES^PSNFTP2($G(PSWRKDIR),$G(PSLOGFIL),$G(PSCOMFIL),"")
 Q
 ;
LINXPING(PSRC,PSADDR,PSWRKDIR,PSLOGFIL) ; PING Unix/Linux server to ensure it is available
 ;Inputs: PSRC - return code, by reference
 ;        PSADDR - remote server address
 ;        PSWRKDIR - local work directory name
 ;        PSLOGFIL - log file name
 ;Output: PSRC - populated return code
 ;
 ;check parameters
 I PSADDR="" S PSRC="0^no target server address" Q
 I $G(PSWRKDIR)="" S PSRC="0^no local work directory name" Q
 I $G(PSLOGFIL)="" S PSRC="0^no log file name" Q
 ; Execute ping, create logfile
 N PSZFRC
 S PSZFRC=$ZF(-1,"ping -c 4 "_PSADDR_">"_PSWRKDIR_PSLOGFIL)
 ; Error check
 I PSZFRC=-1 S PSRC="0^Linux OS command execution failed" Q
 ; Read Logfile into working global, check for error
 K ^TMP("PSNPINGLOG",$J)
 N PSXLOG,PSPNG,PSPNG1 S PSPNG="",PSPNG1=0
 S PSXLOG=$$FTG^%ZISH(PSWRKDIR,PSLOGFIL,$NAME(^TMP("PSNPINGLOG",$J,1)),3)
 F  S PSPNG=$O(^TMP("PSNPINGLOG",$J,PSPNG)) Q:PSPNG=""  D
 . S PSPNG1=$G(^TMP("PSNPINGLOG",$J,PSPNG))
 . I PSPNG1["0 received" S PSRC="0^Remote server - "_PSADDR_" - did not respond"
 ;D DELFILES^PSNFTP2($G(PSWRKDIR),$G(PSLOGFIL))
 Q
WINPING(PSRC,PSADDR,PSWRKDIR,PSLOGFIL) ; PING server to ensure it is available
 ;Inputs: PSRC - return code, by reference
 ;        PSADDR - remote server address
 ;        PSWRKDIR - local work directory name
 ;        PSLOGFIL - log file name
 ;Output: PSRC - populated return code
 ;
 ;check parameters
 I PSADDR="" S PSRC="0^no target server address" Q
 I $G(PSWRKDIR)="" SET PSRC="0^no local work directory name" Q
 I $G(PSLOGFIL)="" S PSRC="0^no log file name" Q
 ;
 ; Execute ping, create logfile
 N PSZFRC
 S PSZFRC=$ZF(-1,"ping "_PSADDR_">"_PSWRKDIR_PSLOGFIL)
 ; Error check
 I PSZFRC=-1 S PSRC="0^Windows OS command execution failed" Q
 ;
 ; Read Logfile into working global, check for error
 K ^TMP("PSNPINGLOG",$J)
 N PSXLOG
 S PSXLOG=$$FTG^%ZISH(PSWRKDIR,PSLOGFIL,$NAME(^TMP("PSNPINGLOG",$J,1)),3)
 N PSPNG,PSPNG1
 S PSPNG="",PSPNG1=0
 F  S PSPNG=$O(^TMP("PSNPINGLOG",$J,PSPNG)) Q:PSPNG=""  D
 . S PSPNG1=$G(^TMP("PSNPINGLOG",$J,PSPNG))
 . I PSPNG1["Received = 0" S PSRC="0^Remote server - "_PSADDR_" - did not respond"
 ; 
 Q
MAILFTP(PSMSGTYP,PSFILE,PSSIZE,PSERRMSG) ; mail message to notify users of the NDF Update File download status
 ;Inputs: PSMSGTYP - message type - 1=file downloaded, 0=error
 ;        PSFILE - file name
 ;        PSSIZE - file size
 ;        PSERRMSG - error message
 ;
 N XMDUZ,XMSUB,XMTEXT,XMY,XMZ,PSMSGTXT,PSGRP
 I PSERRMSG'="" D UPDTCTRL D
 . N CTRLIEN,CTRLXIEN
 . S CTRLIEN=$O(^PS(57.23,"B","PPSN",""))
 . S CTRLXIEN=$O(^PS(57.23,1,4,"B",PSREMFIL,""),-1)
 . S FDA(57.234,CTRLXIEN_","_"1,",4)=PSERRMSG
 . D UPDATE^DIE("","FDA","CTRLIEN")
 ;
 ;SETUP PRODUCTION OR SQA
 S PSNPS=$P($G(^PS(59.7,1,10)),"^",12)
 S XMSUB="",XMDUZ="noreply@domain.ext"
 I PSMSGTYP D
 . ;I PSNPS'="" I PSNPS="P"!(PSNPS="S")!(PSNPS="T") 
 . S XMSUB="PPS-N/NDF File "_PSFILE_$S(PSSIZE="":"was not",1:"")_" DOWNLOADED"
 . I PSNPS'="" I PSNPS="Q" S XMSUB="PPS-N/NDF File "_PSFILE_$S(PSSIZE="":"was not",1:"")_" DOWNLOADED FOR QA"
 . I PSSIZE="" D MSGTEXT0(PSFILE,PSSIZE,"File could not be downloaded.") Q
 . D MSGTEXT1(PSFILE,PSSIZE,.PSMSGTXT)
 I 'PSMSGTYP D
 . S XMSUB="ERROR: PPS-N/NDF File "_PSFILE_" "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 . D MSGTEXT0(PSFILE,PSERRMSG,.PSMSGTXT)
 S XMTEXT="PSMSGTXT("
 S DA=0 F  S DA=$O(^XUSEC("PSNMGR",DA)) Q:'DA  S XMY(DA)=""
 S PSGRP=$$GET1^DIQ(57.23,1,5) I PSGRP'="" S XMY($$MG^PSNPPSMG(PSGRP))="" ;PRIMARY PPS-N MAIL GROUP
 S PSGRP="",PSGRP=$$GET1^DIQ(57.23,1,6) I PSGRP'="" S XMY($$MG^PSNPPSMG(PSGRP))="" ;SECONDARY MAIL GROUP
 D ^XMD
 Q
 ;
MSGTEXT0(PSFILE,PSERRMSG,PSMSGTXT) ;build message text
 ;Inputs: PSFILE - file name
 ;        PSERRMSG - error message
 ;        PSMSGTXT - array reference for message text
 ;Output: populated PSMSGTXT
 ;
 S PSMSGTXT(1)="**************************************************************************"
 S PSMSGTXT(2)="*** An error occurred during download of the following Update file(s): ***"
 S PSMSGTXT(3)="**************************************************************************"
 S PSMSGTXT(4)="The following file(s) could not be downloaded:"
 S PSMSGTXT(5)=""
 S PSMSGTXT(6)="      Update file Name"
 S PSMSGTXT(7)="      -------------------"
 S PSMSGTXT(8)="      "_PSFILE
 S PSMSGTXT(9)=""
 S PSMSGTXT(10)="An error occurred for:"
 S PSMSGTXT(11)="               File: "
 S PSMSGTXT(12)="                IEN: "
 S PSMSGTXT(13)="         Entry Name: "
 S PSMSGTXT(14)="Update file section: "
 S PSMSGTXT(15)=""
 S PSMSGTXT(16)="Error Message: "_PSERRMSG_"."
 S PSMSGTXT(17)=""
 S PSMSGTXT(18)="How to correct your error:"
 S PSMSGTXT(19)="1.    Validate that the PPS-N Site Parameters settings are correct."
 S PSMSGTXT(20)="2.    Validate that PRV version above is the version installed locally."
 S PSMSGTXT(21)="3.    Rerun the download option to re-attempt retrieval."
 S PSMSGTXT(22)="4.    Contact the National Help Desk or enter a ticket."
 S PSMSGTXT(23)=""
 S PSMSGTXT(24)="Further details can be found on the Download/Install Status Report option."
 Q
 ;
MSGTEXT1(PSFILE,PSSIZE,PSMSGTXT) ;build message text
 ;Inputs: PSFILE - file name
 ;        PSSIZE - file size
 ;        PSMSGTXT - array reference for message text
 ;Output: populated PSMSGTXT
 ;
 S PSMSGTXT(1)="The PPS-N/NDF file "_PSFILE_" (Size "_PSSIZE_$S(PSSIZE["MB":"",1:" bytes")_")"
 S PSMSGTXT(2)="has been DOWNLOADED and is available for installation via the scheduled"
 S PSMSGTXT(3)="or manual process utilized at your site.  The following VistA options will"
 S PSMSGTXT(4)="be placed out of order while the NDF Update file is installed: Print PMI"
 S PSMSGTXT(5)="Sheet, Patient Prescription Processing, Release Medication, and Reprint"
 S PSMSGTXT(6)="an Outpatient Rx label."
 Q
 ;
 ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>> SFTP COMMANDS FILE <<<<<<<<<<<<<<<<<<<<<<<<<<
CREATDAT(PSRC,PSDATFIL,PSWRKDIR,PSREMDIR,PSREMFIL) ; create .dat file with sftp commands - "PSNSFTP.DAT"
 N POP
 D OPEN^%ZISH("FILE1",PSWRKDIR,PSDATFIL,"W")
 I POP S PSRC="0^failed to open sftp .dat file" Q
 D USE^%ZISUTL("FILE1")
 W "cd ",PSREMDIR,!
 I +PSOS'=3 W "ascii",!
 W "get ",PSREMFIL,!
 W "exit",!
 D CLOSE^%ZISH("FILE1")
 Q
 ;
DELFILES(PSDIR,PSFILES) ;Delete Local Host File, any OS
 ;Inputs: PSDIR - directory (path) name - in proper format of OS, including trailing / or \
 ;        PSFILES - array of file names, by reference
 ;          Ex: PSFILES("FILE1.DAT")=""
 ;Returns:
 ;    1-Success for all deletions.
 ;    0-Failure on at least one deletion.
 ;
 N PSRC
 S PSRC=$$DEL^%ZISH(PSDIR,$NAME(PSFILES))
 Q PSRC
 ;
LINUXDEL(PSRC,PSDIR,PSFILE) ;Delete Local Host File
 ;Inputs: PSRC - return code, by reference
 ;        PSDIR - directory name
 ;        PSFILE - file name
 ;Output: PSRC - populated return code
 ;
 ;check parameters
 I $G(PSDIR)="" S PSRC="0^no directory name" Q
 I $G(PSFILE)="" S PSRC="0^no file name" Q
 S PSZFRC=$ZF(-1,"rm -f "_PSDIR_PSFILE)
 I PSZFRC=-1 S PSRC="0^Linux OS command execution failed" Q
 Q
 ;
GETD() ; get the right directory based on OS type
 N CDIR,PSOSX S CDIR=""
 S PSOSX=$$OS^%ZOSV()
 I PSOSX["VMS" S CDIR=$$GET1^DIQ(57.23,1,1)
 I PSOSX["UNIX" S CDIR=$$GET1^DIQ(57.23,1,3)
 Q CDIR
 ;
UPDTCTRL ;
 K CTRLIEN S CTRLIEN=$O(^PS(57.23,"B","PPSN",""))
 K FDA S FDA(57.234,"+2,"_1_",",.01)=PSREMFIL D UPDATE^DIE("","FDA")
 K CTRLXIEN S CTRLXIEN=$O(^PS(57.23,1,4,"B",PSREMFIL,""),-1)
 K FDA S FDA(57.234,CTRLXIEN_","_CTRLIEN_",",1)=PSNDNLDB
 D NOW^%DTC
 S FDA(57.234,CTRLXIEN_","_CTRLIEN_",",2)=%
 S FDA(57.234,CTRLXIEN_","_CTRLIEN_",",3)=PSSIZE
 I $G(PSERRMSG)'="" S FDA(57.234,CTRLXIEN_","_CTRLIEN_",",4)=PSERRMSG
 D UPDATE^DIE("","FDA","CTRLIEN")
 S ^PS(57.23,1,4,"G",PSREMFIL)=$G(^PS(57.23,1,4,"G",PSREMFIL))+1
 S ^PS(57.23,1,4,"G",PSREMFIL,CTRLXIEN)=$G(^PS(57.23,1,4,"G",PSREMFIL))
 K FDA S FDA(57.23,CTRLIEN_",",30)=1 D FILE^DIE("","FDA") K FDA
 Q
 ;
