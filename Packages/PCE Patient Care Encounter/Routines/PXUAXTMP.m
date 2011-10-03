PXUAXTMP ;ISA/KWP - PCE XTMP UTILITY;3/29/1999
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**67**;AUG 12, 1996
 ;
CREATE(PXXTMP,PXXTMP2,PXPRGNO,PXDESC,PXDATA) ;
 ;+ PXXTMP -unique subscript for XTMP
 ;+ PXXTMP2 -secondary subscript
 ;+ PXPRGNO -number of days to increment from today for purge
 ;+ PXDESC -description of XTMP
 ;+ PXDATA -for secondary entry
 ;+ returns -0 failed
 ;+  1 successful
 N PXTMP S PXXTMP=$G(PXXTMP,"PXXTMP")
 I $E(PXXTMP,1,2)'="PX" Q 0
 S PXPRGNO=$G(PXPRGNO,365)
 I '$D(^XTMP(PXXTMP)) D
 .N PXPURGE,PXCREATE S PXTMP="^XTMP("_""""_PXXTMP_""""_",0)"
 .L +@PXTMP:300
 .S PXCREATE=$$DT^XLFDT
 .S PXPURGE=$$HTFM^XLFDT($H+PXPRGNO)
 .S @PXTMP=PXCREATE_"^"_PXPURGE_"^"_PXDESC
 .L -@PXTMP
 I '$G(PXXTMP2) Q 1
 S PXTMP="^XTMP("_""""_PXXTMP_""""_","_""""_PXXTMP2_""""_")"
 L +@PXTMP:300
 S @PXTMP=$G(PXDATA)
 L -@PXTMP
 Q 1
DELETE(PXXTMP,PXXTMP2) ;
 N PXTMP
 S PXTMP="^XTMP("_""""_PXXTMP_""""_")"
 I $G(PXXTMP2)'="" G SKIP
 L +@PXTMP:300
 K @PXTMP
 L -@PXTMP
 Q
SKIP S PXTMP="^XTMP("_""""_PXXTMP_""""_","_""""_PXXTMP2_""""_")"
 L +@PXTMP:300
 K @PXTMP
 L -@PXTMP
 Q
