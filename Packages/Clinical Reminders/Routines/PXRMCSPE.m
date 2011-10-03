PXRMCSPE ; SLC/PKR - Entry points for CSV protocol event point. ;11/03/2003
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
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
 D DLG^PXRMCSD("ICPT")
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
 D DLG^PXRMCSD("ICD9")
 S ZTREQ="@"
 Q
 ;
