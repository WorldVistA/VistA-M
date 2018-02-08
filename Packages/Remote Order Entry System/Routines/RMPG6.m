RMPG6 ;DDC/KAW-ROES PATCH RMPF*2.0*9-AHS [ 01/28/98  9:30 AM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**9**;1/21/98
 W @IOF,!,"ROES PATCH:  RMPF*2.0*9"
 W !!,"This patch will inactivate old Custom Hearing Aid models and components"
 W !,"and add new models, makes and components for the Custom Hearing Aid"
 W !,"contracts that take affect on February 1, 1998.  Only ROES users must be"
 W !,"off of the system while running the patch.  These contract changes will"
 W !,"take affect on February 1, 1998, at the DDC, so this patch should"
 W !,"be installed between COB 1/30/98 and the morning of 2/2/98 at your station."
  W !!,"The only files affected are:"
 W !!?10,"791811   - REMOTE INVENTORY PRODUCT"
 W !?10,"791811.2 - HEARING AID COMPONENTS"
 W !?10,"791811.3 - BATTERY FILE",!
 W !!,"Inactivating old models and components"
 S RMPFX=0
 F  S RMPFX=$O(^RMPF(791811,RMPFX)) Q:'RMPFX  D
 .S X=$P($G(^RMPF(791811,RMPFX,0)),U,3) Q:'X  S NM=$P(^(0),U,1)
 .Q:'$D(^RMPF(791811.1,X,0))  Q:$P(^(0),U,1)'="CUSTOM HEARING AIDS"
 .S DIE="^RMPF(791811,",DA=RMPFX,DR="999////1" D ^DIE W "."
 .K ^RMPF(791811,RMPFX,101),^(102)
 D ^RMPG6A
 W !!,"Update Complete"
END K BP,BT,BX,CA,%,CD,CP,CS,CX,DLAYGO,DQ,D0,DI,DA,DR,DIC,DIE,IX,IY,IZ,MD,MP,NM,ST,SX,X,Y,RMPFX Q
SET1 I '$D(^RMPF(791811,MP,101,0)) S ^RMPF(791811,MP,101,0)="^791811.0101PA"
 Q:$D(^RMPF(791811,MP,101,"B",CX))
 S DIC="^RMPF(791811,"_MP_",101,",X=CX,DIC(0)="L",DLAYGO=791811
 S DIC("DR")=".02////"_CS,DA(1)=MP K DD,DO D FILE^DICN K DIC
 I Y=-1 W !!,CP," not added."
 Q
SET2 I '$D(^RMPF(791811,MP,102,0)) S ^RMPF(791811,MP,102,0)="^791811.0102PA"
 Q:$D(^RMPF(791811,MP,102,"B",BP))
 S DIC="^RMPF(791811,"_MP_",102,",X=BP,DIC(0)="L",DLAYGO=791811
 S DA(1)=MP K DD,DO D FILE^DICN K DIC
 I Y=-1 W !!,BP," not added."
 Q
