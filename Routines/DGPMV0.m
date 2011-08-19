DGPMV0 ;ALB/MRL/MIR - SPECIAL LOOK-UP FOR LODGERS; 10 MAR 89
 ;;5.3;Registration;;Aug 13, 1993
SPCLU ;Special (quick) look-up for check-out lodgers
 S DGER=0,DIC="^DPT(",DIC(0)="EQMZ" R !,"Check-out PATIENT:  ",X:DTIME I '$T!(X["^")!(X="") S DGER=1 Q
 I X["?" D COHELP G SPCLU
 D ^DIC I Y'>0 G SPCLU
 I '$D(^DGPM("APTT4",+Y)) W !?5,"Patient was never a lodger ??" G SPCLU
 S DFN=+Y
 Q
COHELP ;help for check-out lodgers...list patients to choose from
 W !," ANSWER WITH PATIENT, OR SOCIAL SECURITY NUMBER, OR WARD LOCATION, OR",!,"     ROOM-BED",!,"CHOOSE FROM:"
 S (DGCT,DGFL)=0
 F DFN=0:0 S DFN=$O(^DGPM("APTT4",DFN)) Q:'DFN  I $D(^DPT(DFN,0)) D DEM^VADPT I VADM(1)]"" S DGCT=DGCT+1 D WRITE Q:DGFL
 D KVAR^VADPT K DGCT,DGFL,DFN,DIR,X,Y Q
WRITE ;write out identifiers
 I DGCT>(IOSL-4) S DIR(0)="E" D ^DIR I 'Y S DGFL=1 Q
 W !?4,VADM(1),"   ",VA("PID"),"   " I VADM(3) W $E(VADM(3),4,5),"-",$E(VADM(3),6,7),"-",$E(VADM(3),2,3)
 Q
