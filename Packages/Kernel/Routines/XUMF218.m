XUMF218 ;OIFO-OAK/RAM - Load DOD DMIS ID's;04/15/02
 ;;8.0;KERNEL;**218**;Jul 10, 1995
 ;
 ; $$PARAM^HLCS2 call supported by IA #3552
 ;
 Q
 ;
MAIN ; -- main
 ;
 I $$CNT<1000 Q
 ;
 D BG
 ;
 Q
 ;
BG ; -- background job
 ;
 N ZTRTN,ZTDESC,ZTDTH
 ;
 S ZTRTN="EN^XUMF218"
 S ZTDESC="XUMF Load DOD DMIS ID's"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 ;
 D ^%ZTLOAD
 ;
 Q
 ;
EN ; -- entry point
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
 D EN^XUMF218A
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
 S PARAM("CDSYS")="DMIS"
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
 K ^TMP("XUMF ARRAY",$J),^TMP("XUMF MFS",$J),^TMP("DIERR",$J)
 ;
 L -^TMP("XUMF ARRAY",$J)
 ;
 S ZTREQ="@"
 ;
 Q
 ;
