IBDEI2WT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48840,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,48840,1,4,0)
 ;;=4^S06.4X9S
 ;;^UTILITY(U,$J,358.3,48840,2)
 ;;=^5021055
 ;;^UTILITY(U,$J,358.3,48841,0)
 ;;=S06.4X0S^^216^2412^62
 ;;^UTILITY(U,$J,358.3,48841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48841,1,3,0)
 ;;=3^Epidural hemorrhage without LOC, sequela
 ;;^UTILITY(U,$J,358.3,48841,1,4,0)
 ;;=4^S06.4X0S
 ;;^UTILITY(U,$J,358.3,48841,2)
 ;;=^5021028
 ;;^UTILITY(U,$J,358.3,48842,0)
 ;;=S06.825S^^216^2412^63
 ;;^UTILITY(U,$J,358.3,48842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48842,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,48842,1,4,0)
 ;;=4^S06.825S
 ;;^UTILITY(U,$J,358.3,48842,2)
 ;;=^5021163
 ;;^UTILITY(U,$J,358.3,48843,0)
 ;;=S06.826S^^216^2412^64
 ;;^UTILITY(U,$J,358.3,48843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48843,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,48843,1,4,0)
 ;;=4^S06.826S
 ;;^UTILITY(U,$J,358.3,48843,2)
 ;;=^5021166
 ;;^UTILITY(U,$J,358.3,48844,0)
 ;;=S06.823S^^216^2412^65
 ;;^UTILITY(U,$J,358.3,48844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48844,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,48844,1,4,0)
 ;;=4^S06.823S
 ;;^UTILITY(U,$J,358.3,48844,2)
 ;;=^5021157
 ;;^UTILITY(U,$J,358.3,48845,0)
 ;;=S06.821S^^216^2412^66
 ;;^UTILITY(U,$J,358.3,48845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48845,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,48845,1,4,0)
 ;;=4^S06.821S
 ;;^UTILITY(U,$J,358.3,48845,2)
 ;;=^5021151
 ;;^UTILITY(U,$J,358.3,48846,0)
 ;;=S06.822S^^216^2412^67
 ;;^UTILITY(U,$J,358.3,48846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48846,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,48846,1,4,0)
 ;;=4^S06.822S
 ;;^UTILITY(U,$J,358.3,48846,2)
 ;;=^5021154
 ;;^UTILITY(U,$J,358.3,48847,0)
 ;;=S06.824S^^216^2412^68
 ;;^UTILITY(U,$J,358.3,48847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48847,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,48847,1,4,0)
 ;;=4^S06.824S
 ;;^UTILITY(U,$J,358.3,48847,2)
 ;;=^5021160
 ;;^UTILITY(U,$J,358.3,48848,0)
 ;;=S06.829S^^216^2412^69
 ;;^UTILITY(U,$J,358.3,48848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48848,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,48848,1,4,0)
 ;;=4^S06.829S
 ;;^UTILITY(U,$J,358.3,48848,2)
 ;;=^5021175
 ;;^UTILITY(U,$J,358.3,48849,0)
 ;;=S06.820S^^216^2412^70
 ;;^UTILITY(U,$J,358.3,48849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48849,1,3,0)
 ;;=3^Inj left int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,48849,1,4,0)
 ;;=4^S06.820S
 ;;^UTILITY(U,$J,358.3,48849,2)
 ;;=^5021148
 ;;^UTILITY(U,$J,358.3,48850,0)
 ;;=S06.815S^^216^2412^71
 ;;^UTILITY(U,$J,358.3,48850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48850,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,48850,1,4,0)
 ;;=4^S06.815S
 ;;^UTILITY(U,$J,358.3,48850,2)
 ;;=^5021133
 ;;^UTILITY(U,$J,358.3,48851,0)
 ;;=S06.816S^^216^2412^72
 ;;^UTILITY(U,$J,358.3,48851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48851,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,48851,1,4,0)
 ;;=4^S06.816S
