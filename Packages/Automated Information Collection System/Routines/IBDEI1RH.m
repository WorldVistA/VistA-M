IBDEI1RH ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31120,1,3,0)
 ;;=3^Concussion w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,31120,1,4,0)
 ;;=4^S06.0X6A
 ;;^UTILITY(U,$J,358.3,31120,2)
 ;;=^5020684
 ;;^UTILITY(U,$J,358.3,31121,0)
 ;;=S06.0X3A^^180^1946^3
 ;;^UTILITY(U,$J,358.3,31121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31121,1,3,0)
 ;;=3^Concussion w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,31121,1,4,0)
 ;;=4^S06.0X3A
 ;;^UTILITY(U,$J,358.3,31121,2)
 ;;=^5020675
 ;;^UTILITY(U,$J,358.3,31122,0)
 ;;=S06.0X1A^^180^1946^4
 ;;^UTILITY(U,$J,358.3,31122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31122,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,31122,1,4,0)
 ;;=4^S06.0X1A
 ;;^UTILITY(U,$J,358.3,31122,2)
 ;;=^5020669
 ;;^UTILITY(U,$J,358.3,31123,0)
 ;;=S06.0X2A^^180^1946^5
 ;;^UTILITY(U,$J,358.3,31123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31123,1,3,0)
 ;;=3^Concussion w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,31123,1,4,0)
 ;;=4^S06.0X2A
 ;;^UTILITY(U,$J,358.3,31123,2)
 ;;=^5020672
 ;;^UTILITY(U,$J,358.3,31124,0)
 ;;=S06.0X4A^^180^1946^6
 ;;^UTILITY(U,$J,358.3,31124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31124,1,3,0)
 ;;=3^Concussion w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,31124,1,4,0)
 ;;=4^S06.0X4A
 ;;^UTILITY(U,$J,358.3,31124,2)
 ;;=^5020678
 ;;^UTILITY(U,$J,358.3,31125,0)
 ;;=S06.0X9A^^180^1946^7
 ;;^UTILITY(U,$J,358.3,31125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31125,1,3,0)
 ;;=3^Concussion w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,31125,1,4,0)
 ;;=4^S06.0X9A
 ;;^UTILITY(U,$J,358.3,31125,2)
 ;;=^5020693
 ;;^UTILITY(U,$J,358.3,31126,0)
 ;;=S06.0X0A^^180^1946^8
 ;;^UTILITY(U,$J,358.3,31126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31126,1,3,0)
 ;;=3^Concussion w/o LOC, initial encounter
 ;;^UTILITY(U,$J,358.3,31126,1,4,0)
 ;;=4^S06.0X0A
 ;;^UTILITY(U,$J,358.3,31126,2)
 ;;=^5020666
 ;;^UTILITY(U,$J,358.3,31127,0)
 ;;=Z13.850^^180^1946^19
 ;;^UTILITY(U,$J,358.3,31127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31127,1,3,0)
 ;;=3^TBI Screening
 ;;^UTILITY(U,$J,358.3,31127,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,31127,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,31128,0)
 ;;=Z87.820^^180^1946^18
 ;;^UTILITY(U,$J,358.3,31128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31128,1,3,0)
 ;;=3^Personal history of traumatic brain injury
 ;;^UTILITY(U,$J,358.3,31128,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,31128,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,31129,0)
 ;;=S06.890A^^180^1946^16
 ;;^UTILITY(U,$J,358.3,31129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31129,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,31129,1,4,0)
 ;;=4^S06.890A
 ;;^UTILITY(U,$J,358.3,31129,2)
 ;;=^5021176
 ;;^UTILITY(U,$J,358.3,31130,0)
 ;;=S06.1X5A^^180^1946^20
 ;;^UTILITY(U,$J,358.3,31130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31130,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,31130,1,4,0)
 ;;=4^S06.1X5A
 ;;^UTILITY(U,$J,358.3,31130,2)
 ;;=^5020711
 ;;^UTILITY(U,$J,358.3,31131,0)
 ;;=S06.1X6A^^180^1946^21
 ;;^UTILITY(U,$J,358.3,31131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31131,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,31131,1,4,0)
 ;;=4^S06.1X6A
 ;;^UTILITY(U,$J,358.3,31131,2)
 ;;=^5020714
 ;;^UTILITY(U,$J,358.3,31132,0)
 ;;=S06.1X3A^^180^1946^22
 ;;^UTILITY(U,$J,358.3,31132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31132,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, init
