IBDEI1T0 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31804,1,4,0)
 ;;=4^S06.5X8S
 ;;^UTILITY(U,$J,358.3,31804,2)
 ;;=^5021082
 ;;^UTILITY(U,$J,358.3,31805,0)
 ;;=S06.5X9S^^181^1968^49
 ;;^UTILITY(U,$J,358.3,31805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31805,1,3,0)
 ;;=3^Traum subdr hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,31805,1,4,0)
 ;;=4^S06.5X9S
 ;;^UTILITY(U,$J,358.3,31805,2)
 ;;=^5021085
 ;;^UTILITY(U,$J,358.3,31806,0)
 ;;=S06.6X0A^^181^1968^73
 ;;^UTILITY(U,$J,358.3,31806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31806,1,3,0)
 ;;=3^Traum subrac hem w/o LOC, init
 ;;^UTILITY(U,$J,358.3,31806,1,4,0)
 ;;=4^S06.6X0A
 ;;^UTILITY(U,$J,358.3,31806,2)
 ;;=^5021086
 ;;^UTILITY(U,$J,358.3,31807,0)
 ;;=S06.6X2D^^181^1968^63
 ;;^UTILITY(U,$J,358.3,31807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31807,1,3,0)
 ;;=3^Traum subrac hem w LOC of 31-59 min, subs
 ;;^UTILITY(U,$J,358.3,31807,1,4,0)
 ;;=4^S06.6X2D
 ;;^UTILITY(U,$J,358.3,31807,2)
 ;;=^5021093
 ;;^UTILITY(U,$J,358.3,31808,0)
 ;;=S06.6X3D^^181^1968^59
 ;;^UTILITY(U,$J,358.3,31808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31808,1,3,0)
 ;;=3^Traum subrac hem w LOC of 1-5 hrs 59 min, subs
 ;;^UTILITY(U,$J,358.3,31808,1,4,0)
 ;;=4^S06.6X3D
 ;;^UTILITY(U,$J,358.3,31808,2)
 ;;=^5021096
 ;;^UTILITY(U,$J,358.3,31809,0)
 ;;=S06.6X4D^^181^1968^64
 ;;^UTILITY(U,$J,358.3,31809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31809,1,3,0)
 ;;=3^Traum subrac hem w LOC of 6 hours to 24 hours, subs
 ;;^UTILITY(U,$J,358.3,31809,1,4,0)
 ;;=4^S06.6X4D
 ;;^UTILITY(U,$J,358.3,31809,2)
 ;;=^5021099
 ;;^UTILITY(U,$J,358.3,31810,0)
 ;;=S06.6X5D^^181^1968^55
 ;;^UTILITY(U,$J,358.3,31810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31810,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w ret consc lev, subs
 ;;^UTILITY(U,$J,358.3,31810,1,4,0)
 ;;=4^S06.6X5D
 ;;^UTILITY(U,$J,358.3,31810,2)
 ;;=^5021102
 ;;^UTILITY(U,$J,358.3,31811,0)
 ;;=S06.6X6D^^181^1968^57
 ;;^UTILITY(U,$J,358.3,31811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31811,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w/o ret consc w surv, subs
 ;;^UTILITY(U,$J,358.3,31811,1,4,0)
 ;;=4^S06.6X6D
 ;;^UTILITY(U,$J,358.3,31811,2)
 ;;=^5021105
 ;;^UTILITY(U,$J,358.3,31812,0)
 ;;=S06.6X7D^^181^1968^68
 ;;^UTILITY(U,$J,358.3,31812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31812,1,3,0)
 ;;=3^Traum subrac hem w LOC w death d/t brain inj bf consc, subs
 ;;^UTILITY(U,$J,358.3,31812,1,4,0)
 ;;=4^S06.6X7D
 ;;^UTILITY(U,$J,358.3,31812,2)
 ;;=^5021108
 ;;^UTILITY(U,$J,358.3,31813,0)
 ;;=S06.6X8D^^181^1968^70
 ;;^UTILITY(U,$J,358.3,31813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31813,1,3,0)
 ;;=3^Traum subrac hem w LOC w death d/t oth cause bf consc, subs
 ;;^UTILITY(U,$J,358.3,31813,1,4,0)
 ;;=4^S06.6X8D
 ;;^UTILITY(U,$J,358.3,31813,2)
 ;;=^5021111
 ;;^UTILITY(U,$J,358.3,31814,0)
 ;;=S06.6X8D^^181^1968^71
 ;;^UTILITY(U,$J,358.3,31814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31814,1,3,0)
 ;;=3^Traum subrac hem w LOC w death d/t oth cause bf consc, subs
 ;;^UTILITY(U,$J,358.3,31814,1,4,0)
 ;;=4^S06.6X8D
 ;;^UTILITY(U,$J,358.3,31814,2)
 ;;=^5021111
 ;;^UTILITY(U,$J,358.3,31815,0)
 ;;=S06.6X9D^^181^1968^66
 ;;^UTILITY(U,$J,358.3,31815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31815,1,3,0)
 ;;=3^Traum subrac hem w LOC of unsp duration, subs
 ;;^UTILITY(U,$J,358.3,31815,1,4,0)
 ;;=4^S06.6X9D
 ;;^UTILITY(U,$J,358.3,31815,2)
 ;;=^5021114
 ;;^UTILITY(U,$J,358.3,31816,0)
 ;;=S06.6X0S^^181^1968^74
 ;;^UTILITY(U,$J,358.3,31816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31816,1,3,0)
 ;;=3^Traum subrac hem w/o LOC, sequela
