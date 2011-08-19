RCEXINAD ;ALB/MAF - Exempt int/admin for Katrina victims from 9/1/05 - patch install;3 Oct 05
 ;;4.5;Accounts Receivable;**237,241**;Mar 20, 1995
 ;;
 ;
START ;
 N ADMIN,BILLDA,DATE,INTEREST,PRINBAL,TRANDA,TRANTYPE,VALUE,RCNOHSIF,RCDFN,DATEEND,RCDEB,X
 ;  needs datebeg, dateend
 ;  total is total by category
 ;
 ;
 S RCNOHSIF=$$NOHSIF^RCRJRCO() ; no HSIF (disabled)
 ;
 K ^TMP("RCINTADM",$J)
 F TRANTYPE=13 D
 .   S DATE=3050901-1,DATEEND=9999999
 .   F  S DATE=$O(^PRCA(433,"AT",TRANTYPE,DATE)) Q:'DATE!(DATE>DATEEND)  D
 .   .   S TRANDA=0
 .   .   F  S TRANDA=$O(^PRCA(433,"AT",TRANTYPE,DATE,TRANDA)) Q:'TRANDA  D
 .   .   .   S BILLDA=+$P($G(^PRCA(433,TRANDA,0)),"^",2) I 'BILLDA Q
 .   .   .   ;  bill not linked to a site
 .   .   .   I '$P($G(^PRCA(430,BILLDA,0)),"^",12) Q
 .   .   .   S RCDEB=$P($G(^PRCA(430,BILLDA,0)),"^",9) Q:'+RCDEB  D  Q:'+RCDFN
 .   .   .   .   S RCDFN=0
 .   .   .   .   Q:$P($G(^RCD(340,+RCDEB,0)),"^",1)'["DPT"
 .   .   .   .   S RCDFN=+$P($G(^RCD(340,+RCDEB,0)),"^",1)
 .   .   .   .   Q
 .   .   .   ;Check if emergency response victim
 .   .   .   I $$EMERES^PRCAUTL(+RCDFN)']"" Q
 .   .   .   Q:$P($G(^RCD(340,+RCDEB,0)),"^",8)  ; already exempted
 .   .   .   S ^TMP("RCINTADM",$J,RCDFN,BILLDA)=""
 .   .   .   Q
 I '$D(^TMP("RCINTADM",$J)) Q
 N BILLDA,RCDFN,PAYDAT
 S (RCDFN,BILLDA)=0,PAYDAT=3050901
 F  S RCDFN=$O(^TMP("RCINTADM",$J,RCDFN)) Q:RCDFN']""  F  S BILLDA=$O(^TMP("RCINTADM",$J,RCDFN,BILLDA)) Q:BILLDA']""  D EXEMPT(BILLDA,PAYDAT)
 Q
 ;
 ;
EXEMPT(RCBILLDA,RCPAYDAT) ;  exempt interest/admin/penalty charges
 ;  added after the payment date
 N ADMIN,BILLBAL,COMMENT,INTEREST,PENALTY,RCDATE,RCEXTRAN,RCFLAG,RCLIST,RCTRANDA,TRANDA,DATE,RCEND,RCEXEM
 ;
 S BILLBAL=$$GETTRANS^RCDPBTLM(RCBILLDA)
 ;  no interest or admin to exempt
 I ($P(BILLBAL,"^",2)+$P(BILLBAL,"^",3))=0 Q
 ;  loop thru transactions after payment date and look for
 ;  interest/admin charge transactions to exempt
 S RCDATE=RCPAYDAT-.1
 ;set an end date so that no transactions beyond the emergency response end date are exempted
 S X=$P($G(^RC(342,1,30)),"^",2)
 S RCEND=$S('X:DT,DT<X:DT,1:X)
 F  S RCDATE=$O(RCLIST(RCDATE)) Q:'RCDATE!(RCDATE>RCEND)  D
 .   S RCTRANDA=0
 .   F  S RCTRANDA=$O(RCLIST(RCDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   I RCLIST(RCDATE,RCTRANDA)'["INTEREST/ADM. CHARGE" Q
 .   .   ;  interest/admin/penalty charge added after payment date
 .   .   ;  exempt the charge
 .   .   ;
 .   .   ;  check to see if charge is already exempted
 .   .   ;  the charge would be on the same date
 .   .   ;  for example:
 .   .   ;    rclist(3000424,2742117)=INTEREST/ADM. CHARGE^^ .68^ .45^0^0
 .   .   ;    rclist(3000424,2750151)=EXEMPT INT/ADM. COST^^-.68^-.45^0^0
 .   .   S RCFLAG=0
 .   .   S TRANDA=RCTRANDA,DATE=RCDATE-.1
 .   .   F  S DATE=$O(RCLIST(DATE)) Q:'DATE!(RCFLAG)  F  S TRANDA=$O(RCLIST(DATE,TRANDA)) Q:'TRANDA!(RCFLAG)  D  I RCFLAG Q
 .   .   .   I RCLIST(DATE,TRANDA)'["EXEMPT INT/ADM. COST" Q
 .   .   .   ;skip exemption if it has already been matched with another interest charge
 .   .   .   Q:$D(RCEXEM(TRANDA))
 .   .   .   ;  compare interest values (p3) and admin (p4)
 .   .   .   I +$P(RCLIST(RCDATE,RCTRANDA),"^",3)'=-$P(RCLIST(DATE,TRANDA),"^",3) Q
 .   .   .   I +$P(RCLIST(RCDATE,RCTRANDA),"^",4)'=-$P(RCLIST(DATE,TRANDA),"^",4) Q
 .   .   .   ;  transaction already exempted; save transaction as one already matched
 .   .   .   S RCFLAG=1,RCEXEM(TRANDA)=""
 .   .   I $G(RCFLAG) Q
 .   .   ;
 .   .   S INTEREST=$P(RCLIST(RCDATE,RCTRANDA),"^",3)
 .   .   S ADMIN=$P(RCLIST(RCDATE,RCTRANDA),"^",4)
 .   .   I 'INTEREST,'ADMIN Q
 .   .   ;
 .   .   ;  check to make sure the amount being exempted does not
 .   .   ;  exceed the balance of the bill
 .   .   I INTEREST>$P(BILLBAL,"^",2) Q
 .   .   I ADMIN>$P(BILLBAL,"^",3) Q
 .   .   ;
 .   .   ;  get the penalty charge from the transaction.  this charge is computed in the
 .   .   ;  admin value, so subtract it from admin
 .   .   S PENALTY=$P($G(^PRCA(433,RCTRANDA,2)),"^",9)
 .   .   I PENALTY S ADMIN=ADMIN-PENALTY S:ADMIN<0 ADMIN=0
 .   .   ;
 .   .   ;  add the exempt transaction to file 433 with the date
 .   .   ;  equal to the date the int/admin charge created
 .   .   S COMMENT(1)="Auto exemption of "_RCTRANDA_", charges applied "_$S(RCDATE=RCPAYDAT:"on ",1:"after ")_$$FORMATDT^RCBECHGA(RCPAYDAT)_" for Hurricane Katrina victims."
 .   .   ;  make sure the time is entered for date processed in file 433 1;9
 .   .   ;  if not, it will show as being out of balance on patient statement
 .   .   ;  this was added for patch 162.
 .   .   ;
 .   .   ;  patch 165 removed the process date passed so the current date
 .   .   ;  and time would be used.  this will prevent statements from
 .   .   ;  being out of balance.
 .   .   ;N %,%H,%I,PROCDATE
 .   .   ;D NOW^%DTC S PROCDATE=$P(RCDATE,".")_"."_$P(%,".",2)
 .   .   S RCEXTRAN=$$EXEMPT^RCBEUTR2(RCBILLDA,INTEREST_"^"_ADMIN_"^"_PENALTY,.COMMENT,0)
 Q
