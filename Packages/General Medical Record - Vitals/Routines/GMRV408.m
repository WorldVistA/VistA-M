GMRV408 ;HIRMFO/DAD - Post Init to Add PN ;3/10/99  11:06
 ;;4.0;Vitals/Measurements;**8**;Apr 25, 1997
 N DA,DIE,DR
 D MES^XPDUTL("Adding 'PN' to the PCE ABBREVIATION field (#7)")
 D MES^XPDUTL("for the 'PAIN' entry in the GMRV VITAL TYPE")
 D MES^XPDUTL("file (#120.51).")
 S DA=+$O(^GMRD(120.51,"B","PAIN",0))
 I $P($G(^GMRD(120.51,DA,0)),U)="PAIN" D
 . S DIE="^GMRD(120.51,",DR="7///PN"
 . D ^DIE
 . Q
 E  D
 . D MES^XPDUTL("'PAIN' entry not found in the GMRV VITAL TYPE")
 . D MES^XPDUTL("file (#120.51).  'PN' not added to the PCE")
 . D MES^XPDUTL("ABBREVIATION field (#7).")
 . Q
 Q
