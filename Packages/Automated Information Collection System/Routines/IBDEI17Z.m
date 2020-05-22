IBDEI17Z ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19579,1,3,0)
 ;;=3^Traum cerebral edema w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19579,1,4,0)
 ;;=4^S06.1X1S
 ;;^UTILITY(U,$J,358.3,19579,2)
 ;;=^5020701
 ;;^UTILITY(U,$J,358.3,19580,0)
 ;;=S06.1X2S^^93^994^108
 ;;^UTILITY(U,$J,358.3,19580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19580,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19580,1,4,0)
 ;;=4^S06.1X2S
 ;;^UTILITY(U,$J,358.3,19580,2)
 ;;=^5020704
 ;;^UTILITY(U,$J,358.3,19581,0)
 ;;=S06.1X4S^^93^994^109
 ;;^UTILITY(U,$J,358.3,19581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19581,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,19581,1,4,0)
 ;;=4^S06.1X4S
 ;;^UTILITY(U,$J,358.3,19581,2)
 ;;=^5020710
 ;;^UTILITY(U,$J,358.3,19582,0)
 ;;=S06.1X9S^^93^994^110
 ;;^UTILITY(U,$J,358.3,19582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19582,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19582,1,4,0)
 ;;=4^S06.1X9S
 ;;^UTILITY(U,$J,358.3,19582,2)
 ;;=^5020725
 ;;^UTILITY(U,$J,358.3,19583,0)
 ;;=S06.1X0S^^93^994^111
 ;;^UTILITY(U,$J,358.3,19583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19583,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19583,1,4,0)
 ;;=4^S06.1X0S
 ;;^UTILITY(U,$J,358.3,19583,2)
 ;;=^5020698
 ;;^UTILITY(U,$J,358.3,19584,0)
 ;;=S06.355S^^93^994^75
 ;;^UTILITY(U,$J,358.3,19584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19584,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19584,1,4,0)
 ;;=4^S06.355S
 ;;^UTILITY(U,$J,358.3,19584,2)
 ;;=^5020923
 ;;^UTILITY(U,$J,358.3,19585,0)
 ;;=S06.356S^^93^994^76
 ;;^UTILITY(U,$J,358.3,19585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19585,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,19585,1,4,0)
 ;;=4^S06.356S
 ;;^UTILITY(U,$J,358.3,19585,2)
 ;;=^5020926
 ;;^UTILITY(U,$J,358.3,19586,0)
 ;;=S06.353S^^93^994^77
 ;;^UTILITY(U,$J,358.3,19586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19586,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 1-5 hrs 59 minutes, sequela
 ;;^UTILITY(U,$J,358.3,19586,1,4,0)
 ;;=4^S06.353S
 ;;^UTILITY(U,$J,358.3,19586,2)
 ;;=^5020917
 ;;^UTILITY(U,$J,358.3,19587,0)
 ;;=S06.351S^^93^994^78
 ;;^UTILITY(U,$J,358.3,19587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19587,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19587,1,4,0)
 ;;=4^S06.351S
 ;;^UTILITY(U,$J,358.3,19587,2)
 ;;=^5020911
 ;;^UTILITY(U,$J,358.3,19588,0)
 ;;=S06.352S^^93^994^79
 ;;^UTILITY(U,$J,358.3,19588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19588,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19588,1,4,0)
 ;;=4^S06.352S
 ;;^UTILITY(U,$J,358.3,19588,2)
 ;;=^5020914
 ;;^UTILITY(U,$J,358.3,19589,0)
 ;;=S06.354S^^93^994^80
 ;;^UTILITY(U,$J,358.3,19589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19589,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,19589,1,4,0)
 ;;=4^S06.354S
 ;;^UTILITY(U,$J,358.3,19589,2)
 ;;=^5020920
 ;;^UTILITY(U,$J,358.3,19590,0)
 ;;=S06.359S^^93^994^81
 ;;^UTILITY(U,$J,358.3,19590,1,0)
 ;;=^358.31IA^4^2
