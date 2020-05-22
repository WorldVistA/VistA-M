IBDEI2MS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42003,0)
 ;;=S06.825S^^155^2066^56
 ;;^UTILITY(U,$J,358.3,42003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42003,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,42003,1,4,0)
 ;;=4^S06.825S
 ;;^UTILITY(U,$J,358.3,42003,2)
 ;;=^5021163
 ;;^UTILITY(U,$J,358.3,42004,0)
 ;;=S06.826S^^155^2066^57
 ;;^UTILITY(U,$J,358.3,42004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42004,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,42004,1,4,0)
 ;;=4^S06.826S
 ;;^UTILITY(U,$J,358.3,42004,2)
 ;;=^5021166
 ;;^UTILITY(U,$J,358.3,42005,0)
 ;;=S06.823S^^155^2066^58
 ;;^UTILITY(U,$J,358.3,42005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42005,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,42005,1,4,0)
 ;;=4^S06.823S
 ;;^UTILITY(U,$J,358.3,42005,2)
 ;;=^5021157
 ;;^UTILITY(U,$J,358.3,42006,0)
 ;;=S06.821S^^155^2066^59
 ;;^UTILITY(U,$J,358.3,42006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42006,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,42006,1,4,0)
 ;;=4^S06.821S
 ;;^UTILITY(U,$J,358.3,42006,2)
 ;;=^5021151
 ;;^UTILITY(U,$J,358.3,42007,0)
 ;;=S06.822S^^155^2066^60
 ;;^UTILITY(U,$J,358.3,42007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42007,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,42007,1,4,0)
 ;;=4^S06.822S
 ;;^UTILITY(U,$J,358.3,42007,2)
 ;;=^5021154
 ;;^UTILITY(U,$J,358.3,42008,0)
 ;;=S06.824S^^155^2066^61
 ;;^UTILITY(U,$J,358.3,42008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42008,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,42008,1,4,0)
 ;;=4^S06.824S
 ;;^UTILITY(U,$J,358.3,42008,2)
 ;;=^5021160
 ;;^UTILITY(U,$J,358.3,42009,0)
 ;;=S06.829S^^155^2066^62
 ;;^UTILITY(U,$J,358.3,42009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42009,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,42009,1,4,0)
 ;;=4^S06.829S
 ;;^UTILITY(U,$J,358.3,42009,2)
 ;;=^5021175
 ;;^UTILITY(U,$J,358.3,42010,0)
 ;;=S06.820S^^155^2066^63
 ;;^UTILITY(U,$J,358.3,42010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42010,1,3,0)
 ;;=3^Inj left int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,42010,1,4,0)
 ;;=4^S06.820S
 ;;^UTILITY(U,$J,358.3,42010,2)
 ;;=^5021148
 ;;^UTILITY(U,$J,358.3,42011,0)
 ;;=S06.815S^^155^2066^64
 ;;^UTILITY(U,$J,358.3,42011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42011,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,42011,1,4,0)
 ;;=4^S06.815S
 ;;^UTILITY(U,$J,358.3,42011,2)
 ;;=^5021133
 ;;^UTILITY(U,$J,358.3,42012,0)
 ;;=S06.816S^^155^2066^65
 ;;^UTILITY(U,$J,358.3,42012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42012,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,42012,1,4,0)
 ;;=4^S06.816S
 ;;^UTILITY(U,$J,358.3,42012,2)
 ;;=^5021136
 ;;^UTILITY(U,$J,358.3,42013,0)
 ;;=S06.813S^^155^2066^66
 ;;^UTILITY(U,$J,358.3,42013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42013,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,42013,1,4,0)
 ;;=4^S06.813S
 ;;^UTILITY(U,$J,358.3,42013,2)
 ;;=^5021127
