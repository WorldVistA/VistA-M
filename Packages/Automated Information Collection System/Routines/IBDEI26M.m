IBDEI26M ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34851,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,34851,1,4,0)
 ;;=4^S06.1X1A
 ;;^UTILITY(U,$J,358.3,34851,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,34852,0)
 ;;=S06.1X2A^^137^1786^19
 ;;^UTILITY(U,$J,358.3,34852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34852,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,34852,1,4,0)
 ;;=4^S06.1X2A
 ;;^UTILITY(U,$J,358.3,34852,2)
 ;;=^5020702
 ;;^UTILITY(U,$J,358.3,34853,0)
 ;;=S06.1X4A^^137^1786^20
 ;;^UTILITY(U,$J,358.3,34853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34853,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,34853,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,34853,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,34854,0)
 ;;=S06.1X7A^^137^1786^22
 ;;^UTILITY(U,$J,358.3,34854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34854,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,34854,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,34854,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,34855,0)
 ;;=S06.1X8A^^137^1786^23
 ;;^UTILITY(U,$J,358.3,34855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34855,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,34855,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,34855,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,34856,0)
 ;;=S06.1X9A^^137^1786^21
 ;;^UTILITY(U,$J,358.3,34856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34856,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,34856,1,4,0)
 ;;=4^S06.1X9A
 ;;^UTILITY(U,$J,358.3,34856,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,34857,0)
 ;;=S06.1X0A^^137^1786^24
 ;;^UTILITY(U,$J,358.3,34857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34857,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,34857,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,34857,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,34858,0)
 ;;=S06.9X5A^^137^1786^4
 ;;^UTILITY(U,$J,358.3,34858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34858,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w ret consc lev, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,34858,1,4,0)
 ;;=4^S06.9X5A
 ;;^UTILITY(U,$J,358.3,34858,2)
 ;;=^5021221
 ;;^UTILITY(U,$J,358.3,34859,0)
 ;;=S06.9X6A^^137^1786^5
 ;;^UTILITY(U,$J,358.3,34859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34859,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w/o ret consc w surv, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,34859,1,4,0)
 ;;=4^S06.9X6A
 ;;^UTILITY(U,$J,358.3,34859,2)
 ;;=^5021224
 ;;^UTILITY(U,$J,358.3,34860,0)
 ;;=S06.9X3A^^137^1786^6
 ;;^UTILITY(U,$J,358.3,34860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34860,1,3,0)
 ;;=3^Intcrn inj w LOC of 1-5 hrs 59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,34860,1,4,0)
 ;;=4^S06.9X3A
 ;;^UTILITY(U,$J,358.3,34860,2)
 ;;=^5021215
 ;;^UTILITY(U,$J,358.3,34861,0)
 ;;=S06.9X1A^^137^1786^7
 ;;^UTILITY(U,$J,358.3,34861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34861,1,3,0)
 ;;=3^Intcrn inj w LOC of 30 minutes or less, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,34861,1,4,0)
 ;;=4^S06.9X1A
 ;;^UTILITY(U,$J,358.3,34861,2)
 ;;=^5021209
 ;;^UTILITY(U,$J,358.3,34862,0)
 ;;=S06.9X2A^^137^1786^8
 ;;^UTILITY(U,$J,358.3,34862,1,0)
 ;;=^358.31IA^4^2
