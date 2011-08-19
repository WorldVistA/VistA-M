XUMF390 ;ISS/RAM - Load CLIA & MAMMO ID's;12/15/05
 ;;8.0;KERNEL;**390**;Jul 10, 1995
 ;
 ; $$PARAM^HLCS2 call supported by IA #3552
 ;
 Q
 ;
MAIN ; -- main
 ;
 D LINK,BG
 ;
 Q
 ;
BG ; -- background job
 ;
 N ZTRTN,ZTDESC,ZTDTH
 ;
 S ZTRTN="EN^XUMF390"
 S ZTDESC="XUMF Load CLIA ID's"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 ;
 D ^%ZTLOAD
 ;
 Q
 ;
EN ; -- entry point
 ;
 D LOAD^XUMF(4)
 ;
 K ^TMP("XUMF ARRAY",$J)
 ;
 N PARAM,XUMFLAG,ERROR,TEST
 ;
 S (ERROR,XUMFLAG,TEST)=0
 ;
 I $P($$PARAM^HLCS2,U,3)="T" S TEST=1
 ;
 L +^TMP("XUMF ARRAY",$J):0 D:'$T
 .S ERROR="1^another process is using the Master File Server"
 ;
 I ERROR D EXIT Q
 ;
 D MFS0
 ;
 I ERROR D EXIT Q
 ;
 I '$D(^TMP("XUMF ARRAY",$J)) D
 .S ERROR="1^Connection to master file server failed!"
 ;
 I ERROR D EXIT Q
 ;
 D CLIA
 ;
 I ERROR D EXIT Q
 ;
 ; -- get MAMMO
 ; 
 K ^TMP("XUMF ARRAY",$J),^TMP("XUMF MFS",$J)
 ;
 D MFS1
 ;
 I ERROR D EXIT Q
 ;
 I '$D(^TMP("XUMF ARRAY",$J)) D
 .S ERROR="1^Connection to master file server failed!"
 ;
 I ERROR D EXIT Q
 ;
 D MAMMO
 ;
 D EXIT
 ;
 Q
 ;
MFS0 ; -- get CLIA from Institution Master File
 ;
 S PARAM("CDSYS")="CLIA"
 S PARAM("LLNK")="XUMF MFR^XUMF "_$S('TEST:"FORUM",1:"TEST")
 S PARAM("PROTOCOL")=$O(^ORD(101,"B","XUMF MFQ",0))
 ;
 D MAIN^XUMFP(4,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFI(4,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFH
 ;
 Q
 ;
MFS1 ; -- get ACR# from Institution Master File
 ;
 S PARAM("CDSYS")="MAMMO-ACR"
 S PARAM("LLNK")="XUMF MFR^XUMF "_$S('TEST:"FORUM",1:"TEST")
 S PARAM("PROTOCOL")=$O(^ORD(101,"B","XUMF MFQ",0))
 ;
 D MAIN^XUMFP(4,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFI(4,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFH
 ;
 Q
 ;
EXIT ; -- cleanup and quit
 ;
 K ^TMP("XUMF ARRAY",$J),^TMP("XUMF MFS",$J),^TMP("DIERR",$J)
 ;
 L -^TMP("XUMF ARRAY",$J)
 ;
 S ZTREQ="@"
 ;
 Q
 ;
CLIA ; -- add CLIA ID to Institution file
 ;
 N ID,NAME,FDA,ERROR,IEN,IENS,X,XUMF,STANUM,OFNME,AGENCY
 ;
 S XUMF=1
 ;
 S ID=""
 F  S ID=$O(^TMP("XUMF ARRAY",$J,ID)) Q:ID=""  D
 .S X=^TMP("XUMF ARRAY",$J,ID)
 .S STANUM=$P(X,U,3)
 .S IEN=$$IEN^XUMF(4,"CLIA",ID)
 .I 'IEN,$G(STANUM)'="" S IEN=$O(^DIC(4,"D",STANUM,0))
 .Q:'IEN
 .S IENS="?+1,"_IEN_","
 .K FDA
 .S FDA(4.9999,IENS,.01)="CLIA"
 .S FDA(4.9999,IENS,.02)=ID
 .D UPDATE^DIE("E","FDA")
 ;
 Q
 ;
MAMMO ; -- add MAMMO ID to Institution file
 ;
 N ID,NAME,FDA,ERROR,IEN,IENS,X,XUMF,STANUM
 ;
 S XUMF=1
 ;
 S ID=""
 F  S ID=$O(^TMP("XUMF ARRAY",$J,ID)) Q:ID=""  D
 .S X=^TMP("XUMF ARRAY",$J,ID)
 .S STANUM=$P(X,U,3)
 .S IEN=$$IEN^XUMF(4,"MAMMO-ACR",ID)
 .I 'IEN,$G(STANUM)'="" S IEN=$O(^DIC(4,"D",STANUM,0))
 .Q:'IEN
 .S IENS="?+1,"_IEN_","
 .K FDA
 .S FDA(4.9999,IENS,.01)="MAMMO-ACR"
 .S FDA(4.9999,IENS,.02)=ID
 .D UPDATE^DIE("E","FDA")
 ;
 Q
 ;
LINK ;
 ;
 N IEN,FDA,IENS
 ;
 S IEN=$$FIND1^DIC(870,,"BX","XUMF ACK")
 S IENS=IEN_","
 ;
 K FDA
 S FDA(870,IENS,4.5)=1
 D UPDATE^DIE(,"FDA")
 ;
 S IEN=$$FIND1^DIC(870,,"BX","XUMF FORUM")
 S IENS=IEN_","
 ;
 K FDA
 S FDA(870,IENS,4.5)=1
 D UPDATE^DIE(,"FDA")
 ;
 Q
 ;
