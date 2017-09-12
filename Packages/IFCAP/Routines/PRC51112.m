PRC51112 ;VMP/TJH - PRE & POST INSTALL INDEX CLEAN-UP FOR *112; 09/13/2007
 ;;5.1;IFCAP;**112**;Oct 20, 2000;Build 2
 ;
TOP ; No entry at top
 Q
 ;
PRE ; Pre-install segment
 ; remove the UNQ, UNQ1 and UNQ3 xref definitions from the Data Dictionary
 ; and Kill the existing index entries.
 D BMES^XPDUTL("Removing old 'UNQ' cross reference.......")
 D DELIX^DDMOD(420.14,.01,"UNQ","K")
 D DELIX^DDMOD(420.14,2,"UNQ1","K",)
 D DELIX^DDMOD(420.14,3,"UNQ3","K",)
 ; if there are any 'dangling' entries in the index, remove them too
 N PRC D
 . Q:'$D(^PRCD(420.14,"UNQ"))
 . S PRC=""
 . F  S PRC=$O(^PRCD(420.14,"UNQ",PRC)) Q:PRC=""  K ^PRCD(420.14,"UNQ",PRC)
 D BMES^XPDUTL("Removal complete.")
 D MES^XPDUTL("Installing new cross reference definition.")
XPRE Q  ; end of Pre-install processing
 ;
 ;
POST ; Post-install segment
 ; re-index file 420.14 using the New Style "UNQ" xref
 D BMES^XPDUTL("New 'UNQ' definition installed.")
 D MES^XPDUTL("Re-indexing.....")
 S DIK="^PRCD(420.14,",DIK(1)=".01^UNQ"
 D ENALL^DIK
 D BMES^XPDUTL("New 'UNQ' cross reference complete.")
XPOST Q
