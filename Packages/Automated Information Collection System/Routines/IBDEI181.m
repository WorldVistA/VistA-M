IBDEI181 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19601,1,4,0)
 ;;=4^S06.6X6S
 ;;^UTILITY(U,$J,358.3,19601,2)
 ;;=^5021106
 ;;^UTILITY(U,$J,358.3,19602,0)
 ;;=S06.6X3S^^93^994^101
 ;;^UTILITY(U,$J,358.3,19602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19602,1,3,0)
 ;;=3^Traum subrac hem w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19602,1,4,0)
 ;;=4^S06.6X3S
 ;;^UTILITY(U,$J,358.3,19602,2)
 ;;=^5021097
 ;;^UTILITY(U,$J,358.3,19603,0)
 ;;=S06.6X1S^^93^994^102
 ;;^UTILITY(U,$J,358.3,19603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19603,1,3,0)
 ;;=3^Traum subrac hem w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19603,1,4,0)
 ;;=4^S06.6X1S
 ;;^UTILITY(U,$J,358.3,19603,2)
 ;;=^5021091
 ;;^UTILITY(U,$J,358.3,19604,0)
 ;;=S06.6X2S^^93^994^103
 ;;^UTILITY(U,$J,358.3,19604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19604,1,3,0)
 ;;=3^Traum subrac hem w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19604,1,4,0)
 ;;=4^S06.6X2S
 ;;^UTILITY(U,$J,358.3,19604,2)
 ;;=^5021094
 ;;^UTILITY(U,$J,358.3,19605,0)
 ;;=S06.6X4S^^93^994^104
 ;;^UTILITY(U,$J,358.3,19605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19605,1,3,0)
 ;;=3^Traum subrac hem w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,19605,1,4,0)
 ;;=4^S06.6X4S
 ;;^UTILITY(U,$J,358.3,19605,2)
 ;;=^5021100
 ;;^UTILITY(U,$J,358.3,19606,0)
 ;;=S06.6X9S^^93^994^105
 ;;^UTILITY(U,$J,358.3,19606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19606,1,3,0)
 ;;=3^Traum subrac hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19606,1,4,0)
 ;;=4^S06.6X9S
 ;;^UTILITY(U,$J,358.3,19606,2)
 ;;=^5021115
 ;;^UTILITY(U,$J,358.3,19607,0)
 ;;=S06.6X0S^^93^994^106
 ;;^UTILITY(U,$J,358.3,19607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19607,1,3,0)
 ;;=3^Traum subrac hem w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19607,1,4,0)
 ;;=4^S06.6X0S
 ;;^UTILITY(U,$J,358.3,19607,2)
 ;;=^5021088
 ;;^UTILITY(U,$J,358.3,19608,0)
 ;;=S06.5X5S^^93^994^91
 ;;^UTILITY(U,$J,358.3,19608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19608,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19608,1,4,0)
 ;;=4^S06.5X5S
 ;;^UTILITY(U,$J,358.3,19608,2)
 ;;=^5021073
 ;;^UTILITY(U,$J,358.3,19609,0)
 ;;=S06.5X6S^^93^994^92
 ;;^UTILITY(U,$J,358.3,19609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19609,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,19609,1,4,0)
 ;;=4^S06.5X6S
 ;;^UTILITY(U,$J,358.3,19609,2)
 ;;=^5021076
 ;;^UTILITY(U,$J,358.3,19610,0)
 ;;=S06.5X3S^^93^994^93
 ;;^UTILITY(U,$J,358.3,19610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19610,1,3,0)
 ;;=3^Traum subdr hem w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19610,1,4,0)
 ;;=4^S06.5X3S
 ;;^UTILITY(U,$J,358.3,19610,2)
 ;;=^5021067
 ;;^UTILITY(U,$J,358.3,19611,0)
 ;;=S06.5X1S^^93^994^94
 ;;^UTILITY(U,$J,358.3,19611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19611,1,3,0)
 ;;=3^Traum subdr hem w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19611,1,4,0)
 ;;=4^S06.5X1S
 ;;^UTILITY(U,$J,358.3,19611,2)
 ;;=^5021061
 ;;^UTILITY(U,$J,358.3,19612,0)
 ;;=S06.5X2S^^93^994^95
 ;;^UTILITY(U,$J,358.3,19612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19612,1,3,0)
 ;;=3^Traum subdr hem w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19612,1,4,0)
 ;;=4^S06.5X2S
 ;;^UTILITY(U,$J,358.3,19612,2)
 ;;=^5021064
 ;;^UTILITY(U,$J,358.3,19613,0)
 ;;=S06.5X4S^^93^994^96
