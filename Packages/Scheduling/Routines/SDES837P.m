SDES837P ;ALB/MGD - SD*5.3*837 Post Init Routine ; Feb 02, 2023
 ;;5.3;SCHEDULING;**837**;AUG 13, 1993;Build 4
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 D FIND,UPDATE409981
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("")
 D MES^XPDUTL("   Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.39
 S DA=SDECDA,DIE=409.98,DR="2///1.7.39;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.39;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("   VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
 ;
UPDATE409981 ; Delete the Scheduling Manager (SM) entry from 409.981 multiple
 N IEN,SUBIEN,FDA
 D MES^XPDUTL("   ")
 D MES^XPDUTL("   Deleting the Scheduling Manager (SM) entry from 409.981 multiple.")
 S IEN=$O(^SDEC(409.98,"B","VS GUI NATIONAL",0))
 I 'IEN D NOFIND Q
 S SUBIEN=$O(^SDEC(409.98,IEN,1,"B","Scheduling Manager (SM)",0))
 I 'SUBIEN D MES^XPDUTL("   Scheduling Manager (SM) entry not found in the 409.981 multiple.") Q
 S FDA(409.981,SUBIEN_","_IEN_",",.01)="@"
 D FILE^DIE(,"FDA") K FDA
 D MES^XPDUTL("   ")
 D MES^XPDUTL("   Scheduling Manager (SM) entry in #409.981 successfully deleted.")
 Q
