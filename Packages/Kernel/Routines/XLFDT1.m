XLFDT1 ;ISC-SF/RWF - Date/Time Functions cont. from VA FileMan %DTC ;02/20/2003  10:05
 ;;8.0;KERNEL;**71,280**;Jul 10, 1995
 ;If y contains a "D" then Date only.
 ;if y contains a "F" then output with leading blanks
 ;If y contains a "P" then output ' HH:MM:SS am/pm'.
 ;If y contains a "S" then force seconds in the output.
 ;if y contains a "M" then stop at minutes i.e. no seconds.
 ;
FMT ;
 N %G S %G=+%F
 G F1:%G=1,F2:%G=2,F3:%G=3,F4:%G=4,F5:%G=5,F6:%G=6,F7:%G=7,F8:%G=8,F9:%G=9,F1
 Q
 ;
F1 ;Apr 10, 2002
 S %R=$P($$M()," ",$S($E(Y,4,5):$E(Y,4,5)+2,1:0))_$S($E(Y,4,5):" ",1:"")_$S($E(Y,6,7):$E(Y,6,7)_", ",1:"")_($E(Y,1,3)+1700)
 ;
TM ;All formats come here to format Time.
 N %,%S Q:%T'>0!(%F["D")
 I %F'["P" S %R=%R_"@"_$E(%T,2,3)_":"_$E(%T,4,5)_$S(%F["M":"",$E(%T,6,7)!(%F["S"):":"_$E(%T,6,7),1:"")
 I %F["P" D
 . S %R=%R_" "_$S($E(%T,2,3)>12:$E(%T,2,3)-12,+$E(%T,2,3)=0:"12",1:+$E(%T,2,3))_":"_$E(%T,4,5)_$S(%F["M":"",$E(%T,6,7)!(%F["S"):":"_$E(%T,6,7),1:"")
 . S %R=%R_$S($E(%T,2,7)<120000:" am",$E(%T,2,3)=24:" am",1:" pm")
 . Q
 Q
 ;Return Month names
M() Q "  Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"
 ;
F2 ;4/10/02
 S %R=$J(+$E(Y,4,5),2)_"/"_$J(+$E(Y,6,7),2)_"/"_$E(Y,2,3)
 S:%F["Z" %R=$TR(%R," ","0") S:%F'["F" %R=$TR(%R," ")
 G TM
F3 ;10/4/02
 S %R=$J(+$E(Y,6,7),2)_"/"_$J(+$E(Y,4,5),2)_"/"_$E(Y,2,3)
 S:%F["Z" %R=$TR(%R," ","0") S:%F'["F" %R=$TR(%R," ")
 G TM
F4 ;02/4/10
 S %R=$E(Y,2,3)_"/"_$J(+$E(Y,4,5),2)_"/"_$J(+$E(Y,6,7),2)
 S:%F["Z" %R=$TR(%R," ","0") S:%F'["F" %R=$TR(%R," ")
 G TM
F5 ;4/10/2002
 S %R=$J(+$E(Y,4,5),2)_"/"_$J(+$E(Y,6,7),2)_"/"_($E(Y,1,3)+1700)
 S:%F["Z" %R=$TR(%R," ","0") S:%F'["F" %R=$TR(%R," ")
 G TM
F6 ;10/4/2002
 S %R=$J(+$E(Y,6,7),2)_"/"_$J(+$E(Y,4,5),2)_"/"_($E(Y,1,3)+1700)
 S:%F["Z" %R=$TR(%R," ","0") S:%F'["F" %R=$TR(%R," ")
 G TM
F7 ;2002/4/10
 S %R=($E(Y,1,3)+1700)_"/"_$J(+$E(Y,4,5),2)_"/"_$J(+$E(Y,6,7),2)
 S:%F["Z" %R=$TR(%R," ","0") S:%F'["F" %R=$TR(%R," ")
 G TM
F8 ;10 Apr 02
 S %R=$S($E(Y,6,7):$E(Y,6,7)_" ",1:"")_$P($$M()," ",$S($E(Y,4,5):$E(Y,4,5)+2,1:0))_$S($E(Y,4,5):" ",1:"")_$E(Y,2,3)
 G TM
F9 ;10 Apr 2002
 S %R=$S($E(Y,6,7):$E(Y,6,7)_" ",1:"")_$P($$M()," ",$S($E(Y,4,5):$E(Y,4,5)+2,1:0))_$S($E(Y,4,5):" ",1:"")_($E(Y,1,3)+1700)
 G TM
