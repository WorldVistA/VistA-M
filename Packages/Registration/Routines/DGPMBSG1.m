DGPMBSG1 ;ALB/LM - BED STATUS GENERATION SET UP; 6 JUNE 90
 ;;5.3;Registration;**34**;Aug 13, 1993
 ;
A S (DV,LDV)=+DIV
 D LWD,PWD,LTS,PTS
 Q
 ;
LWD ;  Last Ward
 I $D(^DIC(42,+MV("LWD"),0)) S LW=$S($D(^UTILITY("DGCN",$J,+MV("LWD"))):^(+MV("LWD")),1:RD) G LWDQ
 S X="^DIC(42,+MV(""LWD""),0)"
 S ^UTILITY("DGNG",$J,X)="",LW=0,E("LW")="" K X
LWDQ Q
 ;
PWD ;  Previous Ward
 I $D(^DIC(42,+MV("PWD"),0)) S PW=$S($D(^UTILITY("DGCN",$J,+MV("PWD"))):^(+MV("PWD")),1:RD) G PWDQ
 S X="^DIC(42,+MV(""PWD""),0)"
 S ^UTILITY("DGNG",$J,X)="",PW=0,E("PW")="" K X
PWDQ Q
 ;
LTS ;  Last Treating Speciality
 I $D(^DIC(45.7,+MV("LTS"),0)) D TSDIV^DGPMGLG4 S LT=$S($D(^UTILITY("DGSN",$J,LTSDV,+MV("LTS"))):^(+MV("LTS")),1:RD) G LTSQ
 I TSD,$D(^DIC(45.7,+TSD,0)) S MV("LTS")=TSD D TSDIV^DGPMGLG4 S LT=$S($D(^UTILITY("DGSN",$J,LTSDV,+MV("LTS"))):^(+MV("LTS")),1:RD) G LTSQ
 S X="^DIC(45.7,+MV(""LTS""),0)"
 S ^UTILITY("DGNGTS",$J,X)="",LT=0,E("LT")="" K X
LTSQ Q
 ;
PTS ;  Previous Treating Speciality
 S Z="PTS"
 I $D(^DIC(45.7,+MV("PTS"),0)) S PT=$S($D(^UTILITY("DGSN",$J,PTSDV,+MV("PTS"))):^(+MV("PTS")),1:RD) G PTSQ
 I TSD,$D(^DIC(45.7,+TSD,0))  D TSDIVP^DGPMGLG4 S PT=$S($D(^UTILITY("DGSN",$J,PTSDV,+MV("PTS"))):^(+MV("PTS")),1:RD) G PTSQ
 S X="^DIC(45.7,+MV(""PTS""),0)"
 S ^UTILITY("DGNGTS",$J,X)="",PT=0,E("PT")="" K X
PTSQ Q
