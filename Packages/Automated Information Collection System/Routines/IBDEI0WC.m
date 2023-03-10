IBDEI0WC ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14584,2)
 ;;=^5020711
 ;;^UTILITY(U,$J,358.3,14585,0)
 ;;=S06.1X6A^^58^701^16
 ;;^UTILITY(U,$J,358.3,14585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14585,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,14585,1,4,0)
 ;;=4^S06.1X6A
 ;;^UTILITY(U,$J,358.3,14585,2)
 ;;=^5020714
 ;;^UTILITY(U,$J,358.3,14586,0)
 ;;=S06.1X3A^^58^701^17
 ;;^UTILITY(U,$J,358.3,14586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14586,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,14586,1,4,0)
 ;;=4^S06.1X3A
 ;;^UTILITY(U,$J,358.3,14586,2)
 ;;=^5020705
 ;;^UTILITY(U,$J,358.3,14587,0)
 ;;=S06.1X1A^^58^701^18
 ;;^UTILITY(U,$J,358.3,14587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14587,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,14587,1,4,0)
 ;;=4^S06.1X1A
 ;;^UTILITY(U,$J,358.3,14587,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,14588,0)
 ;;=S06.1X2A^^58^701^19
 ;;^UTILITY(U,$J,358.3,14588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14588,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,14588,1,4,0)
 ;;=4^S06.1X2A
 ;;^UTILITY(U,$J,358.3,14588,2)
 ;;=^5020702
 ;;^UTILITY(U,$J,358.3,14589,0)
 ;;=S06.1X4A^^58^701^20
 ;;^UTILITY(U,$J,358.3,14589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14589,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,14589,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,14589,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,14590,0)
 ;;=S06.1X7A^^58^701^22
 ;;^UTILITY(U,$J,358.3,14590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14590,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,14590,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,14590,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,14591,0)
 ;;=S06.1X8A^^58^701^23
 ;;^UTILITY(U,$J,358.3,14591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14591,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,14591,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,14591,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,14592,0)
 ;;=S06.1X9A^^58^701^21
 ;;^UTILITY(U,$J,358.3,14592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14592,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,14592,1,4,0)
 ;;=4^S06.1X9A
 ;;^UTILITY(U,$J,358.3,14592,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,14593,0)
 ;;=S06.1X0A^^58^701^24
 ;;^UTILITY(U,$J,358.3,14593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14593,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,14593,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,14593,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,14594,0)
 ;;=S06.9X5A^^58^701^4
 ;;^UTILITY(U,$J,358.3,14594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14594,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w ret consc lev, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14594,1,4,0)
 ;;=4^S06.9X5A
 ;;^UTILITY(U,$J,358.3,14594,2)
 ;;=^5021221
 ;;^UTILITY(U,$J,358.3,14595,0)
 ;;=S06.9X6A^^58^701^5
 ;;^UTILITY(U,$J,358.3,14595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14595,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w/o ret consc w surv, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14595,1,4,0)
 ;;=4^S06.9X6A
 ;;^UTILITY(U,$J,358.3,14595,2)
 ;;=^5021224
