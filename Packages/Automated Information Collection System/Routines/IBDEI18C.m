IBDEI18C ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19952,1,4,0)
 ;;=4^S06.1X4S
 ;;^UTILITY(U,$J,358.3,19952,2)
 ;;=^5020710
 ;;^UTILITY(U,$J,358.3,19953,0)
 ;;=S06.1X9S^^67^882^110
 ;;^UTILITY(U,$J,358.3,19953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19953,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19953,1,4,0)
 ;;=4^S06.1X9S
 ;;^UTILITY(U,$J,358.3,19953,2)
 ;;=^5020725
 ;;^UTILITY(U,$J,358.3,19954,0)
 ;;=S06.1X0S^^67^882^111
 ;;^UTILITY(U,$J,358.3,19954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19954,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19954,1,4,0)
 ;;=4^S06.1X0S
 ;;^UTILITY(U,$J,358.3,19954,2)
 ;;=^5020698
 ;;^UTILITY(U,$J,358.3,19955,0)
 ;;=S06.355S^^67^882^75
 ;;^UTILITY(U,$J,358.3,19955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19955,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19955,1,4,0)
 ;;=4^S06.355S
 ;;^UTILITY(U,$J,358.3,19955,2)
 ;;=^5020923
 ;;^UTILITY(U,$J,358.3,19956,0)
 ;;=S06.356S^^67^882^76
 ;;^UTILITY(U,$J,358.3,19956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19956,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,19956,1,4,0)
 ;;=4^S06.356S
 ;;^UTILITY(U,$J,358.3,19956,2)
 ;;=^5020926
 ;;^UTILITY(U,$J,358.3,19957,0)
 ;;=S06.353S^^67^882^77
 ;;^UTILITY(U,$J,358.3,19957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19957,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 1-5 hrs 59 minutes, sequela
 ;;^UTILITY(U,$J,358.3,19957,1,4,0)
 ;;=4^S06.353S
 ;;^UTILITY(U,$J,358.3,19957,2)
 ;;=^5020917
 ;;^UTILITY(U,$J,358.3,19958,0)
 ;;=S06.351S^^67^882^78
 ;;^UTILITY(U,$J,358.3,19958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19958,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19958,1,4,0)
 ;;=4^S06.351S
 ;;^UTILITY(U,$J,358.3,19958,2)
 ;;=^5020911
 ;;^UTILITY(U,$J,358.3,19959,0)
 ;;=S06.352S^^67^882^79
 ;;^UTILITY(U,$J,358.3,19959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19959,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19959,1,4,0)
 ;;=4^S06.352S
 ;;^UTILITY(U,$J,358.3,19959,2)
 ;;=^5020914
 ;;^UTILITY(U,$J,358.3,19960,0)
 ;;=S06.354S^^67^882^80
 ;;^UTILITY(U,$J,358.3,19960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19960,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,19960,1,4,0)
 ;;=4^S06.354S
 ;;^UTILITY(U,$J,358.3,19960,2)
 ;;=^5020920
 ;;^UTILITY(U,$J,358.3,19961,0)
 ;;=S06.359S^^67^882^81
 ;;^UTILITY(U,$J,358.3,19961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19961,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19961,1,4,0)
 ;;=4^S06.359S
 ;;^UTILITY(U,$J,358.3,19961,2)
 ;;=^5020935
 ;;^UTILITY(U,$J,358.3,19962,0)
 ;;=S06.350S^^67^882^82
 ;;^UTILITY(U,$J,358.3,19962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19962,1,3,0)
 ;;=3^Traum hemor left cerebrum w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19962,1,4,0)
 ;;=4^S06.350S
 ;;^UTILITY(U,$J,358.3,19962,2)
 ;;=^5020908
 ;;^UTILITY(U,$J,358.3,19963,0)
 ;;=S06.345S^^67^882^83
 ;;^UTILITY(U,$J,358.3,19963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19963,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19963,1,4,0)
 ;;=4^S06.345S
