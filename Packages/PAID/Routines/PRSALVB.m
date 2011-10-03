PRSALVB ;HISC/REL,WIRMFO/JAH - Leave Balances ;09/21/01
 ;;4.0;PAID;**22,35,34,69,114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
EMP ; Employee Entry Point
 S DFN="",SSN=$P($G(^VA(200,DUZ,1)),"^",9) I SSN'="" S DFN=$O(^PRSPC("SSN",SSN,0))
 I 'DFN W !!,$C(7),"Your SSN was not found in both the New Person & Employee File!" G EX
 G D
TK ; Timekeeper Entry Point
 S PRSTLV=2 G S0
SUP ; Supervisor Entry Point
 S PRSTLV=3 G S0
S0 D ^PRSAUTL G:TLI<1 EX
S1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC G:DFN<1 EX
D N HOLD
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSALVB",PRSALST="DFN" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 ; Show Balances
 W:$E(IOST,1,2)="C-" @IOF W !?29,"EMPLOYEE LEAVE BALANCES"
 ;
 ;  Display employee name and ssn
 ;  SSN defaults to display of last four digits
 ;    employee displays last four
 ;    timekeeper and supervisor display first digit+last four
 ;
 S X=$G(^PRSPC(DFN,0))
 W !!,$P(X,"^",1)
 S X=$P(X,"^",9)
 I X,'$G(PRSTLV)!($G(PRSTLV)=1) W ?67,"XXX-XX-",$E(X,6,9)
 I X,$G(PRSTLV)=2!($G(PRSTLV)=3) W ?67,$E(X),"XX-XX-",$E(X,6,9)
 ;
 ; compare last pp processed to current pp
 ;
 S LST=+$P($G(^PRSPC(DFN,"MISC4")),"^",16)
 S D1=DT D PP^PRSAPPU
 S YR=$P(PPE,"-",1)
 S D1=+$P(PPE,"-",2)
 S YR=$S(D1'<LST:YR,1:$E(199+YR,2,3))
 S PPE=YR_"-"_$S(LST>9:LST,1:"0"_LST)
 S PPI=$O(^PRST(458,"B",PPE,0))
 I PPI S D1=$P($G(^PRST(458,PPI,2)),"^",14)
 W !!,"Balances are as of ",D1
 ;
 S C0=^PRSPC(DFN,0),DB=$P(C0,"^",10),LVG=$P(C0,"^",15),NH=+$P(C0,"^",16)
 S ALN=$G(^PRSPC(DFN,"ANNUAL")),SLN=$G(^("SICK")),CTN=$G(^("COMP")),MLN=$G(^("MILITARY"))
 ;
 I NH=48,DB=1 D
 .  S BAY=$G(^PRSPC(DFN,"BAYLOR"))
 .  S $P(ALN,"^",3)=$P(BAY,"^",1)
 .  S $P(SLN,"^",3)=$P(BAY,"^",13)
 .  F KK=9:1:12 S $P(ALN,"^",KK+1)=$P(BAY,"^",KK)
 ;
 W !!,"Leave Group: ",LVG
 S Y=$P(ALN,"^",3)
 W !,"Annual Leave Balance:",?30,$S(Y="":"",1:$J(Y,8,3))
 S Y=$P(SLN,"^",3)
 W !!,"Sick Leave Balance:",?30,$S(Y="":"",1:$J(Y,8,3))
 ;
 ;If employee has something in comptime record
 ; -Determine number & year of last pay period on file for use in
 ;  guessing the year when comp time earned.
 ; -Loop thru comp time values & report.
 ;
 I CTN]"",$P(CTN,U,1,8)'="^^^^^^^" D
 . N KK,LASTPP,LASTYR,Y
 . S Y=+$P($G(^PRST(458,0)),U,3) Q:'Y
 . S LASTPP=+$P($P($G(^PRST(458,Y,0)),U),"-",2) Q:'LASTPP
 . S LASTYR=$P($G(^PRST(458,Y,1)),U) Q:'LASTYR
 . S LASTYR=$E(LASTYR,1,3)+1700
 . W ! F KK=1:1:8 I $P(CTN,"^",KK) D C1
 ;
 ;If employee has restored leave then interpret 1 digit year
 ;on file from AAC and display.
 ;
 S Y=$P(ALN,"^",10) I Y D
 .N YRDIGIT
 .W !!," Restored Leave:",?30,$J(Y,8,3)
 .S YRDIGIT=$P(ALN,"^",12)
 .I YRDIGIT>-1 W !,"Use by end of leave year ",$$BLDYR^PRSLIB00(YRDIGIT)," or forfeit."
 S Y=$P(ALN,"^",11) I Y D
 .N YRDIGIT
 .W !!," Restored Leave:",?30,$J(Y,8,3)
 .S YRDIGIT=$P(ALN,"^",13)
 .I YRDIGIT>-1 W !,"Use by end of leave year ",$$BLDYR^PRSLIB00(YRDIGIT)," or forfeit."
 ;
 ;Display other types of leave, if any.
 ;
 S Y=$P(MLN,"^",1) I Y D
 . W !!,"Military Leave in "
 . W $S($$MLINHRS^PRSAENT(DFN):"hours:",1:"days:")
 . W ?30,$J(Y,8,2)
 S Y=$P(ALN,"^",9) I Y W !!,"Non-Pay Leave Taken:",?30,$J(Y,8,3)
 I $E(IOST,1,2)="C-" S HOLD=$$ASK^PRSLIB00(1)
 Q
 ;
 ;====================================================================
C1 ; Display comp time hours and add 8 pay periods (111 days)
 ; to the "Comp Time Earned Pay Period" field to display when 
 ; the comp time must be used by.
 ;
 ; input
 ;     CTN    = value of "COMP" node from File 450
 ;     KK     = piece in CTN (1-8) of comp time being displayed
 ;     LASTPP = number of last pay period
 ;     LASTYR = 4-digit year associated with last pay period
 ;     
 N D1,EARNPP,EARNYR,PPE,USEDT
 W !,"Comp Time/Credit Hours: ",$J($P(CTN,U,KK),8,3)
 S EARNPP=+$P(CTN,"^",KK+9) ; number of pay period CT earned 
 S EARNYR=$S(LASTPP<EARNPP:LASTYR-1,1:LASTYR) ; guess year CT earned
 S PPE=$E(EARNYR,3,4)_"-"_$S(EARNPP<10:"0",1:"")_EARNPP
 D NX^PRSAPPU S USEDT=$$FMADD^XLFDT(D1,111)
 I USEDT W " must be used by ",$$FMTE^XLFDT(USEDT)
 Q
 ;
EX G KILL^XUSCLEAN
