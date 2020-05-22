IBDEI289 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35571,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,35572,0)
 ;;=S06.1X2A^^139^1816^19
 ;;^UTILITY(U,$J,358.3,35572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35572,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,35572,1,4,0)
 ;;=4^S06.1X2A
 ;;^UTILITY(U,$J,358.3,35572,2)
 ;;=^5020702
 ;;^UTILITY(U,$J,358.3,35573,0)
 ;;=S06.1X4A^^139^1816^20
 ;;^UTILITY(U,$J,358.3,35573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35573,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,35573,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,35573,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,35574,0)
 ;;=S06.1X7A^^139^1816^22
 ;;^UTILITY(U,$J,358.3,35574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35574,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,35574,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,35574,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,35575,0)
 ;;=S06.1X8A^^139^1816^23
 ;;^UTILITY(U,$J,358.3,35575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35575,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,35575,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,35575,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,35576,0)
 ;;=S06.1X9A^^139^1816^21
 ;;^UTILITY(U,$J,358.3,35576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35576,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,35576,1,4,0)
 ;;=4^S06.1X9A
 ;;^UTILITY(U,$J,358.3,35576,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,35577,0)
 ;;=S06.1X0A^^139^1816^24
 ;;^UTILITY(U,$J,358.3,35577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35577,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,35577,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,35577,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,35578,0)
 ;;=S06.9X5A^^139^1816^4
 ;;^UTILITY(U,$J,358.3,35578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35578,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w ret consc lev, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,35578,1,4,0)
 ;;=4^S06.9X5A
 ;;^UTILITY(U,$J,358.3,35578,2)
 ;;=^5021221
 ;;^UTILITY(U,$J,358.3,35579,0)
 ;;=S06.9X6A^^139^1816^5
 ;;^UTILITY(U,$J,358.3,35579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35579,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w/o ret consc w surv, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,35579,1,4,0)
 ;;=4^S06.9X6A
 ;;^UTILITY(U,$J,358.3,35579,2)
 ;;=^5021224
 ;;^UTILITY(U,$J,358.3,35580,0)
 ;;=S06.9X3A^^139^1816^6
 ;;^UTILITY(U,$J,358.3,35580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35580,1,3,0)
 ;;=3^Intcrn inj w LOC of 1-5 hrs 59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,35580,1,4,0)
 ;;=4^S06.9X3A
 ;;^UTILITY(U,$J,358.3,35580,2)
 ;;=^5021215
 ;;^UTILITY(U,$J,358.3,35581,0)
 ;;=S06.9X1A^^139^1816^7
 ;;^UTILITY(U,$J,358.3,35581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35581,1,3,0)
 ;;=3^Intcrn inj w LOC of 30 minutes or less, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,35581,1,4,0)
 ;;=4^S06.9X1A
 ;;^UTILITY(U,$J,358.3,35581,2)
 ;;=^5021209
 ;;^UTILITY(U,$J,358.3,35582,0)
 ;;=S06.9X2A^^139^1816^8
 ;;^UTILITY(U,$J,358.3,35582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35582,1,3,0)
 ;;=3^Intcrn inj w LOC of 31-59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,35582,1,4,0)
 ;;=4^S06.9X2A
 ;;^UTILITY(U,$J,358.3,35582,2)
 ;;=^5021212
