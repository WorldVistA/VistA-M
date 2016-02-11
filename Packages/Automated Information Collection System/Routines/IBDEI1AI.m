IBDEI1AI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21552,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,21552,1,4,0)
 ;;=4^S06.814S
 ;;^UTILITY(U,$J,358.3,21552,2)
 ;;=^5021130
 ;;^UTILITY(U,$J,358.3,21553,0)
 ;;=S06.819S^^101^1032^77
 ;;^UTILITY(U,$J,358.3,21553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21553,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,21553,1,4,0)
 ;;=4^S06.819S
 ;;^UTILITY(U,$J,358.3,21553,2)
 ;;=^5021145
 ;;^UTILITY(U,$J,358.3,21554,0)
 ;;=S06.810S^^101^1032^78
 ;;^UTILITY(U,$J,358.3,21554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21554,1,3,0)
 ;;=3^Inj right int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,21554,1,4,0)
 ;;=4^S06.810S
 ;;^UTILITY(U,$J,358.3,21554,2)
 ;;=^5021118
 ;;^UTILITY(U,$J,358.3,21555,0)
 ;;=S06.1X5S^^101^1032^79
 ;;^UTILITY(U,$J,358.3,21555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21555,1,3,0)
 ;;=3^Traum cerebral edema w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,21555,1,4,0)
 ;;=4^S06.1X5S
 ;;^UTILITY(U,$J,358.3,21555,2)
 ;;=^5020713
 ;;^UTILITY(U,$J,358.3,21556,0)
 ;;=S06.1X6S^^101^1032^80
 ;;^UTILITY(U,$J,358.3,21556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21556,1,3,0)
 ;;=3^Traum cerebral edema w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,21556,1,4,0)
 ;;=4^S06.1X6S
 ;;^UTILITY(U,$J,358.3,21556,2)
 ;;=^5020716
 ;;^UTILITY(U,$J,358.3,21557,0)
 ;;=S06.1X3S^^101^1032^114
 ;;^UTILITY(U,$J,358.3,21557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21557,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,21557,1,4,0)
 ;;=4^S06.1X3S
 ;;^UTILITY(U,$J,358.3,21557,2)
 ;;=^5020707
 ;;^UTILITY(U,$J,358.3,21558,0)
 ;;=S06.1X1S^^101^1032^81
 ;;^UTILITY(U,$J,358.3,21558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21558,1,3,0)
 ;;=3^Traum cerebral edema w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,21558,1,4,0)
 ;;=4^S06.1X1S
 ;;^UTILITY(U,$J,358.3,21558,2)
 ;;=^5020701
 ;;^UTILITY(U,$J,358.3,21559,0)
 ;;=S06.1X2S^^101^1032^115
 ;;^UTILITY(U,$J,358.3,21559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21559,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,21559,1,4,0)
 ;;=4^S06.1X2S
 ;;^UTILITY(U,$J,358.3,21559,2)
 ;;=^5020704
 ;;^UTILITY(U,$J,358.3,21560,0)
 ;;=S06.1X4S^^101^1032^116
 ;;^UTILITY(U,$J,358.3,21560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21560,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,21560,1,4,0)
 ;;=4^S06.1X4S
 ;;^UTILITY(U,$J,358.3,21560,2)
 ;;=^5020710
 ;;^UTILITY(U,$J,358.3,21561,0)
 ;;=S06.1X9S^^101^1032^117
 ;;^UTILITY(U,$J,358.3,21561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21561,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,21561,1,4,0)
 ;;=4^S06.1X9S
 ;;^UTILITY(U,$J,358.3,21561,2)
 ;;=^5020725
 ;;^UTILITY(U,$J,358.3,21562,0)
 ;;=S06.1X0S^^101^1032^118
 ;;^UTILITY(U,$J,358.3,21562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21562,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,21562,1,4,0)
 ;;=4^S06.1X0S
 ;;^UTILITY(U,$J,358.3,21562,2)
 ;;=^5020698
 ;;^UTILITY(U,$J,358.3,21563,0)
 ;;=S06.355S^^101^1032^82
 ;;^UTILITY(U,$J,358.3,21563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21563,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,21563,1,4,0)
 ;;=4^S06.355S
 ;;^UTILITY(U,$J,358.3,21563,2)
 ;;=^5020923
 ;;^UTILITY(U,$J,358.3,21564,0)
 ;;=S06.356S^^101^1032^83
