RCXVFTC ;DAOU/ALA-FTP for Cache NT ;16-DEC-2003
 ;;4.5;Accounts Receivable;**201**;Mar 20, 1995
 ;
OUT ;  Outgoing
 D CTXT
 ;
 S Y=$$GTF^%ZISH($NA(^TMP($J,"RCXVFTP",1,0)),3,RCXVPTH,RCXVBAT)
 K ^TMP($J,"RCXVFTP")
 I 'Y S VALMSG="Not able to create the .COM file" Q
 ;
BAT ;  Create the .COM file
 S RCXVOUT="S X=$ZF(-1,""ftp -n -s:""_RCXVPTH_RCXVBAT_"">""_RCXVPTH_RCXVSCR)"
 ;
 X RCXVOUT
 ;
 Q
 ;
CTXT ;
 S RCXVFTP="RCXVCBO"
 S RCXVSCR=RCXVSCR_".LIS",^TMP("RCXVMSG",$J,RCXVSCR)=""
 S RCXVBAT=RCXVFTP_$S($G(RCXVSYS)="VMS":".COM",1:".BAT")
 S RCXVTXT=RCXVFTP_".TXT"
 ;
 ;  Kill off the .COM and .TXT files
 S RCXVARRY(RCXVTXT)="",RCXVARRY(RCXVBAT)=""
 S Y=$$DEL^%ZISH(RCXVPTH,$NA(RCXVARRY))
 K RCXVARRY
 ;
 S ^TMP($J,"RCXVFTP",1,0)="open "_RCXVIP
 S ^TMP($J,"RCXVFTP",2,0)="user "_RCXVUSR_" "_RCXVPAS
 ;
 ;  A root directory must have a slash for CACHE NT
 ;  but a folder cannot have a slash
 I RCXVPTH?1A1":\" S RCXVROOT=$E(RCXVPTH,1,$L(RCXVPTH))
 I RCXVPTH'?1A1":\" S RCXVROOT=$S($E(RCXVPTH,$L(RCXVPTH),$L(RCXVPTH))="\":$E(RCXVPTH,1,$L(RCXVPTH)-1),1:RCXVPTH)
 ;
 S ^TMP($J,"RCXVFTP",3,0)="lcd "_RCXVROOT
 S ^TMP($J,"RCXVFTP",4,0)="put "_RCXVNME
 S ^TMP($J,"RCXVFTP",5,0)="quit"
 Q
