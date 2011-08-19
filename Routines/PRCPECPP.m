PRCPECPP ;WISC/RFJ-copy items from primary to secondary;1/4/99 1435
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 ;
 I PRCP("DPTYPE")'="P" D  QUIT
 . W !,"THIS OPTION SHOULD ONLY BE USED BY A PRIMARY INVENTORY POINT."
 ;
 N %,A,D0,DA,DATA,DELETE,DI,DIC,DIE,DQ,DR,EACHONE,ITEMCNT,ITEMDA
 N LASTONE,NUMBER,PIECE,PRCPINFR,PRCPINTO,PRCPFLVL,PRCPNL,PRCPSENT,X,Y,PRCPXX
 S PRCPINFR=PRCP("I")
 ;
ASKTO ;  ask inventory point to copy to
 K X S X(1)="Select the SECONDARY inventory point to copy TO."
 W ! D DISPLAY^PRCPUX2(1,40,.X)
 S PRCPINTO=$$TO^PRCPUDPT(PRCP("I")) I 'PRCPINTO Q
 I $P($G(^PRCP(445,PRCPINTO,0)),"^",2)="Y" D  G ASKTO
 . K X S X(1)="ERROR: THE SECONDARY INVENTORY POINT BEING COPIED TO CANNOT BE KEEPING A PERPETUAL INVENTORY."
 . D DISPLAY^PRCPUX2(5,75,.X)
 ;
 I '$D(^PRCP(445,PRCPINTO,4,DUZ)) D  G ASKTO
 . K X S X(1)="ERROR: YOU ARE NOT AN AUTHORIZED USER FOR THIS INVENTORY POINT."
 . D DISPLAY^PRCPUX2(5,75,.X)
 ;
 L +^PRCP(445,PRCPINTO,1):5 I '$T D SHOWWHO^PRCPULOC(445,PRCPINTO_"-1",0) Q
 D ADD^PRCPULOC(445,PRCPINTO_"-1",0,"Item copying")
 S ITEMCNT=+$P($G(^PRCP(445,PRCPINTO,1,0)),"^",4)
 W !?5,"Number of items currently stored: ",ITEMCNT
 S DELETE=0
 I ITEMCNT D  I 'DELETE G EXIT
 . I $$ORDCHK^PRCPUITM(0,PRCPINTO,"RCE","") D  S DELETE=2 QUIT
 . . W !,$$INVNAME^PRCPUX1(PRCPINTO)," has outstanding orders.  You may overwrite"
 . . W !,"but cannot delete items already stored here."
 . I DELETE=2 QUIT
 . S XP="Since there are already items stored in the secondary inventory point you"
 . S XP(1)="are copying TO, do you want to delete ALL items before making the copy"
 . S XH="Enter YES to remove ALL items from "_$$INVNAME^PRCPUX1(PRCPINTO)_"."
 . S XH(1)="Enter NO to OVERWRITE items currently stored in the inventory point."
 . S XH(2)="Enter ^ to exit."
 . W ! S DELETE=$$YN^PRCPUYN(2)
 ;
 S PRCPFLVL=0
 S XP="Do you want to copy the stock levels and reorder points"
 S XH="Enter YES to copy the normal stock level, emergency stock level, standard"
 S XH(1)="reorder point, and optional reorder point."
 W ! I $$YN^PRCPUYN(2)=1 S PRCPFLVL=1
 ;
 K X S X(1)="Copying from: "_$$INVNAME^PRCPUX1(PRCPINFR)_"  to: "_$$INVNAME^PRCPUX1(PRCPINTO)
 W !! D DISPLAY^PRCPUX2(5,75,.X)
 S XP="Are you sure you want to copy the items"
 S XH="Enter YES to start copying the items, NO or ^ to exit."
 I $$YN^PRCPUYN(2)'=1 G EXIT
 ;
 I $G(DELETE)=1 D
 . W !!,"Deleting Items. . . ."
 . ; S EACHONE=$$INPERCNT^PRCPUX2(ITEMCNT,"*",PRCP("RV1"),PRCP("RV0"))
 . S ITEMDA=0
 . F NUMBER=1:1 S ITEMDA=$O(^PRCP(445,PRCPINTO,1,ITEMDA)) Q:'ITEMDA  D
 . . D DELITEM^PRCPUITM(PRCPINTO,ITEMDA)
 . . ; S LASTONE=$$SHPERCNT^PRCPUX2(NUMBER,EACHONE,"*",PRCP("RV1"),PRCP("RV0"))
 . ; D QPERCNT^PRCPUX2(+$G(LASTONE),"*",PRCP("RV1"),PRCP("RV0"))
 . W !,"Deletions completed",!
 ;
 W !!!,"Copying Items. . . ."
 ; S EACHONE=$$INPERCNT^PRCPUX2(+$P($G(^PRCP(445,PRCPINFR,1,0)),"^",4),"*",PRCP("RV1"),PRCP("RV0"))
 I '$D(^PRCP(445,PRCPINTO,1,0)) S ^(0)="^445.01IP^^"
 S ITEMDA=0
 F NUMBER=1:1 S ITEMDA=$O(^PRCP(445,PRCPINFR,1,ITEMDA)) Q:'ITEMDA  S DATA=$G(^(ITEMDA,0)) I DATA'="" D
 . ; S LASTONE=$$SHPERCNT^PRCPUX2(NUMBER,EACHONE,"*",PRCP("RV1"),PRCP("RV0"))
 . I '$D(^PRCP(445,PRCPINTO,1,ITEMDA,0)) D ADDITEM^PRCPECPS(PRCPINTO,ITEMDA)
 . I '$D(^PRCP(445,PRCPINTO,1,ITEMDA,0)) Q
 . I $G(PRCPFLVL)>0 S PRCPNL=+$P(^PRCP(445,PRCPINTO,1,ITEMDA,0),"^",9)
 . S DR=""
 . F PIECE=5,14,15 I $P(DATA,"^",PIECE)'="" S DR=DR_$S(PIECE=5:4,PIECE=14:4.5,PIECE=15:4.7,1:PIECE)_"////"_$P(DATA,"^",PIECE)_";"
 . I $G(PRCPFLVL)>0 F PIECE=4,9,10,11 I $P(DATA,"^",PIECE)'="" S DR=DR_$S(PIECE=4:10.3,1:PIECE)_"////"_$P(DATA,"^",PIECE)_";"
 . I $P($G(^PRCP(445,PRCPINFR,1,ITEMDA,6)),"^")'="" S PRCPXX=$P(^(6),"^"),DR=DR_".7////^S X=PRCPXX"
 . S (DIC,DIE)="^PRCP(445,"_PRCPINTO_",1,"
 . S DA(1)=PRCPINTO,DA=ITEMDA
 . D ^DIE
 . D ADDVEN^PRCPUVEN(PRCPINTO,ITEMDA,PRCPINFR_";PRCP(445,",$P(DATA,"^",5),$P(DATA,"^",14),1)
 . S $P(^PRCP(445,PRCPINTO,1,ITEMDA,0),"^",12)=PRCPINFR_";PRCP(445,"
 . S ^PRCP(445,PRCPINTO,1,"AC",PRCPINFR_";PRCP(445,",ITEMDA)=""
 . S PRCPSENT=0
 . I $G(PRCPFLVL)>0,PRCPNL=0,$P(DATA,"^",9)>0 D
 . . D BLDSEG^PRCPHLFM(1,ITEMDA,PRCPINTO) ; send transaction to supply station
 . . S PRCPSENT=1
 . I 'PRCPSENT,$P(^PRCP(445,PRCPINTO,1,ITEMDA,0),"^",9)>0 D BLDSEG^PRCPHLFM(3,ITEMDA,PRCPINTO) ; send item info to supply station
 ; D QPERCNT^PRCPUX2(+$G(LASTONE),"*",PRCP("RV1"),PRCP("RV0"))
 ;
 W !!,"Copy Completed !"
EXIT D CLEAR^PRCPULOC(445,PRCPINTO_"-1",0)
 L -^PRCP(445,PRCPINTO,1)
 Q
