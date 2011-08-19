PRCPCSP1 ;WISC/RFJ/DXH - convert secondary to primary ;10.14.99
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CONVRT W !!,"Preparing to convert: "_$$INVNAME^PRCPUX1(INVPT)_" to a primary."
 K XP,XH S XP="Are you sure this is what you want to do",XH="Enter YES to start converting, NO or ^ to exit."
 I $$YN^PRCPUYN(2)'=1 S ESCAPE=1 Q
 ;
 L +^PRCP(445,INVPT):5 I '$T W !,"Sorry, another user is editing this inventory point. Please try again later." S ESCAPE=1 Q
 ; store some data in case user decides to 'undo' conversion
 S ^PRCP(445,INVPT,"SEC")=^PRCP(445,INVPT,0)_"|"_$G(DUZ)_"|"_$G(DT)_"|"_PRCP("I")
 I $O(^PRCP(445,INVPT,3,0)) S %X="^PRCP(445,"_INVPT_",3,",%Y="^PRCP(445,"_INVPT_",""SECMIS""," D %XY^%RCR ; mis costing sections
 S DIE="^PRCP(445,",DA=INVPT
 S DR=".5;.6;.9" D ^DIE K DR I $D(DTOUT)!($D(Y)) D  L -^PRCP(445,INVPT) Q
 . I $D(DTOUT) W *7,!,"You have timed out "
 . E  W *7,!,"You have escaped "
 . W "and may need to edit this inventory point using the"
 . W !,"'Enter/Edit Inventory and Distribution Points' option under 'Secondary",!,"Inventory Point Main Menu' to restore order."
 . W ! D HOLD K ^PRCP(445,INVPT,"SEC"),^("SECMIS")
 S DR=".7///^S X=""P""" D ^DIE K DR
 S DIK="^PRCP(445,"_PRCP("I")_",2,",DA(1)=PRCP("I"),DA=INVPT D ^DIK K DIK ; remove the secondary as a distribution point
 K ^PRCP(445,INVPT,1,"AC") ; sub-file x-ref on mand source
 S PRCPINPT=INVPT,PRCPTYPE="P",PRCP("CONVRT")=1 D FCP^PRCPENE1
 ;
ITEMS W !!!?30,"Converting Items"
 S EACHONE=$$INPERCNT^PRCPUX2(+$P($G(^PRCP(445,INVPT,1,0)),"^",4),"*",PRCP("RV1"),PRCP("RV0"))
 S ITEMDA=0 F NUMBER=1:1 S ITEMDA=$O(^PRCP(445,INVPT,1,ITEMDA)) Q:'ITEMDA  S DATA=$G(^(ITEMDA,0)) I DATA'="" D  Q:$G(ESCAPE)  D IPVND Q:$G(ESCAPE)
 . S LASTONE=$$SHPERCNT^PRCPUX2(NUMBER,EACHONE,"*",PRCP("RV1"),PRCP("RV0"))
 . S ^PRCP(445,INVPT,"SECITM",ITEMDA,0)=$G(^PRCP(445,INVPT,1,ITEMDA,0))
 . S %X="^PRCP(445,"_INVPT_",1,"_ITEMDA_",5,",%Y="^PRCP(445,"_INVPT_",""SECITM"","_ITEMDA_",5," D %XY^%RCR
 . K ^PRCP(445,INVPT,1,ITEMDA,5) ; clear data that may not be overwritten
 . ;                               by conversion process
 . S $P(^PRCP(445,INVPT,1,ITEMDA,0),U,12)=$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),U,12) ; mandatory source from prcp("i")
 . I $P(^PRCP(445,INVPT,1,ITEMDA,0),U,12) D
 .. S DA=ITEMDA,DA(1)=INVPT,DIK="^PRCP(445,"_DA(1)_",1,",DIK(1)=".4"
 .. D EN1^DIK K DIK ; re-xref by mand source
 . I $O(^PRCP(445,PRCP("I"),1,ITEMDA,5,0)) S %X="^PRCP(445,"_PRCP("I")_",1,"_ITEMDA_",5,",%Y="^PRCP(445,"_INVPT_",1,"_ITEMDA_",5," D %XY^%RCR D  D MNDSRC Q
 .. S VENDA=0 F  S VENDA=$O(^PRCP(445,INVPT,1,ITEMDA,5,VENDA)) Q:'VENDA  S DATA=^(VENDA,0),VENDATA=$G(^PRC(441,ITEMDA,2,VENDA,0)) D
 ... S UP=$$UNITVAL^PRCPUX1($P(VENDATA,U,8),$P(VENDATA,U,7),""),UR=$$UNITVAL^PRCPUX1($P(DATA,U,3),$P(DATA,U,2),"")
 ... I UP'=UR,UP'["?" S $P(DATA,U,3)=$P(VENDATA,U,8),$P(DATA,U,2)=$P(VENDATA,U,7)
 ... I '$P(DATA,U,4) S PRC=$P($G(^PRCP(445,INVPT,1,ITEMDA,0)),U,14) S:PRC="" PRC=1 S $P(DATA,U,4)=($P(DATA,U,3)/PRC)\1 S:'$P(DATA,U,4) $P(DATA,U,4)=1
 ... S ^PRCP(445,INVPT,1,ITEMDA,5,VENDA,0)=DATA
 . ;
 . ; will have to go to the item master
 . S VENDA=$P($G(^PRC(441,ITEMDA,0)),U,8) I VENDA S $P(^PRCP(445,INVPT,1,ITEMDA,0),U,12)=VENDA_";PRC(440,",VENDATA=$G(^PRC(441,ITEMDA,2,VENDA,0)) D  S ESCAPE=1 Q
 .. D ADDVEN^PRCPUVEN(INVPT,ITEMDA,VENDA_";PRC(440,",$P(VENDATA,U,7),$P(VENDATA,U,8),$P(VENDATA,U,10))
 .. S DA=ITEMDA,DA(1)=INVPT,DIK="^PRCP(445,"_DA(1)_",1,",DIK(1)=.4 D EN1^DIK K DIK ; x-ref new mandatory source
 . S VENDA=0 F  S VENDA=$O(^PRC(441,ITEMDA,2,VENDA)) Q:'VENDA  S VENDATA=$G(^PRC(441,ITEMDA,2,VENDA,0)) D
 .. D ADDVEN^PRCPUVEN(INVPT,ITEMDA,VENDA_";PRC(440,",$P(VENDATA,U,7),$P(VENDATA,U,8),$P(VENDATA,U,10))
 ;
LEVELS ; change the stock levels?
 W ! S DIR(0)="Y",DIR("A")="Would you like to edit item levels and/or mandatory source",DIR("B")="NO"
 S DIR("?",1)="Enter 'YES' if you would like to edit the NORMAL STOCK LEVEL, EMERGENCY"
 S DIR("?",2)="STOCK LEVEL, TEMPORARY STOCK LEVEL, STANDARD REORDER POINT, OPTIONAL REORDER"
 S DIR("?",3)="POINT, and/or MANDATORY SOURCE for some or all of the items in this"
 S DIR("?")="inventory point."
 D ^DIR K DIR I $D(DIRUT) Q
 I 'Y W !!,"Conversion Completed !" Q  ; leave everything as it was when inventory point was secondary
 ;
 ; can either step thru the inventory point or prompt for lookups
 ;
 S DIR(0)="SOM^1:Prompt for ITEMS that may need changes;2:Display all ITEMS and prompt for changes",DIR("A")="How shall items be presented? "
 S DIR("B")="1"
 S DIR("?",1)="Enter '2' if you want the system to step through the inventory point and"
 S DIR("?")="prompt you for changes to all of the items."
 D ^DIR K DIR Q:$D(DIRUT)
 S DIE="^PRCP(445,",DR="[PRCP LEVELS]"
 I Y=2 D  W !!?10,"<Done>" D HOLD Q  ; step thru inventory point
 . S ITEMDA=0 F  D:ITEMDA HOLD S ITEMDA=$O(^PRCP(445,INVPT,1,ITEMDA)) Q:'ITEMDA!($G(ESCAPE))  I $D(^(ITEMDA,0)) D EDIT Q:$G(ESCAPE)
 ; prompt for user lookups
 S DIC("S")="I $D(^PRCP(445,INVPT,1,+Y,0))"
 F  W !! S DIC="^PRCP(445,"_INVPT_",1,",DIC(0)="AEQM" D ^DIC Q:Y'>0  S ITEMDA=+Y D EDIT Q:$G(ESCAPE)
 W !!?10,"<Done>" D HOLD
 Q  ; end user lookups
 ;
EDIT ; edit stock levels
 W !!,"ITEM MASTER #: "_ITEMDA,?30,$E($P($G(^PRCP(445,INVPT,1,ITEMDA,6)),U),1,50)
 W ! S DA=INVPT,PRCPITEM=$C(96)_ITEMDA
 D ^DIE I $D(DTOUT) S ESCAPE=1
 Q
 ;
IPVND ; add old 'stocked by' inv pt as vendor if appropriate
 ; try to find it in the vendor file
 S PRIM(0)=$P(PRIM,"-",2) S IPVND("DA")=$O(^PRC(440,"B",PRIM(0),0)) I '$G(IPVND("DA")) S IPVND("DA")=$O(^PRC(440,"C",PRIM(0),0))
 Q:'$G(IPVND("DA"))  S PRCP("DA")=0 F  S PRCP("DA")=$O(^PRCP(445,INVPT,"SECITM",ITEMDA,5,PRCP("DA"))) Q:'PRCP("DA")!(+^PRCP(445,INVPT,"SECITM",ITEMDA,5,PRCP("DA"),0)=PRCP("I"))
 D:PRCP("DA")  ; if it's there, add it
 . S DATA=$G(^PRCP(445,INVPT,"SECITM",ITEMDA,5,PRCP("DA"),0))
 . D ADDVEN^PRCPUVEN(INVPT,ITEMDA,IPVND("DA")_";PRC(440,",$P(DATA,U,2),$P(DATA,U,3),$P(DATA,U,4))
 . I '$D(^PRC(441,ITEMDA,2,"B",IPVND("DA"),0)) D
 .. N DIC,DA,DLAYGO,DD,DO,DINUM
 .. S DIC="^PRC(441,ITEMDA,2,",(X,DINUM)=IPVND("DA"),DA(1)=ITEMDA,DIC(0)="L",DLAYGO=441,DIC("P")=$P(^DD(441,6,0),U,2)
 .. D FILE^DICN
 Q
 ;
MNDSRC ; look for mand srce in imf if not picked up from prcp("i")
 Q:$P(^PRCP(445,INVPT,1,ITEMDA,0),U,12)]""  ; already have it
 S PRCP("MS")=$P($G(^PRC(441,ITEMDA,0)),U,8)_";PRC(440,"
 I +PRCP("MS"),('$D(^PRCP(445,INVPT,1,ITEMDA,5,"B",PRCP("MS")))) D
 . S IMFDATA=$G(^PRC(441,ITEMDA,2,+PRCP("MS"),0))
 . D ADDVEN^PRCPUVEN(INVPT,ITEMDA,PRCP("MS"),$P(IMFDATA,U,7),$P(IMFDATA,U,8),$P(IMFDATA,U,10))
 I +PRCP("MS") S $P(^PRCP(445,INVPT,1,ITEMDA,0),U,12)=PRCP("MS"),DA=ITEMDA,DA(1)=INVPT,DIK="^PRCP(445,"_DA(1)_",1,",DIK(1)=.4 D EN1^DIK K DIK ; set mand srce and x-ref
 Q
 ;
HOLD W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
 ;PRCPCSP1
