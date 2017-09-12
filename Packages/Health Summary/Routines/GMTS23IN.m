GMTS23IN ;SLC/PKR - Init for patch GMTS*2.7*23 ; 11/25/97
 ;;2.7;Health Summary;**23**;Oct 20, 1995
 ;
 ;======================================================================
CDHN ;Change default header names in Health Summary Types.
 D BMES^XPDUTL("Changing defaulted header names to the new defaults.")
 N CDHN,FDA,IENS,IND,JND,MSG
 S IND=0
 F  S IND=$O(^GMT(142,IND)) Q:+IND'>0  D
 . S JND=0
 . F  S JND=$O(^GMT(142,IND,1,JND)) Q:+JND'>0  D
 .. S CDHN=$P(^GMT(142,IND,1,JND,0),U,5)
 .. I CDHN="Clinical Maintenance" D
 ... S IENS=JND_","_IND_","
 ... S FDA(142.01,IENS,5)="Reminder Maintenance"
 ... D FILE^DIE("KE","FDA","MSG")
 .. I CDHN="Clinical Reminders" D
 ... S IENS=JND_","_IND_","
 ... S FDA(142.01,IENS,5)="Reminders Due"
 ... D FILE^DIE("KE","FDA","MSG")
 Q
 ;
 ;======================================================================
POST ;Post init for GMTS*2.7*23
 ;Change the default header names to the new ones in existing Health
 ;Summaries.
 D CDHN
 ;
 ;Reload the Ad Hoc Health Summary
 N INCLUDE
 I XPDQUES("POSADHOC") S INCLUDE=1
 E  S INCLUDE=0
 D BMES^XPDUTL("Reloading the Ad Hoc Health Summary")
 I INCLUDE D BMES^XPDUTL("Disabled components will be included")
 I 'INCLUDE D BMES^XPDUTL("Disabled components will not be included")
 D ENPOST^GMTSLOAD
 Q
 ;
 ;======================================================================
RENCRC ;Rename the CLINICAL REMINDERS COMPONENTS.
 N FDA,IND,MSG
 D BMES^XPDUTL("Renaming PCE CLINICAL REMINDERS Health Summary Component")
 S IND=$O(^GMT(142.1,"B","PCE CLINICAL MAINTENANCE",""))
 I $L(IND)>0 D
 . S FDA(142.1,IND_",",.01)="CLINICAL REMINDERS MAINTENANCE"
 . D FILE^DIE("KE","FDA","MSG")
 ;
 S IND=$O(^GMT(142.1,"B","PCE CLINICAL REMINDERS",""))
 I $L(IND)>0 D
 . S FDA(142.1,IND_",",.01)="CLINICAL REMINDERS DUE"
 . D FILE^DIE("KE","FDA","MSG")
 Q
 ;
