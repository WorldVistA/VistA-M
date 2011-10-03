RCXVFTR ;DAOU/ALA-Retrieve FTP messages ;17-DEC-2003
 ;;4.5;Accounts Receivable;**201**;Mar 20, 1995
 ;
 ;**Program Description**
 ;  This program will read all the ftp messages to
 ;  see if they were successful or not
 ;
EN ;  Find all temporary files
 K ^TMP("RCXVIN",$J)
 S CNT=0,QFL=0
 S RCXVDIR=$P($G(^RC(342,1,20)),U,1)
 ;
 ;  Go through and read each one
 S RCVL=""
 F  S RCVL=$O(^TMP("RCXVMSG",$J,RCVL)) Q:RCVL=""  D
 . K ^TMP("RCXVIN",$J)
 . ;
 . S RCXVBTN=$P(RCVL,"_",3),RCXVBTN=$P(RCXVBTN,".",1)
 . S Y=$$FTG^%ZISH(RCXVDIR,RCVL,$NA(^TMP("RCXVIN",$J,1,0)),3)
 . ;
 . I $O(^TMP("RCXVIN",$J,0))="" S ^TMP("RCXVIN",$J,1,0)="No FTP command file found for batch #"_RCXVBTN
 . ;
 . S RCXOKAY=0,RCXI=0
 . F  S RCXI=$O(^TMP("RCXVIN",$J,RCXI)) Q:'RCXI  D
 .. I $E($G(^TMP("RCXVIN",$J,RCXI,0)),1,3)="226" S RCXOKAY=1
 . ;
 . ;  If the transfer does not say complete, send a mail message
 . I 'RCXOKAY D
 .. S RCXMGRP=$$GET1^DIQ(342,"1,",20.02,"E")
 .. I RCXMGRP="" S RCXMGRP="IRM"
 .. S RCXMGRP="G."_RCXMGRP
 .. S XMDUZ="CBO DATA EXTRACT",XMY(RCXMGRP)=""
 .. S XMSUB="CBO/ARC FTP ATTEMPT"
 .. S XMTEXT="^TMP(""RCXVIN"",$J,"
 .. D ^XMD
 .. K XMDUN,XMDUZ,XMZ,XMY
 . ;
 . I RCXOKAY D
 .. S RCXVUP(348.4,RCXVBTN_",",.08)=$$NOW^XLFDT()
 .. I $P(^RCXV(RCXVBTN,0),"^",3)'="C" S RCXVUP(348.4,RCXVBTN_",",.03)="T"
 .. D FILE^DIE("I","RCXVUP","RCXVERR")
 ;
 S Y=$$DEL^%ZISH(RCXVDIR,$NA(^TMP("RCXVMSG",$J)))
 ;
EXIT K C,CNT,RCXOKAY,RCXVUP,RCXVERR,RCXVLST,Y,RCXMGRP,RCXI,RCVL,QFL,RCXVARY,I
 Q
 ;
