PRCFYN ;WISC@ALTOONA/CTB-UTILITY YES/NO READER AND WAIT ;10 Sep 89  3:08 PM [11/13/98 4:19pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
YN ;
 K DTOUT S U="^" S:'$D(%)#2 %=3 S %S=% I %=3 S %=""
 I '$D(%A(0)) S %A(0)=""
 W:%A(0)["!" ! W:$D(%A)#2 !,%A
 F %I=0:0 S %I=$O(%A(%I)) Q:'%I  Q:'$D(%A(%I))  W !,%A(%I)
 W:%A(0)["*" $C(7)
 W "? ",$P("YES// ^NO// ^<YES/NO> ",U,%S)
RX R %Y:$S($D(DTIME):DTIME,1:300) E  S DTOUT=1,%Y=U W $C(7)
 S:%Y]""!'% %=$A(%Y),%=$S(%=89:1,%=121:1,%=78:2,%=110:2,%=94:-1,1:0)
 I '%,%Y'["?" G Q1
 W:$X>73 ! W $P("  (YES)^  (NO)",U,%)
 G:%'=0 Q I $D(%B),%B]"" W !!,%B D C G:'$D(%A) Q S %=%S G YN
 I $D(%B),%B="" G Q1
 I $D(%A),'$D(%B) S %=%S G YN
Q K %Y,%A,%B,%S,%I Q
Q1 W:'%&(%Y'["?") $C(7) W !,"You must enter a 'Yes' or a 'No', or you may enter an '^' to Quit",! S %=%S G YN
 Q
C F %I=0:0 S %I=$O(%B(%I)) Q:'%I  Q:'$D(%B(%I))  W !,%B(%I)
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
 ;  ** VARIABLE DEFINITIONS **
 ;  Inputs
 ;    % = default response as 1=Yes  2=No   3=Yes/No
 ;    %A = Prompt Text array (optional)
 ;    %B = Help text array (optional)
 ;  Output
 ;    % as 1=Yes  2=No  -1=abort (^)  0=none of the above
 ; 
 ;  NOTES
 ;    If %A(0) contains "!", a linefeed precedes the prompt(s)
 ;    If %A(0) contains "*", the bell sounds after the prompt(s)
