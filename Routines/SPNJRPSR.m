SPNJRPSR ;BP/JAS - Returns SCI Roles for all SCI NEW PERSON entries ;NOV 19, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to ^XUSEC supported by IA# 10076
 ; Reference to file 200 supported by IA# 10060
 ;
 ; Parm values:
 ;     RETURN is the array containing role and access types for SCI users
 ;     Returns: ^TMP($J)
 ;
COL(RETURN) ;
 ;***************************
 K ^TMP($J),^TMP("SPN",$J)
 S RETURN=$NA(^TMP($J)),RETCNT=1
 ;JAS - 11/19/08 - DEFECT 1110
 ;S DA="SCI"
 ;F  S DA=$O(^XUSEC(DA)) Q:DA=""!(DA]"SCI_Z")  D NPDA
 S DA="SPN_AA"
 F  S DA=$O(^XUSEC(DA)) Q:DA=""!(DA]"SPN_ZZ")  D NPDA
 D FIN
 K ACCESS,DA,NPDA,KEY,RETCNT,ROLE,UNAME,^TMP("SPN",$J)
 Q
NPDA ;
 ;JAS - 05/15/08 - DEFECT 1090
 ;S NPDA=""
 S NPDA=0
 F  S NPDA=$O(^XUSEC(DA,NPDA)) Q:NPDA=""  D FIND
 Q
FIND ;
 S UNAME=$$GET1^DIQ(200,NPDA_",",.01)
 S ^TMP("SPN",$J,UNAME,NPDA,DA)=""
 Q
FIN ;
 S UNAME=""
 F  S UNAME=$O(^TMP("SPN",$J,UNAME)) Q:UNAME=""  D
 . S NPDA=""
 . F  S NPDA=$O(^TMP("SPN",$J,UNAME,NPDA)) Q:NPDA=""  D
 . . S KEY="",ROLE="",ACCESS=""
 . . F  S KEY=$O(^TMP("SPN",$J,UNAME,NPDA,KEY)) Q:KEY=""  D
 . . . I KEY["CATCHMENT" S ACCESS="Region" Q
 . . . I ROLE="" S ROLE=$P(KEY,"_",2) Q
 . . . S ROLE=ROLE_", "_$P(KEY,"_",2)
 . . Q:ROLE=""&(ACCESS="")
 . . I ACCESS="" S ACCESS="Institution"
 . . S ^TMP($J,RETCNT)=UNAME_"^"_ROLE_"^"_ACCESS_"^EOL999"
 . . S RETCNT=RETCNT+1
 Q
