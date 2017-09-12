IBY447PO ;ALB/GEF - Post-Installation for IB patch 447 ;19-APR-2011
 ;;2.0;INTEGRATED BILLING;**447**;19-APR-11;Build 80
 D RIT,TPB,CRD
 Q
 ;
RIT ; recompile billing screen templates
 N X,Y,DMAX,IBN
 D MES^XPDUTL("Recompiling Input Templates for Billing Screens ...")
 F IBN=1:1:9,"10","102","10H" D
 .S X="IBXS"_$S(IBN=10:"A",IBN="102":"A2",IBN="10H":"AH",1:IBN)
 .S Y=$$FIND1^DIC(.402,,"X","IB SCREEN"_IBN,"B")
 .S DMAX=$$ROUSIZE^DILF
 .I Y D EN^DIEZ
 D MES^XPDUTL(" Done.")
 Q
 ;
TPB ; Change THIRD PARTY BILLING menu mnemonic
 NEW MENUIEN,ITEMIEN,STOP,IBX,DIE,DA,DR
 D MES^XPDUTL("Updating THIRD PARTY BILLING menu mnemonic ....")
 ;
 S MENUIEN=$O(^DIC(19,"B","IB BILLING CLERK MENU",0)) D UBCG
 S MENUIEN=$O(^DIC(19,"B","IB BILLING SUPERVISOR MENU",0)) D UBCG
 Q
 ;
UBCG ;
 Q:'MENUIEN 
 S ITEMIEN=0 F  S ITEMIEN=$O(^DIC(19,MENUIEN,10,ITEMIEN)) Q:'ITEMIEN  D
 . S IBX=$P($G(^DIC(19,MENUIEN,10,ITEMIEN,0)),U,2) Q:$E(IBX,1,2)'="UB"
 . S DIE="^DIC(19,"_MENUIEN_",10,"
 . S DA=ITEMIEN,DA(1)=MENUIEN
 . S DR="2////TPB"
 . D ^DIE
 Q
CRD ; fix mis-match between claim and account number from patch 433
 N IBN,IBDT,IBC,IBAR,X
 ; Start with install date of patch 433
 S X=$$INSTALDT^XPDUTL("IB*2.0*433",.IBDT) Q:X<1
 S IBDT=$P($O(IBDT("")),".")
 S IBDT=IBDT-1 F  S IBDT=$O(^DGCR(399,"APD",IBDT)) Q:'IBDT  D
 .S IBN=0 F  S IBN=$O(^DGCR(399,"APD",IBDT,IBN)) Q:'IBN  D
 ..; only look at claims with iteration numbers
 ..S IBC=$P($G(^DGCR(399,IBN,0)),"^") Q:IBC'["-"
 ..S IBAR=$P($P($G(^PRCA(430,IBN,0)),"^"),"-",2,3)
 ..Q:IBC=IBAR
 ..; claim does not match AR, fix claim
 ..S $P(^DGCR(399,IBN,0),"^")=IBAR,^DGCR(399,"B",IBAR,IBN)=""
 ..K ^DGCR(399,"B",IBC,IBN)
 Q
