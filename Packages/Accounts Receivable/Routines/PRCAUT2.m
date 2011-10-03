PRCAUT2 ;SF-ISC/YJK-CALCULATE ADMIN. INTEREST AND CHECK NEW BILLS ;4/8/94  1:43 PM
V ;;4.5;Accounts Receivable;**68**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
UPSTATS ;update current status
 Q:('$D(PRCABN))!('$D(PRCA("STATUS")))
 S $P(^PRCA(430,PRCABN,9),U,6)=$S($P(^PRCA(430,PRCABN,0),U,8)]"":$P(^(0),U,8),1:"")
 S DIE="^PRCA(430,",DA=PRCABN,DR="8////"_PRCA("STATUS")_";17////"_$G(DUZ) D ^DIE K DIE,DR
 Q
COUNT ;count the number of returned bill to the service
 Q:'$D(DUZ)  D SVC^PRCABIL Q:'$D(PRCAP("S"))
 S (PRCAK0,PRCAK)=0,PRCAKST=$O(^PRCA(430.3,"AC",205,"")),PRCAKM=" bill(s) pending approval." D CT1
 S (PRCAK0,PRCAK)=0,PRCAKST=$O(^PRCA(430.3,"AC",220,"")),PRCAKM=" bill(s) returned from Fiscal (New Bill)." D CT1
 S PRCAK=0,PRCAK0=0,PRCAKST=$O(^PRCA(430.3,"AC",230,"")),PRCAKM=" bill(s) returned from Fiscal for amendment." D CT1
 K PRCAK0,PRCAP,PRCAKST,PRCAKM Q
CT1 F Z=0:0 S PRCAK=$O(^PRCA(430,"AC",PRCAKST,PRCAK)) Q:PRCAK'>0  I $D(^PRCA(430,PRCAK,100)),$P(^(100),U,2)=PRCAP("S") S PRCAK0=PRCAK0+1
 K PRCAK D:PRCAK0>0 CT2 K Z Q
CT2 I PRCAK0=1 W !,*7,?5,"You have 1 ",PRCAKM Q
 I PRCAK0>1 W !,?5,"You have ",PRCAK0,PRCAKM Q
 Q
