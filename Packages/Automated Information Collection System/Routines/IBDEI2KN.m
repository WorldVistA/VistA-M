IBDEI2KN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43131,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,43131,1,4,0)
 ;;=4^S06.6X5S
 ;;^UTILITY(U,$J,358.3,43131,2)
 ;;=^5021103
 ;;^UTILITY(U,$J,358.3,43132,0)
 ;;=S06.6X6S^^195^2167^58
 ;;^UTILITY(U,$J,358.3,43132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43132,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,43132,1,4,0)
 ;;=4^S06.6X6S
 ;;^UTILITY(U,$J,358.3,43132,2)
 ;;=^5021106
 ;;^UTILITY(U,$J,358.3,43133,0)
 ;;=S06.6X7S^^195^2167^69
 ;;^UTILITY(U,$J,358.3,43133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43133,1,3,0)
 ;;=3^Traum subrac hem w LOC w death d/t brain inj bf consc, sqla
 ;;^UTILITY(U,$J,358.3,43133,1,4,0)
 ;;=4^S06.6X7S
 ;;^UTILITY(U,$J,358.3,43133,2)
 ;;=^5021109
 ;;^UTILITY(U,$J,358.3,43134,0)
 ;;=S06.6X8S^^195^2167^72
 ;;^UTILITY(U,$J,358.3,43134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43134,1,3,0)
 ;;=3^Traum subrac hem w LOC w death d/t oth cause bf consc, sqla
 ;;^UTILITY(U,$J,358.3,43134,1,4,0)
 ;;=4^S06.6X8S
 ;;^UTILITY(U,$J,358.3,43134,2)
 ;;=^5021112
 ;;^UTILITY(U,$J,358.3,43135,0)
 ;;=S06.6X9S^^195^2167^67
 ;;^UTILITY(U,$J,358.3,43135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43135,1,3,0)
 ;;=3^Traum subrac hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,43135,1,4,0)
 ;;=4^S06.6X9S
 ;;^UTILITY(U,$J,358.3,43135,2)
 ;;=^5021115
 ;;^UTILITY(U,$J,358.3,43136,0)
 ;;=S06.890A^^195^2167^41
 ;;^UTILITY(U,$J,358.3,43136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43136,1,3,0)
 ;;=3^Intcran inj w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,43136,1,4,0)
 ;;=4^S06.890A
 ;;^UTILITY(U,$J,358.3,43136,2)
 ;;=^5021176
 ;;^UTILITY(U,$J,358.3,43137,0)
 ;;=S06.891A^^195^2167^35
 ;;^UTILITY(U,$J,358.3,43137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43137,1,3,0)
 ;;=3^Intcran inj w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,43137,1,4,0)
 ;;=4^S06.891A
 ;;^UTILITY(U,$J,358.3,43137,2)
 ;;=^5021179
 ;;^UTILITY(U,$J,358.3,43138,0)
 ;;=S06.892A^^195^2167^36
 ;;^UTILITY(U,$J,358.3,43138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43138,1,3,0)
 ;;=3^Intcran inj w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,43138,1,4,0)
 ;;=4^S06.892A
 ;;^UTILITY(U,$J,358.3,43138,2)
 ;;=^5021182
 ;;^UTILITY(U,$J,358.3,43139,0)
 ;;=S06.894A^^195^2167^37
 ;;^UTILITY(U,$J,358.3,43139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43139,1,3,0)
 ;;=3^Intcran inj w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,43139,1,4,0)
 ;;=4^S06.894A
 ;;^UTILITY(U,$J,358.3,43139,2)
 ;;=^5021188
 ;;^UTILITY(U,$J,358.3,43140,0)
 ;;=S06.895A^^195^2167^33
 ;;^UTILITY(U,$J,358.3,43140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43140,1,3,0)
 ;;=3^Intcran inj w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,43140,1,4,0)
 ;;=4^S06.895A
 ;;^UTILITY(U,$J,358.3,43140,2)
 ;;=^5021191
 ;;^UTILITY(U,$J,358.3,43141,0)
 ;;=S06.896A^^195^2167^34
 ;;^UTILITY(U,$J,358.3,43141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43141,1,3,0)
 ;;=3^Intcran inj w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,43141,1,4,0)
 ;;=4^S06.896A
 ;;^UTILITY(U,$J,358.3,43141,2)
 ;;=^5021194
 ;;^UTILITY(U,$J,358.3,43142,0)
 ;;=S06.897A^^195^2167^40
 ;;^UTILITY(U,$J,358.3,43142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43142,1,3,0)
 ;;=3^Intcran inj w LOC w death due to brain injury bf consc, init
 ;;^UTILITY(U,$J,358.3,43142,1,4,0)
 ;;=4^S06.897A
 ;;^UTILITY(U,$J,358.3,43142,2)
 ;;=^5021197
 ;;^UTILITY(U,$J,358.3,43143,0)
 ;;=S06.898A^^195^2167^39
 ;;^UTILITY(U,$J,358.3,43143,1,0)
 ;;=^358.31IA^4^2
