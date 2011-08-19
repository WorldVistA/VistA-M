RTSM4 ;MJK/TROY ISC;Site Manager's Menu(cont); ; 5/15/87  9:01 AM ;
 ;;v 2.0;Record Tracking;**13,14**;10/22/91 
 ;
CHK ;H 3 K I S:$D(^UTILITY("RTDPTSORT","START")) I=$P(^("START"),"^",2) G CHKQ:'$D(I)
 ;I I'=S W !!,"Global compilation seems to be progressing in an ordering fashion.",!?40,"[Current DFN being processed: ",I,"]" D MES Q
 ;W !!,"The global compilation seems to have STOPPED.",!,"However, it did not finish to completion."
 ;S RTZ("S")=S,RTRD(1)="Yes^check again",RTRD(2)="No^stop checking",RTRD("B")=1,RTRD("A")="Do you want to check again? ",RTRD(0)="S" D SET^RTRD S S=RTZ("S") K RTRD,RTZ G CHK:$E(X)="Y"
CHKQ D 12^RTSM1
XMES ;W !!?3,"Outpatient labels cannot be created until ^UTILITY(""RTDPTSORT"")",!?3,"is totally compiled." Q
 ;
MES W !!,?2,$S('$D(RTIRE):"Outpatient labels",1:"Retirement pull lists")
 W " cannot be created until the RECORD TRACKING SORT GLOBAL"
 W !?2,"is totally compiled."
 ;
 Q
16 ;;Initialize Request By Clinics
 S X="T",%DT="" D ^%DT K %DT S DT=Y,%DT(0)=Y D DATE^RTUTL G Q16:'$D(RTEND) S:RTEND'["." RTEND=RTEND_".9999"
 S RTDESC="Clinic Record Request Initialization Routine",RTVAR="RTBEG^RTEND",RTPGM="START^RTSM4" D ZIS^RTUTL G Q16:POP S RTAPLX=RTAPL,RTDIVX=RTDIV D START S RTAPL=RTAPLX,RTDIV=RTDIVX K RTAPLX,RTDIVX G Q16
START U IO D NOW^%DTC S Y=$E(%,1,12) D D^DIQ W @IOF,!,"Clinic Record Requests Initialization Program",!!,"Start    Time: ",Y S RTBKGRD="",RTMASS=+^DIC(195.4,1,"MAS"),RTRAD=+^("RAD") D GET^RTSM6
 S RTMAS=RTMASS
 F RTSC=0:0 S RTSC=$O(^SC(RTSC)) Q:'RTSC  I $D(^SC(RTSC,0)),$P(^(0),"^",3)="C" D APP
 S RTMAS=RTMASS,RTBKGRD=""
 D ^RTSM61
 W !!,"Number of requests made or reaffirmed:"
 F Z=0:0 S Z=$O(RTSCOUNT(RTMASS,Z)) Q:'Z  S Y=Z D D^DIQ W !?3,Y," = ",$E(RTSCOUNT(RTMASS,Z)_"     ",1,6)_$S($D(RTSCOUNT(RTRAD,Z)):" X-ray Requests = "_RTSCOUNT(RTRAD,Z),1:"")
 I '$D(RTSCOUNT(RTMASS)),'$D(RTSCOUNT(RTRAD)) W " 0"
 D NOW^%DTC S Y=$E(%,1,12) D D^DIQ W !!,"Finished Time: ",Y
 ;
Q16 K RTEXCLUD,Z,RTMASS,RTMAS,RTDESC,RTVAR,RTPGM,DFN,RTSC,RTTM,RTPL,SDSC,SDTTM,SDPL,RTSCOUNT,RTBEG,RTEND D CLOSE^RTUTL
 K DA,D0,DIE,DIC,DR,%DT,RTA,RTBKGRD,RTRAD,X,Y,%I Q
APP I $D(^RTV(195.9,"ABOR",(RTSC_";SC("),RTMAS)) S X=+$O(^(RTMAS,0)) I '$O(^(X)),$D(^RTV(195.9,X,0)),$P(^(0),"^",14)'="y" Q
 F RTTM=(RTBEG-.0001):0 S RTTM=$O(^SC(RTSC,"S",RTTM)) Q:'RTTM!(RTEND<RTTM)  F RTPL=0:0 S RTPL=$O(^SC(RTSC,"S",RTTM,1,RTPL)) Q:'RTPL  I $D(^(RTPL,0)),$P(^(0),"^",9)'="C" S DFN=+^(0) D RTQ
 Q
 ;
RTQ S SDSC=RTSC,SDTTM=RTTM,SDPL=RTPL,RTBKGRD="" D CREATE^RTQ2 I $D(^SC(RTSC,"S",RTTM,1,RTPL,"RTR")) F RTMAS=RTMASS,RTRAD D CNT^RTSM6 I '$D(ZTQUEUED) W "."
 S RTMAS=RTMASS
 Q
REQ S Y=1 I $D(^RTV(195.9,"ABOR",(RTSC_";SC("),RTMAS)) S X=+$O(^(RTMAS,0)) I '$O(^(X)),$D(^RTV(195.9,X,0)),$P(^(0),"^",14)="n" S Y=0
 Q
ONETIM I '$D(^RTV(194.3,0)) S ^(0)="RECORD TRACKING SORT GLOBAL^194.3^1^1"
 I '$D(^RTV(194.3,1,0)) S ^(0)="TERMINAL DIGITS^^"
 I '$D(^RTV(194.3,1,1,0)) S ^(0)="^194.31PA^^"
 S (RTCT,LDFN,DFN)=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  DO
 .S ^RTV(194.3,1,1,DFN,0)=DFN
 .S X=DFN D S1943^RTSM1 ;mumps xref
 .S RTCT=RTCT+1,LDFN=DFN I '$D(ZTQUEUED),DFN#1000=0 W DFN,"   "
 S ^RTV(194.3,1,1,0)="^194.31PA^"_LDFN_"^"_RTCT Q
 Q
