PRCAI169 ;WISC/RFJ-post init patch 169 ; 26 Jan 01
 ;;4.5;Accounts Receivable;**169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START ;  start post init
 ;
 D BMES^XPDUTL(" >>  Queuing the Post-Initialization routine ...")
 ;
 N ZTIO,ZTDTH,ZTRTN,ZTSK
 S ZTIO="",ZTDTH=$H,ZTRTN="DQ^PRCAI169"
 D ^%ZTLOAD
 ;
 D MES^XPDUTL("     in task "_ZTSK_".")
 ;
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("  IMPORTANT  IMPORTANT  IMPORTANT  IMPORTANT  IMPORTANT  IMPORTANT")
 D MES^XPDUTL("  *********************************************************************")
 D MES^XPDUTL("    When the Queued Post-Initialization finishes running, a mail")
 D MES^XPDUTL("    message will be delivered to the mail groups IRM and PRCA")
 D MES^XPDUTL("    ADJUSTMENT TRANS with the subject: AR Patch 169 Installation")
 D MES^XPDUTL("    Completed.  You should receive this message within 24 hours.")
 D MES^XPDUTL("    If you do not receive the message, you will need to restart")
 D MES^XPDUTL("    the Post-Initialization by running the routine START^PRCAI169.")
 D MES^XPDUTL("  *********************************************************************")
 D MES^XPDUTL("  IMPORTANT  IMPORTANT  IMPORTANT  IMPORTANT  IMPORTANT  IMPORTANT")
 Q
 ;
 ;
DQ ;  queue post initialization
 ;
 ;  add the post install entry for history
 N RCMSPOST
 S RCMSPOST=$$START^RCMSPOST("PRCA*4.5*169")
 ;
 ;  1. ***** disable type of payment IRS PAYMENT by
 ;  removing the category field entry .06
 N %,D,D0,DA,DI,DIC,DIE,DQ,DR,X
 S DA=$O(^RC(341.1,"B","IRS PAYMENT",0))
 I DA S (DIC,DIE)="^RC(341.1,",DR=".06///@;" D ^DIE
 ;
 ;
 ;  2. ***** delete IRS mail group
 ;  reference to XMB allowed in integration agreement 3359
 N %,DA,DIC,DIK,RCMIRSDA,RCDA,X,Y
 S RCMIRSDA=+$O(^XMB(3.8,"B","IRS",0))
 I RCMIRSDA D
 .   ;  check to see if IRS mail group is a member of another
 .   ;  mail group.  If so, delete it from the other mail group.
 .   S RCDA(1)=0 F  S RCDA(1)=$O(^XMB(3.8,"AD",RCMIRSDA,RCDA(1))) Q:'RCDA(1)  D
 .   .   S RCDA=0 F  S RCDA=$O(^XMB(3.8,"AD",RCMIRSDA,RCDA(1),RCDA)) Q:'RCDA  D
 .   .   .   S DA(1)=RCDA(1),DA=RCDA,DIK="^XMB(3.8,"_RCDA(1)_",5,"
 .   .   .   D ^DIK
 .   ;
 .   ;  delete the mail group
 .   S DA=RCMIRSDA,DIK="^XMB(3.8,"
 .   D ^DIK
 ;
 ;
 ;  3. ***** fix ineligible bills, convert transaction type 24 to 02
 N RCBILLDA,RCDATE
 S RCDATE=3001000
 F  S RCDATE=$O(^PRCA(430,"ACTDT",RCDATE)) Q:'RCDATE  D
 .   S RCBILLDA=0 F  S RCBILLDA=$O(^PRCA(430,"ACTDT",RCDATE,RCBILLDA)) Q:'RCBILLDA  D
 .   .   ;  if not an ineligible bill, quit
 .   .   I $P($G(^PRCA(430,RCBILLDA,0)),"^",2)'=1 Q
 .   .   ;  if the tranasaction type already equals 02, quit
 .   .   I $P($G(^PRCA(430,RCBILLDA,11)),"^",10)=02 Q
 .   .   S $P(^PRCA(430,RCBILLDA,11),"^",10)="02"
 ;
 ;
 ;  4. ***** fix exemptions where the transaction is not split between
 ;           interest and admin
 D START^PRCAI16A
 ;
 ;
 ;  5. ***** fix exemption date problem
 ;  build a list of accounts out of balance at the site
 N ACCTDATA,DATA,OUTOFBAL,RCDATE,RCDEBTDA,RCEXDATA,RCEXDATE,RCLINE,RCNEXT,RCPADATA,RCTOTAL1,RCTOTAL2,RCTRANDA,X,Y
 K ^TMP("PRCAI169",$J)
 ;
 ;  build list of accounts out of balance
 S RCDEBTDA=0
 F  S RCDEBTDA=$O(^RCD(340,"AB","DPT(",RCDEBTDA)) Q:'RCDEBTDA  D
 .   S OUTOFBAL=$$EN^PRCAMRKC(RCDEBTDA)
 .   I OUTOFBAL S ^TMP("PRCAI169",$J,RCDEBTDA)=""
 ;
 ;  loop all transactions for debtor and look at the exempt charge.
 ;  if the exempt transaction date is not equal to the payment
 ;  transaction date, change the exempt charge date.
 S RCDEBTDA=0
 F  S RCDEBTDA=$O(^TMP("PRCAI169",$J,RCDEBTDA)) Q:'RCDEBTDA  D
 .   ;  get the last statement date
 .   S RCDATE=$P(+$$LST^RCFN01(RCDEBTDA,2),".")
 .   ;
 .   ;  loop all transactions up to the last statement date + 1 day
 .   S RCEXDATE=0
 .   F  S RCEXDATE=$O(^PRCA(433,"ATD",RCDEBTDA,RCEXDATE)) Q:'RCEXDATE!(RCEXDATE>(RCDATE+1))  D
 .   .   S RCTRANDA=0
 .   .   F  S RCTRANDA=$O(^PRCA(433,"ATD",RCDEBTDA,RCEXDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   .   ;  type of transaction is not an exemption
 .   .   .   S RCEXDATA=$G(^PRCA(433,RCTRANDA,1))
 .   .   .   I $P(RCEXDATA,"^",2)'=14 Q
 .   .   .   ;
 .   .   .   ;  get the next transaction for the bill
 .   .   .   S RCNEXT=$O(^PRCA(433,"C",+$P($G(^PRCA(433,+RCTRANDA,0)),"^",2),RCTRANDA))
 .   .   .   ;  is it a payment?, if no, quit
 .   .   .   S RCPADATA=$G(^PRCA(433,+RCNEXT,1))
 .   .   .   I $P(RCPADATA,"^",2)'=2,$P(RCPADATA,"^",2)'=34 Q
 .   .   .   ;
 .   .   .   ;  check to see if this is an automatic exemption,
 .   .   .   ;  if not, then do not change the date
 .   .   .   I $G(^PRCA(433,RCTRANDA,7,1,0))'["Auto" Q
 .   .   .   ;
 .   .   .   ;  it is a payment, if the date of the payment is greater
 .   .   .   ;  than the date of the exemption by more than 1 minute,
 .   .   .   ;  change the exemption date to be equal to the payment date
 .   .   .   I ($P(RCPADATA,"^",9)-$P(RCEXDATA,"^",9))>.0001 S X=$$EDIT433^RCBEUTRA(RCTRANDA,"19////"_$P(RCPADATA,"^",9)_";")
 ;
 ;  recheck the accounts out of balance
 S RCTOTAL1=0  ;used to count accts out of balance prior to install
 S RCTOTAL2=0  ;used to count accts fixed by the patch
 S RCDEBTDA=0
 F  S RCDEBTDA=$O(^TMP("PRCAI169",$J,RCDEBTDA)) Q:'RCDEBTDA  D
 .   ;  check to see if account has a bill in refund review.
 .   ;  if it does, remove it from the list.
 .   I $$REFUREVW^RCBEREFU(RCDEBTDA) K ^TMP("PRCAI169",$J,RCDEBTDA) Q
 .   ;  original count of accounts out of balance before patch install
 .   S RCTOTAL1=RCTOTAL1+1
 .   ;  check to see if account is out of balance.  if it is
 .   ;  not out of balance, remove it from the list.
 .   S OUTOFBAL=$$EN^PRCAMRKC(RCDEBTDA)
 .   I 'OUTOFBAL S RCTOTAL2=RCTOTAL2+1 K ^TMP("PRCAI169",$J,RCDEBTDA)
 ;
 ;  build mailman message showing patch installed and accounts still
 ;  out of balance
 K ^TMP($J,"RCRJRCORMM")
 S ^TMP($J,"RCRJRCORMM",1)="The Post-Initialization routine for patch PRCA*4.5*169 is completed."
 S ^TMP($J,"RCRJRCORMM",2)="Patch PRCA*4.5*169 has been completely installed."
 S ^TMP($J,"RCRJRCORMM",3)=" "
 S ^TMP($J,"RCRJRCORMM",4)="The following accounts are still out of balance after the patch install."
 S ^TMP($J,"RCRJRCORMM",5)="This list excludes accounts with bills in refund review."
 S ^TMP($J,"RCRJRCORMM",6)=" "
 S RCLINE=6
 S RCDEBTDA=0
 F  S RCDEBTDA=$O(^TMP("PRCAI169",$J,RCDEBTDA)) Q:'RCDEBTDA  D
 .   S ACCTDATA=$$ACCNTHDR^RCDPAPLM(RCDEBTDA)
 .   S DATA=$E($P(ACCTDATA,"^")_"                              ",1,30)_"  "
 .   S DATA=DATA_$E($P(ACCTDATA,"^",2)_"            ",1,12)_"  "
 .   S DATA=DATA_$P(ACCTDATA,"^",3)
 .   S RCLINE=RCLINE+1,^TMP($J,"RCRJRCORMM",RCLINE)=DATA
 ;
 S RCLINE=RCLINE+1,^TMP($J,"RCRJRCORMM",RCLINE)=" "
 S RCLINE=RCLINE+1,^TMP($J,"RCRJRCORMM",RCLINE)="  TOTAL ACCOUNTS OUT OF BALANCE BEFORE PATCH INSTALL: "_$J(RCTOTAL1,8)
 S RCLINE=RCLINE+1,^TMP($J,"RCRJRCORMM",RCLINE)="                       TOTAL ACCOUNTS FIXED BY PATCH: "_$J(RCTOTAL2,8)
 S RCLINE=RCLINE+1,^TMP($J,"RCRJRCORMM",RCLINE)="                                                      "_$J("--------",8)
 S RCLINE=RCLINE+1,^TMP($J,"RCRJRCORMM",RCLINE)="  TOTAL ACCOUNTS OUT OF BALANCE AFTER  PATCH INSTALL: "_$J((RCTOTAL1-RCTOTAL2),8)
 ;
 ;  send mail message
 ;  difrom needs to be newed or mailman will not deliver the message
 N DIFROM,XMDUN,XMY,XMZ
 S XMY("G.IRM")=""
 S XMY("G.PRCA ADJUSTMENT TRANS")=""
 S XMY(.5)=""
 S XMY(DUZ)=""
 S XMZ=$$SENDMSG^RCRJRCOR("AR Patch 169 Installation Completed",.XMY)
 K ^TMP($J,"RCRJRCORMM")
 ;
 K ^TMP("PRCAI169",$J)
 ;
 ;  set the end date for the post initialization
 D END^RCMSPOST(RCMSPOST)
 Q
