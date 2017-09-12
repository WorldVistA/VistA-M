ECX335PT ;ALB/DKK/ESD - PATCH ECX*3.0*35 Post-Init ; 01/15/01
 ;;3.0;DSS EXTRACTS;**35**;Jan 15, 2001
 ;
 ; This cleanup routine will delete records in the CLINIC II (CLJ) 
 ; Extract file (#727.818) if corresponding entries in the CLINIC I 
 ; (CLI) Extract file (#727.816) do not exist as a result of an
 ; incomplete CLJ extract purge.
 ;
EN ;- Entry point for cleanup
 ;
 N ZTRTN,ZTDESC,ZTIO
 D BMES^XPDUTL(">>> Searching for incomplete purged CLJ extracts. If found, the incomplete")
 D MES^XPDUTL(">>> purged CLJ extract records will be deleted from file #727.818.")
 D MES^XPDUTL(">>> This purge will be queued.")
 D MES^XPDUTL("")
 ;
 ;- Task job
 S ZTRTN="DEL818^ECX335PT"
 S ZTDESC="Deleting incomplete purged CLJ Extract records (#727.818)"
 S ZTIO=""
 D ^%ZTLOAD
 D BMES^XPDUTL($S(+ZTSK:">>> Queued: Task# "_ZTSK,1:">>> Not Queued!"))
 Q
 ;
 ;
DEL818 ;- Compare CLJ with CLI extract log number and delete CLJ record if no
 ;  matching CLI record is found
 ;
 N BAT,DA,DIK,ECJ
 S BAT=0
 F  S BAT=$O(^ECX(727.818,"AC",BAT)) Q:'BAT  D
 . Q:$D(^ECX(727.816,"AC",BAT))
 . S ECJ=0
 . F  S ECJ=$O(^ECX(727.818,"AC",BAT,ECJ)) Q:'ECJ  D
 .. S DIK="^ECX(727.818,",DA=ECJ D ^DIK
 Q
