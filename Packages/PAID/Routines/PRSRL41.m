PRSRL41 ;HISC/JH-INDIVIDUAL EMPLOYEE LEAVE USAGE PATTERN (Continued) ;09/24/01
 ;;4.0;PAID;**2,19,21,35,69**;Sep 21, 1995
 S ORG=$E(ORG,1,12)
 D HDR1
 S (PP(1),DAY(1),DATT(1))=""
 S DATE(1)=0
 ;
 ;initialize leave arrays, subscripted by ("AL","SL","ML","WP"...)
 F I=1:1 S X=$P($P(LVT,";",I+1),":") Q:X=""  S LEV(X)="",TLEV(X)=""
 D TYPSTF^PRSRUT0
 S INX=0
 ;
 ;Loop through LEAVE pattern temp global.
 ;
 ;debug line
 ;W !!,"LEAVE PATTERN TEMP GLOBAL: "," ^TMP(",$J,",USE," Q
 F I=0:0 S INX=$O(^TMP($J,"USE",INX)) Q:INX'>0  D  Q:POUT
 .;
 .; Loop through each pay period.
 .  S PP=""
 .  F I=0:0 S PP=$O(^TMP($J,"USE",INX,PP)) Q:PP=""  S SW(1)=0 D  Q:POUT
 ..;
 ..;  Loop through the dates within the pay period.
 ..   S DATE=0
 ..   F I=0:0 S DATE=$O(^TMP($J,"USE",INX,PP,DATE)) Q:DATE'>0  D  Q:POUT
 ...;
 ...; Loop through days of week (even though only one per loop)
 ...    S DAY=""
 ...    F I=0:0 S DAY=$O(^TMP($J,"USE",INX,PP,DATE,DAY)) Q:DAY=""  S TOUR=$G(^(DAY)) Q:TOUR=""  S SW(3)=0 D  Q:POUT
 ....;
 ....     D:($Y>(IOSL-5)) HDR Q:POUT
 ....     S DATT=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 ....     D CHK,VLIN0:X>1
 ....     W !,"|"
 ....     W $S(PP'=PP(1):$E(PP,3,7),1:"")
 ....     W ?7,"|",DAY,?12,"|"
 ....     W $S(DATT'=DATT(1):DATT,1:""),?22,"|" D
 .....    D:TOUR["DO" DAY
 .....    I TOUR'["DO" F K=1:4 Q:$P(TOUR,"^",K+2)=""  S LEV=$P(TOUR,"^",K+2),%=$F(LVT,";"_LEV_":") W:SW(3) !,"|",?7,"|",?12,"|",?22,"|" D
 ......     W:%>0 ?23,LEV
 ......     W ?27,"|",$P(TOUR,"^",K)
 ......     W ?35,"|",$P(TOUR,"^",K+1)
 ......     W ?43,"|"
 ......     S Z="^^"_DATE_"^"_$P(TOUR,"^",K)_"^"_DATE_"^"_$P(TOUR,"^",K+1) D
 .......    S COM=$G(^TMP($J,"US",INX))
 .......    D D^PRSRLL:$P($E(LVT,%,999),";")="ML"!(SW(2)=77),H^PRSRLL:$P($E(LVT,%,999),";")'="ML"&(SW(2)=73) W $S(SW(2)=77:$J(TIM,6),1:$J(TIM,6,2)),?($X+1),TYL,?52,"|",$S($D(COM):$E(COM,1,26),1:""),?79,"|" D
 ........     S LEV(LEV)=LEV(LEV)+TIM,TLEV(LEV)=TLEV(LEV)+TIM S SW(1)=SW(1)+1,SW(3)=1
 ........  Q
 .......  Q
 ......  Q
 .....  S PP(1)=PP,DATT(1)=DATT,DAY(1)=DAY,DATE(1)=DATE Q
 ....  Q
 ...  Q
 ..  Q
 .  Q
 ;
 ; Print Totals
 ;
 Q:POUT
 D:$Y>(IOSL-7) VLIN0,HDR Q:POUT
 I SW(1) D VLIN0 W !,"|",?7,"|",?12,"|",?15,"TOTALS:" S (SW(3),TLEV)=0,X="" D
 .  F I=0:0 S X=$O(TLEV(X)) Q:X=""  D:$Y>(IOSL-5) HDR Q:POUT  S %=$F(LVT,";"_X_":") W:SW(3)&(TLEV(X)'="") !,"|",?7,"|",?12,"|",?22,"|" S TLEV=TLEV+TLEV(X) D
 ..  W:TLEV(X)'="" ?24,$P($E(LVT,%,999),";"),?44,$S(SW(2)=77:$J($G(TLEV(X)),6),1:$J($G(TLEV(X)),6,2)),?($X+1),TYL,?52,"|",?79,"|" S:'SW(3)&(TLEV(X)'="") SW(3)=1
 ..  Q
 .  Q
 I IOSL<66 F I=$Y:1:IOSL-6 D VLIN0
 Q
CHK S X1=DATE,X2=DATE(1) D ^%DTC Q
DAY W TOUR,?27,"|",?35,"|",?43,"|",?52,"|",?79,"|" S SW(1)=SW(1)+1 Q
HDR S CODE="L005",FOOT="VA TIME & ATTENDANCE SYSTEM" D VLIDSH0,FOOT2^PRSRUT0
 I $E(IOST)="C"!($G(IOT)="VTRM") R !,"Press Return/Enter to continue. ",II:DTIME S:II="^" POUT=1 Q:POUT
 Q:POUT
HDR1 ; Main header for report contains:
 ; Title, ALL/ONLY, date, date range, employee, cost center, T&L unit
 ;
 ; Subheader according to type of report user selected
 S SUBHDR=$S(ALOO="A":"All Leave Taken With Days Off",1:"Every Occurance of Leave, ONLY Before And After Days Off")
 W @IOF
 W !?29,^TMP($J,"USE"),?66
 W "DATE: ",DAT,!?22,"from: ",XX," to ",YY
 W !,?(80-$L(SUBHDR))\2,SUBHDR ;tab depending on length of subheader
 W !?25,"for: ",NAM," - "
 W ORG,!,?33
 W "T&L Unit:  ",TLE
 D VLIDSH0
 W !,"|","P/P",?7,"|","DAY",?12,"|","DATE",?22,"|","TYPE",?27,"|","FROM",?35,"|","TO",?43,"|","LENGTH",?52,"|","COMMENT",?79,"|" D VLIDSH0 Q
VLIDSH0 W !,"|------|----|---------|----|-------|-------|--------|--------------------------|" Q
VLIN0 W !,"|",?7,"|",?12,"|",?22,"|",?27,"|",?35,"|",?43,"|",?52,"|",?79,"|" Q
ASKDSPLY() ; Ask user if they want to see all leave, including days off and
 ; Holidays or if they want to see only leave taken immediately
 ; before or after Holidays and days off.
 N DIR
 S RTN=""
 S DIR(0)="SM^A:All leave;O:Only around days off & holidays"
 S DIR("A")="     Choose A or O "
 S DIR("A",1)="You may display ALL leave taken within the date range"
 S DIR("A",2)="or ONLY leave taken the day before and after holidays"
 S DIR("A",3)="and scheduled days off."
 S DIR("A",4)=""
 S DIR("?",1)="If you select ONLY leave around days off and holidays,"
 S DIR("?",2)="then for example, when an employee with weekends off has"
 S DIR("?",3)="taken annual leave for the entire week (Mon-Fri), only"
 S DIR("?",4)="the leave for Monday and Friday will be displayed."
 S DIR("?")="Selecting ALL, will display all leave taken."
 D ^DIR S RTN=Y
 Q RTN
