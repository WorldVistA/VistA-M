PRCPCSPX ;WISC/DXH - undo secondary to primary conversion ;10.7.99
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; expects prcp("i") as ien of inv pt to be undone
EN ;
 N D0,DA,DATA,DI,DIC,DIE,DIR,DQ,DR,EACHONE,ITEMCNT,ITEMDA,LASTONE,NUMBER,PIECE,INVPT,VENDOR,X,Y,XP,XH,ESCAPE,PRIM,VENDA,VENDATA,STKDBY,FCPDA,NODEDA
 S PRIM=$$INVNAME^PRCPUX1(PRCP("I"))
 I '$D(^PRCP(445,PRCP("I"),"SEC")) W !!,"Inventory Point "_PRIM_" was never converted.",!,"Data base unchanged.",*7 D HOLD Q
 S PRC=^PRCP(445,PRCP("I"),"SEC"),USER=$P(PRC,"|",2),DATE=$P(PRC,"|",3),NODE=$P(PRC,"|"),STCKDBY=$P(PRC,"|",4)
 I USER,$G(^VA(200,USER,0))]"" S USERNM=$$GET1^DIQ(200,USER,.01)
 I $G(USERNM)]"" D
 . I DATE S Y=DATE X ^DD("DD") S DATEXT=Y
 . W !!,"Inventory Point "_PRIM_" was converted to a primary by "
 . W !,USERNM W:$G(DATEXT)]"" " on "_DATEXT W "."
 S DA=0 F  S DA=$O(^PRCP(445,PRCP("I"),1,DA)) Q:$G(ESCAPE)!('DA)  D
 . I $O(^PRCP(445,PRCP("I"),1,DA,7,0)) S ESCAPE=1
 I $G(ESCAPE) W !!,"Inventory Point "_PRIM_" has at least one OUTSTANDING REQUEST",!,"It can not be converted and the data base remains unchanged.",*7 D HOLD Q
 W !! K X S X(1)="This option will change "_PRIM_" from a primary to a secondary.",X(2)="INVENTORY PARAMETERS, STOCK LEVELS, MANDATORY SOURCES, and PROCUREMENT SOURCES"
 S X(3)="will be restored to whatever they were when this Inventory Point was converted"
 I $G(DATEXT)]"" S X(4)="on "_DATEXT_"."
 E  S X(3)=X(3)_"."
 D DISPLAY^PRCPUX2(10,75,.X)
 W !!,"Preparing to convert "_PRIM_" back to a secondary."
 K XP,XH S XP="Are you sure you want to do that",XH="Enter 'YES' to start the conversion, NO or '^' to escape."
 I $$YN^PRCPUYN(2)'=1 Q
 ;
CONVRT W !!!?20,"Converting "_PRIM_"."
 S EACHONE=$$INPERCNT^PRCPUX2(+$P($G(^PRCP(445,PRCP("I"),1,0)),U,4),"*",PRCP("RV1"),PRCP("RV0"))
 S DIE="^PRCP(445,",DA=PRCP("I"),DR=".7///^S X=""S""" D ^DIE K DR
 S ^PRCP(445,PRCP("I"),0)=NODE ; it's a secondary again
 K ^PRCP(445,PRCP("I"),1,"AC") ; existing x-ref won't work for secondary
 S ITEMDA=0 F NUMBER=1:1 S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  I $G(^(ITEMDA,0))'="" D
 . S LASTONE=$$SHPERCNT^PRCPUX2(NUMBER,EACHONE,"*",PRCP("RV1"),PRCP("RV0"))
 . I '$D(^PRCP(445,PRCP("I"),"SECITM",ITEMDA)) D  Q
 .. ; delete line items added since conversion
 .. S DIK="^PRCP(445,"_PRCP("I")_",1,",DA(1)=PRCP("I"),DA=ITEMDA
 .. D ^DIK K DIK
 . K ^PRCP(445,PRCP("I"),1,ITEMDA,5) ; won't work for secondary
 . S ^PRCP(445,PRCP("I"),1,ITEMDA,0)=^PRCP(445,PRCP("I"),"SECITM",ITEMDA,0)
 . S %X="^PRCP(445,"_PRCP("I")_",""SECITM"","_ITEMDA_",5,",%Y="^PRCP(445,"_PRCP("I")_",1,"_ITEMDA_",5," D %XY^%RCR
 . ; x-ref by mandatory source
 . I $P(^PRCP(445,PRCP("I"),1,ITEMDA,0),U,12)]"" S DA=ITEMDA,DA(1)=PRCP("I"),DIK="^PRCP(445,"_PRCP("I")_",1,",DIK(1)=.4 D EN1^DIK K DIK
 ; restore mis costing
 I $D(^PRCP(445,PRCP("I"),"SECMIS")) K ^PRCP(445,PRCP("I"),3) S %X="^PRCP(445,"_PRCP("I")_",""SECMIS"",",%Y="^PRCP(445,"_PRCP("I")_",3," D %XY^%RCR
 ; restore prcp(i) as distribution point for stckdby
 I $G(STCKDBY) D
 . N DIC,DA,DD,DO,DLAYGO,DINUM
 . S DIC="^PRCP(445,"_STCKDBY_",2,",DIC(0)="L",DA(1)=STCKDBY,(X,DINUM)=PRCP("I"),DIC("P")=$P(^DD(445.03,.01,0),U,2),DLAYGO=445
 . D FILE^DICN
 ; delete any dist points
 I $D(^PRCP(445,PRCP("I"),2)) D  K DIK
 . N DA
 . S DIK="^PRCP(445,PRCP(""I""),2,",DA(1)=PRCP("I"),DA=0
 . F  S DA=$O(^PRCP(445,PRCP("I"),2,DA)) Q:'DA  D ^DIK
 S PRCP("DPTYPE")="S" ; just like in the old days
 ; unlink fcp(s)
FCP S FCPDA=0 F  S FCPDA=$O(^PRC(420,"AE",PRC("SITE"),PRCP("I"),FCPDA)) Q:'FCPDA  D DEL^PRCPUFCP(FCPDA,PRCP("I"))
 ; destroy the evidence
 F NODEDA="SEC","SECITM","SECMIS" K ^PRCP(445,PRCP("I"),NODEDA)
 D HOLD
 Q
 ;
HOLD ; can get here only from a crt
 W !!,"Press <RETURN> to continue..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
 ;PRCPCSPX
