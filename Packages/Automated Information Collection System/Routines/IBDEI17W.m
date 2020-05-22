IBDEI17W ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19545,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,19545,1,4,0)
 ;;=4^S06.2X6S
 ;;^UTILITY(U,$J,358.3,19545,2)
 ;;=^5020746
 ;;^UTILITY(U,$J,358.3,19546,0)
 ;;=S06.2X3S^^93^994^42
 ;;^UTILITY(U,$J,358.3,19546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19546,1,3,0)
 ;;=3^Diffuse TBI w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19546,1,4,0)
 ;;=4^S06.2X3S
 ;;^UTILITY(U,$J,358.3,19546,2)
 ;;=^5020737
 ;;^UTILITY(U,$J,358.3,19547,0)
 ;;=S06.2X1S^^93^994^43
 ;;^UTILITY(U,$J,358.3,19547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19547,1,3,0)
 ;;=3^Diffuse TBI w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19547,1,4,0)
 ;;=4^S06.2X1S
 ;;^UTILITY(U,$J,358.3,19547,2)
 ;;=^5020731
 ;;^UTILITY(U,$J,358.3,19548,0)
 ;;=S06.2X2S^^93^994^44
 ;;^UTILITY(U,$J,358.3,19548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19548,1,3,0)
 ;;=3^Diffuse TBI w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19548,1,4,0)
 ;;=4^S06.2X2S
 ;;^UTILITY(U,$J,358.3,19548,2)
 ;;=^5020734
 ;;^UTILITY(U,$J,358.3,19549,0)
 ;;=S06.2X4S^^93^994^45
 ;;^UTILITY(U,$J,358.3,19549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19549,1,3,0)
 ;;=3^Diffuse TBI w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,19549,1,4,0)
 ;;=4^S06.2X4S
 ;;^UTILITY(U,$J,358.3,19549,2)
 ;;=^5020740
 ;;^UTILITY(U,$J,358.3,19550,0)
 ;;=S06.2X9S^^93^994^46
 ;;^UTILITY(U,$J,358.3,19550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19550,1,3,0)
 ;;=3^Diffuse TBI w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19550,1,4,0)
 ;;=4^S06.2X9S
 ;;^UTILITY(U,$J,358.3,19550,2)
 ;;=^5020755
 ;;^UTILITY(U,$J,358.3,19551,0)
 ;;=S06.2X0S^^93^994^47
 ;;^UTILITY(U,$J,358.3,19551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19551,1,3,0)
 ;;=3^Diffuse TBI w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19551,1,4,0)
 ;;=4^S06.2X0S
 ;;^UTILITY(U,$J,358.3,19551,2)
 ;;=^5020728
 ;;^UTILITY(U,$J,358.3,19552,0)
 ;;=S06.4X5S^^93^994^48
 ;;^UTILITY(U,$J,358.3,19552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19552,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19552,1,4,0)
 ;;=4^S06.4X5S
 ;;^UTILITY(U,$J,358.3,19552,2)
 ;;=^5021043
 ;;^UTILITY(U,$J,358.3,19553,0)
 ;;=S06.4X6S^^93^994^49
 ;;^UTILITY(U,$J,358.3,19553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19553,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,19553,1,4,0)
 ;;=4^S06.4X6S
 ;;^UTILITY(U,$J,358.3,19553,2)
 ;;=^5021046
 ;;^UTILITY(U,$J,358.3,19554,0)
 ;;=S06.4X3S^^93^994^50
 ;;^UTILITY(U,$J,358.3,19554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19554,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19554,1,4,0)
 ;;=4^S06.4X3S
 ;;^UTILITY(U,$J,358.3,19554,2)
 ;;=^5021037
 ;;^UTILITY(U,$J,358.3,19555,0)
 ;;=S06.4X1S^^93^994^51
 ;;^UTILITY(U,$J,358.3,19555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19555,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19555,1,4,0)
 ;;=4^S06.4X1S
 ;;^UTILITY(U,$J,358.3,19555,2)
 ;;=^5021031
 ;;^UTILITY(U,$J,358.3,19556,0)
 ;;=S06.4X2S^^93^994^52
 ;;^UTILITY(U,$J,358.3,19556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19556,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19556,1,4,0)
 ;;=4^S06.4X2S
