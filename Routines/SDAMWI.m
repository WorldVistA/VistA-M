SDAMWI ;ALB/MJK - Unscheduled Appointments ; 5/3/05 5:50pm
 ;;5.3;Scheduling;**63,94,241,250,296,380,327**;Aug 13, 1993
 ;
EN(DFN,SC) ; -- main entry point
 ;    input: DFN ; SC := clinic#
 ; returned: success or fail := 1/0
 ;
 N SDY,SDAPTYP,SDRE,SDRE1,SDIN,SDSL,SDD,SDALLE,SDATD,SDDECOD,SDEC,SDEMP,SDOEL,SDPL,SDRT,SDSC,SDTTM,COLLAT,SDX,SDSTART,ORDER,SDREP,SDDA,SDCL
 D 2^VADPT I +VADM(6) W !!?5,*7,"o  Patient has died!" D PAUSE^VALM1 S SDY=0 G ENQ
 S SDCL=SC,SDSL=$S($D(^SC(SC,"SL")):+^("SL"),1:""),SDD=0
 K SDRE,SDIN,SDRE1
 I $D(^SC(SC,"I")) S Y=^("I"),SDIN=+Y,SDRE=+$P(Y,U,2),SDRE1=$$FDATE^VALM1(SDRE)
 I $D(SDIN),SDIN,SDIN'>DT,SDRE,SDRE>DT W !!?5,*7,"o  Clinic is inactive from ",$$FTIME^VALM1(SDIN)," to "_SDRE1 D PAUSE^VALM1 S SDY=0 G ENQ
 I $D(SDIN),SDIN,SDIN'>DT,'SDRE W !!?5,*7,"o  Clinic is inactive as of ",$$FTIME^VALM1(SDIN) D PAUSE^VALM1 S SDY=0 G ENQ
 N SDRES S SDRES=$$CLNCK^SDUTL2(SC,1)
 I 'SDRES W !,?5,*7,"o  Clinic MUST be corrected before continuing." D PAUSE^VALM1 S SDY=0 G ENQ
 I '$$TIME(.DFN,.SC,.SDT) D WL^SDM1(SC) S SDY=0 G ENQ ;SD/327
 S Y=SDT D ^SDM4 I X="^" S SDY=0 G ENQ
 ; ** SD*5.3*250 MT Blocking check removed
 ;S X="EASMTCHK" X ^%ZOSF("TEST") I $T N EASACT S EASACT="W" I $$MT^EASMTCHK(DFN,+$G(SDAPTYP),EASACT) D PAUSE^VALM1 S SDY=0 G ENQ
 ;-- get sub-category for appointment type
 S SDXSCAT=$$SUB^DGSAUTL(SDAPTYP,2,"")
 S SDY=$$MAKE^SDAMWI1(DFN,SDCL,SDT)
 K SDXSCAT
ENQ D KVAR^VADPT
 Q SDY
 ;
TIME(DFN,SC,SDT) ; -- get appt date/time
 ;    input: DFN ; SC := clinic#
 ;   output: SDT := date/time of wi appt
 ; returned: success or fail := 1/0
 ;
 N SDY,%DT
ASK R !!,"APPOINTMENT TIME: NOW// ",X:DTIME S X=$$UPPER^VALM1(X)
 I X["^"!('$T) S SDY=0 G TIMEQ
 I X?.E1"?" D  G ASK
 .W !,"  Enter a time or date@time for the appointment or return for 'NOW'."
 .W !,"The date must be today or earlier."
 S:X=""!(X="N")!(X="NO") X="NOW"
 I X'="NOW",X'["@" S X="T@"_X
 S %DT="TEP",%DT(0)=-(DT+1) D ^%DT G ASK:Y<0 S SDT=Y
 G:'$$CANCHK(.SC,.SDT) ASK
 I $D(^DPT(DFN,"S",SDT,0)) W !?5,*7,"o  Patient already has an appt on ",$$FTIME^VALM1(SDT) G ASK
 S SDY=1
TIMEQ Q SDY
 ;
CANCHK(SC,SDT) ; -- is clinic cancelled for date
 ;    input: SC := clinic# ; SDT := date/time of wi appt
 ; returned: success or fail := 1/0
 ;
 N SDY
 S SDY=1
 I $D(^SC(SC,"ST",$P(SDT,"."))),'$D(^SC(SC,"ST",$P(SDT,"."),"CAN")) G CANCHKQ
 I $D(^SC(SC,"ST",$P(SDT,"."),"CAN")),$G(^SC(SC,"ST",$P(SDT,"."),1))["CANCEL" W !?5,*7,"o  This date's clinic has been cancelled!" S SDY=0 G CANCHKQ
 I $D(^SC(SC,"ST",$P(SDT,"."),"CAN")),$G(^SC(SC,"ST",$P(SDT,"."),1))'["CANCEL" W !?5,*7,"o  Warning: Part of this day's clinic has been cancelled!" G CANCHKQ
 S SDY=$$AVAIL(.SC,.SDT)
CANCHKQ Q SDY
 ;
AVAIL(SC,SDT) ; -- does clinic meet
 ;    input: SC := clinic# ; SDT := date/time of wi appt
 ; returned: success or fail := 1/0
 ;
 N SDY
 S X=$P(SDT,".") D DOW^SDM0
 I $D(^SC(SC,"T"_Y)) S Z=$O(^SC(SC,"T"_Y,DT)) I Z'="",$D(^SC(SC,"T"_Y,Z,1)),^(1)]"" S SDY=1 G AVAILQ
 W !?5,*7,"o  Clinic does not meet on this date!" S SDY=0
AVAILQ Q SDY
 ;
CL(DFN) ; -- make wi appt
 ;    input: DFN
 ; returned: success or fail := 1/0
 ;
 S DIC="^SC(",DIC(0)="AEMQ",DIC("A")="Select Clinic: ",DIC("S")="I $P(^(0),U,3)=""C"",'$G(^(""OOS""))"
 D ^DIC K DIC
 I Y<0 S SDY=0 G CLQ
 S SC=+Y S SDY=$$EN(.DFN,.SC)
CLQ Q SDY
 ;
PT(SC) ;
 ;    input:  SC := clinic#
 ; returned: success or fail := 1/0
 ;
 S DIC="^DPT(",DIC(0)="AEMQ",DIC("A")="Select Patient: "
 D ^DIC K DIC
 I Y<0 S SDY=0 G PTQ
 S DFN=+Y S SDY=$$EN(.DFN,.SC)
PTQ Q SDY
 ;
