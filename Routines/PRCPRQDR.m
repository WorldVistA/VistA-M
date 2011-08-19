PRCPRQDR ;WISC/RFJ-quantity distribution report (option, whse)      ;10 Jun 93
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")="P" D PRIMARY^PRCPRQDP Q
 I PRCP("DPTYPE")="S" D SECONDY^PRCPRQDP Q
 ;
 ;  quantity distribution report for whse
 N PRCPEND,PRCPSTRT,X
 K X S X(1)="The Quantity Distribution Report will display all sales from the Warehouse to the Primary inventory points.  This report is sorted by NSN and date issued."
 D DISPLAY^PRCPUX2(40,79,.X)
 ;
 K X S X(1)="Select the range of NSNs to display"
 W !! D DISPLAY^PRCPUX2(2,40,.X)
 D NSNSEL^PRCPURS0
 I '$D(PRCPSTRT) Q
 ;
 W ! S %ZIS="Q" D ^%ZIS
 G:POP Q
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D Q Q
 .   S ZTDESC="Quantity Distribution Report",ZTRTN="DQ^PRCPRQDR"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  queue starts here
 N %,%H,%I,COUNT,CURRENT,DA,DATA,DATE,DATEDAT,DATEEDT,DATESDT,DATESTRT,H,ITEMDA,ITEMDATA,L,NOW,NSN,PAGE,PRCPDATA,PRCPFLAG,Q,QTY,SCREEN,TOTALC,TOTALQ,TOTALV,TYPE,V,VALUE,X,Y
 K DATEDAT
 S CURRENT=$E(DT,1,5)_"00"
 S X1=$E(DT,1,5)_"15"
 S X2=-375
 D C^%DTC S (DATESTRT,Y)=$E(X,1,5)_"00"
 D DD^%DT S DATEDAT($E(X,1,5))=$P(Y," ")_$E(X,2,3)
 S DATE=$E(DATESTRT,1,5)_"15"
 F  S X1=DATE,X2=30 D  Q:$E(X,1,5)'<$E(CURRENT,1,5)  S DATE=$E(X,1,5)_"15"
 .   D C^%DTC S Y=$E(X,1,5)_"00"
 .   D DD^%DT
 .   S DATEDAT($E(X,1,5))=$P(Y," ")_$E(X,2,3)
 K ^TMP($J,"PRCPRQDR")
 ;
 S DATE=DATESTRT-.01
 F  S DATE=$O(^PRCP(445.2,"AX",PRCP("I"),DATE)) Q:'DATE!($E(DATE,1,5)>$E(CURRENT,1,5))  F TYPE="R","C","E" S DA=0 F  S DA=$O(^PRCP(445.2,"AX",PRCP("I"),DATE,TYPE,DA)) Q:'DA  D
 .   S DATA=$G(^PRCP(445.2,DA,0)) I DATA="" Q
 .   S ITEMDA=$P(DATA,"^",5),NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 .   I $E(NSN,1,$L(PRCPSTRT))'=PRCPSTRT,$E(NSN,1,$L(PRCPEND))'=PRCPEND I NSN']PRCPSTRT!(PRCPEND']NSN) Q
 .   S $P(DATA,"^",7)=-$P(DATA,"^",7)
 .   I '$P(DATA,"^",23) S $P(DATA,"^",23)=$J($P(DATA,"^",7)*$P(DATA,"^",9),0,2)
 .   I $P(DATA,"^",23)<0 S $P(DATA,"^",23)=-$P(DATA,"^",23)
 .   S %=$G(^TMP($J,"PRCPRQDR",NSN,ITEMDA,$E(DATE,1,5)))
 .   S ^TMP($J,"PRCPRQDR",NSN,ITEMDA,$E(DATE,1,5))=($P(DATA,"^",7)+$P(%,"^"))_"^"_($P(DATA,"^",23)+$P(%,"^",2))
 ;  print report
 S Y=DATESTRT D DD^%DT S DATESDT=Y,Y=DT D DD^%DT S DATEEDT=Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S NSN=""
 F  S NSN=$O(^TMP($J,"PRCPRQDR",NSN)) Q:NSN=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRQDR",NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>" Q
 .   I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   W !!,$TR(NSN,"-")
 .   W ?15,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,18)
 .   W ?34,ITEMDA
 .   W ?39,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),7)
 .   W $J($P(ITEMDATA,"^",10),6)
 .   W $J($P(ITEMDATA,"^",4),7)
 .   W $J($P(ITEMDATA,"^",23),7)
 .   W $J($P(ITEMDATA,"^",11),7)
 .   W $J($P(ITEMDATA,"^",9),7)
 .   S (H(0),H(1),Q(0),Q(1),V(0),V(1))=""
 .   S (COUNT,DATE,L,TOTALC,TOTALQ,TOTALV)=0
 .   F  S DATE=$O(DATEDAT(DATE)) Q:'DATE  S PRCPDATA=$G(^TMP($J,"PRCPRQDR",NSN,ITEMDA,DATE)) D
 .   .   S QTY=+$P(PRCPDATA,"^") I QTY=0 S QTY="..."
 .   .   S VALUE=$J($P(PRCPDATA,"^",2),0,2) I VALUE="0.00" S VALUE="..."
 .   .   I TOTALC'=12 S TOTALQ=TOTALQ+$P(PRCPDATA,"^"),TOTALV=TOTALV+$P(PRCPDATA,"^",2),TOTALC=TOTALC+1
 .   .   S H(L)=H(L)_$J(DATEDAT(DATE),10),Q(L)=Q(L)_$J(QTY,10),V(L)=V(L)_$J(VALUE,10),COUNT=COUNT+1
 .   .   I COUNT=6 S L=1,COUNT=0
 .   S H(1)=H(1)_$J("AVG",10),Q(1)=Q(1)_$J(TOTALQ/TOTALC,10,0),V(1)=V(1)_$J(TOTALV/TOTALC,10,2)
 .   W !,H(0),?79,"^",!,Q(0),?79,"|",!,V(0),?79,"v",!,H(1),!,Q(1),!,V(1)
 I $G(PRCPFLAG) D Q Q
 D END^PRCPUREP
Q D ^%ZISC K ^TMP($J,"PRCPRQDR")
 Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"QUANTITY DISTRIBUTION REPORT FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 W !?5,"QUANTITY DISTRIBUTION DATE RANGE: ",DATESDT,"  TO  ",DATEEDT
 S %="",$P(%,"-",81)=""
 W !?46,$J("STAND",6),$J("OPT",7),$J("TEMP",7),$J("EMER",7),$J("NORM",7),!,"NSN",?15,"DESCRIPTION",?34,"MI#",?39,$J("UNIT/IS",7),$J("REOPT",6),$J("REOPT",7),$J("S.LVL",7),$J("S.LVL",7),$J("S.LVL",7)
 W !,%
 Q
