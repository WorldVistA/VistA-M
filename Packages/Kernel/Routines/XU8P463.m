XU8P463 ;ISF/RWF - POST-INIT FOR XU*8*463 ;6/21/07  09:54
 ;;8.0;KERNEL;**463**;Jul 10, 1995;Build 4
 Q
POST ;
 D TT,PROT
 Q
TT ;Clean-up the TT DD's.
 N DIK,DA,DIE,%
 I $E($G(^DD(3.2,5,0)),1)="*" D
 . F DA=0:0 S DA=$O(^%ZIS(2,DA)) Q:'DA  S %=$G(^(DA,1)) I $L($P(%,U,5)) S $P(^(1),U,5)=""
 . S DIK="^DD(3.2,",DA=5,DA(1)=3.2 D ^DIK
 . Q
 I $G(^DD(3.2,5.2,1,1,"%D",1,0))["temporary trigger" D
 . S DIK="^DD(3.2,DA(1),1,",DA=1,DA(1)=5.2,DA(2)=3.2 D ^DIK
 . Q
 Q
PROT ; add 'Edit a Protocol' option into the 'Menu Management' menu.
 N XUS
 S XUS=$$ADD^XPDMENU("XUMAINT","XUPROTOCOL EDIT")
 Q
