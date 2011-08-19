PRCPAWAP ;WISC/RFJ-adjustment approval                              ;11 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$D(PRCP("I"))
 I PRCP("DPTYPE")'="W" W !,"ONLY THE WAREHOUSE CAN USE THIS OPTION." Q
 S IOP="HOME" D ^%ZIS K IOP
 ;
 N %,%DT,%H,%I,D,D0,DA,DATA,DI,DIC,DQ,DR,ITEMDA,NOW,NOWDT,PRCPFLAG,TRANID,UNAPPR,X,Y
ADJ ;  get adjustment number, quit if no adjustment is selected.
 K PRCPFLAG
 S TRANID=$$ADJUSTNO I TRANID["^" Q
 ;
 ;  get a list of unapproved adjustments and store in tmp global.
 K ^TMP($J,"PRCPAWAP")
 S (DA,UNAPPR)=0
 F  S DA=$O(^PRCP(445.2,"T",PRCP("I"),TRANID,DA)) Q:'DA  S DATA=$G(^PRCP(445.2,DA,0)) I $P(DATA,"^",5) D
 .   S ^TMP($J,"PRCPAWAP","ITEM",$P(DATA,"^",5))=DA
 .   S:'$P(DATA,"^",20) UNAPPR=UNAPPR+1,^TMP($J,"PRCPAWAP","UNAPPR",$P(DATA,"^",5),DA)=""
 W !!?10,">> THERE IS '",UNAPPR,"' UNAPPROVED ITEMS ON THIS ADJUSTMENT. <<"
 ;
 ;  approve **all** items for the selected adjustment.
 D NOW^%DTC S (Y,NOWDT)=% D DD^%DT S NOW=Y
 I UNAPPR D  I $D(PRCPFLAG) K ^TMP($J,"PRCPAWAP") G ADJ
 .   S XP="  DO YOU WANT TO APPROVE ALL OF THE ITEMS ON THIS ADJUSTMENT",XH="  ENTER 'YES' TO APPROVE ALL THE ITEMS ON THE ADJUSTMENT, 'NO' TO SELECT ITEMS."
 .   W ! S %=$$YN^PRCPUYN(2)
 .   I %=2 Q
 .   I %'=1 S PRCPFLAG=1 Q
 .   W !!?10,"approving adjustment items"
 .   S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPAWAP","UNAPPR",ITEMDA)) Q:'ITEMDA  S DA=0 F  S DA=$O(^TMP($J,"PRCPAWAP","UNAPPR",ITEMDA,DA)) Q:'DA  I $D(^PRCP(445.2,DA,0)) D
 .   .   L +^PRCP(445.2,DA)
 .   .   S DATA=^PRCP(445.2,DA,0) I $P(DATA,"^",20)="" W "." S $P(DATA,"^",20)=NOWDT,$P(DATA,"^",21)=DUZ,^(0)=DATA
 .   .   L -^PRCP(445.2,DA)
 .   W !!?10,">> ALL ITEMS ON ADJUSTMENT HAVE BEEN APPROVED. <<"
 .   S PRCPFLAG=1
 ;
ITEM ;  aprrove items as selected.  only selection of items from the
 ;  selected adjustment number.  quit if no item is selected.
 W ! S ITEMDA=$$ITEM^PRCPAWU0 I ITEMDA["^" K ^TMP($J,"PRCPAWAP") G ADJ
 S DA=^TMP($J,"PRCPAWAP","ITEM",ITEMDA)
 L +^PRCP(445.2,DA)
 S DATA=^PRCP(445.2,DA,0),DR="20  ADJUSTMENT APPROVAL" I $P(DATA,"^",20)="" S DR=DR_"//"_NOW
 E  W !!?10,">> ITEM ADJUSTMENT HAS ALREADY BEEN APPROVED, '@' FOR UNAPPROVED. <<"
 S DIE="^PRCP(445.2," D ^DIE K DIE
 S DATA=^PRCP(445.2,DA,0) I $P(DATA,"^",20),'$P(DATA,"^",21) S $P(^(0),"^",21)=DUZ,$P(DATA,"^",6)=DUZ
 I '$P(DATA,"^",20),$P(DATA,"^",21) S $P(^PRCP(445.2,DA,0),"^",21)=""
 L -^PRCP(445.2,DA)
 G ITEM
 ;
 ;
ADJUSTNO() ;  return selected adjustment number from file 445.2.
 N %,ADJNO,COUNT,PRCPFLAG,X
 F  D  Q:ADJNO'=""
 .   W !!,"Select ADJUSTMENT NUMBER: "
 .   R X:DTIME I '$T!(X["^")!(X="") S ADJNO="^" Q
 .   S:$E(X) X="A"_X
 .   I $E(X)="A",$D(^PRCP(445.2,"T",PRCP("I"),X)) S ADJNO=X Q
 .   S ADJNO=""
 .   W !,"Select the ADJUSTMENT NUMBER from the list below:",!
 .   S COUNT=0,X="A" F  S X=$O(^PRCP(445.2,"T",PRCP("I"),X)) Q:$E(X)'="A"!($G(PRCPFLAG))  D
 .   .   W "  ADJUSTMENT NUMBER: ",X S COUNT=COUNT+1
 .   .   I COUNT#20=0 D P^PRCPUREP S %="",$P(%," ",80)="" W $C(13),%
 .   .   W !
 Q ADJNO
