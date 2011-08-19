ABSVYN ;VAMC ALTOONA/CTB - UTILITY YES/NO READER AND WAIT ;6/7/94  8:40 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;;JULY 6, 1994
YN ;
 K DTOUT S U="^" S:'$D(%)#2 %=3 S ABSVXS=% I %=3 S %=""
 W:$D(ABSVXA) !,ABSVXA
 S ABSVXI=0 F  S ABSVXI=$O(ABSVXA(ABSVXI)) Q:+ABSVXI=0  W !,ABSVXA(ABSVXI)
 W "? ",$P("YES// ^NO// ^<YES/NO> ",U,ABSVXS)
RX R ABSVXY:$S($D(DTIME):DTIME,1:600) E  S DTOUT=1,ABSVXY=U W *7
 S:ABSVXY]""!'% %=$A(ABSVXY),%=$S(%=89:1,%=121:1,%=78:2,%=110:2,%=94:-1,1:0)
 I '%,ABSVXY'["?" G Q1
 W:$X>73 ! W $P("  (YES)^  (NO)",U,%)
 G:%'=0 Q I $D(ABSVXB),ABSVXB]"" W !!,ABSVXB D C G:'$D(ABSVXA) Q S %=ABSVXS G YN
 I $D(ABSVXB),ABSVXB="" G Q1
 I $D(ABSVXA),'$D(ABSVXB) S %=ABSVXS G YN
Q K ABSVXY,ABSVXA,ABSVXB,ABSVXS,ABSVXI Q
Q1 W:'%&(ABSVXY'["?") *7 W !,"You must enter a 'Yes' or a 'No', or you may enter an '^' to Quit",! S %=ABSVXS G YN
 Q
C S ABSVXI=0 F  S ABSVXI=$O(ABSVXB(ABSVXI)) Q:'ABSVXI  W !,ABSVXB(ABSVXI)
 W ! Q
WAIT ;
 W !,"..."
 W $P("Whoops,^Hmmm,^Excuse me,^Sorry,^Alright already!^OK! OK!^Alright, so I'm a little tired.","^",$R(7)+1),"  "
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
