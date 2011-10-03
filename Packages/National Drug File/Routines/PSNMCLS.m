PSNMCLS ;BIR/WRT-Print report of drugs manually classed (excluding supply items) SORT BY LOCAL GENERIC NAME ;01/12/98   5:18 PM
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 W !!,"This report will give you an alphabetic listing, by local generic name, of the",!,"drugs from your local drug file which are ""active"" and have been assigned a",!
 W "manual VA Drug Classification through the option ""Allow Unmatched Drugs To Be",!,"Classed"". This report will exclude your supply items that have been assigned",!,"an ""XA"" class."
 W !,"You may queue the report to print, if you wish.",!
DVC K %ZIS,POP,IOP S %ZIS="QM",%ZIS("B")="",%ZIS("A")="Select Printer: " D ^%ZIS G:POP DONE W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" DVC I POP K IOP,POP,IO("Q") Q
QUEUE I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSNMCLS",ZTDESC="Manually Classed Drugs Report" D ^%ZTLOAD K ZTSK D ^%ZISC Q
ENQ ;ENTRY POINT WHEN QUEUED
 U IO
 S PSNPGCT=0,PSNPGLNG=IOSL-6,PSNPRT=0 D TITLE,LOOP1
DONE I $D(PSNPRT) W:PSNPRT=0 !!?23,"No Drugs Found"
 W @IOF S:$D(ZTQUEUED) ZTREQ="@" K PSNPRT,PSNB,NAME,CLSDA,WRT,CODE,MJT,PSNPGCT,PSNPGLNG,Y,IOP,POP,IO("Q") D ^%ZISC
 Q
TITLE I $D(IOF),IOF]"" W @IOF S PSNPGCT=PSNPGCT+1
 W !,?23,"MANUALLY CLASSED DRUGS REPORT",!
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?55,"Page: ",PSNPGCT,!
 W !,"NUMBER",?10,"LOCAL DRUG GENERIC NAME",?63,"VA DRUG CLASS",!
 F MJT=1:1:80 W "-"
 Q
LOOP1 S NAME="" F WRT=0:0 S NAME=$O(^PSDRUG("B",NAME)) Q:NAME=""  F PSNB=0:0 S PSNB=$O(^PSDRUG("B",NAME,PSNB)) Q:'PSNB  D LOOP2
 Q
LOOP2 I '$D(^PSDRUG(PSNB,"I")),$D(^PSDRUG(PSNB,"ND")),$P(^PSDRUG(PSNB,"ND"),"^",2)']"" S CLSDA=$P(^PSDRUG(PSNB,"ND"),"^",6) I $D(^PS(50.605,CLSDA,0)) D STRIP
 Q
STRIP S CODE=$P(^PS(50.605,CLSDA,0),"^",1) I "XA"'[$E(CODE,1,2) D REPRT
 Q
REPRT D:$Y>PSNPGLNG TITLE W !!,PSNB,?10,$P(^PSDRUG(PSNB,0),"^",1),?63,$P(^PS(50.605,$P(^PSDRUG(PSNB,"ND"),"^",6),0),"^",1) S PSNPRT=1
 Q
