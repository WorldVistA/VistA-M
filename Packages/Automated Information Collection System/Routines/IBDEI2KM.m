IBDEI2KM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43119,1,3,0)
 ;;=3^Traum subrac hem w LOC of 6 hours to 24 hours, subs
 ;;^UTILITY(U,$J,358.3,43119,1,4,0)
 ;;=4^S06.6X4D
 ;;^UTILITY(U,$J,358.3,43119,2)
 ;;=^5021099
 ;;^UTILITY(U,$J,358.3,43120,0)
 ;;=S06.6X5D^^195^2167^55
 ;;^UTILITY(U,$J,358.3,43120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43120,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w ret consc lev, subs
 ;;^UTILITY(U,$J,358.3,43120,1,4,0)
 ;;=4^S06.6X5D
 ;;^UTILITY(U,$J,358.3,43120,2)
 ;;=^5021102
 ;;^UTILITY(U,$J,358.3,43121,0)
 ;;=S06.6X6D^^195^2167^57
 ;;^UTILITY(U,$J,358.3,43121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43121,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w/o ret consc w surv, subs
 ;;^UTILITY(U,$J,358.3,43121,1,4,0)
 ;;=4^S06.6X6D
 ;;^UTILITY(U,$J,358.3,43121,2)
 ;;=^5021105
 ;;^UTILITY(U,$J,358.3,43122,0)
 ;;=S06.6X7D^^195^2167^68
 ;;^UTILITY(U,$J,358.3,43122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43122,1,3,0)
 ;;=3^Traum subrac hem w LOC w death d/t brain inj bf consc, subs
 ;;^UTILITY(U,$J,358.3,43122,1,4,0)
 ;;=4^S06.6X7D
 ;;^UTILITY(U,$J,358.3,43122,2)
 ;;=^5021108
 ;;^UTILITY(U,$J,358.3,43123,0)
 ;;=S06.6X8D^^195^2167^70
 ;;^UTILITY(U,$J,358.3,43123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43123,1,3,0)
 ;;=3^Traum subrac hem w LOC w death d/t oth cause bf consc, subs
 ;;^UTILITY(U,$J,358.3,43123,1,4,0)
 ;;=4^S06.6X8D
 ;;^UTILITY(U,$J,358.3,43123,2)
 ;;=^5021111
 ;;^UTILITY(U,$J,358.3,43124,0)
 ;;=S06.6X8D^^195^2167^71
 ;;^UTILITY(U,$J,358.3,43124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43124,1,3,0)
 ;;=3^Traum subrac hem w LOC w death d/t oth cause bf consc, subs
 ;;^UTILITY(U,$J,358.3,43124,1,4,0)
 ;;=4^S06.6X8D
 ;;^UTILITY(U,$J,358.3,43124,2)
 ;;=^5021111
 ;;^UTILITY(U,$J,358.3,43125,0)
 ;;=S06.6X9D^^195^2167^66
 ;;^UTILITY(U,$J,358.3,43125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43125,1,3,0)
 ;;=3^Traum subrac hem w LOC of unsp duration, subs
 ;;^UTILITY(U,$J,358.3,43125,1,4,0)
 ;;=4^S06.6X9D
 ;;^UTILITY(U,$J,358.3,43125,2)
 ;;=^5021114
 ;;^UTILITY(U,$J,358.3,43126,0)
 ;;=S06.6X0S^^195^2167^74
 ;;^UTILITY(U,$J,358.3,43126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43126,1,3,0)
 ;;=3^Traum subrac hem w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,43126,1,4,0)
 ;;=4^S06.6X0S
 ;;^UTILITY(U,$J,358.3,43126,2)
 ;;=^5021088
 ;;^UTILITY(U,$J,358.3,43127,0)
 ;;=S06.6X1S^^195^2167^61
 ;;^UTILITY(U,$J,358.3,43127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43127,1,3,0)
 ;;=3^Traum subrac hem w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,43127,1,4,0)
 ;;=4^S06.6X1S
 ;;^UTILITY(U,$J,358.3,43127,2)
 ;;=^5021091
 ;;^UTILITY(U,$J,358.3,43128,0)
 ;;=S06.6X2S^^195^2167^62
 ;;^UTILITY(U,$J,358.3,43128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43128,1,3,0)
 ;;=3^Traum subrac hem w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,43128,1,4,0)
 ;;=4^S06.6X2S
 ;;^UTILITY(U,$J,358.3,43128,2)
 ;;=^5021094
 ;;^UTILITY(U,$J,358.3,43129,0)
 ;;=S06.6X3S^^195^2167^60
 ;;^UTILITY(U,$J,358.3,43129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43129,1,3,0)
 ;;=3^Traum subrac hem w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,43129,1,4,0)
 ;;=4^S06.6X3S
 ;;^UTILITY(U,$J,358.3,43129,2)
 ;;=^5021097
 ;;^UTILITY(U,$J,358.3,43130,0)
 ;;=S06.6X4S^^195^2167^65
 ;;^UTILITY(U,$J,358.3,43130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43130,1,3,0)
 ;;=3^Traum subrac hem w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,43130,1,4,0)
 ;;=4^S06.6X4S
 ;;^UTILITY(U,$J,358.3,43130,2)
 ;;=^5021100
 ;;^UTILITY(U,$J,358.3,43131,0)
 ;;=S06.6X5S^^195^2167^56
 ;;^UTILITY(U,$J,358.3,43131,1,0)
 ;;=^358.31IA^4^2
