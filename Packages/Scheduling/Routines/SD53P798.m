SD53P798 ;TMP/GSN - TMP POST INSTALL FOR PATCH SD*5.3*798;July 30, 2018
 ;;5.3;Scheduling;**798**;May 29, 2018;Build 12
 ;
 ;Post install routine for SD*5.3*798 sets Facility Name field in HL7 App Param file #771 for 2 entries to null.
 ;
POST ;Post install routines for SD*5.3*780
 N FDA,AP,APN
 D BMES^XPDUTL("")
 D BMES^XPDUTL("*** Updating Facility Name to null in file #771 for the following entires: ***")
 F AP="SD TMP APPT SEND","SD TMP APPT RECEIVE" D
 . S APN=$$FIND1^DIC(771,"","",AP,"B") I APN<1 Q
 . K FDA S FDA(1,771,APN_",",3)=""
 . D FILE^DIE("","FDA(1)","ERROR")
 . D BMES^XPDUTL("***   Update for "_AP_" completed ***")
 D BMES^XPDUTL("")
 Q
