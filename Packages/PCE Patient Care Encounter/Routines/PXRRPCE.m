PXRRPCE ;HIN/MjK - Clinic Specific Workload Reports ;8/28/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,146**;Aug 12, 1996
EN D CLEAN^PXRRPCEQ K ^TMP($J) I '$D(PXRRDEMG) S VAUTD=1
CLSTOP ;_._._._._._._._._._._Clinic Vs Stop Code_._._._._._._._._._._.
 D HDR^PXRRPCR,MEAN^PXRRPCR:$D(PXRRDEMG) S PXRI=1,DIR(0)="SA^H:HOSPITAL LOCATION;S:CLINIC STOP CODE",DIR("A")="Select clinic(s) by (H)OSPITAL LOCATION or CLINIC (S)TOP CODE: " D ^DIR K DIR G:$D(DIRUT) QT G STOP:Y="S" W !
CLIN ;_._._._._._._._._.Select Clinic for Report_._._._._._._._._.
 S DIC="^SC(",DIC(0)="QAENMZ",DIC("S")="I $P(^(0),U,3)=""C""!($P(^(0),U,3)=""Z"")",DIC("A")=$S(PXRI=1:"Select HOSPITAL LOCATION name: ",1:"Another HOSPITAL LOCATION name: ")
 D ^DIC I Y>0 S VAUTC=0 S:'$D(PXRI(+Y)) VAUTC(+Y)=+Y S PXRRCLIN(PXRI)=Y(0,0)_U_+Y,PXRI=PXRI+1,PXRI(+Y)="" G CLIN
 K DIC G QT:'$D(PXRRCLIN)!($D(DUOUT))
STOP ;_._._._._._._._._.Select Stop Code for Report_._._._._._._._._.
 I '$D(PXRRCLIN) W ! S DIC=40.7,DIC(0)="QAENMZ",DIC("A")="Select the CLINIC STOP code: ",DIC("S")="I $P($G(^(0)),U,3)=""""" D ^DIC K DIC G:Y<0 QT S PXRRSC=+Y,PXRSTPNM=Y(0,0)
DTRANGE ;_._._._._._._._._.Select Date Range For Values_._._._._._._._._.
 W !! S DIR(0)="DA^2931001:DT:PXEX",DIR("A")="Enter ENCOUNTER BEGINNING DATE: ",DIR("??")="^D BDT^PXRRPCR"
 D ^DIR K DIR G:Y'>0 QT S (PXRRBDT,SDBD)=Y+.0001,DIR(0)="DA^"_$P(SDBD,".")_":DT:PXEX",DIR("A")="Enter ENCOUNTER ENDING DATE: ",DIR("B")=$$FMTE^XLFDT(DT),DIR("??")="^D EDT^PXRRPCR" D ^DIR K DIR I Y'>0 G QT
 S (PXRREDT,SDED)=Y+.9999
ZIS W ! K IOP,IO("Q") S POP=0,%ZIS="QM" D ^%ZIS K %ZIS,IOP G:POP QT
 I $D(IO("Q")) K IOP S ZTRTN=$S($D(PXRRSC):"ST^PXRRPCE",1:"DEMOGR^PXRRPCE"),ZTDESC="PCE CLINICAL DATA REPORTS",ZTSAVE("PXR*")="",ZTSAVE("SD*")="",ZTSAVE("V*")="" D LOAD G QT
STOPCL U IO I $D(PXRRSC) D STPVAUTC
 G:$D(PXRRDEMG) DEMOGR
 ;_._._._._._._._._Clinic Workload Variables_._._._._._._._._._.
ST D:$D(PXRRSC)&('$D(PXRRCLIN)) STPVAUTC
 S VAUTD=1
 S SDCL="",(SDALL,SDADD,SDPRE)=0,SDF="D",SDRT="E",SDS="C",SDNAM=1
6 S (SDOB,SDPG,SDHR,SD1)=0 F I=0:0 S I=$S(VAUTC:$O(^SC(I)),1:$O(VAUTC(I))) Q:'I  D SET^SDCWL3
 I '$D(^TMP($J,"CL")),'$D(^("SC")) G NONE
REPORT G QT:'$D(^TMP($J))
VIS ;_._._._._._._._._._._._.Clinic Workload_._._._._._._._._._._._._
 I '$D(PXRRCASE)&('$D(PXRRDEMG)) D ^PXRRPCE1,^PXRRPCR1 G QT
ACTIVTY ;_._._._._._._._._._._._Caseload Activity_._._._._._._._._._._._.
 I $D(PXRRCASE) D ^PXRRPCE2,^PXRRPCR2 G QT
DEMOGR ;_._._._._._._._._._._._Caseload Demographics_._._._._._._._._._.
 I $D(PXRRDEMG) D  G QT
 .  S PXRC=0 F  S PXRC=$O(PXRRCLIN(PXRC)) Q:'PXRC  S PXRRCLIN=$P(PXRRCLIN(PXRC),U,2) D ^PXRRPCE3,CLEAN^PXRRPCEQ
 .  D:$D(^TMP($J,"CLINIC TOTALS")) MEAN^PXRRPCE5
 .  S PXR=0 F  S PXR=$O(PXRRCLIN(PXR)) Q:'PXR  S PXRRCLIN=$P(PXRRCLIN(PXR),U,2)  D ^PXRRPCR3
QT D ^%ZISC,^PXRRPCEQ Q
CQT K PXRRCLIN,PXRRBDT,PXRREDT,PXRSTPNM
NONE D HDR^PXRRPCR  W !?5,"o There were no appts for this clinic in this date range",!?5,"o Note: This report is run from patient appts., not clinic enrollment." G QT
LOAD D ^%ZTLOAD
 I $D(ZTSK)=0 W !,"Request Cancelled"
 E  W !,"Request queued, task number "_ZTSK
 S:'$D(ZTSK) X="^" I $D(ZTSK),'$D(ZTQUEUED) N POP D ^%ZISC G QT
 Q
STPVAUTC ;_._.Set up VAUTC array for Stop Code_._._.
 S (VAUTC,X)=0 F  S X=$O(^SC("AC","C",X)) Q:'X  I $P($G(^SC(X,0)),U,7)=PXRRSC D
 . I '$D(^SC(X,"I")) S VAUTC(X)=X,PXRRCLIN(PXRI)=$P(^SC(X,0),U)_U_X,PXRI=PXRI+1 Q
 . S Y=$G(^SC(X,"I")) I $P($G(Y),U,2)>$P($G(Y),U) S VAUTC(X)=X,PXRRCLIN(PXRI)=$P(^SC(X,0),U)_U_X,PXRI=PXRI+1
 Q
