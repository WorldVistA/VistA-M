SRSWL ;B'HAM ISC/MAM - PRINT WAITING LIST; 3 Feb 1989  1:38 PM
 ;;3.0; Surgery ;;24 Jun 93
 Q:'$D(SRSERV)  S SRTS="" I SRSERV'="" S SRTS=$O(^SRO(137.45,"B",SRSERV,0)),SRTS=$P(^SRO(137.45,SRTS,0),"^")
 S (SR,SRHDR,Z)=0 D HDR S (SRSWDT,SRSDPT,SROP)=0 F  S SRSWDT=$O(^SRO(133.8,"AWL",SRSERV,SRSWDT)) Q:SRSWDT'>0!SR  F  S SRSDPT=$O(^SRO(133.8,"AWL",SRSERV,SRSWDT,SRSDPT)) Q:SRSDPT=""  Q:SR  D MORE
 I $D(SRSDEL),'$D(MM) D NUM S:'$D(MM) SR=1
END K IO("Q"),OPT
 Q
LOOP ; break procedure if greater than 50 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<50  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
MORE F  S SROP=$O(^SRO(133.8,"AWL",SRSERV,SRSWDT,SRSDPT,SROP)) Q:SROP=""!SR!$D(MM)  S SRSDA(1)=^(SROP) D SET
 Q
HDR W @IOF,!,?10,"Surgery Waiting List" W:SRTS'="" " "_SRTS W !!,"Date Entered",?14,"Patient",?29,"Procedure",! F I=1:1:80 W "-"
 Q
SET ;
 I $Y+13>IOSL D PAGE G:ZZ="^" END
 D:SRHDR HDR S SRHDR=0
 S Z=Z+1,SRW(Z)=SRSERV_"^"_SRSWDT_"^"_SRSDPT_"^"_SROP_"^"_SRSDA(1),DFN=SRSDPT D DEM^VADPT S SRSDFN=VADM(1) I $L(SRSDFN)>16 S SRSDFN=$P(SRSDFN,",")_", "_$E($P(SRSDFN,",",2))
 K SROPS,MM,MMM S SROPER=SROP S:$L(SROPER)<50 SROPS(1)=SROPER I $L(SROPER)>49 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,Z_".",?3,$E(SRSWDT,4,5)_"/"_$E(SRSWDT,6,7)_"/"_$E(SRSWDT,2,3),?12,SRSDFN,?29,SROPS(1) I $D(SROPS(2)) W !,?29,SROPS(2)
 W ! F I=1:1:80 W "-"
 Q
PAGE ;
 I '$D(SRSDEL) W !!,"Press RETURN to continue, or '^' to stop the list  " R ZZ:DTIME S:'$T ZZ="^" S:ZZ="^" SR=1 S SRHDR=1 Q
NUM Q:SR  W !!,"Select a number, or press RETURN to continue:  " R ZZ:DTIME S:'$T ZZ="^" S:ZZ="^" SR=1 Q:ZZ="^"
 I ZZ="" S SRHDR=1 Q
 I 'ZZ!'$D(SRW(ZZ)) W !!,"Enter the number corresponding to the patient that you want to "_$S(SRSDEL:"delete",1:"edit")_", or",!,"press RETURN to continue.  Entering a '^' will exit you from this option." G PAGE
 S MM=ZZ,ZZ="^",SR=0
 Q
