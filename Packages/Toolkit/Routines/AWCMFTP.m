AWCMFTP ;VISN 7/THM-FTP FILES TO SERVER from VISTA ; Feb 27, 2004
 ;;7.3;TOOLKIT;**84,86,103**;Jan 09, 2004;Build 4
 ;
 W *7,!,"Enter at line EN^AWCMFTP.",!
 Q
EN ; variables killed in calling program
 S VMSC=""                                            ;INIT THE VAR
 ; AWCHFIL1= whole VMS path
 S AWCHFILE="AWCMOVEHTM.COM"                          ;COM file name
 I AWCX="NT" S AWCHFILE=AWCFILE
 S AWCDTAX=$G(^AWC(177100.12,1,0))
 S AWCDIR=$P(AWCDTAX,U,5)             ;Parameter file
 S:AWCDIR="" AWCDIR="SYS$SYSDEVICE:[DSMMGR]"          ;DEFAULT
 S AWCSITE=$$SITE^VASITE,AWCSITE=$P(AWCSITE,U,2)      ;site Name
 S AWCSITEN=+$$SITE^VASITE                            ;3 dig number
 S AWCDIRL=$$LOW^XLFSTR(AWCDIR),AWCHFILL=$$LOW^XLFSTR(AWCHFILE)
 S AWCWBFLD=$P(AWCDTAX,U,15),AWCWBFLD=$$LOW^XLFSTR(AWCWBFLD) ;web page folder
 ; Note: file deletion is not a problem for NT/Cache since it overwrites the files
 S AWCMVMSL=+$P(AWCDTAX,U,16) ;VMS logging
 S AWCMVMSD=+$P(AWCDTAX,U,18) ;VMS delete
 S AWCDIRCH=+$P(AWCDTAX,U,19) ;use change dir command?
 S AWCWBFLD=$P(AWCWBFLD,"/",2)
 D @AWCX
 Q
 ;
NT ; NT script
 S AWCC=1
 K ^TMP("AWCMFTP",$J)
 S ^TMP("AWCMFTP",$J,AWCC,0)="open "_AWCMSRV,AWCC=AWCC+1 ;server ip address
 S ^TMP("AWCMFTP",$J,AWCC,0)=AWCMUSR,AWCC=AWCC+1 ; ftp user
 S ^TMP("AWCMFTP",$J,AWCC,0)=AWCMPW,AWCC=AWCC+1  ;ftp password
 S ^TMP("AWCMFTP",$J,AWCC,0)="ascii",AWCC=AWCC+1
 I $G(AWCDIRCH)=1 S ^TMP("AWCMFTP",$J,AWCC,0)="cd "_AWCWBFLD,AWCC=AWCC+1 ;****
 S ^TMP("AWCMFTP",$J,AWCC,0)="put "_AWCDIRL_"\"_AWCHFILE,AWCC=AWCC+1 ;****
 S ^TMP("AWCMFTP",$J,AWCC,0)="bye"
 ; write it to the NT directory
 S Y=$$GTF^%ZISH($NA(^TMP("AWCMFTP",$J,1,0)),3,AWCDIRL,"ftpawc.txt")
 ; send command to NT to execute this batch file
 S CMD="S AWCVAR=$ZF(-1,""ftp -s:""_AWCDIRL_""\ftpawc.txt"")"
 X CMD G EXIT
 ;
VMSC ; VMS FOR CACHE MODS TO DOUBLE CHECK FOR OS
 S VMSC=1
 ;
VMS ; VMS com file script
 ; Captive process so we give full privs
 S AWC=1
 K ^TMP("AWCMFTP",$J)
 S ^TMP("AWCMFTP",$J,AWC,0)="$ set proc/priv = all"
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="$ set noon"
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="$ assign sys$command sys$input "
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="$ set verify"
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="$ a=""''f$user()'"""
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="$ set def "_AWCDIR
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="$ set prot=(w:rwed,g:rwed,o:rwed,s:rwed) "_AWCDIR_AWCHFILE
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="$ ftp "_AWCMSRV
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)=AWCMUSR
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)=AWCMPW
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="ascii"
 I $G(AWCDIRCH)=1 S ^TMP("AWCMFTP",$J,AWC,0)="cd "_AWCWBFLD ;****
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="put "_AWCHFIL1
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="bye"
 S AWC=AWC+1,^TMP("AWCMFTP",$J,AWC,0)="$ exit"
 ; send to VMS
 S Y=$$GTF^%ZISH($NA(^TMP("AWCMFTP",$J,1,0)),3,AWCDIR,AWCHFILE)
 G:VMSC VMSC1
 ;
 ; USE $&ZLIB EXTERNAL CALLS FOR DSM/VMS
 S CMD="S %SUBMIT=$&ZLIB.%SUBMIT"_"("""_AWCDIR_AWCHFILE_""""_","_"""/NOPRINT"_$S(AWCMVMSL=1:"/LOG="_AWCDIR_$P(AWCHFILE,".",1)_".LOG"""_")",1:"/NOLOG"""_")")
 X CMD
 G EXIT
VMSC1 ;
 ; VMS Cache - use $ZF(-1 calls for OS commands
 S CMD="S AWCVAR=$ZF(-1,AWCVAR)"
 S AWCVAR="SUBMIT "_AWCDIR_AWCHFILE_"/NOPRINT"_$S(AWCMVMSL=1:"/LOG="_AWCDIR_$P(AWCHFILE,".",1)_".LOG",1:"/NOLOG")
 X CMD
 ;
EXIT K CMD,^TMP("AWCMFTP"),^TMP("AWCMFTPD"),AWCMVMSL,AWCMVMSD,AWCDTAX,AWC,AWCDIRCH
 Q
 ;
PURDEL ; purging/deletion script - whether this occurs is controlled in file 177100.12
 ; this part creates a com file to purge or delete files we have created and then it deletes itself
 ;
 S AWCDTAX=$G(^AWC(177100.12,1,0))
 S AWCMVMSL=+$P(AWCDTAX,U,16) ;VMS logging
 S AWCMVMSD=+$P(AWCDTAX,U,18) ;VMS delete
 S AWCHFILE="AWCPURGE.COM"
 ; captive process again so we give full privs
 K ^TMP("AWCMFTPD",$J)
 S AWC=1,^TMP("AWCMFTPD",$J,AWC,0)="$ wait 00:05"
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ set proc/priv = all"
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ set noon"
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ assign sys$command sys$input "
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ set verify"
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ a=""''f$user()'"""
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ set def "_AWCDIR
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ set prot=(w:rwed,g:rwed,o:rwed,s:rwed) "_AWCDIR_"AWCMOVEHTM.LOG;*"
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ set prot=(w:rwed,g:rwed,o:rwed,s:rwed) "_AWCDIR_"AWCMOVEHTM.COM;*"
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ set prot=(w:rwed,g:rwed,o:rwed,s:rwed) "_AWCHFIL1_";*"
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ set prot=(w:rwed,g:rwed,o:rwed,s:rwed) "_AWCDIR_"AWCPURGE.COM;*"
 ; purge or keep log files - 0 deletes all, 1 leaves one copy
 I AWCMVMSL=1 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ purge/keep=1 "_AWCDIR_"AWCMOVEHTM.LOG"
 I AWCMVMSL=0 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ delete "_AWCDIR_"AWCMOVEHTM.LOG;*"
 ; purge or delete all COM versions - 0 deletes all, 1 leaves one copy
 I AWCMVMSD=1 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ delete "_AWCDIR_"AWCMOVEHTM.COM;*"
 I AWCMVMSD=0 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ purge/keep=1 "_AWCDIR_"AWCMOVEHTM.COM;*"
 ; delete the web pages - automatic, not user controlled
 ; patch 103 change for RDPC environment  jls/oak-oifo 10/2006
 ;S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ delete "_$P(AWCHFIL1,"_",1)_"*.*;*"
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ delete "_AWCDIR_$P(AWCDTAX,U,6)_"*.*;*"
 S AWC=AWC+1,^TMP("AWCMFTPD",$J,AWC,0)="$ exit"
 ; send to VMS
 S Y=$$GTF^%ZISH($NA(^TMP("AWCMFTPD",$J,1,0)),3,AWCDIR,AWCHFILE)
 I AWCX="VMS" S CMD="S %SUBMIT=$&ZLIB.%SUBMIT"_"("""_AWCDIR_AWCHFILE_""""_","_"""/DELETE /NOPRINT /NOLOG"""_")"
 I AWCX="VMSC" S CMD="S AWCVAR=$ZF(-1,AWCVAR)"
 I AWCX="VMSC" S AWCVAR="SUBMIT "_AWCDIR_AWCHFILE_"/DELETE /NOPRINT /NOLOG"
 X CMD
 Q
