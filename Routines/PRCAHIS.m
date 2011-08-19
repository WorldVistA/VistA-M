PRCAHIS ;WASH-ISC@ALTOONA,PA/LDB-Transaction History Report ;9/27/93  4:32 PM
V ;;4.5;Accounts Receivable;**110,198,233**;Mar 20, 1995;Build 4
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;Ask debtor and date range for transaction history
 K DIR S POP=0
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIR(0)="PO^340:QEAMZ",DIR("A")="Select Patient ",DIR("?")="Enter a Patient name" D ^DIR
 I $D(DIRUT)!(Y="") G EXIT1
 I $P($G(^RCD(340,+Y,0)),U)'["DPT" W *7 G EN
 S DEB=+Y K DIR
 I '$D(^PRCA(433,"ATD",DEB)),'$D(^PRCA(430,"ATD",DEB)),'$D(^RC(341,"AD",DEB)) W !,"This patient has no activity." Q
 S BDATE=$O(^PRCA(433,"ATD",+DEB,0)),DIR(0)="DO" S:'BDATE BDATE=2910101
 S DIR("A")="History beginning",DIR("B")=$$FMTE^XLFDT(BDATE,"1D")
 S DIR("?")="The default date is either the last statement day or T-30, but any date may be entered."
 D ^DIR
 S:Y'="" BDATE=Y I $D(DIRUT)&'Y G EXIT1 Q
 K DIR,X,Y
 S DIR(0)="DO^"_BDATE_":DT"
 S DIR("A")="History ending",DIR("B")=$$FMTE^XLFDT(DT,"1D")
 D ^DIR S:Y="" Y=DT I $D(DIRUT)&'Y G EXIT1 Q
 S EDATE=Y
 K DIR
TYPE S DIC="^PRCA(430.3,",DIC(0)="QEMZ",DIC("S")="I +Y,(+Y<15!(""25^29^34^35^40^41^43^45^47""[(""^""_+Y_""^"")))"
 S Y=0 R !,"TRANSACTION TYPE: ALL//",X:DTIME I '$T!(X="^") Q
 I X]"",X'="ALL" D ^DIC
 I X["?" W !!,"Enter 'ALL' for all types of transactions in the AR TRANSACTION TYPE FILE",!,"including COMMENTS and STATEMENT DATES.",! G TYPE
 G:Y<0 EXIT1  S TYP=$S(+Y:+Y,1:X)
 I $P($G(^PRCA(430.3,+Y,0)),"^",3)>100 W !!,"This is STATUS. Enter a transaction type only." G TYPE
 S %ZIS="AEQ" D ^%ZIS G:POP EXIT1
 I $D(IO("Q")) D  Q
 .S ZTSAVE("DEB")="",ZTSAVE("BDATE")="",ZTSAVE("EDATE")="",ZTSAVE("TYP")="",ZTRTN="DQ^PRCAHIS",ZTDESC="Patient Transaction History Report"
 .D ^%ZTLOAD,^%ZISC,EXIT1 K ZTSAVE,ZTRTN Q
 ;
DQ ;Call to build array of payment transactions
 ;
 U IO
 D TRANS^PRCAHIS1
 I '$D(^TMP("PRCAGT",$J)) W !!,"This patient has no activity during this time period."
 I $D(^TMP("PRCAGT",$J)) D HDR,PRINT
 ;
EXIT1 K AMT,BDATE,BN,BN0,CAT,CATCARE,EDATE,EVNTT,DAT1,DAT2,DATE,DEB,DIC,DIR,DIWL,DIWF,DIWR,DIWT,DUOUT,DX,DY,EVNT,EVNTT,LINE,PG,PNODE,TBAL,TOTPRIN,TOTTRAN,TTYP,TYP,TN,TN0,X,Y,Z,ZTSK,^TMP("PRCAGT",$J),^UTILITY($J)
 I $D(DIRUT)!POP K DIRUT,POP Q
 ;end of routine
EXIT2 I $E(IOST,1,2)'="C-" W @IOF D ^%ZISC Q
 I $E(IOST,1,2)="C-" W ! D ENS^%ZISS S DY=IOM-1,DX=0 X IOXY D KILL^%ZISS K DIR,X,Y,^UTILITY($J) S DIR(0)="E" D ^DIR
 I $D(DIRUT) K DIRUT Q
 D ^%ZISC
 G EN
 ;
 ;
PRINT ;Print transactions
 K DIRUT
 S DATE=0 F  S DATE=$O(^TMP("PRCAGT",$J,DEB,DATE)) Q:'DATE  Q:$D(DIRUT)  D
 .S BN="" F  S BN=$O(^TMP("PRCAGT",$J,DEB,DATE,BN)) Q:BN=""!($D(DIRUT))  D SCRN D
 ..I $D(^TMP("PRCAGT",$J,DEB,DATE,0)) S (BN0,PNODE)=^(0) D
 ...W !,$$FMTE^XLFDT($P(DATE,".")),?16
 ...S TYP=$P(BN0,"^",2) W $S(TYP=1:"COMMENT",1:"PATIENT STATEMENT PRINTED") I TYP=1 S EVNT=$P(BN0,"^",3) D
 ....W:$D(^RC(341,+EVNT,4)) !,?16,$P(^(4),"^")
 ....I $O(^RC(341,+EVNT,2,0)) S EVNTT=0 F  S EVNTT=$O(^RC(341,+EVNT,2,EVNTT)) Q:'EVNTT  I $D(^(EVNTT,0)) S X=^(0) D  Q:$D(DIRUT)  D ^DIWW
 .....S DIWL=17,DIWF="WC63" D ^DIWP
 .....D SCRN
 ..Q:(BN=0)  S TN="" F  S TN=$O(^TMP("PRCAGT",$J,DEB,DATE,BN,TN)) Q:TN=""  Q:$D(DIRUT)  D SCRN D
 ...I 'TN,$D(^TMP("PRCAGT",$J,DEB,DATE,BN,0)) S PNODE=^(0),BN0=$G(^PRCA(430,+BN,0)) W !!,$$FMTE^XLFDT($P(DATE,".")) D
 ....S CAT=$P(BN0,"^",2),CAT=$S(CAT=24&$P(BN0,"^",16):$P(^PRCA(430.2,$P(BN0,"^",16),0),"^"),1:$P($G(^PRCA(430.2,+CAT,0)),"^"))
 ....W ?16,CAT," BILL",?56,$P($G(^PRCA(430,+BN,0)),"^"),?69,$J(+PNODE,10,2)
 ....W !,?16,$P($G(^PRCA(430.3,+$P(BN0,"^",8),0)),"^")
 ...I TN S PNODE=^TMP("PRCAGT",$J,DEB,DATE,BN,TN) W !!,$$FMTE^XLFDT(DATE,"1D"),?16 S TYP=$P($G(^PRCA(433,+TN,1)),"^",2),TTYP=$P($G(^PRCA(430.3,+TYP,0)),U) W TTYP D
 ....S CAT=$P($G(^PRCA(430,+BN,0)),"^",2),CAT=$P($G(^PRCA(430.2,+CAT,0)),"^")
 ....S CATCARE=$P($G(^PRCA(430,+BN,0)),"^",16),CATCARE=$P($G(^PRCA(430.2,+$P(^(0),"^",16),0)),"^")
 ...I TN W ?56,$P($G(^PRCA(430,+BN,0)),"^") W:+TYP'=45 ?69,$J(+PNODE,10,2)
 ...I TN W !?16,CAT W:CATCARE]"" !,?16,CATCARE
 ...I TN,(+TYP=45) D
 ....I $D(^PRCA(433,+TN,5)) W !?16,$P(^(5),"^",2)
 ....I $O(^PRCA(433,+TN,7,0)) S TN0=0 F  S TN0=$O(^PRCA(433,+TN,7,TN0)) Q:'TN0  I $D(^(TN0,0)) S X=^(0) D  Q:$D(DIRUT)  D ^DIWW
 .....S DIWL=17,DIWF="C63W" D ^DIWP
 ...D SCRN
 ..Q
 .Q
 Q
 ;
SCRN ;Check for screen
 N X,Y K DIR I ($Y+5)>IOSL D
 .I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR Q:$D(DIRUT)
 .D HDR
 Q
 ;
HDR ;Heading for report
 S PG=PG+1
 W @IOF,!,?20,"Patient Transaction History Report",?70,"Page ",PG
 W !,?20,"-------------------------------------"
 W !!,?18,"For Patient: ",$$NAM^RCFN01(DEB),!,?25,"SSN : ",$$SSN^RCFN01(DEB)
 W !,?20,"For dates: ",$$FMTE^XLFDT(BDATE,"1D"),"-",$$FMTE^XLFDT(EDATE,"1D")
 W !!," DATE",?16,"ACTIVITY",?56,"BILL #",?73,"AMOUNT",!,LINE
