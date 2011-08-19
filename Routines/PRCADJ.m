PRCADJ ;SF-ISC/YJK,ALB/CMS - ADJUSTMENT TRANSACTION ;9/7/95  10:58 AM
 ;;4.5;Accounts Receivable;**21,67,48,89,63,111,123,131,134,169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
 ;
UPPRIN ;Update Prin bal
 N DA,DIE,DR,X,Y
 Q:('$D(PRCABN))!('$D(PRCAMT))
 Q:'$D(^PRCA(430,+PRCABN,7))
 S PRCAMT("C")=$P(^PRCA(430,+PRCABN,7),U,1)+PRCAMT
 S DA=+PRCABN,DIE="^PRCA(430,",DR="71////^S X="_PRCAMT("C") D ^DIE
 S (X,PRCAMT("C"))=$G(^PRCA(430,+PRCABN,7))
 I ($P($G(^PRCA(430,+$G(PRCABN),0)),"^",2)=$O(^PRCA(430.2,"AC",33,0))),($P($G(^PRCA(430,+PRCABN,0)),U,8)'=$O(^PRCA(430.3,"AC",112,0))) Q
 I $P(X,"^",1)+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5)=0 D
 .S PRCA("SDT")=DT,PRCA("STATUS")=$O(^PRCA(430.3,"AC",111,0))
 .D CHK,UPSTATS^PRCAUT2,EOB
 S RCREF=$P($G(^PRCA(430,+PRCABN,6)),U,5)
 I RCREF]"" D
 .S RCREF=$S(RCREF="DC":"RC",1:RCREF)
 .S DA=+PRCAEN,DIE="^PRCA(433,",DR="7///^S X=RCREF" D ^DIE
 Q
 ;
EOB ;Another payer bulletin call
 I ($P($G(^PRCA(433,+PRCAEN,8)),"^",8)),($P($G(^PRCA(430.2,+$P($G(^PRCA(430,+PRCABN,0)),U,2),0)),U,6)="T") D
 .S PRCAMT("O")=$P($G(^PRCA(430,+PRCABN,0)),"^",3)
 .S PRCAMT=PRCAMT("O")+PRCAMT
 .D BULL^IBCNSBL2(PRCABN,PRCAMT("O"),$$PAID^PRCAFN1(+PRCABN))
 Q
 ;
DIE ;Edit AR Transaction
 N DA,DIE,DR
 S DR=PRCATEMP,DIE="^PRCA(433,",DA=PRCAEN D ^DIE
 I '$D(PRCAMT) S PRCAD("DELETE")=1
 Q
 ;
UPFY ;Update 433 FY multiple
 Q:('$D(PRCAMT))!('$D(PRCAA2))
 S $P(^PRCA(433,PRCAEN,4,PRCAA2,0),U,5)=PRCAMT
 S $P(^PRCA(433,PRCAEN,4,PRCAA2,0),U,2)=$P(^PRCA(433,PRCAEN,4,PRCAA2,0),U,2)+PRCAMT,$P(^(0),U,4)=1
 Q
 ;
EN1 ;Get Adj. No. Called from within 433 PRCA FY Input Templates
 Q:'$D(PRCABN)
 NEW X
 F X=0:0 S X=$O(^PRCA(433,"C",PRCABN,X)) Q:'X  I $P($G(^PRCA(433,X,1)),"^",4) I $P(^(1),"^",2)=1!($P(^(1),"^",2)=35) S PRCAQNM=$P(^(1),"^",4)+1
 Q
 ;
CHK ;Check for payment transactions or contractual adjustment
 NEW DIR,X,Y
 I $D(^PRCA(433,+$G(PRCAEN),8)),$P(^(8),"^",8) D  Q
 .S DIR("B")=$P($G(^PRCA(430.3,+PRCA("STATUS"),0)),"^"),DIR("A")="FINAL STATUS",DIR(0)="SOBX^CA:CANCELLATION;CO:COLLECTED/CLOSED"
 .S DIR("?",1)="Enter either:"
 .S DIR("?",2)="       'CA' for 'CANCELLATION'"
 .S DIR("?",3)="       'CO' for 'COLLECTED/CLOSED'"
 .S DIR("?",4)="These are the only selectable statuses."
 .S DIR("?")="An up-arrow or <RETURN> will accept the default of 'CANCELLATION' because status is required."
 .D ^DIR Q:Y=""  I Y="CO" S PRCA("STATUS")=$O(^PRCA(430.3,"AC",108,0))
 F X=0:0 S X=$O(^PRCA(433,"C",PRCABN,X)) Q:'X  I ",2,7,20,"[(","_$P($G(^PRCA(430.3,+$P($G(^PRCA(433,X,1)),"^",2),0)),"^",3)_",") S PRCA("STATUS")=$O(^PRCA(430.3,"AC",108,0)) Q
 Q
 ;
UPFYRC ;Update 433
 Q:('$D(PRCAMT))!('$D(PRCAA2))
 S $P(^PRCA(433,PRCAEN,4,PRCAA2,0),U,5)=PRCAMT
 S $P(^PRCA(433,PRCAEN,4,PRCAA2,0),U,2)=$G(PRCAPBAL)+PRCAMT,$P(^(0),U,4)=1
 Q
