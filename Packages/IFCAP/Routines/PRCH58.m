PRCH58  ;WISC/CLH-1358 FUNCTIONS UTILITY ;9/10/92  8:44 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
BAL(Y) ;return 1358 balances
 ;input internal obligation number
 S Y=$S($G(Y)="":-1,1:$G(^PRC(442,Y,8)))
 Q Y
BALUP(PODA,BAL1) ;update amount of total authorizations
 N DIE,DR,DA,X,NBAL,ABAL
 S NBAL=$P($G(^PRC(442,PODA,8)),U,3),NBAL=NBAL+BAL1
 S DIE="^PRC(442,",DR="96////^S X=NBAL",DA=PODA D ^DIE
 Q
BALOB(PODA,AMT) ;obligation balance
 N DIE,DR,DA,X
 S DIE="^PRC(442,",DR="94////^S X=AMT",DA=PODA D ^DIE
 Q
 ;
BALAU(PODA,AMT) N DIE,DR,DA,X
 S DIE="^PRC(442,",DR="96////^S X=AMT",DA=PODA D ^DIE
 Q
 ;
BUL(PODA) ;set bulletin node in 442
 S $P(^PRC(442,PODA,8),U,6)=1
 Q
 ;
BULC(PODA) ;clear bulletin node in 442
 S $P(^PRC(442,PODA,8),U,6)=0
 Q
 ;
DATE() ;date time conversion
 N %,X,Y
 D NOW^%DTC
 S Y=% D DD^%DT
 Q Y
 ;
