DG53P766 ;ALB/JAT DELETE RECORDS ;5/10/07
 ;;5.3;Registration;**766**;Aug 13, 1993;Build 3
 N DA,DIK
 S DIK="^DGCN(391.98,"
 S DA=0
 F  S DA=$O(^DGCN(391.98,DA)) Q:'DA  D ^DIK
 S DIK="^DGCN(391.99,"
 S DA=0
 F  S DA=$O(^DGCN(391.99,DA)) Q:'DA  D ^DIK
 ; delete any dangling cross-references
 N DGJ
 S DGJ=""
 F  S DGJ=$O(^DGCN(391.98,DGJ)) Q:DGJ=""  D
 .Q:DGJ=0
 .K ^DGCN(391.98,DGJ)
 S DGJ=""
 F  S DGJ=$O(^DGCN(391.99,DGJ)) Q:DGJ=""  D
 .Q:DGJ=0
 .K ^DGCN(391.99,DGJ)
 Q
