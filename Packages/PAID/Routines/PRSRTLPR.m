PRSRTLPR ;HISC/JH-DISPLAY/PRINT SUP.,TIMEKEPPER,OT SUP. ;5/8/95
 ;;4.0;PAID;**2,6,10,16,17**;Sep 21, 1995
FIS S PRSR=2,PRSTLV=3
 ;
 ;Time&Leave selection. Return TLE array populated with info about
 ;the T&L unit the user selected.
 D TLESEL^PRSRUT0 G Q:$G(TLE)=""!(SSN="") W ! S SW=$S(TLE>1:1,1:0)
 S ZTRTN="START^PRSRTLPR",ZTDESC="TIMEKEEPER,SUP.,O/T SUP. REPORT" D ST^PRSRUTL,LOOP,QUE1^PRSRUT0 G Q1:POP!($D(ZTSK))
 ;
START K ^TMP($J,"TLPR")
 S ^TMP($J,"TLPR")="P A I D  T & L  R E P O R T",(CNT,POUT)=0
 ;
 ;set up the TMP global with timekeepers, supervisors, approvers 
 ;on nodes 1,2,3 respectively.  Outer loop controls separate T&L units
 S J=0 F II=0:0 S J=$O(TLE(J)) Q:J'>0  D
 .  S DA(1)=$P(TLE(J),U) Q:DA(1)=""  S DA(2)=$P(TLE(J),U,2) D SORT
 S DAT=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3) U IO D HDR1
 I 'CNT W !,"|",?10,"No Timekeepers, Supervisors or O/T Supervisors on file.",?79,"|" S POUT=1 D NONE
 G Q1:POUT
 S CNT=1,(HOLD,TLE)=""
 ;
 ; PRINT out each T&L unit
 F I=0:0 S TLE=$O(^TMP($J,"TLPR",TLE)) Q:TLE=""  D  Q:POUT
 .;  Get one of each job function to print horizontally.
 .;  quit if all three job function nodes are exhausted.
 .  F II=1:1 S MORE=$$GETNEXT(.TMK,.SUP,.OTA,II)  D  Q:'MORE!(POUT)
 ..  S NAM(1)=$S($P(TMK,U)'="":$E($P($G(^VA(200,$P(TMK,U),0)),U),1,22),1:"")
 ..  S NAM(2)=$S($P(SUP,U)'="":$E($P($G(^VA(200,$P(SUP,U),0)),U),1,22),1:"")
 ..  S NAM(3)=$S($P(OTA,U)'="":$E($P($G(^VA(200,$P(OTA,U),0)),U),1,22),1:"")
 ..  D:$Y>(IOSL-5) HDR Q:POUT  W !,"|",$S(TLE'=HOLD:TLE,1:""),?5,"|",$S(NAM(1)'="":NAM(1),1:""),?28,"|",$S(NAM(2)'="":NAM(2),1:""),?52,$P(SUP,U,2),?56,"|",$S(NAM(3)'="":NAM(3),1:""),?79,"|"
 ..  S HOLD=TLE,CNT=CNT+2 Q
 .  D:'POUT VLIN0 S CNT=1 Q
 I IOSL<66 F I=$Y:1:IOSL-5 D VLIN0
 G Q1:POUT I CNT D VLIN1 S CODE="T001",FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT2^PRSRUT0
Q I $E(IOST)="C" R !!,"Press Return/Enter to continue. ",X:DTIME
Q1 K ANT,CNT,COD,CODE,D0,DA,DAT,DIC,FOOT,HOLD,I,II,J,POP,POUT,PRSR,PRSTLV,NAM,SNT,SSN,SW,TL,TLA,TLE,TLI,TLS,TNT,TLT,TLUNIT,X,Y,Z1,ZTDESC,ZTRTN,ZTSAVE,^TMP($J,"TLPR") D ^%ZISC S:$D(ZTSK) ZTREQ="@" K ZTSK
 Q
GETNEXT(TK,SV,OT,NODE) ;
 ;get the next timekeeper, supervisor, and OT/CT approver
 S RTN=1
 S TK=$G(^TMP($J,"TLPR",TLE,1,NODE))
 S SV=$G(^TMP($J,"TLPR",TLE,2,NODE))
 S OT=$G(^TMP($J,"TLPR",TLE,3,NODE))
 I TK=""&(SV="")&(OT="") S RTN=0
 Q RTN
SORT ;modified by John Heiges patch 17.
 N J,JFN,NEXT
 ;  loop thru job function multiples (timekeep, supervr & OT/CT)
 ;  and store in ^TMP($J,
 ;  JFN = job function node
 ;    timekeepers->node 1, supervisors->node 2, ot/ct approvers->node 3
 ;  DA(1)= T&L unit #
 ;  DA = T&L unit internal entry #
 ;
 ;  get ien of T&L unit
 S DA="" S DA=$O(^PRST(455.5,"B",DA(1),DA)) Q:DA'>0
 ;
 ;  loop thru each job function multiple
 S COD="" F I=0:0 S COD=$O(^PRST(455.5,DA,COD))  Q:COD=""  D
 .  S JFN=$S("T"[COD:1,"S"[COD:2,1:3)
 .  S D0=0 F NEXT=1:1 S D0=$O(^PRST(455.5,DA,COD,D0)) Q:D0'>0  D
 ..  S TL=$P($G(^PRST(455.5,DA,COD,D0,0)),U,2)
 ..  S ^TMP($J,"TLPR",DA(1),JFN,NEXT)=D0_U_TL
 ..  S CNT=1
 ..  Q
 .  Q
 Q
NONE I IOSL<66 F I=$Y:1:IOSL-5 D VLIN0
 D HDR
 Q
HDR D VLIN1 S CODE="T001",FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT2^PRSRUT0
 I $E(IOST)="C" R !,"Press Return/Enter to continue. ",X:DTIME S:'$T!(X="^")!($G(NAM(1))=""&($G(NAM(2))=""&($G(NAM(3))=""))) POUT=1
 Q:POUT
HDR1 W:$E(IOST)="C" @IOF W !?26,^TMP($J,"TLPR"),?66,"DATE: ",DAT,!
 W !,"|",?5,"|",?28,"|",?52,"CERT",?56,"|",?79,"|"
 W !,"|","T&L",?5,"|","TIMEKEEPER",?28,"|","SUPERVISOR",?52,"T&L",?56,"|","O/T SUPERVISOR",?79,"|" D VLIN1 Q
VLIN0 W !,"|",?5,"|",?28,"|",?56,"|",?79,"|" Q
VLIN1 W !,"|----|----------------------|---------------------------|----------------------|" Q
LOOP F X="TLE*","SW" S ZTSAVE(X)=""
 Q
