RCXVCHK ;DAOU/ALA-Check for bad records ;26-DEC-2004
 ;;4.5;Accounts Receivable;**227**;Mar 20, 1995
 ;
 ;**Program Description**
 ;  This program checks for records in the queue which
 ;  does not have a bill number
 ;
EN ; Entry point
 K ^TMP("RCXVBREC",$J)
 S ^TMP("RCXVBREC",$J,0)=0
 S BTN=0
BT S BTN=$O(^RCXV(BTN)) G EXIT:'BTN
 S BIL=0
BL S BIL=$O(^RCXV(BTN,1,BIL)) G BT:'BIL
 I $P($G(^PRCA(430,BIL,0)),"^",1)="" D
 . NEW CT
 . S CT=$G(^TMP("RCXVBREC",$J,0))+1,^TMP("RCXVBREC",$J,0)=CT
 . S ^TMP("RCXVBREC",$J,CT,0)="Bill IEN: "_BIL_" does not have a Bill Number in File #430."
 . S DA(1)=BTN,DA=BIL
 . S DIK="^RCXV("_DA(1)_",1,"
 . D ^DIK
 . S $P(^RCXV(BTN,0),"^",7)=$P(^RCXV(BTN,0),"^",7)-1
 G BL
 ;
EXIT K BTN,BIL,DA,DIK,RCXMGRP
 Q
 ;
MSG ;  Send mail message about bad record
 I $G(^TMP("RCXVBREC",$J,0))=""!($G(^TMP("RCXVBREC",$J,0))=0) Q
 S RCXMGRP=$$GET1^DIQ(342,"1,",20.02,"E")
 I RCXMGRP="" S RCXMGRP="IRM"
 S RCXMGRP="G."_RCXMGRP
 S XMDUZ="CBO DATA EXTRACT",XMY(RCXMGRP)=""
 S XMSUB="BAD RECORD(S) FOUND"
 S XMTEXT="^TMP(""RCXVBREC"",$J,"
 D ^XMD
 K XMDUN,XMDUZ,XMZ,XMY,XMSUB,XMTEXT
 Q
