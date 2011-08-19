PSXSMRY ;BIR/BAB-CMOP Summary by Date ;04/08/97 2:06 PM
 ;;2.0;CMOP;**32,38**;11 Apr 97
 ;Reference to file #4 supported by DBIA #10090
 ;This routine will provide a summary report for a selected date range
 ;All Data Received,Processed,Query summary and Released
STRT K ^TMP($J,"PSXSUM")
 S %DT="AEX",%DT("A")="Enter to BEGIN SUMMARY: ",%DT(0)="-DT",%DT("B")="TODAY" D ^%DT K %DT("A") G:Y<0!($D(DTOUT)) EX1
 S START=Y,ST=Y-.0001
 S %DT("A")="Enter date to END SUMMARY:  ",%DT(0)="-DT",%DT("B")="TODAY" D ^%DT K %DT G:Y<0!($D(DTOUT)) EX1
 S (END,LAST)=Y I '(LAST#1) S LAST=Y+.9999
 I END<START W !,"Ending date must follow starting date!" G STRT
 S DIC=552,DIC(0)="AEQMZ",DIC("A")="Select FACILITY or RETURN for all:  "
 D ^DIC K DIC I $D(DUOUT)!($D(DTOUT))!(X["^") G EX1
 S:$G(Y)'>0 ALL=1,FAC1=0 G:$G(Y)'>0 DEV
 I Y>0 S FAC1=$$GET1^DIQ(552,+Y,5)
 I FAC1'>0 S XX=$P(Y,U,2)_",",FAC1=$$GET1^DIQ(4,XX,99) ;getting site/div num
 ;S:+Y>0 XX=$P(Y,"^",2) N X,Y S X=XX,DIC="4",DIC(0)="MOXZ" S:$D(^PSX(552,"D",X)) X=$E(X,2,99) D ^DIC S FAC1=+Y K DIC ;****DOD L1
 ;S:+Y>0 XX=$P(Y,"^",2) N X,Y S X=XX,AGNCY="VASTANUM" S:$D(^PSX(552,"D",X)) X=$E(X,2,99),AGNCY="DMIS" S FAC1=$$IEN^XUMF(4,AGNCY,X) K DIC,AGNCY ;****DOD L1
 ;S:$G(Y)'>0 FAC1=0  K Y,X,DIC,DUOUT,DTOUT
 K Y,X,DIC,DUOUT,DTOUT
DEV S %ZIS="Q" D ^%ZIS S PGL=($G(IOSL)-2) I POP W !,"No Device Selected!" G EX1
 I $D(IO("Q")) D QUE Q
 ;Called by Taskman to produce CMOP summary report
EN ;
 U IO S XXC=0
 F  S ST=$O(^PSX(552.1,"AR",ST)) Q:(ST>LAST)!(ST="")  S:FAC1'>0 BF="" S:FAC1>0 BF=FAC1_"-"_0 D
 . F  S BF=$O(^PSX(552.1,"AR",ST,BF)) Q:'BF  D
 .. S REC=0 F  S REC=$O(^PSX(552.1,"AR",ST,BF,REC)) Q:'REC  D TRN
TOTALS ;
 Q:$G(STOP)=1
 S Y=START X ^DD("DD")  S START=Y S Y=END X ^DD("DD") S END=Y
 S HDATE="For "_START_" thru "_END,SP1=(80-$L(HDATE))/2
 I '$D(^TMP($J,"PSXSUM")) W !,"No data for the report!" D PGBK G EX2
 S S="" F  S S=$O(^TMP($J,"PSXSUM",S)) Q:S=""!($G(STOP)=1)  D:$G(XXC)>0 PGBK D OUT,OUT1
 K ^TMP($J,"PSXSUM")
 G:$G(STOP)>0 EX1 G EXIT
OUT ;
 Q:$G(STOP)=1
 S SNAME="For "_$G(S),SP=(80-$L(SNAME))/2
 S (TOR,TRX,TCO,TCA,TUN)=0
 S F=0 F  S F=$O(^TMP($J,"PSXSUM",S,F)) Q:'F  S B=0 F  S B=$O(^TMP($J,"PSXSUM",S,F,B)) Q:'B  S TOR=TOR+$P(^(B),U),TRX=TRX+$P(^(B),U,2),TCO=TCO+$P(^(B),U,4),TCA=TCA+$P(^(B),U,5),TUN=TUN+$P(^(B),U,6)
 Q
OUT1 ;
 Q:$G(STOP)=1
 D HDR
 S F=0 F  S F=$O(^TMP($J,"PSXSUM",S,F)) Q:'F  Q:$G(STOP)>0  S B=0  F  S B=$O(^TMP($J,"PSXSUM",S,F,B)) Q:'B  S NODE=$G(^TMP($J,"PSXSUM",S,F,B)) D PRT
 G GT
HDR ;S Y=START X ^DD("DD")  S START=Y S Y=END X ^DD("DD") S END=Y,LCNT=0
 S LCNT=0
 W @IOF,!!,?13,"CONSOLIDATED MAIL OUTPATIENT PHARMACY ACTIVITY SUMMARY"
 ;W !,?23,"From "_START_" thru "_END
 W !,?SP1,HDATE
 W !,?SP,$G(SNAME),!!
 ;W !,"TRANS #",?12,"DIVISION",?30,"PROC",?36,"ORDERS",?46,"RXS",?53,"RELEASED",?63,"NOT DISP",?74,"UNREL"
 W !,?66,$J("NOT",6)
 W !,"TRANS #",?18,"DIVISION",?36,$J("PROC",4),?42,$J("ORDERS",6),?50,$J("RXS",6),?58,$J("REL",6)
 W ?66,$J("DISP",6),?74,$J("UNREL",6)
 W ! F X=0:1:79 W "-"
 S LCNT=8
PRT ;
 Q:$G(NODE)=""!($G(STOP)=1)
 S XXC=1,STOP=0
 ;W !,$J((F_"-"_B),10),?12,$E($P(NODE,"^",7),1,16),?30,$J($S($P(NODE,U,3)=0:"NO",1:"YES"),4)
 ;W ?37,$J($P(NODE,U),5),?43,$J($P(NODE,U,2),6),?55,$J($P(NODE,U,4),6),?65,$J($P(NODE,U,5),6),?73,$J($P(NODE,U,6),6)
 ;W !,"TRANS #",?18,"DIVISION",?36,$J("PROC",6),?42,$J("ORDERS",6),?50,$J("RXS",6),?58,$J("REL",6)
 W !,$J((F_"-"_B),15),?18,$E($P(NODE,"^",7),1,16),?36,$J($S($P(NODE,U,3)=0:"NO",1:"YES"),4)
 W ?42,$J($P(NODE,U),6),?50,$J($P(NODE,U,2),6),?58,$J($P(NODE,U,4),6),?66,$J($P(NODE,U,5),6),?74,$J($P(NODE,U,6),6)
 S LCNT=LCNT+1,GRX=$G(GRX)+$P(NODE,U,2),GCOM=$G(GCOM)+$P(NODE,U,4),GORD=$G(GORD)+$P(NODE,"^"),GND=$G(GND)+$P(NODE,"^",5),GUNREL=$G(GUNREL)+$P(NODE,"^",6)
 K NODE
 I $G(IOST)["C-" D
 .I LCNT>$G(PGL) S DIR(0)="E" D ^DIR K DIR S:$G(Y)=0 STOP=1 Q:$G(STOP)>0
 .G:LCNT>$G(PGL) HDR
 I $G(IOST)'["C-" G:LCNT>$G(PGL) HDR
 Q
GT ;
 Q:$G(STOP)>0
 W ! F I=0:1:79 W "-"
 ;W ?42,$J($P(NODE,U),6),?50,$J($P(NODE,U,2),6),?58,$J($P(NODE,U,4),6),?66,$J($P(NODE,U,5),6),?74,$J($P(NODE,U,6),6)
 W !!,"TOTAL",?42,$J(TOR,6),?50,$J(TRX,6),?58,$J(TCO,6),?66,$J(TCA,6),?74,$J(TUN,6)
 Q
TRN ;
 Q:($P(^PSX(552.1,REC,0),U,2)=99)!($P(^(0),U,2)=5)
 I $G(FAC1)>0 Q:($P(^PSX(552.1,REC,0),"-")'[$G(FAC1))
 ;S BAT=+$P(BF,"-",2),(X,FAC)=+BF,DIC="4",DIC(0)="MOXZ" D ^DIC S SNO=+Y,SITE=$P(Y,"^",2) S:SITE']"" SITE="UNKNOWN"
 S AGNCY="VASTANUM"
 S BAT=+$P(BF,"-",2),(X,FAC)=+BF S:$D(^PSX(552,"D",X)) X=$E(X,2,99),AGNCY="DMIS"
 S Y=$$IEN^XUMF(4,AGNCY,X) S SNO=+Y,SITE=$$GET1^DIQ(4,Y,.01) S:SITE']"" SITE="UNKNOWN"
 S ORD=$P(^PSX(552.1,REC,1),U,3),RXS=$P(^PSX(552.1,REC,1),U,4)
 S PROC=$S(+$P(^PSX(552.1,REC,0),U,6):1,1:0),DIV=$P(^PSX(552.1,REC,"P"),"^")
 S MST=$O(^PSX(552.4,"B",REC,0)) Q:'MST
 S (RX,CA,CO,UN)=0 F  S RX=$O(^PSX(552.4,MST,1,RX)) Q:'RX  S RST=+$P(^PSX(552.4,MST,1,RX,0),U,2) S:RST=0 UN=UN+1 S:RST=1 CO=CO+1 S:RST=2 CA=CA+1
 S ^TMP($J,"PSXSUM",SITE,FAC,BAT)=ORD_U_RXS_U_+$G(PROC)_U_CO_U_CA_U_UN_U_DIV
 K ORD,RXS,PROC,CO,CA,UN,RST,RX,MST Q
PGBK I $G(IOST)["C-" S DIR(0)="E" D ^DIR S:$G(Y)=0 STOP=1 K DIR
 Q
 W @IOF Q
EXIT I $G(ALL) W !!,"GRAND TOTAL",?42,$J(GORD,6),?50,$J(GRX,6),?58,$J(GCOM,6),?66,$J(GND,6),?74,$J(GUNREL,6) D PGBK
EX2 I '$G(ALL) D PGBK
 ;W !!,"TOTAL RX's: ",$G(GRAND),?30,"TOTAL COMP: ",$G(GCOM) D PGBK
EX1 K TCO,TCA,TRX,TUN,BAT,BF,F,FAC,TOR,SITE,ST,SNO,LAST,REC,X,Y,B,END,S,START,ZTDESC,ZTDTH,ZTRTN,ZTSK,ZTSAVE,%ZIS,DTOUT,%DT,I,DIROUT,DIRUT,DTOUT,DUOUT,DIR,LCNT,NODE
 K GRX,GCOM,GORD,GND,GUNREL,ALL,HDATE,SNAME,SP,SP1,FAC1,XX,XC,XXC,STOP
 W @IOF
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC K:$D(IO("Q")) IO("Q")
 Q
QUE I $D(IO("Q")) S ZTRTN="EN^PSXSMRY",ZTDESC="CMOP Activity Summary",ZTDTH="",ZTSAVE("START")="",ZTSAVE("ST")="",ZTSAVE("END")="",ZTSAVE("LAST")="",ZTSAVE("FAC1")="",ZTSAVE("PGL")=""
 S ZTSAVE("GRX")="",ZTSAVE("GCOM")="",ZTSAVE("GORD")="",ZTSAVE("GND")="",ZTSAVE("GUNREL")="",ZTSAVE("ALL")=""
 K IO("Q") D ^%ZTLOAD I $D(ZTSK)[0 W !,"Job cancelled!"
 E  W !,"REPORT Queued!"
 G EX2
