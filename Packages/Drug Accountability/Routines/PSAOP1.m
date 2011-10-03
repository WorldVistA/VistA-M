PSAOP1 ;BIR/LTL-Outpatient Dispensing (Single Drug) & (All Drugs) ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**64**; 10/24/97;Build 4
 ;PSAOP,PSAOP1,PSAOP2, & PSAOP4 gathers Outpatient dispensing data.
 ;PSAOP3 calls this routine to stuff Outpatient dispensing data in
 ;#58.81 and update 58.8 balance. It is called by PSAOP, PSAOP2,
 ;PSAOP3, & PSAOP4.
 ;
 N DIC,PSAD,PSAT,PSAB,X
 ;Get transaction number
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSAD=$P(^PSD(58.81,0),U,3)+1 I $D(^PSD(58.81,PSAD)) S $P(^PSD(58.81,0),U,3)=$P(^PSD(58.81,0),U,3)+1 G FIND
 S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSAD D ^DIC
 L -^PSD(58.81,0) K DLAYGO,DINUM
 ;Get date + current balance + update balance
 F  L +^PSD(58.8,+PSALOC,1,+PSADRUG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 S PSAB=$P($G(^PSD(58.8,+PSALOC,1,+PSADRUG,0)),U,4)
 S $P(^PSD(58.8,+PSALOC,1,+PSADRUG,0),U,4)=$P($G(^(0)),U,4)-PSA(3)
EDO S:'$D(^PSD(58.8,+PSALOC,1,+PSADRUG,5,0)) ^(0)="^58.801A^^"
 ;If no monthly activity data yet,
 I '$D(^PSD(58.8,+PSALOC,1,+PSADRUG,5,+$E(PSA(2),1,5)*100,0)) D
 .;Set up current month's node with beginning balance.
 .S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DIC(0)="L",DIC("DR")="1////"_$G(PSAB),(X,DINUM)=$E(PSA(2),1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC K DIC,DINUM,DLAYGO
 .;Set up last month's node with ending balance.
 .S X="T-1M" D ^%DT S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DIC(0)="L",(X,DINUM)=$E(Y,1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC K DIC,DINUM,DLAYGO S DA=+Y
 .S DIE="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DA(2)=PSALOC,DA(1)=PSADRUG
 .S DR="3////"_$G(PSAB) D ^DIE K DIE
 ;Stuff the Total Dispensed with itself+new dispensing data.
 S DIE="^PSD(58.8,"_+PSALOC_",1,"_+PSADRUG_",5,",DR="9////^S X=$P($G(^(0)),U,6)+PSA(3)",DA=$E(PSA(2),1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG D ^DIE K DA
 L -^PSD(58.8,+PSALOC,1,+PSADRUG,0)
 ;Update transaction
 S DIE="^PSD(58.81,",DR="1////6;2////^S X=PSALOC;3///^S X=PSA(2);4////^S X=PSADRUG;5////^S X=PSA(3);9////^S X=$G(PSAB)",DA=PSAD
 D ^DIE K DIE,DA,DR
 ;Update Activity
 S:'$D(^PSD(58.8,+PSALOC,1,+PSADRUG,4,0)) ^(0)="^58.800119PA^^"
 S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,4,",DIC(0)="L",(X,DINUM)=PSAD
 S DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC K DIC,DA,DINUM,DLAYGO
END Q
TMP ;TMP("PSA",$J)
 N DIC,PSAD,PSAT,PSAB,X
 ;Get transaction number
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND1 S PSAD=$P(^PSD(58.81,0),U,3)+1 I $D(^PSD(58.81,PSAD)) S $P(^PSD(58.81,0),U,3)=$P(^PSD(58.81,0),U,3)+1 G FIND1
 S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSAD D ^DIC
 L -^PSD(58.81,0) K DLAYGO,DINUM
 ;Get date + current balance + update balance
 F  L +^PSD(58.8,+PSALOC,1,+PSADRUG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 S PSAB=$P($G(^PSD(58.8,+PSALOC,1,+PSADRUG,0)),U,4)
 S $P(^PSD(58.8,+PSALOC,1,+PSADRUG,0),U,4)=$P($G(^(0)),U,4)-PSA(3)
 S:'$D(^PSD(58.8,+PSALOC,1,+PSADRUG,5,0)) ^(0)="^58.801A^^"
 ;;If no monthly activity data yet,
 I '$D(^PSD(58.8,+PSALOC,1,+PSADRUG,5,+$E(PSA(2),1,5)*100,0)) D
 .;Set up current month's node with beginning balance.
 .S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DIC(0)="L",DIC("DR")="1////"_$G(PSAB),(X,DINUM)=$E(PSA(2),1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC K DIC,DINUM,DLAYGO
 .;Set up last month's node with ending balance.
 .S X="T-1M" D ^%DT S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DIC(0)="L",(X,DINUM)=$E(Y,1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC K DIC,DINUM,DLAYGO S DA=+Y
 .S DIE="^PSD(58.8,"_+PSALOC_",1,"_+PSADRUG_",5,",DA(2)=PSALOC,DA(1)=PSADRUG
 .S DR="3////"_$G(PSAB) D ^DIE K DIE
 ;Stuff the Total Dispensed with itself+new dispensing data.
 S DIE="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DR="9////^S X=$P($G(^(0)),U,6)+PSA(3)",DA=$E(PSA(2),1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG D ^DIE K DA
 L -^PSD(58.8,+PSALOC,1,+PSADRUG,0)
 ;Update transaction
 S DIE="^PSD(58.81,",DR="1////6;2////^S X=PSALOC;3///^S X=PSA(2);4////^S X=PSADRUG;5////^S X=PSA(3);9////^S X=$G(PSAB)",DA=PSAD
 D ^DIE K DIE,DA,DR
 ;Update Activity
 S:'$D(^PSD(58.8,+PSALOC,1,+PSADRUG,4,0)) ^(0)="^58.800119PA^^"
 S DIC="^PSD(58.8,"_+PSALOC_",1,"_+PSADRUG_",4,",DIC(0)="L",(X,DINUM)=PSAD
 S DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC K DA,DIC,DINUM,DLAYGO
 K ^TMP("PSA",$J,PSADRUG)
 Q
