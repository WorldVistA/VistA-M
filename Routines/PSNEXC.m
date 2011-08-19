PSNEXC ;BIR/PTD&CCH&WRT-Report of attempted match drugs ;01/12/98   5:18 PM
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 W !!,"This report should be run after the menu option ""Verify Matches"" and",!,"before the menu option ""Merge National Drug File Data Into Local File""."
 W !,"It gives you a hard copy of the items from your local drug file for which",!,"a match was attempted, but no match was made from the National Drug File."
 W !,"You may queue the report to print, if you wish.",!
 S MJLT=0 I '$O(^PSNTRAN(MJLT)) W !,"No Data has been generated.",!,"The Match routine should be run before selecting this option.",! K MJLT Q
DVC K IO("Q"),%ZIS,POP,IOP S %ZIS="QM",%ZIS("B")="",%ZIS("A")="Select Printer: " D ^%ZIS G:POP DONE W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" DVC I POP K IOP,POP,IO("Q") Q
QUEUE I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSNEXC" S ZTDTH="" S ZTDESC="Report of Attempted Match Drugs" D ^%ZTLOAD K MJT,MJLT,%ZIS,POP,IOP,ZTSK D ^%ZISC Q
ENQ ;ENTRY POINT WHEN QUEUED
 U IO
 S PSNPGCT=0,PSNPGLNG=IOSL-6,PSNPRT=0 D TITLE,LOOP
DONE I $D(PSNPRT) W:PSNPRT=0 !!?23,"No Entries Found"
 W @IOF S:$D(ZTQUEUED) ZTREQ="@" K PSNB,MJLT,MJT,PSNPGCT,PSNPGLNG,PSNOLD,ZTRTN,Y,XYZ,VV,PSNPRT,PSNDEA,IOP,POP,IO("Q") D ^%ZISC
 Q
TITLE I $D(IOF),IOF]"" W @IOF S PSNPGCT=PSNPGCT+1
 W !,?32,"REPORT OF ATTEMPTED MATCH DRUGS",!
 S X="T" D ^%DT X ^DD("DD") W !,?55,"Date printed: ",Y,!,?55,"Page: ",PSNPGCT,!!
 W !,"LOCAL DRUG NAME",?42,"INACTIVE",?65,"DEA",!
 F MJT=1:1:80 W "-"
 Q
LOOP F PSNB=0:0 S PSNB=$O(^PSNTRAN(PSNB)) Q:'PSNB  D:$Y>PSNPGLNG TITLE I $D(^PSNTRAN(PSNB,0)),$P(^PSNTRAN(PSNB,0),"^",2)']"",$P(^PSNTRAN(PSNB,0),"^",8)]"" D LOOP1
 Q
LOOP1 S PSNOLD=$P(^PSDRUG(PSNB,0),"^") W !!,PSNOLD S PSNPRT=1 I $D(^PSDRUG(PSNB,"I")),$P(^PSDRUG(PSNB,"I"),"^",1)]"" S Y=$P(^PSDRUG(PSNB,"I"),"^",1) X ^DD("DD") W ?42,Y
 S PSNDEA=$P(^PSDRUG(PSNB,0),"^",3) F XYZ=1:1:$L(PSNDEA) S VV=$E(PSNDEA,XYZ) I "0IMS"[VV W ?65,$P(^PSDRUG(PSNB,0),"^",3) Q
 Q
