RCBEUBIL ;WISC/RFJ-utilties for bills (in file 430) ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**153,226,276,371**;Mar 20, 1995;Build 29
 ;;Per VHA Directive 6402, this routine should not be modified.
 Q
 ;
 ;
GETABILL() ;  select an active bill
 N RCBILLDA,RCCAT,RCCATEG,STATUS
 F  D  Q:RCBILLDA
 .   W !! S RCBILLDA=$$SELBILL^RCDPBTLM
 .   I RCBILLDA=0 S RCBILLDA=-1 Q
 .   I RCBILLDA<1 Q
 .   ;  bill must be active
 .   S STATUS=$P($G(^PRCA(430,RCBILLDA,0)),"^",8)
 .   I STATUS'=16,STATUS'=42 W !,"THIS IS NOT AN ACTIVE BILL !",! S RCBILLDA=0 Q
 .   ;
 .   ;  determine if bill can be adjusted based on category
 .   K RCCAT D RCCAT^RCRCUTL(.RCCAT)  ;returns rccat(category) array
 .   S RCCATEG=+$P(^PRCA(430,RCBILLDA,0),"^",2)
 .   I +$G(RCCAT(RCCATEG))=1,$$REFST^RCRCUTL(RCBILLDA) W !!,"YOU CANNOT USE THIS OPTION TO ADJUST REFERRED "_$P($G(RCCAT(RCCATEG)),"^",2)_" BILLS !",! S RCBILLDA=0 Q
 .   ;
 .   I RCCATEG=26 W !,"YOU CANNOT ADJUST A PREPAYMENT BILL !",! S RCBILLDA=0 Q
 Q RCBILLDA
 ;
 ;
EDIT430(RCBILLDA,DR) ;  edit the fields in 430 with the DR string passed
 I '$D(^PRCA(430,RCBILLDA)) Q
 N %,D,D0,D1,DA,DDH,DI,DIC,DICR,DIE,DIG,DIH,DIU,DIV,DIW,DQ,J,X,Y
 S (DIC,DIE)="^PRCA(430,",DA=RCBILLDA
 D ^DIE
 ;  user pressed up-arrow
 I $D(Y) Q "0^BILL FIELDS NOT UPDATED"
 Q 1
 ;
 ;
CHGSTAT(RCBILLDA,STATUS) ;  change the current status
 I '$D(^PRCA(430,RCBILLDA,0)) Q
 ;  if the current status equals the new status, quit
 I $P(^PRCA(430,RCBILLDA,0),"^",8)=STATUS Q
 ;  if the status not defined in file 430.3, quit
 I '$D(^PRCA(430.3,STATUS,0)) Q
 N %,D,D0,DA,DI,DIC,DICR,DIE,DIG,DIH,DIU,DIV,DIW,DQ,DR,PREVSTAT,X,Y
 S (DIC,DIE)="^PRCA(430,",DA=RCBILLDA
 ;  build DR string
 S DR=""
 ;  get the current status and set to previous status
 S PREVSTAT=$P($G(^PRCA(430,RCBILLDA,0)),"^",8)
 ;  if previous status equal to new status, quit
 I PREVSTAT=STATUS Q
 I PREVSTAT S DR=DR_"95////"_PREVSTAT_";"
 S DR=DR_"8////"_STATUS_";"    ;current status
 S DR=DR_"17////"_$G(DUZ)_";"  ;status updated by
 D ^DIE
 Q
 ;
 ;
SETRCDOJ(RCBILLDA,RCTRANDA,RCDOJ) ;  set the bill and transaction to rc or doj
 ;  rcdoj = code RC or DOJ
 N D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^PRCA(430,",DA=RCBILLDA
 S DR="65////"_RCDOJ_";"
 D ^DIE
 ;
 S (DIC,DIE)="^PRCA(433,",DA=RCTRANDA
 S DR="7////"_RCDOJ_";"
 D ^DIE
 Q
 ;
SETBAL(RCTRANDA,RCNFLG) ;  set the bills balance by adding value of transaction
 N RCBILLDA,RCDATA7,VALUE,RCFDA
 S RCBILLDA=$P($G(^PRCA(433,RCTRANDA,0)),"^",2) I 'RCBILLDA Q
 ;  get the value of the transaction
 S VALUE=$P($$TRANVALU^RCDPBTLM(RCTRANDA),"^",2,6)
 ;  there is no value on the transaction
 I $TR(VALUE,"^0")="" Q
 ;
 S RCDATA7=$G(^PRCA(430,RCBILLDA,7))
 ; PRCA276 - next line: if adjustment causes negative balance entry in ACCOUNTS RECEIVABLE file not updated
 I $P(RCDATA7,"^",1)+$P(VALUE,"^")<0 S RCNFLG=1 Q
 ; PRCA*4.5*371 - Replace direct global sets in 7 node with FileMan calls so indexes get updated
 S RCFDA(430,RCBILLDA_",",71)=$P(RCDATA7,"^")+$P(VALUE,"^") ; principal
 S RCFDA(430,RCBILLDA_",",72)=$P(RCDATA7,"^",2)+$P(VALUE,"^",2) ; interest
 S RCFDA(430,RCBILLDA_",",73)=$P(RCDATA7,"^",3)+$P(VALUE,"^",3) ; admin
 S RCFDA(430,RCBILLDA_",",74)=$P(RCDATA7,"^",4)+$P(VALUE,"^",4) ; marshal fee
 S RCFDA(430,RCBILLDA_",",75)=$P(RCDATA7,"^",5)+$P(VALUE,"^",5) ; court cost
 D FILE^DIE(,"RCFDA")
 Q
 ;
FYMULT(RCTRANDA) ;  update the fiscal year multiple for bill
 ;  to equal the fiscal year multiple for transaction in file 433
 N RCBILLDA,FYDA
 S RCBILLDA=$P($G(^PRCA(433,RCTRANDA,0)),"^",2) I 'RCBILLDA Q
 S FYDA=0
 F  S FYDA=$O(^PRCA(433,RCTRANDA,4,FYDA)) Q:'FYDA  D
 .   I $D(^PRCA(430,RCBILLDA,2,FYDA,0)) S $P(^PRCA(430,RCBILLDA,2,FYDA,0),"^",2)=$P(^PRCA(433,RCTRANDA,4,FYDA,0),"^",2)
 Q
 ;
 ;
SHOWBILL(RCBILLDA) ;  show data for bill
 N DATA7
 S DATA7=$G(^PRCA(430,RCBILLDA,7))
 W !?8,"Principal Balance: ",$J($P(DATA7,"^"),9,2)
 W !?8," Interest Balance: ",$J($P(DATA7,"^",2),9,2)
 W !?8,"    Admin Balance: ",$J($P(DATA7,"^",3)+$P(DATA7,"^",4)+$P(DATA7,"^",5),9,2)
 W !?27,"---------"
 W !?8,"    TOTAL Balance: ",$J($P(DATA7,"^")+$P(DATA7,"^",2)+$P(DATA7,"^",3)+$P(DATA7,"^",4)+$P(DATA7,"^",5),9,2)
 Q
 ;
 ;
ADDCOMM(RCBILLDA,COMMENT) ;  automatically put a comment on a bill
 ;  comment in the array comment(1)=first line
 ;                       comment(2)=second line
 N CURRLINE,LINE
 ;  get the last line
 S CURRLINE=$O(^PRCA(430,RCBILLDA,10,99999999),-1)
 ;  if comment already on transaction, add a blank line and
 ;  date time of new comment
 I CURRLINE D
 .   S CURRLINE=CURRLINE+1,^PRCA(430,RCBILLDA,10,CURRLINE,0)=" "
 .   S CURRLINE=CURRLINE+1,^PRCA(430,RCBILLDA,10,CURRLINE,0)="Comment added on: "_$$FMTE^XLFDT($$NOW^XLFDT)
 ;  add new lines
 F LINE=1:1 Q:'$D(COMMENT(LINE))  S ^PRCA(430,RCBILLDA,10,CURRLINE+LINE,0)=COMMENT(LINE)
 ;  set the 0th node
 S ^PRCA(430,RCBILLDA,10,0)="^^"_(CURRLINE+LINE-1)_"^"_(CURRLINE+LINE-1)_"^"_DT_"^"
 Q
