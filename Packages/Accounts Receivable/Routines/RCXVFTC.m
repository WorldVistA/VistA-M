RCXVFTC ;DAOU/ALA-FTP for Cache NT ; 10/10/12 11:54am
 ;;4.5;Accounts Receivable;**201,292,395**;Mar 20, 1995;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;SAC EXEMPTION 20220504-01: Allows the use of the $ZF(-100) function.
 ;
OUT ;  Outgoing
 D SAVEKEYS ;added in PRCA*4.5*395 to get SSH KEY for SFTP 
 D CTXT
 ;
 S Y=$$GTF^%ZISH($NA(^TMP($J,"RCXVFTP",1,0)),3,RCXVPTH,RCXVBAT)
 K ^TMP($J,"RCXVFTP")
 I 'Y S VALMSG="Not able to create the .COM file" Q
 ;
BAT ;  Create the .COM file
 ;S RCXVOUT="S X=$ZF(-1,""ftp -n -s:""_RCXVPTH_RCXVBAT_"">""_RCXVPTH_RCXVSCR)"
 ;updated to IF statement in PRCA*4.5*395 to handle non-UNIX systems
 I RCXVSYS'["UNIX" D
 .S RCXVOUT="S X=$ZF(-1,""ftp -n -s:""_RCXVPTH_RCXVBAT_"">""_RCXVPTH_RCXVSCR)"
 .X RCXVOUT
 .Q
 ;
 ;  For Full Linux OS, PRCA*4.5*395 CHANGES FTP TO SFTP
 I RCXVSYS["UNIX" D
 .S RCXVOUT=$ZF(-100,"","sftp","-o StrictHostKeyChecking no","-i",RCXVPTH_"sftpsshkey_"_$J,"-b",RCXVPTH_RCXVBAT,RCXVUSR_"@"_RCXVIP)
 .I RCXVOUT=0 D
 ..D OPEN^%ZISH(RCXVSCR,RCXVDIR,RCXVSCR,"W")
 ..D USE^%ZISUTL(RCXVSCR)
 ..W "226_SFTP return status ="_RCXVOUT,! ;226 is a successful transmission indicator used in RCXVFTR transfer status routine
 ..D CLOSE^%ZISH(RCXVSCR)
 ..Q
 .I RCXVOUT'=0 D
 ..D OPEN^%ZISH(RCXVSCR,RCXVDIR,RCXVSCR,"W")
 ..D USE^%ZISUTL(RCXVSCR)
 ..W "SFTP failed, status ="_RCXVOUT,!
 ..D CLOSE^%ZISH(RCXVSCR)
 ..Q
 .Q
 ;. S RCXVOUT="S X=$ZF(-1,""ftp -n -v <""_RCXVPTH_RCXVBAT_"">""_RCXVPTH_RCXVSCR)"
 ;
 ;X RCXVOUT
 D DELK
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
 ; S ^TMP($J,"RCXVFTP",1,0)="open "_RCXVIP
 ; S ^TMP($J,"RCXVFTP",2,0)="user "_RCXVUSR_" "_RCXVPAS
 ;
 ;  A root directory must have a slash for CACHE NT
 ;  but a folder cannot have a slash
 I RCXVPTH?1A1":\" S RCXVROOT=$E(RCXVPTH,1,$L(RCXVPTH))
 I RCXVPTH'?1A1":\" S RCXVROOT=$S($E(RCXVPTH,$L(RCXVPTH),$L(RCXVPTH))="\":$E(RCXVPTH,1,$L(RCXVPTH)-1),1:RCXVPTH)
 ;
 ;PRCA*4.5*395 used for FTP .BAT file build
 I RCXVSYS'["UNIX" D
 .S ^TMP($J,"RCXVFTP",1,0)="open "_RCXVIP
 .S ^TMP($J,"RCXVFTP",2,0)="user "_RCXVUSR_" "_RCXVPAS
 .S ^TMP($J,"RCXVFTP",3,0)="lcd "_RCXVROOT
 .S ^TMP($J,"RCXVFTP",4,0)="put "_RCXVNME
 .S ^TMP($J,"RCXVFTP",5,0)="quit"
 .Q
 ;
 ;PRCA*4.5*395 used for SFTP .BAT file build
 I RCXVSYS["UNIX" D
 .S ^TMP($J,"RCXVFTP",1,0)="lcd "_RCXVROOT
 .S ^TMP($J,"RCXVFTP",2,0)="put "_RCXVNME
 .S ^TMP($J,"RCXVFTP",3,0)="quit"
 .Q
 Q
 ;
SAVEKEYS ;PRCA*4.5*395 retrieves the private key from the database and builds it in the appropriate host file.
 N WLINE,RCXVPV,RCXVPRKY,RCXVPRM
 D GETWP^XPAR(.RCXVPRKY,"PKG","PRCA SFTP","SFTP SSH PRIVATE KEY") ; get private key 
 ;
 I $$OS^%ZOSV()["UNIX" D  Q
 .; Building the Private SSH Key host file
 .D OPEN^%ZISH("sftpsshkey",RCXVDIR,"sftpsshkey_"_$J,"W")
 .D USE^%ZISUTL("sftpsshkey")
 .F WLINE=1:1 Q:'$D(RCXVPRKY(WLINE,0))  W $$DECRYP^XUSRB1(RCXVPRKY(WLINE,0)),!
 .D CLOSE^%ZISH("sftpsshkey")
 .S RCXVPRM=$ZF(-100,"","chmod","600",RCXVPTH_"sftpsshkey_"_$J)
 .Q
 ;
 Q
 ;
DELK ; PRCA*4.5*395 Delete the ssh private key file - sftpsshkey_$J
 N RCXVARRY,Y
 S RCXVARRY("sftpsshkey_"_$J)=""
 S Y=$$DEL^%ZISH(RCXVDIR,$NA(RCXVARRY))
 Q
 ;
