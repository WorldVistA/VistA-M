PSNOCLS ;BIR/CCH&WRT-Print report of drugs with no classification ;01/12/98   5:18 PM
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 W !!,"This report should be run after executing the menu option ""Merge National Drug",!,"File Data Into Local File"". It may be useful to print this report before and",!,"after executing the ""Allow Unmatched Drugs To Be Classed"" option."
 W " It gives you",!,"a hard copy of the drugs from your local drug file which are ""active"" and have",!
 W "no VA Drug Classification.",!,"You may queue the report to print, if you wish.",!
DVC K %ZIS,POP,IOP S %ZIS="QM",%ZIS("B")="",%ZIS("A")="Select Printer: " D ^%ZIS G:POP DONE W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" DVC I POP K IOP,POP,IO("Q") Q
QUEUE I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSNOCLS",ZTDESC="Local Drugs With No VA Class Report" D ^%ZTLOAD K ZTSK D ^%ZISC Q
ENQ ;ENTRY POINT WHEN QUEUED
 U IO
 S PSNPGCT=0,PSNPGLNG=IOSL-6,PSNPRT=0 D TITLE,LOOP
DONE I $D(PSNPRT) W:PSNPRT=0 !!?23,"No Drugs Found"
 W @IOF S:$D(ZTQUEUED) ZTREQ="@" K PSNB,BT,PSNPRT,PSNDEA,ZX,PSNMRK,MJT,PSNPGCT,PSNPGLNG,PSNOLD,Y,IOP,POP,IO("Q") D ^%ZISC
 Q
TITLE I $D(IOF),IOF]"" W @IOF S PSNPGCT=PSNPGCT+1
 W !,?23,"LOCAL DRUGS WITH NO VA CLASSIFICATION",!
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?55,"Page: ",PSNPGCT,!
 W !,"NUMBER",?10,"LOCAL DRUG GENERIC NAME",?67,"DEA",!
 F MJT=1:1:80 W "-"
 Q
LOOP F PSNB=0:0 S PSNB=$O(^PSDRUG(PSNB)) Q:'PSNB  I '$D(^PSDRUG(PSNB,"ND")),'$D(^PSDRUG(PSNB,"I")) D REPRT I PSNMRK=1 D WRTDEA
 Q
REPRT D:$Y>PSNPGLNG TITLE W !!,PSNB,?10,$P(^PSDRUG(PSNB,0),"^",1) S PSNPRT=1,PSNDEA=$P(^PSDRUG(PSNB,0),"^",3),PSNMRK=0 F ZX=1:1:$L(PSNDEA) S BT=$E(PSNDEA,ZX) I "0IM"[BT S PSNMRK=1
 Q
WRTDEA W ?67,$P(^PSDRUG(PSNB,0),"^",3)
 Q
