PRSALVB ;WOIFO/JAH/PLT - Leave Balances ;02/01/08
 ;;4.0;PAID;**22,35,34,69,114,133**;Sep 21, 1995;Build 2
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
 N PGQUIT,LST,D1,YR,PPE,PYR,PPP,PPI,CTN,PPVN,PPVO,PPG,PPF
 S PGQUIT=""
 W:$E(IOST,1,2)="C-" @IOF W !?29,"EMPLOYEE LEAVE BALANCES"
 S C0=^PRSPC(DFN,0),DB=$P(C0,"^",10),LVG=$P(C0,"^",15),NH=+$P(C0,"^",16)
 D PGHD G Q2
 ;
 ;  Display employee name and ssn
 ;  SSN defaults to display of last four digits
 ;    employee displays last four
 ;    timekeeper and supervisor display first digit+last four
 ;
PGHD S X=$G(^PRSPC(DFN,0))
 W !!,$P(X,"^",1),?48,"Leave Group: ",LVG
 S X=$P(X,"^",9)
 I X,'$G(PRSTLV)!($G(PRSTLV)=1) W ?67,"XXX-XX-",$E(X,6,9)
 I X,$G(PRSTLV)=2!($G(PRSTLV)=3) W ?67,$E(X),"XX-XX-",$E(X,6,9)
 QUIT
 ;
 ; compare last pp processed to current pp
 ;
Q2 S LST=+$P($G(^PRSPC(DFN,"MISC4")),"^",16)
 ;get most recent year-pp in file
 S PPE=$P($G(^PRST(458,$O(^PRST(458,":"),-1),0)),U)
 S YR=$P(PPE,"-",1)
 S D1=+$P(PPE,"-",2)
 S YR=$S(D1'<LST:YR,1:$E(199+YR,2,3))
 S PPE=YR_"-"_$S(LST>9:LST,1:"0"_LST),PYR=YR,PPP=$P(PPE,"-",2)
 S PPI=$O(^PRST(458,"B",PPE,0))
 I PPI S D1=$P($G(^PRST(458,PPI,2)),"^",14)
 W !!,"Balances are as of Pay Period ",PPE," (",D1,")"
 ;
 S ALN=$G(^PRSPC(DFN,"ANNUAL")),SLN=$G(^("SICK")),CTN=$G(^("COMP")),MLN=$G(^("MILITARY"))
 ;
 I NH=48,DB=1 D
 .  S BAY=$G(^PRSPC(DFN,"BAYLOR"))
 .  S $P(ALN,"^",3)=$P(BAY,"^",1)
 .  S $P(SLN,"^",3)=$P(BAY,"^",13)
 .  F KK=9:1:12 S $P(ALN,"^",KK+1)=$P(BAY,"^",KK)
 ;
 S Y=$P(ALN,"^",3)
 W !,"Annual Leave Balance:",?30,$S(Y="":"",1:$J(Y,8,3))
 S Y=$P(SLN,"^",3)
 W !,"Sick Leave Balance:",?30,$S(Y="":"",1:$J(Y,8,3))
 ;
 ;print comptime downloaded with pp without year but padding with year based on the balance as of date's year
 I CTN]"",$P(CTN,U,1,8)'?1."^" D  G:PGQUIT EX
 . N PA,PB,PC,PD,PE,PDAYS
 . S PC="",PDAYS=377 ;from 26*14+13
 . W !!?10,"Comp Time/Credit Hours (CT/CH) Pay Period Balances",!?10,"Pay Period Earned",?30,"# of Hours",?45,"Must be used by"
 . F PA=1:1:8 I $P(CTN,U,PA),$P(CTN,U,PA+9) S PC=PC+$P(CTN,U,PA),PB=$$C1($P(CTN,U,PA+9),PDAYS) W !?10,$P(PB,U),?30,$J($P(CTN,U,PA),8,3),?45,$$FMTE^XLFDT($P(PB,U,2)) I IOSL-2<$Y S PGQUIT=$$PGBRK QUIT:PGQUIT  W !
 . S PD=$P($G(PB),U)
 . I $P(CTN,U,9)-PC,PD'=PPE S:PD]"" PD=$$PPDT^PRSU1B2(PD,14),PD=$$DTPP^PRSU1B2($P(PD,U,4)+15,"H") D
 .. S PE=$S($P(PD,U,2)=PPE:" "_PPE,1:"*"_$P(PD,U,2)_" thru "_PPE) W !?9,PE,?30,$J($P(CTN,U,9)-PC,8,3)
 .. W ?45,$S($P(PD,U,2)=PPE:$$FMTE^XLFDT($P($$C1(PPE,PDAYS),U,2)),1:$$FMTE^XLFDT($P($$C1($P(PD,U,2),PDAYS),U,2))_" thru "_$$FMTE^XLFDT($P($$C1(PPE,PDAYS),U,2)))
 .. QUIT
 . I IOSL-3<$Y S PGQUIT=$$PGBRK QUIT:PGQUIT  W !
 . W !?10,"-----------------------------------------------------------------"
 . W !,"Total CT/CH Hours Balance: ",?30,$J($P(CTN,U,9),8,3),!
 . I IOSL-3<$Y S PGQUIT=$$PGBRK QUIT:PGQUIT  W !
 . I $G(PE)["*" W !,"*The CT/CH balance of ",$J($P(CTN,U,9)-PC,1,3)," hours earned between ",$P($P(PE,"*",2)," ")," and ",$P(PE," ",3)," will be",!,"itemized in the report at least 8 pay periods in advance."
 . QUIT
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
 W !,"END OF REPORT"
 I $E(IOST,1,2)="C-" S HOLD=$$ASK^PRSLIB00(1)
 QUIT
 ;
 ;a=yy-pp or pp and pp is 1 to 26, b=# of days for used by
C1(A,B) ;ef - ^1=pp in format yy-pp or pp, ^2=expiration date
 N C,D,E
 ;get pp year based on the last pp download in the employee file
 QUIT:A="" ""
 S D=A S:A?1.2N D=$S(A'>PPP:PYR,1:$E(199+PYR,2,3))_"-"_$E(100+A,2,3)
 S C=$P($$PPDT^PRSU1B2(D,1),U,2),E=$$FMADD^XLFDT(C,B)
 QUIT D_"^"_E
 ;
PGBRK() ;ev - 1 if quit, "" if continue
 N DIR,DIRUT
 I IOST?1"C-".E S DIR(0)="E" D ^DIR
 I '$G(DIRUT) W @IOF D PGHD
 QUIT $G(DIRUT)
 ;
EX G KILL^XUSCLEAN
