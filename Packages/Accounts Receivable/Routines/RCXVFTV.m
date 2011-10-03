RCXVFTV ;DAOU/ALA-FTP for VMS ;08-SEP-03
 ;;4.5;Accounts Receivable;**201,227**;Mar 20, 1995
 ;
 ;
VMSO ;  Outgoing for VMS systems
 ;
 ;  Set up variables
 ;    RCXVFTP = Executable filename
 ;    RCXVPTH = Path name
 ;    RCXVNME = Outgoing filename
 ;    RCXVTXT = .TXT filename
 ;    RCXVBAT = .COM filename
 ;
 D VTXT
 ;
 S Y=$$GTF^%ZISH($NA(^TMP($J,"RCXVFTP",1,0)),3,RCXVPTH,RCXVBAT)
 K ^TMP($J,"RCXVFTP")
 I 'Y S VALMSG="Not able to create the .COM file" Q
 ;
VOBAT ;  Output and create the .COM file
 ;
 ;  Create the executable commands for the .TXT file
 S ^TMP($J,"RCXVFTP",1,0)="SET TYPE ASCII"
 S ^TMP($J,"RCXVFTP",2,0)="PUT "_RCXVNME
 S ^TMP($J,"RCXVFTP",3,0)="EXIT"
 ;
 ;  Output and create the .TXT file
 S Y=$$GTF^%ZISH($NA(^TMP($J,"RCXVFTP",1,0)),3,RCXVPTH,RCXVTXT)
 K ^TMP($J,"RCXVFTP")
 I 'Y S VALMSG="Not able to create the .TXT file" Q
 ;
 X RCXVOUT
 ;
 HANG 60
 ;
 Q
 ;
VTXT ;  Create the .TXT file
 S RCXVFTP="RCXVCBO"
 S RCXVSCR=RCXVSCR_".LIS",^TMP("RCXVMSG",$J,RCXVSCR_";1")=""
 S RCXVBAT=RCXVFTP_$S($G(RCXVSYS)="VMS":".COM",1:".BAT")
 S RCXVTXT=RCXVFTP_".TXT"
 ;
 I RCXVSYT="DSM" S RCXVOUT="S X=$ZC(%SUBMIT,RCXVPTH_$S($E(RCXVPTH,$L(RCXVPTH))[""]"":"""",1:"":"")_RCXVBAT)"
 I RCXVSYT="CACHE" S RCXVOUT="S X=$ZF(-1,""SUBMIT ""_RCXVPTH_$S($E(RCXVPTH,$L(RCXVPTH))[""]"":"""",1:"":"")_RCXVBAT_""/NOLOG_FILE/NOPRINT"")"
 ;
 I $G(RCXVVMS)="" S RCXVVMS="U"
 ;
 ;  Kill off the .COM and .TXT files
 S RCXVARRY(RCXVTXT)="",RCXVARRY(RCXVBAT)=""
 S Y=$$DEL^%ZISH(RCXVPTH,$NA(RCXVARRY))
 K RCXVARRY
 ;
 ;  This sets the .COM file name for VMS systems
 I RCXVSYS="VMS" D
 . S ^TMP($J,"RCXVFTP",1,0)="$SET NOON"
 . S ^TMP($J,"RCXVFTP",2,0)="$SET NOVERIFY"
 . S ^TMP($J,"RCXVFTP",3,0)="$SET DEFAULT "_RCXVPTH
 . S ^TMP($J,"RCXVFTP",4,0)="$DEL "_RCXVSCR_";*"
 . S ^TMP($J,"RCXVFTP",5,0)="$DEF SYS$OUTPUT "_RCXVSCR
 . I RCXVVMS="M" S ^TMP($J,"RCXVFTP",6,0)="FTP /TAKE_FILE="_RCXVTXT
 . I RCXVVMS="U" S ^TMP($J,"RCXVFTP",6,0)="FTP "_RCXVIP_" /USERNAME="""_RCXVUSR_""" /PASSWORD="""_RCXVPAS_""" /INPUT="_RCXVTXT
 . S ^TMP($J,"RCXVFTP",7,0)="$DEASSIGN SYS$OUTPUT"
 . S ^TMP($J,"RCXVFTP",8,0)="$SET FILE/PROTECTION=(S:RWED,O:RWED,G:RWED,W:RWED) "_RCXVSCR
 ;
 Q
