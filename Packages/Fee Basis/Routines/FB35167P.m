FB35167P ;ALBANY/BJR-PATCH INSTALL ROUTINE ; 11/18/15 12:59pm
 ;;3.5;FEE BASIS;**167**;JAN 30, 1995;Build 13
 ;Per VA Directive 6402, this routine should not be modified
 Q
 ;
EN ; post-install entry point
 K ^TMP("FB167",$J)
 D MES^XPDUTL("")
 D MES^XPDUTL("Running FB*3.5*167 Post Install")
 D MES^XPDUTL("Check your Mailman Inbox for message 'FB*3.5*167 Data'")
 D HDR,DATA,MAIL
 K ^TMP("FB167",$J)
 D MES^XPDUTL("")
 D MES^XPDUTL("FB*3.5*167 Post Install Complete")
 Q
DATA ;Create temp global for report
 N FBPROG,FBDT,FBIEN,FBDFN,FBAUTH,FBGBL,FBINV,FBX
 S FBX=5
 S FBPROG=0 F  S FBPROG=$O(^FBAA(161.8,FBPROG)) Q:'FBPROG  D
 .S FBDT=3150930 F  S FBDT=$O(^FB583("AD",FBPROG,FBDT)) Q:'FBDT  D
 ..S FBIEN=0 F  S FBIEN=$O(^FB583("AD",FBPROG,FBDT,FBIEN)) Q:'FBIEN  D
 ...Q:$$GET1^DIQ(162.7,FBIEN,5.1)=""
 ...S FBDFN=$O(^FBAAA("AG",FBIEN_";FB583(","")) Q:'FBDFN  S FBAUTH=$O(^FBAAA("AG",FBIEN_";FB583(",FBDFN,""))
 ...S FBGBL=^FBAAA(FBDFN,1,FBAUTH,0) I $P($G(^FBAAA(FBDFN,1,FBAUTH,"C")),"^",2)="" D
 ....S ^TMP("FB167",$J,FBX)=$E($$GET1^DIQ(162.7,FBIEN,2)_"                               ",1,32)
 ....S ^TMP("FB167",$J,FBX)=^TMP("FB167",$J,FBX)_$E($$GET1^DIQ(162.7,FBIEN,3)_"                ",1,16)
 ....S ^TMP("FB167",$J,FBX)=^TMP("FB167",$J,FBX)_$E($$GET1^DIQ(162.7,FBIEN,4)_"                ",1,16)
 ....S ^TMP("FB167",$J,FBX)=^TMP("FB167",$J,FBX)_$E($$GET1^DIQ(162.7,FBIEN,1),1,15)
 ....S FBX=FBX+1
 Q
HDR ;Header for report
 N FBY
 S ^TMP("FB167",$J,3)="PATIENT"_"                         "_"FROM DATE"_"       "_"TO DATE"_"         "_"VENDOR"
 S ^TMP("FB167",$J,4)="" F FBY=1:1:79 S ^TMP("FB167",$J,4)=^TMP("FB167",$J,4)_"-"
 Q
MAIL ; send the mail message
 ;Call to ^XMD supported by ICR #10070
 S ^TMP("FB167",$J,1)="The following Unauthorized Claims have data missing in the FEE BASIS PATIENT (#161) file."
 S ^TMP("FB167",$J,2)=" "
 N XMY,XMDUZ,XMSUB,XMTEXT,DIFROM
 S XMY(DUZ)="",XMDUZ="FB_3.5_167 Post Install"
 S XMSUB="FB*3.5*167 Data"
 S XMTEXT="^TMP(""FB167"",$J,"
 D ^XMD
 Q
PRINT ;Print to screen instead of Mailman
 K ^TMP("FB167",$J)
 D HDR,DATA
 N FBCNT
 S FBCNT=0 F  S FBCNT=$O(^TMP("FB167",$J,FBCNT)) Q:'FBCNT  W !,^TMP("FB167",$J,FBCNT)
 K ^TMP("FB167",$J)
 Q
