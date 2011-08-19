RCBMILL3 ;WISC/RFJ-millennium bill report (summary) ; 27 Jun 2001 11:10 AM
 ;;4.5;Accounts Receivable;**170**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SUMMARY ;  print summary
 N DATA,DATA1,RCBILLDA,RCTOTALM,RCTRANDA,TYPE
 ;
 U IO D H
 ;
 ;  intialize totals for month
 S RCTOTALM("TO MCCF")=0
 S RCTOTALM("TO HSIF")=0
 S RCTOTALM("PAID TO HSIF")=0
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
 .   .   ;  only print payments for the selected month
 .   .   I $E($P(DATA1,"^",9),1,5)'=$E(RCDATBEG,1,5) Q
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
 .   .   S RCTOTALM("TO MCCF")=RCTOTALM("TO MCCF")-$P(DATA,"^",3)
 .   .   S RCTOTALM("TO HSIF")=RCTOTALM("TO HSIF")-$P(DATA,"^",4)
 .   .   S RCTOTALM("PAID TO HSIF")=RCTOTALM("PAID TO HSIF")+$P(DATA,"^",6)
 ;
 D TOTALS^RCBMILL2
 ;
 ;  lookup data in generic code sheets (pass key and 1 for code sheet)
 N GECSDATA,RCLINE
 D KEYLOOK^GECSSGET("TR-"_RCDATBEG,1)
 ;
 W !!,"TRANSFER DOCUMENT DATA:"
 W !,"-----------------------"
 I '$G(GECSDATA) W !?5,"Transfer (TR) Document NOT Created for ",RCMOYR
 I $G(GECSDATA) D
 .   W !,"Generic Code Sheet Id: ",$G(GECSDATA(2100.1,GECSDATA,.01,"E"))
 .   W !,"          Description: ",$G(GECSDATA(2100.1,GECSDATA,4,"E"))
 .   W !,"    Date/Time Created: ",$G(GECSDATA(2100.1,GECSDATA,2,"E"))
 .   W !,"               Status: ",$G(GECSDATA(2100.1,GECSDATA,3,"E"))
 .   ;
 .   ;  page break
 .   I $Y>(IOSL-5),$O(GECSDATA(2100.1,GECSDATA,10,0)) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 .   W !?6,"Actual Document: "
 .   F RCLINE=1:1 Q:'$D(GECSDATA(2100.1,GECSDATA,10,RCLINE))!($G(RCRJFLAG))  D
 .   .   W !,GECSDATA(2100.1,GECSDATA,10,RCLINE)
 .   .   I $Y>(IOSL-5),$O(GECSDATA(2100.1,GECSDATA,10,RCLINE)) D:RCSCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H W !?5,"              Actual Document: <continued>"
 Q
 ;
 ;
H ;  print heading
 S %=RCNOW_"  PAGE "_RCPAGE,RCPAGE=RCPAGE+1 I RCPAGE'=2!(RCSCREEN) W @IOF
 W $C(13),"PAYMENTS SPLIT TO HSIF/MCCF SUMMARY REPORT",?(79-$L(%)),%
 ;
 W !,"  FOR THE MONTH/YEAR: ",RCMOYR
 W !!,"* * *                  S U M M A R Y   P A G E                            * * *"
 W !,"-------------------------------------------------------------------------------"
 Q
