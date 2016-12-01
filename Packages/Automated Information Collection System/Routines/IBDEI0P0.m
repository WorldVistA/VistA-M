IBDEI0P0 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31706,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31706,1,2,0)
 ;;=2^Stim Guidance
 ;;^UTILITY(U,$J,358.3,31706,1,3,0)
 ;;=3^95873
 ;;^UTILITY(U,$J,358.3,31707,0)
 ;;=95874^^93^1393^1^^^^1
 ;;^UTILITY(U,$J,358.3,31707,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31707,1,2,0)
 ;;=2^Needle Guidance
 ;;^UTILITY(U,$J,358.3,31707,1,3,0)
 ;;=3^95874
 ;;^UTILITY(U,$J,358.3,31708,0)
 ;;=20526^^93^1394^1^^^^1
 ;;^UTILITY(U,$J,358.3,31708,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31708,1,2,0)
 ;;=2^Therapeutic Injection
 ;;^UTILITY(U,$J,358.3,31708,1,3,0)
 ;;=3^20526
 ;;^UTILITY(U,$J,358.3,31709,0)
 ;;=20611^^93^1395^3^^^^1
 ;;^UTILITY(U,$J,358.3,31709,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31709,1,2,0)
 ;;=2^Joint Inj w/ US-Major
 ;;^UTILITY(U,$J,358.3,31709,1,3,0)
 ;;=3^20611
 ;;^UTILITY(U,$J,358.3,31710,0)
 ;;=20606^^93^1395^2^^^^1
 ;;^UTILITY(U,$J,358.3,31710,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31710,1,2,0)
 ;;=2^Joint Inj w/ US-Intermediate
 ;;^UTILITY(U,$J,358.3,31710,1,3,0)
 ;;=3^20606
 ;;^UTILITY(U,$J,358.3,31711,0)
 ;;=20604^^93^1395^1^^^^1
 ;;^UTILITY(U,$J,358.3,31711,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31711,1,2,0)
 ;;=2^Joint Inj w/ US-Small
 ;;^UTILITY(U,$J,358.3,31711,1,3,0)
 ;;=3^20604
 ;;^UTILITY(U,$J,358.3,31712,0)
 ;;=20552^^93^1396^1^^^^1
 ;;^UTILITY(U,$J,358.3,31712,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31712,1,2,0)
 ;;=2^Inject 1-2 Muscles
 ;;^UTILITY(U,$J,358.3,31712,1,3,0)
 ;;=3^20552
 ;;^UTILITY(U,$J,358.3,31713,0)
 ;;=20553^^93^1396^2^^^^1
 ;;^UTILITY(U,$J,358.3,31713,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31713,1,2,0)
 ;;=2^Inject 3 or more Muscles
 ;;^UTILITY(U,$J,358.3,31713,1,3,0)
 ;;=3^20553
 ;;^UTILITY(U,$J,358.3,31714,0)
 ;;=76881^^93^1397^2^^^^1
 ;;^UTILITY(U,$J,358.3,31714,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31714,1,2,0)
 ;;=2^US Guided w/ Image
 ;;^UTILITY(U,$J,358.3,31714,1,3,0)
 ;;=3^76881
 ;;^UTILITY(U,$J,358.3,31715,0)
 ;;=76882^^93^1397^1^^^^1
 ;;^UTILITY(U,$J,358.3,31715,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31715,1,2,0)
 ;;=2^Complete US Guided w/ Image
 ;;^UTILITY(U,$J,358.3,31715,1,3,0)
 ;;=3^76882
 ;;^UTILITY(U,$J,358.3,31716,0)
 ;;=76942^^93^1397^3^^^^1
 ;;^UTILITY(U,$J,358.3,31716,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31716,1,2,0)
 ;;=2^US Guided w/o Image
 ;;^UTILITY(U,$J,358.3,31716,1,3,0)
 ;;=3^76942
 ;;^UTILITY(U,$J,358.3,31717,0)
 ;;=99358^^93^1398^1^^^^1
 ;;^UTILITY(U,$J,358.3,31717,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31717,1,2,0)
 ;;=2^Prolonged Service w/o Patient,1st hr
 ;;^UTILITY(U,$J,358.3,31717,1,3,0)
 ;;=3^99358
 ;;^UTILITY(U,$J,358.3,31718,0)
 ;;=99359^^93^1398^2^^^^1
 ;;^UTILITY(U,$J,358.3,31718,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31718,1,2,0)
 ;;=2^Prolonged Service w/o Pt,Ea Addl 30min
 ;;^UTILITY(U,$J,358.3,31718,1,3,0)
 ;;=3^99359
 ;;^UTILITY(U,$J,358.3,31719,0)
 ;;=S06.0X5A^^94^1399^1
 ;;^UTILITY(U,$J,358.3,31719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31719,1,3,0)
 ;;=3^Concussion w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,31719,1,4,0)
 ;;=4^S06.0X5A
 ;;^UTILITY(U,$J,358.3,31719,2)
 ;;=^5020681
 ;;^UTILITY(U,$J,358.3,31720,0)
 ;;=S06.0X6A^^94^1399^2
 ;;^UTILITY(U,$J,358.3,31720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31720,1,3,0)
 ;;=3^Concussion w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,31720,1,4,0)
 ;;=4^S06.0X6A
 ;;^UTILITY(U,$J,358.3,31720,2)
 ;;=^5020684
 ;;^UTILITY(U,$J,358.3,31721,0)
 ;;=S06.0X3A^^94^1399^3
 ;;^UTILITY(U,$J,358.3,31721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31721,1,3,0)
 ;;=3^Concussion w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,31721,1,4,0)
 ;;=4^S06.0X3A
 ;;^UTILITY(U,$J,358.3,31721,2)
 ;;=^5020675
 ;;^UTILITY(U,$J,358.3,31722,0)
 ;;=S06.0X1A^^94^1399^4
 ;;^UTILITY(U,$J,358.3,31722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31722,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,31722,1,4,0)
 ;;=4^S06.0X1A
 ;;^UTILITY(U,$J,358.3,31722,2)
 ;;=^5020669
 ;;^UTILITY(U,$J,358.3,31723,0)
 ;;=S06.0X2A^^94^1399^5
 ;;^UTILITY(U,$J,358.3,31723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31723,1,3,0)
 ;;=3^Concussion w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,31723,1,4,0)
 ;;=4^S06.0X2A
 ;;^UTILITY(U,$J,358.3,31723,2)
 ;;=^5020672
 ;;^UTILITY(U,$J,358.3,31724,0)
 ;;=S06.0X4A^^94^1399^6
 ;;^UTILITY(U,$J,358.3,31724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31724,1,3,0)
 ;;=3^Concussion w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,31724,1,4,0)
 ;;=4^S06.0X4A
 ;;^UTILITY(U,$J,358.3,31724,2)
 ;;=^5020678
 ;;^UTILITY(U,$J,358.3,31725,0)
 ;;=S06.0X9A^^94^1399^7
 ;;^UTILITY(U,$J,358.3,31725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31725,1,3,0)
 ;;=3^Concussion w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,31725,1,4,0)
 ;;=4^S06.0X9A
 ;;^UTILITY(U,$J,358.3,31725,2)
 ;;=^5020693
 ;;^UTILITY(U,$J,358.3,31726,0)
 ;;=S06.0X0A^^94^1399^8
 ;;^UTILITY(U,$J,358.3,31726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31726,1,3,0)
 ;;=3^Concussion w/o LOC, initial encounter
 ;;^UTILITY(U,$J,358.3,31726,1,4,0)
 ;;=4^S06.0X0A
 ;;^UTILITY(U,$J,358.3,31726,2)
 ;;=^5020666
 ;;^UTILITY(U,$J,358.3,31727,0)
 ;;=Z13.850^^94^1399^19
 ;;^UTILITY(U,$J,358.3,31727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31727,1,3,0)
 ;;=3^TBI Screening
 ;;^UTILITY(U,$J,358.3,31727,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,31727,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,31728,0)
 ;;=Z87.820^^94^1399^18
 ;;^UTILITY(U,$J,358.3,31728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31728,1,3,0)
 ;;=3^Personal history of traumatic brain injury
 ;;^UTILITY(U,$J,358.3,31728,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,31728,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,31729,0)
 ;;=S06.890A^^94^1399^16
 ;;^UTILITY(U,$J,358.3,31729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31729,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,31729,1,4,0)
 ;;=4^S06.890A
 ;;^UTILITY(U,$J,358.3,31729,2)
 ;;=^5021176
 ;;^UTILITY(U,$J,358.3,31730,0)
 ;;=S06.1X5A^^94^1399^20
 ;;^UTILITY(U,$J,358.3,31730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31730,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,31730,1,4,0)
 ;;=4^S06.1X5A
 ;;^UTILITY(U,$J,358.3,31730,2)
 ;;=^5020711
 ;;^UTILITY(U,$J,358.3,31731,0)
 ;;=S06.1X6A^^94^1399^21
 ;;^UTILITY(U,$J,358.3,31731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31731,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,31731,1,4,0)
 ;;=4^S06.1X6A
 ;;^UTILITY(U,$J,358.3,31731,2)
 ;;=^5020714
 ;;^UTILITY(U,$J,358.3,31732,0)
 ;;=S06.1X3A^^94^1399^22
 ;;^UTILITY(U,$J,358.3,31732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31732,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,31732,1,4,0)
 ;;=4^S06.1X3A
 ;;^UTILITY(U,$J,358.3,31732,2)
 ;;=^5020705
 ;;^UTILITY(U,$J,358.3,31733,0)
 ;;=S06.1X1A^^94^1399^23
 ;;^UTILITY(U,$J,358.3,31733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31733,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,31733,1,4,0)
 ;;=4^S06.1X1A
 ;;^UTILITY(U,$J,358.3,31733,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,31734,0)
 ;;=S06.1X2A^^94^1399^24
 ;;^UTILITY(U,$J,358.3,31734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31734,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,31734,1,4,0)
 ;;=4^S06.1X2A
 ;;^UTILITY(U,$J,358.3,31734,2)
 ;;=^5020702
 ;;^UTILITY(U,$J,358.3,31735,0)
 ;;=S06.1X4A^^94^1399^25
 ;;^UTILITY(U,$J,358.3,31735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31735,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,31735,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,31735,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,31736,0)
 ;;=S06.1X7A^^94^1399^27
 ;;^UTILITY(U,$J,358.3,31736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31736,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,31736,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,31736,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,31737,0)
 ;;=S06.1X8A^^94^1399^28
 ;;^UTILITY(U,$J,358.3,31737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31737,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,31737,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,31737,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,31738,0)
 ;;=S06.1X9A^^94^1399^26
 ;;^UTILITY(U,$J,358.3,31738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31738,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,31738,1,4,0)
 ;;=4^S06.1X9A
 ;;^UTILITY(U,$J,358.3,31738,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,31739,0)
 ;;=S06.1X0A^^94^1399^29
 ;;^UTILITY(U,$J,358.3,31739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31739,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,31739,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,31739,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,31740,0)
 ;;=S06.9X5A^^94^1399^9
 ;;^UTILITY(U,$J,358.3,31740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31740,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w ret consc lev, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31740,1,4,0)
 ;;=4^S06.9X5A
 ;;^UTILITY(U,$J,358.3,31740,2)
 ;;=^5021221
 ;;^UTILITY(U,$J,358.3,31741,0)
 ;;=S06.9X6A^^94^1399^10
 ;;^UTILITY(U,$J,358.3,31741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31741,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w/o ret consc w surv, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31741,1,4,0)
 ;;=4^S06.9X6A
 ;;^UTILITY(U,$J,358.3,31741,2)
 ;;=^5021224
 ;;^UTILITY(U,$J,358.3,31742,0)
 ;;=S06.9X3A^^94^1399^11
 ;;^UTILITY(U,$J,358.3,31742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31742,1,3,0)
 ;;=3^Intcrn inj w LOC of 1-5 hrs 59 min, init encntr,Unspec
