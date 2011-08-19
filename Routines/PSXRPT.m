PSXRPT ;BIR/WPB,HTW-Routine to Generate Reports at the CMOP Host Facility ;04/08/97  2:06 PM
 ;;2.0;CMOP;**38**;11 Apr 97
PRINT S FROM=$P($G(^PSX(552.1,REC,"P")),U,1),BB=$P($G(^PSX(552.1,REC,0)),U,1)
 S BAT=$P($G(BB),"-",2),RESP="",STA1=$P($G(BB),"-")
 ;I $G(STA1)]"" S X=STA1,DIC="4",DIC(0)="XMZO" S:$D(^PSX(552,"D",X)) X=$E(X,2,99) D ^DIC  S STA2=+Y,STATION=$P(Y,"^",2) K DIC,Y,X ;****DOD L1
 I $G(STA1)]"" S X=STA1,AGNCY="VASTANUM" S:$D(^PSX(552,"D",X)) X=$E(X,2,99),AGNCY="DMIS" S STA2=$$IEN^XUMF(4,AGNCY,X),STATION=$$NAME^XUAF4(STA2) K AGNCY,Y,X ;****DOD L1
 S ORDS=$P($G(^PSX(552.1,REC,1)),U,3),RXS=$P($G(^(1)),U,4)
 S SS=$P($G(^PSX(552.1,REC,0)),U,2)
 S STAT=$S(SS=2:"Queued",SS=3:"Processed",SS=4:"Closed",SS=5:"Hold",SS=6:"Printed",SS=99:"Rejected",1:"")
 S Y=RDTTM X ^DD("DD") S RDTTM=Y K Y S RDTTM=$P(RDTTM,":",1,2)
 W !,RDTTM,?19,FROM,?43,BB,?59,$J(ORDS,5),?68,$J(RXS,5),?75,$E(STAT,1,4) S LN=LN+1
 ;W !,RDTTM,?20,FROM,?44,BB,?54,$J(ORDS,5),?63,$J(RXS,5),?70,STAT S LN=LN+1
 I $G(IOST)["C-" D
 .Q:LN<22
 .I LN>21 S RESP="",LN=0,DIR(0)="E" D ^DIR S:(Y='1)!($D(DTOUT)) RESP="^" K DIR Q:Y'=1  K Y,X,DIRUT,DIROUT,DTOUT,DUOUT
 .S LN=0
 .W @IOF,!
 .W !,?29,"TRANSMISSIONS "_$S(RPT="Q":"QUEUED",RPT="P":"PROCESSED",RPT="C":"CLOSED",RPT="H":"ON HOLD",RPT="L":"PRINTED",1:"SUMMARY")
 .W !,?30,RDATE,!! S LN=LN+3
 .;W "RECEIVED",?20,"FROM",?44,"BATCH",?55,"TOTAL",?64,"TOTAL",?72,"STATUS",!
 .;W "DATE/TIME",?44,"NUMBER",?55,"ORDERS",?65,"RXS",!
 .W "RECEIVED",?19,"FROM",?43,"BATCH",?59,"TOTAL",?68,"TOTAL",?75,"STAT",!
 .W "DATE/TIME",?43,"NUMBER",?59,"ORDERS",?68,"RXS",!
 .S LL="-" F JJ=0:1:79 W LL
 .W ! S LN=LN+3
 I $G(IOST)'["C-"&(LN>60) D
 .S LN=0
 .W @IOF,!
 .W !,?29,"TRANSMISSIONS "_$S(RPT="Q":"QUEUED",RPT="P":"PROCESSED",RPT="C":"CLOSED",RPT="H":"ON HOLD",RPT="L":"PRINTED",1:"SUMMARY")
 .W !,?30,RDATE,!! S LN=LN+3
 .;W "RECEIVED",?20,"FROM",?44,"BATCH",?55,"TOTAL",?64,"TOTAL",?72,"STATUS",!
 .;W "DATE/TIME",?44,"NUMBER",?55,"ORDERS",?65,"RXS",!
 .W "RECEIVED",?19,"FROM",?43,"BATCH",?59,"TOTAL",?68,"TOTAL",?75,"STAT",!
 .W "DATE/TIME",?43,"NUMBER",?59,"ORDERS",?68,"RXS",!
 .S LL="-" F JJ=0:1:79 W LL
 .W ! S LN=LN+4
 Q:$G(RESP)="^"
 S NEXT=REC+1
 Q:'$D(^PSX(552.1,NEXT,0))
 Q
EXIT I '$G(POP) S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
EXIT1 W @IOF K RPT,XX,DATE,RDATE,Y,%,X,FROM,ORDS,RXS,BB,STAT,RESP,RDT,RDTTM,LL,BAT,REC,SS,SITE,JJ,LN,NEXT,STA1,STA2,STATION,COM,COM2,EE,END,ORD,REVD,SP,SP1,SP2,TBB,X1,XT,XY
 K ZTRTN,ZTIO,PSXLION,ZTDESC,ZTSAVE,ZTSK,%ZIS,DIR,DTOUT,DIROUT,DUOUT,DIRUT,^TMP($J,"PSXRPT")
 I $G(IOST)'["C-" W @IOF
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
QUE S ZTRTN="RPT^PSXRPT",ZTIO=PSXLION,ZTSAVE("RDT")="",ZTSAVE("RPT")="",ZTSAVE("END")="",ZTSAVE("TBB")="",ZTSAVE("ORD")="",ZTDESC="CMOP Transmission Report Summary" D ^%ZTLOAD
 I $D(ZTSK)[0 W !!,"Job Canceled"
 E  W !!,"Job Queued"
 D HOME^%ZIS
 Q
EN S DIR(0)="SOM^S:Summary;Q:Queued;P:Processed;C:Closed;H:Hold;L:Labels Printed"
 S DIR("A")="Select",DIR("B")="Q",DIR("??")="^D HELP^PSXRPT"
 D ^DIR K DIR S RPT=Y G:Y=0 EXIT1 G:$D(DIRUT) EXIT1
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 ;G:"HL"[RPT R1
 S DIR(0)="S^A:Ascending Order;D:Descending Order",DIR("B")="Ascending",DIR("??")="^D HELP1^PSXRPT"
 D ^DIR K DIR S ORD=Y Q:Y=""!($D(DIRUT))!($D(DUOUT))!($D(DIROUT))!($D(DTOUT))
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 I "SQPCHL"'[RPT Q
R1 I "SCPLHQ"[RPT D  G:$G(Y)<0 EXIT
 .S:"HL"[RPT ORD="A"
 .W !! S %DT="AEX",%DT("A")="Enter Begin Date for Report:  ",%DT(0)="-NOW",%DT("B")="TODAY" D ^%DT Q:Y<0!($D(DTOUT))  S TBB=Y,RDT=$$FMADD^XLFDT(TBB,-1,0,0,0)_".9999"
 .W ! S %DT("A")="Enter End Date for Report:  " D ^%DT K %DT Q:Y<0!($D(DTOUT))  S EE=Y,END=EE_".9999"
 .K %DT("A"),%DT("B"),%DT(0),Y,X,DTOUT
 .I TBB>EE W !,"Beginning date must be before ending date." G R1
DEV S %ZIS="Q" D ^%ZIS S PSXLION=ION G:$G(IOST)["C-"&('POP) RPT I POP W !,"NO DEVICE SELECTED" G EXIT
 I $D(IO("Q")) D QUE,EXIT1 Q
 I '$D(IO("Q")) G RPT
 Q
 ;Taskman entry point to start the transmission summary report
RPT D NOW^%DTC S Y=% X ^DD("DD") S DATE=Y,RDATE=$P(DATE,"@",1)_"  "_$E($P(DATE,"@",2),1,5),LN=0
 I '$D(ZTSK) U IO
 W @IOF
HDR S COM="TRANSMISSIONS "_$S(RPT="Q":"QUEUED",RPT="P":"PROCESSED",RPT="C":"CLOSED",RPT="H":"ON HOLD",RPT="L":"PRINTED",1:"SUMMARY"),COM2=$P($$FMTE^XLFDT(TBB,"2S"),"@",1)_" THRU "_$P($$FMTE^XLFDT(END,"2S"),"@",1)
 S SP2=(80-$L(COM2))/2,SP=(80-$L(COM))/2,SP1=(80-$L(RDATE))/2
 W !,?SP,COM,!,?SP2,COM2,!! S LN=LN+4
 ;W !,?SP1,RDATE,!! S LN=LN+5
 W "RECEIVED",?19,"FROM",?43,"BATCH",?59,"TOTAL",?68,"TOTAL",?75,"STAT",!
 W "DATE/TIME",?43,"NUMBER",?59,"ORDERS",?68,"RXS",!
 ;W "RECEIVED",?20,"FROM",?44,"BATCH",?55,"TOTAL",?64,"TOTAL",?72,"STATUS",!
 ;W "DATE/TIME",?44,"NUMBER",?55,"ORDERS",?65,"RXS",!
 S LL="-" F JJ=0:1:79 W LL
 W ! S LN=LN+2
 I $G(ORD)="D" G DESC
 I (RPT="S")!(RPT="C")!(RPT="Q")!(RPT="P") G DATA
 I RPT="H"!(RPT="L") G QDATA
 W !!
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Another report" D ^DIR K DIR G:Y=1 EN
 G EXIT1
 Q
DATA S XX=$S(RPT="Q":"AQ",RPT="S":"AR",RPT="C":"AC",RPT="P":"AP",1:"")
 S XT=0,XY=RDT F  S XY=$O(^PSX(552.1,XX,XY)) Q:XY=""!(XY>END)  S XT=XT+1
 I '$D(^PSX(552.1,XX))!($G(XT)'>0) W !!,"No data for the report." G EXIT
 ;S RDT="" F  S RDT=$O(^PSX(552.1,XX,RDT)) Q:(RDT="")  S SITE="" F  S SITE=$O(^PSX(552.1,XX,RDT,SITE)) Q:'SITE  F REC=0:0 S REC=$O(^PSX(552.1,XX,RDT,SITE,REC)) Q:REC'>0  S RDTTM=RDT K Y D PRINT G:RESP="^" EXIT1
 F  S RDT=$O(^PSX(552.1,XX,RDT)) Q:(RDT="")!(RDT>END)  S SITE="" F  S SITE=$O(^PSX(552.1,XX,RDT,SITE)) Q:'SITE  F REC=0:0 S REC=$O(^PSX(552.1,XX,RDT,SITE,REC)) Q:REC'>0  S RDTTM=RDT K Y D PRINT G:RESP="^" EXIT1
 G:$G(IOST)'["C-" EXIT1
 G EXIT
QDATA S XX=$S(RPT="H":"AH",RPT="L":"AE",1:"")
 I '$D(^PSX(552.1,XX)) W !!,"No data for the report." G EXIT
 S SITE="" F  S SITE=$O(^PSX(552.1,XX,SITE)) Q:'SITE  F REC=0:0 S REC=$O(^PSX(552.1,XX,SITE,REC)) Q:REC'>0  S RDTTM=$P($G(^PSX(552.1,REC,0)),U,4) Q:RDTTM<TBB!(RDTTM>END)  D PRINT G:RESP="^" EXIT1
 G:$G(IOST)'["C-" EXIT1
 G EXIT
DESC S XX=$S(RPT="Q":"AQ",RPT="S":"AR",RPT="C":"AC",RPT="P":"AP",1:"")
 S XT=0,XY=RDT F  S XY=$O(^PSX(552.1,XX,XY)) Q:XY=""!(XY>END)  S XT=XT+1
 I '$D(^PSX(552.1,XX))!($G(XT)'>0) W !!,"No data for the report." G EXIT
 F  S RDT=$O(^PSX(552.1,XX,RDT)) Q:(RDT="")!(RDT>END)  S SITE="" F  S SITE=$O(^PSX(552.1,XX,RDT,SITE)) Q:'SITE  F REC=0:0 S REC=$O(^PSX(552.1,XX,RDT,SITE,REC)) Q:REC'>0  S REVD=9999999.9999-RDT,^TMP($J,"PSXRPT",REVD,REC)=""
 D DESC1
 Q
DESC1 S X1="" F  S X1=$O(^TMP($J,"PSXRPT",X1)) Q:X1=""  S REC=0 F  S REC=$O(^TMP($J,"PSXRPT",X1,REC)) Q:REC'>0  S RDTTM=$P(^PSX(552.1,REC,0),"^",4) K Y D PRINT G:RESP="^" EXIT1
 K X1,Y1
 G:$G(IOST)'["C-" EXIT1
 G EXIT
HELP W !!,"S - Provides a report of all transmissions received for the date range entered."
 W !,"Q - Provides a report of all transmissions that are queued to download to the",!,"vendor for the date range entered."
 W !,"P - Provides a report of all transmissions that are processed for the date range",!,"entered."
 W !,"C - Provides a report of all transmissions that are closed for the date range",!,"entered."
 W !,"H - Provides a report of all transmissions that are on hold status for the date range entered."
 W !,"L - Provides a report of all transmissions that were printed for the date range entered."
 Q
HELP1 W !!,"Ascending order will order data starting with the earliest date.",!,"Descending order will order the data starting the latest date."
 Q
