PRCPEIUI ;WISC/RFJ-units per issue                                  ;01 Dec 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SETUNITS(PRCPINPT,ITEMDA) ;  called to automatically set units
 I '$D(^PRCP(445,+PRCPINPT,1,+ITEMDA,0)) Q
 N D,DATA,MANSRCE,PRCPLOCK,TYPE,UI,UP,WHSESRCE
 S TYPE=$P($G(^PRCP(445,+PRCPINPT,0)),"^",3)
 I TYPE'="S" S WHSESRCE=$O(^PRC(440,"AC","S",0)) I 'WHSESRCE W !!,"YOU DO NOT HAVE A VENDOR (FILE #440) ENTERED AS A SUPPLY WAREHOUSE.",! D R^PRCPUREP Q
 ;
 ;  unit of issue (whse) = unit of receipts (whse vendor)
 S MANSRCE=$$MANDSRCE^PRCPU441(ITEMDA)_";PRC(440," S:'MANSRCE MANSRCE=""
 I TYPE="W",+MANSRCE,+MANSRCE=WHSESRCE S DATA=$G(^PRC(441,ITEMDA,2,+MANSRCE,0)) I DATA'="" D
 .   S UP=$$UNITVAL^PRCPUX1($P(DATA,"^",8),$P(DATA,"^",7)," per ")
 .   W !?4,"UNIT per PURCHASE (WHSE VENDOR): ",UP
 .   I UP["?" W !,"The UNIT per PURCHASE in the item master file needs to be correctly entered."
 .   I UP'["?" S UI=$$UNIT^PRCPUX1(PRCPINPT,ITEMDA," per ") I UI'=UP W !?4,"THE UNIT per ISSUE SHOULD EQUAL THE UNIT per PURCHASE."
 .   ;  update issue multiples (field 16,16.5) if warehouse
 .   S D=^PRCP(445,PRCPINPT,1,ITEMDA,0)
 .   W !!?5,"ISSUE MULTIPLE   : ",+$P(D,"^",25) I $P(DATA,"^",11),$P(DATA,"^",11)'=$P(D,"^",25) S $P(D,"^",25)=$P(DATA,"^",11) W ?27,"adjusted to: ",$P(D,"^",25)
 .   W !?5,"MINIMUM ISSUE QTY: ",+$P(D,"^",17) I $P(DATA,"^",12),$P(DATA,"^",12)'=$P(D,"^",17) S $P(D,"^",17)=$P(DATA,"^",12) W ?27,"adjusted to: ",$P(D,"^",17)
 .   S ^PRCP(445,PRCPINPT,1,ITEMDA,0)=D
 Q
 ;
 ;
EDITUI(PRCPINPT,ITEMDA) ;  edit unit per issue and update
 I '$D(^PRCP(445,+PRCPINPT,1,+ITEMDA,0)) Q
 N D,D0,DA,DI,DIC,DIE,DQ,DR,PRCPUI,TYPE,UI,X,Y
 S TYPE=$P(^PRCP(445,PRCPINPT,0),"^",3),PRCPUI=$$UNIT^PRCPUX1(PRCPINPT,ITEMDA," per ")
 S DA(1)=PRCPINPT,DA=ITEMDA,(DIC,DIE)="^PRCP(445,"_PRCPINPT_",1,",DR="4;4.5;"_$S(TYPE="P":"16;16.5;",1:"") W ! D ^DIE I $D(Y) Q
 S UI=$$UNIT^PRCPUX1(PRCPINPT,ITEMDA," per ") I UI=PRCPUI!(UI["?") Q
 I TYPE'="S" D UPDATE^PRCPEIPU(PRCPINPT,ITEMDA)
 Q
