PRCPCSP ;WISC/RFJ/DXH - convert secondary to primary ;9.9.99
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; prcpflvl=1 => accept existing stock levels for some or all
 ;
EN D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="P" W !,"THIS OPTION SHOULD ONLY BE USED FROM WITHIN A PRIMARY INVENTORY POINT." Q
 ;
 N D0,DA,DATA,DELETE,DI,DIC,DIE,DIR,DQ,DR,EACHONE,ESCAPE,ITEMCNT,ITEMDA
 N IMFDATA,INVPT,IPVND,LASTONE,NUMBER,PIECE,PRIM,PRCPINPT,PRCPITEM
 N PRCPTYPE,UP,UR,VENDA,VENDATA,VENDOR,XH,XP
ASKNP ;  ask for secondary inventory point to be converted
 S PRIM=$$INVNAME^PRCPUX1(PRCP("I"))
 K X
 S X(1)="Select the SECONDARY inventory point to CONVERT."
 S X(2)="It must be one of the DISTRIBUTION POINTS for "_PRIM_"."
 W ! D DISPLAY^PRCPUX2(1,60,.X)
 S INVPT=$$TO^PRCPUDPT(PRCP("I")) I 'INVPT Q
 I '$D(^PRCP(445,INVPT,4,DUZ)) D  G ASKNP
 . K X
 . S X(1)="ERROR: You are not an authorized user for this inventory point."
 . D DISPLAY^PRCPUX2(5,75,.X)
 S ITEMCNT=+$P($G(^PRCP(445,INVPT,1,0)),"^",4)
 I 'ITEMCNT,'$O(^PRCP(445,INVPT,1,0)) D  Q:$G(ESCAPE)
 . K X
 . S X(1)="There are no items stored in the selected secondary inventory point."
 . S X(2)="Data base unchanged."
 . S ESCAPE=1
 . D DISPLAY^PRCPUX2(5,75,.X)
 I $P($G(^PRCP(445,INVPT,5)),"^",1)]"" D  QUIT
 . K X
 . S X(1)="This inventory point is linked to a supply station and cannot be converted."
 . D DISPLAY^PRCPUX2(5,75,.X)
 W !!?5,"Number of items currently stored: ",ITEMCNT
 W !! K X
 S X(1)="Existing PROCUREMENT and MANDATORY SOURCES for this secondary"
 S X(2)="will be replaced with data taken from its supplying primary"
 S X(3)="("_PRIM_") during the conversion. You can change these data"
 S X(4)="later if you need to."
 D DISPLAY^PRCPUX2(20,75,.X)
 ;
 D CONVRT^PRCPCSP1
 Q
 ;
HOLD ; can get here only from a crt
 W !,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
 ;PRCPCSP
