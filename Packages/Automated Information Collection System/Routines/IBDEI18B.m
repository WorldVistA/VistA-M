IBDEI18B ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19941,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19941,1,4,0)
 ;;=4^S06.813S
 ;;^UTILITY(U,$J,358.3,19941,2)
 ;;=^5021127
 ;;^UTILITY(U,$J,358.3,19942,0)
 ;;=S06.811S^^67^882^67
 ;;^UTILITY(U,$J,358.3,19942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19942,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19942,1,4,0)
 ;;=4^S06.811S
 ;;^UTILITY(U,$J,358.3,19942,2)
 ;;=^5021121
 ;;^UTILITY(U,$J,358.3,19943,0)
 ;;=S06.812S^^67^882^68
 ;;^UTILITY(U,$J,358.3,19943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19943,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19943,1,4,0)
 ;;=4^S06.812S
 ;;^UTILITY(U,$J,358.3,19943,2)
 ;;=^5021124
 ;;^UTILITY(U,$J,358.3,19944,0)
 ;;=S06.814S^^67^882^69
 ;;^UTILITY(U,$J,358.3,19944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19944,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,19944,1,4,0)
 ;;=4^S06.814S
 ;;^UTILITY(U,$J,358.3,19944,2)
 ;;=^5021130
 ;;^UTILITY(U,$J,358.3,19945,0)
 ;;=S06.819S^^67^882^70
 ;;^UTILITY(U,$J,358.3,19945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19945,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19945,1,4,0)
 ;;=4^S06.819S
 ;;^UTILITY(U,$J,358.3,19945,2)
 ;;=^5021145
 ;;^UTILITY(U,$J,358.3,19946,0)
 ;;=S06.810S^^67^882^71
 ;;^UTILITY(U,$J,358.3,19946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19946,1,3,0)
 ;;=3^Inj right int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19946,1,4,0)
 ;;=4^S06.810S
 ;;^UTILITY(U,$J,358.3,19946,2)
 ;;=^5021118
 ;;^UTILITY(U,$J,358.3,19947,0)
 ;;=S06.1X5S^^67^882^72
 ;;^UTILITY(U,$J,358.3,19947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19947,1,3,0)
 ;;=3^Traum cerebral edema w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19947,1,4,0)
 ;;=4^S06.1X5S
 ;;^UTILITY(U,$J,358.3,19947,2)
 ;;=^5020713
 ;;^UTILITY(U,$J,358.3,19948,0)
 ;;=S06.1X6S^^67^882^73
 ;;^UTILITY(U,$J,358.3,19948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19948,1,3,0)
 ;;=3^Traum cerebral edema w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,19948,1,4,0)
 ;;=4^S06.1X6S
 ;;^UTILITY(U,$J,358.3,19948,2)
 ;;=^5020716
 ;;^UTILITY(U,$J,358.3,19949,0)
 ;;=S06.1X3S^^67^882^107
 ;;^UTILITY(U,$J,358.3,19949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19949,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19949,1,4,0)
 ;;=4^S06.1X3S
 ;;^UTILITY(U,$J,358.3,19949,2)
 ;;=^5020707
 ;;^UTILITY(U,$J,358.3,19950,0)
 ;;=S06.1X1S^^67^882^74
 ;;^UTILITY(U,$J,358.3,19950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19950,1,3,0)
 ;;=3^Traum cerebral edema w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19950,1,4,0)
 ;;=4^S06.1X1S
 ;;^UTILITY(U,$J,358.3,19950,2)
 ;;=^5020701
 ;;^UTILITY(U,$J,358.3,19951,0)
 ;;=S06.1X2S^^67^882^108
 ;;^UTILITY(U,$J,358.3,19951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19951,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19951,1,4,0)
 ;;=4^S06.1X2S
 ;;^UTILITY(U,$J,358.3,19951,2)
 ;;=^5020704
 ;;^UTILITY(U,$J,358.3,19952,0)
 ;;=S06.1X4S^^67^882^109
 ;;^UTILITY(U,$J,358.3,19952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19952,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6-24 hrs, sequela
