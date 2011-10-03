PSNPFN ;BIR/WRT-va product name report of matches made ; 10/31/98 19:21
 ;;4.0; NATIONAL DRUG FILE;**2**; 30 Oct 98
 W !!!,"This report can be run before and/or after the menu option ""Verify Matches"".",!,"It should be run before the menu option ""Merge National Drug File Data Into",!,"Local File"". This "
 W "report may also be run after the auto-match process to review",!,"what was matched. "
 W "It generates a hard copy of the matches selected in the menu",!,"option ""Automatic Match of Unmatched Drugs"" and the menu option ""Verify",!,"Matches"". This report requires 132 columns."
 W !,"You may queue the report to print, if you wish.",!
 S MJLT=0 I '$O(^PSNTRAN(MJLT)) W !,"No data has been generated.",!,"The ""Automatic Match of Unmatched Drugs"" should be run before selecting",!,"this option." K MJLT Q
DVC K IO("Q"),IOP,POP,%ZIS S %ZIS="QM",%ZIS("B")="",%ZIS("A")="Select Printer: " D ^%ZIS G:POP DONE W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" DVC I POP K IOP,POP,IO("Q") Q
QUEUE I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSNPFN" S ZTDTH="" S ZTDESC="VA Product Names Matched Report" D ^%ZTLOAD K MJLT,MJT,%ZIS,POP,IOP,ZTSK D ^%ZISC Q
ENQ ;ENTRY POINT WHEN QUEUED
 U IO
 S PSNPGCT=0,PSNPGLNG=IOSL-10,PSNPRT=0,(PSNVHLD,PSNNMHLD)="" D TITLE,LOOP
DONE I $D(PSNPRT) W:PSNPRT=0 !!?50,"No Entries Found"
 W @IOF S:$D(ZTQUEUED) ZTREQ="@" K PSNB,MJLT,MJT,IOP,POP,IO("Q"),PSNNEW,PSNOLD,PSNPC1,PSNPC2,PSNPGCT,PSNPGLNG,PSNDUZ,PSNVDUZ,PSNVNAME,PSNNAME,PSNVHLD,PSNNMHLD,PSNSZ,PSNTYP,Y
 K PSNPRT,PSNOUN,PSNOU,PSNODE,PSNTYPE,PSNSIZE,PSNSZE,PSNTPE D ^%ZISC
 Q
TITLE I $D(IOF),IOF]"" W @IOF S PSNPGCT=PSNPGCT+1
 W !,?33,"DRUG NAME FROM LOCAL DRUG FILE WITH MATCH FROM NATIONAL DRUG FILE"
 S X="T" D ^%DT X ^DD("DD") W !,?100,"Date printed: ",Y,!?100,"Page: ",PSNPGCT,!
 W !?4,"LOCAL DRUG NAME",?54,"VA PRODUCT NAME",!
 F MJT=1:1:132 W "-"
 I (PSNPGCT>1),(PSNNAME=PSNNMHLD) W !,?39,"Entered by: ",PSNNAME
 I (PSNPGCT>1),(PSNVNAME=PSNVHLD) W !,?38,"Verified by: ",PSNVNAME
 Q
LOOP F PSNB=0:0 S PSNB=$O(^PSNTRAN(PSNB)) Q:'PSNB  D WRITE
 Q
WRITE Q:'$D(^PSNTRAN(PSNB,0))  Q:$P(^PSNTRAN(PSNB,0),"^",2)']""  S PSNOLD=$P(^PSDRUG(PSNB,0),"^"),PSNPC1=$P(^PSNTRAN(PSNB,0),"^"),PSNPC2=$P(^PSNTRAN(PSNB,0),"^",2)
 S PSNNEW=$P(^PSNDF(50.68,PSNPC2,0),"^"),PSNSIZE=$P(^PSNTRAN(PSNB,0),"^",5),PSNTYPE=$P(^PSNTRAN(PSNB,0),"^",7)
 I $D(^PSDRUG(PSNB,660)) S PSNODE=^PSDRUG(PSNB,660) I $P(PSNODE,"^",2) S PSNOU=$P(PSNODE,"^",2) I $D(^DIC(51.5)),$D(^DIC(51.5,PSNOU)) S PSNOUN=$P(^DIC(51.5,PSNOU,0),"^",1)
 S PSNDUZ=$P(^PSNTRAN(PSNB,0),"^",8),PSNNAME=$P(^VA(200,PSNDUZ,0),"^")
 S PSNVDUZ=$S($P(^PSNTRAN(PSNB,0),"^",9)]"":$P(^PSNTRAN(PSNB,0),"^",10),1:"") S PSNVNAME=$S(PSNVDUZ]"":$P(^VA(200,PSNVDUZ,0),"^"),1:"")
 D:$Y>PSNPGLNG TITLE
 W:PSNNAME'=PSNNMHLD !,?39,"Entered by: ",PSNNAME S PSNNMHLD=PSNNAME
 I PSNVDUZ]"" W:PSNVNAME'=PSNVHLD !,?38,"Verified by: ",PSNVNAME S PSNVHLD=PSNVNAME
 D PKSIZE^PSNOUT,PKTYPE^PSNOUT W !!,?4,PSNOLD,?54,PSNNEW,!,?6,"ORDER UNIT: ",$S($D(PSNOUN):PSNOUN,1:""),?56,"PKG SIZE: ",PSNSZE S PSNPRT=1
 W !,?6,"DISPENSE UNITS/ORDER UNITS: ",$S('$D(PSNODE):"",1:$P(PSNODE,"^",5)),?56,"PKG TYPE: ",PSNTPE
 W !,?6,"DISPENSE UNIT: ",$S('$D(PSNODE):"",1:$P(PSNODE,"^",8)),?56,"VA CLASS: ",$P(^PS(50.605,$P(^PSNTRAN(PSNB,0),"^",3),0),"^",1)_"  "_$P(^PS(50.605,$P(^PSNTRAN(PSNB,0),"^",3),0),"^",2)
 I PSNVDUZ']"" W !,?38,"** NOT VERIFIED **"
 Q
