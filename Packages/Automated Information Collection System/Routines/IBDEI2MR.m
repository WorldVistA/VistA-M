IBDEI2MR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41991,1,4,0)
 ;;=4^S06.2X2S
 ;;^UTILITY(U,$J,358.3,41991,2)
 ;;=^5020734
 ;;^UTILITY(U,$J,358.3,41992,0)
 ;;=S06.2X4S^^155^2066^45
 ;;^UTILITY(U,$J,358.3,41992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41992,1,3,0)
 ;;=3^Diffuse TBI w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,41992,1,4,0)
 ;;=4^S06.2X4S
 ;;^UTILITY(U,$J,358.3,41992,2)
 ;;=^5020740
 ;;^UTILITY(U,$J,358.3,41993,0)
 ;;=S06.2X9S^^155^2066^46
 ;;^UTILITY(U,$J,358.3,41993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41993,1,3,0)
 ;;=3^Diffuse TBI w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,41993,1,4,0)
 ;;=4^S06.2X9S
 ;;^UTILITY(U,$J,358.3,41993,2)
 ;;=^5020755
 ;;^UTILITY(U,$J,358.3,41994,0)
 ;;=S06.2X0S^^155^2066^47
 ;;^UTILITY(U,$J,358.3,41994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41994,1,3,0)
 ;;=3^Diffuse TBI w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,41994,1,4,0)
 ;;=4^S06.2X0S
 ;;^UTILITY(U,$J,358.3,41994,2)
 ;;=^5020728
 ;;^UTILITY(U,$J,358.3,41995,0)
 ;;=S06.4X5S^^155^2066^48
 ;;^UTILITY(U,$J,358.3,41995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41995,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,41995,1,4,0)
 ;;=4^S06.4X5S
 ;;^UTILITY(U,$J,358.3,41995,2)
 ;;=^5021043
 ;;^UTILITY(U,$J,358.3,41996,0)
 ;;=S06.4X6S^^155^2066^49
 ;;^UTILITY(U,$J,358.3,41996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41996,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,41996,1,4,0)
 ;;=4^S06.4X6S
 ;;^UTILITY(U,$J,358.3,41996,2)
 ;;=^5021046
 ;;^UTILITY(U,$J,358.3,41997,0)
 ;;=S06.4X3S^^155^2066^50
 ;;^UTILITY(U,$J,358.3,41997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41997,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,41997,1,4,0)
 ;;=4^S06.4X3S
 ;;^UTILITY(U,$J,358.3,41997,2)
 ;;=^5021037
 ;;^UTILITY(U,$J,358.3,41998,0)
 ;;=S06.4X1S^^155^2066^51
 ;;^UTILITY(U,$J,358.3,41998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41998,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,41998,1,4,0)
 ;;=4^S06.4X1S
 ;;^UTILITY(U,$J,358.3,41998,2)
 ;;=^5021031
 ;;^UTILITY(U,$J,358.3,41999,0)
 ;;=S06.4X2S^^155^2066^52
 ;;^UTILITY(U,$J,358.3,41999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41999,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,41999,1,4,0)
 ;;=4^S06.4X2S
 ;;^UTILITY(U,$J,358.3,41999,2)
 ;;=^5021034
 ;;^UTILITY(U,$J,358.3,42000,0)
 ;;=S06.4X4S^^155^2066^53
 ;;^UTILITY(U,$J,358.3,42000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42000,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,42000,1,4,0)
 ;;=4^S06.4X4S
 ;;^UTILITY(U,$J,358.3,42000,2)
 ;;=^5021040
 ;;^UTILITY(U,$J,358.3,42001,0)
 ;;=S06.4X9S^^155^2066^54
 ;;^UTILITY(U,$J,358.3,42001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42001,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,42001,1,4,0)
 ;;=4^S06.4X9S
 ;;^UTILITY(U,$J,358.3,42001,2)
 ;;=^5021055
 ;;^UTILITY(U,$J,358.3,42002,0)
 ;;=S06.4X0S^^155^2066^55
 ;;^UTILITY(U,$J,358.3,42002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42002,1,3,0)
 ;;=3^Epidural hemorrhage without LOC, sequela
 ;;^UTILITY(U,$J,358.3,42002,1,4,0)
 ;;=4^S06.4X0S
 ;;^UTILITY(U,$J,358.3,42002,2)
 ;;=^5021028
