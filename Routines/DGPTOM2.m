DGPTOM2 ;ALB/AS - PTF MEANS TEST INDICATOR of 'U' Report (CONT) ; 2 FEB 90  14:30
 ;;5.3;Registration;;Aug 13, 1993
 G:'$D(^DGPT("AMT","U")) NONE K ^UTILITY($J,"DGPTFU") D LO^DGUTL S $P(DGLN,"=",81)="",(DGTOT,DGPAG)=0,DGQUIT=""
 F PTF=0:0 S PTF=$O(^DGPT("AMT","U",PTF)) Q:PTF'>0  I $D(^DGPT(PTF,0)),$P(^(0),U,11)=1 D DT
 G:'$D(^UTILITY($J,"DGPTFU")) NONE D HDR,PRT G Q:DGQUIT W !,"Total of  ",DGTOT,"  PTF Records" D PG G Q
DT S DGDATE=$S('DGD:$P(^DGPT(PTF,0),"^",2),$D(^DGPT(PTF,70)):+$P(^(70),"^"),1:"") Q:DGDATE<DGSD!(DGDATE>DGED)  S I=^DGPT(PTF,0),DFN=+I,DGADM=$P(I,"^",2),I=^DPT(DFN,0),DGNAME=$P(I,"^"),SSN=$P(I,"^",9) N DGPMAN,DGPMCA D PM^DGPTUTL
 D MT^DGPTUTL Q:$P(^DGPT(PTF,0),U,10)'="U"  S DGMTDT=$P($$LST^DGMTU(DFN,$P($G(^DGPT(PTF,70)),".")),U,4)
 ;
 S DGMTDT=$S(DGMTDT'>0:"*"_DGDATE,1:9999999-DGMTDT) I DGP S ^UTILITY($J,"DGPTFU",1,DGNAME,SSN,PTF)=$P(DGMTDT,".") Q
 S N=" "_$E(SSN,8,9)_$E(SSN,6,7)_$E(SSN,4,5)_$E(SSN,1,3),^UTILITY($J,"DGPTFU",N,DGNAME,SSN,PTF)=$P(DGMTDT,".") Q
LN F PTF=0:0 S PTF=$O(^UTILITY($J,"DGPTFU",DGSB,DGNAME,SSN,PTF)) Q:PTF'>0!(DGQUIT)  S DGDATE=^(PTF),Y=$S(DGDATE["*":$P(DGDATE,"*",2),1:DGDATE) X ^DD("DD") S DGMTDT=Y D:$Y>$S('$D(IOSL):55,1:(IOSL-11)) HDR Q:DGQUIT  D WLN
 Q
WLN W !,DGNAME,?35,SSN,?48,PTF,?56,$S(DGDATE["*":"** ",1:""),DGMTDT S DGTOT=DGTOT+1 Q
PG S N=$S('$D(IOSL):55,1:(IOSL-11)) F Y=$Y:1:N W !
 W !,"*   The date in the APPLICABLE DATE OF TEST column is the date of means test ",!,"    which is used to determine this Means Test indicator",!,"**  Denotes no date of means test on or before this date; therefore, an"
 W !,"    appropriate means test indicator cannot be determined",!!?35,"-",DGPAG,"-",! Q
HDR D:DGPAG>0 PG D:(IOST?1"C-".E) CONT Q:DGQUIT  W @IOF,!,"PTF Means Test Indicator of 'U' Report",?58,"Printed:  " S Y=DT X ^DD("DD") W Y,!,"For ",$S(DGD:"discharge",1:"admission")," date range from "
 S Y=DGSD+.1 X ^DD("DD") W $P(Y,"@")," to " S Y=DGED X ^DD("DD") W $P(Y,"@"),!,"Sorted by ",$S(DGP:"patient last name",1:"terminal digit order")
 W !!,"The following PTF Records have a Means Test Indicator of 'U' (means test is",!,"not done or not completed):",!!?48,"PTF",?56,"* APPLICABLE",!,"PATIENT NAME",?35,"SSN",?48,"NUMBER",?56,"DATE OF TEST",!,DGLN S DGPAG=DGPAG+1 Q
PRT S DGSB="" F I=0:0 S DGSB=$O(^UTILITY($J,"DGPTFU",DGSB)) Q:DGSB']""!(DGQUIT)  S DGNAME="" F N=0:0 S DGNAME=$O(^UTILITY($J,"DGPTFU",DGSB,DGNAME)) Q:DGNAME']""  S SSN="" F Y=0:0 S SSN=$O(^UTILITY($J,"DGPTFU",DGSB,DGNAME,SSN)) Q:SSN']""  D LN
 Q
CONT Q:DGPAG=0  F N=$Y:1:(IOSL-2) W !
 R ?22,"Enter <RET> to continue or ^ to QUIT ",N:DTIME S:N["^"!('$T) DGQUIT=1 Q
NONE W @IOF,!,"No PTF records with Means Test Indicators of 'U' within "_$S(DGD:"discharge",1:"admission")_" date range selected"
Q K ^UTILITY($J,"DGPTFU"),DGLN,Y,PTF,DGADM,DGD,DGED,DGP,DGSD,DGTOT,DGMTDT,DGDT,DGSB,DGPAG,DGDATE,DGNAME,DGQUIT,DFN,SSN,N,I Q
