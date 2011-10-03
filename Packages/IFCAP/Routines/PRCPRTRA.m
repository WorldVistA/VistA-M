PRCPRTRA ;WISC/RFJ-transaction register report                      ;07 Sep 91
V ;;5.1;IFCAP;**1,142**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,%H,%I,ALLITEMS,ITEMDA,PRCPDT,PRCPDATE,PRCPDATB,PRCPSUMM,X,Y
 ;
 K X S X(1)="The Transaction Register Report prints all activity for specified items, including the opening and closing balances."
 S X(2)="The current month-year balance on file appears under the calculated closing balance if the two values differ."
 D DISPLAY^PRCPUX2(40,79,.X)
 ;
 K X S X(1)="Enter the beginning/ending month-year for printing the transaction register. If printing 'ALL' items the beginning/ending dates MUST be the same."
 D DISPLAY^PRCPUX2(2,40,.X)
DAT S Y=$E(DT,1,5)_"00" S %DT(0)=-Y
 D DD^%DT
DAT1 S %DT="AEP",%DT("B")=Y
 S %DT("A")="Print Transaction Register for beginning MONTH and YEAR: "
 D ^%DT K %DT I Y<1 Q
 S (Y,PRCPDATB)=$E(Y,1,5)
DAT2 S Y=$E(Y,1,5)_"00" D DD^%DT
 S %DT="AEP",%DT("B")=Y
 S %DT("A")="Print Transaction Register for ending MONTH and YEAR: "
 D ^%DT K %DT I Y<1 Q
 S (Y,PRCPDATE)=$E(Y,1,5)
 I PRCPDATE<PRCPDATB W !,"    Ending date CANNOT be prior to beginning date" G DAT2
 ;
SELECT I PRCPDATE=$E(DT,1,5),PRCPDATB=$E(DT,1,5) D  I '% Q
 .   K X S X(1)="You may now select to print only items whose calculated closing balance differs from the current on-hand inventory."
 .   D DISPLAY^PRCPUX2(2,40,.X)
 .   S XP="Display only items out of balance"
 .   S XH="Enter 'YES' to only show those items out of balance, 'NO' to select items."
 .   S %=$$YN^PRCPUYN(2) I '% Q
 .   I %=1 S PRCPSUMM=1
 ;
 I $G(PRCPSUMM) S ALLITEMS=1 G DEVICE
 ;
ITEMS ;return here after printing report
 ;  get selected item list
 S HPRCPDT=PRCPDATE,PRCPDATE=""
 D ITEMMAST^PRCPURS4(PRCPDATE)
 S PRCPDATE=HPRCPDT K HPRCPDT
 I '$O(^TMP($J,"PRCPITEMS",0)),'$D(ALLITEMS) Q
 I $D(ALLITEMS),(PRCPDATB'=PRCPDATE) W !,"** All Items selection MUST use same begin/end month and year **" K ALLITEMS G DAT
 ;
DEVICE ;  ask device
 S %ZIS="Q" D ^%ZIS Q:POP 
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK,^TMP($J,"PRCPITEMS") Q
 .   S ZTDESC="Transaction Register Report",ZTRTN="DQ^PRCPRTRA"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ALLITEMS")="",ZTSAVE("^TMP($J,""PRCPITEMS"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;queue comes here
 N %,CURRQTY,CURRVAL,D,DATE,DESCR,ITEMDA,ITEMDATA,NSN,OPENQTY,OPENVAL,TOTALQTY,TOTALVAL,TRX,TT,UNIT,X,Y
 K ^TMP($J,"PRCPRTRA")
 S PRCPDT=PRCPDATB
D1 S ITEMDA=0,TOTALQTY=0,TOTALVAL=0
 F  S ITEMDA=$O(^PRCP(445.1,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  I $D(^(ITEMDA,1,PRCPDT,0))&($D(ALLITEMS)!($D(^TMP($J,"PRCPITEMS",ITEMDA)))) D
 .   S %=$$GETOPEN^PRCPUBAL(PRCP("I"),ITEMDA,PRCPDT)
 .   S OPENQTY=$P(%,"^",2)+$P(%,"^",3)
 .   S OPENVAL=+$P(%,"^",8)
 .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 .   S TOTALQTY=OPENQTY,TOTALVAL=OPENVAL
 .   S TRX=0
 .   F  S TRX=$O(^PRCP(445.2,"AD",PRCP("I"),ITEMDA,TRX)) Q:'TRX  D
 .   .   S D=$G(^PRCP(445.2,TRX,0)),DATE=$P($P(D,"^",17),".")
 .   .   I $E(DATE,1,5)=PRCPDT D
 .   .   .   S TT=$P(D,"^",4)
 .   .   .   S TT=$S($E(TT,1,2)="RC":"R",$E(TT)="R":"D",1:TT)
 .   .   .   S %=$E($P(D,"^",2),2,10) S:$E(%)?1A %=$E(%,2,10)
 .   .   .   I PRCP("DPTYPE")="P"&(TT="D"!(TT="C")!(TT="E")) D
 .   .   .   .   S X=$P($P($G(^PRCP(445,+$P(D,"^",18),0)),"^"),"-",2,99)
 .   .   .   .   S:X'="" X=$E("to: "_X,1,18)
 .   .   .   .   S:$P(D,"^",19)="" $P(D,"^",19)=X
 .   .   .   I PRCP("DPTYPE")="S",TT="U" D
 .   .   .   .   S X=$P($G(^PRCP(445.2,TRX,2)),"^",2)
 .   .   .   .   S:X'="" X=$E("to: "_X,1,18)
 .   .   .   .   S $P(D,"^",19)=X
 .   .   .   I $P(D,"^",22)="",$P(D,"^",23)="" D
 .   .   .   .   S $P(D,"^",22)=$J($P(D,"^",7)*$S($E(TT,1,2)="R":$P(D,"^",9),1:$P(D,"^",8)),0,2)
 .   .   .   .   S $P(D,"^",23)=$J($P(D,"^",7)*$P(D,"^",9),0,2)
 .   .   .   S $P(D,"^",22)=$J($P(D,"^",22),0,2)
 .   .   .   S $P(D,"^",23)=$J($P(D,"^",23),0,2)
 .   .   .   ;  nonissuable
 .   .   .   I $P(D,"^",11)'="" D
 .   .   .   .   S $P(D,"^",19)=$S($P(D,"^",7)<0:"  TO",1:"FROM")
 .   .   .   .   S $P(D,"^",19)=$P(D,"^",19)_" noniss qty: "
 .   .   .   .   S $P(D,"^",19)=$P(D,"^",19)_$S($P(D,"^",7)<0:-$P(D,"^",7),1:$P(D,"^",7))
 .   .   .   .   S $P(D,"^",7)=""
 .   .   .   .   S $P(D,"^",22,23)="^"
 .   .   .   S TOTALQTY=TOTALQTY+$P(D,"^",7),TOTALVAL=TOTALVAL+$P(D,"^",22)
 .   .   .   S ^TMP($J,"PRCPRTRA",ITEMDA,PRCPDT,DATE,TRX)=TT_%_"^"_$P(D,"^",19)_"^"_$P(D,"^",6)_"^"_$P(D,"^",22)_"^"_$P(D,"^",23)_"^"_$P(D,"^",7)
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   S CURRQTY=$P(ITEMDATA,"^",7)+$P(ITEMDATA,"^",19)
 .   S CURRVAL=$P(ITEMDATA,"^",27)
 .   I CURRVAL="" S CURRVAL=+$J(CURRQTY*$P(ITEMDATA,"^",22),0,2)
 .   I $G(PRCPSUMM),CURRQTY=TOTALQTY,CURRVAL=TOTALVAL K ^TMP($J,"PRCPRTRA",ITEMDA,PRCPDT) Q
 .   S DESCR=$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,30)
 .   S UNIT=$$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/")
 .   S ^TMP($J,"PRCPRTRA",ITEMDA,PRCPDT)=NSN_"^"_DESCR_"^"_UNIT_"^"_$$GETIN^PRCPUDUE(PRCP("I"),ITEMDA)_"^"_$$GETOUT^PRCPUDUE(PRCP("I"),ITEMDA)_"^"_$P(ITEMDATA,"^",19)_"^"_OPENQTY_"^"_OPENVAL_"^"_TOTALQTY_"^"_TOTALVAL
 .   I CURRQTY=TOTALQTY,CURRVAL=TOTALVAL Q
 .   S ^TMP($J,"PRCPRTRA",ITEMDA,PRCPDT,"BAL")=CURRQTY_"^"_CURRVAL
 S PRCPDT=PRCPDT+1 S:$E(PRCPDT,4,5)=13 PRCPDT=$E(PRCPDT,1,3)+1_"01"
 I PRCPDT'>PRCPDATE G D1
 D PRINT^PRCPRTR1
 I '$D(ZTQUEUED) W !!!! K PRCPSUMM G ITEMS
 Q
