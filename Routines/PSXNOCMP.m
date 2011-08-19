PSXNOCMP ;BIR/WRT,HTW-Outpatient drugs not marked to send to CMOP ;[ 10/19/98  8:50 AM ]
 ;;2.0;CMOP;**18,19,23**;11 Apr 97
 ;Reference to ^PSDRUG(  supported by DBIA #1983, #2367
 W !!,"This report will print all drugs marked for Outpatient use which are non-",!,"controlled substances and are not marked to transmit to CMOP.",!
 W "This report requires 132 columns."
 W !,"You may queue the report to print, if you wish.",!!
DVC K IO("Q"),IOP,POP,%ZIS S %ZIS="QM",%ZIS("B")="" D ^%ZIS G:POP DONE W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" DVC I POP K IOP,POP,IO("Q") Q
QUEUE I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSXNOCMP" S ZTDTH="" S ZTDESC="Outpatient Drugs Not Marked to Send To CMOP Report" D ^%ZTLOAD K MJLT,MJT,%ZIS,POP,IOP,ZTSK D ^%ZISC Q
ENQ ;Called by Taskman to print all drugs marked for OP but not CMOP
 U IO
 S PSXPGCT=0,PSXPGLNG=IOSL-6 D TITLE,LOOPA
DONE W @IOF S:$D(ZTQUEUED) ZTREQ="@" K PSXB,MJLT,MJT,IOP,POP,IO("Q"),PSXAM,PSXCMOP,PSXDN,PSXGN,PSXSTAT,PSXPGCT,PSXPGLNG,Y,PSXVAP,PSXVP,X D ^%ZISC
 Q
TITLE I $D(IOF),IOF]"" W @IOF S PSXPGCT=PSXPGCT+1
 W !,?33,"OUTPATIENT DRUGS NOT MARKED TO SEND TO CMOP"
 S X="T" D ^%DT X ^DD("DD") W !,?100,"Date printed: ",Y,!?100,"Page: ",PSXPGCT,!
 W !,"LOCAL DRUG NAME",?54,"STATUS",?75,"VA PRINT NAME",!
 F MJT=1:1:132 W "-"
 Q
LOOPA S PSXAM="" F  S PSXAM=$O(^PSDRUG("B",PSXAM)) Q:PSXAM=""  D LOOP
 Q
LOOP F PSXB=0:0 S PSXB=$O(^PSDRUG("B",PSXAM,PSXB)) Q:'PSXB  I '$D(^PSDRUG(PSXB,"I")),$D(^PSDRUG(PSXB,2)),$P(^PSDRUG(PSXB,2),"^",3)["O",$D(^PSDRUG(PSXB,"ND")),$P(^PSDRUG(PSXB,"ND"),"^",2)]"" D LOOP2
 Q
LOOP2 K CS S CS=$P($G(^PSDRUG(PSXB,0)),"^",3) I $G(CS)[1!$G(CS)[2 K CS Q  ; Patch 23
 S PSXDN=^PSDRUG(PSXB,"ND"),PSXGN=$P(PSXDN,"^",1),PSXVP=$P(PSXDN,"^",3)
 S PSXCMOP=$$PROD2^PSNAPIS(PSXGN,PSXVP)
 I $P($G(PSXCMOP),"^",3)=1 S PSXVAP=$P(PSXCMOP,"^") D STAT
 Q
STAT  I '$D(^PSDRUG("AQ",PSXB)) D STAT1
 Q
STAT1 I '$D(^PSDRUG(PSXB,3)) S PSXSTAT="NOT MARKED" D WRITE
 I $D(^PSDRUG(PSXB,3)),$P(^PSDRUG(PSXB,3),"^",1)=0 S PSXSTAT="DO NOT SEND" D WRITE
 I $D(^PSDRUG(PSXB,3)),$P(^PSDRUG(PSXB,3),"^",1)="" S PSXSTAT="NOT MARKED" D WRITE
 Q
WRITE D:$Y>PSXPGLNG TITLE
 W !,PSXAM,?54,PSXSTAT,?75,PSXVAP,!
 Q
