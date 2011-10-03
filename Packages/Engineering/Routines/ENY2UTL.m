ENY2UTL ;;(WIRMFO)/DH-Equipment Y2K Utilities ;11.24.98
 ;;7.0;ENGINEERING;**51,59**;August 17, 1993
LOG ;  log each change in Y2K CATEGORY
 ;  expects DA as IEN for equipment file
 N ENI,ENFDA,CAT
 S CAT=$P($G(^ENG(6914,DA,11)),U)
 D NOW^%DTC
 S ENI(1)=DA,ENFDA(6918,"?+1,",.01)=DA
 S ENFDA(6918.01,"?+2,?+1,",.01)=%
 S ENFDA(6918.01,"?+2,?+1,",1)=CAT
 S ENFDA(6918.01,"?+2,?+1,",2)=DUZ
 D UPDATE^DIE("","ENFDA","ENI") D MSG^DIALOG()
 Q
 ;
COST ; remove Y2K expectancies when appropriate, including open work order
 ; expects DA as IEN for equipment file
 Q:'$D(DA)  Q:'$D(^ENG(6914,DA,11))
 N EQDA,WODA
 S EQDA=DA I "^NC^NA^"[(U_$P(^ENG(6914,DA,11),U)_U) D
 . S X=^ENG(6914,DA,11) F J=2,3,4,5,7,10 S $P(X,U,J)=""
 . S ^ENG(6914,DA,11)=X
 . S WODA=$P(X,U,8) I WODA,$D(^ENG(6920,WODA,0)),$P($G(^(5)),U,2)="" D
 .. S DA=WODA,DIK="^ENG(6920," D ^DIK K DIK S DA=EQDA
 .. S $P(^ENG(6914,DA,11),U,8)=""
 Q
 ;ENY2UTL
