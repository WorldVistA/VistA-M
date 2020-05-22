IBDEI17X ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19556,2)
 ;;=^5021034
 ;;^UTILITY(U,$J,358.3,19557,0)
 ;;=S06.4X4S^^93^994^53
 ;;^UTILITY(U,$J,358.3,19557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19557,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,19557,1,4,0)
 ;;=4^S06.4X4S
 ;;^UTILITY(U,$J,358.3,19557,2)
 ;;=^5021040
 ;;^UTILITY(U,$J,358.3,19558,0)
 ;;=S06.4X9S^^93^994^54
 ;;^UTILITY(U,$J,358.3,19558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19558,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19558,1,4,0)
 ;;=4^S06.4X9S
 ;;^UTILITY(U,$J,358.3,19558,2)
 ;;=^5021055
 ;;^UTILITY(U,$J,358.3,19559,0)
 ;;=S06.4X0S^^93^994^55
 ;;^UTILITY(U,$J,358.3,19559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19559,1,3,0)
 ;;=3^Epidural hemorrhage without LOC, sequela
 ;;^UTILITY(U,$J,358.3,19559,1,4,0)
 ;;=4^S06.4X0S
 ;;^UTILITY(U,$J,358.3,19559,2)
 ;;=^5021028
 ;;^UTILITY(U,$J,358.3,19560,0)
 ;;=S06.825S^^93^994^56
 ;;^UTILITY(U,$J,358.3,19560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19560,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19560,1,4,0)
 ;;=4^S06.825S
 ;;^UTILITY(U,$J,358.3,19560,2)
 ;;=^5021163
 ;;^UTILITY(U,$J,358.3,19561,0)
 ;;=S06.826S^^93^994^57
 ;;^UTILITY(U,$J,358.3,19561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19561,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,19561,1,4,0)
 ;;=4^S06.826S
 ;;^UTILITY(U,$J,358.3,19561,2)
 ;;=^5021166
 ;;^UTILITY(U,$J,358.3,19562,0)
 ;;=S06.823S^^93^994^58
 ;;^UTILITY(U,$J,358.3,19562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19562,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19562,1,4,0)
 ;;=4^S06.823S
 ;;^UTILITY(U,$J,358.3,19562,2)
 ;;=^5021157
 ;;^UTILITY(U,$J,358.3,19563,0)
 ;;=S06.821S^^93^994^59
 ;;^UTILITY(U,$J,358.3,19563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19563,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19563,1,4,0)
 ;;=4^S06.821S
 ;;^UTILITY(U,$J,358.3,19563,2)
 ;;=^5021151
 ;;^UTILITY(U,$J,358.3,19564,0)
 ;;=S06.822S^^93^994^60
 ;;^UTILITY(U,$J,358.3,19564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19564,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19564,1,4,0)
 ;;=4^S06.822S
 ;;^UTILITY(U,$J,358.3,19564,2)
 ;;=^5021154
 ;;^UTILITY(U,$J,358.3,19565,0)
 ;;=S06.824S^^93^994^61
 ;;^UTILITY(U,$J,358.3,19565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19565,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,19565,1,4,0)
 ;;=4^S06.824S
 ;;^UTILITY(U,$J,358.3,19565,2)
 ;;=^5021160
 ;;^UTILITY(U,$J,358.3,19566,0)
 ;;=S06.829S^^93^994^62
 ;;^UTILITY(U,$J,358.3,19566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19566,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19566,1,4,0)
 ;;=4^S06.829S
 ;;^UTILITY(U,$J,358.3,19566,2)
 ;;=^5021175
 ;;^UTILITY(U,$J,358.3,19567,0)
 ;;=S06.820S^^93^994^63
 ;;^UTILITY(U,$J,358.3,19567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19567,1,3,0)
 ;;=3^Inj left int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19567,1,4,0)
 ;;=4^S06.820S
 ;;^UTILITY(U,$J,358.3,19567,2)
 ;;=^5021148
