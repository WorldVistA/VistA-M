XU8P440 ;ISF/RWF - Post-INIT for XU*8*440. ;01/17/2008
 ;;8.0;KERNEL;**440**;Jul 10, 1995;Build 13
 Q
POST ;Post-INIT
 D DD35,DD32,DDGBL,DD8989
 D RELOAD^ZTMGRSET
 Q
DD35 ;Remove old HUNT GROUP field #29. OLDXY is in p463
 N %,DA,DIK
 I $E($G(^DD(3.5,29,0)),1)="*" D
 . F DA=0:0 S DA=$O(^%ZIS(1,DA)) Q:'DA  S %=$G(^(DA,0)) I $L($P(%,U,10)) S $P(^(0),U,10)=""
 . S DIK="^DD(3.5,",DA=29,DA(1)=3.5 D ^DIK
 Q
 ;
DD32 ;
 N DA,DIK
 I $E($G(^DD(3.2,408,0)),1)="*" D
 . F DA=0:0 S DA=$O(^%ZIS(2,DA)) Q:'DA  K ^%ZIS(2,DA,408),^%ZIS(2,DA,409)
 . S DIK="^DD(3.2,",DA=408,DA(1)=3.2 D ^DIK
 . Q
 I $E($G(^DD(3.2,409,0)),1)="*" D
 . S DIK="^DD(3.2,",DA=409,DA(1)=3.2 D ^DIK
 . Q
 Q
 ;
DD8989 ;See that MIXED OS is a 0 or 1
 N X
 S X=$P($G(^XTV(8989.3,1,0)),"^",5)
 S $P(^XTV(8989.3,1,0),"^",5)=+X
 Q
 ;
DDGBL ;Convert any data in the 'GBL' node to match new DD.
 N DA,X,CNT
 S DA=0,CNT=0
 F  S DA=$O(^%ZIS(1,DA)) Q:'DA  I $D(^(DA,"GBL")) D
 . S X=^%ZIS(1,DA,"GBL")
 . S:$L(X) ^%ZIS(1,DA,"GBL")=1,CNT=CNT+1
 . Q
 W !,?5,CNT," 'GBL' nodes converted."
 Q
