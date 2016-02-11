IBDEI2AM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38521,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,38522,0)
 ;;=S06.1X0A^^180^1975^29
 ;;^UTILITY(U,$J,358.3,38522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38522,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,38522,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,38522,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,38523,0)
 ;;=S06.9X5A^^180^1975^9
 ;;^UTILITY(U,$J,358.3,38523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38523,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w ret consc lev, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,38523,1,4,0)
 ;;=4^S06.9X5A
 ;;^UTILITY(U,$J,358.3,38523,2)
 ;;=^5021221
 ;;^UTILITY(U,$J,358.3,38524,0)
 ;;=S06.9X6A^^180^1975^10
 ;;^UTILITY(U,$J,358.3,38524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38524,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w/o ret consc w surv, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,38524,1,4,0)
 ;;=4^S06.9X6A
 ;;^UTILITY(U,$J,358.3,38524,2)
 ;;=^5021224
 ;;^UTILITY(U,$J,358.3,38525,0)
 ;;=S06.9X3A^^180^1975^11
 ;;^UTILITY(U,$J,358.3,38525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38525,1,3,0)
 ;;=3^Intcrn inj w LOC of 1-5 hrs 59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,38525,1,4,0)
 ;;=4^S06.9X3A
 ;;^UTILITY(U,$J,358.3,38525,2)
 ;;=^5021215
 ;;^UTILITY(U,$J,358.3,38526,0)
 ;;=S06.9X1A^^180^1975^12
 ;;^UTILITY(U,$J,358.3,38526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38526,1,3,0)
 ;;=3^Intcrn inj w LOC of 30 minutes or less, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,38526,1,4,0)
 ;;=4^S06.9X1A
 ;;^UTILITY(U,$J,358.3,38526,2)
 ;;=^5021209
 ;;^UTILITY(U,$J,358.3,38527,0)
 ;;=S06.9X2A^^180^1975^13
 ;;^UTILITY(U,$J,358.3,38527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38527,1,3,0)
 ;;=3^Intcrn inj w LOC of 31-59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,38527,1,4,0)
 ;;=4^S06.9X2A
 ;;^UTILITY(U,$J,358.3,38527,2)
 ;;=^5021212
 ;;^UTILITY(U,$J,358.3,38528,0)
 ;;=S06.9X4A^^180^1975^14
 ;;^UTILITY(U,$J,358.3,38528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38528,1,3,0)
 ;;=3^Intcrn inj w LOC of 6 hours to 24 hours, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,38528,1,4,0)
 ;;=4^S06.9X4A
 ;;^UTILITY(U,$J,358.3,38528,2)
 ;;=^5021218
 ;;^UTILITY(U,$J,358.3,38529,0)
 ;;=S06.9X9A^^180^1975^15
 ;;^UTILITY(U,$J,358.3,38529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38529,1,3,0)
 ;;=3^Intcrn inj w LOC of unsp duration, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,38529,1,4,0)
 ;;=4^S06.9X9A
 ;;^UTILITY(U,$J,358.3,38529,2)
 ;;=^5021233
 ;;^UTILITY(U,$J,358.3,38530,0)
 ;;=S06.9X0A^^180^1975^17
 ;;^UTILITY(U,$J,358.3,38530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38530,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,38530,1,4,0)
 ;;=4^S06.9X0A
 ;;^UTILITY(U,$J,358.3,38530,2)
 ;;=^5021206
 ;;^UTILITY(U,$J,358.3,38531,0)
 ;;=S78.019S^^180^1976^4
 ;;^UTILITY(U,$J,358.3,38531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38531,1,3,0)
 ;;=3^Complete traumatic amputation at unsp hip joint, sequela
 ;;^UTILITY(U,$J,358.3,38531,1,4,0)
 ;;=4^S78.019S
 ;;^UTILITY(U,$J,358.3,38531,2)
 ;;=^5039710
 ;;^UTILITY(U,$J,358.3,38532,0)
 ;;=S68.419S^^180^1976^1
 ;;^UTILITY(U,$J,358.3,38532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38532,1,3,0)
 ;;=3^Complete traumatic amp of unsp hand at wrist level, sequela
 ;;^UTILITY(U,$J,358.3,38532,1,4,0)
 ;;=4^S68.419S
 ;;^UTILITY(U,$J,358.3,38532,2)
 ;;=^5036707
 ;;^UTILITY(U,$J,358.3,38533,0)
 ;;=S88.919S^^180^1976^2
 ;;^UTILITY(U,$J,358.3,38533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38533,1,3,0)
 ;;=3^Complete traumatic amp of unsp low leg, level unsp, sequela
