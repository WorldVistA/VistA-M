SCRPW7 ;RENO/KEITH - Patient Encounter List ; 15 Jul 98  02:38PM
 ;;5.3;Scheduling;**139,144,466**;AUG 13, 1993;Build 2
ASK N DIC,%DT D TITL^SCRPW50("Patient Encounter List")
 W ! S DIC="^DPT(",DIC(0)="AZEMQ" D ^DIC G:$D(DTOUT)!$D(DUOUT) EXIT G:Y'>0 EXIT S SDPT=$P(Y,U),SDPTNA=$P(Y,U,2),SDPTSN=$P(Y(0),U,9)
 I '$D(^SCE("ADFN",SDPT)) W !!,$C(7),"This patient has no encounters on file.",! H 3 G ASK
 D SUBT^SCRPW50("*** Date Range Selection ***")
FDT W ! S %DT="AEPX",%DT("A")="Beginning date:  FIRST// ",%DT(0)="-TODAY" D ^%DT G:X=U!($D(DTOUT)) EXIT I X="" S Y=$O(^SCE("ADFN",SDPT,0)),(Y,SDBDT)=$P(Y,".") X ^DD("DD") W "   ",Y S SDPBDA=Y G LDT
 G:Y<1 FDT S SDBDT=Y X ^DD("DD") W "   ",Y S SDPBDA=Y
LDT W ! S %DT("A")="Ending date:  LAST// " D ^%DT G:X=U!($D(DTOUT)) EXIT I X="" S (Y,SDEDT)=DT X ^DD("DD") W "   ",Y S SDPEDA=Y W ! G QUE
 I Y<SDBDT W !!,$C(7),"Ending date must be after beginning date!",! G LDT
 G:Y<1 LDT S SDEDT=Y X ^DD("DD") W "   ",Y S SDPEDA=Y
QUE S SDEDT=SDEDT+.9999 N ZTSAVE F X="SDPT","SDPTNA","SDPTSN","SDBDT","SDPBDA","SDEDT","SDPEDA" S ZTSAVE(X)=""
 W ! D EN^XUTMDEVQ("PEL^SCRPW7","Patient Encounter List",.ZTSAVE) G ASK
 ;
PEL S SDPAGE=1,SDLINE="",$P(SDLINE,"=",(IOM+1))="",SDOUT=0,SDP=$S($E(IOST)="C":6,1:4),SDDT=SDEDT D:$E(IOST)="C" DISP0^SCRPW23 D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW="Date printed: "_$P(Y,":",1,2),SDCT=0
 D HDR Q:SDOUT  F  S SDDT=$O(^SCE("ADFN",SDPT,SDDT),-1) Q:'SDDT!SDOUT!(SDDT<SDBDT)  S SDOE=0 F  S SDOE=$O(^SCE("ADFN",SDPT,SDDT,SDOE)) Q:'SDOE!SDOUT  S SDOE0=$$GETOE^SDOE(SDOE) D:$L(SDOE0) DISP S SDCT=SDCT+1
 I 'SDCT S X="No encounters found within this date range!" W !!?(IOM-$L(X)\2),X,!
END I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
EXIT D END^SCRPW50 K %,%I,%H,SDBDT,SDPBDA,SDCT,SDEDT,SDPEDA,SDP,SDLINE,SDPAGE,SDDT,SDI,SDL,SDOE,SDOE0,SDOUT,SDPT,SDPNOW,SDPTNA,SDPTSN,SDS,SDS1,SDT,DTOUT,DUOUT,Y,X Q
 ;
STOP ;Check for stop task request
 S:$G(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
HDR W:SDP=6!(SDPAGE>1) $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0)
 D STOP Q:SDOUT  W SDLINE I SDP=4!(SDPAGE=1) W !?(IOM-32/2),"<*>  PATIENT ENCOUNTER LIST  <*>",!,SDLINE,!,"Date range: ",SDPBDA," to ",SDPEDA,?(IOM-$L(SDPNOW)),SDPNOW
 W !,"Patient: ",SDPTNA,?40,"SSN: ",SDPTSN,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1
 Q
 ;
DISP S SDL=$P($G(^SC(+$P(SDOE0,U,4),0)),U),SDT=$P(SDOE0,U,8),SDT=$S(SDT=1:"Appointment",SDT=2:"Stop Code Addition",SDT=3:"Disposition",SDT=4:"Credit Stop Code",1:""),SDS=$P($G(^SD(409.63,+$P(SDOE0,U,12),0)),U)
 S SDS1=$$COTS(SDOE) D:$Y>(IOSL-SDP) WAIT Q:SDOUT  S Y=SDDT X ^DD("DD") W !,Y,?30,SDL,!?5,"#",SDOE,?15,SDT,?35,SDS W:$L(SDS1) " - ",SDS1 W ! F SDI=1:1:80 W "-"
 Q
 ;
WAIT I SDP=4 D HDR Q
 W ! K DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1
 D:Y HDR Q
 ;
COTS(SDOE) Q:$P(SDOE0,U,6) "Child of enc. #"_$P(SDOE0,U,6)
 I $P(SDOE0,U,4),$P($G(^SC($P(SDOE0,U,4),0)),U,17)="Y" Q ""
 Q:"^CHECKED OUT^INPATIENT APPOINTMENT^"'["^"_SDS_"^" ""  Q $P($$STX^SCRPW8(SDOE,SDOE0),U,2)
