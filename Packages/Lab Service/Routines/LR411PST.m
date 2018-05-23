LR411PST ;Post-init Routine for LR*5.2*411 ; 2/18/04 9:29am
 ;;5.2;LAB SERVICE;**411**;Dec 30, 1994;Build 2
 ;
PRE ; initiate pre-init process
 Q
 ;
POST ; initiate post-init process
 D 389262
 D MAIL
 ;
 K ^TMP($J)
 Q
 ;
389262 ; check file 69.2 for missing global level containing last update date
 ;
 K ^TMP($J)
 ;
 D EN^DDIOL("Checking file # 69.2 (User defined patient/test lists...",,"!!!!")
 D EN^DDIOL("",,"!")
 ;
 N AA,DZ,DT
 S AA=$O(^LRO(68,"B","CHEMISTRY",0))
 I 'AA D EN^DDIOL("No entries to correct in file # 69.2.",,"!!!") Q
 ;
 S DT=$$HTFM^XLFDT(+$H)
 S DZ=0
 F  S DZ=$O(^LRO(69.2,AA,7,DZ)) Q:DZ=""  D
 . I '$D(^LRO(69.2,AA,7,DZ,1,0)) S ^LRO(69.2,AA,7,DZ,1,0)="^69.3PA^0^0"
 . I '$D(^LRO(69.2,AA,7,DZ,0)) S ^LRO(69.2,AA,7,DZ,0)=DZ_"^"_DT,^TMP($J,"DUZ",DZ)=""
 ;
 D EN^DDIOL("Review/Repair of file 69.2 complete.",,"!!!!")
 ;
 Q
 ;
MAIL ;
 ; setup, create, and send MAILMAN message listing DFNs from the NEW PERSON file 
 ; that were set with today's date as the last date used for the patient/test lists
 ; in file 69.2
 ;
 N DIFROM,XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,I,DZ
 ;
 S XMDUZ="PATCH LR*5.2*411 POST-INIT"
 S XMTEXT="^TMP($J,""TXT"","
 S XMSUB="PATCH LR*5.2*411 POST-INIT RESULTS"
 S:$G(DUZ) XMY(DUZ)=""
 S I=1,^TMP($J,"TXT",I)=""
 S I=I+1,^TMP($J,"TXT",I)=""
 S I=I+1,^TMP($J,"TXT",I)="User-defined test lists and patient lists are stored in file 69.2."
 S I=I+1,^TMP($J,"TXT",I)=""
 S I=I+1,^TMP($J,"TXT",I)="The last date used is a data item in this file that allows for"
 S I=I+1,^TMP($J,"TXT",I)="the deletion of lists that have not been used in a prescribed amount"
 S I=I+1,^TMP($J,"TXT",I)="of time."
 S I=I+1,^TMP($J,"TXT",I)=""
 S I=I+1,^TMP($J,"TXT",I)="In some cases the global level holding this date is missing for a user."
 S I=I+1,^TMP($J,"TXT",I)=""
 S I=I+1,^TMP($J,"TXT",I)="This post-init routine will insert this global level into file 69.2 for"
 S I=I+1,^TMP($J,"TXT",I)="those users where this level is missing. Today's date will be inserted"
 S I=I+1,^TMP($J,"TXT",I)="as the last used date so that these lists may ultimately be deleted."
 S I=I+1,^TMP($J,"TXT",I)=""
 S I=I+1,^TMP($J,"TXT",I)="The following users had today's date added as the last used date:"
 S I=I+1,^TMP($J,"TXT",I)="(These are DFNs - IENs for the NEW PERSON file.)"
 S I=I+1,^TMP($J,"TXT",I)=""
 S I=I+1,^TMP($J,"TXT",I)=""
 I $O(^TMP($J,"DUZ",0))="" D  Q
 . S I=I+1,^TMP($J,"TXT",I)="NO USERS WERE IN NEED OF UPDATES."
 . D ^XMD
 S DZ=0 F  S DZ=$O(^TMP($J,"DUZ",DZ)) Q:DZ=""  S I=I+1,^TMP($J,"TXT",I)="   "_DZ
 D ^XMD
 ;
 Q
