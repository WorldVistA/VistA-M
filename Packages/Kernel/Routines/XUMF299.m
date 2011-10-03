XUMF299 ;ISS/RAM - Query Master File Parameters;04/15/02
 ;;8.0;KERNEL;**299**;Jul 10, 1995
 ;
 ; $$PARAM^HLCS2 call supported by IA #3552
 ;
 Q
 ;
MAIN ; -- main
 ;
 N ZTRTN,ZTDESC,ZTDTH
 ;
 S ZTRTN="EN^XUMF299"
 S ZTDESC="XUMF query MFS for file parameters"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 S ZTSAVE("IEN")=""
 S ZTSAVE("IFN")=""
 ;
 D ^%ZTLOAD
 ;
 Q
 ;
EN ; -- entry point
 ;
 N PARAM,ERROR,TEST
 ;
 S (ERROR,TEST)=0
 ;
 I $P($$PARAM^HLCS2,U,3)="T" S TEST=1
 ;
 ; -- get Master File Parameters
 ;
 S PARAM("LLNK")="XUMF MFP MFR^XUMF "_$S('TEST:"FORUM",1:"TEST")
 S PARAM("PROTOCOL")=$$FIND1^DIC(101,,"B","XUMF MFP MFQ")
 ;
 D MAIN^XUMFXP(4.001,IEN,5,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFXI(4.001,IEN,5,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFHPR
 ;
EXIT ; -- cleanup and quit
 ;
 K ^TMP("XUMF MFS",$J),^TMP("DIERR",$J)
 ;
 S ZTREQ="@"
 ;
 Q
 ;
