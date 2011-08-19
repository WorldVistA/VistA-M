IBOMTP ;ALB/CPM - MEANS TEST BILLING PROFILE ; 10-DEC-91
 ;;2.0;INTEGRATED BILLING;**153,199**;21-MAR-94
 ;
 S:'$D(DTIME) DTIME=300 D HOME^%ZIS
 ;
ASK ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTP" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBOMTP-1" D T0^%ZOSV ;start rt clock
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DPT(",DIC(0)="AEQMN" D ^DIC K DIC G END:Y<1 S IBDFN=+Y
 ;
 ; Select Start and End dates.
BDT S %DT="AEPX",%DT("A")="Start with DATE: ",%DT("B")="OCT 01, 1990" D ^%DT K %DT G END:Y<0 S IBBDT=Y
EDT S Y=DT D DD^%DT S %DT="EX" W !,"Go to DATE: ",Y,"//" R X:DTIME
 G END:'$T!(X["^") S:X="" X=DT D ^%DT G EDT:Y<0 S IBEDT=Y
 I Y<IBBDT W *7," ??",!,"ENDING DATE must follow BEGINNING DATE.",! G BDT
 ;
 ; Select an output device.
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q") D HOME^%ZIS,END W ! G ASK
 . S ZTRTN="^IBOMTP1",ZTDESC="MEANS TEST BILLING PROFILE"
 . S (ZTSAVE("IBBDT"),ZTSAVE("IBEDT"),ZTSAVE("IBDFN"))=""
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTP" D T1^%ZOSV ;stop rt clock
 D ^IBOMTP1 ; generate report
 D END W ! G ASK ; re-run for next patient
 ;
END ;
 K %DT,IBDFN,IBBDT,IBEDT,X,Y,ZTSK
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTP" D T1^%ZOSV ;stop rt clock
 Q
