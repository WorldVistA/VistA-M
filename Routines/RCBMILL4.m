RCBMILL4 ;WISC/RFJ-millennium bill report (print history for date range) ; 27 Jun 2001 11:10 AM
 ;;4.5;Accounts Receivable;**170**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PRINT ;  print history for date range
 N DATA,DATA1,GECSDATA,RCAMOUNT,RCBILLDA,RCDATE,RCLINE,RCTOTAL,RCTRANDA,TYPE,Y
 ;
 ;  intialize totals for month
 K ^TMP("RCBMILL4",$J)
 ;
 ;  loop the bills with payments
 S RCBILLDA=0 F  S RCBILLDA=$O(^TMP($J,"RCBMILLDATA",RCBILLDA)) Q:'RCBILLDA  D
 .   ;
 .   ;  loop the transactions
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)) Q:'RCTRANDA  D
 .   .   ;
 .   .   ;  get the type of transaction
 .   .   S DATA1=$G(^PRCA(433,RCTRANDA,1))
 .   .   S TYPE=$P(DATA1,"^",2)
 .   .   ;
 .   .   ;  only print payments for the selected date range
 .   .   I $P(DATA1,"^",9)<RCDATBEG!($P(DATA1,"^",9)>RCDATEND) Q
 .   .   ;
 .   .   ;  if not a payment, quit
 .   .   I TYPE'=2,TYPE'=34 Q
 .   .   ;  data = principal amt of transaction
 .   .   ;         amount owed to mccf
 .   .   ;         amount owed to hsif
 .   .   ;         for payment, amount paid to mccf
 .   .   ;         for payment, amount paid to hsif
 .   .   S DATA=^TMP($J,"RCBMILLDATA",RCBILLDA,RCTRANDA)
 .   .   ;
 .   .   ;  compute totals paid for selected report month
 .   .   ;  payment dollars are recorded in data as minus
 .   .   S ^TMP("RCBMILL4",$J,$E($P(DATA1,"^",9),1,5),"TO MCCF")=$G(^TMP("RCBMILL4",$J,$E($P(DATA1,"^",9),1,5),"TO MCCF"))-$P(DATA,"^",3)
 .   .   S ^TMP("RCBMILL4",$J,$E($P(DATA1,"^",9),1,5),"TO HSIF")=$G(^TMP("RCBMILL4",$J,$E($P(DATA1,"^",9),1,5),"TO HSIF"))-$P(DATA,"^",4)
 .   .   S ^TMP("RCBMILL4",$J,$E($P(DATA1,"^",9),1,5),"PAID TO HSIF")=$G(^TMP("RCBMILL4",$J,$E($P(DATA1,"^",9),1,5),"PAID TO HSIF"))+$P(DATA,"^",6)
 ;
 U IO D H
 ;
 S RCDATE="" F  S RCDATE=$O(^TMP("RCBMILL4",$J,RCDATE)) Q:'RCDATE!($G(RCRJFLAG))  D
 .   ;  page break
 .   I $Y>(IOSL-4) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 .   ;
 .   S Y=$E(RCDATE,1,5)_"00" D DD^%DT
 .   ;  write month/year and split amount paid to mccf
 .   W !,Y,?10,"  |",$J($G(^TMP("RCBMILL4",$J,RCDATE,"TO MCCF")),12,2),"  |"
 .   ;  write split amount paid to hsif
 .   W $J($G(^TMP("RCBMILL4",$J,RCDATE,"TO HSIF")),12,2)
 .   ;  write amount paid to hsif
 .   W $J($G(^TMP("RCBMILL4",$J,RCDATE,"PAID TO HSIF")),12,2)
 .   ;  write amount owed to hsif
 .   W $J($G(^TMP("RCBMILL4",$J,RCDATE,"TO HSIF"))-$G(^TMP("RCBMILL4",$J,RCDATE,"PAID TO HSIF")),12,2),"  |"
 .   ;
 .   ;  get the code sheet data
 .   K GECSDATA
 .   D KEYLOOK^GECSSGET("TR-"_$E(RCDATE,1,5)_"00",1)
 .   ;
 .   S RCAMOUNT=0
 .   I $G(GECSDATA) D
 .   .   S RCLINE=0 F  S RCLINE=$O(GECSDATA(2100.1,GECSDATA,10,RCLINE)) Q:'RCLINE  D
 .   .   .   S DATA=GECSDATA(2100.1,GECSDATA,10,RCLINE)
 .   .   .   I $P(DATA,"^")'="LIN" Q
 .   .   .   I $P(DATA,"^",6)'="5358.1" Q
 .   .   .   I $P(DATA,"^",21)'="I" Q
 .   .   .   S RCAMOUNT=RCAMOUNT+$P(DATA,"^",20)
 .   ;
 .   W $J(RCAMOUNT,12,2)
 .   ;
 .   ;  total all columns
 .   S RCTOTAL(1)=$G(RCTOTAL(1))+$G(^TMP("RCBMILL4",$J,RCDATE,"TO MCCF"))
 .   S RCTOTAL(2)=$G(RCTOTAL(2))+$G(^TMP("RCBMILL4",$J,RCDATE,"TO HSIF"))
 .   S RCTOTAL(3)=$G(RCTOTAL(3))+$G(^TMP("RCBMILL4",$J,RCDATE,"PAID TO HSIF"))
 .   S RCTOTAL(5)=$G(RCTOTAL(5))+RCAMOUNT
 ;
 ;  page break
 I $G(RCRJFLAG) D Q Q
 I $Y>(IOSL-5) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 ;
 ;  show totals
 W !,"==============================================================================="
 W !,"TOTALS",?10,"  |",$J($G(RCTOTAL(1)),12,2),"  |",$J($G(RCTOTAL(2)),12,2),$J($G(RCTOTAL(3)),12,2),$J($G(RCTOTAL(2))-$G(RCTOTAL(3)),12,2),"  |",$J($G(RCTOTAL(5)),12,2)
 W !,"==============================================================================="
 ;
 ;  page break
 I $G(RCRJFLAG) D Q Q
 I $Y>(IOSL-8) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 ;
 ;  show what columns mean
 W !,"Column 2 is the dollar amount of RX-Copayments that is split to MCCF."
 W !,"Column 3 is the dollar amount of RX-Copayments that is split to HSIF."
 W !,"Column 4 is the dollar amount of HSIF payments that is paid to HSIF in FMS."
 W !,"Column 5 is the dollar difference between columns 3 and 4.  This is the amount"
 W !,"         owed (needs to be transferred from MCCF) to HSIF."
 W !,"Column 6 is the dollar amount transferred from MCCF to HSIF taken from the"
 W !,"         monthly (TR)ansfer document."
 ;
Q ;  quit report
 K ^TMP("RCBMILL4",$J)
 Q
 ;
 ;
H ;  print heading
 S %=RCNOW_"  PAGE "_RCPAGE,RCPAGE=RCPAGE+1 I RCPAGE'=2!(RCSCREEN) W @IOF
 W $C(13),"PAYMENTS SPLIT TO HSIF/MCCF HISTORY REPORT",?(79-$L(%)),%
 ;
 W !,"  FROM MONTH/YEAR: ",RCMOYR,"  TO MONTH/YEAR: ",RCMOYRTO
 W !,?10,"  |",$J("PAYMENTS",12),"  |",$J("PAYMENTS",12),$J("PAID TO",12),$J("OWED TO",12),"  |",$J("DOCUMENT",12)
 W !,"MONTH/YEAR",?10,"  |",$J("TO MCCF",12),"  |",$J("TO HSIF",12),$J("HSIF",12),$J("HSIF",12),"  |",$J("AMT TO HSIF",12)
 W !,"-------------------------------------------------------------------------------"
 Q
