PRPFYN ;ALTOONA/CTB   YES/NO ROUTINE FOR PATIENT FUNDS ;2/24/97  5:12 PM
V ;;3.0;PATIENT FUNDS;**6**;JUNE 1, 1989
YN ;
 K DTOUT S U="^" S:'$D(%)#2 %=3 S %S=% I %=3 S %=""
 W:$D(%A) !,%A
 F %I=1:1 Q:'$D(%A(%I))  W !,%A(%I)
 W "? ",$P("YES// ^NO// ^<YES/NO> ",U,%S)
RX R %Y:$S($D(DTIME):DTIME,1:99999) E  S DTOUT=1,%Y=U W *7
 S:%Y]""!'% %=$A(%Y),%=$S(%=89:1,%=121:1,%=78:2,%=110:2,%=94:-1,1:0)
 I '%,%Y'["?" G Q1
 W:$X>73 ! W $P("  (YES)^  (NO)",U,%)
 G:%'=0 Q I $D(%B),%B]"" W !!,%B D C G:'$D(%A) Q S %=%S G YN
 I $D(%B),%B="" G Q1
 I $D(%A),'$D(%B) S %=%S G YN
Q K %Y,%A,%B,%S,%I Q
Q1 W:'%&(%Y'["?") *7 W !,"You must enter a 'Yes' or a 'No', or you may enter an '^' to Quit",!! S %=%S G YN
 Q
C F %I=1:1 Q:'$D(%B(%I))  W !,%B(%I)
 W ! Q
WAIT ;
 Q:$E($G(IOST),1,2)'="C-"
 W !,"..."
 W $P("Whoops^Hmmm^Excuse me^Sorry","^",$R(4)+1),", "
 W $P($T(LIST+$R(6)),";",3)_"..."
 QUIT
LIST ;;This may take a few moments
 ;;Let me put you on 'HOLD' for a second
 ;;Hold on
 ;;Just a moment, please
 ;;I'm working as fast as I can
 ;;Let me think about this for a moment
 ;
