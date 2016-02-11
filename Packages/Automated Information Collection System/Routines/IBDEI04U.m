IBDEI04U ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1575,1,4,0)
 ;;=4^Z02.6
 ;;^UTILITY(U,$J,358.3,1575,2)
 ;;=^5062639
 ;;^UTILITY(U,$J,358.3,1576,0)
 ;;=Z02.5^^14^157^12
 ;;^UTILITY(U,$J,358.3,1576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1576,1,3,0)
 ;;=3^Exam for Sport Participation
 ;;^UTILITY(U,$J,358.3,1576,1,4,0)
 ;;=4^Z02.5
 ;;^UTILITY(U,$J,358.3,1576,2)
 ;;=^5062638
 ;;^UTILITY(U,$J,358.3,1577,0)
 ;;=Z02.3^^14^157^11
 ;;^UTILITY(U,$J,358.3,1577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1577,1,3,0)
 ;;=3^Exam for Recruitment to Armed Forces
 ;;^UTILITY(U,$J,358.3,1577,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,1577,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,1578,0)
 ;;=Z01.118^^14^157^4
 ;;^UTILITY(U,$J,358.3,1578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1578,1,3,0)
 ;;=3^Ears/Hearing Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,1578,1,4,0)
 ;;=4^Z01.118
 ;;^UTILITY(U,$J,358.3,1578,2)
 ;;=^5062616
 ;;^UTILITY(U,$J,358.3,1579,0)
 ;;=Z01.10^^14^157^5
 ;;^UTILITY(U,$J,358.3,1579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1579,1,3,0)
 ;;=3^Ears/Hearing Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,1579,1,4,0)
 ;;=4^Z01.10
 ;;^UTILITY(U,$J,358.3,1579,2)
 ;;=^5062614
 ;;^UTILITY(U,$J,358.3,1580,0)
 ;;=Z46.1^^14^157^17
 ;;^UTILITY(U,$J,358.3,1580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1580,1,3,0)
 ;;=3^Fitting/Adjustment of Hearing Aid
 ;;^UTILITY(U,$J,358.3,1580,1,4,0)
 ;;=4^Z46.1
 ;;^UTILITY(U,$J,358.3,1580,2)
 ;;=^5063014
 ;;^UTILITY(U,$J,358.3,1581,0)
 ;;=Z09.^^14^157^14
 ;;^UTILITY(U,$J,358.3,1581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1581,1,3,0)
 ;;=3^F/U Exam After Trtmt for Cond Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,1581,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,1581,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,1582,0)
 ;;=Z02.79^^14^157^20
 ;;^UTILITY(U,$J,358.3,1582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1582,1,3,0)
 ;;=3^Medical Certificate Issue NEC
 ;;^UTILITY(U,$J,358.3,1582,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,1582,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,1583,0)
 ;;=Z02.1^^14^157^9
 ;;^UTILITY(U,$J,358.3,1583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1583,1,3,0)
 ;;=3^Exam for Employment
 ;;^UTILITY(U,$J,358.3,1583,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,1583,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,1584,0)
 ;;=Z13.5^^14^157^13
 ;;^UTILITY(U,$J,358.3,1584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1584,1,3,0)
 ;;=3^Eye/Ear Disorder Screening
 ;;^UTILITY(U,$J,358.3,1584,1,4,0)
 ;;=4^Z13.5
 ;;^UTILITY(U,$J,358.3,1584,2)
 ;;=^5062706
 ;;^UTILITY(U,$J,358.3,1585,0)
 ;;=Z82.2^^14^157^15
 ;;^UTILITY(U,$J,358.3,1585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1585,1,3,0)
 ;;=3^Family history of deafness and hearing loss
 ;;^UTILITY(U,$J,358.3,1585,1,4,0)
 ;;=4^Z82.2
 ;;^UTILITY(U,$J,358.3,1585,2)
 ;;=^5063366
 ;;^UTILITY(U,$J,358.3,1586,0)
 ;;=Z83.52^^14^157^16
 ;;^UTILITY(U,$J,358.3,1586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1586,1,3,0)
 ;;=3^Family history of ear disorders
 ;;^UTILITY(U,$J,358.3,1586,1,4,0)
 ;;=4^Z83.52
 ;;^UTILITY(U,$J,358.3,1586,2)
 ;;=^5063384
 ;;^UTILITY(U,$J,358.3,1587,0)
 ;;=Z91.81^^14^157^18
 ;;^UTILITY(U,$J,358.3,1587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1587,1,3,0)
 ;;=3^History of falling
 ;;^UTILITY(U,$J,358.3,1587,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,1587,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,1588,0)
 ;;=Z76.5^^14^157^19
 ;;^UTILITY(U,$J,358.3,1588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1588,1,3,0)
 ;;=3^Malingerer [conscious simulation]
 ;;^UTILITY(U,$J,358.3,1588,1,4,0)
 ;;=4^Z76.5
 ;;^UTILITY(U,$J,358.3,1588,2)
 ;;=^5063302
