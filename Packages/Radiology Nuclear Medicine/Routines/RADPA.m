RADPA ;HISC/GJC AISC/MJK,RMO-Look-up Rad/Nuc Med Patients ;4/17/96  11:41
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
PAT S Y=-1 Q:'$D(DIC(0))
 N RAFLG,RAY S RAFLG=+$G(^DISV(DUZ,"^DPT(")),RAY=0
 S:RAFLG>0 ^DISV(DUZ,"^RADPT(")=RAFLG
 ; If RAOPT("REG") exists, allow addition of new patient to file 70.
 ; RAOPT("REG") set in entry action of RA REG
 I RAFLG,($D(RAOPT("REG"))),('$D(^RADPT("B",RAFLG))) D  Q:RAY=-1
 . F  D  Q:RAY=-1!($D(X))
 .. R !,"Select Patient: ",X:DTIME
 .. S:'$T!(X["^")!(X']"") RAY=-1 Q:RAY=-1
 .. I X["?" S X="??",DIC("W")="W """"",DIC(0)="MLEZ" Q
 .. I X=" " D  Q
 ... S X=$P($G(^DPT(RAFLG,0)),"^"),DIC("W")="W """"",DIC(0)="MLEZ"
 ... Q
 .. I $L(X)<3!($L(X)>30)!(X?1P.E)!(X'?1A.ANP) D
 ... W !?5,"Enter patient name in 'Last,First Middle' format [3-30 characters].",$C(7) K X
 ... Q
 .. E  S DIC("W")="W """"",DIC(0)="MLEZ"
 .. Q
 . Q
 I '$D(DIC("W")),('$D(^RADPT("B",RAFLG))),($D(RAOPT("REG"))) D
 . S DIC(0)="AQELMZ"
 . Q
 S RAIC(0)=DIC(0),DLAYGO=70,DIC="^RADPT(",DIC("DR")=".06////"_DUZ
 S:'$D(DIC("A"))&(DIC(0)["A") DIC("A")="Select Patient: "
 W ! D ^DIC K DLAYGO I Y>0 S:RAIC(0)["L" RAPTFL=""
 I Y=-1,(X["?"),('$D(^RADPT("B",RAFLG))),($D(RAOPT("REG"))) G PAT
 ;
Q I Y>0,$D(DUZ)'[0,DUZ S ^DISV(DUZ,"^DPT(")=+Y S:$D(^DIC(195.4,1,"RAD")) ^DISV(DUZ,"RT",+^("RAD"))=+Y_";DPT("
 K DIC("A"),DIC("DR"),RAIC Q
1 S DIC(0)="AEMQL" D PAT K DIC,RAIC Q:Y<0  S DIE="^RADPT(",DA=+Y,DR=".04;.05;1" D ^DIE K %,%Y,C,D,D0,DA,DE,DQ,DIE,DR,RAPTFL Q
