XUMF567 ;BP/RAM - INSTITUTION DUP FIX ;06/28/00
 ;;8.0;KERNEL;**567**;Jul 10, 1995;Build 8
 ;
 ;
 Q
 ;
MAIN ;
 ;
 Q:$$KSP^XUPARAM("INST")=12000
 ;
 M ^TMP("XUMF 04",$$NOW^XLFDT,$J,4)=^DIC(4)
 ;
 S XUMF=1
 ;
 D DUP,BK
 ;
 Q
 ;
KT ; -- kill temp node / file backup
 ;
 K ^TMP("XUMF 04")
 ;
 Q
 ;
BK ; -- background job to kill temp node in 30 days
 ;
 N ZTRTN,ZTDESC,ZTDTH
 ;
 S ZTRTN="KT^XUMF567"
 S ZTDESC="XUMF kill temp backup of file 4 - patch xu549"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,30,0,0,0)
 S ZTIO=""
 ;
 D ^%ZTLOAD
 ;
 Q
 ;
DUP ; RESOLVE DUPLICATE RECORDS
 ;
 N NAME,IEN,IENS,FDA,XUMF,STA
 ;
 S STA=""
 F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  D
 .S IEN=$O(^DIC(4,"D",STA,0)) Q:'$O(^DIC(4,"D",STA,IEN))
 .F  S IEN=$O(^DIC(4,"D",STA,IEN)) Q:'IEN  D
 ..S XUMF=1
 ..S NAME=$P(^DIC(4,IEN,0),U)
 ..S IENS=IEN_","
 ..K FDA
 ..S FDA(4,IENS,.01)=$E("ZZ DUP "_NAME,1,30)
 ..S FDA(4,IENS,101)="INACTIVE"
 ..S FDA(4,IENS,99)="@"
 ..D FILE^DIE("E","FDA")
 ;
 Q
 ;
EXIT ; -- cleanup, and quit
 ;
 Q
 ;
