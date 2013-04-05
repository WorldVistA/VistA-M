KMPDPOST ;OAK/RAK - CM Tools Post Install ;4/2/04  08:55
 ;;3.0;KMPD;;Jan 22, 2009;Build 42
 ;
EN ;-entry point
 N IEN,IEN1,ERROR,FDA,ZIEN
 ; update cp parameters file
 S FDA($J,8973,"?+1,",.01)=+$P($$SITE^VASITE,"^")
 S FDA($J,8973,"?+1,",.02)=$P($$VERSION^KMPDUTL,"^")
 S FDA($J,8973,"?+1,",.03)=$$NOW^XLFDT
 S FDA($J,8973,"?+1,",.04)=""
 S FDA($J,8973,"?+1,",.05)=""
 D UPDATE^DIE("","FDA($J)","ERROR")
 ; if error
 I $D(ERROR) D MSG^DIALOG("W","",60,10,"ERROR") Q
 D MES^XPDUTL("     CM TOOLS CURRENT VERSION field in CP PARAMETERS file has been updated!")
 ; check for background job
 S IEN=$O(^DIC(19,"B","KMPD BACKGROUND DRIVER",0))
 D:'IEN MES^XPDUTL("     KMPD BACKGROUND DRIVER is NOT in the OPTION file!")
 ; check for option scheduling entry
 S IEN1=$O(^DIC(19.2,"B",IEN,0))
 I IEN1 D MES^XPDUTL("     [KMPD BACKGROUND DRIVER] is scheduled in the OPTION SCHEDULING file!")
 E  D 
 .K ERROR,FDA,ZIEN
 .S FDA($J,19.2,"+1,",.01)=IEN
 .S FDA($J,19.2,"+1,",2)="T+1@01:30"
 .S FDA($J,19.2,"+1,",6)="1D"
 .D UPDATE^DIE("","FDA($J)",.ZIEN,"ERROR")
 .; if error
 .I $D(ERROR) D MSG^DIALOG("W","",60,10,"ERROR") Q
 .D MES^XPDUTL("     [KMPD BACKGROUND DRIVER] has been scheduled to run each day at 1:30am!")
 ;
 Q
