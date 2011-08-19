PRCHDPO ;WOIFO/CR - DELINQUENT DELIVERY LISTING PA OPTION ; 2/20/01  12:55 PM
 ;;5.1;IFCAP;**8,133**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
A1 ;
 D CLEAN
TYPE K Y,SELECT S SELECTW="" W !!
 S DIR("?")=" ",DIR("?",1)="Enter the Supply Employee code desired."
 S DIR("?",2)="Enter multiple codes if needed, ex. 1,3 or 2-4"
 S DIR("?",3)="Normal run has been for 6-ALL"
 S DIR(0)="L^1:6:0"
 S DIR("A",1)="Supply Employee type selection: ",DIR("A",2)="",DIR("A",3)="1:WAREHOUSE",DIR("A",4)="2:PPM ACCOUNTABLE OFFICER"
 S DIR("A",5)="3:PURCHASING AGENT",DIR("A",6)="4:MANAGER",DIR("A",7)="5:PURCHASE CARD HOLDER"
 S DIR("A",8)="6:ALL OF THE ABOVE",DIR("A",9)=""
 S DIR("A")="By Type of Supply Employee: ",DIR("B")="6" D ^DIR
 Q:$D(DIRUT)!($D(DTOUT))
 S SELECT=Y I SELECT[6 S SELECTW="<All Supply Employee types>",SELECT="6,"
 E  F I=1:1 S X=$P(SELECT,",",I) Q:X=""  I X>0 S:SELECTW'="" SELECTW=SELECTW_"," S SELECTW=SELECTW_$P("WAREHOUSE,PPM ACCT OFFICER,PURCHASING AGENT,MANAGER,PURCHASE CARD HOLDER",",",X)
 W !!,"SELECTED: ",$E(SELECT,1,($L(SELECT)-1))," / ",SELECTW,!
 K DR,DIR,X,Y,DIRUT,DTOUT
DATE S DIR("A")="START WITH DELIVERY DATE",DIR(0)="D^^" D ^DIR K DIR Q:Y["^"!(Y<1)
 S FDATE=+Y W "  ",Y(0)
 ;
 S DIR("A")="GO TO DELIVERY DATE",DIR(0)="D^^" D ^DIR K DIR Q:Y["^"!(Y<1)
 S EDATE=+Y W "  ",Y(0)
 I EDATE<FDATE W !,$C(7),"Less than 'FROM' value.",! K EDATE,FDATE G DATE
 ;
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="STAT^PRCHDPO",ZTSAVE("*")="" D ^%ZTLOAD,^%ZISC Q
 D STAT
 D ^%ZISC
 Q
 ;
FRMDT ; Make the current date for the header easier to read.
 D NOW^%DTC S Y=% D DD^%DT
 S X1=$P(Y,"@",1),X2=$P(X1,",",1)_","_$P(X1,", ",2)
 S X3=$P($P(Y,"@",2),":",1,2)
 S DATE=X2_"  "_X3
 Q
 ;
FRMDT1 ; Compress the delivery date display.
 S X1=$P(Y,",",1)_","_$P(Y,", ",2)
 Q
 ;
STAT ; Gather all the statistics
 S (GTOT,AMT1)=0,(VENTOT,SUBUSER)="",P=1
 S I="" F  S I=$O(^PRC(442,"B",I)) Q:I=""  D
 .S ZP="" F  S ZP=$O(^PRC(442,"B",I,ZP)) Q:ZP=""  D
 ..S ZP0=$G(^PRC(442,ZP,0)),DELDT=$P(ZP0,"^",10)
 ..S PONUM=$P(ZP0,"^",1),MOP=$P(ZP0,"^",2)
 ..; Check all possible methods of processing
 ..Q:"^1^2^3^4^7^8^9^21^22^23^25^26^"'[("^"_MOP_"^")
 ..S ZP1=$G(^PRC(442,ZP,1))
 ..Q:ZP1=""
 ..Q:DELDT<FDATE
 ..Q:DELDT>EDATE
 ..S Y=DELDT D DD^%DT,FRMDT1 S DELDT=X1 ; Show a human-readable date
 ..S VENPTR=$P(ZP1,"^",1)
 ..Q:VENPTR=""!(VENPTR=0)!(VENPTR'>0)
 ..S VENDOR=$P(^PRC(440,VENPTR,0),"^",1)
 ..S PHONE=$P($G(^PRC(440,VENPTR,0)),"^",10)
 ..S PRCHPA=+$P(ZP1,"^",10) Q:PRCHPA=""!(PRCHPA=0)
 ..I $D(^VA(200,PRCHPA,0)) S USER=$P(^VA(200,PRCHPA,0),"^")_">"_PRCHPA
 ..I SELECT'[6 Q:+$G(^VA(200,PRCHPA,400))=0&(SELECT'[5)  Q:+$G(^VA(200,PRCHPA,400))>0&(SELECT'[+$G(^VA(200,PRCHPA,400)))
 ..S:$D(^PRC(442,ZP,7)) ZP7=^PRC(442,ZP,7)
 ..S SUPT=+$P(ZP7,"^",1)
 ..S PRCSTAT=$P($G(^PRCD(442.3,SUPT,0)),"^")
 ..S SUPORD=$P(ZP7,"^",2)
 ..Q:"^20^21^22^23^24^25^26^27^28^29^32^34^39^44^46^47^"'[("^"_SUPORD_"^")
 ..S TOTAMT=$P(ZP0,"^",15),LIQAMT=$P(ZP0,"^",17)
 ..I LIQAMT<0,(TOTAMT-LIQAMT)>TOTAMT S COSOUT=0
 ..E  S COSOUT=TOTAMT-LIQAMT I COSOUT<0 S COSOUT=0
 ..S ^TMP($J,USER,VENDOR,PONUM)=PONUM_"^"_PRCSTAT_"^"_COSOUT_"^"_VENDOR_"^"_PHONE_"^"_DELDT
 ; 
PRINT ; Let's print the outstanding orders and dollar amounts.
 ;
 U IO
 D FRMDT
 S (P,EX)=1,(TOT,AMT1)=0
 I '$D(^TMP($J)) S P=1,(Q,Q1)="" D HEADER W !!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 S Q="" F  S Q=$O(^TMP($J,Q)) Q:Q=""  Q:EX="^"  D
 .D HEADER S (VENTOT,SUBUSER)=""
 .S Q1="" F  S Q1=$O(^TMP($J,Q,Q1)) Q:Q1=""  Q:EX="^"  D
 ..W:Q1]"" !,?18,"VENDOR: ",Q1
 ..S Q2="" F  S Q2=$O(^TMP($J,Q,Q1,Q2)) Q:Q2=""  Q:EX="^"  D
 ...S AMT1=0
 ...S STR3=^TMP($J,Q,Q1,Q2)
 ...W !,$P(STR3,"^",1),?15,$P(STR3,"^",2),?60,$J($P(STR3,"^",3),10,2)
 ...W !,?3,$P(STR3,"^",6),?17,$P(STR3,"^",5)
 ...I (IOSL-$Y)<8 D HOLD Q:EX="^"
 ...S AMT1=$P(STR3,"^",3),TOT=AMT1+$G(TOT),VENTOT(USER,VENPTR)=TOT
 ..W !,?60,"----------"
 ..W !,"SUBTOTAL",?60,$J(VENTOT(USER,VENPTR),10,2),!
 ..S GTOT=$G(GTOT)+VENTOT(USER,VENPTR),SUBUSER(USER)=VENTOT(USER,VENPTR)+$G(SUBUSER(USER))
 ..S TOT=0
 .I $E(IOST,1,2)="C-",EX'["^" W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ="^" EX="^" S:'$T EX="^"
 .I $G(Q2)="" D
 ..W ?60,"----------"
 ..W !,"SUBTOTAL",?60,$J(SUBUSER(USER),10,2) S SUBUSER(USER)=""
 ..; This is the subtotal for the user including all the vendors used.
 W !,?60,"----------"
 W !,"TOTAL",?55,$J(GTOT,15,2)
 D CLEAN
 Q
 ;
HOLD G HEADER:$E(IOST,1,2)'="C-"!(IO'=IO(0)) W !,"Press return to continue, '^' to exit: " R XXZ:DTIME S:XXZ["^" EX="^" S:'$T EX="^" I EX'="^",$G(Q2)'="" D HEADER
 Q
 ;
HEADER ;
 W @IOF
 W !,"DELINQUENT PURCHASE ORDERS",?42,DATE,?68,"PAGE ",P,!
 W "** FOR SUPPLY EMPLOYEE: ",SELECTW,!
 W !,"PO NUMBER",?15,"SUPPLY STATUS",?63,"COST",!
 W ?3,"DELIVERY",?17,"PHONE",?60,"OUTSTANDING",!
 W ?3,"DATE",?17,"NUMBER",?45,"(QTY*UNIT COST FOR ITEMS NOT REC'D)",!
 F I=1:1:10 W "--------"
 W !!,?15,"PA/PPM/AUTHORIZED BUYER: ",$P(Q,">"),!
 S P=P+1
 Q
 ;
CLEAN K AMT1,COSOUT,DATE,DELDT,EDATE,FDATE,PRCHPA,PRCSTAT,Q,Q1,Q2,^TMP($J)
 K SUPT,TOT,TOTAMT,VENDOR,VENPTR,VENTOT,X,X1,X2,X3,XXZ,Y,ZP,ZP0,ZP1,ZP7
 K EX,ENTOT,GTOT,I,LIQAMT,MOP,P,PHONE,PONUM,STR3,SUBUSER,SUPORD,USER
 K SELECT,SELECTW
 Q
