ENX6IPR ;(CIOFO-2)/DH - Pre-init for EN*7*56 ;7.10.98
 ;;7.0;ENGINEERING;**56**;Aug 17, 1993
 N DA,DIK
 ; delete corrupted DJ edit screen
 S DIK="^ENG(6910.9,"
 S DA=$O(^ENG(6910.9,"B","ENEQ2",0)) D:DA>0 ^DIK
 Q
 ;ENX6IPR
