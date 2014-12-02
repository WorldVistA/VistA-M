PXRMCSPE ; SLC/PKR - Entry points for CSV protocol event point. ;07/27/2012
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;
 Q
 ;==================================================
CPTPE ;CPT code set update
 S ZTDESC="Clinical Reminders CPT code set update"
 S ZTDTH=$H
 S ZTIO=""
 S ZTRTN="CPT^PXRMCSPE"
 D ^%ZTLOAD
 D BMES^XPDUTL("Clinical Reminder CPT Code Update - Task Number "_ZTSK_" queued.")
 Q
 ;
 ;==================================================
CPT ;Do the CPT update.
 D CSU^PXRMCSTX("CPT")
 S ZTREQ="@"
 Q
 ;
 ;==================================================
ICDPE ;ICD code set update.
 S ZTDESC="Clinical Reminders ICD code set update"
 S ZTDTH=$H
 S ZTIO=""
 S ZTRTN="ICD^PXRMCSPE"
 D ^%ZTLOAD
 D BMES^XPDUTL("Clinical Reminder ICD Code Update - Task Number "_ZTSK_" queued.")
 Q
 ;
 ;==================================================
ICD ;Do the ICD update.
 D CSU^PXRMCSTX("ICD")
 S ZTREQ="@"
 Q
 ;
