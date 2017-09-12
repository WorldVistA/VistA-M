ENXPIPR ;WIRMFO/SAB-PRE-INIT ;4.11.97
 ;;7.0;ENGINEERING;**35**;AUG 17,1993
 ;
 N DA,DIK,ENFDA,ENI
 ;
 ; *** test site only section - remove for national release
 ;K DA S DIK="^DD(6914,",DA=5,DA(1)=6914 D ^DIK K DA,DIK
 ; *** end test site only section
 ;
DSCR ; delete DJ edit screens
 S DIK="^ENG(6910.9,"
 F ENI="ENEQ1","ENEQ1D","ENEQ1E","ENEQ1S","ENEQ2","ENEQ2D","ENEQ2E","ENEQ2S","ENEQ3","ENEQ3D","ENEQ3S","ENEQNX1","ENEQNX2","ENEQNX3" D
 . S DA=$O(^ENG(6910.9,"B",ENI,0))
 . D:DA>0 ^DIK
 K DIK
 ;
WOMFG ; Delete Manufacturer (#21.9) field to remove obsolete trigger x-ref
 K DA S DIK="^DD(6920,",DA=21.9,DA(1)=6920 D ^DIK K DA,DIK
 ;
 Q:$$PATCH^XPDUTL("EN*7.0*35")  ; only do remaining stuff the 1st time
 ;
ENSO ;  Delete PM DEVICE TYPE IDENTIFIER from Engineering Software Options
 ;  EQUIPMENT CATEGORY & MANUFACTURER EQUIPMENT NAME will now be printed
 S DA=$O(^ENG(6910.2,"B","PM DEVICE TYPE IDENTIFIER",0))
 I DA>0 S DIK="^ENG(6910.2," D ^DIK K DIK
 ;
BULL ; Remove mail group EN NEW EQUIPMENT from bulletin EN NEW EQUIPMENT
 S ENI=$$FIND1^DIC(3.6,"","X","EN NEW EQUIPMENT","B")
 I ENI S ENI(1)=$$FIND1^DIC(3.62,","_ENI_",","X","EN NEW EQUIPMENT","B")
 I ENI,ENI(1) D
 . K ENFDA S ENFDA(3.62,ENI(1)_","_ENI_",",.01)="@"
 . D FILE^DIE("","ENFDA") D MSG^DIALOG()
 ;
TEMPL ; Delete Local Input Templates
 ; Only done during initial install
 I '$$PATCH^XPDUTL("EN*7.0*35") D
 . N ENY
 . D LINPT^ENXPIEN
 . I $D(ENY) D
 . . N DA,DIK,ENX
 . . D MES^XPDUTL("  Deleting local versions of patched input templates")
 . . S DIK="^DIE("
 . . S ENX("L")="" F  S ENX("L")=$O(ENY("INP",ENX("L"))) Q:ENX("L")=""  D
 . . . S DA=$P(ENY("INP",ENX("L")),U)  D ^DIK
 . . . D MES^XPDUTL("    "_ENX("L")_" deleted.")
 ;
PM I $G(XPDQUES("PREPM")) D
 . S X="T+1@2300",%DT="T" D ^%DT S ZTDTH=Y
 . S ZTRTN="PM^ENPAT35",ZTIO=""
 . S ZTDESC="Delete old incomplete PM Work Orders"
 . D ^%ZTLOAD
 Q
 ;ENXPIPR
