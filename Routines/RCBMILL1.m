RCBMILL1 ;WISC/RFJ-millennium bill report (payment detail) ; 27 Jun 2001 11:10 AM
 ;;4.5;Accounts Receivable;**170**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PRINT ;  print report
 N DATA,DATA1,HSIFBAL,RCBILLDA,RCTOTALM,RCTRANDA,TYPE
 ;
 U IO D H
 ;
 ;  intialize totals for month
 S RCTOTALM("TO MCCF")=0
 S RCTOTALM("TO HSIF")=0
 S RCTOTALM("PAID TO HSIF")=0
 ;
 ;  loop the bills with payments
 S RCBILLDA=0 F  S RCBILLDA=$O(^TMP($J,"RCBMILLDATA",RCBILLDA)) Q:'RCBILLDA!($G(RCRJFLAG))  D
 .   ;
 .   ;  loop the transactions
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)) Q:'RCTRANDA!($G(RCRJFLAG))  D
 .   .   ;  data = type of transaction
 .   .   ;         principal amt of transaction
 .   .   ;         amount owed to mccf
 .   .   ;         amount owed to hsif
 .   .   ;         for payment, amount paid to mccf
 .   .   ;         for payment, amount paid to hsif
 .   .   S DATA=^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)
 .   .   ;
 .   .   ;  get the type of transaction
 .   .   S DATA1=$G(^PRCA(433,RCTRANDA,1))
 .   .   S TYPE=$P(DATA1,"^",2)
 .   .   S TYPE=$S(TYPE=1:"Increase",TYPE=35:"Decrease",TYPE=2:"Pay Part",TYPE=34:"Pay Full",1:"Unknown")
 .   .   ;
 .   .   S HSIFBAL=0
 .   .   ;
 .   .   ;  write data
 .   .   I $E(TYPE)="P" D
 .   .   .   ;  only print payments for the selected month
 .   .   .   I $E($P(DATA1,"^",9),1,5)'=$E(RCDATBEG,1,5) Q
 .   .   .   ;
 .   .   .   ;  page break
 .   .   .   I $Y>(IOSL-3) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 .   .   .   ;
 .   .   .   W !,$P($P(^PRCA(430,RCBILLDA,0),"^"),"-",2)
 .   .   .   W ?10,RCTRANDA
 .   .   .   W ?20,TYPE
 .   .   .   W ?30,"|"
 .   .   .   W $J($P(DATA,"^",2),10,2)
 .   .   .   W "  |"
 .   .   .   W $J($P(DATA,"^",3),10,2)
 .   .   .   I $P(DATA,"^",4) W $J($P(DATA,"^",4),10,2)
 .   .   .   W ?64,"  |"
 .   .   .   ;
 .   .   .   ;  show if balance owed to hsif
 .   .   .   ;  get the amount owed to hsif based on what has been paid
 .   .   .   S HSIFBAL=$P(DATA,"^",4)+$P(DATA,"^",6)
 .   .   .   I HSIFBAL W $J(-HSIFBAL,10,2)
 .   .   .   I 'HSIFBAL,$P(DATA,"^",6) W $J("paid",10)
 .   .   .   ;
 .   .   .   W ?78,"|"
 .   .   .   ;
 .   .   .   ;  compute totals paid for selected report month
 .   .   .   ;  payment dollars are recorded in data as minus
 .   .   .   S RCTOTALM("TO MCCF")=RCTOTALM("TO MCCF")-$P(DATA,"^",3)
 .   .   .   S RCTOTALM("TO HSIF")=RCTOTALM("TO HSIF")-$P(DATA,"^",4)
 .   .   .   S RCTOTALM("PAID TO HSIF")=RCTOTALM("PAID TO HSIF")+$P(DATA,"^",6)
 ;
 I $G(RCRJFLAG) Q
 ;
 ;  page break
 I $Y>(IOSL-9) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 ;
 ;  show totals for the month
 D TOTALS^RCBMILL2
 Q
 ;
 ;
H ;  print heading
 S %=RCNOW_"  PAGE "_RCPAGE,RCPAGE=RCPAGE+1 I RCPAGE'=2!(RCSCREEN) W @IOF
 W $C(13),"PAYMENTS SPLIT TO HSIF/MCCF REPORT",?(79-$L(%)),%
 ;
 W !,"  FOR THE MONTH/YEAR: ",RCMOYR
 W ?30,"+------------+----------------------+-----------+"
 ;
 W !?30,"|"
 W $J("PRINCIP",10)
 W "  |"
 W $J("FUND SPLIT",18)
 W "    |"
 W $J("TRANSFER",10)
 W ?78,"|"
 ;
 W !,"BILL #"
 W ?10,"TRAN #"
 W ?20,"TYPE"
 W ?30,"|"
 W $J("AMOUNT",10)
 W "  |"
 W $J("TO MCCF",10)
 W $J("TO HSIF",10)
 W "  |"
 W $J("TO HSIF",10)
 W ?78,"|"
 ;
 W !,"------------------------------+------------+----------------------+-----------+"
 Q
