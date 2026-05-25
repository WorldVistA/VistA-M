SDES903P ;ALB/TJB - SD*5.3*903 Post Init Routine ; MAR 31, 2025
 ;;5.3;SCHEDULING;**903**;AUG 13, 1993;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
EN ; Update the VS GUI version in #409.98
 D APPTYPE
 Q
 ;
APPTYPE ;
 N FDA,DESC,FDAIEN,ERR,FILEERR,NEWIEN
 Q:$D(^SD(409.1,"B","HUD/VASH"))&($D(^SD(409.1,"B","ALLIED VETERAN")))&($D(^SD(409.1,"B","REGISTRY EXAM")))
 D MES^XPDUTL("")
 D MES^XPDUTL("   Adding HUD/VASH to the Appointment Type file (#409.1)")
 S FDA(409.1,"+1,",.01)="HUD/VASH"
 S FDA(409.1,"+1,",2)=1
 S FDA(409.1,"+1,",4)="HV"
 S FDA(409.1,"+1,",5)=1
 S FDA(409.1,"+1,",6)=$O(^DIC(8,"B","HUD-VASH",0))
 D UPDATE^DIE(,"FDA","NEWIEN","FILEERR")
 I $D(FILEERR) D  Q
 .D MES^XPDUTL("")
 .D MES^XPDUTL("Error adding HUD/VASH to the Appointment Type file.")
 .D MES^XPDUTL("Please create a SNOW ticket and route to the Vista Scheduling")
 .D MES^XPDUTL("team.")
 ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   Adding ALLIED VETERAN to the Appointment Type file (#409.1)")
 K FDA,NEWIEN,FILERRR
 S FDA(409.1,"+1,",.01)="ALLIED VETERAN"
 S FDA(409.1,"+1,",2)=1
 S FDA(409.1,"+1,",4)="AV"
 S FDA(409.1,"+1,",5)=1
 S FDA(409.1,"+1,",6)=$O(^DIC(8,"B","ALLIED VETERAN",0))
 D UPDATE^DIE(,"FDA","NEWIEN","FILEERR")
 I $D(FILEERR) D  Q
 .D MES^XPDUTL("")
 .D MES^XPDUTL("Error adding ALLIED VETERAN to the Appointment Type file.")
 .D MES^XPDUTL("Please create a SNOW ticket and route to the Vista Scheduling")
 .D MES^XPDUTL("team.")
 ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   Adding REGISTRY EXAM to the Appointment Type file (#409.1)")
 K FDA,NEWIEN,FILERRR
 S FDA(409.1,"+1,",.01)="REGISTRY EXAM"
 S FDA(409.1,"+1,",2)=1
 S FDA(409.1,"+1,",4)="RE"
 S FDA(409.1,"+1,",5)=1
 S FDA(409.1,"+1,",6)=$O(^DIC(8,"B","CLINICAL EVALUATION",0))
 D UPDATE^DIE(,"FDA","NEWIEN","FILEERR")
 I $D(FILEERR) D  Q
 .D MES^XPDUTL("")
 .D MES^XPDUTL("Error adding REGISTRY EXAM to the Appointment Type file.")
 .D MES^XPDUTL("Please create a SNOW ticket and route to the Vista Scheduling")
 .D MES^XPDUTL("team.")
 Q
