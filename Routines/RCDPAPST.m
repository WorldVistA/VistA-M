RCDPAPST ;WISC/RFJ-account profile bill status select ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,168**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SELSTAT ;  select a status called from listmanager
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will allow you to specify which bill statuses to display."
 D GETSTAT(RCDEBTDA)
 ;
 D INIT^RCDPAPLM
 Q
 ;
 ;
GETSTAT(RCDEBTDA) ;  select the list of statuses of bills to display for an account
 ;  if rcdebtda passed, it will show selectable statuses for this account
 N %,DIR,DIRUT,RCRJFLAG,RCSTAT,RCSTATSL,STATDA,STATLIST,X,Y
 ;
 ;  get the status list for the user
 D STATDEF
 ;
 ;  build list of possible statuses for AR package (show statuses used)
 S STATLIST=""
 S STATDA=0  F  S STATDA=$O(^PRCA(430,"ASDT",STATDA)) Q:'STATDA  D
 .   S RCSTAT(STATDA)=$P($G(^PRCA(430.3,STATDA,0)),"^")
 .   S STATLIST=STATLIST_STATDA_":"_$E(RCSTAT(STATDA),1,20)_";"
 S STATLIST=STATLIST_"*:ALL statuses;-:NO statuses;"
 ;
 F  D  Q:$G(RCRJFLAG)
 .   D SHOWSTAT(RCDEBTDA)
 .   S DIR(0)="SOA^"_STATLIST,DIR("A")="Select STATUS of bills to display: "
 .   D ^DIR
 .   I $D(DIRUT) S RCRJFLAG=1 Q
 .   I Y="*" S %=0 F  S %=$O(RCSTAT(%)) Q:'%  S RCSTATSL(%)=1
 .   I Y="-" K RCSTATSL Q
 .   S Y=+Y
 .   I $D(RCSTAT(Y)) D
 .   .   I $D(RCSTATSL(Y)) K RCSTATSL(Y) W "  un-selected" Q
 .   .   S RCSTATSL(Y)=1 W "  selected"
 ;
 ;  save as default for user
 S STATLIST=""
 S STATDA=0 F  S STATDA=$O(RCSTATSL(STATDA)) Q:'STATDA  S STATLIST=STATLIST_STATDA_"^"
 S ^DISV(DUZ,"RCDPAPLM","STATUS")=STATLIST
 Q
 ;
 ;
STATDEF ;  get list of statuses for the user
 ;  returns RCSTATSL(statda)
 N %,STATDA
 ;  build default selected statuses
 K RCSTATSL
 F %=1:1 S STATDA=$P($G(^DISV(DUZ,"RCDPAPLM","STATUS")),"^",%) Q:'STATDA  S RCSTATSL(STATDA)=1
 Q
 ;
 ;
DEFAULT ;  set the default statuses
 W !
 W !,"When using this option, you have the option to select bills to display by"
 W !,"status.  You can select a list of statuses of the bills to display.  After"
 W !,"you select the list of statuses, the option will retain the list of selected"
 W !,"statuses for the next time you enter this option.  Since you currently do"
 W !,"not have any statuses selected for your list, the default statuses of"
 W !,"active, open, pending calm, and refund review will be automatically"
 W !,"selected for your list now."
 ;  active(16), open(42), pending calm(21), refund review(44)
 S ^DISV(DUZ,"RCDPAPLM","STATUS")="16^42^21^44"
 Q
 ;
 ;
SHOWSTAT(RCDEBTDA) ;  show list of statuses
 N OFFSET,STARS,STATDA
 W !!?3,"The following is a list of available statuses for bills:"
 W !?3,"--------------------------------------------------------"
 S OFFSET=0
 S STATDA=0 F  S STATDA=$O(RCSTAT(STATDA)) Q:'STATDA  D
 .   I OFFSET=0 W !
 .   W ?(OFFSET)
 .   ;  does account have bills under status, if yes show stars
 .   S STARS="  "
 .   I $G(RCDEBTDA),$D(^PRCA(430,"AS",RCDEBTDA,STATDA)) S STARS="**"
 .   W STARS," ",$E(STATDA_" ",1,2)," ",$E(RCSTAT(STATDA)_"                ",1,16)
 .   ;  user has status selected
 .   I $G(RCSTATSL(STATDA)) W "  selected"
 .   S OFFSET=OFFSET+44
 .   I OFFSET>44 S OFFSET=0
 W !,"** indicates account has bills under status **",!
 Q
 ;
 ;
GETBILLS(RCDEBTDA) ;  bills for account
 ;  returns a list of bills in ^tmp("rcdpapst",$j,actdate,status,bill)
 N BILLDA,DATE,STATDA
 K ^TMP("RCDPAPST",$J)
 ;
 S STATDA=0 F  S STATDA=$O(^PRCA(430,"AS",RCDEBTDA,STATDA)) Q:'STATDA  D
 .   S BILLDA=0 F  S BILLDA=$O(^PRCA(430,"AS",RCDEBTDA,STATDA,BILLDA)) Q:'BILLDA  D
 .   .   S DATE=$P($G(^PRCA(430,BILLDA,6)),"^",21) I 'DATE Q
 .   .   S ^TMP("RCDPAPST",$J,$P(DATE,"."),STATDA,BILLDA)=$$BILLBAL(BILLDA,0)
 Q
 ;
 ;
BILLBAL(BILLDA,EXTERNAL) ;  return a bills current balance principal ^ interest ^ admin
 ;  set the external flag if data is being reported to an external system
 ;  like fms, ndb, ig, etc.
 N ADMIN,CATEG,DATA7,INTEREST,PRINCPAL,STATDA
 S DATA7=$G(^PRCA(430,BILLDA,7))
 S PRINCPAL=$P(DATA7,"^")
 S INTEREST=$P(DATA7,"^",2)
 S ADMIN=$P(DATA7,"^",3)+$P(DATA7,"^",4)+$P(DATA7,"^",5)
 ;
 S CATEG=$P(^PRCA(430,BILLDA,0),"^",2),STATDA=$P(^(0),"^",8)
 ;
 ;  special case for prepayments (26)
 I CATEG=26 D
 .   S PRINCPAL=-PRINCPAL,(INTEREST,ADMIN)=0
 .   ;  bill status not open, active, or in refund review
 .   I STATDA'=42,STATDA'=16,STATDA'=44 S PRINCPAL=0
 ;
 ;  if the bill's status is write-off, balance and int = 0
 I STATDA=23 S (PRINCPAL,INTEREST,ADMIN)=0
 ;  if the bill's status is suspended, balance and int = 0
 ;  this would be for collecting payments only, external systems
 ;  still would get the bills balance
 I STATDA=40,'$G(EXTERNAL) S (PRINCPAL,INTEREST,ADMIN)=0
 ;
 Q PRINCPAL_"^"_INTEREST_"^"_ADMIN
