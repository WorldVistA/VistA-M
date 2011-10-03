PRCUYN ;WISC@ALTOONA/CTB-UTILITY YES/NO READER AND WAIT ;10/22/93  3:35 PM
V ;;5.0;IFCAP;;4/21/95
YN ;
 N I,S,Z
 K DTOUT S U="^" S:'$D(PRC("YN"))#2 PRC("YN")=3 S S=PRC("YN")
 I PRC("YN")=3 S PRC("YN")=""
 I '$D(PRC("A",0)) S PRC("A",0)=""
 W:PRC("A",0)["!" ! W:$D(PRC("A"))#2 !,PRC("A")
 F I=0:0 S I=$O(PRC("A",I)) Q:'I  Q:'$D(PRC("A",I))  W !,PRC("A",I)
 W:PRC("A",0)["*" $C(7)
 W "? ",$P("YES// ^NO// ^<YES/NO> ",U,S)
RX R Z:$S($D(DTIME):DTIME,1:300) E  S DTOUT=1,Z=U W $C(7)
 S:Z]""!'PRC("YN") PRC("YN")=$A(Z),PRC("YN")=$S(PRC("YN")=89:1,PRC("YN")=121:1,PRC("YN")=78:2,PRC("YN")=110:2,PRC("YN")=94:-1,1:0)
 I 'PRC("YN"),Z'["?" G Q1
 W:$X>73 ! W $P("  (YES)^  (NO)",U,PRC("YN")) G:PRC("YN")'=0 Q
 I $D(PRC("B")),PRC("B")]"" W !!,PRC("B") D C G:'$D(PRC("A")) Q S PRC("YN")=S G YN
 I $D(PRC("B")),PRC("B")="" G Q1
 I $D(PRC("A")),'$D(PRC("B")) S PRC("YN")=S G YN
Q K PRC("A"),PRC("B") Q
Q1 W:'PRC("YN")&(Z'["?") $C(7) W !,"You must enter a 'Yes' or a 'No', or you may enter an '^' to Quit",! S PRC("YN")=S G YN
 Q
C F I=0:0 S I=$O(PRC("B",I)) Q:'I  Q:'$D(PRC("B",I))  W !,PRC("B",I)
 W ! Q
WAIT ;
 W !,"..."
 W $P("Whoops,^Hmmm,^Excuse me,^Sorry,^Alright already!^OK! OK!^Alright, I'm tired.","^",$R(7)+1),"  "
 W $P($T(LIST+$R(8)),";",3)_"..."
LIST ;;This may take a few moments
 ;;Let me put you on 'HOLD' for a second
 ;;Please hold on
 ;;Just a moment, please
 ;;I'm working as fast as I can
 ;;Let me think about this for a moment
 ;;I'm just having one of those days...
 ;;Is it lunchtime yet?...
 ;
