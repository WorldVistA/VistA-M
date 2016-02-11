IBDEI2C3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39206,1,3,0)
 ;;=3^Concussion w/o LOC, initial encounter
 ;;^UTILITY(U,$J,358.3,39206,1,4,0)
 ;;=4^S06.0X0A
 ;;^UTILITY(U,$J,358.3,39206,2)
 ;;=^5020666
 ;;^UTILITY(U,$J,358.3,39207,0)
 ;;=Z13.850^^183^2013^19
 ;;^UTILITY(U,$J,358.3,39207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39207,1,3,0)
 ;;=3^TBI Screening
 ;;^UTILITY(U,$J,358.3,39207,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,39207,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,39208,0)
 ;;=Z87.820^^183^2013^18
 ;;^UTILITY(U,$J,358.3,39208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39208,1,3,0)
 ;;=3^Personal history of traumatic brain injury
 ;;^UTILITY(U,$J,358.3,39208,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,39208,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,39209,0)
 ;;=S06.890A^^183^2013^16
 ;;^UTILITY(U,$J,358.3,39209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39209,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,39209,1,4,0)
 ;;=4^S06.890A
 ;;^UTILITY(U,$J,358.3,39209,2)
 ;;=^5021176
 ;;^UTILITY(U,$J,358.3,39210,0)
 ;;=S06.1X5A^^183^2013^20
 ;;^UTILITY(U,$J,358.3,39210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39210,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,39210,1,4,0)
 ;;=4^S06.1X5A
 ;;^UTILITY(U,$J,358.3,39210,2)
 ;;=^5020711
 ;;^UTILITY(U,$J,358.3,39211,0)
 ;;=S06.1X6A^^183^2013^21
 ;;^UTILITY(U,$J,358.3,39211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39211,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,39211,1,4,0)
 ;;=4^S06.1X6A
 ;;^UTILITY(U,$J,358.3,39211,2)
 ;;=^5020714
 ;;^UTILITY(U,$J,358.3,39212,0)
 ;;=S06.1X3A^^183^2013^22
 ;;^UTILITY(U,$J,358.3,39212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39212,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,39212,1,4,0)
 ;;=4^S06.1X3A
 ;;^UTILITY(U,$J,358.3,39212,2)
 ;;=^5020705
 ;;^UTILITY(U,$J,358.3,39213,0)
 ;;=S06.1X1A^^183^2013^23
 ;;^UTILITY(U,$J,358.3,39213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39213,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,39213,1,4,0)
 ;;=4^S06.1X1A
 ;;^UTILITY(U,$J,358.3,39213,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,39214,0)
 ;;=S06.1X2A^^183^2013^24
 ;;^UTILITY(U,$J,358.3,39214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39214,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,39214,1,4,0)
 ;;=4^S06.1X2A
 ;;^UTILITY(U,$J,358.3,39214,2)
 ;;=^5020702
 ;;^UTILITY(U,$J,358.3,39215,0)
 ;;=S06.1X4A^^183^2013^25
 ;;^UTILITY(U,$J,358.3,39215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39215,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,39215,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,39215,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,39216,0)
 ;;=S06.1X7A^^183^2013^27
 ;;^UTILITY(U,$J,358.3,39216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39216,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,39216,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,39216,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,39217,0)
 ;;=S06.1X8A^^183^2013^28
 ;;^UTILITY(U,$J,358.3,39217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39217,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,39217,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,39217,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,39218,0)
 ;;=S06.1X9A^^183^2013^26
