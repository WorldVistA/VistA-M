IBDEI2MT ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42014,0)
 ;;=S06.811S^^155^2066^67
 ;;^UTILITY(U,$J,358.3,42014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42014,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,42014,1,4,0)
 ;;=4^S06.811S
 ;;^UTILITY(U,$J,358.3,42014,2)
 ;;=^5021121
 ;;^UTILITY(U,$J,358.3,42015,0)
 ;;=S06.812S^^155^2066^68
 ;;^UTILITY(U,$J,358.3,42015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42015,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,42015,1,4,0)
 ;;=4^S06.812S
 ;;^UTILITY(U,$J,358.3,42015,2)
 ;;=^5021124
 ;;^UTILITY(U,$J,358.3,42016,0)
 ;;=S06.814S^^155^2066^69
 ;;^UTILITY(U,$J,358.3,42016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42016,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,42016,1,4,0)
 ;;=4^S06.814S
 ;;^UTILITY(U,$J,358.3,42016,2)
 ;;=^5021130
 ;;^UTILITY(U,$J,358.3,42017,0)
 ;;=S06.819S^^155^2066^70
 ;;^UTILITY(U,$J,358.3,42017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42017,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,42017,1,4,0)
 ;;=4^S06.819S
 ;;^UTILITY(U,$J,358.3,42017,2)
 ;;=^5021145
 ;;^UTILITY(U,$J,358.3,42018,0)
 ;;=S06.810S^^155^2066^71
 ;;^UTILITY(U,$J,358.3,42018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42018,1,3,0)
 ;;=3^Inj right int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,42018,1,4,0)
 ;;=4^S06.810S
 ;;^UTILITY(U,$J,358.3,42018,2)
 ;;=^5021118
 ;;^UTILITY(U,$J,358.3,42019,0)
 ;;=S06.1X5S^^155^2066^72
 ;;^UTILITY(U,$J,358.3,42019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42019,1,3,0)
 ;;=3^Traum cerebral edema w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,42019,1,4,0)
 ;;=4^S06.1X5S
 ;;^UTILITY(U,$J,358.3,42019,2)
 ;;=^5020713
 ;;^UTILITY(U,$J,358.3,42020,0)
 ;;=S06.1X6S^^155^2066^73
 ;;^UTILITY(U,$J,358.3,42020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42020,1,3,0)
 ;;=3^Traum cerebral edema w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,42020,1,4,0)
 ;;=4^S06.1X6S
 ;;^UTILITY(U,$J,358.3,42020,2)
 ;;=^5020716
 ;;^UTILITY(U,$J,358.3,42021,0)
 ;;=S06.1X3S^^155^2066^107
 ;;^UTILITY(U,$J,358.3,42021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42021,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,42021,1,4,0)
 ;;=4^S06.1X3S
 ;;^UTILITY(U,$J,358.3,42021,2)
 ;;=^5020707
 ;;^UTILITY(U,$J,358.3,42022,0)
 ;;=S06.1X1S^^155^2066^74
 ;;^UTILITY(U,$J,358.3,42022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42022,1,3,0)
 ;;=3^Traum cerebral edema w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,42022,1,4,0)
 ;;=4^S06.1X1S
 ;;^UTILITY(U,$J,358.3,42022,2)
 ;;=^5020701
 ;;^UTILITY(U,$J,358.3,42023,0)
 ;;=S06.1X2S^^155^2066^108
 ;;^UTILITY(U,$J,358.3,42023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42023,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,42023,1,4,0)
 ;;=4^S06.1X2S
 ;;^UTILITY(U,$J,358.3,42023,2)
 ;;=^5020704
 ;;^UTILITY(U,$J,358.3,42024,0)
 ;;=S06.1X4S^^155^2066^109
 ;;^UTILITY(U,$J,358.3,42024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42024,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,42024,1,4,0)
 ;;=4^S06.1X4S
 ;;^UTILITY(U,$J,358.3,42024,2)
 ;;=^5020710
 ;;^UTILITY(U,$J,358.3,42025,0)
 ;;=S06.1X9S^^155^2066^110
