RMPR117P ;VMP/RB - DELETE FIELD# 19 FOR FILE #660 ;11/7/05
 ;;3.0;Prosthetics;**117**;06/20/05
 ;;
 ;1. Post install to delete in ^DD for file #660, field 19 (if exists) 
 ;
FIX1 ;DELETE FIELD 19 FROM FILE #660 IF EXISTS
 Q:'$D(^DD(660,19,0))
 S DIK="^DD(660,",DA=19,DA(1)=660
 D ^DIK
 K DIK,DA
 Q
