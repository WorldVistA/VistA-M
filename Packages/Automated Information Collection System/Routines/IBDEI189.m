IBDEI189 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19918,1,4,0)
 ;;=4^S06.2X1S
 ;;^UTILITY(U,$J,358.3,19918,2)
 ;;=^5020731
 ;;^UTILITY(U,$J,358.3,19919,0)
 ;;=S06.2X2S^^67^882^44
 ;;^UTILITY(U,$J,358.3,19919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19919,1,3,0)
 ;;=3^Diffuse TBI w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19919,1,4,0)
 ;;=4^S06.2X2S
 ;;^UTILITY(U,$J,358.3,19919,2)
 ;;=^5020734
 ;;^UTILITY(U,$J,358.3,19920,0)
 ;;=S06.2X4S^^67^882^45
 ;;^UTILITY(U,$J,358.3,19920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19920,1,3,0)
 ;;=3^Diffuse TBI w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,19920,1,4,0)
 ;;=4^S06.2X4S
 ;;^UTILITY(U,$J,358.3,19920,2)
 ;;=^5020740
 ;;^UTILITY(U,$J,358.3,19921,0)
 ;;=S06.2X9S^^67^882^46
 ;;^UTILITY(U,$J,358.3,19921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19921,1,3,0)
 ;;=3^Diffuse TBI w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19921,1,4,0)
 ;;=4^S06.2X9S
 ;;^UTILITY(U,$J,358.3,19921,2)
 ;;=^5020755
 ;;^UTILITY(U,$J,358.3,19922,0)
 ;;=S06.2X0S^^67^882^47
 ;;^UTILITY(U,$J,358.3,19922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19922,1,3,0)
 ;;=3^Diffuse TBI w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19922,1,4,0)
 ;;=4^S06.2X0S
 ;;^UTILITY(U,$J,358.3,19922,2)
 ;;=^5020728
 ;;^UTILITY(U,$J,358.3,19923,0)
 ;;=S06.4X5S^^67^882^48
 ;;^UTILITY(U,$J,358.3,19923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19923,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19923,1,4,0)
 ;;=4^S06.4X5S
 ;;^UTILITY(U,$J,358.3,19923,2)
 ;;=^5021043
 ;;^UTILITY(U,$J,358.3,19924,0)
 ;;=S06.4X6S^^67^882^49
 ;;^UTILITY(U,$J,358.3,19924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19924,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,19924,1,4,0)
 ;;=4^S06.4X6S
 ;;^UTILITY(U,$J,358.3,19924,2)
 ;;=^5021046
 ;;^UTILITY(U,$J,358.3,19925,0)
 ;;=S06.4X3S^^67^882^50
 ;;^UTILITY(U,$J,358.3,19925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19925,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19925,1,4,0)
 ;;=4^S06.4X3S
 ;;^UTILITY(U,$J,358.3,19925,2)
 ;;=^5021037
 ;;^UTILITY(U,$J,358.3,19926,0)
 ;;=S06.4X1S^^67^882^51
 ;;^UTILITY(U,$J,358.3,19926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19926,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19926,1,4,0)
 ;;=4^S06.4X1S
 ;;^UTILITY(U,$J,358.3,19926,2)
 ;;=^5021031
 ;;^UTILITY(U,$J,358.3,19927,0)
 ;;=S06.4X2S^^67^882^52
 ;;^UTILITY(U,$J,358.3,19927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19927,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19927,1,4,0)
 ;;=4^S06.4X2S
 ;;^UTILITY(U,$J,358.3,19927,2)
 ;;=^5021034
 ;;^UTILITY(U,$J,358.3,19928,0)
 ;;=S06.4X4S^^67^882^53
 ;;^UTILITY(U,$J,358.3,19928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19928,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,19928,1,4,0)
 ;;=4^S06.4X4S
 ;;^UTILITY(U,$J,358.3,19928,2)
 ;;=^5021040
 ;;^UTILITY(U,$J,358.3,19929,0)
 ;;=S06.4X9S^^67^882^54
 ;;^UTILITY(U,$J,358.3,19929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19929,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19929,1,4,0)
 ;;=4^S06.4X9S
 ;;^UTILITY(U,$J,358.3,19929,2)
 ;;=^5021055
 ;;^UTILITY(U,$J,358.3,19930,0)
 ;;=S06.4X0S^^67^882^55
