ENXOIPR ;WIRMFO/SAB-PRE INIT ;7.29.96
 ;;7.0;ENGINEERING;**33**;Aug 17, 1993
 ; correct some DJ screen field lengths
 D MES^XPDUTL("Beginning pre-init...")
 F ENSCR="ENEQ3","ENEQ3D","ENEQ3S" D
 . S ENSCRDA=$O(^ENG(6910.9,"B",ENSCR,0))
 . Q:'ENSCRDA
 . S ENFLDDA=$O(^ENG(6910.9,ENSCRDA,1,"B","FUND",0)) I ENFLDDA D
 . . S DIE="^ENG(6910.9,"_ENSCRDA_",1,",DA(1)=ENSCRDA,DA=ENFLDDA
 . . S DR=".03///^S X=6" D ^DIE
 D MES^XPDUTL("Pre-init complete.")
 Q
 ;ENXOIPR
