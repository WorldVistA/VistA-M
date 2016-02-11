IBDEI1AG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21528,1,4,0)
 ;;=4^S06.2X4S
 ;;^UTILITY(U,$J,358.3,21528,2)
 ;;=^5020740
 ;;^UTILITY(U,$J,358.3,21529,0)
 ;;=S06.2X9S^^101^1032^53
 ;;^UTILITY(U,$J,358.3,21529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21529,1,3,0)
 ;;=3^Diffuse TBI w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,21529,1,4,0)
 ;;=4^S06.2X9S
 ;;^UTILITY(U,$J,358.3,21529,2)
 ;;=^5020755
 ;;^UTILITY(U,$J,358.3,21530,0)
 ;;=S06.2X0S^^101^1032^54
 ;;^UTILITY(U,$J,358.3,21530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21530,1,3,0)
 ;;=3^Diffuse TBI w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,21530,1,4,0)
 ;;=4^S06.2X0S
 ;;^UTILITY(U,$J,358.3,21530,2)
 ;;=^5020728
 ;;^UTILITY(U,$J,358.3,21531,0)
 ;;=S06.4X5S^^101^1032^55
 ;;^UTILITY(U,$J,358.3,21531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21531,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,21531,1,4,0)
 ;;=4^S06.4X5S
 ;;^UTILITY(U,$J,358.3,21531,2)
 ;;=^5021043
 ;;^UTILITY(U,$J,358.3,21532,0)
 ;;=S06.4X6S^^101^1032^56
 ;;^UTILITY(U,$J,358.3,21532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21532,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,21532,1,4,0)
 ;;=4^S06.4X6S
 ;;^UTILITY(U,$J,358.3,21532,2)
 ;;=^5021046
 ;;^UTILITY(U,$J,358.3,21533,0)
 ;;=S06.4X3S^^101^1032^57
 ;;^UTILITY(U,$J,358.3,21533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21533,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,21533,1,4,0)
 ;;=4^S06.4X3S
 ;;^UTILITY(U,$J,358.3,21533,2)
 ;;=^5021037
 ;;^UTILITY(U,$J,358.3,21534,0)
 ;;=S06.4X1S^^101^1032^58
 ;;^UTILITY(U,$J,358.3,21534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21534,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,21534,1,4,0)
 ;;=4^S06.4X1S
 ;;^UTILITY(U,$J,358.3,21534,2)
 ;;=^5021031
 ;;^UTILITY(U,$J,358.3,21535,0)
 ;;=S06.4X2S^^101^1032^59
 ;;^UTILITY(U,$J,358.3,21535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21535,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,21535,1,4,0)
 ;;=4^S06.4X2S
 ;;^UTILITY(U,$J,358.3,21535,2)
 ;;=^5021034
 ;;^UTILITY(U,$J,358.3,21536,0)
 ;;=S06.4X4S^^101^1032^60
 ;;^UTILITY(U,$J,358.3,21536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21536,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,21536,1,4,0)
 ;;=4^S06.4X4S
 ;;^UTILITY(U,$J,358.3,21536,2)
 ;;=^5021040
 ;;^UTILITY(U,$J,358.3,21537,0)
 ;;=S06.4X9S^^101^1032^61
 ;;^UTILITY(U,$J,358.3,21537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21537,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,21537,1,4,0)
 ;;=4^S06.4X9S
 ;;^UTILITY(U,$J,358.3,21537,2)
 ;;=^5021055
 ;;^UTILITY(U,$J,358.3,21538,0)
 ;;=S06.4X0S^^101^1032^62
 ;;^UTILITY(U,$J,358.3,21538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21538,1,3,0)
 ;;=3^Epidural hemorrhage without LOC, sequela
 ;;^UTILITY(U,$J,358.3,21538,1,4,0)
 ;;=4^S06.4X0S
 ;;^UTILITY(U,$J,358.3,21538,2)
 ;;=^5021028
 ;;^UTILITY(U,$J,358.3,21539,0)
 ;;=S06.825S^^101^1032^63
 ;;^UTILITY(U,$J,358.3,21539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21539,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,21539,1,4,0)
 ;;=4^S06.825S
 ;;^UTILITY(U,$J,358.3,21539,2)
 ;;=^5021163
 ;;^UTILITY(U,$J,358.3,21540,0)
 ;;=S06.826S^^101^1032^64
 ;;^UTILITY(U,$J,358.3,21540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21540,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
