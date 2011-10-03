RCBEUTRA ;WISC/RFJ-utilties for transactions (in file 433)           ;1 Jun 00
 ;;4.5;Accounts Receivable;**153,169,204**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ADD433(BILLDA,TRANTYPE) ;  add a new transaction to file 433 (silent)
 ;  return: ien of 433 transaction or 0^error msg
 ;        : ^prca(433,ien) will be locked if entry selected
 N %I,DA,DATA0,DD,DIC,DICR,DIE,DINUM,DIW,DLAYGO,DO,I,RCTRANDA,REFCODE,X,Y
 ;
 ;  find next available transaction number
 ;  add an extra level of locks, some operating systems do not process
 ;  the locks correctly if they happen at the same time.
 L +^PRCA(433,"ADDNEWENTRY")
 ;  start with last entry in file
 ;    -> if no data is in the entry, lock it
 ;       -> if the lock works and no data was added (prior to the lock)
 ;          -> then you have the entry.
 ;          -> otherwise, unlock it and start over
 F DINUM=$P(^PRCA(433,0),"^",3)+1:1 I '$D(^PRCA(433,DINUM)) L +^PRCA(433,DINUM):1 Q:$T&('$D(^PRCA(433,DINUM)))  L -^PRCA(433,DINUM)
 L -^PRCA(433,"ADDNEWENTRY")
 ;
 ;  add entry to file
 S RCTRANDA=DINUM,(DIC,DIE)="^PRCA(433,",DIC(0)="L",DLAYGO=433,X=DINUM
 ;  build DR string, 42=processed by (use postmaster if queued)
 S DIC("DR")="42////"_$S($D(ZTQUEUED):.5,1:DUZ)_";"
 S DIC("DR")=DIC("DR")_".03////"_BILLDA_";"  ;bill ien
 S DIC("DR")=DIC("DR")_"12////"_TRANTYPE_";" ;transaction type
 S DATA0=$G(^PRCA(430,BILLDA,0))
 ;  appropriation symbol
 I $P(DATA0,"^",18)'="" S DIC("DR")=DIC("DR")_"8////"_$P(DATA0,"^",18)_";"
 ;  segment
 I $P(DATA0,"^",21)'="" S DIC("DR")=DIC("DR")_"6////"_$P(DATA0,"^",21)_";"
 ;  test for referral code
 S REFCODE=$P($G(^PRCA(430,BILLDA,6)),"^",5)
 I REFCODE'="" S REFCODE=$S(REFCODE="DC":"RC",1:REFCODE),DIC("DR")=DIC("DR")_"7////"_REFCODE_";"
 ;  file it
 D FILE^DICN
 I Y=-1 L -^PRCA(433,RCTRANDA) Q "0^UNABLE TO ADD A NEW ENTRY TO FILE 433"
 Q RCTRANDA
 ;
 ;
FY433(RCTRANDA) ;  transfer fiscal year multiple from 430 to 433
 ;  bill number must be stored in file 433, field .03 before calling
 N BILLDA,FY,FYDATA
 S BILLDA=+$P($G(^PRCA(433,RCTRANDA,0)),"^",2) I 'BILLDA Q
 K ^PRCA(433,RCTRANDA,4)
 S FY=0 F  S FY=$O(^PRCA(430,BILLDA,2,FY)) Q:'FY  D
 .   S FYDATA=$G(^PRCA(430,BILLDA,2,FY,0)) I $P(FYDATA,"^")="" Q
 .   S ^PRCA(433,RCTRANDA,4,FY,0)=$P(FYDATA,"^",1,3)_"^1"
 .   S ^PRCA(433,RCTRANDA,4,"B",$P(FYDATA,"^"),FY)=""
 ;
 S ^PRCA(433,RCTRANDA,4,0)="^433.01I^"_$P($G(^PRCA(430,BILLDA,2,0)),"^",3,4)
 Q
 ;
 ;
FYMULT(RCTRANDA) ;  apply payment to fy multiple, oldest first
 N AMOUNT,FYDA,FYAMOUNT
 ;  transfer fy multiple if not there
 I '$D(^PRCA(433,RCTRANDA,4)) D FY433(RCTRANDA)
 ;  amount is principal amount
 S AMOUNT=$P($$TRANVALU^RCDPBTLM(RCTRANDA),"^",2) I 'AMOUNT Q
 ;
 ;  the transaction value is minus, decrease principal
 I AMOUNT<0 D  Q
 .   S AMOUNT=-AMOUNT
 .   S FYDA=0 F  S FYDA=$O(^PRCA(433,RCTRANDA,4,FYDA)) Q:'FYDA  D  I 'AMOUNT Q
 .   .   S FYAMOUNT=$P($G(^PRCA(433,RCTRANDA,4,FYDA,0)),"^",2)
 .   .   ;  fy amount is greater than transaction amount
 .   .   I FYAMOUNT>AMOUNT D  Q
 .   .   .   S $P(^PRCA(433,RCTRANDA,4,FYDA,0),"^",2)=FYAMOUNT-AMOUNT
 .   .   .   S $P(^PRCA(433,RCTRANDA,4,FYDA,0),"^",5)=AMOUNT
 .   .   .   S AMOUNT=0
 .   .   ;  fy amount not greater than total amount
 .   .   S $P(^PRCA(433,RCTRANDA,4,FYDA,0),"^",2)=0
 .   .   S $P(^PRCA(433,RCTRANDA,4,FYDA,0),"^",5)=FYAMOUNT
 .   .   S AMOUNT=AMOUNT-FYAMOUNT
 .   ;  move back to 430
 .   D FYMULT^RCBEUBIL(RCTRANDA)
 ;
 ;  the transaction value is plus, increase principal
 S FYDA=$O(^PRCA(433,RCTRANDA,4,999),-1) I 'FYDA Q
 S $P(^PRCA(433,RCTRANDA,4,FYDA,0),"^",2)=$P(^PRCA(433,RCTRANDA,4,FYDA,0),"^",2)+AMOUNT
 S $P(^PRCA(433,RCTRANDA,4,FYDA,0),"^",5)=AMOUNT
 ;  move back to 430
 D FYMULT^RCBEUBIL(RCTRANDA)
 Q
 ;
 ;
EDIT433(RCTRANDA,DR) ;  edit the field in 433 with the DR string passed
 I '$D(^PRCA(433,RCTRANDA)) Q
 N %,D,D0,D1,DA,DDH,DI,DIC,DIE,DQ,J,X,Y
 S (DIC,DIE)="^PRCA(433,",DA=RCTRANDA
 D ^DIE
 ;  user pressed up-arrow
 I $D(Y) Q "0^TRANSACTION NOT COMPLETELY PROCESSED"
 Q 1
 ;
 ;
PROCESS(RCTRANDA) ;  mark transaction as processed
 I '$D(^PRCA(433,RCTRANDA,0)) Q
 N D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^PRCA(433,",DA=RCTRANDA
 S DR="3////0;4////2;"
 D ^DIE
 Q
 ;
 ;
INCOMPLE(RCTRANDA) ;  opposite of processed, make a transaction incomplete
 I '$D(^PRCA(433,RCTRANDA,0)) Q
 N D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^PRCA(433,",DA=RCTRANDA
 S DR="4////1;"
 D ^DIE
 Q
 ;
 ;
DEL433(RCTRANDA,COMMENT,ARCHIVE) ;  delete (mark incomplete) in file 433
 ;  comment is the user comment in field 41 (default USER CANCELLED)
 ;  archive is set to 1 if called to archive transaction
 I '$D(^PRCA(433,RCTRANDA,0)) Q
 N %,D,D0,DA,DI,DIC,DIE,DQ,DR,J,RCBILLDA,X,Y
 ;
 S (DIC,DIE)="^PRCA(433,",DA=RCTRANDA
 ;  build DR string
 S DR=""
 S DR=DR_"4////1;"  ;transaction status incomplete
 S DR=DR_"10////1;" ;incomplete transaction flag
 S DR=DR_"11///T;"  ;transaction date
 I $G(COMMENT)="" S COMMENT="USER CANCELLED"
 S DR=DR_"41///"_COMMENT_";"
 ;  brief comment
 S RCBILLDA=$P($G(^PRCA(433,RCTRANDA,0)),"^",2)
 S DR=DR_"5.02////SYSTEM "_$S($G(ARCHIVE):"ARCHIVED",1:"INACTIVATED")_$S(RCBILLDA:" (BILL "_$P($G(^PRCA(430,RCBILLDA,0)),"^")_")",1:"")_";"
 D ^DIE
 ;  since the bill number (field .03) is required, it must be manually removed
 I RCBILLDA S $P(^PRCA(433,RCTRANDA,0),"^",2)="" K ^PRCA(433,"C",RCBILLDA,RCTRANDA)
 ;  remove fy multiple
 K ^PRCA(433,RCTRANDA,4)
 Q
 ;
 ;
ADDCOMM(RCTRANDA,COMMENT) ;  automatically put a comment on a transaction
 ;  comment in the array comment(1)=first line
 ;                       comment(2)=second line
 N CURRLINE,LINE
 ;  get the last line
 S CURRLINE=$O(^PRCA(433,RCTRANDA,7,99999999),-1)
 ;  if comment already on transaction, add a blank line and
 ;  date time of new comment
 I CURRLINE D
 .   S CURRLINE=CURRLINE+1,^PRCA(433,RCTRANDA,7,CURRLINE,0)=" "
 .   S CURRLINE=CURRLINE+1,^PRCA(433,RCTRANDA,7,CURRLINE,0)="Comment added on: "_$$FMTE^XLFDT($$NOW^XLFDT)
 ;  add new lines
 F LINE=1:1 Q:'$D(COMMENT(LINE))  S ^PRCA(433,RCTRANDA,7,CURRLINE+LINE,0)=COMMENT(LINE)
 ;  set the 0th node
 S ^PRCA(433,RCTRANDA,7,0)="^^"_(CURRLINE+LINE-1)_"^"_(CURRLINE+LINE-1)_"^"_DT_"^"
 Q
FMSDATE(X) ;Finds the next month & year and sets the date for transmission
 ;of the document to FMS.  If DT is after EOAM and the document has not
 ;been previously transmitted, the date will be set to the first of the
 ;next month.  If the DT is after the EOAM and the document is being 
 ;re-transmitted, the the date of transmission will be DT. The flag REGEN
 ;is set in the source code if the document is being 
 ;re-transmitted, thus will have a transmission date of DT.
 I $G(REFMS) G QUIT
 I DT>$$LDATE^RCRJR(DT) S X=$E($$FPS^RCAMFN01(X,1),1,5)_"01"
QUIT Q X
