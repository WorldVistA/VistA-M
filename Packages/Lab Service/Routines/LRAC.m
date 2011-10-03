LRAC ;SLC/DCM/MILW/JMC - CUMULATIVE REPORTS DRIVER ;2/20/91  08:33 ;
 ;;5.2;LAB SERVICE;**172**;Sep 27, 1994
 ;Routine has been change to handle separate file room scheduling.
 ;;Semi-automatic queuing of selected reports can occur by setting-up
 ;;an action type option:  S LRX(x)="" D CLOCK^LRAC
 ;;Where 'x' is the internal number of the report desired.
 ;;Fields 200,201,202 of OPTION file should then be filled in.
 K DIC,LRX
 ;
 ;
 D ^LRPARAM ;---HOAK FOR PRINTER PROBLEMS
 ;
 R !,"Print ALL or SELECTED reports? ALL// ",X:DTIME S:X="" X="A" Q:".^"[X
 I "AaSs"'[$E(X) S X="?"
 I X["?" W !?5,"Enter 'S' for SELECTED reports ",!?18,"-or-",!?11,"'A' for ALL reports" G LRAC
 I "Ss"[$E(X,1) D  Q:'$D(LRX)
 . W ! ; Allow user to select reports to print.
 . S DIC="^LAB(64.5,1,3,",DIC(0)="AEMQ",DIC("A")="Select REPORT NAME: "
 . ; Screen out file room reports if printing separate file room, use appropiate option.
 . I $P($G(^LAB(64.5,1,6)),U,2) S DIC("S")="I '$P($G(^LAB(64.5,1,3,Y,.1)),U,3)"
 . F  D ^DIC Q:Y<1  S LRX(+Y)=""
 . K DIC W !
 S U="^" D DT^LRX
 S ZTRTN="CLOCK^LRAC",ZTIO="",ZTDESC="Laboratory cumulative report" S:$D(LRX) ZTSAVE("LRX*")="" D ^%ZTLOAD
 K LRX,X,ZTSK,ZTSAVE,ZTDESC,ZTIO,ZTRTN
 Q
 ;
CLOCK S:$D(ZTQUEUED) ZTREQ="@" K ZTSK
CL2 Q:'$D(^LAB(64.5,1,3))!($D(^LAC("LRAC","A")))
 S LRXLR="LRAC" S:'$D(LRPERM) LRPERM=0
 S LRFRSEP=$P($G(^LAB(64.5,1,6)),U,2) ; Set flag if printing separate file rooms.
 I $D(XRTL) S XRTN="LRAC" D T0^%ZOSV ; START RESPONSE TIMING LOG
 I '$D(LRDT) S %DT="",X="T-1" D ^%DT S LRDT=Y
 L +^LAB(64.5)
 ;---last date cime printed--\/
 S LRLDT=$P(^LAB(64.5,1,0),U,3)
 ;
 I $L(LRLDT) D:LRDT'=LRLDT ^LRACK
 S %DT="",X="T" D ^%DT S LRYDT=Y,U="^",LRBOT=$P(^LAB(64.5,1,0),U,2)
 I LRDT'=LRLDT D ENT^LRACKL S $P(^LAB(64.5,1,0),U,3)=LRDT,$P(^(0),U,7)=LRLDT
 L -^LAB(64.5) S LRRE=0
 I '$D(LRX) D CL3
 I $D(LRX) D CL4
 I $D(XRTL),$D(XTR0) S XRTN="LRAC" D T1^%ZOSV ;STOP RESPONSE TIME LOG
 K LRRE,LRX,LRXLR,X1,X2,Z
 Q
CL3 ; Task "ALL" reports except file room if file room on separate schedule.
 S LRRPTN=0
 F  S LRRPTN=$O(^LAB(64.5,1,3,LRRPTN)) Q:LRRPTN<1  D
 . S X=$G(^LAB(64.5,1,3,LRRPTN,.1)) Q:$P(X,U,2)  ; Don't start "manual" reports.
 . I LRFRSEP,$P(X,U,3) Q  ; Don't start "File Room" report if on separate schedule.
 . S IOP=$P(X,U,1) D:IOP'="" CL3A
 K LRBOT,LRDFN,LRDT,LRFRSEP,LRLDT,LRLLOC,LRNM,LRRPTN,LRYDT,X,Y,ZTSAVE,ZTSK
 Q
 ;
CL3A ; Task the actual reports to run.
 N ZTIO ; Tasked jobs have ZTIO defined, want ZTLOAD to build from IO* variables.
 S %ZIS="N" D ^%ZIS I POP D ^%ZISC Q
 S ZTRTN="ENT^LRAC1",ZTDTH=$H,ZTDESC="Laboratory cumulative report" K ZTSK
 F I="LRPERM","LRXLR","LRDT","LRLDT","LRYDT","LRBOT","LRRE","LRRPTN" S ZTSAVE(I)=""
 D ^%ZTLOAD,^%ZISC
 Q
 ;
CL4 ; Task selected reports.
 S LRRPTN=0
 F  S LRRPTN=$O(^LAB(64.5,1,3,LRRPTN)) Q:LRRPTN<1  I $D(LRX(LRRPTN)) D
 . S X=$G(^LAB(64.5,1,3,LRRPTN,.1))
 . I LRFRSEP,$P(X,U,3) Q  ; Don't start "File Room" report if on separate schedule.
 . S IOP=$P(X,U,1) D:IOP'="" CL3A
 K LRBOT,LRDFN,LRDT,LRFRSEP,LRLDT,LRLLOC,LRNM,LRRPTN,LRX,LRYDT,X,Y,ZTSAVE,ZTSK
 Q
