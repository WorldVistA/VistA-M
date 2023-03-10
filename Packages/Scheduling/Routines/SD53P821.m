SD53P821 ;TMP/SA - SD*5.3*821 Post Init Routine ; September 15, 2022
 ;;5.3;Scheduling;**821**;May 29, 2018;Build 9
 ;
 ; load new Stop codes to the SD TELE HEALTH STOP CODE FILE #40.6.
 ; *** post install can be rerun with no harm ***
 ;
EN ; entry point
 N ERRCNT,FDA,SDIEN,ERR,STP
 S ERRCNT=0
 D MES^XPDUTL("")
 D MES^XPDUTL("Updating of SD TELE HEALTH STOP CODE FILE...")
 D MES^XPDUTL("") H 1
 F STP=497,498 D
 . I $O(^SD(40.6,"B",STP,"")) D MES^XPDUTL(STP_"    already on file") Q
 . I '$$CHKSTOP^SDTMPEDT(STP) D MES^XPDUTL(STP_"    ** Not added, invalid stop code") Q
 . S FDA(40.6,"+1,",.01)=STP D UPDATE^DIE("","FDA","SDIEN","ERR")
 . D:'$D(ERR) MES^XPDUTL(STP_"    added stop code")
 . I $D(ERR) D MES^XPDUTL(STP_" failed an attempt to add to the file.") S ERRCNT=ERRCNT+1
 . K FDA,SDIEN,ERR
 D MES^XPDUTL("")
 D MES^XPDUTL("Stop Code Update completed. "_ERRCNT_" error(s) found.")
 D MES^XPDUTL("")
 Q
