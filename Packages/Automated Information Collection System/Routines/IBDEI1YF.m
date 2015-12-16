IBDEI1YF ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34292,2)
 ;;=^5021037
 ;;^UTILITY(U,$J,358.3,34293,0)
 ;;=S06.4X1S^^183^2018^58
 ;;^UTILITY(U,$J,358.3,34293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34293,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,34293,1,4,0)
 ;;=4^S06.4X1S
 ;;^UTILITY(U,$J,358.3,34293,2)
 ;;=^5021031
 ;;^UTILITY(U,$J,358.3,34294,0)
 ;;=S06.4X2S^^183^2018^59
 ;;^UTILITY(U,$J,358.3,34294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34294,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,34294,1,4,0)
 ;;=4^S06.4X2S
 ;;^UTILITY(U,$J,358.3,34294,2)
 ;;=^5021034
 ;;^UTILITY(U,$J,358.3,34295,0)
 ;;=S06.4X4S^^183^2018^60
 ;;^UTILITY(U,$J,358.3,34295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34295,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,34295,1,4,0)
 ;;=4^S06.4X4S
 ;;^UTILITY(U,$J,358.3,34295,2)
 ;;=^5021040
 ;;^UTILITY(U,$J,358.3,34296,0)
 ;;=S06.4X9S^^183^2018^61
 ;;^UTILITY(U,$J,358.3,34296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34296,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,34296,1,4,0)
 ;;=4^S06.4X9S
 ;;^UTILITY(U,$J,358.3,34296,2)
 ;;=^5021055
 ;;^UTILITY(U,$J,358.3,34297,0)
 ;;=S06.4X0S^^183^2018^62
 ;;^UTILITY(U,$J,358.3,34297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34297,1,3,0)
 ;;=3^Epidural hemorrhage without LOC, sequela
 ;;^UTILITY(U,$J,358.3,34297,1,4,0)
 ;;=4^S06.4X0S
 ;;^UTILITY(U,$J,358.3,34297,2)
 ;;=^5021028
 ;;^UTILITY(U,$J,358.3,34298,0)
 ;;=S06.825S^^183^2018^63
 ;;^UTILITY(U,$J,358.3,34298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34298,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,34298,1,4,0)
 ;;=4^S06.825S
 ;;^UTILITY(U,$J,358.3,34298,2)
 ;;=^5021163
 ;;^UTILITY(U,$J,358.3,34299,0)
 ;;=S06.826S^^183^2018^64
 ;;^UTILITY(U,$J,358.3,34299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34299,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,34299,1,4,0)
 ;;=4^S06.826S
 ;;^UTILITY(U,$J,358.3,34299,2)
 ;;=^5021166
 ;;^UTILITY(U,$J,358.3,34300,0)
 ;;=S06.823S^^183^2018^65
 ;;^UTILITY(U,$J,358.3,34300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34300,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,34300,1,4,0)
 ;;=4^S06.823S
 ;;^UTILITY(U,$J,358.3,34300,2)
 ;;=^5021157
 ;;^UTILITY(U,$J,358.3,34301,0)
 ;;=S06.821S^^183^2018^66
 ;;^UTILITY(U,$J,358.3,34301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34301,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,34301,1,4,0)
 ;;=4^S06.821S
 ;;^UTILITY(U,$J,358.3,34301,2)
 ;;=^5021151
 ;;^UTILITY(U,$J,358.3,34302,0)
 ;;=S06.822S^^183^2018^67
 ;;^UTILITY(U,$J,358.3,34302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34302,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,34302,1,4,0)
 ;;=4^S06.822S
 ;;^UTILITY(U,$J,358.3,34302,2)
 ;;=^5021154
 ;;^UTILITY(U,$J,358.3,34303,0)
 ;;=S06.824S^^183^2018^68
 ;;^UTILITY(U,$J,358.3,34303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34303,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,34303,1,4,0)
 ;;=4^S06.824S
 ;;^UTILITY(U,$J,358.3,34303,2)
 ;;=^5021160
 ;;^UTILITY(U,$J,358.3,34304,0)
 ;;=S06.829S^^183^2018^69
 ;;^UTILITY(U,$J,358.3,34304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34304,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of unsp duration, sequela
