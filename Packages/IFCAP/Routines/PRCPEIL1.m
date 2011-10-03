PRCPEIL1 ;WISC/RFJ-edit inventory item (list manager) calls         ;01 Dec 93
V ;;5.1;IFCAP;**1,142**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
DESCRIP ;  edit descriptive elements
 D FULL^VALM1
 D DESCRIP^PRCPEITE(PRCPINPT,ITEMDA)
 ;  rebuild array
 D DIQ^PRCPEILM(".5;.7;5")
 D DESCRIP^PRCPEILM
 S VALMBCK="R"
 Q
 ;
 ;
COST ;  edit costing elements
 D COSTEDIT^PRCPEIQT(PRCPINPT,ITEMDA)
 ;  rebuild array
 D DIQ^PRCPEILM("4.7;4.8;4.81")
 D COSTS^PRCPEIL0
 S VALMBCK="R"
 Q
 ;
 ;
ISSUNITS ;  edit issue units
 D FULL^VALM1
 D SETUNITS^PRCPEIUI(PRCPINPT,ITEMDA)
 D EDITUI^PRCPEIUI(PRCPINPT,ITEMDA)
 ;  rebuild array
 D DIQ^PRCPEILM("16;16.5")
 D ISSUNITS^PRCPEIL0
 S VALMBCK="R"
 Q
 ;
 ;
LEVELS ;  edit levels
 D LEVELS^PRCPEITE(PRCPINPT,ITEMDA)
 ;  rebuild array
 D DIQ^PRCPEILM("9:11")
 D LEVELS^PRCPEIL0
 S VALMBCK="R"
 Q
 ;
 ;
QUANTITY ;  edit quantities
Q1 D FULL^VALM1
 D QTY^PRCPEIQT(PRCPINPT,ITEMDA)
 ;  rebuild array
 D DIQ^PRCPEILM("7;4.8;4.81")
 N ERR S ERR=0
 I $G(PRCPDATA("445.01",ITEMDA,"7","E"))>0,($G(PRCPDATA("445.01",ITEMDA,"4.8","E"))<".01"!($G(PRCPDATA("445.01",ITEMDA,"4.81","E"))<".01")) D  G:ERR=1 Q1
 . W !!,"** Result ON-HAND greater than 0 CANNOT have an average cost of zero."
 . W !,"   You MUST modify Inventory Value to something greater than zero. You cannot"
 . W !,"   have on-hand with an inventory value of zero and no average cost. If you"
 . W !,"   cannot enter an inventory value (not sure what to enter) then you must "
 . W !,"   MINUS the quantity originally entered to exit the QT action.",!
 . W !!,"=>> PLEASE OK IF THE ZERO INVENTORY VALUE IS DUE TO A ZERO VALUE INVENTORY ITEM",!
 . W $C(7) S %A="Is this a zero value inventory item",%B="",%=2 D ^PRCFYN I %'=1 S ERR=1
 I $G(PRCPDATA("445.01",ITEMDA,"4.81","E"))<0!($G(PRCPDATA("445.01",ITEMDA,"4.81","E"))<0) D  G Q1
 . W !!,"** Resulting Inventory Value or Average Cost CANNOT be negative. If you are"
 . W !,"   unsure what the inventory value should be then you MUST adjust the "
 . W !,"   quantity and inventory value back to original (zero or greater) values to "
 . W !,"   exit the QT action."
 D QUANTITY^PRCPEIL0
 D COSTS^PRCPEIL0
 S VALMBCK="R"
 K ERR,%,%A,%B
 Q
 ;
 ;
DUEIN ;  edit due-ins
 D FULL^VALM1
 D DUEIN^PRCPEIQT(PRCPINPT,ITEMDA)
 ;  rebuild array
 D DIQ^PRCPEILM(8)
 D QUANTITY^PRCPEIL0
 D OUTSTRAN^PRCPEIL0
 S VALMBCK="R"
 Q
 ;
 ;
SPECIAL ;  edit special parameters
 I PRCPTYPE="W" D FULL^VALM1
 D SPECIAL^PRCPEITE(PRCPINPT,ITEMDA)
 ;  rebuild array
 D DIQ^PRCPEILM(17)
 D SPECIAL^PRCPEIL0
 S VALMBCK="R"
 Q
 ;
 ;
SOURCES ;  edit procurement sources
 D FULL^VALM1
 D SOURCES^PRCPEIPS(PRCPINPT,ITEMDA)
 D SOURCES0(PRCPINPT,ITEMDA) ; restrict editing if oustanding orders
 ;  rebuild array
 D DIQ^PRCPEILM(.4)
 D SOURCES^PRCPEIL0
 S VALMBCK="R"
 Q
 ;
SOURCES0(PRCPINPT,ITEMDA) ; allow editing of source info if no orders
 N ORD S ORD=0
 ; because this is sometimes called from templates, new FileMan variables
 N D,D0,D1,D2,D3,D4,D5,D6,DA,DB,DC,DD,DE,DG,DH,DI,DIA,DIADD,DIC,DICR,DIE
 N DIEC,DIEL,DIFLD,DIK,DIOV,DIR,DK,DL,DLAYGO,DM,DO,DOV,DP,DR,DQ,DU,DV,DW
 N I,J,X,Y
 I $P(^PRCP(445,PRCPINPT,0),"^",3)="S" D  Q:ORD
 . W !,"Checking the released orders for this item..."
 . S ORD=$$ORDCHK^PRCPUITM(ITEMDA,PRCPINPT,"RCE","R")
 . Q:'ORD
 . I ORD D EN^DDIOL("To edit these values, you must first post or delete the following order(s):")
 . D LISTOO^PRCPUITM(ITEMDA,PRCPINPT,"R")
 . D P^PRCPUREP ; pause to allow user read information
 W !!?25,"*----------------------------*",!,"You will now have the option to override the changes I made, be careful though!",!?25,"*----------------------------*",!
 D EDITSOUR^PRCPEIPU(PRCPINPT,ITEMDA)
 Q
 ;
 ;
DRUGACCT ;  edit drug accountability parameters
 D DISPUNIT^PRCPEITE(PRCPINPT,ITEMDA)
 ;  rebuild array
 D DIQ^PRCPEILM("50;51")
 D DRUGACCT^PRCPEIL0
 S VALMBCK="R"
 Q
 ;
 ;
ALL ;  edit all fields
 D FULL^VALM1
 D ALL^PRCPEITE(PRCPINPT,ITEMDA)
 ;  rebuild array
 D INIT^PRCPEILM
 S VALMBCK="R"
 Q
 ;
 ;
DELETE ;  remove item from inventory point
 D DELETE^PRCPUITM(PRCPINPT,ITEMDA)
 D R^PRCPUREP
 S VALMBCK="R"
 I '$D(^PRCP(445,PRCPINPT,1,ITEMDA,0)) K VALMBCK Q
 Q
 ;
 ;
SECOND ;  edit secondary item
 D FULL^VALM1
 S VALMBCK="R"
 N PRCPSECO
 S PRCPSECO=$$TO^PRCPUDPT(PRCPINPT) I 'PRCPSECO  Q
 I '$D(^PRCP(445,PRCPSECO,4,+$G(DUZ),0)) S VALMSG="NOT AN AUTHORIZED USER FOR SECONDARY INVENTORY POINT" Q
 D
 .   N ITEMDA,PRCPINPT,PRCPTYPE
 .   S PRCPINPT=PRCPSECO,PRCPTYPE=$P($G(^PRCP(445,PRCPSECO,0)),"^",3)
 .   F  W !! S ITEMDA=$$ITEM^PRCPUITM(PRCPINPT,1,"","") Q:'ITEMDA  D
 .   .   L +^PRCP(445,PRCPINPT,1,ITEMDA):1 I '$T D SHOWWHO^PRCPULOC(445,PRCPINPT_"-1",0) Q
 .   .   D ADD^PRCPULOC(445,PRCPINPT_"-1",0,"Enter/Edit Inventory Item Data")
 .   .   D EN^VALM("PRCP EDIT ITEMS")
 .   .   I $D(^PRCP(445,PRCPINPT,1,ITEMDA)) D BLDSEG^PRCPHLFM(3,ITEMDA,PRCPINPT) ; send supply station an update of any changes to the item
 .   .   D CLEAR^PRCPULOC(445,PRCPINPT_"-1",0)
 .   .   L -^PRCP(445,PRCPINPT,1,ITEMDA)
 .   Q
 D INIT^PRCPEILM
 S VALMBCK="R"
 Q
