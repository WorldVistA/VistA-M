IBDEI2WX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48887,1,3,0)
 ;;=3^Traum subrac hem w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,48887,1,4,0)
 ;;=4^S06.6X4S
 ;;^UTILITY(U,$J,358.3,48887,2)
 ;;=^5021100
 ;;^UTILITY(U,$J,358.3,48888,0)
 ;;=S06.6X9S^^216^2412^112
 ;;^UTILITY(U,$J,358.3,48888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48888,1,3,0)
 ;;=3^Traum subrac hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,48888,1,4,0)
 ;;=4^S06.6X9S
 ;;^UTILITY(U,$J,358.3,48888,2)
 ;;=^5021115
 ;;^UTILITY(U,$J,358.3,48889,0)
 ;;=S06.6X0S^^216^2412^113
 ;;^UTILITY(U,$J,358.3,48889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48889,1,3,0)
 ;;=3^Traum subrac hem w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,48889,1,4,0)
 ;;=4^S06.6X0S
 ;;^UTILITY(U,$J,358.3,48889,2)
 ;;=^5021088
 ;;^UTILITY(U,$J,358.3,48890,0)
 ;;=S06.5X5S^^216^2412^98
 ;;^UTILITY(U,$J,358.3,48890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48890,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,48890,1,4,0)
 ;;=4^S06.5X5S
 ;;^UTILITY(U,$J,358.3,48890,2)
 ;;=^5021073
 ;;^UTILITY(U,$J,358.3,48891,0)
 ;;=S06.5X6S^^216^2412^99
 ;;^UTILITY(U,$J,358.3,48891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48891,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,48891,1,4,0)
 ;;=4^S06.5X6S
 ;;^UTILITY(U,$J,358.3,48891,2)
 ;;=^5021076
 ;;^UTILITY(U,$J,358.3,48892,0)
 ;;=S06.5X3S^^216^2412^100
 ;;^UTILITY(U,$J,358.3,48892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48892,1,3,0)
 ;;=3^Traum subdr hem w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,48892,1,4,0)
 ;;=4^S06.5X3S
 ;;^UTILITY(U,$J,358.3,48892,2)
 ;;=^5021067
 ;;^UTILITY(U,$J,358.3,48893,0)
 ;;=S06.5X1S^^216^2412^101
 ;;^UTILITY(U,$J,358.3,48893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48893,1,3,0)
 ;;=3^Traum subdr hem w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,48893,1,4,0)
 ;;=4^S06.5X1S
 ;;^UTILITY(U,$J,358.3,48893,2)
 ;;=^5021061
 ;;^UTILITY(U,$J,358.3,48894,0)
 ;;=S06.5X2S^^216^2412^102
 ;;^UTILITY(U,$J,358.3,48894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48894,1,3,0)
 ;;=3^Traum subdr hem w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,48894,1,4,0)
 ;;=4^S06.5X2S
 ;;^UTILITY(U,$J,358.3,48894,2)
 ;;=^5021064
 ;;^UTILITY(U,$J,358.3,48895,0)
 ;;=S06.5X4S^^216^2412^103
 ;;^UTILITY(U,$J,358.3,48895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48895,1,3,0)
 ;;=3^Traum subdr hem w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,48895,1,4,0)
 ;;=4^S06.5X4S
 ;;^UTILITY(U,$J,358.3,48895,2)
 ;;=^5021070
 ;;^UTILITY(U,$J,358.3,48896,0)
 ;;=S06.5X9S^^216^2412^104
 ;;^UTILITY(U,$J,358.3,48896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48896,1,3,0)
 ;;=3^Traum subdr hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,48896,1,4,0)
 ;;=4^S06.5X9S
 ;;^UTILITY(U,$J,358.3,48896,2)
 ;;=^5021085
 ;;^UTILITY(U,$J,358.3,48897,0)
 ;;=S06.5X0S^^216^2412^105
 ;;^UTILITY(U,$J,358.3,48897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48897,1,3,0)
 ;;=3^Traum subdr hem w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,48897,1,4,0)
 ;;=4^S06.5X0S
 ;;^UTILITY(U,$J,358.3,48897,2)
 ;;=^5021058
 ;;^UTILITY(U,$J,358.3,48898,0)
 ;;=M84.351S^^216^2413^107
 ;;^UTILITY(U,$J,358.3,48898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48898,1,3,0)
 ;;=3^Stress fracture, right femur, sequela
 ;;^UTILITY(U,$J,358.3,48898,1,4,0)
 ;;=4^M84.351S
 ;;^UTILITY(U,$J,358.3,48898,2)
 ;;=^5013685
 ;;^UTILITY(U,$J,358.3,48899,0)
 ;;=M84.352S^^216^2413^106
 ;;^UTILITY(U,$J,358.3,48899,1,0)
 ;;=^358.31IA^4^2
