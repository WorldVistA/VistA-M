PSNSUPLY ;BIR/WRT-Print report of drugs with an "XA" classification- SORT BY CLASS CODE ;01/12/98   5:18 PM
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 W !!,"This report should be run if you have already classed your local drugs/items",!,"using Version 1.0 of NDF. After the installation of Version 2.0 of NDF and the",!,"VA DRUG CLASS file is re-installed, you may wish "
 W "to re-class your local items",!,"with an ""XA"" classification using the newly expanded ""XA000"" classification. It"
 W !,"gives you a hard copy of the items from your local drug file which are ""active"" and have an ""XA"" VA Drug Classification.",!,"You may queue the report to print, if you wish.",!
DVC K %ZIS,POP,IOP S %ZIS="QM",%ZIS("B")="",%ZIS("A")="Select Printer: " D ^%ZIS G:POP DONE W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" DVC I POP K IOP,POP,IO("Q") Q
QUEUE I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSNSUPLY",ZTDESC="Supply (XA000) VA Class Report" D ^%ZTLOAD K ZTSK D ^%ZISC Q
ENQ ;ENTRY POINT WHEN QUEUED
 U IO
 S PSNPGCT=0,PSNPGLNG=IOSL-6,PSNPRT=0 D TITLE,LOOP1
DONE I $D(PSNPRT) W:PSNPRT=0 !!?10,"No Entries Found"
 W @IOF S:$D(ZTQUEUED) ZTREQ="@" K PSNPRT,PSNB,CODE,NAME,CLSDA,WRT,MJT,PSNPGCT,PSNPGLNG,Y,IOP,POP,IO("Q") D ^%ZISC
 Q
TITLE I $D(IOF),IOF]"" W @IOF S PSNPGCT=PSNPGCT+1
 W !,?8,"LOCAL ITEMS WITH A ""PROSTHETICS/SUPPLIES/DEVICES"" VA CLASSIFICATION",!
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?55,"Page: ",PSNPGCT,!
 W !,"NUMBER",?10,"LOCAL DRUG GENERIC NAME",?57,"VA CLASS",?70,"NEW CLASS",!
 F MJT=1:1:80 W "-"
 Q
LOOP1 S NAME="" F WRT=0:0 S NAME=$O(^PSDRUG("B",NAME)) Q:NAME=""  S PSNB=$O(^PSDRUG("B",NAME,0)) D LOOP2
 Q
LOOP2 I '$D(^PSDRUG(PSNB,"I")),$D(^PSDRUG(PSNB,"ND")),$P(^PSDRUG(PSNB,"ND"),"^",2)']"" S CLSDA=$P(^PSDRUG(PSNB,"ND"),"^",6) I $D(^PS(50.605,CLSDA,0)) D STRIP
 Q
STRIP S CODE=$P(^PS(50.605,CLSDA,0),"^",1) I "XA"[$E(CODE,1,2) D REPRT
 Q
REPRT D:$Y>PSNPGLNG TITLE W !!,PSNB,?10,$P(^PSDRUG(PSNB,0),"^",1),?57,$P(^PS(50.605,$P(^PSDRUG(PSNB,"ND"),"^",6),0),"^",1),?70,"_______" S PSNPRT=1
 Q
