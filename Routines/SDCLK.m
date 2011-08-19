SDCLK ;ALB/MJB/MLI - LOOK UP CLERK WHO MADE APPOINTMENT ; 22 FEB 88
 ;;5.3;Scheduling;**63**;Aug 13, 1993
EN D Q W !! S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G Q:Y'>0 S DFN=+Y I '$D(^DPT(DFN,"S")) W !,"No appointments scheduled for this patient." G EN
C K ^UTILITY($J)
 S DIC("A")="Enter CLINIC: ",DIC="^SC(",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,3)=""C"",'$G(^(""OOS""))" D ^DIC G:Y'>0!(X="") EN
 S SDIFN=+Y
 F I=0:0 S I=$N(^DPT(DFN,"S",I)) Q:I'>0  I $D(^(I,0)),($P(^(0),U)=SDIFN) S ^UTILITY($J,"A",10000000-I)=""
 K DIC I '$D(^UTILITY($J,"A")) W "There are no appointments for this patient to this clinic." G C
A K SDD R !,"Enter APPOINTMENT DATE/TIME: ",X:DTIME G C:X="^"!(X="")!('$T) S %DT="ETPX",%DT(0)=2820100 G L:X["??",H:X["?" D ^%DT G A:Y'>0 I '$D(^UTILITY($J,"A",10000000-Y)) G ON:X'["."&(Y>2820100) D H G A
 S SDA=Y
P Q:'$D(^DPT(DFN,0))  S SDS=$P(^(0),U,9) W !,"Patient Name",?32,": ",$P(^(0),U),?60,"SSN: ",$E(SDS,1,3),"-",$E(SDS,4,5),"-",$E(SDS,6,10),!,"Clinic Name",?32,": ",$S($D(^SC(SDIFN,0)):$P(^(0),U),1:""),!,"Appointment Date/Time",?32,": "
 K SDS S Y=SDA D DT^DIQ F I=0:0 S I=$N(^SC(SDIFN,"S",SDA,1,I)) Q:I'>0!'$D(^(I,0))  I $P(^(0),U)=DFN S SDS=^(0),SDC=$P(SDS,U,6) Q
 I '$D(SDS) S (SDS,SDC)=""
 K SDC1,SDC2 S:$P(^DPT(DFN,"S",SDA,0),"^",18) SDC1=$P(^DPT(DFN,"S",SDA,0),"^",18) S:$P(^DPT(DFN,"S",SDA,0),"^",19) SDC2=$P(^DPT(DFN,"S",SDA,0),"^",19)
 W !!,"Appointment Made By",?32,": " S:$D(SDC1) SDC=SDC1 W:SDC $S($D(^VA(200,SDC,0)):$P(^(0),U),1:"") W !,"Date Appointment Made",?32,": " S Y=$P(SDS,U,7) S:$D(SDC2) Y=SDC2 D DT^DIQ W !,"Purpose of Visit",?32,": "
 S SDP=$S($D(^DPT(DFN,"S",SDA,0)):^(0),1:""),SDS=$P(SDP,U,2),SDPP=$P(SDP,U,7),SDP3=$P(SDP,U,14) W $S(SDPP=1:"C&P",SDPP=2:"10-10",SDPP=3:"SCHEDULED VISIT",SDPP=4:"UNSCHED. VISIT",1:"")
 K DIC,X,Y S SDAP=0 S:$P(SDP,U,16) SDAP=$P(SDP,U,16) W !,"Appointment Type",?32,": " I SDAP S SDAP1=$P(^SD(409.1,SDAP,0),"^") W SDAP1
 I $P(SDP,U,17) W !,"Appt. Cancelled to make ",!,"this appt.",?32,": ",$P(^SC($P(SDP,U,17),0),U)
STATUS W !!,"Appointment Status",?32,": " S SDSTAT=^DD(2.98,3,0) F SD9=1:1:8 I SDS=$P($P($P(SDSTAT,"^",3),";",SD9),":") W $P($P($P(SDSTAT,"^",3),";",SD9),":",2)
 I SDP3 S SDP1=$S($P(SDP,U,12):$P(^VA(200,$P(SDP,U,12),0),U,1),1:"") W !,"No-show/Cancelled By",?32,": ",SDP1 S Y=SDP3 W !,"No-show/Cancel Date/Time" W ?32,": " D DT^DIQ
 S SDP2=$P(SDP,U,15) I SDP2 W !,"Cancellation Reason",?32,": ",$P(^SD(409.2,SDP2,0),U) I $D(^DPT(DFN,"S",SDA,"R")) W !,"Cancellation Remarks",?32,": " F X5=0:46:$L(^("R")) W ?34,$E(^("R"),X5,X5+45),!
 S SDP4=$P(SDP,U,10) I SDP4 S Y=SDP4 W !,"Rescheduled for",?32,": " D DT^DIQ
 W ! K DIC,X,X5,Y,I,SD9,SDA,SDAP,SDAP1,SDD,SDP1,SDP2,SDP3,SDP4,SDQ I $D(SD) F I=1:1:SD K ^UTILITY($J,"A",I)
 G A
Q K ^UTILITY($J,"A"),%DT,DIC,DIPGM,DFN,I,SDIFN,J,N,SD,SDA,SDB,SDC,SDD,SDE,SDF,SDFT,SDP,SDPP,SDQ,SDS,SDSTAT,SDC1,SDC2,C,%,%Y,X,Y Q
ON S Y=10000000-Y,SDB=Y+.1,SDE=Y-.9,(J,N)=0 F I=SDE:0 S I=$N(^UTILITY($J,"A",I)) Q:I'>0!(I>SDB)  S J=J+1,SDD(J,10000000-I)=""
 I J=1 S SDA=0,SDA=$N(SDD(J,SDA)) G P
 I '$D(SDD) W !,"No appointments on date selected." G A
 W @IOF,"Choose from: " F I=1:1:J W !,?5,I,")",?9 S X=0,X=$N(SDD(I,X)) D ^%DT
QA W !,"Enter a number  1-",J,": " R X:DTIME G A:X="^"!(X="")!('$T),QA:X["?"!(X<1)!(X>J) S N=$N(SDD(X,N)) S SDA=N G P
H W !!,"Enter:",!,"(1)  '??' to see a list of appointments.",!,"(2)  Date alone to see appointments for this patient to this clinic on a date.",!,"(3)  A valid appointment date after JAN 1, 1982.",!! G A
L S (SD,SDF,SDFT)=0 F I=0:0 S I=$N(^UTILITY($J,"A",I)) Q:I'>0  S SD=SD+1,^UTILITY($J,"A",SD,10000000-I)=""
 F I=1:1:SD S Y=0,Y=$N(^UTILITY($J,"A",I,Y)) W !,?5,I,")",?12 D DT^DIQ D:'(I#5) P5 G P:SDF,Q:$D(SDQ)
 S SDFT=1
P5 W !,"Enter a number 1-",I," or '^' to exit: " R X:DTIME S:(X="^")!('$T) SDQ="" Q:X=""!$D(SDQ)&('SDFT)  G Q:$D(SDQ),P5:(I=SD)&(X="")!$S($L(X)>5:1,X<1:1,X>I:1,X'=+X:1,1:0) S SDA=0,SDA=$N(^UTILITY($J,"A",X,SDA)) G:SDFT P S SDF=1 Q
