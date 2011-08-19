PRCAUDT1 ;SF-ISC/YJK-SUBROUTINE AUDIT A NEW BILL/EDIT INCOMPLETE AR ;5/1/95  3:05 PM
V ;;4.5;Accounts Receivable;**1,173**;Mar 20, 1995
 ;This audits a new bill and edits incomplete accounts receivables.
 ;
 ; DBIA for reference to file 399.3: DBIA4118
 ;
RETN S DR="36",DA=PRCABN,DIE="^PRCA(430," D ^DIE K DR,DIE,DA
 S PRCA("STATUS")=$O(^PRCA(430.3,"AC",220,"")),PRCA("SDT")=DT,PRCASV("STATUS")=1 D UPSTATS^PRCAUT2 S $P(^PRCA(430,PRCABN,3),U,1)=DT,$P(^(3),U,2)=DUZ
 W !,"THE BILL HAS BEEN RETURNED",! Q  ;end of RETN
 K DR Q
WOBIL ;Check if the patient account has old written-off bills.
 Q:('$D(PRCAT))!('$D(PRCABN))  Q:"CP"'[PRCAT  S PRCA("DEBTOR")=$P(^PRCA(430,PRCABN,0),U,9) Q:PRCA("DEBTOR")=""  S PRCAWOB=$O(^PRCA(430.3,"AC",109,0)),Z0=0
 F PRCAWO=0:0 S Z0=$O(^PRCA(430,"C",PRCA("DEBTOR"),Z0)) Q:+Z0'>0  I Z0'=PRCABN D WOBIL1 Q:$D(PRCA("WO"))
 W:$D(PRCA("WO")) !,*7,"This debtor has had another account written-off",!
 K PRCAWO,PRCAWOB,PRCA("DEBTOR"),Z0,PRCA("WO") Q
WOBIL1 I $P(^PRCA(430,Z0,0),U,8)=PRCAWOB S PRCA("WO")=1 Q
 Q
UPBALN I $P(^PRCA(430,PRCABN,0),U,3)="",$D(^PRCA(430,PRCABN,2,0)) D ORAMT
 I '$D(^PRCA(430,PRCABN,7)) S $P(^(7),U,1)=$P(^(0),U,3)
 S:+$P(^PRCA(430,PRCABN,7),U,1)'>0 $P(^PRCA(430,PRCABN,7),U,1)=$P(^PRCA(430,PRCABN,0),U,3)
 S $P(^PRCA(430,PRCABN,0),U,4)=$S($P(^PRCA(430,PRCABN,0),U,2)>0:$P(^PRCA(430.2,$P(^(0),U,2),0),U,4),1:"")
 S $P(^PRCA(430,PRCABN,0),U,12)=$S($D(PRCA("SITE")):PRCA("SITE"),1:"") I '$D(PRCA("SITE")) W:'$G(PRAUTOA) !!,"HELP AT UPBALN+4",!
 S PRCA("STATUS")=$O(^PRCA(430.3,"AC",102,"")),PRCA("SDT")=DT D UPSTATS^PRCAUT2 Q  ;end of UPBALN
ORAMT S PRCAK1=0,%=0
 F PRCAK=0:0 S %=$O(^PRCA(430,PRCABN,2,%)) Q:'%  S PRCAK1=PRCAK1+$P(^PRCA(430,PRCABN,2,%,0),U,2)
 S $P(^PRCA(430,PRCABN,0),U,3)=PRCAK1 K PRCAK,PRCAK1,% Q
 ;
CAUSED ;edit caused by,principal balance and general ledger number.
 I '$G(PRAUTOA) K PRCA("AUTO_AUDIT")
 S DA=PRCABN,DR="[PRCA CAUSED BY]",DIE="^PRCA(430," D ^DIE
 I $D(Y) D
 . S PRCAOK=0
 . I '$G(PRAUTOA) W *7,"YOU SHOULD MAKE AN ENTRY !" Q
 . D SETERR^PRCAUDT("BILL: "_$$BILL^PRCAUDT(PRCABN)),SETERR^PRCAUDT("ERROR ENCOUNTERED STORING 'BILL RESULTING FROM'")
 K DR
 Q
 ;
THIRD ; Check for 3rd party info on AR bill
 Q:$D(^PRCA(430,PRCABN,202))
 ; PRAUTOA is the flag for IB's call to audit-audit an electronic bill
 N Z S Z="This bill does not have 3rd party information."
 I $G(PRAUTOA) D SETERR^PRCAUDT("BILL: "_$$BILL^PRCAUDT(PRCABN)),SETERR^PRCAUDT(Z) Q
 W !,Z,!
 S %=2 W "Do you want to enter the data " D YN^DICN Q:(%<0)!(%=2)
 I %=0 W !,"You may enter 'INSURED NAME', 'ID NO', 'GROUP NAME' and 'GROUP NO' for this bill.  Answer 'Y' (YES) or 'N' (NO)." G THIRD
 S DIE="^PRCA(430,",DR="[PRCAE INSURANCE DATA]",DA=PRCABN D ^DIE K DR,DIE,DA Q
 ;
RESFROM ; Update the BILL RESULTING FROM field for a rate type in RATE TYPE file
 ; #399.3
 N X,Y,DIR,RC1,RCDA,DIC,DTOUT,DUOUT
 S RC1=0
 F  S DIC(0)="AEMQ",DIC="^DGCR(399.3," W ! D ^DIC Q:Y'>0  S RCDA=+Y D  Q:$D(DUOUT)!$D(DTOUT)  ; IA 4118
 . S RC1=1
 . S DIR(0)="YA",DIR("A")="AUTO-AUDIT?: ",DIR("B")=$S($P($G(^DGCR(399.3,+RCDA,0)),U,11)'="":"YES",1:"NO")
 . D ^DIR K DIR
 . Q:$D(DUOUT)!$D(DTOUT)
 . I Y=1 S DR=".11",DIE="^DGCR(399.3,",DA=RCDA D ^DIE Q
 . S DR=".11///@",DIE="^DGCR(399.3,",DA=RCDA D ^DIE W ! Q
 Q
 ;
