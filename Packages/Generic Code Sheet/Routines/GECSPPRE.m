GECSPPRE ;WISC/RFJ-version 2 pre-init                               ;28 Jun 94
 ;;2.0;GCS;;MAR 14, 1995
 N %,DA,DIC,DIK,X,Y
 ;  remove AZ cross reference for field 9 (date created) in file 2100
 ;  if the x-ref exists, remove the field, the init will re-install it
 I $D(^DD(2100,0,"IX","AZ",2100,9)) S DIK="^DD(2100,",DA(1)=2100,DA=9 D ^DIK K ^GECS(2100,"AZ")
 ;
 ;  remove C cross reference for field 9.1 (amis mo/yr) in file 2100
 ;  if the x-ref exists, remove the field, the init will re-install it
 I $D(^DD(2100,0,"IX","C",2100,9.1)) S DIK="^DD(2100,",DA(1)=2100,DA=9.1 D ^DIK K ^GECS(2100,"C")
 ;
 ;  remove AT cross reference for field 2 (transmit y/n) in 2101.12
 ;  if the x-ref exists, remove the field, the init will re-install it
 I $D(^DD(2101.12,0,"IX","AT",2101.12,2)) D
 .   S DIK="^DD(2101.12,",DA(1)=2101.12,DA=2 D ^DIK
 .   S %=0 F  S %=$O(^GECS(2101.1,%)) Q:'%  K ^GECS(2101.1,%,2,"AT")
 ;
 ;  clean up duplicates in file 2101.2
 S GECSNAME="" F  S GECSNAME=$O(^GECS(2101.2,"B",GECSNAME)) Q:GECSNAME=""  S DA=$O(^GECS(2101.2,"B",GECSNAME,0)) Q:'DA  F  S DA=$O(^GECS(2101.2,"B",GECSNAME,DA)) Q:'DA  S DIK="^GECS(2101.2," D ^DIK
 ;
 ;  remove id from 2101.2 to prevent duplicates from being installed
 K ^DD(2101.2,0,"ID",2)
 Q
