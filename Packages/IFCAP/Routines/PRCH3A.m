PRCH3A ;WISC/PLT-IFCAP INACTIVATE OLD/EXPIRED PURCHASE CARDS - CITIBANK ;8/28/98  11:49
V ;;5.1;IFCAP;**8,125**;Oct 20, 2000;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;ZTQPARAM="REGULAR" if from schedule option, ="CITI" if from CITIBANK schedule
EN ;inactivate charge cards
 N PRCA,PRCB,PRCRI,PRCDI,PRC,PRCTD
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
 I $D(ZTQUEUED) G SCHED
Q1 ;inactivate all CITI charge cards with expired date before t
 S PRCTD=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 D YN^PRC0A(.X,.Y,"Ready to inactivate old Citibank & expired US Bank charge cards before "_PRCTD,"O","NO")
 I X["^"!(X="")!'Y G EXIT
 D NOW^%DTC S ZTDTH=%
 S %ZIS("B")="Q",ZTIO=""
 S ZTRTN="SCHED^PRCH3A",ZTDESC="IFCAP INACTIVATION OF OLD CITIBANK/EXPIRED US BANK CHARGE CARDS",ZTSAVE("*")=""
 D ^%ZTLOAD
 W !! D EN^DDIOL("  IFCAP INACTIVATION OF OLD CITIBANK/EXPIRED US BANK CHARGE CARDS WAS SCHEDULED WITH TASK # "_ZTSK)
 R X:4
 D HOME^%ZIS
EXIT QUIT
 ;
 ;
 D EDIT^PRC0B(.X,PRCDI,"4;5;6")
 ;
SCHED ;inactivate old Citibank/expired US Bank charge card with date before run date
 D NOW^%DTC I %<3081129.0500 Q
 N PRCRI,PRCA,PRCB,PRCC S DT=X
 S PRCRI=0,U="^"
 F  S PRCRI=$O(^PRC(440.5,PRCRI)) QUIT:PRCRI'?1N.N!'PRCRI  S PRCA=$G(^(PRCRI,0)),PRCB=$G(^(2)) D:$P(PRCB,U,2)'="Y"
 . I $D(PRC("SITE")) Q:$P($G(PRCB),"^",3)'=PRC("SITE")
 . S PRCC=""
 . I PRCA?1"4486".E S PRCC="Y"
 . I PRCC="",$P(PRCB,U,4),$P(PRCB,U,4)<DT S PRCC="Y"
 . I PRCC="Y" S X="" D EDIT^PRC0B(.X,"440.5;^PRC(440.5,;"_PRCRI,"14///^S X=""Y""")
 . QUIT
 QUIT
