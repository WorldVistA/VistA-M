PRCACOL ;WASH-ISC@ALTOONA,PA/LDB-Payment History Report ;9/27/93  4:31 PM
V ;;4.5;Accounts Receivable;**165,198,264**;Mar 20, 1995;Build 1
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;Ask debtor and date range for payment history
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 K DIR S POP=0
 S DIR(0)="PO^340:QEAMZ",DIR("A")="Select Patient ",DIR("?")="Enter a Patient name" D ^DIR
 I $D(DIRUT)!(Y="") G EXIT1
 I $P($G(^RCD(340,+Y,0)),U)'["DPT" W *7 G EN
 S DEBTOR=+Y K DIR
 I '$D(^PRCA(433,"ATD",DEBTOR)) W !,"This patient has made no payments." Q
 S BDATE=$S(($$LST^RCFN01(DEBTOR,2)<0):$$FMADD^XLFDT(DT,-30),1:+$$LST^RCFN01(DEBTOR,2)),DIR(0)="DO^2880101:DT",DIR("A")="Payment history beginning date",DIR("B")=$$FMTE^XLFDT(BDATE,"1D")
 S DIR("?")="The default date is either the last statement day or T-30, but any date may be entered."
 D ^DIR
 S:Y'="" BDATE=Y I $D(DIRUT)&'Y G EXIT1 Q
 K DIR,X,Y
 S DIR(0)="DO^"_BDATE_":DT",DIR("A")="Payment history ending date",DIR("B")=$$FMTE^XLFDT(DT,"1D")
 D ^DIR S:Y="" Y=DT I $D(DIRUT)&'Y G EXIT1 Q
 S EDATE=Y
 K DIR
 S %ZIS="AEQ" D ^%ZIS G:POP EXIT1
 I $D(IO("Q")) D  Q
 .S ZTSAVE("DEBTOR")="",ZTSAVE("BDATE")="",ZTSAVE("EDATE")="",ZTRTN="DQ^PRCACOL",ZTDESC="Patient Payment/Refund Transaction History Report"
 .D ^%ZTLOAD,^%ZISC,EXIT1 K ZTSAVE,ZTRTN,IO("Q") Q
 ;
DQ ;Call to build array of payment transactions
 ;
 U IO
 D TRANS
 I '$D(^TMP($J,"PRCACOL")) D HDR W !!,"This patient has no payments or refunds during this time period."
 I $D(^TMP($J)) D HDR,PRINT
 ;
EXIT1 K AMT,BDATE,EDATE,DATE,DEBTOR,DIR,DUOUT,DX,DY,LINE,PG,PNODE,TN,X,Y,ZTSK,TOTPD,TOTREF,TOTPRIN,TOTINT,TOTADM,^TMP($J),^UTILITY($J)
 I $D(DIRUT)!POP K DIRUT,POP Q
 ;end of routine
EXIT2 I $E(IOST,1,2)'="C-" W @IOF D ^%ZISC Q
 I $E(IOST,1,2)="C-"  D ENS^%ZISS S DY=IOM-1,DX=0 X IOXY D KILL^%ZISS K DIR,X,Y,^UTILITY($J) S DIR(0)="E" D ^DIR
 I $D(DIRUT) K DIRUT Q
 D ^%ZISC
 G EN
 ;
TRANS ;Build array of transactions
 S (PG,TOTPD,TOTREF,TOTPRIN,TOTINT,TOTADM)=0,$P(LINE,"-",75)="-" K ^TMP($J) D DT^DICRW
 S BILL=0 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:'BILL  D
 .S TN=0 F  S TN=$O(^PRCA(433,"C",+BILL,TN)) Q:'TN  D
 ..I $D(^PRCA(433,TN,0)),$D(^(1)),"^2^34^41^"[("^"_$P(^(1),"^",2)_"^") D
 ...;  if transaction is not complete (2), do not display it
 ...I $P(^PRCA(433,TN,0),"^",4)'=2 Q
 ...S X=^PRCA(433,TN,1),DATE=+X Q:DATE<BDATE!(+X>EDATE)
 ...S ^TMP($J,"PRCACOL",DATE,TN)=$P($G(^PRCA(433,+TN,0)),U,2)_U_$P(X,U)_U_$S($P(X,U,2)=41:"Y",1:"")_U_$P(X,U,3)_U_$P(X,U,5)
 ...S:$P(^TMP($J,"PRCACOL",DATE,TN),U,3)'="Y" TOTPD=TOTPD+$P(X,U,5) S:$P(^(TN),U,3)="Y" TOTREF=TOTREF+$P(X,U,5)
 ...I $D(^PRCA(433,TN,3)) S X=^(3),^TMP($J,"PRCACOL",DATE,TN)=^TMP($J,"PRCACOL",DATE,TN)_U_$P(X,U)_U_$P(X,U,2)_U_$P(X,U,3) D
 ....S:$P(^TMP($J,"PRCACOL",DATE,TN),U,3)'="Y" TOTPRIN=TOTPRIN+$P(X,U),TOTINT=TOTINT+$P(X,U,2),TOTADM=TOTADM+$P(X,U,3)
 Q
 ;
PRINT ;Print transactions
 S DATE=0 F  S DATE=$O(^TMP($J,"PRCACOL",DATE)) Q:'DATE  Q:$D(DIRUT)  D
 .S TN=0 F  S TN=$O(^TMP($J,"PRCACOL",DATE,TN)) Q:'TN  D SCRN Q:$D(DIRUT)  D
 ..S PNODE=^TMP($J,"PRCACOL",DATE,TN) W !,$$FMTE^XLFDT($P(PNODE,U,2),"1D"),?15,$P($G(^PRCA(430,+$P(PNODE,U),0)),U)
 ..W ?27,$P(PNODE,U,3),?32,$P(PNODE,U,4),?42 S AMT=$P(PNODE,U,5) W $J(AMT,6,2)
 ..F X=1:1:3 S X(X)=$P(PNODE,U,X+5) W:X=1 ?50,$J(X(X),6,2) W:X=2 ?58,$J(X(X),6,2) W:X=3 ?66,$J(X(X),6,2)
 ..D SCRN Q:$D(DIRUT)
 ..Q
 .Q
 ;
 D SCRN Q:$D(DIRUT)
 W !!,?25,"      Total Principal Paid: ",?50,$J(TOTPRIN,12,2)
 D SCRN Q:$D(DIRUT)
 W !,?25,"       Total Interest Paid: ",?50,$J(TOTINT,12,2)
 D SCRN Q:$D(DIRUT)
 W !,?25,"          Total Admin Paid: ",?50,$J(TOTADM,12,2)
 D SCRN Q:$D(DIRUT)
 W !,?25,"                Total Paid: ",?50,$J(TOTPD,12,2)
 D SCRN Q:$D(DIRUT)
 W !,?25,"              Total Refund: ",?50,$J(TOTREF,12,2)
 Q
 ;
SCRN ;Check for screen
 K DIR I ($Y+3)>IOSL D
 .I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR Q:$D(DIRUT)
 .D HDR
 Q
 ;
HDR ;Heading for report
 S PG=PG+1
 W @IOF,!,?20,"Patient Payment History Report",?70,"Page ",PG
 W !,?20,"------------------------------"
 W !!,?18,"For Patient: ",$$NAM^RCFN01(DEBTOR),!,?25,"SSN : ",$$SSN^RCFN01(DEBTOR)
 W !,?20,"For dates: ",$$FMTE^XLFDT(BDATE,"ID"),"-",$$FMTE^XLFDT(EDATE,"1D")
 W !!,"    DATE OF",!,"PAYMENT/REFUND",?16,"BILL #",?25,"REFUND",?32,"RECEIPT #",?42,"AMOUNT",?51,"PRIN.",?59,"INT.",?67,"ADMIN.",!,LINE
 Q
