IBDEI18A ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19930,1,3,0)
 ;;=3^Epidural hemorrhage without LOC, sequela
 ;;^UTILITY(U,$J,358.3,19930,1,4,0)
 ;;=4^S06.4X0S
 ;;^UTILITY(U,$J,358.3,19930,2)
 ;;=^5021028
 ;;^UTILITY(U,$J,358.3,19931,0)
 ;;=S06.825S^^67^882^56
 ;;^UTILITY(U,$J,358.3,19931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19931,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19931,1,4,0)
 ;;=4^S06.825S
 ;;^UTILITY(U,$J,358.3,19931,2)
 ;;=^5021163
 ;;^UTILITY(U,$J,358.3,19932,0)
 ;;=S06.826S^^67^882^57
 ;;^UTILITY(U,$J,358.3,19932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19932,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,19932,1,4,0)
 ;;=4^S06.826S
 ;;^UTILITY(U,$J,358.3,19932,2)
 ;;=^5021166
 ;;^UTILITY(U,$J,358.3,19933,0)
 ;;=S06.823S^^67^882^58
 ;;^UTILITY(U,$J,358.3,19933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19933,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19933,1,4,0)
 ;;=4^S06.823S
 ;;^UTILITY(U,$J,358.3,19933,2)
 ;;=^5021157
 ;;^UTILITY(U,$J,358.3,19934,0)
 ;;=S06.821S^^67^882^59
 ;;^UTILITY(U,$J,358.3,19934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19934,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19934,1,4,0)
 ;;=4^S06.821S
 ;;^UTILITY(U,$J,358.3,19934,2)
 ;;=^5021151
 ;;^UTILITY(U,$J,358.3,19935,0)
 ;;=S06.822S^^67^882^60
 ;;^UTILITY(U,$J,358.3,19935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19935,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19935,1,4,0)
 ;;=4^S06.822S
 ;;^UTILITY(U,$J,358.3,19935,2)
 ;;=^5021154
 ;;^UTILITY(U,$J,358.3,19936,0)
 ;;=S06.824S^^67^882^61
 ;;^UTILITY(U,$J,358.3,19936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19936,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,19936,1,4,0)
 ;;=4^S06.824S
 ;;^UTILITY(U,$J,358.3,19936,2)
 ;;=^5021160
 ;;^UTILITY(U,$J,358.3,19937,0)
 ;;=S06.829S^^67^882^62
 ;;^UTILITY(U,$J,358.3,19937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19937,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19937,1,4,0)
 ;;=4^S06.829S
 ;;^UTILITY(U,$J,358.3,19937,2)
 ;;=^5021175
 ;;^UTILITY(U,$J,358.3,19938,0)
 ;;=S06.820S^^67^882^63
 ;;^UTILITY(U,$J,358.3,19938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19938,1,3,0)
 ;;=3^Inj left int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19938,1,4,0)
 ;;=4^S06.820S
 ;;^UTILITY(U,$J,358.3,19938,2)
 ;;=^5021148
 ;;^UTILITY(U,$J,358.3,19939,0)
 ;;=S06.815S^^67^882^64
 ;;^UTILITY(U,$J,358.3,19939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19939,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19939,1,4,0)
 ;;=4^S06.815S
 ;;^UTILITY(U,$J,358.3,19939,2)
 ;;=^5021133
 ;;^UTILITY(U,$J,358.3,19940,0)
 ;;=S06.816S^^67^882^65
 ;;^UTILITY(U,$J,358.3,19940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19940,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,19940,1,4,0)
 ;;=4^S06.816S
 ;;^UTILITY(U,$J,358.3,19940,2)
 ;;=^5021136
 ;;^UTILITY(U,$J,358.3,19941,0)
 ;;=S06.813S^^67^882^66
 ;;^UTILITY(U,$J,358.3,19941,1,0)
 ;;=^358.31IA^4^2
