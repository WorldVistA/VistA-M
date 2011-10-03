%INDX51 ;ISC/REL,GRK,RWF - PRINT ROUTINE ;8/18/93  11:12 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
B S RTN="$",INL(1)=IOM-10,INL(2)=IOSL-4,INL(3)="C"[$E(IOST),INL(4)=IOM-1 ;Local IO paramiters
 K I W !!?10,"Compiled list of Errors and Warnings     ",INDXDT,!
 F INDXJ=0:0 S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""  I $D(^UTILITY($J,1,RTN,"E"))>9 W !,RTN F I=1:1 Q:'$D(^UTILITY($J,1,RTN,"E",I))  W !?3,^(I)
 W:'$D(I) !,"No errors or warnings to report",! G END:'INP(1),CR:INP(6)
 W !!,"--- Routine Detail" W:INP(5)?1A "   --- with "_$S(INP(5)["R":"REGULAR",INP(5)["S":"STRUCTURED",INP(5)["B":"R/S",1:"")_" ROUTINE LISTING" W " ---"
 S RTN="$",INDB="R"
BL F  S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""!('INP(4)&(RTN?1"|"1.4L.NP))  D B1,CHK
 G END:NRO<2,END:$D(IND("QUIT")),CR
 ;
CHK I $D(ZTQUEUED),$$S^%ZTLOAD S IND("QUIT")=1,ZTSTOP=1
 S:$D(IND("QUIT")) RTN="~" Q
 ;
B1 D:INP(5)["S"!(INP(5)["B") ^%INDX8 D:INP(5)["F" SC G:INP(5)["S" B2
 D WAIT:INL(3) S X=^UTILITY($J,1,RTN,0) W @IOF,!,RTN," * *  ",$P(X,"^",2)," Lines,  ",+X," Bytes.    printed on ",INDXDT,! G:'INP(2) B2
 F I=1:1 Q:'$D(^UTILITY($J,1,RTN,0,I))  S X=^(I,0),L=$P(X," ",1),X=$P(X," ",2,999) F J=6,7:0 W !,L,?J," ",$E(X,1,INL(4)-J) S X=$E(X,INL(4)-J+1,999),L="" Q:X=""
B2 G:'INP(3)!('$D(^UTILITY($J,1,RTN,"E",0))) B3 W !!,"*****   ERRORS & WARNINGS IN ",RTN,"   *****",!
 F I=1:1 Q:'$D(^UTILITY($J,1,RTN,"E",I))  W !?3,^(I)
B3 S INL(5)="*****   INDEX OF "_RTN_"   *****" W !!,INL(5),!
 S HED="Local Variables      Line Occurrences   ( >> not killed explicitly)",HED(1)=$J("",40)_"( * Changed  ! Killed  ~ Newed)",LOC="L",SYM="" D P
 S HED="Global Variables  ( * Changed  ! Killed)",LOC="G",SYM="" D P
 S HED="Naked Globals",LOC="N",SYM="" D P
 S HED="Marked Items",LOC="MK",SYM="" D P
 S HED="Label References",LOC="I",SYM="" D P
 S HED="External References",LOC="X",SYM="^" D P
 W !!,"*****   END   *****",! Q
 ;
P S L="",PC="",TAB=$S("XG"[LOC:23,1:16) D HD1 Q:$D(IND("QUIT"))
P1 S L=$O(^UTILITY($J,1,RTN,LOC,L)) I L="" W:PC="" !?3,"NONE" K HED Q
 I LOC="X",L?1L.LNP Q
 S PC(1)=$G(^UTILITY($J,1,RTN,LOC,$P(L,"(")))_$S("^DT^DUZ^DTIME^IO^IOF^ION^IOM^IOSL^IOST^U^"[("^"_$P(L,"(")_"^"):"!",1:" ")
 S PC(1)=(PC(1)["!")!(PC(1)["~"),PC="*"
 F J=0:1 S X=$S($D(^UTILITY($J,1,RTN,LOC,L,J)):^(J),1:"") Q:X=""  D P2,P3
 G P1
P2 I $Y'<INL(2) D HD1 S PC="*"
 Q:PC=L
 I LOC="L" W !,$S(('PC(1)):">> ",1:"   "),SYM,L,?TAB Q
 I LOC'="X" W !,"   ",SYM,L,?TAB Q
 W !?3,$P(L," ",2),SYM,$P(L," ",1)," ",?TAB
 Q
P3 W:$X>TAB !,?TAB
 S PC=L F I=1:1 S ARG=$P(X,",",I) Q:ARG=""  W:$X>INL(1) !?TAB W:$X'=TAB "," W ARG
 Q
HD1 I $Y'<INL(2) D WAIT:INL(3) W @IOF,!,INL(5),!
HD2 W !!,HED W:$D(HED(1)) !,HED(1)
 Q
CR S INDB="C" U IO(0) W !!,"--- CROSS-REFERENCING ALL ROUTINES ---" U IO
 S RTN="$" D CRX^%INDX5
 S INL(5)="*****   Cross Reference of all Routines  printed "_INDXDT_"  *****",RTN="***" D WAIT:INL(3) W @IOF,!,INL(5),!
 S HED="Local Variables    Routines   ( >> not killed explicitly)",HED(1)=$J("",30)_"( * Changed  ! Killed  ~ Newed)",LOC="L",SYM="" D P
 S HED="Global Variables",LOC="G",SYM="" D P
 S HED="Marked Items",LOC="MK",SYM="" D P
 S HED="Routine             Invokes:",LOC="Z",SYM="" D P
 S HED="Routine             is Invoked by:",LOC="X",SYM="^" D P
 W !!,"*****   END   *****",! G END
END K INL,HED Q
SC ;Print a command chart
 D WAIT:INL(3) W @IOF,!,RTN,"   Command chart"
 F I=0:0 S I=$O(^UTILITY($J,1,RTN,"COM",I)) Q:I'>0  W !,^(I)
 Q
WAIT W !,"   Press return to continue:" R %:60 S:%="^" IND("QUIT")=1 Q
