PXCSPE ; SLC/PKR - Entry points for Code Setup update protocol event point. ;04/13/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 Q
 ;
 ;==================================================
CPTPE ;CPT code set update
 S ZTDESC="PCE CPT code set update"
 S ZTDTH=$H
 S ZTIO=""
 S ZTRTN="CPT^PXCSPE"
 D ^%ZTLOAD
 D BMES^XPDUTL("PCE CPT Code Update - Task Number "_ZTSK_" queued.")
 Q
 ;
 ;==================================================
CPT ;Do the CPT update.
 D CSU^PXMCICHK("CPT")
 S ZTREQ="@"
 Q
 ;
 ;==================================================
ICDPE ;ICD code set update.
 S ZTDESC="PCE ICD code set update"
 S ZTDTH=$H
 S ZTIO=""
 S ZTRTN="ICD^PXCSPE"
 D ^%ZTLOAD
 D BMES^XPDUTL("PCE ICD Code Update - Task Number "_ZTSK_" queued.")
 Q
 ;
 ;==================================================
ICD ;Do the ICD update.
 D CSU^PXMCICHK("ICD")
 S ZTREQ="@"
 Q
 ;
