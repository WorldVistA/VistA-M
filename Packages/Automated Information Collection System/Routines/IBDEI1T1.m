IBDEI1T1 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31816,1,4,0)
 ;;=4^S06.6X0S
 ;;^UTILITY(U,$J,358.3,31816,2)
 ;;=^5021088
 ;;^UTILITY(U,$J,358.3,31817,0)
 ;;=S06.6X1S^^181^1968^61
 ;;^UTILITY(U,$J,358.3,31817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31817,1,3,0)
 ;;=3^Traum subrac hem w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,31817,1,4,0)
 ;;=4^S06.6X1S
 ;;^UTILITY(U,$J,358.3,31817,2)
 ;;=^5021091
 ;;^UTILITY(U,$J,358.3,31818,0)
 ;;=S06.6X2S^^181^1968^62
 ;;^UTILITY(U,$J,358.3,31818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31818,1,3,0)
 ;;=3^Traum subrac hem w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,31818,1,4,0)
 ;;=4^S06.6X2S
 ;;^UTILITY(U,$J,358.3,31818,2)
 ;;=^5021094
 ;;^UTILITY(U,$J,358.3,31819,0)
 ;;=S06.6X3S^^181^1968^60
 ;;^UTILITY(U,$J,358.3,31819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31819,1,3,0)
 ;;=3^Traum subrac hem w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,31819,1,4,0)
 ;;=4^S06.6X3S
 ;;^UTILITY(U,$J,358.3,31819,2)
 ;;=^5021097
 ;;^UTILITY(U,$J,358.3,31820,0)
 ;;=S06.6X4S^^181^1968^65
 ;;^UTILITY(U,$J,358.3,31820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31820,1,3,0)
 ;;=3^Traum subrac hem w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,31820,1,4,0)
 ;;=4^S06.6X4S
 ;;^UTILITY(U,$J,358.3,31820,2)
 ;;=^5021100
 ;;^UTILITY(U,$J,358.3,31821,0)
 ;;=S06.6X5S^^181^1968^56
 ;;^UTILITY(U,$J,358.3,31821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31821,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,31821,1,4,0)
 ;;=4^S06.6X5S
 ;;^UTILITY(U,$J,358.3,31821,2)
 ;;=^5021103
 ;;^UTILITY(U,$J,358.3,31822,0)
 ;;=S06.6X6S^^181^1968^58
 ;;^UTILITY(U,$J,358.3,31822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31822,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,31822,1,4,0)
 ;;=4^S06.6X6S
 ;;^UTILITY(U,$J,358.3,31822,2)
 ;;=^5021106
 ;;^UTILITY(U,$J,358.3,31823,0)
 ;;=S06.6X7S^^181^1968^69
 ;;^UTILITY(U,$J,358.3,31823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31823,1,3,0)
 ;;=3^Traum subrac hem w LOC w death d/t brain inj bf consc, sqla
 ;;^UTILITY(U,$J,358.3,31823,1,4,0)
 ;;=4^S06.6X7S
 ;;^UTILITY(U,$J,358.3,31823,2)
 ;;=^5021109
 ;;^UTILITY(U,$J,358.3,31824,0)
 ;;=S06.6X8S^^181^1968^72
 ;;^UTILITY(U,$J,358.3,31824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31824,1,3,0)
 ;;=3^Traum subrac hem w LOC w death d/t oth cause bf consc, sqla
 ;;^UTILITY(U,$J,358.3,31824,1,4,0)
 ;;=4^S06.6X8S
 ;;^UTILITY(U,$J,358.3,31824,2)
 ;;=^5021112
 ;;^UTILITY(U,$J,358.3,31825,0)
 ;;=S06.6X9S^^181^1968^67
 ;;^UTILITY(U,$J,358.3,31825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31825,1,3,0)
 ;;=3^Traum subrac hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,31825,1,4,0)
 ;;=4^S06.6X9S
 ;;^UTILITY(U,$J,358.3,31825,2)
 ;;=^5021115
 ;;^UTILITY(U,$J,358.3,31826,0)
 ;;=S06.890A^^181^1968^41
 ;;^UTILITY(U,$J,358.3,31826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31826,1,3,0)
 ;;=3^Intcran inj w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,31826,1,4,0)
 ;;=4^S06.890A
 ;;^UTILITY(U,$J,358.3,31826,2)
 ;;=^5021176
 ;;^UTILITY(U,$J,358.3,31827,0)
 ;;=S06.891A^^181^1968^35
 ;;^UTILITY(U,$J,358.3,31827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31827,1,3,0)
 ;;=3^Intcran inj w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,31827,1,4,0)
 ;;=4^S06.891A
 ;;^UTILITY(U,$J,358.3,31827,2)
 ;;=^5021179
 ;;^UTILITY(U,$J,358.3,31828,0)
 ;;=S06.892A^^181^1968^36
 ;;^UTILITY(U,$J,358.3,31828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31828,1,3,0)
 ;;=3^Intcran inj w LOC of 31-59 min, init
