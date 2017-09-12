XU8P125 ;SF-CIOFO/JDS  Post Init for XU*8*125 ;10/01/99  10:28
 ;;KID's Post Init
 ;
EN ;
 N DA,DIK
 K ^XTV(8992,"AXQA")
 K ^XTV(8992,"AXQAN")
 S DA(1)=0
 F  S DA(1)=$O(^XTV(8992,DA(1))) Q:DA(1)'>0  D
 . S DIK="^XTV(8992,"_DA(1)_",""XQA"","
 . S DIK(1)=".02^AXQA^AXQAN"
 . D ENALL^DIK
 Q
