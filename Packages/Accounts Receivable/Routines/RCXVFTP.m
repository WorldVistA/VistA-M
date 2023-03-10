RCXVFTP ;DAOU/ALA-FTP AR Data Extract Batch Files ;08-SEP-03
 ;;4.5;Accounts Receivable;**201,256,292,395**;Mar 20, 1995;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This code will ftp a batch file
 ;
EN(FILE,DIREC) ;
 ;  Input Parameter
 ;    FILE = Filename
 ;    DIREC = Directory
 S RCXVPTH=$S($G(DIREC)'="":DIREC,1:RCXVDIR)
 ;
SYS ;  Get system type
 S RCXVSYS=$$VERSION^%ZOSV(1)
 I RCXVSYS["DSM" S RCXVSYS="VMS",RCXVSYT="DSM"
 I RCXVSYS["MSM" D
 . I RCXVSYS["NT"!(RCXVSYS["PC") S RCXVSYS="MSM",RCXVSYT="MSM" Q
 . E  S RCXVSYS="UNIX",RCXVSYT="MSM"
 I RCXVSYS["Cache" D
 . I RCXVSYS["VMS" S RCXVSYS="VMS",RCXVSYT="CACHE" Q
 . ; For Full Linux OS
 . I RCXVSYS["UNIX" S RCXVSYS="UNIX",RCXVSYT="CACHE" Q
 . S RCXVSYS="CACHE",RCXVSYT="CACHE"
 ;
 I RCXVSYS="VMS" S RCXVNME=FILE_";1"
 I RCXVSYS'="VMS" S RCXVNME=FILE
 ;
ARC ;  Directly FTP to the Boston Allocation Resource Center
 ; PRCA*4.5*395 updates receiving server location
 ; get the SFTP gateway server information
 I $$GET1^DIQ(342,"1,",20.06,"I")="P" D 
 . D GETWP^XPAR(.RCXVIP,"PKG","PRCA SFTP","SFTP SERVER")
 . D GETWP^XPAR(.RCXVUSR,"PKG","PRCA SFTP","SFTP USERNAME")
 . Q
 ;
 ;. S RCXVIP="MORPHEUS.ARC.DOMAIN.EXT"
 ;. S RCXVUSR="mccf"
 ;. S RCXVPAS="1qaz2wsx" 
 S RCXVPAS="1qaz2wsx" ;PRCA*4.5*395 old FTP password for previous receiving site !!!may move to CTXT^RCXVFTC where it is used if we do away with 'P statement!!!
 ;
 I $$GET1^DIQ(342,"1,",20.06,"I")'="P" D
 . S RCXVIP="MORPHEUS.ARC.DOMAIN.EXT"
 . S RCXVUSR="cbotest1"
 . S RCXVPAS="1qaz2wsx"
 ;
 I RCXVSYS="VMS" D ^RCXVFTV
 I RCXVSYS'="VMS" D ^RCXVFTC
 ;
 S RCXVARRY(RCXVTXT)="",RCXVARRY(RCXVBAT)="",RCXVARRY(RCXVNME)=""
 S Y=$$DEL^%ZISH(RCXVPTH,$NA(RCXVARRY))
 K RCXVARRY,%ZISHF,%ZISHO,%ZISUB,DIREC,FILE,I,RCXCT,RCXI,RCXOKAY,RCXVBAT
 K RCXVFTP,RCXVHNDL,RCXVIP,RCXVNME,RCXVOUT,RCXVPAS,RCXVPTH,RCXVSCR,XMY
 K RCXVSYS,RCXVSYT,RCXVTXT,RCXVUSR,RCXVVMS,CNT,QER,QFL,RCXMGRP,XMSUB
 K VALMSG,RCXVROOT
 Q
 ;
FCK ;  Check that file is ready to read
 S QFL=0,CNT=0,QER=0
FQT I QFL Q
 D OPEN^%ZISH(RCXVHNDL,RCXVPTH,RCXVSCR,"R")
 I POP D  G FQT
 . HANG 5
 . S CNT=CNT+1
 . I CNT>10 S QFL=1,QER=1 D CLOSE^%ZISH(RCXVHNDL)
 S QFL=1 D CLOSE^%ZISH(RCXVHNDL)
 G FQT
 ;
