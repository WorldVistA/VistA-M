PRSXP107 ;WCIOFO/MGD,RRG-POST INSTALL CLEAN UP FILE 458 ;02/27/2007
 ;;4.0;PAID;**107**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;
 ; This program will delete erroneous Zero nodes in the TIME & ATTENDANCE
 ; (#458) file starting at Pay Period 03-19.
 ;
START ; Main Driver
 ;
 D 458
 Q
 ;
 ;
 ;
458 ; Correct data in the TIME & ATTENDANCE (#458) file
 ;
 N CNT,DA,DATA,DIK,EMP,EMPX,I,LINE,LINE2,LCNT,MESS,MSG,MSG1
 N NAME,TNAME,PPI,STANUM,STATUS,TIME,U,UCIX,PPIEN
 S U="^",LCNT=1,$P(LINE,"-",80)="",$P(LINE2,"=",80)="",STATUS="OK"
 K ^TMP($J)
 S MESS="TIME & ATTENDANCE (#458)",MSG1=" beginning at "
 D TIME
 D STAUCI
 S ^TMP($J,"P107",LCNT)="",LCNT=LCNT+1
 S MESS="Deleting erroneous nodes."
 S ^TMP($J,"P107",LCNT)=MESS,LCNT=LCNT+1
 S ^TMP($J,"P107",LCNT)="",LCNT=LCNT+1
 ;
 ; Correct data in the TIME & ATTENDANCE (#458) file
 ;
 S PPI="03-15"
 F  S PPIEN="",PPI=$O(^PRST(458,"B",PPI))  Q:'PPI!(PPI>"09-20")  D
 . S PPIEN=$O(^PRST(458,"B",PPI,0)) Q:'PPIEN
 . S ^TMP($J,"P107",LCNT)="",LCNT=LCNT+1
 . S ^TMP($J,"P107",LCNT)="Pay Period "_PPI,LCNT=LCNT+1
 . S ^TMP($J,"P107",LCNT)=LINE2,LCNT=LCNT+1
 . S ^TMP($J,"P107",LCNT)="EMP IEN                 DATA",LCNT=LCNT+1
 . S ^TMP($J,"P107",LCNT)=LINE,LCNT=LCNT+1
 . S (CNT,EMP)=0
 . F  S EMP=$O(^PRST(458,PPIEN,"E",EMP)) Q:'EMP  D
 . . S DATA=$G(^PRST(458,PPIEN,"E",EMP,0))
 . . I EMP'=$P(DATA,U,1),($P(DATA,U,2)="") D
 . . . S EMPX="",$P(EMPX," ",21)="",$E(EMPX,1,$L(EMP))=EMP
 . . . S ^TMP($J,"P107",LCNT)=EMPX_DATA,LCNT=LCNT+1
 . . . S CNT=CNT+1
 . . . ;
 . . . ; Delete the erroneous 0 node
 . . . ;
 . . . S DA=EMP,DA(1)=PPIEN,DIK="^PRST(458,"_DA(1)_",""E"","
 . . . D ^DIK
 . S ^TMP($J,"P107",LCNT)="",LCNT=LCNT+1
 . S MESS=$S(CNT>0:CNT_" record(s) deleted.",1:"No records to delete")
 . S ^TMP($J,"P107",LCNT)=MESS,LCNT=LCNT+1
 . S ^TMP($J,"P107",LCNT)="",LCNT=LCNT+1
 S MESS="TIME & ATTENDANCE (#458)",MSG1=" ending at "
 D TIME
 S MSG=MSG_"458 "_STATUS
 D XMT
 Q
 ;
 ;
XMT ; Send status via mail message
 ;
 I $D(^TMP($J,"P107")) D
 . N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 . S XMDUZ=.5
 . S XMSUB=MSG
 . S XMTEXT="^TMP($J,""P107"","
 . S XMY(DUZ)=""
 . S XMY("G.PAD@"_^XMB("NETNAME"))=""
 . D ^XMD
 ;
 K ^TMP($J),Y,%
 Q
 ;
TIME ; Get current Time
 ;
 D NOW^%DTC
 S Y=%
 D DD^%DT
 S TIME=Y
 S MESS=MESS_" clean up routine"_MSG1_TIME_"."
 S ^TMP($J,"P107",LCNT)=MESS,LCNT=LCNT+1
 Q
 ;
 ;
STAUCI ;Get Station Number
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MSG=STANUM_" - "
 ;
 ; Check for UCI,VOL
 ;
 X ^%ZOSF("UCI")
 S UCIX=$G(Y)
 I UCIX="" S UCIX="??????"
 S MSG=MSG_UCIX_" - "
 Q
 ;
NAME ; Format name
 ;
 S NAME="",$P(NAME," ",30)=""
 S TNAME=$$GET1^DIQ(450,EMP,.01)
 I TNAME="" S TNAME=EMP
 S $E(NAME,1,$L(TNAME))=TNAME
 Q
 ;
