PRCPUBAL ;WISC/RFJ-update beginning item balances                   ;23 Jul 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
BALANCE(INVPT,ITEMDA,PRCPMOYR) ;  update beginning monthly balance
 N %,%H,%I,D,D0,DA,DATA,DD,DI,DIC,DIE,DINUM,DLAYGO,DQ,DR,X,Y
 I 'PRCPMOYR D NOW^%DTC S PRCPMOYR=$E(X,1,5)
 I 'INVPT!('ITEMDA) Q
 ;  monthly beginning balance already set
 I $D(^PRCP(445.1,INVPT,1,ITEMDA,1,PRCPMOYR,0)) Q
 L +^PRCP(445.1,INVPT,1,ITEMDA,1,PRCPMOYR)
 I '$D(^PRCP(445.1,INVPT,0)) D  I '$D(^PRCP(445.1,INVPT,0)) D Q Q
 .   K DD,D0 S DIC="^PRCP(445.1,",DIC(0)="L",DLAYGO=445.1,(X,DINUM)=INVPT,PRCPPRIV=1 D FILE^DICN K PRCPPRIV,DIC,DLAYGO
 I '$D(^PRCP(445.1,INVPT,1,ITEMDA,0)) D  I '$D(^PRCP(445.1,INVPT,1,ITEMDA,0)) D Q Q
 .   S:'$D(^PRCP(445.1,INVPT,1,0)) ^(0)="^445.11P^^"
 .   K DA,DD,D0 S DIC="^PRCP(445.1,"_INVPT_",1,",DIC(0)="L",DLAYGO=445.1,DA(1)=INVPT,(X,DINUM)=ITEMDA D FILE^DICN K DIC,DLAYGO
 I '$D(^PRCP(445.1,INVPT,1,ITEMDA,1,PRCPMOYR,0)) D  I '$D(^PRCP(445.1,INVPT,1,ITEMDA,1,PRCPMOYR,0)) D Q Q
 .   S:'$D(^PRCP(445.1,INVPT,1,ITEMDA,1,0)) ^(0)="^445.111D^^"
 .   K DA,DD,D0 S DIC="^PRCP(445.1,"_INVPT_",1,"_ITEMDA_",1,",DIC(0)="L",DLAYGO=445.1,DA(1)=ITEMDA,DA(2)=INVPT,(X,DINUM)=PRCPMOYR D FILE^DICN K DIC,DLAYGO
 S DATA=$G(^PRCP(445,INVPT,1,ITEMDA,0))
 I $P(DATA,"^",27)="" S $P(DATA,"^",27)=$J(($P(DATA,"^",7)+$P(DATA,"^",19))*$P(DATA,"^",22),0,2)
 ;
 I $P(DATA,"^",22)'>0 S $P(DATA,"^",22)=0
 I $P(DATA,"^",15)'>0 S $P(DATA,"^",15)=0
 S DIE="^PRCP(445.1,"_INVPT_",1,"_ITEMDA_",1,",DA=PRCPMOYR,DA(1)=ITEMDA,DA(2)=INVPT
 S DR="1///"_+$P(DATA,"^",7)_";2///"_+$P(DATA,"^",19)_";3///"_$$GETIN^PRCPUDUE(INVPT,ITEMDA)_";4///"_$$GETOUT^PRCPUDUE(INVPT,ITEMDA)_";5///"_+$P(DATA,"^",22)_";6///"_+$P(DATA,"^",15)_";7///"_+$P(DATA,"^",27)
 D ^DIE
Q L -^PRCP(445.1,INVPT,1,ITEMDA,1,PRCPMOYR)
 Q
 ;
 ;
GETOPEN(INVPT,ITEMDA,DATE) ;  return open balance for invpt item for date
 N %,Y
 S Y="" I $D(^PRCP(445.2,"ABEG",+INVPT,+ITEMDA,+DATE)) S %=^(+DATE),$P(Y,"^",2)=$P(%,"^"),$P(Y,"^",8)=$P(%,"^",2)
 S %=$G(^PRCP(445.1,+INVPT,1,+ITEMDA,1,+DATE,0)) I %'="" S Y=%
 Q Y
 ;
 ;
TASKSET ;  taskman job to set beginning monthly balance
 N %,%H,%I,D,INVPT,ITEMDA,MONTH,PRCPDATE,PRCPTEXT,PRCPXMY,TYPE,X,XCNP,XMDUZ,XMZ
 D NOW^%DTC S PRCPDATE=$E(X,1,5),MONTH=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(X,4,5))_" "_(17+$E(X))_$E(X,2,3)
 S INVPT=0 F  S INVPT=$O(^PRCP(445,INVPT)) Q:'INVPT  I $P($G(^PRCP(445,INVPT,0)),"^",6)="Y" S TYPE=$P(^(0),"^",3) D
 .   L +^PRCP(445,INVPT,1)
 .   D ADD^PRCPULOC(445,INVPT_"-1",0,"Opening Balances Being Set")
 .   S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,INVPT,1,ITEMDA)) Q:'ITEMDA  I $D(^PRCP(445,INVPT,1,ITEMDA,0)) S D=^(0) D
 .   .   I TYPE="W",$P(D,"^",27)="" S %=+$J(($P(D,"^",7)+$P(D,"^",19))*$P(D,"^",22),0,2),$P(^PRCP(445,INVPT,1,ITEMDA,0),"^",27)=%
 .   .   D BALANCE(INVPT,ITEMDA,PRCPDATE)
 .   D CLEAR^PRCPULOC(445,INVPT_"-1",0)
 .   L -^PRCP(445,INVPT,1)
 .   S $P(^PRCP(445,INVPT,0),"^",22)=PRCPDATE_"00"
 .   D GETUSER^PRCPXTRM(INVPT) I '$D(PRCPXMY) Q
 .   K XMY S X=0 F  S X=$O(PRCPXMY(X)) Q:'X  I PRCPXMY(X) S XMY(X)=""
 .   I $O(XMY(0))="" Q
 .   K PRCPTEXT S PRCPTEXT(1,0)="The opening balances for the inventory point: "_$$INVNAME^PRCPUX1(INVPT),PRCPTEXT(2,0)="        have been set for the month and year: "_MONTH
 .   S XMSUB="OPENING BALANCE FOR "_MONTH_" SET",XMTEXT="PRCPTEXT(" D ^XMD
 Q
