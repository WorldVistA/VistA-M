PSNONDF ;BIR/WRT-Print report of drugs with no match to NDF (all or only OP) ; 11/22/98 15:11
 ;;4.0; NATIONAL DRUG FILE;**3,5**; 30 Oct 98
 ;
 ; Reference to ^PSDRUG supported by IA# 221
 ;
 W !!,"This report should be run after executing the menu option ""Merge National Drug",!,"File Data Into Local File""."
 W " It gives you a hard copy of the drugs from your",!,"local DRUG file which are ""active"" and have"
 W " no match to NDF. You have the choice",!,"to print ALL drugs or only drugs marked for Outpatient use. If you answer ""yes"" to the question, you will print all. If you answer ""no"", you will print only",!,"Outpatient use drugs."
 W !,"You may queue the report to print, if you wish.",!
ASK S PSNOP=0,PSNFLAG=0 W !!,"Do you wish to print ALL drugs from your local file? " K DIR S DIR(0)="Y" D ^DIR D OUT I PSNFLAG=1 K PSNOP,PSNFLAG,X Q
 I "Nn"[X S PSNOP=1
DVC K %ZIS,POP,IOP S %ZIS="QM",%ZIS("B")="",%ZIS("A")="Select Printer: " D ^%ZIS G:POP DONE W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" DVC I POP K IOP,POP,IO("Q") Q
QUEUE I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSNONDF",ZTDESC="Local Drugs With No Match To NDF Report",ZTSAVE("PSNOP")="" D ^%ZTLOAD K ZTSK D ^%ZISC Q
ENQ ;ENTRY POINT WHEN QUEUED
 U IO
 S PSNPGCT=0,PSNPGLNG=IOSL-6,PSNPRT=0 D TITLE,LOOP
DONE I $D(PSNPRT) W:PSNPRT=0 !!?23,"No Drugs Found"
 W @IOF S:$D(ZTQUEUED) ZTREQ="@" K PSNB,PSNFLAG,PSNLCL,PSNMC,PSNOP,PSNUSE,PSNVCL,PSNPRT,MJT,PSNPGCT,PSNPGLNG,Y,DEA,DIR,INDT,X,IOP,POP,IO("Q") D ^%ZISC
 Q
TITLE I $D(IOF),IOF]"" W @IOF S PSNPGCT=PSNPGCT+1
 W !,?23,"LOCAL DRUGS WITH NO MATCH TO NDF",!
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?55,"Page: ",PSNPGCT,!
 W !?54,"DEA,",!?46,"MANUAL",?54,"SPCL",?61,"INACTIVE"
 W !,"LOCAL DRUG GENERIC NAME",?46,"CLASS",?54,"HDLG",?61,"DATE",!
 F MJT=1:1:80 W "-"
 Q
LOOP S PSNLCL="" F  S PSNLCL=$O(^PSDRUG("B",PSNLCL)) Q:PSNLCL=""  F PSNB=0:0 S PSNB=$O(^PSDRUG("B",PSNLCL,PSNB)) Q:'PSNB  D CHECK
 Q
CHECK I PSNOP=0 D NOTHG,MCLS
 I PSNOP=1 D OUTPAT
 Q
OUTPAT S PSNUSE=$G(^PSDRUG(PSNB,2)) I $P(PSNUSE,"^",3)["O" D NOTHG,MCLS
 Q
NOTHG I '$D(^PSDRUG(PSNB,"ND")) S PSNVCL="",DEA=$P(^PSDRUG(PSNB,0),"^",3),INDT=$G(^PSDRUG(PSNB,"I")) D REPRT
 Q
MCLS I $D(^PSDRUG(PSNB,"ND")) S PSNMC=^PSDRUG(PSNB,"ND") I $P(PSNMC,"^",2)']"" S PSNVCL=$P(^PSDRUG(PSNB,0),"^",2),DEA=$P(^PSDRUG(PSNB,0),"^",3),INDT=$G(^PSDRUG(PSNB,"I")) D REPRT
 Q
REPRT D:$Y>PSNPGLNG TITLE W !!,PSNLCL,?46,PSNVCL,?54,DEA I INDT]"" S Y=INDT D DD^%DT W ?61,Y
 S PSNPRT=1
 Q
OUT I $D(DTOUT),DTOUT=1 S PSNFLAG=1
 I X="^" S PSNFLAG=1
 Q
