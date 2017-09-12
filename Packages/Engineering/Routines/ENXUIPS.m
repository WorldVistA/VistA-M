ENXUIPS ;WIRMFO/SAB- POST-INIT ;1/8/97
 ;;7.0;ENGINEERING;**41**;Aug 17, 1993
 N DA,ENDA,ENMFG,ENX
 D BMES^XPDUTL("  Searching local entries for duplicate MFG/DIV...")
 K ^TMP($J)
 S ENDA=49999 F  S ENDA=$O(^ENG("MFG",ENDA)) Q:'ENDA  D
 . S ENMFG=$P($G(^ENG("MFG",ENDA,0)),U) Q:ENMFG=""
 . S DA=0 F  S DA=$O(^ENG("MFG","B",$E(ENMFG,1,30),DA)) Q:'DA  D
 . . I DA'=ENDA,$P($G(^ENG("MFG",DA,0)),U)=ENMFG S ^TMP($J,ENMFG,DA)=""
 . I $D(^TMP($J,ENMFG)) S ^TMP($J,ENMFG,ENDA)=""
 I '$D(^TMP($J)) D MES^XPDUTL("    No duplicate MFG/DIVs were found.")
 I $D(^TMP($J)) D
 . D MES^XPDUTL("    Duplicate MFG/DIVs were found.")
 . D MES^XPDUTL("    You can use the FileMan ENTER OR EDIT FILE ENTRIES")
 . D MES^XPDUTL("    option to delete a Local entry and change all")
 . D MES^XPDUTL("    pointers to reference the corresponding National")
 . D MES^XPDUTL("    entry. Use the MFGID number to select enties.")
 . S ENMFG="" F  S ENMFG=$O(^TMP($J,ENMFG)) Q:ENMFG=""  D
 . . D BMES^XPDUTL("    Duplicate MFGR: "_ENMFG)
 . . S DA=0 F  S DA=$O(^TMP($J,ENMFG,DA)) Q:'DA  D
 . . . S ENX="        "_$S(DA<50000:"National",1:"Local")_" MFGID: "_DA
 . . . D MES^XPDUTL(ENX)
 K ^TMP($J)
 Q
 ;ENXUIPS
