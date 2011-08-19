DENTPEX ;ISC2/HCD-Inpatients needing Dental Exam Report ;10/23/90  14:35 ;
 ;;VERSION 1.2;;**7,11**;
 S Z4="" G:'$D(^DENT(225,0)) W I $P(^(0),U,4)=1 S X=$P(^(0),U,3) I $D(^DENT(225,X,0)) S DENTSTA=$P(^(0),U) G D
 S DIC="^DENT(225,",DIC(0)="AEMQ" D ^DIC G EXIT1:Y<0 S DENTSTA=$P(Y,U,2)
D S %ZIS="MQ" K IO("Q") D ^%ZIS G EXIT1:IO=""
 I $D(IO("Q")) S ZTRTN="QUE^DENTPEX",ZTSAVE("DENTSTA")="",ZTSAVE("U")="",ZTSAVE("Z4")="" D ^%ZTLOAD K ZTSK,ZTRTN,ZTSAVE G CLOSE
QUE U IO D RET G EXIT2:'$D(^UTILITY($J,"DENTTR")) D PR1,PR
 I Z4'[U,'$D(ZTSK),IO=IO(0) R !!,"Press return to continue, uparrow (^) to exit: ",X:DTIME
 G CLOSE
RET D NOW^%DTC S Y=X X ^DD("DD") S DATE=Y K ^UTILITY($J,"DENTTR")
 S X1="" F DENTI=0:0 S X1=$O(^DPT("CN",X1)) Q:X1=""  S DENT="" F J=1:1 S DENT=$O(^DPT("CN",X1,DENT)) Q:DENT=""  I $D(^DPT(DENT,0)) D WRD
 Q
WRD S DENTX2=0,DFN=DENT D INP^VADPT Q:'VAIN(1)!('VAIN(7))  D DEM^VADPT S:VAIN(5)="" VAIN(5)=" " Q:VADM(2)']""  S DENTDX=VAIN(9)
 I '$D(^DENT(221,"D",$P(VADM(2),U))) S DENTX="" G SET
 S DENTX=1,X2="" F K=0:0 S X2=$O(^DENT(221,"D",$P(VADM(2),U),X2)) Q:X2=""  D:$D(^DENT(221,X2,0)) WRD1 Q:$D(DENTX1)
SET S:('$D(DENTX1)&('DENTX))!(DENTX2) ^UTILITY($J,"DENTTR",$P(VAIN(4),U,2),VAIN(5),VADM(1))=$P(VADM(2),U)_U_DENTDX K DENTX1 Q
WRD1 S DENTTD=^(0) I $P(DENTTD,"^",40)=DENTSTA,$P(VAIN(7),U)'>+DENTTD S DENTX2=0 S:$P(DENTTD,"^",7)="" DENTX="" S:$P(DENTTD,"^",7)'="" DENTX1=1 Q
 I $P(DENTTD,"^",40)=DENTSTA,$P(VAIN(7),U)>+DENTTD S DENTX2=1
 Q
PR S (DENTNB,X)="" F I=0:1 S X=$O(^UTILITY($J,"DENTTR",X)) Q:X=""  D:I&($Y>(IOSL-3)) HOLD1 Q:Z4[U  S X1="" F J=0:0 S X1=$O(^UTILITY($J,"DENTTR",X,X1)) Q:X1=""  S DENTNM="" F K=0:0 S DENTNM=$O(^UTILITY($J,"DENTTR",X,X1,DENTNM)) Q:DENTNM=""  D PR2
 Q
PR2 S Z=^UTILITY($J,"DENTTR",X,X1,DENTNM),DENTSSN=$P(Z,U),DENTDX=$P(Z,U,2),DENTNB=DENTNB+1
 D:$Y>(IOSL-3) HOLD1 Q:Z4[U  W !,$J(DENTNB,3),?5,$E(X,1,10),?17,$E(X1,1,10),?29,$E(DENTNM,1,24),?54,DENTSSN,?65,$E(DENTDX,1,15),! Q
PR1 S Z1="Veterans Administration Medical Center",Z2="Dental Service -- Station Number "_DENTSTA,Z3="Inpatients Needing Dental Exams for "_DATE
 W @IOF,$C(13),?(80-$L(Z1)/2),Z1,!,?(80-$L(Z2)/2),Z2,!,?(80-$L(Z3)/2),Z3,!!
 W !,?5,"Ward",?17,"Room-Bed",?29,"Patient Name",?54,"SSN",?65,"Diagnosis",!,?5,"----",?17,"--------",?29,"------------",?54,"---------",?65,"---------" Q
HOLD1 D HOLD D:Z4'[U PR1 Q
HOLD Q:$D(ZTSK)!(IO'=IO(0))  S Z4="" R !,"Press return to continue, uparrow (^) to exit: ",Z4:DTIME Q
W W !!,"Stations have not been entered in the Dental Site Parameter file.",!,"You must enter a station before you can use this option." G EXIT1
EXIT2 W !!,"There are no examinations for station "_DENTSTA_" that need to be done today.",!
CLOSE X ^%ZIS("C")
EXIT1 K %,DATE,DENTDX,DENTI,DENTNB,DENTNM,DENTSTA,DENTSSN,DENTTD,DENTX,DENTX1,DENTX2,DIC,I,J,K,VADM,VAIN,X,X1,X2,Z,Z1,Z2,Z3,Z4,Y,^UTILITY($J,"DENTTR") K:$D(ZTSK) ^%ZTSK(ZTSK),ZTSK Q
