SDCLAV1 ;ALB/LDB - OUTPUT PATTERNS (cont.) ; 9/1/00 10:57am
 ;;5.3;Scheduling;**140,167,168,76,383,463,490,517,533,509**;Aug 13, 1993;Build 37
 ;
 ;PATCH 383 STOPPED REPORT FROM CREATING AVAILIBILTY-TEH
 ;
S2 N I1,SC,SDAV,SDMED,SI,SL,SM,SS,STARTDAY,SDDD,YCNT,SDFRST
 S P=0 F D=0:0 S D=$O(^UTILITY($J,"SDNMS",D)) Q:D'>0!(SDUP)  S SDV="",SDZ2=SDBD F X5=0:0 S SDV=$O(^UTILITY($J,"SDNMS",D,SDV)) Q:SDV=""!SDUP  S SDC=$P(^UTILITY($J,"SDNMS",D,SDV),"^",3) D S ;Q:SDUP  ;D WR ;,SS
 Q
S1 S SD=^SC(SDC,0),D=$S($P(SD,"^",15):$P(SD,"^",15),1:$P(^DG(43,1,"GL"),"^",3)),SD5=0,SDNM=$P(SD,"^")
 S $P(^UTILITY($J,"SDNMS",D,SDNM),"^",3)=SDC Q
S I '$D(^SC(SDC,"SL")) D SDM,HDR W !!,"THIS CLINIC DOES NOT HAVE APPT. LENGTH" Q
 S (SDZ,SDZ2)=SDBD D SDM,HDR,TIME S SDZ=SDBD-1,SD0=0,SDMED=SDED+.9
 N X,SDSOH S SC=+SDC,SL=^SC(SC,"SL"),X=$P(SL,U,3),STARTDAY=$S($L(X):X,1:8),X=$P(SL,U,6),SI=$S(X="":4,X<3:4,X:X,1:4),X=SDBD,SDSOH=$P(SL,"^",8),SM=$S($E(X,4,5)[12:$E(X,1,3)+1_"01",1:$E(X,1,3)_$E(X,4,5)+1)_"00",SDZ=SDBD
 N POP S POP=0  ;SD/517
LOOP D SDM D:0&$E(SDZ,2,5)=$E(SDZ1,2,5) MON I $E(SDZ,2,5)'=$E(SDZ1,2,5) I 'SDUP D X1 I 'SDUP D A I 'SDUP D:SD0!($E(IOST,1,2)="C-") 3 I 'SDUP D WR I 'SDUP,$E(IOST,1,2)="C-" D 3
 D:POP MSG  ;SD/517
 I 'SDUP I X<SDED S (X,SDZ2)=$S($E(X,4,5)=12:$E(X,1,3)+1_"01",1:$E(X,1,5)+1)_"01",SDZ=X D SDM,HDR,TIME G LOOP
 D:POP MSG  ;SD/517
 Q
 ;
MSG ;Added SD/517
 D WARN
 Q
 ;
SS Q:SDUP  S SDZ=SDZ1,SD5=1
 D A Q:SDUP  D 3 Q:SDUP  D WR Q:SDUP  D:$E(IOST,1,2)="C-" 3 Q
MON Q:'$D(^SC(+SDC,"ST",SDZ,1))  S SDPT=^SC(+SDC,"ST",SDZ,1) D SDPT1
 Q
SDPT1 I YCNT+6>IOSL D:$E(IOST,1,2)="C-" 3 Q:SDUP  D HDR,TIME
 W !,SDPT S SDAP=SDZ-1 F Z=1:1 S SDAP=$O(^SC(SDC,"S",SDAP)) Q:SDAP'>0!(SDAP>(SDZ+.9999))!SDUP  D NM^SDCLAV0
 D YCNT
 Q
TIME ;SD/533 $Select defaults to 8 when Z5=0, so a Midnight to 8am clinic
 ;incorrectly prints available hours as 8am to 4pm instead of 0 to 8am
 ;Two new lines added to fix this and linetag T1 added at Write command
 ;S Z5=$P(^SC(+SDC,"SL"),U,3),SDT=$S(Z5:Z5,1:8),Z5=$P(^("SL"),U,6),SDI=$S(Z5="":4,Z5<3:4,Z5:Z5,1:4)
 S Z5=$P(^SC(+SDC,"SL"),U,3) I Z5=0 S SDT=0,Z5=$P(^("SL"),U,6),SDI=$S(Z5="":4,Z5<3:4,Z5:Z5,1:4) G T1
 S SDT=$S(Z5:Z5,1:8),Z5=$P(^SC(+SDC,"SL"),U,6),SDI=$S(Z5="":4,Z5<3:4,Z5:Z5,1:4)
T1 W !!," TIME",?SDI+SDI-1 F Z6=SDT:1:65\(SDI+SDI)+SDT W $E("|"_$S('Z6:0,1:(Z6-1#12+1))_"                 ",1,SDI+SDI)
 W !," DATE",?SDI+SDI-1,"|" K J F Z7=0:1:6 I $D(^SC(+SDC,"T"_Z7)) S J(Z7)=""
 S YCNT=YCNT+3
 F Z8=1:1:65\(SDI+SDI) W $J("|",SDI+SDI)
 Q
WR N X S (Y3,X1,SDC1,SD0)=0,C=SDZ2
 F S8=C:0 S SDC1=SDC1+1,C=$O(^UTILITY($J,"SDNMS",D,SDV,C)) Q:C'>0!(C>SDMED&('SD5))!SDUP  S SD0=1 D:SDC1=1 HDR1 S X=C D DW^%DTC S Y=C X ^DD("DD") S Y1=$P(Y,"@"),Y2=$P(Y,"@",2),X9=X W:Y1'=Y3 !!,?1,X9,?11,Y1 D WR1 Q:SDUP
 Q:SDUP  I 'SD0 D HDR1 W !!,"No appointments scheduled"
 D:SD0 WR2 S SDZ2=SDZ Q  ;SD/517
WR1 S X4="" F X1=0:0 S X4=$O(^UTILITY($J,"SDNMS",D,SDV,C,X4)) Q:X4=""!SDUP  S X6="" F X2=0:0 S X6=$O(^UTILITY($J,"SDNMS",D,SDV,C,X4,X6)) Q:X6=""  D W1
 Q
 ;
WR2 ;Added SD/517
 D 3 W @IOF D HDR1,DAT
 D A1^SDCLAV
 Q
 ;
HDR N X D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S YCNT=1 W @IOF,!?52,Y D:$E(IOST,1,2)="P-" PG^SDCLAV
 I $D(^DG(43,1,"GL")),$P(^("GL"),"^",2) W !?30,$P(^DG(40.8,D,0),"^")
 W !?30,SDV,!?30,SDM,"  ",($E(SDZ,1,3)+1700) S YCNT=4 Q
HDR1 S SDZ2=$S(SDZ2=0:SDBD,SDZ2>SDED:SDED,1:SDZ2) W !!,?30,SDV,!,?30,$P(SDM1,"^",+$E(SDZ2,4,5)),"  ",($E(SDZ2,1,3)+1700) S YCNT=YCNT+3 Q
SDM S SDM1="JANUARY^FEBRUARY^MARCH^APRIL^MAY^JUNE^JULY^AUGUST^SEPTEMBER^OCTOBER^NOVEMBER^DECEMBER",SDM=$P(SDM1,"^",+($E(SDZ,4,5))) Q
W S SDUT=^UTILITY($J,"SDNMS",D,SDV,C,X4,X6) S D1="" F D8=2,3 S D1=$S($P(SDUT,"^",D8)]"":$P(SDUT,"^",D8),1:"")_D1
 W D1 Q
W1 ;added next 2 lines and changed 3rd line SD/517
 S X=C X ^DD("FUNC",2,1)  ;SD*509 added DO next line to delete corrupt node
 I +^UTILITY($J,"SDNMS",D,SDV,C,X4,X6)=0 D  Q:X4="UNKNOWN"  S X="**WARNING** "_X D W2 Q
 .Q:X4'="UNKNOWN"
 .S N1=^UTILITY($J,"SDNMS",D,SDV,C,X4,X6),SDC=$P(N1,U,2),SDAP1=$P(N1,U,3)
 .S DA(2)=SDC,DA(1)=C,DA=SDAP1
 .S DIK="^SC("_DA(2)_",""S"","_DA(1)_",1," D ^DIK
 .K DA,DIK,N1
 .Q
 D TAB W:T ?10 W:'T ?11 W X,?20,X4,?51,X6 D MIN W ?61,"("_M1_") MINUTES" D W S Y3=Y1,X1=X9 I YCNT+6>IOSL D 3 Q:SDUP  D HDR1,DAT
 Q
 ;
W2 ;added SD/517
 S POP=1
 D TAB W:T ?1 W:'T ?2 W X,?23,X4,?51,X6 D MIN W ?61,"("_M1_") MINUTES" D W S Y3=Y1,X1=X9 I YCNT+6>IOSL D 3 Q:SDUP  D HDR1,DAT
 Q
WARN ;added SD/517
 W @IOF,! D:$E(IOST,1,2)="P-" PG^SDCLAV
 D HDR1,DAT
 W !!,"*************************************************************************"
 W !,"* WARNING: There is a data inconsistency or data corruption problem      *"
 W !,"* with one or more of the above appointments.  These appointments will   *"
 W !,"* have WARNING displayed to the left of the time.  Corrective action     *"
 W !,"* needs to be taken.  Please cancel any of the appointments above, which *"
 W !,"* have the WARNING display.  If any of them are valid appointments, they *"
 W !,"* will have to be re-entered via Appointment Management.                 *"
 W !,"**************************************************************************"
 D 3
 S POP=0
 Q
 ;
3 N X I $E(IOST,1,2)="C-" F X=$Y:1:IOSL-6 W ! D YCNT
 I  R !!,"PRESS RETURN TO CONTINUE OR ^ TO QUIT  ",SDU:DTIME S:SDU="^"!('$T) SDUP=1
 I YCNT+6'<IOSL,'SDUP W @IOF,! S YCNT=1 D:$E(IOST,1,2)="P-" PG^SDCLAV Q
 Q
A N X D:YCNT+13>IOSL 3 Q:SDUP  D INAC^SDCLAV W !!!,"FOR CLINIC AVAILABILITY PATTERNS:"
 W !!?4,"0-9 and j-z",?15," --denote available slots where j=10,k=11...z=26",!?12,"A-W",?15," --denote overbooks with A being the first slot to be overbooked",!?18,"and B being the second for that same time, etc."
 W !?6,"*,$,!,@,#",?15," --denote overbooks or appts. that fall outside of a clinic's",!?18,"regular hours" S YCNT=YCNT+8 Q
TAB W ! S:$L(X)>7 T=1 S:$L(X)<8 T=0 D YCNT Q
MIN S M1=+^UTILITY($J,"SDNMS",D,SDV,C,X4,X6) Q
DAT I $E($O(^UTILITY($J,"SDNMS",D,SDV,C)),2,7)=$E(C,2,7) W !,?1,X1,?11,Y1 D YCNT
 Q
X1 S X1=X\100_$P("31^28^31^30^31^30^31^31^30^31^30^31",U,$E(X,4,5))
 S X1=$$LEAP(X1) I X1>SDED S X1=SDED
 S SDMED=X1+.9,SDAP=X-.01 F  S SDAP=$O(^SC(SDC,"S",SDAP)) Q:SDAP'>0!(SDAP>(X1+.9999))!SDUP  D NM^SDCLAV0
 D DOW S SDDD=Y
WW ;
 I '$D(^SC(+SC,"ST",X,1)),$$CHKDT() S Y=SDDD#7 G L:'$D(J(Y)),H:$D(^HOLIDAY(X))&('SDSOH) S SS=+$O(^SC(+SC,"T"_Y,X)) G L:SS'>0,L:^(SS,1)="" D
 .S ^SC(+SC,"ST",$P(X,"."),1)=$E($P($T(DAY),U,Y+2),1,2)_" "_$E(X,6,7)_$J("",SI+SI-6)_^(1),^(0)=$P(X,".")
 ;SD*5.3*490 added GOTO command so dates prior to clinic start date no
 ;longer display on grid
 S SDAV=1 D:X>SM WM I $D(^SC(+SC,"ST",X,1)),^(1)["["!(^(1)["CANCELLED")!($D(^HOLIDAY(X))) G:X<$O(^SC(+SC,"T",0)) L W !,$E(^SC(+SC,"ST",X,1),1,80) D YCNT S:'$D(^HOLIDAY(X))&('SDAV) SDAV=1
 I YCNT+6>IOSL D 3 Q:SDUP  D HDR
L S X=X+1,SDDD=SDDD+1
 G WW:X'>X1 Q
 ;
WM W !?36 S Y=$E(X,1,5)_"00",SM=$S($E(X,4,5)[12:$E(X,1,3)+1_"01",1:$E(X,1,3)_$E(X,4,5)+1)_"00" D YCNT
DT W $$FMTE^XLFDT(Y) Q
 ;
DOW S Y=$$DOW^XLFDT(X,1) Q
YCNT S YCNT=YCNT+1 Q
 ;
DAY ;;^SUN^MON^TUES^WEDNES^THURS^FRI^SATUR
DIFF S X1=SDRE,X2=X D ^%DTC S SDDD=SDDD+X,X=SDRE,X1=X\100_28 Q
H S ^SC(+SC,"ST",X,1)="   "_$E(X,6,7)_"    "_$P(^(X,0),U,2),^(0)=X G WW
 ;
LEAP(SDEOM) ;Check for leap year, adjust if indicated
 ;Input: SDEOM=end of month date to adjust for leap year
 Q:$E(SDEOM,4,5)'="02" SDEOM  ; only adjust February
 N SDLEAP
 S SDLEAP=$$FMADD^XLFDT(SDEOM,1)
 Q $S($E(SDLEAP,4,5)="02":SDLEAP,1:SDEOM)
CHKDT() ;
 N Y,RET,SDFA
 I '$D(SDFRST(D,+SC)) D
 .; Create array of days that have a current template.
 .N %H,X,SDFMTDAY,SDAYCNT,SDAYI,SDST,SDAYCHK,SDAYNAM,SDAYNUM
 .S %H=$H
 .D YX^%DTC S SDFMTDAY=X
 .S SDAYCNT=0
 .F SDAYI=0:1:6 D
 ..Q:'$D(^SC(+SC,"T"_SDAYI))
 ..I $O(^SC(+SC,"T"_SDAYI,""),-1)'<SDFMTDAY S SDFRST(D,+SC,SDAYI)="",SDAYCNT=SDAYCNT+1
 .; Calculate first available date for each day that has current template.
 .S SDST=0,SDAYCHK=0
 .F  S SDST=$O(^SC(+SC,"ST",SDST)) Q:SDST=""!(SDAYCHK=SDAYCNT)  D
 ..S SDAYNAM=$E($G(^SC(+SC,"ST",SDST,1)),1,2)
 ..S SDAYNUM=$S(SDAYNAM="MO":1,SDAYNAM="TU":2,SDAYNAM="WE":3,SDAYNAM="TH":4,SDAYNAM="FR":5,SDAYNAM="SA":6,SDAYNAM="SU":0,1:"")
 ..Q:SDAYNUM=""
 ..Q:$G(SDFRST(D,+SC,SDAYNUM))'=""
 ..Q:'$D(^SC(+SC,"T"_SDAYNUM))
 ..S SDFRST(D,+SC,SDAYNUM)=SDST,SDAYCHK=SDAYCHK+1
 ; Get first avail date from array for particular day of week
 S Y=SDDD#7,RET=0
 S SDFA=$G(SDFRST(D,+SC,Y))
 I SDFA'="" D
 .S SDFA=$S(+$H>SDFA:+$H,1:SDFA)
 .I X'<SDFA S RET=1
 Q RET
