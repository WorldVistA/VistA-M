IBDEI04S ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1714,1,4,0)
 ;;=4^K13.70
 ;;^UTILITY(U,$J,358.3,1714,2)
 ;;=^5008496
 ;;^UTILITY(U,$J,358.3,1715,0)
 ;;=R04.2^^3^48^2
 ;;^UTILITY(U,$J,358.3,1715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1715,1,3,0)
 ;;=3^Hemoptysis
 ;;^UTILITY(U,$J,358.3,1715,1,4,0)
 ;;=4^R04.2
 ;;^UTILITY(U,$J,358.3,1715,2)
 ;;=^5019175
 ;;^UTILITY(U,$J,358.3,1716,0)
 ;;=R94.5^^3^49^1
 ;;^UTILITY(U,$J,358.3,1716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1716,1,3,0)
 ;;=3^Abnormal results of liver function studies
 ;;^UTILITY(U,$J,358.3,1716,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,1716,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,1717,0)
 ;;=T78.40XA^^3^49^2
 ;;^UTILITY(U,$J,358.3,1717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1717,1,3,0)
 ;;=3^Allergy, unspecified, initial encounter
 ;;^UTILITY(U,$J,358.3,1717,1,4,0)
 ;;=4^T78.40XA
 ;;^UTILITY(U,$J,358.3,1717,2)
 ;;=^5054284
 ;;^UTILITY(U,$J,358.3,1718,0)
 ;;=Z51.81^^3^49^6
 ;;^UTILITY(U,$J,358.3,1718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1718,1,3,0)
 ;;=3^Therapeutic drug level monitoring
 ;;^UTILITY(U,$J,358.3,1718,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,1718,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,1719,0)
 ;;=Z02.79^^3^49^4
 ;;^UTILITY(U,$J,358.3,1719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1719,1,3,0)
 ;;=3^Issue of other medical certificate
 ;;^UTILITY(U,$J,358.3,1719,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,1719,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,1720,0)
 ;;=Z76.0^^3^49^5
 ;;^UTILITY(U,$J,358.3,1720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1720,1,3,0)
 ;;=3^Issue of repeat prescription
 ;;^UTILITY(U,$J,358.3,1720,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,1720,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,1721,0)
 ;;=Z04.9^^3^49^3
 ;;^UTILITY(U,$J,358.3,1721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1721,1,3,0)
 ;;=3^Examination and observation for unsp reason
 ;;^UTILITY(U,$J,358.3,1721,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,1721,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,1722,0)
 ;;=G89.0^^3^50^4
 ;;^UTILITY(U,$J,358.3,1722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1722,1,3,0)
 ;;=3^Central pain syndrome
 ;;^UTILITY(U,$J,358.3,1722,1,4,0)
 ;;=4^G89.0
 ;;^UTILITY(U,$J,358.3,1722,2)
 ;;=^334189
 ;;^UTILITY(U,$J,358.3,1723,0)
 ;;=G89.11^^3^50^1
 ;;^UTILITY(U,$J,358.3,1723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1723,1,3,0)
 ;;=3^Acute pain due to trauma
 ;;^UTILITY(U,$J,358.3,1723,1,4,0)
 ;;=4^G89.11
 ;;^UTILITY(U,$J,358.3,1723,2)
 ;;=^5004152
 ;;^UTILITY(U,$J,358.3,1724,0)
 ;;=G89.12^^3^50^2
 ;;^UTILITY(U,$J,358.3,1724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1724,1,3,0)
 ;;=3^Acute post-thoracotomy pain
 ;;^UTILITY(U,$J,358.3,1724,1,4,0)
 ;;=4^G89.12
 ;;^UTILITY(U,$J,358.3,1724,2)
 ;;=^5004153
 ;;^UTILITY(U,$J,358.3,1725,0)
 ;;=G89.18^^3^50^3
 ;;^UTILITY(U,$J,358.3,1725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1725,1,3,0)
 ;;=3^Acute postprocedural pain NEC
 ;;^UTILITY(U,$J,358.3,1725,1,4,0)
 ;;=4^G89.18
 ;;^UTILITY(U,$J,358.3,1725,2)
 ;;=^5004154
 ;;^UTILITY(U,$J,358.3,1726,0)
 ;;=R52.^^3^50^16
 ;;^UTILITY(U,$J,358.3,1726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1726,1,3,0)
 ;;=3^Pain, unspecified
 ;;^UTILITY(U,$J,358.3,1726,1,4,0)
 ;;=4^R52.
 ;;^UTILITY(U,$J,358.3,1726,2)
 ;;=^5019514
 ;;^UTILITY(U,$J,358.3,1727,0)
 ;;=G89.21^^3^50^6
 ;;^UTILITY(U,$J,358.3,1727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1727,1,3,0)
 ;;=3^Chronic pain due to trauma
 ;;^UTILITY(U,$J,358.3,1727,1,4,0)
 ;;=4^G89.21
 ;;^UTILITY(U,$J,358.3,1727,2)
 ;;=^5004155
 ;;^UTILITY(U,$J,358.3,1728,0)
 ;;=G89.22^^3^50^8
 ;;^UTILITY(U,$J,358.3,1728,1,0)
 ;;=^358.31IA^4^2
