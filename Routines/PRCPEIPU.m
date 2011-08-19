PRCPEIPU ;WISC/RFJ/DXH - procurement source update utilities ;10.7.99
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SETMAN(INVPT,ITEMDA,SOURCE) ;  set mandatory source for inventory point
 I '$D(^PRCP(445,+INVPT,1,+ITEMDA,0)) Q
 N %,VENOLD,VENNEW
 S %=$P(^PRCP(445,+INVPT,1,+ITEMDA,0),"^",12),VENOLD=$S(%="":"<<NOT DEFINED>>",%["PRC(440":$P($G(^PRC(440,+%,0)),"^"),1:$P($G(^PRCP(445,+%,0)),"^")) S:VENOLD="" VENOLD="<<NOT FOUND>>"
 S VENNEW=$S(SOURCE="":"<<NOT DEFINED>>",SOURCE["PRC(440":$P($G(^PRC(440,+SOURCE,0)),"^"),1:$P($G(^PRCP(445,+SOURCE,0)),"^")) S:VENNEW="" VENNEW="<<NOT FOUND>>"
 I %=SOURCE W !!?5,"MANDATORY SOURCE (for inventory point item): ",VENOLD Q
 W !!?5,"...inventory point item mandatory source being changed",!?8,"from: ",VENOLD,!?8,"  to: ",VENNEW
 K:%'="" ^PRCP(445,INVPT,1,"AC",%,ITEMDA)
 S $P(^PRCP(445,INVPT,1,ITEMDA,0),"^",12)=SOURCE S:SOURCE'="" ^PRCP(445,INVPT,1,"AC",SOURCE,ITEMDA)=""
 Q
 ;
 ;
EDITSOUR(PRCPINPT,ITEMDA) ;  edit procurement sources for invpt and item
 I '$D(^PRCP(445,+PRCPINPT,1,+ITEMDA)) Q
 N %,D,D0,D1,DA,PRCPPRIV,DD,DDH,DI,DIC,DIC1,DIE,DIX,DIY,D0,DLAYGO,DQ,DR,X,Y
 I '$D(^PRCP(445,PRCPINPT,1,ITEMDA,5,0)) S ^(0)="^445.07I^^"
 S (DIC,DIE)="^PRCP(445,"_PRCPINPT_",1,",DA(1)=PRCPINPT,DA=ITEMDA,DR=".6;.4" D ^DIE
 Q
 ;
 ;
UPDATE(PRCPINPT,ITEMDA) ;  update the unit per receipt = unit per issue
 ;  for all inventory points stocked by invpt prcpinpt
 I '$D(^PRCP(445,+PRCPINPT,1,+ITEMDA,0)) Q
 N %,D,INVPTDA,INVPTNM,SOURCE,TYPE,UI,UNITS
 S UI=$$UNIT^PRCPUX1(PRCPINPT,ITEMDA," per ") I UI["?" Q
 S INVPTNM=$$INVNAME^PRCPUX1(PRCPINPT),TYPE=$P(^PRCP(445,PRCPINPT,0),"^",3),D=^PRCP(445,PRCPINPT,1,ITEMDA,0),UNITS=$P(D,"^",5)_"^"_$P(D,"^",14) I TYPE="S" Q
 S XP="  Do you want to update the UNIT per RECEIPT (equal to the UNIT PER ISSUE) for",XP(1)="  ALL distribution points stocked by "_INVPTNM
 S XH="  Enter 'YES' to loop through ALL the distribution points changing the receipt",XH(1)="  units equal to the issue units for the "_$E(INVPTNM,1,25)_" procurement",XH(2)="  source."
 I $$YN^PRCPUYN(1)'=1 Q
 W !!,"updating the u/r equal to u/i ***PLEASE CHECK CONVERSION FACTORS***"
 S SOURCE=PRCPINPT_";PRCP(445,"
 I TYPE="W" S SOURCE=$O(^PRC(440,"AC","S",0))_";PRC(440," I 'SOURCE W !,"THERE IS NOT A VENDOR DEFINED AS SUPPLY WAREHOUSE IN THE VENDOR FILE." Q
 S INVPTDA=0 F  S INVPTDA=$O(^PRCP(445,INVPTDA)) Q:'INVPTDA  I $D(^PRCP(445,INVPTDA,1,ITEMDA,0)) S D=$$GETVEN^PRCPUVEN(INVPTDA,ITEMDA,SOURCE,1) I $P(D,"^",5) D
 .   I $P(D,"^",2,3)=UNITS Q
 .   W !,$E($$INVNAME^PRCPUX1(INVPTDA),1,17),?19,"OLD U/R: ",$$UNITVAL^PRCPUX1($P(D,"^",3),$P(D,"^",2)," per "),?44,"NEW U/R: ",UI,?69,"CF: ",$P(D,"^",4)
 .   S $P(D,"^",2,3)=UNITS,^PRCP(445,INVPTDA,1,ITEMDA,5,$P(D,"^",5),0)=D
 D R^PRCPUREP
 Q
