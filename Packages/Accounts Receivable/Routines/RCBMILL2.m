RCBMILL2 ;WISC/RFJ-millennium bill report (transactions) ; 27 Jun 2001 11:10 AM
 ;;4.5;Accounts Receivable;**170**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PRINT ;  print report
 N DATA,DATA1,DATE,HSIFBAL,RCBILLDA,RCDPDATA,RCTOTAL,RCTOTALM,RCTRANDA,TYPE
 ;
 U IO D H
 ;
 ;  intialize totals for month
 S RCTOTALM("TO MCCF")=0
 S RCTOTALM("TO HSIF")=0
 S RCTOTALM("PAID TO HSIF")=0
 ;
 S RCBILLDA=0 F  S RCBILLDA=$O(^TMP($J,"RCBMILLDATA",RCBILLDA)) Q:'RCBILLDA!($G(RCRJFLAG))  D
 .   ;
 .   ;  page break
 .   I $Y>(IOSL-3) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 .   ;
 .   ;  write bill data
 .   D DIQ430^RCDPBPLM(RCBILLDA,".01;8;")
 .   W !,"BILL: ",$P(RCDPDATA(430,RCBILLDA,.01,"E"),"-",2)
 .   W ?15,"STATUS: ",$E(RCDPDATA(430,RCBILLDA,8,"E"),1,7)
 .   K RCDPDATA(430,RCBILLDA)
 .   W ?30,"+------------+----------------------+-----------+"
 .   ;
 .   ;  intialize totals for bill
 .   S RCTOTAL("PRINCIPAL")=0
 .   S RCTOTAL("TO MCCF")=0
 .   S RCTOTAL("TO HSIF")=0
 .   S RCTOTAL("TRANSFER TO HSIF")=0
 .   ;
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)) Q:'RCTRANDA!($G(RCRJFLAG))  D
 .   .   ;  data = type of transaction
 .   .   ;         principal amt of transaction
 .   .   ;         amount owed to mccf
 .   .   ;         amount owed to hsif
 .   .   ;         for payment, amount paid to mccf
 .   .   ;         for payment, amount paid to hsif
 .   .   S DATA=^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)
 .   .   ;
 .   .   ;  get the date and type of transaction
 .   .   S DATA1=$G(^PRCA(433,RCTRANDA,1))
 .   .   S DATE=$E($P(DATA1,"^",9),4,5)_"/"_$E($P(DATA1,"^",9),6,7)_"/"_$E($P(DATA1,"^",9),2,3)
 .   .   S TYPE=$P(DATA1,"^",2)
 .   .   S TYPE=$S(TYPE=1:"Increase",TYPE=35:"Decrease",TYPE=2:"Pay Part",TYPE=34:"Pay Full",43:"Re-estab",1:"Unknown")
 .   .   ;
 .   .   ;  page break
 .   .   I $Y>(IOSL-3) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 .   .   ;
 .   .   ;  write data
 .   .   W !,RCTRANDA
 .   .   W ?10,DATE
 .   .   W ?20,TYPE
 .   .   W ?30,"|"
 .   .   W $J($P(DATA,"^",2),10,2)
 .   .   W "  |"
 .   .   W $J($P(DATA,"^",3),10,2)
 .   .   I $P(DATA,"^",4) W $J($P(DATA,"^",4),10,2)
 .   .   W ?64,"  |"
 .   .   ;
 .   .   ;  if it is a payment transaction, show if there is a
 .   .   ;  balance owed to hsif
 .   .   S HSIFBAL=0
 .   .   I $P(DATA1,"^",2)=2!($P(DATA1,"^",2)=34) D
 .   .   .   ;  get the amount owed to hsif based on what has been paid
 .   .   .   S HSIFBAL=$P(DATA,"^",4)+$P(DATA,"^",6)
 .   .   .   I HSIFBAL W $J(-HSIFBAL,10,2)
 .   .   .   I 'HSIFBAL,$P(DATA,"^",6) W $J("paid",10)
 .   .   .   ;
 .   .   .   ;  compute totals paid for selected report month
 .   .   .   ;  payment dollars are recorded in data as minus
 .   .   .   I $E($P(DATA1,"^",9),1,5)'=$E(RCDATBEG,1,5) Q
 .   .   .   S RCTOTALM("TO MCCF")=RCTOTALM("TO MCCF")-$P(DATA,"^",3)
 .   .   .   S RCTOTALM("TO HSIF")=RCTOTALM("TO HSIF")-$P(DATA,"^",4)
 .   .   .   S RCTOTALM("PAID TO HSIF")=RCTOTALM("PAID TO HSIF")+$P(DATA,"^",6)
 .   .   ;
 .   .   W ?78,"|"
 .   .   ;
 .   .   ;  store totals by bill
 .   .   S RCTOTAL("PRINCIPAL")=RCTOTAL("PRINCIPAL")+$P(DATA,"^",2)
 .   .   S RCTOTAL("TO MCCF")=RCTOTAL("TO MCCF")+$P(DATA,"^",3)
 .   .   S RCTOTAL("TO HSIF")=RCTOTAL("TO HSIF")+$P(DATA,"^",4)
 .   .   S RCTOTAL("TRANSFER TO HSIF")=RCTOTAL("TRANSFER TO HSIF")+HSIFBAL
 .   ;
 .   ;  page break
 .   I $G(RCRJFLAG) Q
 .   I $Y>(IOSL-4) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 .   ;
 .   ;  show totals by each bill
 .   W !?30,"+------------+----------------------+-----------+"
 .   W !?20,"BALANCES"
 .   W ?31,$J(RCTOTAL("PRINCIPAL"),10,2)
 .   W "   "
 .   W $J(RCTOTAL("TO MCCF"),10,2)
 .   W $J(RCTOTAL("TO HSIF"),10,2)
 .   W "  |"
 .   W $J(-RCTOTAL("TRANSFER TO HSIF"),10,2)
 .   W ?78,"|"
 ;
 I $G(RCRJFLAG) Q
 ;
 I $O(^TMP($J,"RCBMILLDATA",0)) W !?66,"+-----------+"
 ;
 ;  page break
 I $G(RCRJFLAG) Q
 I $Y>(IOSL-9) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 ;
TOTALS ;  show monthly totals (called by the other reports)
 ;
 W !,"+=============================================================================+"
 W !,"|",?2,"TOTAL RX-COPAYMENTS FOR MONTH: ",$J(RCMOYR,10),?78,"|"
 W !,"|",?2,"           SPLIT PAID TO MCCF: ",$J(RCTOTALM("TO MCCF"),10,2),?78,"|"
 W !,"|",?2,"           SPLIT PAID TO HSIF: ",$J(RCTOTALM("TO HSIF"),10,2),?78,"|"
 W !,"|",?45,"ALREADY PAID TO HSIF: ",$J(RCTOTALM("PAID TO HSIF"),10,2),?78,"|"
 W !,"|",?45,"BALANCE OWED TO HSIF: ",$J(RCTOTALM("TO HSIF")-RCTOTALM("PAID TO HSIF"),10,2),?78,"|"
 W !,"|",?2,"                               ",$J("----------",10),?78,"|"
 W !,"|",?2," TOTAL RX-COPAYMENTS RECEIVED: ",$J(RCTOTALM("TO MCCF")+RCTOTALM("TO HSIF"),10,2),?78,"|"
 W !,"+=============================================================================+"
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
 W $J("FUND SPLIT",16)
 W "      |"
 W $J("TRANSFER",10)
 W ?78,"|"
 ;
 W !,"TRANS #"
 W ?10,"PROCDATE"
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
