PRCPEITD ;WISC/RFJ-enter,edit items for distribution point          ;01 Dec 93
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I "PW"'[PRCP("DPTYPE") W !,"This option can only be used by primary or warehouse inventory points." Q
 N %,D,D0,D1,DA,DATA,DI,DIC,DIE,DQ,DR,DISTRPT,GROUP,ITEMDA,ITEMDATA,MANDATA,MANSRCE,PRCPFLAG,PRCPINPT,PRCPSTOP,X,Y
 F  D  I $G(PRCPFLAG) QUIT
 .   W !!?7,"You can only edit items in distribution points"
 .   W !?7,"NOT keeping a perpetual inventory."
 .   S DISTRPT=+$$TO^PRCPUDPT(PRCP("I")) I 'DISTRPT S PRCPFLAG=1 Q
 .   I $P($G(^PRCP(445,DISTRPT,0)),"^",2)="Y" Q
 .   L +^PRCP(445,DISTRPT,1):5 I '$T D SHOWWHO^PRCPULOC(445,DISTRPT_"-1",0) Q
 .   D ADD^PRCPULOC(445,DISTRPT_"-1",0,"Enter/Edit Items On Distribution Point")
 .   K PRCPSTOP F  D  Q:$G(PRCPSTOP)
 .   .   W !!
 .   .   S ITEMDA=$$ITEM^PRCPUITM(DISTRPT,1,",$D(^PRCP(445,"_PRCP("I")_",1,+Y,0))","")
 .   .   I ITEMDA["^" S (PRCPFLAG,PRCPSTOP)=1 Q
 .   .   I 'ITEMDA S PRCPSTOP=1 Q
 .   .   S GROUP=$$GROUPDA^PRCPEGRP(DISTRPT,ITEMDA)
 .   .   I 'GROUP S GROUP=$$GROUPDA^PRCPEGRP(PRCP("I"),ITEMDA) I GROUP S DATA=$G(^PRCP(445.6,GROUP,0)) I DATA'="" D
 .   .   .   ;  lookup group category
 .   .   .   S Y=+$$GROUP^PRCPEGRP(DISTRPT,$P(DATA,"^"))
 .   .   .   I Y>0 D SETGRP^PRCPEGRP(DISTRPT,ITEMDA,Y) Q
 .   .   .   ;  add group category to group category file
 .   .   .   S Y=$$ADDGRP^PRCPEGRP(DISTRPT,$P(DATA,"^"),$P(DATA,"^",3))
 .   .   .   I Y D SETGRP^PRCPEGRP(DISTRPT,ITEMDA,Y)
 .   .   ;
 .   .   S %=$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,6)),"^")
 .   .   I %'="" S $P(^PRCP(445,DISTRPT,1,ITEMDA,6),"^")=%
 .   .   ;
 .   .   S DATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   .   S MANSRCE=PRCP("I")_";PRCP(445,"
 .   .   I PRCP("DPTYPE")="W" S MANSRCE=$O(^PRC(440,"AC","S",0))_";PRC(440,"
 .   .   I +MANSRCE D
 .   .   .   S $P(^PRCP(445,DISTRPT,1,ITEMDA,0),"^",12)=MANSRCE
 .   .   .   S ^PRCP(445,DISTRPT,1,"AC",$E(MANSRCE,1,30),ITEMDA)=""
 .   .   .   W !?5,"MANDATORY SOURCE : ",$$VENNAME^PRCPUX1(MANSRCE)
 .   .   .   I '$$GETVEN^PRCPUVEN(DISTRPT,ITEMDA,MANSRCE,1) D ADDVEN^PRCPUVEN(DISTRPT,ITEMDA,MANSRCE,$P(DATA,"^",5),$P(DATA,"^",14),1)
 .   .   S MANDATA=$$GETVEN^PRCPUVEN(DISTRPT,ITEMDA,MANSRCE,1)
 .   .   S ITEMDATA=^PRCP(445,DISTRPT,1,ITEMDA,0)
 .   .   S:$P(ITEMDATA,"^",5)="" $P(ITEMDATA,"^",5)=$P(DATA,"^",5)
 .   .   S:$P(ITEMDATA,"^",14)="" $P(ITEMDATA,"^",14)=$P(DATA,"^",14)
 .   .   S ^PRCP(445,DISTRPT,1,ITEMDA,0)=ITEMDATA
 .   .   W !?5,"UNIT per ISSUE   : "
 .   .   W $$UNITVAL^PRCPUX1($P(ITEMDATA,"^",14),$P(ITEMDATA,"^",5)," per ")
 .   .   I MANDATA D
 .   .   .   W !?5,"UNIT per RECEIPT : "
 .   .   .   W $$UNITVAL^PRCPUX1($P(MANDATA,"^",3),$P(MANDATA,"^",2)," per ")
 .   .   .   W !?5,"CONVERSION FACTOR: ",$P(MANDATA,"^",4)
 .   .   S DR=".01;4;4.5;.6;4.7;9;5;"_$S(PRCP("DPTYPE")="W":"14.3;14.4;",1:"")
 .   .   S DR(2,445.07)="3;"
 .   .   I $P(^PRCP(445,DISTRPT,0),"^",3)="S",$P($G(^PRCP(445,DISTRPT,5)),"^",1)]"" D
 .   .  .   D EDNORM^PRCPEITE(DISTRPT,ITEMDA,"NORMAL STOCK LEVEL")
 .   .  .   I $D(DUOUT)!$D(DTOUT) S PRCPSTOP=1 Q
 .   .  .   S DR=".01;4;4.5;.6;4.7;5;"_$S(PRCP("DPTYPE")="W":"14.3;14.4;",1:"")
 .   .   I $G(PRCPSTOP) S PRCPFLAG=1 Q  ; allow user to exit item editing
 .   .   S DIE="^PRCP(445,"_DISTRPT_",1,"
 .   .   S (DA(1),PRCPINPT)=DISTRPT
 .   .   S (DA,D1)=ITEMDA
 .   .   D ^DIE K DIC,DIE,DR I $D(Y) Q
 .   .   D BLDSEG^PRCPHLFM(3,ITEMDA,DISTRPT) ; send supply station an update of any changes to the item
 .   L -^PRCP(445,DISTRPT,1,ITEMDA) ; do this even if user enters '^'
 .   D CLEAR^PRCPULOC(445,DISTRPT_"-1",0)
 Q
