IBDEI2EL ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38358,0)
 ;;=S06.5X0A^^149^1948^40
 ;;^UTILITY(U,$J,358.3,38358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38358,1,3,0)
 ;;=3^Traum subdr hem w/o LOC, init
 ;;^UTILITY(U,$J,358.3,38358,1,4,0)
 ;;=4^S06.5X0A
 ;;^UTILITY(U,$J,358.3,38358,2)
 ;;=^5021056
 ;;^UTILITY(U,$J,358.3,38359,0)
 ;;=S06.5X1A^^149^1948^34
 ;;^UTILITY(U,$J,358.3,38359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38359,1,3,0)
 ;;=3^Traum subdr hem w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,38359,1,4,0)
 ;;=4^S06.5X1A
 ;;^UTILITY(U,$J,358.3,38359,2)
 ;;=^5021059
 ;;^UTILITY(U,$J,358.3,38360,0)
 ;;=S06.5X2A^^149^1948^35
 ;;^UTILITY(U,$J,358.3,38360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38360,1,3,0)
 ;;=3^Traum subdr hem w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,38360,1,4,0)
 ;;=4^S06.5X2A
 ;;^UTILITY(U,$J,358.3,38360,2)
 ;;=^5021062
 ;;^UTILITY(U,$J,358.3,38361,0)
 ;;=S06.5X3A^^149^1948^33
 ;;^UTILITY(U,$J,358.3,38361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38361,1,3,0)
 ;;=3^Traum subdr hem w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,38361,1,4,0)
 ;;=4^S06.5X3A
 ;;^UTILITY(U,$J,358.3,38361,2)
 ;;=^5021065
 ;;^UTILITY(U,$J,358.3,38362,0)
 ;;=S06.5X4A^^149^1948^36
 ;;^UTILITY(U,$J,358.3,38362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38362,1,3,0)
 ;;=3^Traum subdr hem w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,38362,1,4,0)
 ;;=4^S06.5X4A
 ;;^UTILITY(U,$J,358.3,38362,2)
 ;;=^5021068
 ;;^UTILITY(U,$J,358.3,38363,0)
 ;;=S06.5X5A^^149^1948^31
 ;;^UTILITY(U,$J,358.3,38363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38363,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,38363,1,4,0)
 ;;=4^S06.5X5A
 ;;^UTILITY(U,$J,358.3,38363,2)
 ;;=^5021071
 ;;^UTILITY(U,$J,358.3,38364,0)
 ;;=S06.5X6A^^149^1948^32
 ;;^UTILITY(U,$J,358.3,38364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38364,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,38364,1,4,0)
 ;;=4^S06.5X6A
 ;;^UTILITY(U,$J,358.3,38364,2)
 ;;=^5021074
 ;;^UTILITY(U,$J,358.3,38365,0)
 ;;=S06.5X7A^^149^1948^38
 ;;^UTILITY(U,$J,358.3,38365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38365,1,3,0)
 ;;=3^Traum subdr hem w LOC w dth d/t brain inj bef reg consc,init
 ;;^UTILITY(U,$J,358.3,38365,1,4,0)
 ;;=4^S06.5X7A
 ;;^UTILITY(U,$J,358.3,38365,2)
 ;;=^5021077
 ;;^UTILITY(U,$J,358.3,38366,0)
 ;;=S06.5X8A^^149^1948^39
 ;;^UTILITY(U,$J,358.3,38366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38366,1,3,0)
 ;;=3^Traum subdr hem w LOC w dth d/t oth cause bef reg consc,init
 ;;^UTILITY(U,$J,358.3,38366,1,4,0)
 ;;=4^S06.5X8A
 ;;^UTILITY(U,$J,358.3,38366,2)
 ;;=^5021080
 ;;^UTILITY(U,$J,358.3,38367,0)
 ;;=S06.5X0S^^149^1948^41
 ;;^UTILITY(U,$J,358.3,38367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38367,1,3,0)
 ;;=3^Traum subdr hem w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,38367,1,4,0)
 ;;=4^S06.5X0S
 ;;^UTILITY(U,$J,358.3,38367,2)
 ;;=^5021058
 ;;^UTILITY(U,$J,358.3,38368,0)
 ;;=S06.5X9S^^149^1948^37
 ;;^UTILITY(U,$J,358.3,38368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38368,1,3,0)
 ;;=3^Traum subdr hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,38368,1,4,0)
 ;;=4^S06.5X9S
 ;;^UTILITY(U,$J,358.3,38368,2)
 ;;=^5021085
 ;;^UTILITY(U,$J,358.3,38369,0)
 ;;=S06.6X0A^^149^1948^55
 ;;^UTILITY(U,$J,358.3,38369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38369,1,3,0)
 ;;=3^Traum subrac hem w/o LOC, init
