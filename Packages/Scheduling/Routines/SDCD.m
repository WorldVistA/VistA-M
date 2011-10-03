SDCD ;BSN/GRR - DISCHARGE PATIENT FROM CLINIC ;3/15/91  11:24 ;
 ;;5.3;Scheduling;**41,148**;AUG 13, 1993
15 D:'$D(DT) DT^SDUTL I '$G(SDFN) S DIC="^DPT(",DIC(0)="AEQM" D ^DIC G:Y=-1 QUIT
 S:$G(SDFN) Y=+SDFN S DA(2)=+Y
 I '$G(SDCLN) G:'$D(^DPT(+Y,"DE")) NOPE S DIC="^DPT("_DA(2)_",""DE"",",DIC("S")="I $P(^(0),""^"",2)']""""",VAUTSTR="clinic",VAUTNI=2,VAUTVB="VAUTC" D FIRST^VAUTOMA K DIC("S") Q:Y<0
 I $G(SDCLN) D  G QUIT:'$O(VAUTC(0))
 .S VAUTC=0,VAUTC(+$O(^DPT(DA(2),"DE","B",+SDCLN,99999),-1))=+SDCLN
 .I '$O(VAUTC(0)) W !!,*7,">>> Patient not enrolled in '",$S($D(^SC(+SDCLN,0)):$P(^(0),"^"),1:"Unknown"),"' clinic." S SDAMERR=1
 I VAUTC=1 F I=0:0 S I=$O(^DPT(DA(2),"DE",I)) Q:'I  S CLINIC=^DPT(DA(2),"DE",I,0) I $P(CLINIC,U,2)']"" S VAUTC(I)=+CLINIC
 D BEFORE^SCMCEV3(DA(2)) ;setup before values
 F I=0:0 S I=$O(VAUTC(I)) Q:'I  S DA(1)=I,SC=VAUTC(I) D DIS
 I '$O(VAUTC(0)) W !!,*7,">>> Patient is not actively enrolled in any clinics." S SDAMERR=1
 I '$D(SDAMERR) D AFTER^SCMCEV3(DA(2)) ;setup after values
 ;call team event driver
 I '$D(SDAMERR) D INVOKE^SCMCEV3(DA(2))
 G 15:'$G(SDFN)
QUIT ;
 K CLINIC,DFN,SC,SDF,SDST,VAUTC,VAUTD,VAUTNI,VAUSTR,VAUTVB,DIC
 Q
DIS ;
 S SDF=0
 I $P(^DPT(DA(2),"DE",DA(1),0),"^",2)]"" W *7,*7,!,"PATIENT ALREADY DISCHARGED FROM '",$S($D(^SC(SC,0)):$P(^(0),U),1:"UNKNOWN"),"' CLINIC",*7,*7 S SDAMERR=1 Q
 W !!,"***Discharging patient from ",$S($D(^SC(SC,0)):$P(^(0),U),1:"UNKNOWN")," Clinic***",!
 F XX=DT_.2359:0 S XX=$O(^DPT(DA(2),"S",XX)) Q:XX'>0  I $P(^(XX,0),"^",1)=SC,$P(^(0),"^",2)=""!($P(^(0),"^",2)="I") W !?10,*7,"PATIENT HAS FUTURE APPOINTMENT(S) IN THIS CLINIC" S SDF=1
 I 'SDF F XX=0:0 S XX=$O(^DPT(DA(2),"DE",DA(1),1,XX)) Q:XX=""  D STAT I SDST']"" S DIE="^DPT("_DA(2)_",""DE"","_DA(1)_",1,",DA=XX,DR="3"_$S($G(SCDISCH):"///"_SCDISCH,1:"")_";I 'X S Y=0;I X S XD=1;4" D ^DIE
 W !,*7,"Patient ",$S('$D(XD):"NOT ",XD=2:"ALREADY ",1:""),"Discharged from clinic !!",! S:SDF SDF=0,SDAMERR=1 K XD
 Q
NOPE W !,*7,"PATIENT NOT ENROLLED IN ANY CLINICS!!" G QUIT:$G(SDFN),15
STAT ;ck if already discharged
 S SDST=$P(^DPT(DA(2),"DE",DA(1),1,XX,0),U,3) Q:SDST']""
 S DIE="^DPT("_DA(2)_",""DE"","_DA(1)_",1,",DA=XX,DR="3////^S X=SDST"
 L @(DIE_XX_")"):2 G:'$T STAT D ^DIE L  S:'$D(XD) XD=2 Q
