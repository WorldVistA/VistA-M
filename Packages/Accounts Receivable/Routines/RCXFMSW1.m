RCXFMSW1 ;WISC/RFJ-fms writeoff (wr) code sheet generator for a transaction ;1 Feb 2000
 ;;4.5;Accounts Receivable;**168,172,204**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
REGENWR ;  regenerate write off document (menu option)
 N FMSDOC,PRINAMT,RCTRANDA,TRANTYPE,Y
 F  D  Q:'RCTRANDA
 .   W ! S RCTRANDA=$$SELTRAN^RCDPTPLM I RCTRANDA<1 S RCTRANDA=0 Q
 .   L +^PRCA(433,RCTRANDA):5 I '$T W !,"Another user is working with this transaction.  Try again later." Q
 .   S TRANTYPE=$P($G(^PRCA(433,RCTRANDA,1)),"^",2)
 .   I TRANTYPE'=8,TRANTYPE'=9,TRANTYPE'=10,TRANTYPE'=11,TRANTYPE'=29 L -^PRCA(433,RCTRANDA) W !,"You can only send a WRITE OFF document for transactions that write off a bill." Q
 .   ;  check to see if transaction was processed
 .   I $P($G(^PRCA(433,RCTRANDA,0)),"^",4)'=2 L -^PRCA(433,RCTRANDA) W !,"This transaction was NOT processed." Q
 .   D SHOWTRAN(RCTRANDA)
 .   I $$ACCK^PRCAACC(+$P($G(^PRCA(433,RCTRANDA,0)),"^",2)) L -^PRCA(433,RCTRANDA) W !,"ACCRUED bills do not get sent in detail to FMS." Q
 .   ;  get fms document and status
 .   S FMSDOC=$$FMSSTAT(RCTRANDA)
 .   W !,"Previously sent in WR FMS document: ",$S($P(FMSDOC,"^")="":"NOT FOUND",1:$P(FMSDOC,"^")),"    Status: ",$E($P(FMSDOC,"^",2),1,16)
 .   I $P(FMSDOC,"^",2)["ACCEPT"!($P(FMSDOC,"^",2)["TRANSMIT") L -^PRCA(433,RCTRANDA) W !,"The FMS document has been ",$P(FMSDOC,"^",2)," and cannot be regenerated." Q
 .   S PRINAMT=$P($G(^PRCA(433,RCTRANDA,8)),"^")
 .   I PRINAMT'>0 L -^PRCA(433,RCTRANDA) W !,"The principal amount needs to be greater than ZERO." Q
 .   S Y=$$ASKOK I Y'=1 L -^PRCA(433,RCTRANDA) S:Y<0 RCTRANDA=0 Q
 .   S Y=$$BUILDWR(RCTRANDA)
 .   L -^PRCA(433,RCTRANDA)
 .   I Y W !,"WR Document regenerated and retransmitted to FMS." Q
 .   W !,"Unable to regenerate document.  ",$P(Y,"^",2)
 Q
 ;
 ;
BUILDWR(RCTRANDA) ;  this entry point is called to generate a wr document to fms for a single transaction
 N CATEGORY,CR2,DA347,DIQ2,DOCTOTAL,FMSDOCNO,FMSLINE,GECSDATA,RCBILLDA,TRANNUMB,REFMS
 S RCBILLDA=$P($G(^PRCA(433,RCTRANDA,0)),"^",2)
 I 'RCBILLDA Q "0^Bill Number missing on transaction."
 ;
 S DOCTOTAL=$P($G(^PRCA(433,RCTRANDA,8)),"^")
 I 'DOCTOTAL Q "0^Total Principal Amount is ZERO."
 ;
 ;  find a previously sent document
 S FMSDOCNO=$P($G(^PRCA(433,RCTRANDA,1)),"^",12) I FMSDOCNO'="" S DA347=$O(^RC(347,"C",FMSDOCNO,0))
 I FMSDOCNO="" D
 .   S DA347=$O(^RC(347,"D","T"_RCTRANDA,0)) I 'DA347 Q
 .   S FMSDOCNO=$P($G(^RC(347,DA347,0)),"^",9)
 ;  if previously sent, get the data from gcs
 I FMSDOCNO'="" S REFMS=1 D DATA^GECSSGET(FMSDOCNO,0) I $G(GECSDATA) S TRANNUMB=$E($P(FMSDOCNO,"-",2),1,11)
 ;
 I $G(TRANNUMB)="" S TRANNUMB=$$ENUM^RCMSNUM
 I TRANNUMB<0 Q "0^Unable to lookup next transaction number."
 ;  remove dash (example 460-K1A05HY)
 S TRANNUMB=$TR(TRANNUMB,"-")
 ;
 S FMSLINE="LIN^~CRA^001"
 S $P(FMSLINE,"^",20)=$J(DOCTOTAL,0,2)
 S $P(FMSLINE,"^",21)="I"
 S $P(FMSLINE,"^",23)=$P($$DTYPE^PRCAFBD1($P($G(^PRCA(430,RCBILLDA,11)),"^",10)),"^",4) ;refund/reimbursement
 S $P(FMSLINE,"^",24)="BD"
 S $P(FMSLINE,"^",25)=$TR($P(^PRCA(430,RCBILLDA,0),"^"),"-")  ;bill number with no dash
 S $P(FMSLINE,"^",26)=$$LINE^RCXFMSC1(RCBILLDA)_"^~"
 ;
 ;  tricare bill
 S CATEGORY=$P($G(^PRCA(430,RCBILLDA,0)),"^",2)
 I CATEGORY=30!(CATEGORY=32) S $P(FMSLINE,"^",23)="06"
 ;
 N FMSDT S FMSDT=$$FMSDATE^RCBEUTRA(DT)
 S CR2="CR2^"_$E(FMSDT,2,3)_"^"_$E(FMSDT,4,5)_"^"_$E(FMSDT,6,7)
 S $P(CR2,"^",10)="E"
 S $P(CR2,"^",13)=999999999999
 S $P(CR2,"^",15)=$J(DOCTOTAL,0,2)
 S $P(CR2,"^",17)=$E(DT,2,3)
 S $P(CR2,"^",18)=$E(DT,4,5)
 S $P(CR2,"^",19)=$E(DT,6,7)_"^~"
 ;
 ;  put together document in fms
 N %DT,D,D0,DA,DI,DIC,DIE,DQ,DR,GECSFMS,X
 I '$G(GECSDATA) D CONTROL^GECSUFMS("A",$E(TRANNUMB,1,3),TRANNUMB,"WR",10,0,"","WRITE OFF")
 E  D REBUILD^GECSUFM1(+GECSDATA,"A",10,"N","Rebuild WRITE OFF") S GECSFMS("DA")=+GECSDATA
 D SETCS^GECSSTAA(GECSFMS("DA"),CR2)
 D SETCS^GECSSTAA(GECSFMS("DA"),FMSLINE)
 D SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 ;
 ;  store the gcs number in 433 for future reference
 S $P(^PRCA(433,RCTRANDA,1),"^",12)="WR-"_$P(GECSFMS("CTL"),"^",9)
 ;
 ;  add/update entry in file 347 for reports
 N %DT,X,D,D0,DI,DQ,DIC,ERROR
 I 'DA347 D OPEN^RCFMDRV1("WR-"_$P(GECSFMS("CTL"),"^",9),1,"T"_RCTRANDA,.DA347,.ERROR,RCBILLDA,RCTRANDA)
 I DA347 D SSTAT^RCFMFN02("T"_RCTRANDA,1)
 ;
 Q "1^WR-"_$P(GECSFMS("CTL"),"^",9)
 ;
 ;
FMSSTAT(RCTRANDA) ;  return the fms wr document ^ status ^ file 347 ien
 N DA347,FMSDOCNO,STATUS
 ;  get the fms document from the transaction
 S FMSDOCNO=$P($G(^PRCA(433,RCTRANDA,1)),"^",12)
 ;  if fms document found, get the file 347 entry
 I FMSDOCNO'="" S DA347=$O(^RC(347,"C",FMSDOCNO,0))
 ;  if not on transaction, it may be earlier than patch 146
 I FMSDOCNO="" D
 .   S DA347=$O(^RC(347,"D","T"_RCTRANDA,0)) I 'DA347 Q
 .   S FMSDOCNO=$P($G(^RC(347,DA347,0)),"^",9)
 ;  get the status
 S STATUS="NOT FOUND"
 I FMSDOCNO'="" S STATUS=$$STATUS^GECSSGET(FMSDOCNO)
 Q FMSDOCNO_"^"_STATUS_"^"_$G(DA347)
 ;
 ;
SHOWTRAN(RCTRANDA) ;  show data for transaction
 N DATA0,DATA1,DATA8,RCWRLINE,Y
 S DATA0=$G(^PRCA(433,RCTRANDA,0))
 S DATA1=$G(^PRCA(433,RCTRANDA,1))
 S DATA8=$G(^PRCA(433,RCTRANDA,8))
 S RCWRLINE="",$P(RCWRLINE,"=",79)=""
 W !!,RCWRLINE
 W !,"TRANSACTION NUMBER: ",RCTRANDA
 W ?40,"WAIVED AMOUNT: ",$J($P(DATA1,"^",5),0,2)
 W !,"BILL NUMBER: ",$P($G(^PRCA(430,+$P(DATA0,"^",2),0)),"^")
 S Y=$P($P(DATA1,"^"),".") I Y D DD^%DT
 W ?42,"WAIVED DATE: ",Y
 W !?8,"Principal Waived: ",$J($P(DATA8,"^"),9,2)
 W !?8," Interest Waived: ",$J($P(DATA8,"^",2),9,2)
 W !?8,"    Admin Waived: ",$J($P(DATA8,"^",3)+$P(DATA8,"^",4)+$P(DATA8,"^",5),9,2)
 W !?26,"---------"
 W !?8,"    TOTAL Waived: ",$J($P(DATA8,"^")+$P(DATA8,"^",2)+$P(DATA8,"^",3)+$P(DATA8,"^",4)+$P(DATA8,"^",5),9,2)
 W !!,RCWRLINE
 Q
 ;
 ;
ASKOK() ;  ask to regenerate write off document
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="Are you sure you want to regenerate the write off document to FMS"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
