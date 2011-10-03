RCBECHGU ;WISC/RFJ-process the charges to bill (called by rcbechgs)  ;1 Jun 00
 ;;4.5;Accounts Receivable;**153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ADDCHARG ;  this is called by rcbechgs and is a continuation of that routine
 ;  variables passed to this entry point:
 ;    rcupdate = the fm date that charges are being added
 ;    rcdata0  = debtor file entry 0th node
 ;
 N COMMENT,DR,RCBILLDA,RCDATA,RCDATE,RCLINE,RCTRANDA,RCTRDATE,VALUE,X
 ;
 ;  for first party charges, the 433 transaction date must be 3 days
 ;  prior to the statement date so the charges will appear on the
 ;  patient statement (statement date is the variable rcupdate)
 S RCTRDATE=RCUPDATE
 I $P(RCDATA0,"^")["DPT(" S RCTRDATE=$$FMADD^XLFDT(RCUPDATE,-3)
 ;
 S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("RCBECHGS",$J,"ADDCHG",RCBILLDA)) Q:'RCBILLDA  D
 .   S RCDATA=^TMP("RCBECHGS",$J,"ADDCHG",RCBILLDA)
 .   ;  pass the value = interest ^ admin ^ penalty
 .   S VALUE=+$P(RCDATA,"^",1)_"^"_$P(RCDATA,"^",2)_"^"_$P(RCDATA,"^",3)
 .   ;  no value for interest or admin
 .   I '$P(VALUE,"^"),'$P(VALUE,"^",2),'$P(VALUE,"^",3) Q
 .   ;  pass the comments, admin comment (p4) and penalty comment (p5)
 .   S COMMENT="",RCLINE=1
 .   I $P(RCDATA,"^",4)'="" S COMMENT(RCLINE)="Admin   Reason: "_$P(RCDATA,"^",4),RCLINE=2
 .   I $P(RCDATA,"^",5)'="" S COMMENT(RCLINE)="Penalty Reason: "_$P(RCDATA,"^",5)
 .   ;  lock the bill, this lock cannot fail
 .   L +^PRCA(430,RCBILLDA)
 .   ;
 .   ;  add the int/admin transaction
 .   S RCTRANDA=$$INTADM^RCBEUTR1(RCBILLDA,VALUE,.COMMENT,RCTRDATE)
 .   I 'RCTRANDA L -^PRCA(430,RCBILLDA) Q
 .   ;
 .   ;  set key fields in file 430
 .   S DR=""
 .   ;  interest last updated
 .   I $P(RCDATA,"^",1) S DR=DR_".11////"_RCUPDATE_";"
 .   ;  admin last updated
 .   I $P(RCDATA,"^",2) S DR=DR_".12////"_RCUPDATE_";"
 .   ;  penalty last updated
 .   I $P(RCDATA,"^",3) S DR=DR_".13////"_RCUPDATE_";"
 .   S X=$$EDIT430^RCBEUBIL(RCBILLDA,DR)
 .   ;
 .   ;  set date admin applied to account in file 340
 .   S DR=".12////"_RCUPDATE_";"
 .   S X=$$EDIT340^RCBEUDEB(+$P(^PRCA(430,RCBILLDA,0),"^",9),DR)
 .   ;  clear the lock on the bill
 .   L -^PRCA(430,RCBILLDA)
 .   ;
 .   ;  set tmp for mailman message, sort by date prepared
 .   S RCDATE=+$P(^PRCA(430,RCBILLDA,0),"^",10)
 .   S ^TMP("RCBECHGS REPORT",$J,RCDATE,RCBILLDA)=$P(RCDATA,"^")_"^"_$P(RCDATA,"^",2)_"^"_$P(RCDATA,"^",3)_"^"_RCTRANDA
 Q
 ;
 ;
REPORT ;  build report in mailman
 N MMDATA,RCBILLDA,RCDATA,RCDATE,RCLINE,RCSPACE,RCTOTAL,RCUPDATE,X,XMDUN,XMY
 K ^TMP($J,"RCRJRCORMM")
 S RCSPACE=$J("",79)
 S RCTOTAL=""
 S RCLINE=2
 S RCDATE="" F  S RCDATE=$O(^TMP("RCBECHGS REPORT",$J,RCDATE)) Q:RCDATE=""  D
 .   S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("RCBECHGS REPORT",$J,RCDATE,RCBILLDA)) Q:'RCBILLDA  D
 .   .   S RCDATA=^TMP("RCBECHGS REPORT",$J,RCDATE,RCBILLDA)
 .   .   ;  bill number
 .   .   S MMDATA=$E($P($P($G(^PRCA(430,RCBILLDA,0)),"^"),"-",2)_RCSPACE,1,10)
 .   .   ;  date bill prepared
 .   .   S MMDATA=MMDATA_$E($$FORMATDT^RCBECHGA(RCDATE)_RCSPACE,1,10)
 .   .   ;  transaction with charges added
 .   .   S MMDATA=MMDATA_$E($P(RCDATA,"^",4)_RCSPACE,1,10)
 .   .   ;  date of update (transaction date)
 .   .   S RCUPDATE=$P($G(^PRCA(433,+$P(RCDATA,"^",4),1)),"^")
 .   .   S MMDATA=MMDATA_$E($$FORMATDT^RCBECHGA(RCUPDATE)_RCSPACE,1,10)
 .   .   ;  justify dollar amount 10 places with 2 decimal places,
 .   .   ;  if no interest, admin, penalty, then set to null
 .   .   ;  total dollars for end of report
 .   .   F X=1:1:3 D
 .   .   .   S $P(RCTOTAL,"^",X)=$P(RCTOTAL,"^",X)+$P(RCDATA,"^",X)
 .   .   .   S $P(RCDATA,"^",X)=$S('$P(RCDATA,"^",X):$J("",12),1:$J($P(RCDATA,"^",X),12,2))
 .   .   ;  interest charge
 .   .   S MMDATA=MMDATA_$P(RCDATA,"^",1)
 .   .   ;  admin charge
 .   .   S MMDATA=MMDATA_$P(RCDATA,"^",2)
 .   .   ;  penalty charge
 .   .   S MMDATA=MMDATA_$P(RCDATA,"^",3)
 .   .   S RCLINE=RCLINE+1
 .   .   S ^TMP($J,"RCRJRCORMM",RCLINE,0)=MMDATA
 ;
 I RCLINE=2 S ^TMP($J,"RCRJRCORMM",1,0)="No interest, administrative, or penalty charges added on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 ;  if charges added, build header
 I RCLINE'=2 D
 .   S ^TMP($J,"RCRJRCORMM",1,0)="BILL      DATEPREP  433TRANS  TRANDATE  "_$J("INTEREST",12)_$J("ADMIN",12)_$J("PENALTY",12)
 .   S ^TMP($J,"RCRJRCORMM",2,0)="------    --------  --------  --------  "_$J("--------",12)_$J("-----",12)_$J("-------",12)
 .   ;  build totals
 .   S RCLINE=RCLINE+1
 .   S ^TMP($J,"RCRJRCORMM",RCLINE,0)=$E(RCSPACE,1,42)_"----------  ----------  ----------"
 .   S RCLINE=RCLINE+1
 .   S ^TMP($J,"RCRJRCORMM",RCLINE,0)=$E(RCSPACE,1,30)_"TOTALS    "_$J($P(RCTOTAL,"^"),12,2)_$J($P(RCTOTAL,"^",2),12,2)_$J($P(RCTOTAL,"^",3),12,2)
 ;
 ;  send report
 S XMY("G.PRCA ADJUSTMENT TRANS")=""
 S X=$$SENDMSG^RCRJRCOR("AR Nightly Interest/Admin/Penalty Charges Added",.XMY)
 K ^TMP($J,"RCRJRCORMM")
 Q
