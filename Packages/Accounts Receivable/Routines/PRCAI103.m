PRCAI103 ;WISC/RFJ-post init patch 103 ;1 Mar 97
 ;;4.5;Accounts Receivable;**103**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START ;  start post init
 N DATA3,DATE,TRANDA
 ;  for exempt int/adm charge transactions (entry = 14)
 S DATE=0 F  S DATE=$O(^PRCA(433,"AT",14,DATE)) Q:'DATE  D
 .   S TRANDA=0 F  S TRANDA=$O(^PRCA(433,"AT",14,DATE,TRANDA)) Q:'TRANDA  D
 .   .   L +^PRCA(433,TRANDA)
 .   .   ;
 .   .   S DATA3=$G(^PRCA(433,TRANDA,3))
 .   .   ;  if there is interest collected (field 32),
 .   .   ;  move to interest charge (field 27)
 .   .   I $P(DATA3,"^",2) D
 .   .   .   S $P(^PRCA(433,TRANDA,2),"^",7)=$P(DATA3,"^",2)
 .   .   .   S $P(^PRCA(433,TRANDA,3),"^",2)=""
 .   .   ;  if there is admin collected (field 33),
 .   .   ;  move to admin charge (field 28)
 .   .   I $P(DATA3,"^",3) D
 .   .   .   S $P(^PRCA(433,TRANDA,2),"^",8)=$P(DATA3,"^",3)
 .   .   .   S $P(^PRCA(433,TRANDA,3),"^",3)=""
 .   .   ;
 .   .   L -^PRCA(433,TRANDA)
 ;
 ;  if the patch is installed after the 20th of the month
 ;  send the responses to the messages which will be deleted
 ;  on the first of the month (by routine RCRJR)
 I $E(DT,6,7)>20 D CLEANXMB^RCRJR
 Q
