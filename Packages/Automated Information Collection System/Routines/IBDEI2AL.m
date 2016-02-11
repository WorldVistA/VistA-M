IBDEI2AL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38510,0)
 ;;=Z13.850^^180^1975^19
 ;;^UTILITY(U,$J,358.3,38510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38510,1,3,0)
 ;;=3^TBI Screening
 ;;^UTILITY(U,$J,358.3,38510,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,38510,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,38511,0)
 ;;=Z87.820^^180^1975^18
 ;;^UTILITY(U,$J,358.3,38511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38511,1,3,0)
 ;;=3^Personal history of traumatic brain injury
 ;;^UTILITY(U,$J,358.3,38511,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,38511,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,38512,0)
 ;;=S06.890A^^180^1975^16
 ;;^UTILITY(U,$J,358.3,38512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38512,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,38512,1,4,0)
 ;;=4^S06.890A
 ;;^UTILITY(U,$J,358.3,38512,2)
 ;;=^5021176
 ;;^UTILITY(U,$J,358.3,38513,0)
 ;;=S06.1X5A^^180^1975^20
 ;;^UTILITY(U,$J,358.3,38513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38513,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,38513,1,4,0)
 ;;=4^S06.1X5A
 ;;^UTILITY(U,$J,358.3,38513,2)
 ;;=^5020711
 ;;^UTILITY(U,$J,358.3,38514,0)
 ;;=S06.1X6A^^180^1975^21
 ;;^UTILITY(U,$J,358.3,38514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38514,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,38514,1,4,0)
 ;;=4^S06.1X6A
 ;;^UTILITY(U,$J,358.3,38514,2)
 ;;=^5020714
 ;;^UTILITY(U,$J,358.3,38515,0)
 ;;=S06.1X3A^^180^1975^22
 ;;^UTILITY(U,$J,358.3,38515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38515,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,38515,1,4,0)
 ;;=4^S06.1X3A
 ;;^UTILITY(U,$J,358.3,38515,2)
 ;;=^5020705
 ;;^UTILITY(U,$J,358.3,38516,0)
 ;;=S06.1X1A^^180^1975^23
 ;;^UTILITY(U,$J,358.3,38516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38516,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,38516,1,4,0)
 ;;=4^S06.1X1A
 ;;^UTILITY(U,$J,358.3,38516,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,38517,0)
 ;;=S06.1X2A^^180^1975^24
 ;;^UTILITY(U,$J,358.3,38517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38517,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,38517,1,4,0)
 ;;=4^S06.1X2A
 ;;^UTILITY(U,$J,358.3,38517,2)
 ;;=^5020702
 ;;^UTILITY(U,$J,358.3,38518,0)
 ;;=S06.1X4A^^180^1975^25
 ;;^UTILITY(U,$J,358.3,38518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38518,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,38518,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,38518,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,38519,0)
 ;;=S06.1X7A^^180^1975^27
 ;;^UTILITY(U,$J,358.3,38519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38519,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,38519,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,38519,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,38520,0)
 ;;=S06.1X8A^^180^1975^28
 ;;^UTILITY(U,$J,358.3,38520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38520,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,38520,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,38520,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,38521,0)
 ;;=S06.1X9A^^180^1975^26
 ;;^UTILITY(U,$J,358.3,38521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38521,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,38521,1,4,0)
 ;;=4^S06.1X9A
