PRCH58LQ ;WISC/CLH-1358 LIQUIDATIONS ;10/30/92  1:53 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
LIQ(PRCFA,Y,ER,PO) N DIC,Z,ZX,X
 S ER=1,DIC=442,DIC(0)="AMZEQ",DIC("A")="Select OBLIGATION NUMBER: ",DIC("S")="S Z=^(0) I +Z=PRC(""SITE""),$P(Z,U,2)=ZX",ZX=$O(^PRCD(442.5,"C",1358,0))
 K PRCFA("PODA") D ^DIC I Y<0 S ER=0 Q
 S PRCFA("PODA")=+Y,PRCFA("TRDA")=$P(Y(0),"^",12)
 F I=0,7,8,12 S PO(I)=$G(^PRC(442,PRCFA("PODA"),I))
 S:$D(^PRC(442,PRCFA("PODA"),7)) X=$P(^(7),"^",1)
 Q:$D(LOOK)
 I X=$O(^PRCD(442.3,"AC",40,0)) W $C(7),!!,"This 1358 transaction is complete.  Transaction must be reactivated",!,"before additional posting may occur." Q:$D(PRCFA("XM"))  S ER=0 Q
 I $O(^PRCD(442.3,"AC",+X,0))=$O(^PRCD(442.3,"AC",105,0)) W $C(7),!!,"This 1358 transaction has been cancelled.",!,"No posting is permitted." S ER=0 Q
 Q
POST(PRCFA,LAMT,PO) ;post liquidated balance
 N OB,NB,DIE,DR,DA
 S OB=$P($G(^PRC(442,PRCFA("PODA"),8)),U,2),NB=OB+LAMT
 S DR="95////^S X=NB",DIE="^PRC(442,",DA=PRCFA("PODA") D ^DIE
 S PO(8)=^PRC(442,PRCFA("PODA"),8)
 Q
