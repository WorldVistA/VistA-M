XU8P755P ;OAK/RSD - Post Install routine for patch XU*8*755
 ;;8.0;KERNEL;**755**;Jul 10, 2021;Build 6
 ;Re-index the 2 new cross references
 N DIK
 S DIK="^XPD(9.6,",DIK(1)=".01^D" D ENALL^DIK
 S DIK="^XPD(9.7,",DIK(1)=".01^C" D ENALL^DIK
 ;resave ZISHONT to %ZISH.  This was missed in patch XU*8*738
 D PATCH^ZTMGRSET(738)
 Q
