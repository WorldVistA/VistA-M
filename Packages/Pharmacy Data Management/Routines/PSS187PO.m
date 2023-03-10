PSS187PO ;BIR/MA - Post install reindexing xrefs ;Dec 06, 2021@08:18:18
 ;;1.0;PHARMACY DATA MANAGEMENT;**187**;9/30/97;Build 27
 Q
POST ;
 D MES^XPDUTL("===================================================================")
 D MES^XPDUTL("Start reindexing INDICATIONS FOR USE and OTHER LANGUAGE INDICATIONS")
 D MES^XPDUTL("of PHARMACY ORDERABLE ITEM file (#50.7).")
 D EN
 D BMES^XPDUTL("Completed Reindexing ..............................................")
 D MES^XPDUTL("===================================================================")
 ;
EN ;
 K DIK,DA S DA(1)=0 F  S DA(1)=$O(^PS(50.7,DA(1))) Q:'DA(1)  D
 . S DIK="^PS(50.7,"_DA(1)_","_"""IND"""_",",DIK(1)=".01" D ENALL2^DIK S DA="" D ENALL^DIK S DA=""
 K DIK,DA S DA(1)=0 F  S DA(1)=$O(^PS(50.7,DA(1))) Q:'DA(1)  D
 . S DIK="^PS(50.7,"_DA(1)_","_"""INDO"""_",",DIK(1)=".01" D ENALL2^DIK S DA="" D ENALL^DIK S DA=""
 Q
 ;
