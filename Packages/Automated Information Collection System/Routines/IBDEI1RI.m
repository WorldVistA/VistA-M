IBDEI1RI ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31132,1,4,0)
 ;;=4^S06.1X3A
 ;;^UTILITY(U,$J,358.3,31132,2)
 ;;=^5020705
 ;;^UTILITY(U,$J,358.3,31133,0)
 ;;=S06.1X1A^^180^1946^23
 ;;^UTILITY(U,$J,358.3,31133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31133,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,31133,1,4,0)
 ;;=4^S06.1X1A
 ;;^UTILITY(U,$J,358.3,31133,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,31134,0)
 ;;=S06.1X2A^^180^1946^24
 ;;^UTILITY(U,$J,358.3,31134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31134,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,31134,1,4,0)
 ;;=4^S06.1X2A
 ;;^UTILITY(U,$J,358.3,31134,2)
 ;;=^5020702
 ;;^UTILITY(U,$J,358.3,31135,0)
 ;;=S06.1X4A^^180^1946^25
 ;;^UTILITY(U,$J,358.3,31135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31135,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,31135,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,31135,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,31136,0)
 ;;=S06.1X7A^^180^1946^27
 ;;^UTILITY(U,$J,358.3,31136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31136,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,31136,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,31136,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,31137,0)
 ;;=S06.1X8A^^180^1946^28
 ;;^UTILITY(U,$J,358.3,31137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31137,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,31137,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,31137,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,31138,0)
 ;;=S06.1X9A^^180^1946^26
 ;;^UTILITY(U,$J,358.3,31138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31138,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,31138,1,4,0)
 ;;=4^S06.1X9A
 ;;^UTILITY(U,$J,358.3,31138,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,31139,0)
 ;;=S06.1X0A^^180^1946^29
 ;;^UTILITY(U,$J,358.3,31139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31139,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,31139,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,31139,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,31140,0)
 ;;=S06.9X5A^^180^1946^9
 ;;^UTILITY(U,$J,358.3,31140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31140,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w ret consc lev, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31140,1,4,0)
 ;;=4^S06.9X5A
 ;;^UTILITY(U,$J,358.3,31140,2)
 ;;=^5021221
 ;;^UTILITY(U,$J,358.3,31141,0)
 ;;=S06.9X6A^^180^1946^10
 ;;^UTILITY(U,$J,358.3,31141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31141,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w/o ret consc w surv, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31141,1,4,0)
 ;;=4^S06.9X6A
 ;;^UTILITY(U,$J,358.3,31141,2)
 ;;=^5021224
 ;;^UTILITY(U,$J,358.3,31142,0)
 ;;=S06.9X3A^^180^1946^11
 ;;^UTILITY(U,$J,358.3,31142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31142,1,3,0)
 ;;=3^Intcrn inj w LOC of 1-5 hrs 59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31142,1,4,0)
 ;;=4^S06.9X3A
 ;;^UTILITY(U,$J,358.3,31142,2)
 ;;=^5021215
 ;;^UTILITY(U,$J,358.3,31143,0)
 ;;=S06.9X1A^^180^1946^12
 ;;^UTILITY(U,$J,358.3,31143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31143,1,3,0)
 ;;=3^Intcrn inj w LOC of 30 minutes or less, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31143,1,4,0)
 ;;=4^S06.9X1A
 ;;^UTILITY(U,$J,358.3,31143,2)
 ;;=^5021209
 ;;^UTILITY(U,$J,358.3,31144,0)
 ;;=S06.9X2A^^180^1946^13
 ;;^UTILITY(U,$J,358.3,31144,1,0)
 ;;=^358.31IA^4^2
