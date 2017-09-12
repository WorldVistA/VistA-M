FBXIP35 ;WOIFO/SS-PATCH INSTALL ROUTINE ;6/29/01
 ;;3.5;FEE BASIS;**35**;JAN 30, 1995
 Q
PS ;post-install entry point
 ;reindex "B" cross-ref for 162.03 .01 field
 N DA,DIK
 S DIK(1)=".01^B"
 S DA(3)=0
 F  S DA(3)=$O(^FBAAC(DA(3))) Q:+DA(3)=0  D
 . S DA(2)=0
 . F  S DA(2)=$O(^FBAAC(DA(3),1,DA(2))) Q:+DA(2)=0  D
 . . S DA(1)=0
 . . F  S DA(1)=$O(^FBAAC(DA(3),1,DA(2),1,DA(1))) Q:+DA(1)=0  D
 . . . S DA=0
 . . . F  S DA=$O(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA)) Q:+DA=0  D
 . . . . S DIK="^FBAAC("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,"
 . . . . D EN1^DIK
 Q
