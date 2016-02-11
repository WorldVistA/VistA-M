IBDEI1AL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21587,2)
 ;;=^5021073
 ;;^UTILITY(U,$J,358.3,21588,0)
 ;;=S06.5X6S^^101^1032^99
 ;;^UTILITY(U,$J,358.3,21588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21588,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,21588,1,4,0)
 ;;=4^S06.5X6S
 ;;^UTILITY(U,$J,358.3,21588,2)
 ;;=^5021076
 ;;^UTILITY(U,$J,358.3,21589,0)
 ;;=S06.5X3S^^101^1032^100
 ;;^UTILITY(U,$J,358.3,21589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21589,1,3,0)
 ;;=3^Traum subdr hem w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,21589,1,4,0)
 ;;=4^S06.5X3S
 ;;^UTILITY(U,$J,358.3,21589,2)
 ;;=^5021067
 ;;^UTILITY(U,$J,358.3,21590,0)
 ;;=S06.5X1S^^101^1032^101
 ;;^UTILITY(U,$J,358.3,21590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21590,1,3,0)
 ;;=3^Traum subdr hem w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,21590,1,4,0)
 ;;=4^S06.5X1S
 ;;^UTILITY(U,$J,358.3,21590,2)
 ;;=^5021061
 ;;^UTILITY(U,$J,358.3,21591,0)
 ;;=S06.5X2S^^101^1032^102
 ;;^UTILITY(U,$J,358.3,21591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21591,1,3,0)
 ;;=3^Traum subdr hem w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,21591,1,4,0)
 ;;=4^S06.5X2S
 ;;^UTILITY(U,$J,358.3,21591,2)
 ;;=^5021064
 ;;^UTILITY(U,$J,358.3,21592,0)
 ;;=S06.5X4S^^101^1032^103
 ;;^UTILITY(U,$J,358.3,21592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21592,1,3,0)
 ;;=3^Traum subdr hem w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,21592,1,4,0)
 ;;=4^S06.5X4S
 ;;^UTILITY(U,$J,358.3,21592,2)
 ;;=^5021070
 ;;^UTILITY(U,$J,358.3,21593,0)
 ;;=S06.5X9S^^101^1032^104
 ;;^UTILITY(U,$J,358.3,21593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21593,1,3,0)
 ;;=3^Traum subdr hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,21593,1,4,0)
 ;;=4^S06.5X9S
 ;;^UTILITY(U,$J,358.3,21593,2)
 ;;=^5021085
 ;;^UTILITY(U,$J,358.3,21594,0)
 ;;=S06.5X0S^^101^1032^105
 ;;^UTILITY(U,$J,358.3,21594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21594,1,3,0)
 ;;=3^Traum subdr hem w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,21594,1,4,0)
 ;;=4^S06.5X0S
 ;;^UTILITY(U,$J,358.3,21594,2)
 ;;=^5021058
 ;;^UTILITY(U,$J,358.3,21595,0)
 ;;=M84.351S^^101^1033^107
 ;;^UTILITY(U,$J,358.3,21595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21595,1,3,0)
 ;;=3^Stress fracture, right femur, sequela
 ;;^UTILITY(U,$J,358.3,21595,1,4,0)
 ;;=4^M84.351S
 ;;^UTILITY(U,$J,358.3,21595,2)
 ;;=^5013685
 ;;^UTILITY(U,$J,358.3,21596,0)
 ;;=M84.352S^^101^1033^106
 ;;^UTILITY(U,$J,358.3,21596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21596,1,3,0)
 ;;=3^Stress fracture, left femur, sequela
 ;;^UTILITY(U,$J,358.3,21596,1,4,0)
 ;;=4^M84.352S
 ;;^UTILITY(U,$J,358.3,21596,2)
 ;;=^5013691
 ;;^UTILITY(U,$J,358.3,21597,0)
 ;;=M84.451S^^101^1033^95
 ;;^UTILITY(U,$J,358.3,21597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21597,1,3,0)
 ;;=3^Pathological fracture, right femur, sequela
 ;;^UTILITY(U,$J,358.3,21597,1,4,0)
 ;;=4^M84.451S
 ;;^UTILITY(U,$J,358.3,21597,2)
 ;;=^5013907
 ;;^UTILITY(U,$J,358.3,21598,0)
 ;;=M84.452S^^101^1033^94
 ;;^UTILITY(U,$J,358.3,21598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21598,1,3,0)
 ;;=3^Pathological fracture, left femur, sequela
 ;;^UTILITY(U,$J,358.3,21598,1,4,0)
 ;;=4^M84.452S
 ;;^UTILITY(U,$J,358.3,21598,2)
 ;;=^5013913
 ;;^UTILITY(U,$J,358.3,21599,0)
 ;;=S72.021S^^101^1033^12
 ;;^UTILITY(U,$J,358.3,21599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21599,1,3,0)
 ;;=3^Displaced epiphy fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,21599,1,4,0)
 ;;=4^S72.021S
 ;;^UTILITY(U,$J,358.3,21599,2)
 ;;=^5037136
