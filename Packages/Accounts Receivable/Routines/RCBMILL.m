RCBMILL ;WISC/RFJ-millennium bill report (generator) ; 27 Jun 2001 11:10 AM
 ;;4.5;Accounts Receivable;**170,203**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 N %DT,DEFAULT,RCDATBEG,RCDATEND,RCREPTYP,X,Y
 ;
 ;  ask type of report to generate
 W !!,"--- Enter the Type of Report to Generate ---"
 S RCREPTYP=$$ASKTYPE
 I RCREPTYP<1 Q
 ;
 ;  ask month year
 I RCREPTYP=1!(RCREPTYP=2)!(RCREPTYP=3) D
 .   N RCOFFDT
 .   W !!,"--- Enter the Month and Year for the Report ---"
 .   S Y=$E($$PREVMONT^RCRJRBD(DT),1,5)_"00" D DD^%DT S DEFAULT=Y
 .   S RCOFFDT=3030930 ; The report cannot run for later date
 .   S %DT(0)=$S(DT>RCOFFDT:-RCOFFDT,1:-DT)
 .   S %DT("A")="Select MONTH YEAR for Report: ",%DT("B")=DEFAULT,%DT="AEMP"
 .   D ^%DT I Y<0 Q
 .   S RCDATBEG=$E(Y,1,5)_"00",RCDATEND=$E(Y,1,5)_"32"
 ;
 ;  ask date range
 I RCREPTYP=4 D MONTHSEL I '$G(RCDATEND) Q
 ;
 I '$G(RCDATEND) Q
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="AR Millennium Bill Report Generator",ZTRTN="DQ^RCBMILL"
 .   S ZTSAVE("RCREPTYP")="",ZTSAVE("RCDATBEG")="",ZTSAVE("RCDATEND")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  queued report starts here
 ;  requires variable rcdatbeg and rcdatend
 ;
 N %,RCBILLDA,RCCATEG,RCDATE,RCTRANDA,RCTYPE
 K ^TMP("RCBMILL",$J),^TMP($J,"RCBMILLDATA")
 ;
 ;  get all payments between the two dates
 F RCTYPE=2,34 D
 .   S RCDATE=$E(RCDATBEG,1,5)_"00"
 .   F  S RCDATE=$O(^PRCA(433,"AT",RCTYPE,RCDATE)) Q:'RCDATE!(RCDATE>RCDATEND)  D
 .   .   S RCTRANDA=0
 .   .   F  S RCTRANDA=$O(^PRCA(433,"AT",RCTYPE,RCDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   .   S RCBILLDA=+$P($G(^PRCA(433,RCTRANDA,0)),"^",2) I 'RCBILLDA Q
 .   .   .   ;
 .   .   .   ;  bill not rx copay
 .   .   .   S RCCATEG=$P($G(^PRCA(430,RCBILLDA,0)),"^",2)
 .   .   .   I RCCATEG'=22,RCCATEG'=23 Q
 .   .   .   ;
 .   .   .   S ^TMP("RCBMILL",$J,RCBILLDA)=""
 ;
 ;  loop bills paid during the month and gather transactions
 S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("RCBMILL",$J,RCBILLDA)) Q:'RCBILLDA  D
 .   S %=$$BILLFUND^RCBMILLC(RCBILLDA,RCDATEND)
 ;
 ;  set up variables for reports
 N %,%H,%I,RCMOYR,RCMOYRTO,RCNOW,RCPAGE,RCRJFLAG,RCRJLINE,RCSCREEN,X,Y
 S Y=$E(RCDATBEG,1,5)_"00" D DD^%DT S RCMOYR=Y
 S Y=$E(RCDATEND,1,5)_"00" D DD^%DT S RCMOYRTO=Y
 D NOW^%DTC S Y=% D DD^%DT S RCNOW=Y
 S RCPAGE=1
 S RCSCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S RCSCREEN=1
 ;
 ;  print summary report
 I RCREPTYP=1 D SUMMARY^RCBMILL3
 ;  print payment detail report
 I RCREPTYP=2 D PRINT^RCBMILL1
 ;  print all transaction report
 I RCREPTYP=3 D PRINT^RCBMILL2
 ;  print history for date range
 I RCREPTYP=4 D PRINT^RCBMILL4
 ;
 K ^TMP("RCBMILL",$J),^TMP($J,"RCBMILLDATA")
 D ^%ZISC
 Q
 ;
 ;
ASKTYPE() ;  ask type of report
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SO^1:Summary for Selected Month;2:Payment Detail for Selected Month;3:All Transactions for Selected Month;4:History for Date Range"
 S DIR("A")="Select Report to Generate"
 S DIR("B")="Summary"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 ;
 I Y=3 D
 .   W !!,"***** WARNING: THIS WILL USE A LARGE AMOUNT OF PAPER. *****"
 .   W !,"***** I RECOMMENDED THAT YOU DO ***NOT*** PRINT THIS  *****"
 .   W !,"***** REPORT ON A PRINTER.  YOU SHOULD CAPTURE THIS   *****"
 .   W !,"***** TO A FILE ON YOUR PC FOR REVIEW.                *****"
 ;
 Q Y
 ;
 ;
MONTHSEL ;  ask starting and ending month
 ;  returns rcdatbeg and rcdatend
 N %DT,DEFAULT,X,Y
 K RCDATBEG,RCDATEND
 ;
 W !!,"--- Enter the Starting and Ending Month and Year ---"
 S Y=$E(DT,1,3)_"0100" D DD^%DT S DEFAULT=Y
 S %DT("A")="Select Starting MONTH YEAR: ",%DT("B")=DEFAULT,%DT="AEMP",%DT(0)=-DT D ^%DT I Y<0 Q
 S RCDATBEG=$E(Y,1,5)_"00"
 ;
 S Y=$E(DT,1,5)_"00" D DD^%DT S DEFAULT=Y
 S %DT("A")="Select Ending MONTH YEAR: ",%DT("B")=DEFAULT,%DT="AEMP",%DT(0)=-DT D ^%DT I Y<0 Q
 I Y<RCDATBEG W !,"ENDING MONTH MUST BE GREATER THAN STARTING MONTH!" G MONTHSEL
 S RCDATEND=$E(Y,1,5)_"32"
 ;
 S Y=RCDATBEG D DD^%DT W !,"--- Selected date range from ",Y," to "
 S Y=$E(RCDATEND,1,5)_"00" D DD^%DT W Y," ---"
 Q
