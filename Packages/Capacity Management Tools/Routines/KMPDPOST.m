KMPDPOST ;OAK/RAK - CM Tools Post Install ;4/2/04  08:55
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**1,2,5**;Mar 22, 2002
 ;
EN ;-entry point
 N BTIEN,ERROR,FDA,MGIEN,ZIEN
 D MES^XPDUTL("     Adding CURRENT PATCH data to CP PARAMETERS file...")
 S FDA($J,8973,"1,",.04)=$P($$VERSION^KMPDUTL,"^",2)
 S FDA($J,8973,"1,",.05)=$$NOW^XLFDT
 D FILE^DIE("","FDA($J)","ERROR")
 ; if error
 I $D(ERROR) D MSG^DIALOG("W","",60,10,"ERROR")
 ;
 D MES^XPDUTL("     Adding 'VISTA MONITOR TRANSFER TO' data to CP PARAMETERS file...")
 ; ad vista monitor 'transmit to' entries
 ;
 K ERROR,FDA,ZIEN
 S FDA($J,8973.05,"?+1,1,",.01)="S.KMP7SRV@FO-ALBANY.MED.VA.GOV"
 ; file data
 D UPDATE^DIE("","FDA($J)","ZIEN","ERROR")
 ; if error
 I $D(ERROR) D MSG^DIALOG("W","",60,10,"ERROR")
 ;
 ; bulletin ien
 S BTIEN=$O(^XMB(3.6,"B","KMPD ECHO",0))
 ; mail group ien
 S MGIEN=$O(^XMB(3.8,"B","KMP-CAPMAN",0))
 I BTIEN&(MGIEN) D 
 .D MES^XPDUTL("     Adding mail group KMP-CAPMAN to bulletin KMPD ECHO...")
 .K ERROR,FDA,ZIEN
 .S FDA($J,3.62,"?+1,"_BTIEN_",",.01)=MGIEN
 .D UPDATE^DIE("","FDA($J)","ZIEN","ERROR")
 .; if error
 .I $D(ERROR) D MSG^DIALOG("W","",60,10,"ERROR")
 ;
 D MES^XPDUTL("     Complete!")
 ;
 Q
