SRSWL3 ;B'HAM ISC/MAM - WAITING LIST, EXTENDED-ALL ; 17 OCT 1989  7:35 AM
 ;;3.0; Surgery ;**34**;24 Jun 93
 W ! K %ZIS,POP,IOP,IO("Q") S %ZIS("A")="Print to Device: ",%ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTDESC="SURGERY WAITING LIST",ZTRTN="BEG^SRSWL3" D ^%ZTLOAD G END
BEG ; entry when queued
 U IO S (SRSOUT,SRHDR)=0 D NOW^%DTC S Y=% D D^DIQ S SRTIME=$E(Y,1,12)_" at "_$E(Y,14,18)
 S SRSS=0 F  S SRSS=$O(^SRO(133.8,"AWL",SRSS)) Q:'SRSS!(SRSOUT)  S SRSNM=$P(^SRO(133.8,SRSS,0),"^"),SRSNM=$P(^SRO(137.45,SRSNM,0),"^") D PAGE S SRSDT=0 F  S SRSDT=$O(^SRO(133.8,"AWL",SRSS,SRSDT)) Q:'SRSDT!(SRSOUT)  D MORE
END I $E(IOST)="P" S SRSOUT=1 W @IOF
 I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 D ^%ZISC,^SRSKILL K SRTN
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S SRHDR=1 W:$Y @IOF W !,"Surgery Waiting List for "_SRSNM,!,"Printed "_SRTIME,! F LINE=1:1:80 W "="
 Q
MORE ; continue looping on 'WL' x-ref
 S SROFN=0 F  S SROFN=$O(^SRO(133.8,"AWL",SRSS,SRSDT,SROFN)) Q:'SROFN!(SRSOUT)  D PRINT
 Q
PRINT ; print information
 I $Y+20>IOSL D PAGE Q:SRSOUT
 S SRW=^SRO(133.8,SRSS,1,SROFN,0),DFN=$P(SRW,"^") D DEM^VADPT S SRSDPT=VADM(1)_" ("_VA("PID")_")",SROPER=$P(SRW,"^",2),(Y,SRDT)=SRSDT D D^DIQ S SRDT=$E(Y,1,12)_" "_$E(Y,14,18)
OUT S (Y,SRADT)=$P(SRW,"^",4) I Y D D^DIQ S SRADT=$E(Y,1,12)
 S (Y,TEMPDT)=$P(SRW,"^",5) I Y D D^DIQ S TEMPDT=Y
 D ADD^VADPT
 S SRSPH1=VAPA(8)
 S SRSDPT(.13)=$S($D(^DPT(DFN,.13)):^(.13),1:"") S SRSPH2=$P(SRSDPT(.13),"^",2) S:SRSPH1="" SRSPH1="NOT ENTERED" S:SRSPH2="" SRSPH2="NOT ENTERED"
 K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,"Patient:",?14,SRSDPT,!,"Date Entered: ",?12,SRDT,!,"Procedure: ",?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2)
 W !!,"Tentative Admission Date:    "_$S(SRADT="":"None Specified",1:SRADT)
 W !,"Tentative Date of Operation: "_$S(TEMPDT="":"None Specified",1:TEMPDT)
 D ^SRSWL5
 K ^UTILITY($J,"W") I $O(^SRO(133.8,SRSS,1,SROFN,2,0)) W !!,"Comments: " S SRCOM=0 F I=0:0 S SRCOM=$O(^SRO(133.8,SRSS,1,SROFN,2,SRCOM)) Q:'SRCOM  S X=^SRO(133.8,SRSS,1,SROFN,2,SRCOM,0),DIWL=3,DIWR=78 D ^DIWP
 I $D(^UTILITY($J,"W")) F X=1:1:^UTILITY($J,"W",3) W !,?3,^UTILITY($J,"W",3,X,0)
 W !!,"  Home Phone: "_SRSPH1,?40,"Work Phone: "_SRSPH2
 ; VAPA contents are (1)-street add 1 (2)-street add 2 (3)-street add 3
 ; (4)-city (5)-state (6)-zip (8)-home phone
 W !,"  Address: ",?14,VAPA(1) W:VAPA(2)'="" !,?14,VAPA(2) W:VAPA(3)'="" !,?14,VAPA(3) W:VAPA(4)'="" !,?14,VAPA(4) W:$P(VAPA(5),U,2)'="" ", "_$P(VAPA(5),U,2)_" "_VAPA(6)
 I $O(^SRO(133.8,SRSS,1,SROFN,1,0)) W !!,"Referring Physician/Institution: "
 S SREFER=0 F  K SRPHY S SREFER=$O(^SRO(133.8,SRSS,1,SROFN,1,SREFER)) Q:'SREFER  D
 .S X=^SRO(133.8,SRSS,1,SROFN,1,SREFER,0),SRPHY("NAME")=$P(X,"^"),SRPHY("ADD")=$P(X,"^",2),SRPHY("CITY")=$P(X,"^",3)
 .S Y=$P(X,"^",4),SRPHY("STATE")=$S(Y:$P(^DIC(5,Y,0),"^"),1:""),SRPHY("ZIP")=$P(X,"^",5),SRPHY("PH")=$P(X,"^",6)
 .W !,?5,SRPHY("NAME"),?40,"Phone: "_SRPHY("PH"),!,?8,SRPHY("ADD") W:SRPHY("CITY")'="" !,?8,SRPHY("CITY")_", "_SRPHY("STATE")_"  "_SRPHY("ZIP")
 W ! F LINE=1:1:80 W "-"
 Q
LOOP ; break operation if greater than 59 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<59  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
PAGE ; end of page
 I 'SRHDR S SRHDR=1 D HDR Q
 I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 D HDR
 Q
