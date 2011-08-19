SRSCD ;B'HAM ISC/MAM - SCHEDULE OF OPERATIONS (SCREEN FORMAT) ; [ 10/13/98  10:19 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
 W @IOF,!,"List of Scheduled Operations:",!
DT S SRQ=0,%DT="AEFX",%DT("A")="List Scheduled Operations for which date ?  " D ^%DT G:Y<1 END S SRSDATE=Y
BEG W !!,"Do you want to sort by OPERATING ROOM, SPECIALTY or WARD LOCATION ? " R Z:DTIME S:'$T Z="^" G:"^^"[Z END S Z=$E(Z)
 I "OoSsWw"'[Z W !!,"Enter 'O' to sort the schedule by operating room, 'S' to sort by specialty",!,"or 'W' to sort by ward." G BEG
 S Y=SRSDATE D D^DIQ S SRDATE=Y G:"Ss"[Z ^SRSCDS G:"Ww"[Z ^SRSCDW
ROOM ; sort by operating room 
 S (SROR,SROR("N"))="" K ^TMP("SR",$J) W !!,"Do you want a list of scheduled operations for all rooms ?  YES//  " R Z:DTIME S:'$T Z="^" G:Z["^" END S:Z="" Z="Y"
 S Z=$E(Z) I "NnYy"'[Z W !!,"Enter 'NO' to list the scheduled operations for a specific operating room,",!,"or RETURN to list the scheduled cases for all rooms." G ROOM
 I "Nn"[Z W !! S DIC("S")="I $$ORDIV^SROUTL0(+Y,$G(SRSITE(""DIV""))),('$P(^SRS(+Y,0),U,6))",DIC=131.7,DIC(0)="QEAMZ" D ^DIC G:Y<0 END S SROR=+Y,SROR("N")=$P(^SC($P(Y,"^",2),0),"^")
 W ! K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the list on which device: ",%ZIS="Q" D ^%ZIS G:POP END I $D(IO("Q")) K IO("Q") S ZTDESC="SCHEDULED OPERATIONS",ZTRTN="ALL^SRSCD" D ZTSAVE,^%ZTLOAD G END
ALL ; entry when queued
 U IO S (SRQ,SRZ)=0 G:"Nn"[Z ONE S SROR=0 F  S SROR=$O(^SRF("AOR",SROR)) Q:'SROR!SRQ  I $$ORDIV^SROUTL0(SROR,$G(SRSITE("DIV"))) S SROR("N")=$P(^SC($P(^SRS(SROR,0),"^"),0),"^") D OR
 D PRINT I '$D(^TMP("SR",$J)) D HDR W $$NODATA^SROUTL0()
 G END
ONE ; list scheduled cases for a specific room
 D OR,PRINT I '$D(^TMP("SR",$J)) D HDR W $$NODATA^SROUTL0()
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRQ,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 D ^SRSKILL K SRTN D ^%ZISC W @IOF
 Q
LOOP ; break procedure if greater than 65 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRQ=1 Q
 S SRZ=1 W:$Y @IOF W !,?20,"* Scheduled Operations for "_SROR_" *",!,?30,SRDATE,!!,"Start Time",?13,"Patient",?43,"Surgical Specialty",?67,"Ward Location",!,?13,"ID #",! F LINE=1:1:80 W "="
 Q
OR S SRTN=0 F  S SRTN=$O(^SRF("AOR",SROR,SRSDATE,SRTN)) Q:'SRTN!SRQ  I $P($G(^SRF(SRTN,31)),"^",4),$$DIV^SROUTL0(SRTN) S SRST=$P(^SRF(SRTN,31),"^",4) D UTL
 Q
UTL ; set ^TMP("SR",$J)
 I SRZ,$Y+5>IOSL D PAGE Q:SRQ  D HDR Q:SRQ
 S DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S SRNM=VADM(1),SRSSN=VA("PID"),SRWARD=$S($D(^DPT(DFN,.1)):$P(^(.1),"^"),1:""),SRSOP=$P(^SRF(SRTN,"OP"),"^"),SRSS=$P(^SRF(SRTN,0),"^",4) I SRWARD="" D WARD
 I SRSS S SRSS=$P(^SRO(137.45,SRSS,0),"^")
 S Y=SRST D D^DIQ S SRFIND=$F(Y,":"),SRTIME=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 S:SRSS="" SRSS="NOT ENTERED" S SRSS=$P(SRSS,"(")
 S ^TMP("SR",$J,SROR("N"),SRST)=SRNM_"^"_SRSOP_"^"_SRWARD_"^"_SRSS_"^"_SRTIME_"^"_SRSSN
 Q
PRINT ; loop through ^TMP and print cases
 S (SROR,SRST,SRZ)=0 F  S SROR=$O(^TMP("SR",$J,SROR)) Q:SROR=""!SRQ  D:SRZ PAGE Q:SRQ  D HDR F  S SRST=$O(^TMP("SR",$J,SROR,SRST)) Q:'SRST!SRQ  D OUT
 Q
OUT ; output data
 I $Y+5>IOSL D PAGE Q:SRQ  D HDR Q:SRQ
 S SR=^TMP("SR",$J,SROR,SRST),SROPER=$P(SR,"^",2) K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,$P(SR,"^",5),?12,$P(SR,"^"),?43,$P(SR,"^",4),?67,$P(SR,"^",3),!,?12,$P(SR,"^",6),!,?12,SROPS(1) I $D(SROPS(2)) W !,?12,SROPS(2) I $D(SROPS(3)) W !,?12,SROPS(3)
 W ! F LINE=1:1:80 W "-"
 Q
PAGE I $E(IOST,1)'="P" W !!,"Press RETURN to continue or '^' to quit.  " R X:DTIME I '$T!(X="^") S SRQ=1
 Q
ZTSAVE S (ZTSAVE("SRDATE"),ZTSAVE("SROR"),ZTSAVE("SROR(""N"")"),ZTSAVE("SRQ"),ZTSAVE("SRSDATE"),ZTSAVE("Z"),ZTSAVE("SRSITE*"))=""
 Q
WARD ; check for scheduled admission
 S (X,PEND)=0 F  S PEND=$O(^DGS(41.1,"B",DFN,PEND)) Q:'PEND  S PDATE=$P(^DGS(41.1,PEND,0),"^",2) I PDATE>DT S SRWARD="ADM. PENDING",X=1
 Q:X=1  S SRWARD="OUTPATIENT"
 Q
