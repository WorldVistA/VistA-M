IBDF10B ;ALB/CJM - ENCOUNTER FORM - (shifting selection lists);3/29/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
LSTS(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT) ;shifts all of the selection lists in IBBLK falling within the range START->END by AMOUNT - if END="" range extends all the way out
 ;WAY="D" for down, "U" for up, "L" for left, "R" for right
 N SUB,NODE,POS,LIST,PIECE,VERT,IBX,IBY,COL
 S VERT=$S("UD"[WAY:1,1:0)
 ;shifts to the left or up are negative
 S:"UL"[WAY AMOUNT=AMOUNT*(-1)
 ;must make sure there is at least one column defined with the row and column specified
 S LIST="" F  S LIST=$O(^IBE(357.2,"C",IBBLK,LIST)) Q:'LIST  D
 .S COL=$O(^IBE(357.2,LIST,1,"B","")) I COL S SUB=$O(^IBE(357.2,LIST,1,"B",COL,0))
 .S:'$G(SUB) SUB=$$ADDCOL(LIST) ;if there is no column then one must be added, otherwise positioning works through defaults
 .Q:'SUB
 .S NODE=$G(^IBE(357.2,LIST,1,SUB,0))
 .I "DU"[WAY S POS=$P(NODE,"^",2) I POS="" S POS=$S(IBBLK("BOX")=1:1,1:0),POS=POS+$S(IBBLK("HDR")="":0,1:2) S $P(^IBE(357.2,LIST,1,SUB,0),"^",2)=POS
 .I "RL"[WAY S POS=$P(NODE,"^",3) I POS="" S POS=0,$P(^IBE(357.2,LIST,1,SUB,0),"^",3)=POS
 .;now loop through all of the columns, shifting the position of each
 .S SUB=0 F  S SUB=$O(^IBE(357.2,LIST,1,SUB)) Q:'SUB  D
 ..S NODE=$G(^IBE(357.2,LIST,1,SUB,0)) Q:NODE=""
 ..S PIECE=$S(VERT:2,1:3),POS=$P(NODE,"^",PIECE),IBY=+$P(NODE,"^",2),IBX=+$P(NODE,"^",3) I POS=+POS,$$INRANGE^IBDF10A(IBX,IBY,TOP,BOTTOM,LEFT,RIGHT) S $P(^IBE(357.2,LIST,1,SUB,0),"^",PIECE)=$S(POS+AMOUNT<0:0,1:POS+AMOUNT)
 Q
ADDCOL(LIST) ;adds a column to the selection list, which has none
 S ^IBE(357.2,LIST,1,0)="^357.21I^1^1",^(1,0)="1^^^"
 K DIK,DA S DIK="^IBE(357.2,"_LIST_",1,",DA(1)=LIST,DA=1 D IX1^DIK K DIK,DA
 Q 1
