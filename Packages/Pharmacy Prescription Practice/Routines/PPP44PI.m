PPP44PI ;BIRM/JAM - Post Install to remove PPP data and DDs ;06/05/09
 ;;1.0;PHARMACY PRESCRIPTION PRACTICE;**44**;APR 7,1995;Build 19
 ;
 ;Retiring of PPP package - removal of all its files & data
EN ; entry point
 ;
 N STR,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTREQ,ZTSAVE
 D MES^XPDUTL(" ")
 S STR="A background job will be tasked to delete all PPP data and data dictionary..."
 D MES^XPDUTL(STR)
 S STR="A Mailman message will be generated and sent to the installer when the job"
 D MES^XPDUTL(STR)
 D MES^XPDUTL("is completed.")
 S ZTRTN="BGEN^PPP44PI",ZTDESC="PPP Package Data & Data Dictionary Removal"
 S ZTIO="",ZTDTH=$H,ZTREQ="@",ZTSAVE("ZTREQ")=""
 D ^%ZTLOAD
 Q
 ;
BGEN ;Background job entry
 N DIU,COUNT,GNOD,I,TXT,FILE,FLG,START,END
 S (COUNT,FLG)=0,START=$$FMTE^XLFDT($$NOW^XLFDT,1)
 K ^TMP($J,"PPP44")
 F I=1:1 S TXT=$P($T(MSGTXT+I),";;",2) Q:TXT="QUIT"  D LINE(TXT)
 S DIU(0)="DST"
 F FILE=1020.1:.1:1020.8,1020.128 D
 .S DIU=$$ROOT^DILFD(FILE),GNOD=$$CREF^DILF(DIU)
 .I '$$VFILE^DILFD(FILE) Q
 .D EN^DIU2
 .; check if DD and data is removed
 .I '$D(@GNOD),'$$VFILE^DILFD(FILE) D  Q
 ..S STR=DIU_" successfully removed" D LINE(STR) Q
 .S STR=DIU_" was not successfully removed",FLG=1 D LINE(STR)
 I FLG D
 .D LINE("")
 .S STR="A file was not removed successfully. Please have your IRM re-run"
 .S STR=STR_" the background job" D LINE(STR)
 .S STR="by entering this command at the programmer's prompt" D LINE(STR)
 .S STR="   D EN^PPP44PI"
 D DIRCHK
 D LINE("")
 S START="Start Time: "_START D LINE(START)
 S END=$$FMTE^XLFDT($$NOW^XLFDT,1)
 S STR="End Time:   "_END D LINE(STR)
 D MAIL
 Q
 ;
MSGTXT ; Message into
 ;; The PPP package is being retired and all data and data dictionary
 ;; will be removed from the system. This message shows a list of
 ;; files that were removed.
 ;;
 ;;QUIT
 Q
LINE(TEXT) ; Add line to message global
 S COUNT=COUNT+1,^TMP($J,"PPP44",COUNT)=TEXT
 Q
 ;
DIRCHK ; Checks ^ROUTINE global for files beginning with PPP that were not 
 ; removed.
 N X,FND,STR
 S FND=1
 S X="PPO~" F  S X=$O(^ROUTINE(X)) Q:(X="")!($E(X,1,3)'="PPP")  D
 .I X="PPP44PI" Q
 .I FND D 
 ..D LINE("")
 ..S STR="The following routines beginning with PPP were found in the directory." D LINE(STR)
 ..S STR="They were not removed with patch PPP*1*44 installation. You will need to" D LINE(STR)
 ..S STR="review these routines and delete them if necessary." D LINE(STR)
 .D LINE(X) S FND=0
 Q
 ;
MAIL ; Send message
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="PPP Package Data & Data Dictionary Removal"
 S XMTEXT="^TMP($J,""PPP44"","
 D ^XMD
 Q
 ;
