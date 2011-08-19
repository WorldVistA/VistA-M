PRCPAWR1 ;WISC/DWA,RFJ-print register approval form (end of report)     ;11 Mar 94
 ;;5.1;IFCAP;**4**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
BUILD ;  build tmp global for printing the report
 N DA,DATA,TRANID
 K ^TMP($J,"PRCPAWR0 DA")
 ;  build selected adjustements only
 I $O(^TMP($J,"PRCPAWR0",""))'="" D  Q
 .   S TRANID="" F  S TRANID=$O(^TMP($J,"PRCPAWR0",TRANID)) Q:$E(TRANID)'="A"  D BUILD1
 ;  build all adjustments
 S TRANID="A" F  S TRANID=$O(^PRCP(445.2,"T",PRCP("I"),TRANID)) Q:$E(TRANID)'="A"  D BUILD1
 Q
 ;
 ;
BUILD1 ;  build tmp global with adjustment data
 S DA=0 F  S DA=$O(^PRCP(445.2,"T",PRCP("I"),TRANID,DA)) Q:'DA  S DATA=$G(^PRCP(445.2,DA,0)) I DATA'="" D
 .   I $P(DATA,"^",20)="" S ^TMP($J,"PRCPAWR0 DA",TRANID,DA)=""
 Q
 ;
 ;
END ;  print end of report information
 W !!,"----------- S U M M A R Y   O F   I T E M   A C C O U N T   C O D E S ----------"
 S TOTAL=0,ACCT=0 F  S ACCT=$O(ACCOUNT(ACCT)) Q:ACCT=""!$G(PRCPFLAG)  S DATA=ACCOUNT(ACCT) D
 .   I $X>40 W !
 .   E  W ?40
 .   W "ACCT: ",ACCT,?($S($X<10:10,1:50)),"INV AMOUNT: ",$J(DATA,12,2) S TOTAL=TOTAL+DATA
 .   I $Y>(IOSL-2),$X>40,$O(^TMP($J,"ACCT",ACCT))'="" D:$G(SCREEN) P^PRCPUREP Q:$D(PRCPFLAG)  D H^PRCPAWR0
 K ACCOUNT
 I $D(PRCPFLAG) Q
 W !!,"TOTAL DOLLAR AMOUNT OF INVENTORY VALUE ADJUSTMENT (UNAPPROVED): ",$J(TOTAL,0,2)
 I $D(PRCPMSG) W !!,PRCPMSG
 I '$G(PRCPMULT) Q  ;all adjustments printed on same report
 K DATA F %=1:1 S DATA=$P($T(DATA+%),";",3,99) Q:DATA=""  S DATA(%)=DATA
 I $Y>(IOSL-%-2) D:$G(SCREEN) P^PRCPUREP Q:$D(PRCPFLAG)  D H^PRCPAWR0
 W ! S %=0 F  S %=$O(DATA(%)) Q:'%  W !,DATA(%)
 I $O(^TMP($J,"PRCPAWR0 DA",TRANID))'="" D:$G(SCREEN) P^PRCPUREP W @IOF
 S PAGE=0
 Q
 ;
 ;
DATA ;print signature at bottom of report
 ;;CERTIFICATION -- THE SUPPLIES LISTED ON THIS REQUEST HAVE BEEN PROPERLY
 ;;ADJUSTED BY QUANTITY AND VALUE.
 ;; 
 ;;ITEM NUMBERS APPROVED [#MI]:__________________________________________________
 ;; 
 ;;SIGNATURE ACCOUNTABLE OFFICER:________________________________________________
 ;; 
 ;;SIGNATURE APPROVING OFFICIAL:_________________________________________________
