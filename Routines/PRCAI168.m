PRCAI168 ;WISC/RFJ-post init patch 168 ; 26 Jan 01
 ;;4.5;Accounts Receivable;**168**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START ;  start post init
 ;  track int, admin write offs on the write off 433 transaction
 ;
 D BMES^XPDUTL(" >>  Checking write-off transactions ...")
 ;
 N DATA7,DATA8,NEXTTRAN,P,PRIN,RCBILLDA,RCDATE,RCTRANDA,RCTRTYPE
 ;
 ;  8 = TERM.BY FIS.OFFICER
 ;  9 = TERM.BY COMPROMISE
 ; 10 = WAIVED IN FULL
 ; 11 = WAIVED IN PART
 ; 29 = TERM BY RC/DOJ
 F RCTRTYPE=8,9,10,11,29 S RCDATE=0 F  S RCDATE=$O(^PRCA(433,"AT",RCTRTYPE,RCDATE)) Q:'RCDATE  D
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^PRCA(433,"AT",RCTRTYPE,RCDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   ;  if transaction status not valid, quit
 .   .   I '$$VALID^RCRJRCOT(RCTRANDA) Q
 .   .   ;
 .   .   L +^PRCA(433,RCTRANDA)
 .   .   ;
 .   .   S DATA8=$G(^PRCA(433,RCTRANDA,8))
 .   .   S PRIN=$P(DATA8,"^") I 'PRIN S PRIN=$$TRANAMT^RCRJRCOT(RCTRANDA),$P(DATA8,"^")=PRIN
 .   .   ;
 .   .   S RCBILLDA=+$P($G(^PRCA(433,RCTRANDA,0)),"^",2) I 'RCBILLDA L -^PRCA(433,RCTRANDA) Q
 .   .   S DATA7=$P($G(^PRCA(430,RCBILLDA,7)),"^",1,5)
 .   .   ;
 .   .   ;  if the termination is not the last transaction, find the next re-establish transaction
 .   .   ;  to determine the interest and admin
 .   .   I $O(^PRCA(433,"C",RCBILLDA,RCTRANDA)) D
 .   .   .   S NEXTTRAN=RCTRANDA F  S NEXTTRAN=$O(^PRCA(433,"C",RCBILLDA,NEXTTRAN)) Q:'NEXTTRAN  I $P($G(^PRCA(433,NEXTTRAN,1)),"^",2)=43 Q
 .   .   .   I 'NEXTTRAN Q
 .   .   .   F P=2:1:5 S $P(DATA8,"^",P)=+$P($G(^PRCA(433,NEXTTRAN,8)),"^",P)
 .   .   ;
 .   .   ;  move over int, admin, mf, cc
 .   .   I '$O(^PRCA(433,"C",RCBILLDA,RCTRANDA)) F P=2:1:5 S $P(DATA8,"^",P)=+$P(DATA7,"^",P)
 .   .   ;
 .   .   F P=1:1:5 I $P(DATA8,"^",P),(+$P(DATA8,"^",P)'=+$P($G(^PRCA(433,RCTRANDA,8)),"^",P)) D
 .   .   .   S $P(^PRCA(433,RCTRANDA,8),"^",P)=+$P(DATA8,"^",P)
 .   .   ;
 .   .   L -^PRCA(433,RCTRANDA)
 ;
 D MES^XPDUTL("     OK, done.")
 Q
