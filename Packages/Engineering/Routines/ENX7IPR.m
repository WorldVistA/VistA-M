ENX7IPR ;WIRMFO/DH-PRE-INIT ;9.29.98
 ;;7.0;ENGINEERING;**55**;Aug 17, 1993
 ; delete old DJ edit screens - will be reloaded
 N DA,DIK,ENI
 S DIK="^ENG(6910.9,"
 F ENI="ENEQ2","ENEQ2D","ENEQNX2" D
 . S DA=$O(^ENG(6910.9,"B",ENI,0))
 . D:DA>0 ^DIK
 ; need to delete x-refs at test sites
 S DIK="^DD(6914,",DA=78,DA(1)=6914 D ^DIK
 I $D(^DD(6914,82)) D
 . S DA=82,DA(1)=6914
 . D ^DIK
 Q
 ;ENX7IPR
