IBDEI2C4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39218,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,39218,1,4,0)
 ;;=4^S06.1X9A
 ;;^UTILITY(U,$J,358.3,39218,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,39219,0)
 ;;=S06.1X0A^^183^2013^29
 ;;^UTILITY(U,$J,358.3,39219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39219,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,39219,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,39219,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,39220,0)
 ;;=S06.9X5A^^183^2013^9
 ;;^UTILITY(U,$J,358.3,39220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39220,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w ret consc lev, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,39220,1,4,0)
 ;;=4^S06.9X5A
 ;;^UTILITY(U,$J,358.3,39220,2)
 ;;=^5021221
 ;;^UTILITY(U,$J,358.3,39221,0)
 ;;=S06.9X6A^^183^2013^10
 ;;^UTILITY(U,$J,358.3,39221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39221,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w/o ret consc w surv, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,39221,1,4,0)
 ;;=4^S06.9X6A
 ;;^UTILITY(U,$J,358.3,39221,2)
 ;;=^5021224
 ;;^UTILITY(U,$J,358.3,39222,0)
 ;;=S06.9X3A^^183^2013^11
 ;;^UTILITY(U,$J,358.3,39222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39222,1,3,0)
 ;;=3^Intcrn inj w LOC of 1-5 hrs 59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,39222,1,4,0)
 ;;=4^S06.9X3A
 ;;^UTILITY(U,$J,358.3,39222,2)
 ;;=^5021215
 ;;^UTILITY(U,$J,358.3,39223,0)
 ;;=S06.9X1A^^183^2013^12
 ;;^UTILITY(U,$J,358.3,39223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39223,1,3,0)
 ;;=3^Intcrn inj w LOC of 30 minutes or less, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,39223,1,4,0)
 ;;=4^S06.9X1A
 ;;^UTILITY(U,$J,358.3,39223,2)
 ;;=^5021209
 ;;^UTILITY(U,$J,358.3,39224,0)
 ;;=S06.9X2A^^183^2013^13
 ;;^UTILITY(U,$J,358.3,39224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39224,1,3,0)
 ;;=3^Intcrn inj w LOC of 31-59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,39224,1,4,0)
 ;;=4^S06.9X2A
 ;;^UTILITY(U,$J,358.3,39224,2)
 ;;=^5021212
 ;;^UTILITY(U,$J,358.3,39225,0)
 ;;=S06.9X4A^^183^2013^14
 ;;^UTILITY(U,$J,358.3,39225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39225,1,3,0)
 ;;=3^Intcrn inj w LOC of 6 hours to 24 hours, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,39225,1,4,0)
 ;;=4^S06.9X4A
 ;;^UTILITY(U,$J,358.3,39225,2)
 ;;=^5021218
 ;;^UTILITY(U,$J,358.3,39226,0)
 ;;=S06.9X9A^^183^2013^15
 ;;^UTILITY(U,$J,358.3,39226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39226,1,3,0)
 ;;=3^Intcrn inj w LOC of unsp duration, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,39226,1,4,0)
 ;;=4^S06.9X9A
 ;;^UTILITY(U,$J,358.3,39226,2)
 ;;=^5021233
 ;;^UTILITY(U,$J,358.3,39227,0)
 ;;=S06.9X0A^^183^2013^17
 ;;^UTILITY(U,$J,358.3,39227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39227,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,39227,1,4,0)
 ;;=4^S06.9X0A
 ;;^UTILITY(U,$J,358.3,39227,2)
 ;;=^5021206
 ;;^UTILITY(U,$J,358.3,39228,0)
 ;;=S78.019S^^183^2014^4
 ;;^UTILITY(U,$J,358.3,39228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39228,1,3,0)
 ;;=3^Complete traumatic amputation at unsp hip joint, sequela
 ;;^UTILITY(U,$J,358.3,39228,1,4,0)
 ;;=4^S78.019S
 ;;^UTILITY(U,$J,358.3,39228,2)
 ;;=^5039710
 ;;^UTILITY(U,$J,358.3,39229,0)
 ;;=S68.419S^^183^2014^1
 ;;^UTILITY(U,$J,358.3,39229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39229,1,3,0)
 ;;=3^Complete traumatic amp of unsp hand at wrist level, sequela
 ;;^UTILITY(U,$J,358.3,39229,1,4,0)
 ;;=4^S68.419S
 ;;^UTILITY(U,$J,358.3,39229,2)
 ;;=^5036707
