ENSP3 ;(WCIOFO)/WDS@CHARLESTON,SAB-DISPLAY ROOM DATA (CONT'D) ;8/16/1999
 ;;7.0;ENGINEERING;**62**;Aug 17, 1993
 ;
 ;EXPECTS XY,DUZ(0)
 ;CALLED BY ENSP2
TOP ;D:'($D(ENLO)&$D(ENHI)) INIT^EN
 D:'($D(IOINLOW)&$D(IOINHI)) ZIS^ENUTL
 S DIC="^ENG(""SP"","
 S:$D(J)=0 J=0
 W ?28 D W("SINGLE ROOM DATA DISPLAY") W !
 W ! D W(" 1) ") W "ROOM NO.  : " D W(EN(1)) W ?39 D W(" 2) ") W "BUILDING #: " D W(EN(2))
 W ! D W(" 3) ") W "WING      : " D W(EN(3)) W ?39 D W(" 4) ") W "SERVICE   : " D W(EN(4))
 W ! D W(" 5) ") W "ROOM KEY  : " D W(EN(5)) W ?39 D W(" 6) ") W "FUNCTION  : " D W(EN(6))
TOP2 W ! D W(" 7) ") W "NO. OF BED: " D W(EN(10)) W ?39 D W(" 8) ") W "SPEC CHAR.: " D W(EN(11))
TOP4 W !
 W ! D W(" 9) ") W "LENGTH : " D W(EN(7)) W ?27 D W("10) ") W "WIDTH  : " D W(EN(8)) W ?54 D W("11) ") W "NET SF : " D W(EN(9))
 W ! D W("12) ") W "WALL   : " D W(EN(12)) W ?27 D W("13) ") W "FLOOR  : " D W(EN(13)) W ?54 D W("14) ") W "CEILING:" D W(EN(14))
 W ! D W("15) ") W "REPL.DT: " S X=EN(15) D PDT D W(X) W ?27 D W("16) ") W "REPL.DT: " S X=EN(16) D PDT D W(X) W ?54 D W("17) ") W "REPL.DT:" S X=EN(17) D PDT D W(X)
LITE W !
 W ! D W("18) ") W "LIGHTING  : " D W(EN(18,1)) W ?31,"QUANTITY  : " D W(EN(18,2)) W ?58,"WATTAGE   : " D W(EN(18,3))
 I $D(EN(19,1)) W !,?16 D W(EN(19,1)) W ?43 D W(EN(19,2)) W ?70 D W(EN(19,3))
 I $D(EN(20,1)) W !,?16 D W(EN(20,1)) W ?43 D W(EN(20,2)) W ?70 D W(EN(20,3))
TOP15 W !
 W ! D W("19) ") W "WINDOW QTY: " D W(EN(21)) W ?41 D W("20) ") W "WINDOW TYPE: " D W(EN(22))
 W ! D W("21) ") W "DRAPE NO. : " D W(EN(23)) W ?41 D W("22) ") W "CUB. CTNS. : " D W(EN(24))
 W ! D W("23) ") W "DOOR QTY  : " D W(EN(25)) W ?41 D W("24) ") W "RCS 10-0141: " D W(EN(26))
 W ! D W("25) ") W "UTILITIES : " D W(EN(27))
 I J-1>27 F I=28:1:J-1 W ! D W("  * ") W "UTILITIES : " D W(EN(I)) D:I=29 MSG
 W !
 W ! D W("26) ") W "COMMENTS: "
WCO I $D(^ENG("SP",DA,3)) D
 . S DIWL=15,DIWR=79,DIWF="" K ^UTILITY($J,"W")
 . S ENNX=0 F  S ENNX=$O(^ENG("SP",DA,3,ENNX)) Q:'ENNX  I $D(^(ENNX,0))>0 S X=^(0)  D ^DIWP
 . I $O(^UTILITY($J,"W",DIWL,1)),IOSL'>30 D HOLD Q:$E(X)="^"
 . W IOINHI S ENNX=0 F  S ENNX=$O(^UTILITY($J,"W",DIWL,ENNX)) Q:'ENNX  W !,?DIWL,^(ENNX,0) I (IOSL-$Y)'>2 D  Q:$E(X)="^"
 .. W IOINLOW D HOLD
 .. W:$E(X)'="^" IOINHI
 . W IOINLOW
SYN W !
 W ! D W("27)") W " SYNONYM : " D W(EN("SYN"))
OKEY I $Y+3>IOSL D MSG
 W ! D W("28)") W " OTHER KEYS: "
 S I=0 F  S I=$O(EN("OKEY",I)) Q:'I  D
 . W:I>1 ! W ?16 D W(EN("OKEY",I))
WAIT K EN,ENLTH,ENORD,I,J,K,ENNU,ENNX,X,DIWL,DIWR,DIWF
 I $D(ZTQUEUED) S ZTREQ="@" W @IOF Q
 I $D(A),A="...PRT..." W:IO'=IO(0) @IOF Q  ;WDS/CHA 6.41
 W !,"Choose " W $S($D(^XUSEC("ENROOM",DUZ)):"Item to Enter/Edit (2-28, ",1:"(") W "D(DISPLAY), P(PRINT)):  EXIT// " R A:DTIME
REPEAT I A=""!(A="^") W !!,"Want to view another " S %=1 D YN^DICN G:%=1 ENT^ENSP2 K A Q
 I A=""!(A="^") K A Q
 I A="P" G PRT
 I A="D" W @IOF G RPT
 I A<29,(A>1) S DR=$P(".5^1^1.5^2^2.6^5^6^3^3.5^4.5^7^8^9^7.5^8.5^9.5^10^11^11.5^12^13^13.5^16^14^17^18^2.1","^",A-1) G SDA
 G WAIT
MSG I $E(IOST,1,2)="C-" W !,?10,"Press <RETURN> to continue. " R R:DTIME Q
 Q
PRT ;PRINT SPACE SCREEN DATA
 S ENLOW=IOINLOW,ENHI=IOINHI S IOINLOW="",IOINHI=""
 S A="...PRT..." D DEV^ENLIB G:POP PRT1 G:'$D(IO("Q")) PRT0
 K IO("Q") S ZTIO=ION,ZTRTN="START^ENSP2",ZTSAVE("EN*")="",ZTSAVE("DA")="",ZTSAVE("A")="",ZTDESC="Single Room Data Display" D ^%ZTLOAD K ZTSK
 D ^%ZISC S IOINLOW=ENLOW,IOINHI=ENHI K ENLOW,ENHI,A G WAIT
PRT0 U IO D START^ENSP2 D:IO'=IO(0) ^%ZISC
PRT1 S IOINLOW=ENLOW,IOINHI=ENHI K ENLOW,ENHI,A
 D HOME^%ZIS G WAIT
RPT G START^ENSP2
SDA S X=DIC_DA_")" L +@X:1 I $T=0 W !!,*7,"THIS ENTRY IS BEING EDITED BY ANOTHER USER.  TRY LATER." G WAIT
TEST I '$D(^XUSEC("ENROOM",DUZ)) W !,"** Sorry, you seem to lack the appropriate Security Key (ENROOM) **",*7 G WAIT
ED D ^DIE L -@(DIC_DA_")") G WAIT
PDT S:X'="" X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) Q
 ;
HOLD S X="" I $E(IOST,1,2)="C-" D  Q
 . W !,"Press <RETURN> to continue, '^' to escape..."
 . R X:DTIME
 . S $Y=0
 W @IOF
 Q
 ;
W(ENDATA) ;Bold ENDATA
 Q:$G(ENDATA)=""
 N X
 S X=$X W IOINHI S $X=X W ENDATA
 S X=$X W IOINLOW S $X=X
 Q
 ;ENSP3
