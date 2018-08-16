SR3P177 ;ALB/AAS - Patch 177 pre-install;1 Mar 12
 ;;3.0;Surgery;**177**;24 Jun 93;Build 89
 ;
EN ; 
 N FLD,X,Y,DA,DIK
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 ;
 ;Delete updated fields to remove screens.
 N FLD,X,Y,DA,DIK
 X ^%ZOSF("UCI") I Y["DEVESS" W !,"CAN'T BE RUN IN DEVESS",!,*7 Q
 ;
 F FLD=32.5,66,253,286,343,344,392,489 D
 . S DIK="^DD(130,",DA=FLD,DA(1)=130
 . D ^DIK
 ;
 ;
 S FLD=4 D
 . S DIK="^DD(130.13,",DA=FLD,DA(1)=130.13
 . D ^DIK
 ;
 S FLD=3 D
 . S DIK="^DD(130.17,",DA=FLD,DA(1)=130.17
 . D ^DIK
 ;
 S FLD=3 D
 . S DIK="^DD(130.18,",DA=FLD,DA(1)=130.18
 . D ^DIK
 ;
 S FLD=6 D
 . S DIK="^DD(130.22,",DA=FLD,DA(1)=130.22
 . D ^DIK
 ;
 S FLD=.03 D
 . S DIK="^DD(136,",DA=FLD,DA(1)=136
 . D ^DIK
