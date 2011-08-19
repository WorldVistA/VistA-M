PSXCSDC ;BIR/JMB-Drug Cost by Drug Report ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 ;Gets specific drug (if desired), facility, div, & date range to print
 D IDYN^PSXCSUTL G:$G(PSXOUT) EX1^PSXCSDC1
DEV ;Device handling
 W ! K %ZIS,ZTSK,IOP,POP S %ZIS("B")="",PSXION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=PSXION D ^%ZIS K POP,PSXION G EX^PSXCSDC1
 I $E(IOST)["C"!($G(IOM)<132) W !!,"Printout must be sent to a 132-column printer!",!! G DEV
 K PSXION I $D(IO("Q")) S ZTDESC="CMOP Drug Cost by Drug",ZTRTN="START^PSXCSDC" F PSXG="PSXBDT","PSXEDT","PSXDV","PSXFAC","PSXID" S:$D(@PSXG) ZTSAVE(PSXG)=""
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report queued to print!",! K ZTSK G EX^PSXCSDC1
START ;Determines which loop to use based on user input
 U IO K ^TMP($J),PSXSPDV S:$D(PSXDV) PSXSPDV=1 D @($S($G(PSXFAC)=""&($G(PSXDV)=""):"ALL",$G(PSXFAC)'=""&($G(PSXDV)=""):"ALLDV",$G(PSXFAC)'=""&($G(PSXDV)'=""):"DATE",1:"EX^PSXCSDC1")) G PRINT^PSXCSDC1
ALL ;Loops thru all facilities
 F PSXFAC=0:0 S PSXFAC=$O(^PSX(552.5,PSXFAC)) Q:'PSXFAC  S PSXDV="" F  S PSXDV=$O(^PSX(552.5,PSXFAC,1,"B",PSXDV)) Q:PSXDV=""  D DATE
 Q
ALLDV ;Loops thru all divisions
 S PSXDV="" F  S PSXDV=$O(^PSX(552.5,PSXFAC,1,"B",PSXDV)) Q:PSXDV=""  D DATE
 Q
DATE ;Entry point if specific fac & div OR this is called by ALL & ALLDV
 S PSXIDV=$O(^PSX(552.5,PSXFAC,1,"B",PSXDV,0)) F PSXPSDT=(PSXBDT-1):0:PSXEDT S PSXPSDT=$O(^PSX(552.5,PSXFAC,1,PSXIDV,1,PSXPSDT)) Q:'PSXPSDT!(PSXPSDT>PSXEDT)  D
 .F PSXDG=0:0 S PSXDG=$O(^PSX(552.5,PSXFAC,1,PSXIDV,1,PSXPSDT,1,PSXDG)) Q:'PSXDG  D:$D(^PSX(552.5,PSXFAC,1,PSXIDV,1,PSXPSDT,1,PSXDG,0)) DRUG
 Q
DRUG ;Gets drug data & sets ^TMP nodes
 S PSXDGID=$P(^PSX(552.5,PSXFAC,1,PSXIDV,1,PSXPSDT,1,PSXDG,0),"^")
 I $G(PSXID)'="" Q:PSXDGID'=PSXID
 D NAME^PSXCSUTL S PSXDV=$E(PSXDV,1,25),Y=^PSX(552.5,PSXFAC,1,PSXIDV,1,PSXPSDT,1,PSXDG,0)
 I '$D(^TMP($J,PSXFAC,PSXDV,PSXNAM)) S ^TMP($J,PSXFAC,PSXDV,PSXNAM)=$P(Y,"^",2)_"^"_$P(Y,"^",3)_"^"_$P(Y,"^",4)_"^"_$P(Y,"^",5) Q
 S $P(^TMP($J,PSXFAC,PSXDV,PSXNAM),"^")=$P(^(PSXNAM),"^")+$P(Y,"^",2),$P(^TMP($J,PSXFAC,PSXDV,PSXNAM),"^",2)=$P(^(PSXNAM),"^",2)+$P(Y,"^",3),$P(^TMP($J,PSXFAC,PSXDV,PSXNAM),"^",3)=$P(^(PSXNAM),"^",3)+$P(Y,"^",4)
 S $P(^TMP($J,PSXFAC,PSXDV,PSXNAM),"^",4)=$P(^(PSXNAM),"^",4)+$P(Y,"^",5)
 Q
