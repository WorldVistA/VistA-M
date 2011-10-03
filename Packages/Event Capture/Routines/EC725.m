EC725 ;BIR/CML,JPW-Updates for File 725 ;28 Aug 96
 ;;2.0; EVENT CAPTURE ;**2**;8 May 96
 ;
CHECK ; check entries and in file 725
 D MES^XPDUTL("Updating existing entry ""PC-THEODICY-PT SPIRITUAL"" to ""PC-THEODICY-UNFAIRNESS OF GOD/LIFE 14091""...")
 S EC1=$P($G(^EC(725,58,0)),"^")
 S ECA="PC-THEODICY-UNFAIRNESS OF GOD/LIFE 14091"
 S $P(^EC(725,58,0),"^")=ECA
 K ^EC(725,"B",EC1,58) S ^EC(725,"B",ECA,58)=""
 D MES^XPDUTL("Entry updated.")
 K EC1,ECA
 Q
