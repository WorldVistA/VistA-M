PRCEAU1 ;WISC/CLH/LDB/BGJ-AUTHORIZATION EDITS ; 07/08/93  12:00 PM
V ;;5.1;IFCAP;**23**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ADJ N DIR,X,Y,ACT,DIFF,UAAMT,IN
AMT S DIR(0)="N^0.01:999999999.99:2",DIR("A")="Change AUTHORIZATION amount",DIR("B")=$P(^PRC(424,DA,0),U,12),DIR("?",1)="Enter NEW amount of the authorization or '^' to quit"
 S DIR("?",2)="I will do the calculations to update the authorization and",DIR("?",4)="obligations balances.",DIR("?",5)="  "
 D ^DIR S AMT=X G:$D(DIRUT) ZEROQ
 S ABAL=$P(^PRC(424,DA,0),U,5)
 D  G:AMT="" AMT Q
 . S DIFF=X-$P($G(^PRC(424,DA,0)),U,12)
 . I +BAL-$P(BAL,U,3)-DIFF<0 S PRCADJ=0 D  Q:PRCADJ
 .. W !,$C(7),"This amount EXCEEDS the balance remaining on this",!,"obligation by ",$FN(+BAL-($P(BAL,U,3)+DIFF),",",2),"."
 .. W !!,?20,"AVAILABLE FUNDS: ",$FN((+BAL-$P(BAL,U,3)),",",2),!!,"An increase adjustment to the obligation must be submitted." D ASK^PRCEADJ S PRCADJ=1 Q
 . I $P($G(^PRC(424,DA,0)),U,12)-ABAL>AMT W !,$C(7),"This amount will cause a negative balance on this",!,"authorization." S AMT="" Q
 . S PRCADJ=0,AAMT=DIFF D ADJ^PRCEDRE0 Q:PRCADJ
 . S BAL2=$P($G(^PRC(424,DA,0)),U,12)+DIFF,BAL1=+DIFF,ABAL=ABAL+DIFF,DR=".05////^S X=ABAL;.12////^S X=BAL2;.1;1.1",DIE="^PRC(424," D WAIT^PRCFYN,^DIE,BUPDT
 . W !!,"NEW BALANCES: " S BAL=$$BAL^PRCH58(PODA) D BALDIS W !!,?15,"Authorization Amount: $",$FN($P($G(^PRC(424,DA,0)),U,12),",P",2),!,?28,"Balance: $",$FN($P($G(^(0)),U,5),",P",2),!! H 2
 . ; if remaining authorized balance is smaller than 5% of obligated
 . ;   balance, send mail to alert user.
 . I $D(^PRC(424,DA,0)),$P(^(0),U,5)<($P(BAL,U)*.05) S IN="EDIT" D ^PRCEBL
 . Q
ZERO ;zero out authorization balance, mark authorization as complete and
 ;and return left over monies to obligation
 ;PODA MUST be defined and equal to internal obligation nuber
 K DIR S DIR(0)="Y",DIR("A",1)="This will zero out the balance on this authorization",DIR("A",2)="and mark this authorization as complete",DIR("A")="Do you want to continue" D ^DIR
 I $D(DIRUT)!('Y) S X="" G ZEROQ
 S ABAL=0,X=$G(^PRC(424,DA,0)),AAMT=-$P(X,U,5),BAL1=$P(X,U,12)+AAMT,PRCADJ=0 D ADJ^PRCEDRE0 Q:PRCADJ  D WAIT^PRCFYN
UPDT ;Called from PRCEDRE when final daily record is entered
 S DA=AUDA,DR=".05////^S X="_$S($G(ABAL):ABAL,1:0)_";.1;1.1;.12////^S X=$S($G(BAL2):BAL2,1:BAL1)",DIE="^PRC(424," S:'$G(ABAL) DR=DR_";.09////^S X=1" D ^DIE S BAL1=AAMT D BUPDT
 I '$G(ABAL) S X="Authorization balance has been reduced to ZERO, and this authorization has been marked as complete.*",X1=1 W ! D MSG^PRCFQ G ZEROQ
 W ! S X="Authorization and obligation balances update" D MSG^PRCFQ
ZEROQ K DIRUT,DIROUT,DUOUT,DTOUT Q
 ;
OPN ;Called from PRCEAU to reopen an authorization set as completed
 K DIR S DIR(0)="YO",DIR("A",1)="Reopening this authorization will allow transferral of funds from the obligation"
 S DIR("A",2)="to THIS authorization."
 S DIR("A",3)="These funds will remain available only within this authorization",DIR("A",4)="until the authorization is marked as complete."
 S DIR("A",5)="At which time the funds will be transferred back to the obligation."
 S DIR("A",6)="",DIR("A")="Are you certain that you would like to reopen this authorization",DIR("B")="NO" D ^DIR I $D(DIRUT)!'Y Q
 K DIR S ACT="I" D AMT
 G:AMT="^" ZEROQ S DIE="^PRC(424,",DA=AUDA,DR=".09////@" D ^DIE,ZEROQ Q
BUPDT ;up date balance in file 442
 D BALUP^PRCH58(PODA,BAL1)
 Q
BALDIS ;Called from PRCEAU to display balances
 S Y=$FN(+$G(BAL),",P",2) W !!,"Obligation amount: $" W $$LBF1^PRCFU(Y,14)
 S Y=$FN(+$G(BAL)-$P($G(BAL),U,2),",P",2) W ?42,"Fiscal balance: $" W $$LBF1^PRCFU(Y,14)
 S Y=$FN(+$G(BAL)-$P($G(BAL),U,3),",P",2) W !?2,"Service balance: $" W $$LBF1^PRCFU(Y,14)
 Q
