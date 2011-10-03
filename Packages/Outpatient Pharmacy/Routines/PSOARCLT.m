PSOARCLT ;BHAM ISC/LGH - list archived prescriptions ; 11/17/92 18:17
 ;;7.0;OUTPATIENT PHARMACY;**10**;DEC 1997
AC W !!!!
 S DIC("S")="I $O(^PS(55,+Y,""ARC"",0))",DIC=55,DIC(0)="AEQM",DIC("A")="Show archived prescriptions for: " D ^DIC K DIC G DONE:Y<0 S (DA,DFN)=+Y D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN)
 I '$O(^PS(55,DA,"ARC",0)) W !,"Patient has no archived prescriptions !",! G PSOARCLT
 ;
 S %ZIS="MNQ" D ^%ZIS G DONE:POP I IO'=IO(0) S ZTDTH=$H,ZTRTN="GET^PSOARCLT",ZTDESC="Option to print archived prescriptions",ZTSAVE("DA")=DA D ^%ZTLOAD D ^%ZISC K ZTDTH,ZTRTN,ZTDESC,ZTSAVE G PSOARCLT
 D GET R !," Please press RETURN to continue",Z:DTIME G PSOARCLT:$T
DONE D ^%ZISC K DA,DFN,J1,JJ,KK,SC,TEMP,X,Y,Z,SUB,XY,SL,FF,BS,XI,VA("PID"),VA("BID") Q
GET S DFN=DA
 D ADD^VADPT,DEM^VADPT,ELIG^VADPT
 W @IOF,!,$G(VADM(1)),?40,"ID#:   ",$P($G(VADM(2)),"^",2)
 I $G(VAPA(10)),$G(VAPA(9)),(DT'>$G(VAPA(10))) S Y=VAPA(9) X:Y ^DD("DD") W !?5,"(TEMP ADDRESS from "_Y S Y=VAPA(10) X:Y ^DD("DD") W " till "_Y_")"
 W !,$G(VAPA(1)),?40,"DOB:   ",$S($G(VADM(3)):$E($P(VADM(3),"^"),4,5)_"-"_$E($P(VADM(3),"^"),6,7)_"-"_(1700+$E($P(VADM(3),"^"),1,3)),1:"UNKNOWN")
 W !,$G(VAPA(4)),?40,"PHONE: ",$G(VAPA(8))
 W !,$P($G(VAPA(5)),"^",2)
 W "  ",$G(VAPA(6)),?40,"ELIG:  " I $G(VAEL(1)) S SC=$P($G(VAEL(1)),"^",2) W SC
 I $D(^PS(55,DFN,0)),+$P(^(0),"^",2) W !,"CANNOT USE SAFETY CAPS."
 I +$P(^PS(55,DFN,0),"^",4) W ?40,"DIALYSIS PATIENT."
 I $D(^PS(55,DFN,1)),^(1)]"" S X=^(1) W !!?5,"Pharmacy narrative: " F I=1:1 Q:$P(X," ",I,99)=""  W $P(X," ",I)," " W:$X>75 !
RE S PSLC=0 G END:'$D(^DPT(DFN,.17)) G END:$P(^(.17),"^",2)'="I"
 W !!,"ELIGIBILITY: ",SC S PSLC=PSLC+2
 K SC W !,"DISABILITIES: " S PSLC=PSLC+2 G END:'$D(^DPT(DFN,.372))
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  S I1=$S($D(^(I,0)):^(0),1:""),PSDIS=$S($D(^DIC(31,+I1,0)):$P(^(0),"^"),1:""),PSCNT=$P(I1,"^",2) X:($X+$L(PSDIS)+7)>72 "W !?10 S PSLC=PSLC+1" W PSDIS,"-",PSCNT,"% (",$S($P(I1,"^",3):"SC",1:"NSC"),"), "
 D KVA^VADPT
END ;
 D HOME^%ZIS W !!,"ARCHIVED: " S PSOD=0,U="^" F JJ=0:0 W:PSOD'=0 !?10 S PSOD=$O(^PS(55,DA,"ARC",PSOD)) Q:'PSOD  D W
 K PSOD,PSOR,PSORR
 I $E(IOST)="P",$D(IOF),IOF]"" W @IOF
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
W Q:'$D(^PS(55,DA,"ARC",PSOD,1,0))  Q:$P(^PS(55,DA,"ARC",PSOD,1,0),U,4)'>0  S PSOR=0 W $E(PSOD,4,5),"/",$E(PSOD,6,7),"/",$E(PSOD,2,3)," - "
 F KK=0:0 S PSOR=$O(^PS(55,DA,"ARC",PSOD,1,PSOR)) Q:'PSOR  D P
 Q
P Q:$L(^PS(55,DA,"ARC",PSOD,1,PSOR,0))<1  S PSORR=^PS(55,DA,"ARC",PSOD,1,PSOR,0)
 F J1=1:1 Q:$P(PSORR,"*",J1)=""  W:($X+$L($P(PSORR,"*",J1))+1)>IOM !?21 W $P(PSORR,"*",J1),","
 Q
Q K SC,Y,LMI,TEMP,TMPDT Q
