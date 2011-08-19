PSAPV ;BIR/JMB-Processor and Verifier ;9/6/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine prints the order number, invoice number, invoice date,
 ;processor's name, process date, verifier's name, and verification
 ;date for a specified invoice date range.
 ;
 I '$D(^XUSEC("PSA ORDERS",DUZ)) W !,"You do not hold the key to enter the option." Q
 I '$O(^PSD(58.811,"ADATE",0)) W !,"There are no invoices." G EXIT
 S PSAOUT=0 D BDATE G:PSAOUT EXIT
DEVICE ;Asks device & queueing info
 W !!,"The report must be sent to a printer that supports 132 columns.",!
DEV K IO("Q"),%ZIS,IOP,POP S %ZIS="Q",%ZIS("B")="",IOM=132
 D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 ;I $E(IOST)["C"!($G(IOM)<132) W !,"The printout must be sent to a 132 column printer!",! G DEV
 I $D(IO("Q")) D  G EXIT
 .N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK
 .S ZTRTN="COMPILE^PSAPV",ZTDESC="Drug Acct. - Processor and Verifier Report"
 .S:$D(PSABEG) ZTSAVE("PSABEG")="" S:$D(PSAEND) ZTSAVE("PSAEND")=""
 .D ^%ZTLOAD
 ;
COMPILE ;Compiles data
 S PSAOUT=0,X1=PSABEG,X2=-1 D C^%DTC S PSADATE=X_.239999
 F  S PSADATE=+$O(^PSD(58.811,"ADATE",PSADATE)) Q:'PSADATE!(PSADATE>PSAEND)!(PSAOUT)  D
 .S PSAIEN=0 F  S PSAIEN=+$O(^PSD(58.811,"ADATE",PSADATE,PSAIEN)) Q:'PSAIEN!(PSAOUT)  D
 ..Q:'$D(^PSD(58.811,PSAIEN,0))  S PSAORD=$P(^PSD(58.811,PSAIEN,0),"^"),PSAIEN1=0
 ..F  S PSAIEN1=+$O(^PSD(58.811,"ADATE",PSADATE,PSAIEN,PSAIEN1)) Q:'PSAIEN1!(PSAOUT)  D
 ...Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,0))
 ...S PSAIN=^PSD(58.811,PSAIEN,1,PSAIEN1,0),PSAINV=$P(PSAIN,"^"),PSAINVDT=$P(PSAIN,"^",2),PSAPROC=+$P(PSAIN,"^",10),PSAVER=+$P(PSAIN,"^",11)
 ...S PSAPROC=$S($P($G(^VA(200,PSAPROC,0)),"^")'="":$P($G(^VA(200,PSAPROC,0)),"^"),1:"")
 ...S PSAVER=$S($P($G(^VA(200,PSAVER,0)),"^")'="":$P($G(^VA(200,PSAVER,0)),"^"),1:"")
 ...S (PSALINE,PSAPROCD,PSAVERD)=0
 ...Q:PSAPROC=""&(PSAVER="")
 ...F  S PSALINE=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE)) Q:'PSALINE!(PSAOUT)  D
 ....Q:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0))
 ....S PSADATA=^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,0) S:PSAPROCD<$P(PSADATA,"^",6) PSAPROCD=$P(PSADATA,"^",6) S:PSAVERD<$P(PSADATA,"^",8) PSAVERD=$P(PSADATA,"^",8)
 ..S PSAINVDT=$S(+PSAINVDT:$E(PSAINVDT,4,5)_"/"_$E(PSAINVDT,6,7)_"/"_$E(PSAINVDT,2,3),1:"UNKNOWN")
 ..S PSAPROCD=$S(+PSAPROCD&(PSAPROC'=""):$E(PSAPROCD,4,5)_"/"_$E(PSAPROCD,6,7)_"/"_$E(PSAPROCD,2,3),1:"")
 ..S PSAVERD=$S(+PSAVERD&(PSAVER'=""):$E(PSAVERD,4,5)_"/"_$E(PSAVERD,6,7)_"/"_$E(PSAVERD,2,3),1:"")
 ..S ^TMP("PSAPVR",$J,PSAORD,PSAINV)=PSAINVDT_"^"_PSAPROC_"^"_PSAPROCD_"^"_PSAVER_"^"_PSAVERD
 ;
PRINT ;Print data
 S Y=PSAEND D DD^%DT S PSAENDX=Y K X,Y,%DT
 S Y=PSABEG D DD^%DT S PSABEGX=Y K X,Y,%DT
 D NOW^%DTC S PSARUN=%,PSARUN=$E(PSARUN,4,5)_"/"_$E(PSARUN,6,7)_"/"_$E(PSARUN,2,3)_"@"_$E($P(PSARUN,".",2),1,2)_":"_$E($P(PSARUN,".",2),3,4)
 S PSAPG=0,PSASLN="",$P(PSASLN,"-",123)="" K Y D HDR
 S PSAORD="" F  S PSAORD=$O(^TMP("PSAPVR",$J,PSAORD)) Q:PSAORD=""  D
 .I $Y+4>IOSL D HDR
 .W !,"Order #: "_PSAORD,?24,"|",?36,"|",?68,"|",?80,"|",?112,"|"
 .S PSAINV="" F  S PSAINV=$O(^TMP("PSAPVR",$J,PSAORD,PSAINV)) Q:PSAINV=""  D
 ..S PSADATA=^TMP("PSAPVR",$J,PSAORD,PSAINV),PSAINVDT=$P(PSADATA,"^"),PSAPROC=$P(PSADATA,"^",2),PSAPROCD=$P(PSADATA,"^",3),PSAVER=$P(PSADATA,"^",4),PSAVERD=$P(PSADATA,"^",5)
 ..W !,PSAINV,?24,"|",?26,PSAINVDT,?36,"|",?38,PSAPROC,?68,"|",?70,PSAPROCD,?80,"|",?82,PSAVER,?112,"|",?114,PSAVERD
 .W !,"                        |           |                               |           |                               |"
 W !,PSASLN,!
 ;
EXIT W @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q"),^TMP("PSAPVR",$J)
 K %,%ZIS,DTOUT,PSABEG,PSABEG,PSABEGX,PSADATA,PSADATE,PSAEND,PSAENDX,PSAIEN,PSAIEN1,PSAIN,PSAINV,PSAINVDT
 K PSALINE,PSAORD,PSAOUT,PSAPG,PSAPROC,PSAPROCD,PSARUN,PSASLN,PSAVER,PSAVERD,X,X1,X2,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
BDATE ;Gets beginning and ending invoice dates
 W ! S %DT="AEP",%DT("A")="Beginning Date: " D ^%DT
 I +Y<1!($D(DTOUT))!(X["^")!(X']"") S PSAOUT=1 Q
 I Y>DT K X,Y,%DT W !!,"Future dates are not permitted.",! K X,Y,%DT G BDATE
 S PSABEG=+Y
EDATE W ! S %DT="AE",%DT("A")="Ending Date   : " D ^%DT
 I +Y<1!($D(DTOUT))!(X["^")!(X']"") S PSAOUT=1 Q
 I Y<PSABEG K X,Y,%DT W !!,"Ending Date cannot be before the Start Date.",! K X,Y,%DT G EDATE
 S PSAEND=+Y
 Q
 ;
HDR ;Report header
 I $E(IOST)'="C",PSAPG W !,PSASLN,@IOF
 S PSAPG=PSAPG+1
 W !?46,"DRUG ACCOUNTABILITY/INVENTORY INTERFACE",?114,"PAGE "_PSAPG,!?51,"PROCESSOR AND VERIFIER REPORT"
 I $E(IOST,1,2)="C-" W !,"RUN DATE: "_PSARUN,?52,PSABEGX_" - "_PSAENDX
 E  W !,?52,PSABEGX_" - "_PSAENDX
 W !!?24,"|  INVOICE",?36,"|",?68,"|   DATE",?80,"|",?112,"|   DATE"
 W !,"INVOICE#",?24,"|   DATE",?36,"| PROCESSOR",?68,"| PROCESSED",?80,"| VERIFIER",?112,"| VERIFIED"
 W !,"========================|===========|===============================|===========|===============================|========="
 Q
