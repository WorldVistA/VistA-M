MCFIXOEP ;HIRMFO/DAD-PROTOCOL DELETION ;5/2/96  13:30
 ;;2.3;Medicine;;09/13/1996
 N TEMP,DA
 S TEMP=$O(^ORD(101,"B","GMRCACT NEW PATIENT",0))
 S DA(1)=$O(^ORD(101,"B","GMRCACTM MEDICINE PKG MENU",0))
 S DA=$O(^ORD(101,+DA(1),10,"B",+TEMP,0))
 D @$S(DA="":"END",DA(1)="":"END",TEMP="":"END",1:"DEL")
END ;
 Q
DEL ;
 S DIK="^ORD(101,"_DA(1)_",10," D ^DIK
 W !,"The 'Select Patient' protocol was removed from the Medicine Pkg Menu, OE/RR protocol.",!
 Q
