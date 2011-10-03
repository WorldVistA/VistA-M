PRCAUT3 ;SF-ISC/YJK-AR UTILITY ROUTINE ;11/19/96  10:28 AM
V ;;4.5;Accounts Receivable;**34,63,173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
CTNEW ;count new bills. called by AR clerk's main menu.
 I $P(^RC(342,1,0),"^",10)<DT W *7,!!,"WARNING!! The AR Package was last updated on: ",$$SLH^RCFN01($P(^RC(342,1,0),"^",10)),!,"*** Contact IRM Service!" H 5
 D ^RCCPCBAK
 I $O(^PRCA(430,"AC",+$O(^PRCA(430.3,"AC",104,0)),0)) W *7,!!,"*** You have NEW BILL(s) that need to be audited ***"
 I $O(^PRCA(430,"AC",+$O(^PRCA(430.3,"AC",110,0)),0)) W *7,!!,"*** You have AMENDED BILL(s) that need to be audited ***"
 I $O(^PRCA(430,"AC",+$O(^PRCA(430.3,"AC",113,0)),0)) W !!,*7,"*** You have PREPAYMENT BILL(s) that need to be reviewed for refund ***"
 D ECHK^RCRCUTL
 Q
COMMENTS ;put comments in the 430.
 Q:'$D(PRCABN)
 ;
 I $G(PRAUTOA) D  Q
 . N PRCATEXT ; Stuff comment if auto-audit
 . I $O(^PRCA(430,PRCABN,10,0)) S PRCATEXT(1)=" "
 . S PRCATEXT($O(PRCATEXT(""),-1)+1)="*** AUTO-AUDITED BY ELECTRONIC RETURN MESSAGE RECEIPT "_$$FMTE^XLFDT($$NOW^XLFDT(),2)
 . D WP^DIE(430,PRCABN_",",10,"A","PRCATEXT")
 ;
 S %=2 W !,"Do you want to write any comments for this bill " D YN^DICN I %<0 S PRCA("EXIT")="" Q
 Q:%=2  I %=0 W !," You may add/edit comments to this word processing field for the bill." G COMMENTS
 S DIE="^PRCA(430,",DR="98",DA=PRCABN D ^DIE K DR,DA,DIE,% Q
PRCOMM ;print the comments.
 Q:('$D(D0))&('$D(PRCABN))  S PRCAD0=$S($D(PRCABN):PRCABN,1:D0) I '$D(^PRCA(430,PRCAD0,10)) G CANCL
 W !,"COMMENTS:" S PRCAKN=0
 F PRCAI=0:0 S PRCAKN=$O(^PRCA(430,PRCAD0,10,PRCAKN)) Q:'PRCAKN  W !,?3,^(PRCAKN,0)
CANCL ;W ! S PRCAKSTA=$P(^PRCA(430,PRCAD0,0),U,8)
 ;I PRCAKSTA=$O(^PRCA(430.3,"AC",111,0)) W !,"CANCELLATION REMARKS: ",?13,$P(^PRCA(430,PRCAD0,0),U,15)
 W ! K PRCAKN,PRCAI,PRCAD0,PRCAKSTA Q
CKSTAT ;Input transform for 430,8 (AR Current Status) - DA=Bill#
 N Z1,Z2
 S Z1=100,Z2=199 S:$D(PRCASV("STATUS")) Z1=199,Z2=300 S DIC("S")="I $P(^PRCA(430.3,Y,0),U,3)>Z1,$P(^(0),U,3)<Z2" S:$D(PRCAOLD) DIC("S")="I $P(^(0),U,5)=1" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X Q:'$D(X)
 I $D(^PRCA(430.3,X,0)),$P(^(0),"^",3)'=102 Q
 Q:",22,23,26,18,"[(","_$P(^PRCA(430,DA,0),U,2)_",")  ;RX/MEANS NO PAT
 ;F Y=0:0 S Y=$O(^PRCA(430,DA,2,Y)) Q:'Y  I $P(^(Y,0),"^",3)="" W *7,!!,"Fiscal Year ",+^(0)," for bill #",$P(^PRCA(430,DA,0),"^")," has no PAT ref #!",!,"A PAT ref # must be assigned to this FY before the bill",!,"can be made active.",! K X
 Q
