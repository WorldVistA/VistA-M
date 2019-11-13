LRWU9A ;HPS/DSK - TOOL TO DETECT, FIX, AND REPORT BAD DATA NAMES ;Apr 11, 2019@16:00
 ;;5.2;LAB SERVICE;**519**;Sep 27, 1994;Build 16
 ;
 ;Reference to ^DD(63.04 supported by DBIA #7053
 ;
 Q
 ;
B6304 ;check "B" cross reference
 ;
 ;LRNUM = Current MailMessage line number
 ;
 N LRA,LRB,LRMISNM,LRCOUNT
 S (LRA,LRB)="",LRMISNM=0
 F  S LRA=$O(^DD(63.04,"B",LRA)) Q:LRA=""  D
 . S LRCOUNT=0
 . F  S LRB=$O(^DD(63.04,"B",LRA,LRB)) Q:LRB=""  D
 . . S LRCOUNT=LRCOUNT+1
 . . I LRCOUNT>1 M ^TMP("LR63.04B",$J,LRA)=^DD(63.04,"B",LRA)
 ;
 ;Check whether issues were found. If so, add to MailMan ^TMP from LRWU9
 I $D(^TMP("LR63.04B",$J)) D BMAIL
 Q
 ;
BMAIL ;Generate MailMan message for "B" cross ref issues
 N LRSPACE,LRDASH,LRSTR,LRHIT,LRA,LRB
 S LRSPACE="                              "
 S LRDASH="------------------------------------------------------------"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="**** The following issue(s) were found in ^DD(63.04. ****"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="Please submit a ServiceNow ticket with the assignment group"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="of NTL SUP CLIN2 for assistance with correcting the issue(s)."
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="NOTE: Names such as ""not in use"", etc. which do not appear to"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="      pertain to active tests do not warrant correction."
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="Name(s) With Multiple IENs"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="Name                     IEN"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=LRDASH
 S (LRA,LRB)=""
 F  S LRA=$O(^TMP("LR63.04B",$J,LRA)) Q:LRA=""  D
 . S LRB=$O(^TMP("LR63.04B",$J,LRA,"")) D
 . . S LRNUM=LRNUM+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)=$E(LRA,1,23)_$E(LRSPACE,1,25-$L(LRA))_LRB
 . F  S LRB=$O(^TMP("LR63.04B",$J,LRA,LRB)) Q:LRB=""  D
 . . S LRNUM=LRNUM+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)=$E(LRSPACE,1,25)_LRB
 . ;
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="**** End of issue(s) found in ^DD(63.04 ****"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" "
 Q
 ;
