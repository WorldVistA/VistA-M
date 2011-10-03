PSXOCMOP ;BIR/WRT-Print Report of Drugs with Not Marked for CMOP or Marked As "NO" ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 W !!,"This report should be run after executing the menu option ""Merge National Drug",!,"File Data Into Local File""."
 W " It gives you a hard copy of the Outpatient drugs",!,"from your local drug file which are ""active"" and have"
 W " not been marked at all OR ones marked as ""Do Not Transmit""."
 W !,"You may queue the report to print, if you wish.",!
DVC K %ZIS,POP,IOP S %ZIS="QM",%ZIS("B")="",%ZIS("A")="Select Printer: " D ^%ZIS G:POP DONE W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" DVC I POP K IOP,POP,IO("Q") Q
QUEUE I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSXOCMOP",ZTDESC="CMOP Local Drugs not Marked or Marked as NO Report",ZTSAVE("PSNOP")="" D ^%ZTLOAD K ZTSK D ^%ZISC Q
ENQ ;ENTRY POINT WHEN QUEUED
 U IO
 S PSNPGCT=0,PSNPGLNG=IOSL-6,PSNPRT=0 D TITLE,LOOP
DONE I $D(PSNPRT) W:PSNPRT=0 !!?23,"No Drugs Found"
 W @IOF S:$D(ZTQUEUED) ZTREQ="@" K PSNB,DU,PSNLCL,MESSG,PSNPRT,MJT,PSNPGCT,PSNPGLNG,Y,X,IOP,POP,IO("Q") D ^%ZISC
 Q
TITLE I $D(IOF),IOF]"" W @IOF S PSNPGCT=PSNPGCT+1
 W !,?7,"LOCAL OUTPATIENT DRUGS WHICH ARE NOT MARKED AT ALL OR MARKED AS ""DO NOT TRANSMIT""",!
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?55,"Page: ",PSNPGCT,!
 W !,"LOCAL DRUG GENERIC NAME",?50,"DISPENSE UNIT",!,?3,"QUANTITY DISPENSE MESSAGE",!
 F MJT=1:1:80 W "-"
 Q
LOOP S PSNLCL="" F  S PSNLCL=$O(^PSDRUG("B",PSNLCL)) Q:PSNLCL=""  F PSNB=0:0 S PSNB=$O(^PSDRUG("B",PSNLCL,PSNB)) Q:'PSNB  D OUTPAT
 Q
OUTPAT I '$D(^PSDRUG(PSNB,3)),'$D(^PSDRUG(PSNB,"I")),$D(^PSDRUG(PSNB,2)),$P(^PSDRUG(PSNB,2),"^",3)["O",$P(^PSDRUG(PSNB,0),"^",3)'["C",$D(^PSDRUG(PSNB,"ND")),$P(^PSDRUG(PSNB,"ND"),"^",2)]"" D NOTHG,REPRT
 I $D(^PSDRUG(PSNB,3)),$P(^PSDRUG(PSNB,3),"^",1)=0,'$D(^PSDRUG(PSNB,"I")),$D(^PSDRUG(PSNB,2)),$P(^PSDRUG(PSNB,2),"^",3)["O",$P(^PSDRUG(PSNB,0),"^",3)'["C",$D(^PSDRUG(PSNB,"ND")),$P(^PSDRUG(PSNB,"ND"),"^",2)]"" D NOTHG,REPRT
 Q
NOTHG S DU="" S:$D(^PSDRUG(PSNB,660)) DU=$P(^PSDRUG(PSNB,660),"^",8)
 S MESSG="" S:$D(^PSDRUG(PSNB,5)) MESSG=$P(^PSDRUG(PSNB,5),"^",1)
 Q
REPRT D:$Y>PSNPGLNG TITLE W !!,PSNLCL,?50,DU,!?3,MESSG
 S PSNPRT=1
 Q
