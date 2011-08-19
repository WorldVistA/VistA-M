XINDX51 ;ISC/REL,GRK,RWF - PRINT ROUTINE ;06/24/08  16:06
 ;;7.3;TOOLKIT;**20,48,61,110**;Apr 25, 1995;Build 11
 ;Setup Local IO paramiters
B S RTN="",INL(1)=IOM-2,INL(2)=IOSL-4,INL(3)=("C"=$E(IOST)),INL(4)=IOM-1,PG=0,INL(5)="Compiled list of Errors and Warnings "
 K ER,HED D HD1 ;Do header
 ;Show Errors
 F  S RTN=$O(^UTILITY($J,1,RTN)) Q:RTN=""!$D(IND("QUIT"))  S X=^(RTN,0) I $D(^UTILITY($J,1,RTN,"E"))>9 S HED=$$BHDR(RTN,X) D HD,WERR(1)
 W:'$D(ER) !,"No errors or warnings to report",!
 ;Did they want more?
 G END:'INP(1)!$D(IND("QUIT")),CR:INP(6)
 ;Show detail on each routine
 W !!,"--- Routine Detail"
 W:INP(5)?1A "   --- with "_$S(INP(5)["R":"REGULAR",INP(5)["S":"STRUCTURED",INP(5)["B":"R/S",1:"")_" ROUTINE LISTING" W " ---"
 S RTN="$",INDB="R" ;Report on each routine
BL F  S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""!('INP(4)&(RTN?1"|"1.4L.NP))!$D(IND("QUIT"))  D B1,CHK
 ;Exit or do Cross-Refference
 G END:NRO<2,END:$D(IND("QUIT")),CR
 ;
BHDR(R,X) ;Build hdr
 Q $E(R_"       ",1,8)_" * *  "_$P(X,"^",2)_" Lines,  "_(+X)_" Bytes, Checksum: "_$G(^UTILITY($J,1,R,"RSUM"))
 ;
WERR(FL) ;Write error messages
 N ER2
 F ER=1:1 Q:'$D(^UTILITY($J,1,RTN,"E",ER))!$D(IND("QUIT"))  S %=^(ER) D
 . I $Y'<INL(2) D HD K ER2
 . D:FL&(%>0)&($G(ER2)'=+%) WORL(^UTILITY($J,1,RTN,0,+%,0)) ;Write the routine line
 . W !?3,$P(%,$C(9),2) W:$X>16 ! W ?16,$P(%,$C(9),3) S ER2=+% ;Write the error p110
 . Q
 Q
 ;
WR ;Write one routine
 S X=^UTILITY($J,1,RTN,0),INL(5)=$$BHDR(RTN,X)
 D HD1 W !,?14,$P(X,"^",3)_" bytes in comments" G:'INP(2) B2
 F I=1:1 Q:'$D(^UTILITY($J,1,RTN,0,I))  S X=^(I,0) D
 . D:$Y'<INL(2) HD1 I $D(IND("QUIT")) S I=99999 Q
 . D WORL(X) ;Write routine line
 . Q
 Q
 ;
WORL(D) ;Write one routine line
 N J,L
 S L=$P(D," ",1),D=$P(D," ",2,999)
 F J=8,9:0 W !,L,?J," " W:$X>10 "--",!,?10 W $E(D,1,INL(4)-J) S D=$E(D,INL(4)-J+1,999),L="" Q:D=""
 Q
 ;
CHK I $D(ZTQUEUED),$$S^%ZTLOAD S IND("QUIT")=1,ZTSTOP=1
 S:$D(IND("QUIT")) RTN="~"
 Q
 ;
B1 I '$D(^UTILITY($J,1,RTN,0)) Q  ;No data to show
 D:INP(5)["S"!(INP(5)["B") ^XINDX8 ;Show structured listing
 D:INP(5)["F" SC
 D:INP(5)["R"!(INP(5)["B") WR ;Show normal listing
B2 ;
 G:'INP(3)!('$D(^UTILITY($J,1,RTN,"E",0))) B3
 S HED="*****   ERRORS & WARNINGS IN "_RTN_"   *****" W !,HED
 D WERR(0) ;Show errors
B3 ;
 S INL(5)="*****   INDEX OF "_RTN_"   *****" W !!,INL(5),!
 S HED="Local Variables      Line Occurrences   ( >> not killed explicitly)",HED(1)=$J("",40)_"( * Changed  ! Killed  ~ Newed)" D P("L","") Q:$D(IND("QUIT"))
 S HED="Global Variables  ( * Changed  ! Killed)" D P("G","") Q:$D(IND("QUIT"))
 S HED="Naked Globals" D P("N","") Q:$D(IND("QUIT"))
 S HED="Marked Items" D P("MK","") Q:$D(IND("QUIT"))
 S HED="Label References" D P("I","") Q:$D(IND("QUIT"))
 S HED="External References" D P("X","^") Q:$D(IND("QUIT"))
 W !!,"*****   END   *****",!
 Q
 ;
P(LOC,SYM) ;
 S L="",PC="",TAB=$S("XG"[LOC:23,1:16) D HD Q:$D(IND("QUIT"))
P1 S L=$O(^UTILITY($J,1,RTN,LOC,L)) G:L="" PX
 I LOC="X",L?1L.LNP Q
 S PC(1)=$G(^UTILITY($J,1,RTN,LOC,$P(L,"(")))_$S("^DT^DUZ^DTIME^IO^IOF^ION^IOM^IOSL^IOST^U^"[("^"_$P(L,"(")_"^"):"!",1:" ")
 S PC(1)=(PC(1)["!")!(PC(1)["~"),PC="*"
 F J=0:1 S X=$S($D(^UTILITY($J,1,RTN,LOC,L,J)):^(J),1:"") Q:X=""!$D(IND("QUIT"))  D P2,P3
 G P1
PX W:PC="" !?3,"NONE" K HED
 Q
P2 I $Y'<INL(2) D HD S PC="*"
 Q:PC=L
 I LOC="L" W !,$S(('PC(1)):">> ",1:"   "),SYM,L," ",?TAB Q
 I LOC'="X" W !,"   ",SYM,L,?TAB Q
 W !?3,$P(L," ",2),SYM,$P(L," ",1)," ",?TAB
 Q
P3 W:$X>TAB !,?TAB
 S PC=L F I=1:1 S ARG=$P(X,",",I) Q:ARG=""  W:$X+$L(ARG)>INL(1) !?TAB W:$X'=TAB "," W ARG
 Q
HD D:$Y'<INL(2) HD1 D HD2
 Q
HD1 D WAIT:INL(3) S PG=PG+1 W @IOF,!,INL(5) W:(IOM-30)<$X ! W ?(IOM-30),INDXDT," page ",PG
 Q
HD2 W !!,HED W:$D(HED(1)) !,HED(1)
 Q
CR S INDB="C" U IO(0) W !!,"--- CROSS-REFERENCING ALL ROUTINES ---" U IO
 S RTN="$" D CRX^XINDX5
 S INL(5)="*****   Cross Reference of all Routines   *****",RTN="***" D HD1
 S HED="Local Variables    Routines   ( >> not killed explicitly)",HED(1)=$J("",30)_"( * Changed  ! Killed  ~ Newed)" D P("L","") G:$D(IND("QUIT")) END
 S HED="Global Variables" D P("G","") G:$D(IND("QUIT")) END
 S HED="Naked Globals" D P("N","") Q:$D(IND("QUIT"))
 S HED="Marked Items" D P("MK","") G:$D(IND("QUIT")) END
 S HED="Routine             Invokes:" D P("Z","") G:$D(IND("QUIT")) END
 S HED="Routine             is Invoked by:" D P("X","^")
 W !!,"*****   END   *****",!
END K INL,HED Q
SC ;Print a command chart
 S INL(5)=RTN_"   Command chart" D HD1
 F I=0:0 S I=$O(^UTILITY($J,1,RTN,"COM",I)) Q:I'>0  W !,^(I)
 Q
WAIT N % W !,"   Press return to continue:" R %:300 S:'$T %="^"
 I %["?" W !,"Press return to continue the report, ^ to exit the report" G WAIT
 S:%="^" IND("QUIT")=1 Q
