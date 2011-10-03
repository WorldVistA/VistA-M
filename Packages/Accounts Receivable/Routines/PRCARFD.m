PRCARFD ;WASH-ISC@ALTOONA,PA/CMS-REFUND REVIEW AND APPROVE ;10/31/96  10:19 AM
V ;;4.5;Accounts Receivable;**55,169,198**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Review Prepayment and Sign Elec Sig
 N DA,DIC,DIE,DIR,DN,DR,D0,OP,PRCA,PRCABN,PRCAIO,PRCASUP,PRCAT,RR,X,Y
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
EN1 S OP=+$O(^PRCA(430.3,"AC",112,0)),OP(1)=$P(^PRCA(430.3,+OP,0),U)
 S RR=+$O(^PRCA(430.3,"AC",113,0)),RR(1)=$P($G(^PRCA(430.3,+RR,0)),U)
 S D0=+$O(^PRCA(430.2,"AC",33,0)),D0(1)=$P(^PRCA(430.2,+D0,0),U)
 I $D(^XUSEC("PRCAY PAYMENT SUP",DUZ)) S PRCASUP=DUZ
 S DIC="^PRCA(430,",DIC("S")="I $P(^(0),U,2)="_D0_",($P(^(0),U,8)="_RR_"!($P(^(0),U,8)="_OP_"))",DIC(0)="AEQMZ" D ^DIC G:$G(Y)<1 EN1Q S PRCABN=+Y
 I $P(^PRCA(430,PRCABN,9),U,2)]"",$$GSTAT^RCFMFN02("B"_+PRCABN)<0 W !!,"This bill has been APPROVED" D  W !! G EN1
 .S Y=$P($G(^PRCA(430,+PRCABN,9)),U,3) W " but an FMS document was NOT created " D
 ..I Y D DD^%DT W !,"on ",Y," by ",$P($G(^VA(200,+$P(^PRCA(430,PRCABN,9),U),0)),U)
 .S DIR(0)="Y",DIR("A")="Do you want to CREATE the document now" D ^DIR K DIR D:Y FMSDOC^PRCARFD1
 I $P(^PRCA(430,PRCABN,7),U,21) W !!,*7,"This bill is ready for the Certifying Official's approval.",! D
 .W !,"It has been reviewed by ",$P($G(^VA(200,+$P(^PRCA(430,PRCABN,7),U,21),0)),U),!
 E  W !!,"This bill has not been reviewed for approval yet.",!,"It must be signed by a refunder to be ",!,"ready for the Certifying Official's approval.",!
 I $P(^PRCA(430,PRCABN,0),U,8)'=RR,'$G(PRCASUP) W !!,"AUTHORIZED FISCAL USER MUST CHANGE STATUS OF BILL TO 'REFUND REVIEW'",! G EN1
 S DIR(0)="Y",DIR("A")="Do you want to review the prepayment bill at this time" D ^DIR K DIR G:$D(DIRUT) EN1Q
 I Y D:$G(IO)']"" HOME^%ZIS S D0=PRCABN,PRCAIO=IO,PRCAIO(0)=IO(0) D PROC^PRCAPRO
 I $P(^PRCA(430,PRCABN,0),U,8)'=RR S DIR(0)="Y",DIR("A")="Do you want to change the status to 'REFUND REVIEW' at this time" D ^DIR K DIR G:$D(DIRUT) EN1Q G:Y'=1 EN1 D RR(PRCABN) W !!,"Status Changed to 'REFUND REVIEW'",!
 I $P(^PRCA(430,PRCABN,9),U,2)']"" K DIRUT S DIR(0)="Y",DIR("A")="Do you want to make any adjustments to the refund amount now" D ^DIR K DIR G:$D(DIRUT) EN1Q
 I $P(^PRCA(430,PRCABN,9),U,2)']"",Y D  G:$D(DIRUT) EN1Q
 .K DIRUT S DIR(0)="S^I:INCREASE;D:DECREASE" D ^DIR K DIR Q:$D(DIRUT)
 .   I Y'="I",Y'="D" Q
 .   D ADJBILL^RCBEADJ($S(Y="I":"INCREASE",1:"DECREASE"),PRCABN)
 .   ;  set refund fills and clear esigs
 .   ;    79.18 = refunded amount      90 = approved by
 .   ;    79.21 = refunded by          91 = ar elecronic signature
 .   ;    111   = approving official  112 = electronic signature
 .   N %,BALANCE,DATA7
 .   S DATA7=$G(^PRCA(430,PRCABN,7))
 .   S BALANCE=$P(DATA7,"^")+$P(DATA7,"^",2)+$P(DATA7,"^",3)+$P(DATA7,"^",4)+$P(DATA7,"^",5)
 .   S %=$$EDIT430^RCBEUBIL(PRCABN,"79.18////"_BALANCE_";90///@;79.21///@;91///@;111///@;112///@")
 ;
 ;  bill is no longer in refund review (i.e. cancelled with a decrease)
 I $P(^PRCA(430,PRCABN,0),"^",8)'=44 W !!,"Bill status is no longer REFUND REVIEW.  It has changed to ",$P($G(^PRCA(430.3,+$P(^PRCA(430,PRCABN,0),"^",8),0)),"^"),".",! G EN1
 ;
 I $P($G(^PRCA(430,PRCABN,104)),U,2)="" S DIR(0)="Y",DIR("A")="Do you want to send the refund to the certifying official for approval now" D ^DIR K DIR G:$D(DIRUT) EN1Q G:Y'=1 EN1
 I ($P($G(^(7)),U,21)=DUZ) W !!,"DUPLICATE AUTHORIZER!" G EN1
 I '$G(PRCASUP),$P($G(^PRCA(430,PRCABN,104)),U,2)]"" W !!,"UNAUTHORIZED TO SIGN AS CERTIFYING OFFICER" G EN1
 I '$G(PRCASUP) D EDTR G EN1
 I $G(PRCASUP),$P($G(^PRCA(430,PRCABN,104)),U,2)="" D  G:$D(DIRUT) EN1Q D:Y=1 EDTR G EN1
 .S DIR("A")="Sign as the 'REFUNDED BY' person",DIR("A",1)="This refund must first be approved by the refunder.",DIR("A",2)="If you sign as the 'Refunded By' person, you CANNOT",DIR(0)="Y"
 .S DIR("A",3)="sign as the Certifying Officer.",DIR("A",4)=" "
 .D ^DIR K DIR
 .Q
 I $G(PRCASUP),$P($G(^PRCA(430,PRCABN,7)),U,21)]"" D APPRV^PRCARFD1 G EN1
EN1Q Q
 ;
 ;
EDTR ;Enter Elec sig for refunder
 N DA,PRCANM,RA,X,Y
 F X=1:1:5 S RA=+$G(RA)+$P($G(^PRCA(430,PRCABN,7)),U,X)
 I +$G(RA)'=$P($G(^PRCA(430,PRCABN,7)),U,18) W !!,"REFUND AMOUNT OUT-OF-BALANCE!",! Q
 S DA=+PRCABN D SIG^PRCASIG I $G(PRCANM)']"" W !!,"DID NOT APPROVE REFUND" Q
 L +^PRCA(430,PRCABN):1 Q:'$T  S $P(^PRCA(430,PRCABN,104),U,2)=PRCANM,$P(^PRCA(430,PRCABN,7),U,21)=DUZ,$P(^(7),U,19)=$G(DT) L -^PRCA(430,PRCABN) W !," <APPROVED BY REFUNDER>"
 Q
CANC(BN) ;Change status of prepay bill to CANCELLATION
 N DA,DIE,DR
 I $P(^PRCA(430,BN,7),U,1)>0 Q
 S DA=BN,BN=+$O(^PRCA(430.3,"AC",111,0)),DIE="^PRCA(430,",DR="8////"_BN D ^DIE
 Q
RR(BN) ;Change status of prepay bill to REFUND REVIEW
 N DA,DIE,DR,RA,X
 F X=1:1:5 S RA=+$G(RA)+$P($G(^PRCA(430,BN,7)),U,X)
 S DA=BN,BN=+$O(^PRCA(430.3,"AC",113,0)),DIE="^PRCA(430,",DR="8////"_BN_";79.18////"_RA_";90///@;79.21///@;91///@;111///@;112///@" D ^DIE
 Q
 ;
DISP(PRCABN) ;Display refund approvals
 N X,X1,X2,RA,Y
 Q:$P(^PRCA(430,PRCABN,0),U,2)'=$O(^PRCA(430.2,"AC",33,0))
 W !,"REFUND APPROVAL SIGNATURES"
 S RA=+$P($G(^PRCA(430,PRCABN,7)),U,18) I 'RA F X=1:1:5 S RA=+$G(RA)+$P($G(^PRCA(430,PRCABN,7)),U,X)
 S X=$P($G(^PRCA(430,PRCABN,9)),U,2) I X]"" S X1=+$P(^(9),U,1),X2=PRCABN_RA D DE^PRCASIG(.X,X1,X2) W !!,"Certifying Officer: ",X,"    Signed on: " S Y=+$P(^PRCA(430,PRCABN,9),U,3) I +$G(Y) X ^DD("DD") W Y,!
 S X=$P($G(^PRCA(430,PRCABN,104)),U,2) I X]"" S X1=+$P(^(7),U,21),X2=PRCABN_RA D DE^PRCASIG(.X,X1,X2) W !!,"Reviewed By: ",X,"    Signed on: " S Y=+$P(^PRCA(430,PRCABN,7),U,19) I +$G(Y) X ^DD("DD") W Y,!
 Q
