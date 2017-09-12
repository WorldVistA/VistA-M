ENXVIPR ;WIRMFO/SAB- PRE-INIT ;6/25/97
 ;;7.0;ENGINEERING;**39**;Aug 17, 1993
 N DA,DIK,ENI
 ; Delete STATION NUMBER field in CMR file to remove AH x-ref
 S DIK="^DD(6914.1,",DA=5,DA(1)=6914.1 D ^DIK K DA,DIK
 ; Kill obsolete AC x-ref in CMR file (#6914.1)
 K ^ENG(6914.1,"AC")
 ; delete DJ edit screens
 S DIK="^ENG(6910.9,"
 F ENI="ENEQ2","ENEQ2D","ENEQ3","ENEQ3D","ENEQNX2" D
 . S DA=$O(^ENG(6910.9,"B",ENI,0))
 . D:DA>0 ^DIK
 K DIK
 Q
 ;ENXVIPR
