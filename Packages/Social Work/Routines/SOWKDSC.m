SOWKDSC ;B'HAM ISC/SAB-DIRECT SERVICES CATEGORY REPORT ;  [ 08/20/96  7:32 AM ]
 ;;3.0; Social Work ;**17,34,43,53**;27 Apr 93
BEG W ! S %DT="AEXP",%DT("A")="DIRECT SERVICES PROVIDED FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SB1=Y
EN S %DT("A")="ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 EN S SE1=Y
 I '$D(SOWK) D ASK
 G:$G(SOWOUT)=1 CLOS
DEV ;
 K ZTSK,%ZIS,IOP S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION G CLOS
 S:'$D(SOWKAB) SOWKAB="" K SOWKION I $D(IO("Q")) S ZTDESC="DIRECT SERVICES REPORT",ZTRTN="ENQ^SOWKDSC" F G="SB1","SE1","SOWKAB","SOWK","SOWKDIV","SWA","SWB","SWZ" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD I '$D(ZTSK) K G,%DT G CLOS
 I $D(ZTSK) K G,%DT,ZTSK W !!,"Task Queued to Print",! G CLOS
ENQ ;queue report entry point
 S SOWOUT=0
 D CLE
 I $D(SOWK) D DV
 I '$D(SOWK) D CS
 F I=0:0 S I=$O(^SOWK(655.202,I)) Q:'I  S:TOT TP(I)=(DSC(I)/TOT)*100
 U IO W:$Y @IOF W ?5,"DIRECT SERVICES CATEGORY FOR "_$S($D(SOWK):"DIVISION "_$P(^SOWK(650.1,SOWKDIV,0),"^"),$G(SWA)=1!('$D(SWA)):"COMPLETE SERVICE",$G(SWB)=1:"SUPERVISOR: "_$P(^VA(200,SWZ,0),"^"),1:"SOCIAL WORKER: "_$P(^VA(200,SWZ,0),"^"))
 W !!,$E($S($D(SB1):SB1,1:SOWKFD),4,5)_"/"_$E($S($D(SB1):SB1,1:SOWKFD),6,7)_"/"_$E($S($D(SB1):SB1,1:SOWKFD),2,3)_" TO "_$E($S($D(SE1):SE1,1:SOWKFB),4,5)_"/"_$E($S($D(SE1):SE1,1:SOWKFB),6,7)_"/"_$E($S($D(SE1):SE1,1:SOWKFB),2,3)
 W !!,?60,"NUMBER",?70,"PERCENT"
 F I=0:0 S I=$O(^SOWK(655.202,I)) Q:'I!($G(OUT)=1)  D CHK Q:$G(OUT)=1  W !,$E($P(^SOWK(655.202,I,0),"^"),1,55),?60,$J(DSC(I),3,0),?70,$J(TP(I),3,0)
 G:$G(OUT)=1 CLOS W !,"TOTALS",?60,$J(TOT,3,0),?70,$S(TOT:$J(TOT/TOT*100,3,0),1:$J(0,3,0))
CLOS W ! I $G(SOWKAB)'="ALL" W:$E(IOST)'["C" @IOF D ^%ZISC K X,SOWOUT,POP,IOP,OUT,SB1,SE1,Y,SOWKAB,SOWKFB,SOWKFD
 K %DT,II,CR,I,TOT,TP,DSC D:$D(ZTSK) KILL^%ZTLOAD
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",X:DTIME W @IOF
 Q
CLE S TOT=0 F I=0:0 S I=$O(^SOWK(655.202,I)) Q:'I  S (DSC(I),TP(I))=0
 K I
 Q
 ;SPECIAL POPULATION ROUTINE SECTION
DSC F II=0:0 S II=$O(^SOWK(650,I,5,II)) Q:'II  S DSC($P(^SOWK(650,I,5,II,0),"^"))=DSC($P(^SOWK(650,I,5,II,0),"^"))+1,TOT=TOT+1
 Q
DV F I=0:0 S I=$O(^SOWK(650,I)) Q:'I  S CR=^SOWK(650,I,0) D
 .S W=$P(CR,U,3) I $D(SWB) Q:$S(SWB:$P(^VA(200,W,654),U,2)'=SWZ,(('SWA)&('SWB)):W'=SWZ,1:1)
 .I $P(CR,"^",2)'<$S($D(SB1):SB1,1:SOWKFD),$P(CR,"^",2)'>$S($D(SE1):SE1,1:SOWKFB),$P(CR,"^",5)=SOWK D DSC
 .I $P(CR,"^",2)<$S($D(SB1):SB1,1:SOWKFD),$P(CR,"^",18)'<$S($D(SB1):SB1,1:SOWKFD),$P(CR,"^",18)'>$S($D(SE1):SE1,1:SOWKFB),$P(CR,"^",5)=SOWK D DSC
 Q
CS F I=0:0 S I=$O(^SOWK(650,I)) Q:'I  S CR=^SOWK(650,I,0) D
 .S W=$P(CR,U,3) I $D(SWB),($G(SWA)'=1) Q:$S(SWB:$P(^VA(200,W,654),U,2)'=SWZ,(('SWA)&('SWB)):W'=SWZ,1:1)
 .I $P(CR,"^",2)'<$S($D(SB1):SB1,1:SOWKFD),$P(CR,"^",2)'>$S($D(SE1):SE1,1:SOWKFB) D DSC
 .I $P(CR,"^",2)<$S($D(SB1):SB1,1:SOWKFD),$P(CR,"^",18)'<$S($D(SB1):SB1,1:SOWKFD),$P(CR,"^",18)'>$S($D(SE1):SE1,1:SOWKFB) D DSC
 Q
CHK ;checks for the end of page
 I ($Y+5)>IOSL D
 .I $E(IOST)["C" R !,"Press <RETURN> to continue: ",X:DTIME S:X["^" OUT=1
 .W @IOF
 Q
ASK ;print screen
 K DIR,DA S DIR(0)="YO",DIR("A")="Do you want Complete Service",DIR("?")="Enter 'YES' to print the complete service.",DIR("B")="No" D ^DIR S:$D(DUOUT) SOWOUT=1 I +Y=1 S SWA=1,SWB=0 Q
 Q:$G(SOWOUT)=1
 K DIR,DA S DIR(0)="YO",DIR("A")="Do you want report by Supervisor ",DIR("?")="Enter 'YES' to print the report by supervisor",DIR("B")="No" D ^DIR S:$D(DUOUT) SOWOUT=1 I +Y=1 D  I +Y>0 S SWZ=+Y,SWB=1,SWA=0 Q
 .K DIR,DA S DIR(0)="P^200:EMZ",DIR("A")="Enter Supervisor's last name ",DIR("?")="To print the report for a supervisor, enter the supervisor's last name.",DIR("S")="I $D(^VA(200,""ASWC"",+Y))" D ^DIR
 Q:$G(SOWOUT)=1
 K DIR,DA S DIR(0)="P^200:EMZ",DIR("A")="Enter Social Worker's last name ",DIR("?")="To print the report for a worker, enter the worker's last name.",DIR("S")="I $D(^VA(200,+Y,654)),$P(^VA(200,+Y,654),U)" D ^DIR I +Y>0 S SWZ=+Y,(SWA,SWB)=0 Q
 S SOWOUT=1
 Q
