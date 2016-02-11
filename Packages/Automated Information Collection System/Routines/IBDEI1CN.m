IBDEI1CN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22471,1,3,0)
 ;;=3^Pathological fracture, left ulna, sequela
 ;;^UTILITY(U,$J,358.3,22471,1,4,0)
 ;;=4^M84.432S
 ;;^UTILITY(U,$J,358.3,22471,2)
 ;;=^5013847
 ;;^UTILITY(U,$J,358.3,22472,0)
 ;;=M84.431S^^101^1040^132
 ;;^UTILITY(U,$J,358.3,22472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22472,1,3,0)
 ;;=3^Pathological fracture, right ulna, sequela
 ;;^UTILITY(U,$J,358.3,22472,1,4,0)
 ;;=4^M84.431S
 ;;^UTILITY(U,$J,358.3,22472,2)
 ;;=^5013841
 ;;^UTILITY(U,$J,358.3,22473,0)
 ;;=S59.012S^^101^1040^133
 ;;^UTILITY(U,$J,358.3,22473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22473,1,3,0)
 ;;=3^Sltr-haris Type I physl fx lower end of ulna, left arm, sqla
 ;;^UTILITY(U,$J,358.3,22473,1,4,0)
 ;;=4^S59.012S
 ;;^UTILITY(U,$J,358.3,22473,2)
 ;;=^5031984
 ;;^UTILITY(U,$J,358.3,22474,0)
 ;;=S59.011S^^101^1040^136
 ;;^UTILITY(U,$J,358.3,22474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22474,1,3,0)
 ;;=3^Sltr-haris Type I physl fx lower end ulna, right arm, sqla
 ;;^UTILITY(U,$J,358.3,22474,1,4,0)
 ;;=4^S59.011S
 ;;^UTILITY(U,$J,358.3,22474,2)
 ;;=^5031978
 ;;^UTILITY(U,$J,358.3,22475,0)
 ;;=S59.022S^^101^1040^141
 ;;^UTILITY(U,$J,358.3,22475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22475,1,3,0)
 ;;=3^Sltr-haris Type II physl fx lower end ulna, left arm, sqla
 ;;^UTILITY(U,$J,358.3,22475,1,4,0)
 ;;=4^S59.022S
 ;;^UTILITY(U,$J,358.3,22475,2)
 ;;=^5032002
 ;;^UTILITY(U,$J,358.3,22476,0)
 ;;=S59.021S^^101^1040^142
 ;;^UTILITY(U,$J,358.3,22476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22476,1,3,0)
 ;;=3^Sltr-haris Type II physl fx lower end ulna, right arm, sqla
 ;;^UTILITY(U,$J,358.3,22476,1,4,0)
 ;;=4^S59.021S
 ;;^UTILITY(U,$J,358.3,22476,2)
 ;;=^5031996
 ;;^UTILITY(U,$J,358.3,22477,0)
 ;;=S59.032S^^101^1040^147
 ;;^UTILITY(U,$J,358.3,22477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22477,1,3,0)
 ;;=3^Sltr-haris Type III physl fx lower end ulna, left arm, sqla
 ;;^UTILITY(U,$J,358.3,22477,1,4,0)
 ;;=4^S59.032S
 ;;^UTILITY(U,$J,358.3,22477,2)
 ;;=^5032020
 ;;^UTILITY(U,$J,358.3,22478,0)
 ;;=S59.031S^^101^1040^148
 ;;^UTILITY(U,$J,358.3,22478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22478,1,3,0)
 ;;=3^Sltr-haris Type III physl fx lower end ulna, right arm, sqla
 ;;^UTILITY(U,$J,358.3,22478,1,4,0)
 ;;=4^S59.031S
 ;;^UTILITY(U,$J,358.3,22478,2)
 ;;=^5032014
 ;;^UTILITY(U,$J,358.3,22479,0)
 ;;=S59.042S^^101^1040^153
 ;;^UTILITY(U,$J,358.3,22479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22479,1,3,0)
 ;;=3^Sltr-haris Type IV physl fx lower end ulna, left arm, sqla
 ;;^UTILITY(U,$J,358.3,22479,1,4,0)
 ;;=4^S59.042S
 ;;^UTILITY(U,$J,358.3,22479,2)
 ;;=^5032038
 ;;^UTILITY(U,$J,358.3,22480,0)
 ;;=S59.041S^^101^1040^154
 ;;^UTILITY(U,$J,358.3,22480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22480,1,3,0)
 ;;=3^Sltr-haris Type IV physl fx lower end ulna, right arm, sqla
 ;;^UTILITY(U,$J,358.3,22480,1,4,0)
 ;;=4^S59.041S
 ;;^UTILITY(U,$J,358.3,22480,2)
 ;;=^5032032
 ;;^UTILITY(U,$J,358.3,22481,0)
 ;;=M84.332S^^101^1040^160
 ;;^UTILITY(U,$J,358.3,22481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22481,1,3,0)
 ;;=3^Stress fracture, left ulna, sequela
 ;;^UTILITY(U,$J,358.3,22481,1,4,0)
 ;;=4^M84.332S
 ;;^UTILITY(U,$J,358.3,22481,2)
 ;;=^5013619
 ;;^UTILITY(U,$J,358.3,22482,0)
 ;;=M84.331S^^101^1040^162
 ;;^UTILITY(U,$J,358.3,22482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22482,1,3,0)
 ;;=3^Stress fracture, right ulna, sequela
 ;;^UTILITY(U,$J,358.3,22482,1,4,0)
 ;;=4^M84.331S
 ;;^UTILITY(U,$J,358.3,22482,2)
 ;;=^5013613
 ;;^UTILITY(U,$J,358.3,22483,0)
 ;;=S52.622S^^101^1040^164
