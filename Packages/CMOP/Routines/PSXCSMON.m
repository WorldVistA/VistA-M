PSXCSMON ;BIR/SAB-Drug Cost by Drug for One Month ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
EN ;Get month, specific drug (if desired), facility, & div
 W ! D MN^PSXCSUTL G:$G(PSXOUT) END^PSXCSUTL
MIN ;If user selected specific drug, get minimum # of refills to print
 G:$D(PSXID) DEV W ! S DIR("A")="Select Minimum Total number of Refills: ",DIR("B")=0,DIR(0)="N^0:50:0",DIR("?",1)="Enter a number for minimum refills (0-50)",DIR("?")="OR press Enter for a minimum of zero (0)."
 D ^DIR K DIR G:$G(DIRUT) EX^PSXCSMN1 S PSXRF=Y
 ;Gets minimum total cost to print
 W ! S DIR("A")="Select Minimum Total Cost: ",DIR("B")=0,DIR(0)="N^0:9999:2",DIR("?",1)="Enter the minimum cost of drug (0-9999) OR",DIR("?")="press return for a minimum cost of zero (0)."
 D ^DIR K DIR G:$G(DIRUT) EX^PSXCSMN1 S PSXMC=Y
DEV ;Device handling
 W ! K %ZIS,IOP,ZTSK,POP S PSXION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP D END^PSXCSUTL Q
 I $E(IOST)["C"!($G(IOM)<132) W !!,"Printout must be sent to a 132-column printer!",!! G DEV
 K PSXION I $D(IO("Q")) S ZTDESC="CMOP Drug Cost Report by Month",ZTRTN="START^PSXCSMON" F PSXG="PSXBDT","PSXID","PSXFAC","PSXFACYN","PSXDV","PSXRF","PSXMC" S:$D(@PSXG) ZTSAVE(PSXG)=""
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is queued to print!",! G EX^PSXCSMN1
START ;Queued entry point
 U IO K ^TMP($J),PSXSPDV S PSXPG=0,PSXBDTH=PSXBDT,PSXEDT=PSXBDT+32 S:$D(PSXDV) PSXSPDV=1
 ;Determines loop to use based on user input
 D @($S($G(PSXFAC)=""&($G(PSXDV)=""):"ALL",$G(PSXFAC)'=""&($G(PSXDV)=""):"ALLDV",$G(PSXFAC)'=""&($G(PSXDV)'=""):"DATE",1:"EX^PSXCSMN1"))
 G ^PSXCSMN1
ALL ;Loops thru all facilities
 F PSXFAC=0:0 S PSXFAC=$O(^PSX(552.5,PSXFAC)) Q:'+PSXFAC  S PSXDV="" F  S PSXDV=$O(^PSX(552.5,PSXFAC,1,"B",PSXDV)) Q:PSXDV=""  D DATE
 Q
ALLDV ;Loops thru all divs
 S PSXDV="" F  S PSXDV=$O(^PSX(552.5,PSXFAC,1,"B",PSXDV)) Q:PSXDV=""  D DATE
 Q
DATE ;Entry point if specific fac & div OR this is called by ALL & ALLDV
 S PSXIDV=$O(^PSX(552.5,PSXFAC,1,"B",PSXDV,0))
 F PSXDT=(PSXBDT-1):0:PSXEDT S PSXDT=$O(^PSX(552.5,PSXFAC,1,PSXIDV,1,PSXDT)) Q:'PSXDT!(PSXDT>PSXEDT)  D
 .F PSXDG=0:0 S PSXDG=$O(^PSX(552.5,PSXFAC,1,PSXIDV,1,PSXDT,1,PSXDG)) Q:'PSXDG  D:$D(^(PSXDG,0)) DRUG
 Q
DRUG ;Gets drug data & sets ^TMP nodes
 S PSXDGID=$P(^PSX(552.5,PSXFAC,1,PSXIDV,1,PSXDT,1,PSXDG,0),"^") I $D(PSXID) Q:PSXDGID'=PSXID
 Q:$P(^PSX(552.5,PSXFAC,1,PSXIDV,1,PSXDT,1,PSXDG,0),"^",3)<+$G(PSXRF)!($P(^(0),"^",4)<+$G(PSXMC))
 S PSXIDG=+$O(^PSDRUG("AQ1",PSXDGID,0)) D NAME^PSXCSUTL
 S PSXDV=$E(PSXDV,1,25),Y=^PSX(552.5,PSXFAC,1,PSXIDV,1,PSXDT,1,PSXDG,0)
 I '$D(^TMP($J,PSXFAC,PSXDV,PSXNAM)) S ^TMP($J,PSXFAC,PSXDV,PSXNAM)=$P(Y,"^",2)+$P(Y,"^",3)_"^"_$P(Y,"^",4)_"^"_$P(Y,"^",5)_"^"_$S($P($G(^PSDRUG(PSXIDG,0)),"^",9):"*** N/F ***",1:"") Q
 S $P(^TMP($J,PSXFAC,PSXDV,PSXNAM),"^")=$P(^(PSXNAM),"^")+$P(Y,"^",2)+$P(Y,"^",3),$P(^(PSXNAM),"^",2)=$P(^(PSXNAM),"^",2)+$P(Y,"^",4)
 S $P(^TMP($J,PSXFAC,PSXDV,PSXNAM),"^",3)=$P(^(PSXNAM),"^",3)+$P(Y,"^",5),$P(^(PSXNAM),"^",4)=$S($P($G(^PSDRUG(PSXIDG,0)),"^",9):"*** N/F ***",1:"")
 Q
