IBCEPTU ;ALB/TMK-TEST TRANSMIT CLAIMS UTILITIES ;25-JAN-2005
 ;;2.0;INTEGRATED BILLING;**296**;21-MAR-94
 ;
PURGE ; Purge test claim transmit records over 60 days old
 N IBDAYS,IBDT,IBDELDT,DIK,DA,X
 S IBDAYS=60
 S X1=DT,X2=-IBDAYS D C^%DTC S IBDELDT=X
 S DIK="^IBM(361.4,"
 S IBDT=0 F  S IBDT=$O(^IBM(361.4,"ALT",IBDT)) Q:'IBDT!(IBDT>IBDELDT)  S DA=0 F  S DA=$O(^IBM(361.4,"ALT",IBDT,DA)) Q:'DA  D ^DIK
 Q
 ;
LASTDT(DA) ; Get last txmt dt file 361.4 for xref
 ; DA = array of iens from Fileman
 N Z,Z0,X
 S X=""
 S Z="" F  S Z=$O(^IBM(361.4,DA(1),1,"ALTD",Z),-1) Q:Z=""!X  S Z0=0 F  S Z0=$O(^IBM(361.4,DA(1),1,"ALTD",Z,Z0)) Q:'Z0  I Z0'=DA S X=Z Q
 Q X
 ;
