AWCMFTP1 ;VISN7/THM-FTP FILES TO NATIONAL ROLL-UP SERVER from VISTA ; Feb 27, 2004
 ;;7.3;TOOLKIT;**84,86**;Jan 09, 2004
 ;
 W *7,!,"Enter at line EN^AWCMFTP1.",!
 Q
EN ; variables killed in calling program
 S VMSC=""                                            ;INIT THE VAR
 S AWCHFILE="AWCMOVESTAT.COM"                          ;COM file name
 I AWCX="NT" S AWCHFILE=AWCFILE
 S AWCDTAX=$G(^AWC(177100.12,1,0))
 S AWCDIR=$P(AWCDTAX,U,5)             ;Parameter file
 S:AWCDIR="" AWCDIR="SYS$SYSDEVICE:[DSMMGR]"          ;DEFAULT
 S AWCSITE=$$SITE^VASITE,AWCSITE=$P(AWCSITE,U,2)      ;site Name
 S AWCSITEN=+$$SITE^VASITE                            ;3 dig number
 S AWCDIRL=$$LOW^XLFSTR(AWCDIR),AWCHFILL=$$LOW^XLFSTR(AWCHFILE)
 S AWCDTX=$G(^AWC(177100.12,1,1))
 S AWCWBFLD=$P(^AWC(177100.12,1,0),U,15),AWCWBFLD=$$LOW^XLFSTR(AWCWBFLD) ;web page folder
 S AWCMVMSL=$P(AWCDTAX,U,16) ;VMS logging on or off
 S AWCMVMSD=$P(AWCDTAX,U,18) ;DELETE COM files on or off
 S AWCWBFLD=$P(AWCWBFLD,"/",2)
 S AWCDIRCH=+$P(AWCDTAX,U,19) ;use change dir command?
 S AWCMSRV=$P(AWCDTX,U,6),AWCMUSR=$P(AWCDTX,U,7),AWCMPW=$P(AWCDTX,U,8)
 D @AWCX
 Q
 ;
NT S AWCC=1
 K ^TMP("AWCMFTP1",$J)
 S ^TMP("AWCMFTP1",$J,AWCC,0)="open "_AWCMSRV,AWCC=AWCC+1 ;server ip address
 S ^TMP("AWCMFTP1",$J,AWCC,0)=AWCMUSR,AWCC=AWCC+1 ; ftp user
 S ^TMP("AWCMFTP1",$J,AWCC,0)=AWCMPW,AWCC=AWCC+1  ;ftp password
 S ^TMP("AWCMFTP1",$J,AWCC,0)="ascii",AWCC=AWCC+1
 S ^TMP("AWCMFTP1",$J,AWCC,0)="put "_AWCDIRL_"\"_AWCHFILE,AWCC=AWCC+1
 S ^TMP("AWCMFTP1",$J,AWCC,0)="bye"
 ; write it to the NT directory
 S Y=$$GTF^%ZISH($NA(^TMP("AWCMFTP1",$J,1,0)),3,AWCDIRL,"ftpstatawc.txt")
 ; send command to NT to execute this batch file
 S CMD="S AWCVAR=$ZF(-1,""ftp -s:"_AWCDIRL_"\ftpstatawc.txt"")" X CMD
 G EXIT
 ;
VMSC ; VMS FOR CACHE MODS TO DOUBLE CHECK FOR OS
 S VMSC=1
 ;
VMS K ^TMP("AWCMFTP1",$J)
 S AWC=1,^TMP("AWCMFTP1",$J,AWC,0)="$ set noon"
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ set proc/priv = all"
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ assign sys$command sys$input "
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ set verify"
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ a=""''f$user()'"""
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ set def "_AWCDIR
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ set prot=(w:rwed,g:rwed,o:rwed,s:rwed) "_AWCDIR_AWCHFILE
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ ftp "_AWCMSRV
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)=AWCMUSR
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)=AWCMPW
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="ascii"
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="put "_AWCHFIL1
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="bye"
 ; purge or keep log files after FTP
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ wait 00:01"
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ set prot=(w:rwed,g:rwed,o:rwed,s:rwed) "_AWCDIR_AWCHFILE_";*"
 I AWCMVMSL=1 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ purge/keep=1 "_AWCDIR_"AWCMOVESTAT.LOG"
 I AWCMVMSL=0 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ delete "_AWCDIR_"AWCMOVESTAT.LOG;*"
 ; purge or delete all web page versions after FTP
 I AWCMVMSD=1 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ delete "_AWCDIR_AWCHFILE_";*"
 I AWCMVMSD=0 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ purge/keep=1 "_AWCDIR_AWCHFILE
 ; delete the stat text file - automatic,not user controlled
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ delete CPRSstats*.*;*"
 S AWC=AWC+1,^TMP("AWCMFTP1",$J,AWC,0)="$ exit"
 ; send to VMS
 S Y=$$GTF^%ZISH($NA(^TMP("AWCMFTP1",$J,1,0)),3,AWCDIR,AWCHFILE)
 G:VMSC VMSC1
 ; USE $&ZLIB EXTERNAL CALLS FOR DSM
 S CMD="S %SUBMIT=$&ZLIB.%SUBMIT"_"("""_AWCDIR_AWCHFILE_""""_","_"""/NOPRINT"_$S(AWCMVMSL=1:"/LOG="_AWCDIR_"AWCMOVESTAT.LOG"""_")",1:"/NOLOG"""_")")
 X CMD
 G EXIT
VMSC1 ;
 ; vms cache
 ; USE $ZF CALLS FOR OS COMMANDS IN CACHE
 S CMD="S AWCVAR=$ZF(-1,AWCVAR)"
 S AWCVAR="SUBMIT "_AWCDIR_AWCHFILE_"/NOPRINT"_$S(AWCMVMSL=1:"/LOG="_AWCDIR_"AWCMOVESTAT.LOG",1:"/NOLOG")
 X CMD
 ;
EXIT ;
 K CMD,^TMP("AWCMFTP1",$J),AWCMVMSL,AWCMVMSD,AWCDTAX,AWCDTX,AWC,AWCMANL
 Q
