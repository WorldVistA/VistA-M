XUMF4L0 ;OIFO-OAK/RAM - Load IMF ;02/21/02
 ;;8.0;KERNEL;**217**;Jul 10, 1995
 ;
 ; $$PARAM^HLCS2 call supported by IA #3552
 ;
MAIN ; -- main
 ;
 Q:$$SERVER^XUMFI()
 ;
 D V23
 ;
 I $$CNT<1000 D NEVER Q
 ;
 D BG
 ;
 Q
 ;
BG ; -- background job
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO
 ;
 S ZTRTN="EN^XUMF4L0"
 S ZTDESC="XUMF Institution file background cleanup"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 ;
 D ^%ZTLOAD
 ;
 Q
 ;
EN ; -- entry point
 ;
 D UPDATE,LOCAL^XUMF4L2,NVS^XUMF4L2,EXIT Q
 ;
 Q
 ;
UPDATE ; -- get FACILITY TYPE, update, get INSTITUTION, update
 ;
 ; -- get FACILITY TYPE
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
 I '$D(^TMP("XUMF ARRAY",$J)) D  D EXIT Q
 .S ERROR="1^Connection to master file server failed!"
 ;
 ; -- update
 D FTCLEAN^XUMF4A I ERROR D EXIT Q
 ;
 ; -- get INSTITUTION
 K ^TMP("XUMF ARRAY",$J),^TMP("XUMF MFS",$J)
 ;
 D MFS1
 ;
 I ERROR D EXIT Q
 ;
 I '$D(^TMP("XUMF ARRAY",$J)) D  Q
 .S ERROR="1^Connection to master file server failed!"
 .D EXIT
 ;
 ; -- update
 D EN^XUMF4L1
 ;
 D EXIT
 ;
 Q
 ;
MFS0 ; -- get national facility type file from Master File Server
 ;
 S PARAM("LLNK")="XUMF MFR^XUMF "_$S('TEST:"FORUM",1:"TEST")
 S PARAM("PROTOCOL")=$O(^ORD(101,"B","XUMF MFQ",0))
 ;
 D MAIN^XUMFP(4.1,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFI(4.1,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFH
 ;
 Q
 ;
MFS1 ; -- get national facility type file from Master File Server
 ;
 S PARAM("LLNK")="XUMF MFR^XUMF "_$S('TEST:"FORUM",1:"TEST")
 S PARAM("PROTOCOL")=$O(^ORD(101,"B","XUMF MFQ",0))
 ;
 D MAIN^XUMFP(4,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFI(4,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFH
 ;
 Q
 ;
 ;
CNT() ; -- count station numbers in Institution file
 ;
 N STA,CNT
 ;
 S STA="" F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  S CNT=$G(CNT)+1
 ;
 Q CNT
 ;
EXIT ; -- cleanup and quit
 ;
 K ^TMP("XUMF ADD",$J),^TMP("XUMF MOD",$J),^TMP("XUMF DEL",$J)
 K ^TMP("XUMF ARRAY",$J),^TMP("XUMF MFS",$J),^TMP("DIERR",$J)
 ;
 L -^TMP("XUMF ARRAY",$J)
 ;
 S ZTREQ="@"
 ;
 Q
 ;
V23 ; -- stuff VISN 23
 ;
 N XUMF,IENS,IEN
 ;
 S XUMF=1
 ;
 S IEN=$O(^DIC(4.1,"B","VISN",0))
 S IENS=$S(IEN:IEN_",",1:"+1,")
 ;
 K FDA
 S FDA(4.1,IENS,.01)="VISN"
 S FDA(4.1,IENS,1)="VETERANS INTEGRATED SERVICE NETWORK"
 S FDA(4.1,IENS,3)="NATIONAL"
 D UPDATE^DIE("E","FDA")
 ;
 S IEN=$O(^DIC(4,"B","VISN 23",0))
 S IENS=$S(IEN:IEN_",",1:"+1,")
 ;
 K FDA
 S FDA(4,IENS,.01)="VISN 23"
 S FDA(4,IENS,11)="LOCAL"
 S FDA(4,IENS,13)="VISN"
 D UPDATE^DIE("E","FDA")
 ;
 Q
 ;
NEVER ; -- cleanup never performed - notify site and NVS
 ;
 N XMSUB,TEXT,XMY,XMDUZ,XMTEXT
 ;
 S TEXT(1)="A check of the INSTITUTION file (#4) indicates the IFR"
 S TEXT(2)="cleanup has NOT been performed."
 S TEXT(3)=""
 S TEXT(4)="The IFR cleanup is a required action.  Future initiatives"
 S TEXT(5)="are dependant on consistent and reliable Institution data"
 S TEXT(6)="at each site.  A copy of this message is being sent to NVS"
 S TEXT(7)="for tracking purposes."
 S TEXT(8)=""
 S TEXT(9)="If you require assistance performing the IFR cleanup,"
 S TEXT(10)="you may contact NVS and someone will contact you and"
 S TEXT(11)="help you with the IFR cleanup process.  To request"
 S TEXT(12)="assistance you may send a MailMan message to the"
 S TEXT(13)="G.XUMF INSTITUTION mail group on FORUM or log a NOIS."
 S TEXT(14)=""
 S TEXT(15)="Note: Running the IFR cleanup on LEGACY systems is"
 S TEXT(16)="OPTIONAL.  If this message refers to a legacy system"
 S TEXT(17)="please disregard this message."
 ;
 S XMSUB="IFR/cleanup/REQUIRED at "_$$SITE
 S XMDUZ=$S(DUZ:DUZ,1:.5),XMY(DUZ)=""
 S XMTEXT="TEXT("
 S XMY("G.XUMF INSTITUTION")=""
 S:$P($$PARAM^HLCS2,U,3)'="T" XMY("G.XUMF INSTITUTION@FORUM")=""
 D ^XMD
 ;
 Q
 ;
SITE() ; -- facility name and sta # string
 ;
 Q $P($G(^DIC(4,+DUZ(2),0)),U)_" Sta#: "_$P($G(^DIC(4,+DUZ(2),99)),U)
 ;
