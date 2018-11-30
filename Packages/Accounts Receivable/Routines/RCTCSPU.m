RCTCSPU ;ALBANY/BDB-CROSS-SERVICING UTILITIES ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;total amount of bills for a debtor
TOTALB(DEBTOR) ;
 N TOTAL,BILL,B7
 S TOTAL=0,BILL=0
 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 .Q:'$D(^PRCA(430,"TCSP",BILL))
 .S B7=$G(^PRCA(430,BILL,7))
 .S TOTAL=TOTAL+$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 Q TOTAL
 ;
 ;stop TCSP referral on a bill
STOP ;stop Cross-Servicing referral
 N DIC,DIE,DA,DIR,Y,BILL,REASON,COMMENT,EFFDT
 S DIC=430,DIC(0)="AEQM" D ^DIC Q:Y<0
 S BILL=+Y
 I $P($G(^PRCA(430,BILL,15)),U,7) G DELSTOP
 W !,"Stop flag for Cross-Servicing Referral set? : NO"
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to stop the Cross-Servicing Referral for this bill" D ^DIR
 I 'Y W !,*7,"No action taken" Q
 ;
REASON ;ask referral reason
 K DIR S DIR("A")="Enter Stop Cross-Servicing Reason ",DA=BILL,DIR(0)="430,159" D ^DIR
 Q:(Y="")!(Y=U)
 S REASON=Y I REASON="O" D  Q:COMMENT=U  G REASON:COMMENT=""
    .S COMMENT="",DIR("A")="Enter Stop Reason Comment ",DA=BILL,DIR(0)="430,159.1" D ^DIR S COMMENT=Y
    .I COMMENT="" W !,"A Reason of Other requires a comment to be entered"
    .Q
 I REASON'="O",$P($G(^PRCA(430,BILL,15)),U,10)'="" S $P(^(15),U,10)=""
 ;
 ;ask effective date
 ;
 S DIR(0)="430,158",DA=BILL,DIR("A")="Enter Effective Date " D ^DIR G:Y=U STOPQ S EFFDT=Y
 ;
STOPFILE ;set stop referral data in file 430
 S $P(^PRCA(430,BILL,15),U,7,10)="1^"_EFFDT_U_REASON_U_$G(COMMENT)
 ;
 W !,"Stop Cross-Servicing Referral complete"
 G STOPQ
 ;
DELSTOP ;Allows Cross-Servicing Referral to be re-instituted for bill
 N I
 W !!,*7,"Referral to Cross-Servicing has already been stopped for this bill."
 W !,"Stop Cross-Servicing referral effective date: ",$$GET1^DIQ(430,BILL,158,"E")
 W !,"Stop Cross-Servicing referral reason        : ",$$GET1^DIQ(430,BILL,159,"E")
 I $$GET1^DIQ(430,BILL,159,"E")="OTHER" W !,"Stop Cross-Servicing referral comment       : ",$$GET1^DIQ(430,BILL,159.1,"E")
 S DIR(0)="Y",DIR("A")="Do you wish to re-institute Cross-Servicing Referral for this bill",DIR("B")="NO" D ^DIR G EDSTOP:'Y
 ;
 ;reset file to allow cross-servicing referral to be re-started
 F I=7:1:10 S $P(^PRCA(430,BILL,15),U,I)=""
 W !!,"Bill is now eligible to be Referred to Cross-Servicing" G STOPQ
 ;
EDSTOP S DIR(0)="Y",DIR("A")="Do you wish to edit the Stop Referral Data for this bill",DIR("B")="NO" D ^DIR G REASON:Y
STOPQ Q
 ;
 ;Set Cross-Servicing recall for a bill
RCLLSETB ;Set Cross-Servicing recall
 N DIC,DIE,DA,DIR,Y,BILL,REASON
 S DIC=430,DIC(0)="AEQM" D ^DIC Q:Y<0
 S BILL=+Y
 I $P($G(^PRCA(430,BILL,15)),U,2) G DELSETB
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to set this bill to be recalled from Cross-Servicing" D ^DIR
 I 'Y W !,*7,"No action taken" Q
 I '$D(^PRCA(430,"TCSP",BILL)) W !,*7,"No action taken.  Bill has not been referred to Cross-Servicing." Q
 ; 
RCRSB ;ask recall reason
 K DIR S DIR(0)="S^01:DEBT REFERRED IN ERROR;07:AGENCY IS FORGIVING DEBT;08:AGENCY CAN COLLECT THROUGH INTERNAL OFFSET" D ^DIR
 Q:(Y="")!(Y=U)
 ;set recall data in file 430
 S REASON=Y
 S $P(^PRCA(430,BILL,15),U,2,4)="1^^"_REASON
 ;
 W !,"Setting this bill for Recall from Cross-Servicing is complete"
 G SETBQ
 ;
DELSETB ;Allows Cross-Servicing Recall to be deleted for bill
 W !!,*7,"This bill has already been set for recall from Cross-Servicing."
 I +$P($G(^PRCA(430,BILL,15)),U,3) W !!,"Not available for reactivation.  The Recall request has already been processed." G SETBQ
 S DIR(0)="Y",DIR("A")="Do you wish to delete the Cross-Servicing Recall for this bill",DIR("B")="NO" D ^DIR G EDSETB:'Y
 ;
 ;delete the recall
 F I=2:1:5 S $P(^PRCA(430,BILL,15),U,I)=""
 W !!,"Recall from Cross-Servicing has been deleted for this bill."
 G SETBQ
 ;
EDSETB S DIR(0)="Y",DIR("A")="Do you wish to edit the Recall data for this bill",DIR("B")="NO" D ^DIR G RCRSB:Y
SETBQ Q
 ;
 ;Set Cross-Servicing recall for a debtor
RCLLSETD ;Set Cross-Servicing debtor recall
 N DIC,DIE,DA,DIR,Y,DEBTOR,REASON,BILL
 S DIC=340,DIC(0)="AEQM" D ^DIC Q:Y<0
 S DEBTOR=+Y
 I $P($G(^RCD(340,DEBTOR,7)),U,2),'$P($G(^RCD(340,DEBTOR,7)),U,3) G DELSETD
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to recall this debtor and bills from Cross-Servicing" D ^DIR
 I 'Y W !,*7,"No action taken" Q
 I '$D(^RCD(340,"TCSP",DEBTOR)) W !,*7,"No action taken.  Debtor has not been referred to Cross-Servicing." Q
 ;
RCRSD ;ask debtor recall reason
 K DIR S DIR(0)="340,7.04" D ^DIR
 Q:(Y="")!(Y=U)
 ;set debtor recall data in file 340
 S REASON=Y
 S $P(^RCD(340,DEBTOR,7),U,2,4)="1^^"_REASON
 ;go through debtor bills and set reason in the bill recall reason
 S BILL=0
 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 .I $D(^PRCA(430,"TCSP",BILL)) D  Q  ;bill previously sent to TCSP
 ..S $P(^PRCA(430,BILL,15),U,4)=REASON ;set the recall reason
 ;
 W !,"Setting this debtor for Recall from Cross-Servicing is complete"
 G SETDQ
 ;
DELSETD ;Allows Cross-Servicing Recall to be deleted for debtor
 W !!,*7,"This debtor has already been set for recall from Cross-Servicing."
 S DIR(0)="Y",DIR("A")="Do you wish to delete the Cross-Servicing Recall for this debtor",DIR("B")="NO" D ^DIR G EDSETD:'Y
 ;
 ;delete the recall in file 340
 F I=2:1:4 S $P(^RCD(340,DEBTOR,7),U,I)=""
 ;go through debtor bills and delete the reason in the bill recall reason
 S BILL=0
 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 .I $D(^PRCA(430,"TCSP",BILL)) D  Q  ;bill previously sent to TCSP
 ..S $P(^PRCA(430,BILL,15),U,4)="" ;delete the recall reason
 ;
 W !!,"Recall from Cross-Servicing has been deleted for this debtor."
 G SETDQ
 ;
EDSETD S DIR(0)="Y",DIR("A")="Do you wish to edit the Recall data for this debtor",DIR("B")="NO" D ^DIR G RCRSD:Y
SETDQ Q
 ;
DECADJ(RCBILLDA,RCTRANDA) ;decrease adjustment transaction history for 5b cross-servicing record
 ;rcbillda - file 430 bill ien
 ;rctranda - file 433 transaction ien
 N DIC,DA,DIE,DR,Y,X
 I '$D(RCBILLDA)!('$D(RCTRANDA)) Q
 S X=RCTRANDA
 S DIC="^PRCA(430,"_RCBILLDA_",17,",DIC(0)="L"
 I '$D(^PRCA(430,RCBILLDA,17,0)) S ^PRCA(430,RCBILLDA,17,0)="^430.0171PA^0^0"
 S DIC("P")=$P(^PRCA(430,RCBILLDA,17,0),"^",2)
 S DA(1)=RCBILLDA
 D ^DIC I Y=-1 K DIC,DA Q
 S DIE=DIC K DIC
 S DA=+Y
 S DR="1////1" D ^DIE
 Q
 ;
 ;Set Cross-Servicing recall for a case
RCLLSETC ;Set Cross-Servicing recall for a case
 N DIC,DIE,DA,DIR,Y,BILL,REASON
 S DIC=430,DIC(0)="AEQM" D ^DIC Q:Y<0
 S BILL=+Y
 I $P($G(^PRCA(430,BILL,15)),U,11) G DELSETC
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to set this case to be recalled from Cross-Servicing" D ^DIR
 I 'Y W !,*7,"No action taken" Q
 I '$D(^PRCA(430,"TCSP",BILL)) W !,*7,"No action taken.  Case has not been referred to Cross-Servicing." Q
 ; 
RCRSC ;set case recall reason
 ;set recall data in file 430 for the bill and the case
 S REASON=15
 S $P(^PRCA(430,BILL,15),U,11,13)="1^^"_REASON
 S $P(^PRCA(430,BILL,15),U,2,4)="1^^"_REASON
 ;
 W !,"Setting this case for Recall from Cross-Servicing is complete"
 G SETCQ
 ;
DELSETC ;Allows Cross-Servicing Recall to be deleted for case
 W !!,*7,"This case has already been set for recall from Cross-Servicing."
 S DIR(0)="Y",DIR("A")="Do you wish to delete the Cross-Servicing Recall for this case",DIR("B")="NO" D ^DIR G SETCQ:'Y
 ;
 ;delete the case recall
 F I=11:1:13 S $P(^PRCA(430,BILL,15),U,I)=""
 F I=2:1:5 S $P(^PRCA(430,BILL,15),U,I)=""
 W !!,"Recall from Cross-Servicing has been deleted for this case."
 G SETCQ
 ;
SETCQ Q
 ;
