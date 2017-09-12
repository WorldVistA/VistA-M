HLPAT120 ;OIFO-OAKLAND/RAM & RJH - HL7 PATCH 120 PRE&POST-INIT ;01/19/06  11:07
 ;;1.6;HEALTH LEVEL SEVEN;**120**;Oct 13, 1995;Build 12
 ;
 Q
PRE ;
 ; disable identifier for file #779.004 to prevent from duplicate
 ; caused by field #2 (Description)
 K ^DD(779.004,0,"ID")
 ;
 N HLCCARY,HLAPPARY
 D CC
 D APP771
 Q:'$D(HLCCARY)
 ;
 I $D(^XTMP("HLPAT120")) K ^XTMP("HLPAT120")
 M ^XTMP("HLPAT120","CC")=HLCCARY
 S ^XTMP("HLPAT120",0)=$$FMADD^XLFDT(DT,90)_U_DT
 Q:'$D(HLAPPARY)
 ;
 M ^XTMP("HLPAT120","APP")=HLAPPARY
 Q
CC ;
 ; find entries US" and "USA" in file #779.004
 N HLIEN,HLCC
 S HLIEN=0
 F  S HLIEN=$O(^HL(779.004,HLIEN)) Q:'HLIEN  D
 . I $D(^HL(779.004,HLIEN,0)) D
 .. S HLCC=$P(^HL(779.004,HLIEN,0),"^")
 .. I (HLCC="US")!(HLCC="USA") D
 ... ; no duplicate country code is assumed
 ... S HLCCARY(HLCC)=HLIEN
 Q
APP771 ;
 ; find pointer in file #771, pointing to entries US" in file #779.004
 N HLIEN,HLCCPTR,HLCCPNEW
 S HLIEN=0
 Q:'$G(HLCCARY("US"))
 Q:'$G(HLCCARY("USA"))
 ;
 F  S HLIEN=$O(^HL(771,HLIEN)) Q:'HLIEN  D
 . I $D(^HL(771,HLIEN,0)) D
 .. S HLCCPTR=$P(^HL(771,HLIEN,0),"^",7)
 .. S HLCCPNEW=0
 .. I HLCCPTR>0,HLCCPTR=HLCCARY("US") D
 ... ;
 ... ; redirect pointer for field #771,7
 ... S $P(^HL(771,HLIEN,0),"^",7)=HLCCARY("USA")
 ... S HLAPPARY(HLIEN,HLCCARY("US"))=HLCCARY("USA")
 ;
 ; delete entry "US" from file #779.004
 N DA,DIK
 S DIK="^HL(779.004,"
 S DA=HLCCARY("US")
 D ^DIK
 Q
POST ;
 ; enable identifier for file  #779.004
 S ^DD(779.004,0,"ID",2)="W "_""""_"   "_""""_",$P(^(0),U,2)"
 ;
 N FDA,IEN,IENS,VUID,IFN
 ;
 S IFN=779.00409
 K FDA
 ;
 S VUID=0
 F  S VUID=$O(^HL(779.004,"AMASTERVUID",VUID)) Q:'VUID  D
 .S IEN=$O(^HL(779.004,"AMASTERVUID",VUID,1,0)) Q:'IEN
 .K ^HL(779.004,IEN,"TERMSTATUS")
 .S IENS=IEN_","
 .K FDA
 .S FDA(IFN,"?+1,"_IENS,.01)=$$NOW^XLFDT
 .S FDA(IFN,"?+1,"_IENS,.02)=1
 .D UPDATE^DIE(,"FDA")
 ;
 Q
 ;
