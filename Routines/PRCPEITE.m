PRCPEITE ;WISC/RFJ-enter/edit inventory items                       ; 11/6/06 8:40am
V ;;5.1;IFCAP;**1,98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
ALL(PRCPINPT,ITEMDA) ;  edit all fields option (for new items)
 I '$D(^PRCP(445,+PRCPINPT,1,+ITEMDA,0)) Q
 N %,%H,D,D0,D1,D2,DA,DES,DI,DIC,DIE,DLAYGO,DQ,DR,I
 N PRCPINDA,PRCPITEM,PRCPNL,PRCPQUIT,PRCPPRIV,PRCPTYPE,PRCPUI,PRCPUI1,X,Y
 D EN^DDIOL("----- Enter Item Descriptive Data -----")
 S DES=$P($G(^PRCP(445,PRCPINPT,1,ITEMDA,6)),"^")
 I DES="" S DES=$$DESDEF^PRCPEITF(PRCPINPT,ITEMDA) ; get item description default
 S PRCPQUIT=0
 D DESCRIP^PRCPEITF(PRCPINPT,ITEMDA,.PRCPQUIT)
 I PRCPQUIT Q
 S DR="[PRCP ITEM ALL FIELDS (NON-SS)]"
 I $P(^PRCP(445,PRCPINPT,0),"^",3)="S",$P($G(^PRCP(445,PRCPINPT,5)),"^",1)]"" S DR="[PRCP ITEM ALL FIELDS (SS)]" ; supply station monitors normal level value
 S DA=PRCPINPT
 S PRCPITEM=$C(96)_ITEMDA
 S (DIC,DIE)="^PRCP(445,"
 S DIE("NO^")="BACKOUTOK"
 S PRCPPRIV=1 D ^DIE
 Q
 ;
 ;
DESCRIP(PRCPINPT,ITEMDA) ;  edit description, category, location fields
 I '$D(^PRCP(445,+PRCPINPT,1,+ITEMDA,0)) Q
 N %,D,D0,DA,DES,DI,DIC,DIE,DISYS,DQ,DR,DZ,E,PRCPPRIM,PRCPPRIV,PRCPPRNM,PRCPQUIT,TYPE,X,XH,XP,Y
 S DES=$P($G(^PRCP(445,PRCPINPT,1,ITEMDA,6)),"^")
 I DES="" S DES=$$DESDEF^PRCPEITF(PRCPINPT,ITEMDA) ; get default value
 S PRCPQUIT=0
 D DESCRIP^PRCPEITF(PRCPINPT,ITEMDA,.PRCPQUIT)
 I PRCPQUIT Q
 S DA(1)=PRCPINPT,DA=ITEMDA,(DIC,DIE)="^PRCP(445,"_PRCPINPT_",1,"
 S DR=".5GROUP CATEGORY;5MAIN STORAGE LOCATION;6"
 S PRCPPRIV=1
 D ^DIE K PRCPPRIV
 Q
 ;
 ;
LEVELS(PRCPINPT,ITEMDA) ;  edit stock levels
 I '$D(^PRCP(445,+PRCPINPT,1,+ITEMDA,0)) Q
 N %,D,D0,DA,DI,DIC,DIE,DQ,DR,DZ,PRCPDR,PRCPPRIV,PRCPQUIT,UNIT,X,Y
 S UNIT=$$UNIT^PRCPUX1(PRCPINPT,ITEMDA," per ")
 S DR="9NORMAL STOCK LEVEL     ("_UNIT_")"
 S PRCPQUIT=0
 ;
 ; if the supply station secondary has unposted regular orders,
 ; restrict editing a non-zero normal level to zero.
 I $P(^PRCP(445,PRCPINPT,0),"^",3)="S",$P($G(^PRCP(445,PRCPINPT,5)),"^",1)]"" D
 . D EDNORM(PRCPINPT,ITEMDA,$E(DR,2,99),.PRCPQUIT)
 . S DR=""
 . I $D(DUOUT)!$D(DTOUT) Q
 I PRCPQUIT Q
 I DR]"" S DR=DR_";"
 S PRCPPRIV=1
 S DR=DR_"11EMERGENCY STOCK LEVEL  ("_UNIT_");9.5TEMPORARY STOCK LEVEL  ("_UNIT_");I 'X S Y=10;9.6;10STANDARD REORDER POINT ("_UNIT_");10.3OPTIONAL REORDER POINT ("_UNIT_");"
 S DA(1)=PRCPINPT,DA=ITEMDA,(DIC,DIE)="^PRCP(445,"_PRCPINPT_",1," D ^DIE
 Q
 ;
 ;
SPECIAL(PRCPINPT,ITEMDA) ;  special parameters and flags
 I '$D(^PRCP(445,+PRCPINPT,1,+ITEMDA,0)) Q
 N %,C,D,D0,D1,DA,DDH,DI,DIC,DIE,DISYS,DIZ,DLAYGO,DQ,DR,I,ISSUE,PRCPITEM,PRCPPRIV,PRCPSET,TYPE,X,Y
 S (DIC,DIE)="^PRCP(445,"_PRCPINPT_",1,",PRCPSET="I PRCPITEM'=X,$D(^PRCP(445,PRCPINPT,1,X,0))",DA(1)=PRCPINPT,(PRCPITEM,DA)=ITEMDA
 S TYPE=$P($G(^PRCP(445,PRCPINPT,0)),"^",3)
 ;  substitute item multiple
 I TYPE="W",'$D(^PRCP(445,PRCPINPT,1,ITEMDA,4,0)) S ^(0)="^445.122PI^^"
 I TYPE="P",$P(^PRCP(445,PRCPINPT,0),"^",10)="S" S ISSUE=1
 ;  removal of fields 14;14.3;14.4 if type = "P" (fields not used)
 S DR="17;"_$S($G(ISSUE):"14.5;",1:"")_$S(TYPE="W":"22;",1:"")
 S PRCPPRIV=1
 D ^DIE I $D(DTOUT)!$D(Y) Q
 K DIC,DIE,DA,DR
 I TYPE'="W" D ODI^PRCPEITG(PRCPINPT,ITEMDA) ; ask On-Demand (PRC*5.1*98)
 Q
 ;
 ;
DISPUNIT(PRCPINPT,ITEMDA) ;  drug accountability dispensing units
 N %,D,D0,DA,DD,DDH,DI,DIC,DIE,DISYS,DIX,DIY,DO,DQ,DR,DZ,X,Y
 S DA(1)=PRCPINPT,DA=ITEMDA,(DIC,DIE)="^PRCP(445,"_PRCPINPT_",1,",DR="50;51"
 S PRCPPRIV=1 D ^DIE K PRCPPRIV
 Q
 ;
 ;
EDNORM(PRCPINPT,ITEMDA,TEXT,PRCPQUIT) ; editing the normal level on supply station secondaries
 ; ITEMDA   = item number requiring the default description
 ; PRCPINPT = inventory point
 ; TEXT = text to display when prompting the user
 ; PRCPQUIT = flag to signify exit desired
 ;
 N DA,DIC,DIE,DIR,DR,ORD,PRCPNL,PRCPPRIV,VALUE
 ; because this is sometimes called from templates, new FileMan variables
 N D,D0,D1,D2,D3,D4,D5,D6,DB,DC,DD,DE,DG,DH,DI,DIA,DIADD,DICR,DIEC,DIEL
 N DIFLD,DIK,DIOV,DK,DL,DLAYGO,DM,DO,DOV,DP,DQ,DU,DV,DW,I,J,X,Y
 I $P(^PRCP(445,PRCPINPT,0),"^",3)'="S" QUIT
 I '$P($G(^PRCP(445,PRCPINPT,5)),"^",1) QUIT
 I '$D(^PRCP(445,PRCPINPT,1,ITEMDA,0)) QUIT
 S PRCPNL=+$P(^PRCP(445,PRCPINPT,1,ITEMDA,0),"^",9)
 S ORD=0
 S ORD=$$ORDCHK^PRCPUITM(ITEMDA,PRCPINPT,"R","")
 I ORD D  ; this field is also a flag of items on supply station, editing must be restricted if there are outstanding supply station orders.
 . N DIR
 . S DIR("A")=TEXT
 . S DIR("A",1)="There are outstanding regular orders for this item."
 . S DIR("A",2)="You cannot delete the normal level or make it 0"
 . S DIR(0)="N^1:999999"
 . S DIR("B")=PRCPNL
 . D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT) S PRCPQUIT=1 Q
 . I X S PRCPNL=X D
 . . S DA(1)=PRCPINPT,DA=ITEMDA,PRCPPRIV=1
 . . S (DIC,DIE)="^PRCP(445,"_PRCPINPT_",1,"
 . . S DR="9///^S X=PRCPNL"
 . . D ^DIE
 . . K DIC,DIE
 I 'ORD D
 . I PRCPNL'>0 W !!,"Changing the level from zero will add the item to the supply station."
 . I PRCPNL>0 W !!,"Changing the level to zero will delete the item from the supply station."
 . I $D(DUOUT)!$D(DTOUT) S PRCPQUIT=1 Q
 . S DIR(0)="445.01,9^^",DA(1)=PRCPINPT,DA=ITEMDA
 . D ^DIR K DIR
 . S VALUE=Y
 . I $D(DTOUT)!$D(DUOUT) S PRCPQUIT=1 Q
 . S DR="9///^S X=VALUE"
 . S DA=ITEMDA,DA(1)=PRCPINPT,PRCPPRIV=1
 . S (DIC,DIE)="^PRCP(445,"_PRCPINPT_",1,"
 . D ^DIE
 . K DIC,DIE
 . I PRCPNL,'$P(^PRCP(445,PRCPINPT,1,ITEMDA,0),"^",9) D BLDSEG^PRCPHLFM(2,ITEMDA,PRCPINPT)
 . I 'PRCPNL,$P(^PRCP(445,PRCPINPT,1,ITEMDA,0),"^",9) D BLDSEG^PRCPHLFM(1,ITEMDA,PRCPINPT)
 QUIT
