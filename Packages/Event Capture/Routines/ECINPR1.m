ECINPR1 ;BIR/JPW-After Commit Pre Init for Event Capture ;3 Apr 96
 ;;2.0; EVENT CAPTURE ;;8 May 96
EN ;deleting entries from file 723
 D MES^XPDUTL("Deleting entries from the MEDICAL SPECIALTY file (#723)...")
 S DIK="^ECC(723,",EC=0 F  S EC=$O(^ECC(723,EC)) Q:'EC  I $D(^ECC(723,EC,0)) S DA=EC D ^DIK
 K DA,DIK,EC
 D MES^XPDUTL("Entries deleted")
 Q
