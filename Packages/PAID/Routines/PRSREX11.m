PRSREX11 ;HISC/JH-T & L EXPENDITURE REPORT (Continued) ;7/9/97
 ;;4.0;PAID;**2,19,26**;Sep 21, 1995
 D INIT,PRINT
 K TAB1,TAB2
 Q
 ;
PRINT ;routine to loop through temp global and print employee expenditures
 S PP=0 F I=0:0 S PP=$O(^TMP($J,"EXP",PP)) Q:PP'>0  D:PP'=PP(1) HDR1 S:PP(1)="" SW(7)=0 D  Q:POUT
 .  S TLE="" F I=0:0 S TLE=$O(^TMP($J,"EXP",PP,TLE)) Q:TLE=""  D  Q:POUT
 ..  S NAM="" F I=0:0 S NAM=$O(^TMP($J,"EXP",PP,TLE,NAM)) Q:NAM=""  D  Q:POUT
 ...  S D0=0 F I=0:0 S D0=$O(^TMP($J,"EXP",PP,TLE,NAM,D0)) Q:D0'>0  S TIME=^(D0) Q:TIME=""  D  Q:POUT
 ....  D:$Y>(IOSL-5) HDR Q:POUT
 ....  W !,"|",$E(NAM,1,20),?21,"|"
 ....  W $J($P(TIME,"^",1),12,2),?34,"|",$J($P(TIME,"^",2),7,2),?42,"|"
 ....  W $J($P(TIME,"^",3),6,2),?48,"|",$J($P(TIME,"^",4),8,2),?58,"|"
 ....  W $J($P(TIME,"^",5),6,2),?65,"|",$J($P(TIME,"^",6),6,2),?72,"|"
 ....  W $J($P(TIME,"^",7),8,2),?80,"|",$J($P(TIME,"^",8),7,2),?88,"|"
 ....  W $J($P(TIME,"^",9),7,2),?96,"|"
 ....  W $J($P(TIME,"^",10),10,2),?107,"|",$J($P(TIME,"^",11),8,2),?117,"|",$J($P(TIME,"^",12),12,2),?131,"|"
 ....  S PP(1)=PP,NAM(1)=NAM
 ....  Q
 ...  Q
 ..  Q:POUT  D VLIDSH S TOT=^TMP($J,"EXP1",PP,TLE)
 ..  W !,"|",?6,"T&L ",TLE," Total:",?21,"|",$J($P(TOT,U),12,2),?34,"|",$J($P(TOT,U,2),7,2),?42,"|",$J($P(TOT,U,3),6,2),?48,"|",$J($P(TOT,U,4),8,2),?58,"|"
 ..  W $J($P(TOT,U,5),6,2),?65,"|",$J($P(TOT,U,6),6,2),?72,"|",$J($P(TOT,U,7),8,2),?80,"|",$J($P(TOT,U,8),7,2),?88,"|",$J($P(TOT,U,9),7,2),?96,"|"
 ..  W $J($P(TOT,U,10),10,2),?107,"|",$J($P(TOT,U,11),8,2),?117,"|",$J($P(TOT,U,12),12,2),?131,"|" D VLIN0 S PP(2)=PP,PP(2)=$O(^TMP($J,"EXP",PP(2))) I PP(2)'=""  I IOSL<66 F II=$Y:1:IOSL-5 D VLIN0
 ..  Q
 .  Q:POUT  I PP(2)'="" S SW=1 D HDR S SW=0 Q
 .  Q
 Q:POUT  D VLIN0,VLIDSH W !,"|","Totals:",?21,"|",$J(TOTAL(1),12,2),?34,"|",$J(TOTAL(2),7,2),?42,"|",$J(TOTAL(3),6,2),?48,"|",$J(TOTAL(4),8,2),?58,"|"
 W $J(TOTAL(5),6,2),?65,"|",$J(TOTAL(6),6,2),?72,"|",$J(TOTAL(7),8,2),?80,"|",$J(TOTAL(8),7,2),?88,"|",$J(TOTAL(9),7,2),?96,"|"
 W $J(TOTAL,10,2),?107,"|",$J(TGOV,8,2),?117,"|",$J(TOTAL+TGOV,12,2),?131,"|"
 I IOSL<66 F I=$Y:1:IOSL-5 D VLIN0
 S SW=1 D HDR S SW=0
 Q
 ;
HDR S CODE="E001",FOOT="VA TIME & ATTENDANCE SYSTEM" D VLIDSH0,FOOT1^PRSRUT0
 I $E(IOST,1,2)="C-" R !,"Press Return to continue. ",II:DTIME S:II="^" POUT=1
 Q:POUT!(SW=1)
 ;
HDR1 W:'SW(7)!($E(IOST)="C") @IOF
 D SETTABS
 W !?TAB1
 W ^TMP($J,"EXP")," ",$S(PP'="":"- "_PP,1:"- ALL"),?(IOM-14),"DATE: ",DAT
 W !?TAB2,"T&L Unit:  ",$G(TLEU),"    Year: ",YEAR,!! D
 .  W !,"|",?21,"|","BASE",?34,"|","NIGHT",?42,"|","HOLIDA",?48,"|","O/TIME",?58,"|","SUNDAY",?65,"|","ON-CA",?72,"|",?81,"|","REEMP",?89,"|","SAT",?97,"|","GROSS",?108,"|","G/SHARE",?117,"|","GROSS",?131,"|"
 .  W !,"|","NAME",?21,"|","PAY",?34,"|","DIFF",?42,"|","PAY",?49,"|","PAY",?58,"|","PAY",?65,"|","PAY",?72,"|","AWARDS",?81,"|","ANNUIT",?89,"|","PAY",?97,"|","PAY",?108,"|","BENEFITS",?117,"|","COST",?131,"|" D VLIDSH0 Q
 Q
 ;
VLIDSH0 W !,"|--------------------|------------|-------|------|--------|------|------|--------|-------|-------|----------|--------|-------------|" Q
VLIDSH W !,"|",?21,"| -----------| ------| -----| -------| -----| -----| -------| ------| ------| ---------| -------| ------------|" Q
VLIN0 W !,"|",?21,"|",?34,"|",?42,"|",?49,"|",?58,"|",?65,"|",?72,"|",?81,"|",?89,"|",?97,"|",?108,"|",?117,"|",?131,"|" Q
 ;
INIT ; initialize tabs and flags
 S (PP(1),NAM(1))="",SW=0,SW(7)=1
 ;
 ; save off the user entered T&L unit for the report, since we 
 ; have to set TLE to null to traverse the TMP global.
 S TLEU=TLE
 Q
SETTABS ;set tabs for report header lines
 S TAB1=IOM-$L(^TMP($J,"EXP")_" "_$S(PP'="":"- "_PP,1:"- ALL"))\2
 S TAB2=IOM-$L("T&L Unit:  "_$G(TLE)_"    Year: "_YEAR)\2
 Q
