TIU330P ;SPFO/AJB - VistA Cutoff  ;Mar 24, 2021@10:46:20
 ;;1.0;TEXT INTEGRATION UTILITIES;**330**;Jun 20, 1997;Build 51
 ;
 ; $$FIND1^DIC     ICR#2051     MES^XPDUTL     ICR#10141
 ; $$SITE^VASITE   ICR#10112
 Q
PRE ;
 N DC,DOC,SCR,SITE,TIUFPRIV
 S SITE=$$SITE^VASITE,SITE=$P(SITE,U,2),TIUFPRIV=1
 ; check document class entry EHRM CUTOVER
 S SCR="I $P(^(0),U,4)=""DC""" ; screen for the document class
 S DC=$$LU(8925.1,"EHRM CUTOVER","X",SCR) I +DC D MES^XPDUTL("EHRM CUTOVER document class found.")
 ; create new dc if not found
 I '+DC S DC=$$CRDD^TIUCRDD("EHRM CUTOVER","DC","ACTIVE","PROGRESS NOTES") I +DC D
 . D MES^XPDUTL("Installed document class EHRM CUTOVER.")
 ; display error message and quit
 I '+DC D MES^XPDUTL($P(DC,U,2)) Q
 ; check document titles
 S SCR="I $P(^(0),U,4)=""DOC""" ; screen for the document title
 F DOC="EHRM CUTOVER ","EHRM CUTOVER REMINDERS " D
 . ; set document title length to 60 just in case, attempt lookup
 . S DOC=DOC_SITE,DOC=$E(DOC,1,60),DOC("IEN")=$$LU(8925.1,DOC,"X",SCR) I +DOC("IEN") D MES^XPDUTL(DOC_" title found.") Q
 . S DOC("IEN")=$$CRDD^TIUCRDD(DOC,"DOC","ACTIVE","EHRM CUTOVER","CARE MANAGEMENT NOTE") I +DOC("IEN") D MES^XPDUTL("Installed title "_DOC_".") Q
 . I '+DOC("IEN") D MES^XPDUTL($P(DOC("IEN"),U,2))
 Q
LU(FILE,NAME,FLAGS,SCREEN,INDEXES,IENS) ;
 N DILOCKTM,DISYS
 Q $$FIND1^DIC(FILE,$G(IENS),$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN),"ERR")
