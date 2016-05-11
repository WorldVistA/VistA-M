IBDEI041 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1454,1,3,0)
 ;;=3^Ears/Hearing Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,1454,1,4,0)
 ;;=4^Z01.10
 ;;^UTILITY(U,$J,358.3,1454,2)
 ;;=^5062614
 ;;^UTILITY(U,$J,358.3,1455,0)
 ;;=Z46.1^^8^136^17
 ;;^UTILITY(U,$J,358.3,1455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1455,1,3,0)
 ;;=3^Fitting/Adjustment of Hearing Aid
 ;;^UTILITY(U,$J,358.3,1455,1,4,0)
 ;;=4^Z46.1
 ;;^UTILITY(U,$J,358.3,1455,2)
 ;;=^5063014
 ;;^UTILITY(U,$J,358.3,1456,0)
 ;;=Z09.^^8^136^14
 ;;^UTILITY(U,$J,358.3,1456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1456,1,3,0)
 ;;=3^F/U Exam After Trtmt for Cond Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,1456,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,1456,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,1457,0)
 ;;=Z02.79^^8^136^20
 ;;^UTILITY(U,$J,358.3,1457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1457,1,3,0)
 ;;=3^Medical Certificate Issue NEC
 ;;^UTILITY(U,$J,358.3,1457,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,1457,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,1458,0)
 ;;=Z02.1^^8^136^9
 ;;^UTILITY(U,$J,358.3,1458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1458,1,3,0)
 ;;=3^Exam for Employment
 ;;^UTILITY(U,$J,358.3,1458,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,1458,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,1459,0)
 ;;=Z13.5^^8^136^13
 ;;^UTILITY(U,$J,358.3,1459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1459,1,3,0)
 ;;=3^Eye/Ear Disorder Screening
 ;;^UTILITY(U,$J,358.3,1459,1,4,0)
 ;;=4^Z13.5
 ;;^UTILITY(U,$J,358.3,1459,2)
 ;;=^5062706
 ;;^UTILITY(U,$J,358.3,1460,0)
 ;;=Z82.2^^8^136^15
 ;;^UTILITY(U,$J,358.3,1460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1460,1,3,0)
 ;;=3^Family history of deafness and hearing loss
 ;;^UTILITY(U,$J,358.3,1460,1,4,0)
 ;;=4^Z82.2
 ;;^UTILITY(U,$J,358.3,1460,2)
 ;;=^5063366
 ;;^UTILITY(U,$J,358.3,1461,0)
 ;;=Z83.52^^8^136^16
 ;;^UTILITY(U,$J,358.3,1461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1461,1,3,0)
 ;;=3^Family history of ear disorders
 ;;^UTILITY(U,$J,358.3,1461,1,4,0)
 ;;=4^Z83.52
 ;;^UTILITY(U,$J,358.3,1461,2)
 ;;=^5063384
 ;;^UTILITY(U,$J,358.3,1462,0)
 ;;=Z91.81^^8^136^18
 ;;^UTILITY(U,$J,358.3,1462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1462,1,3,0)
 ;;=3^History of falling
 ;;^UTILITY(U,$J,358.3,1462,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,1462,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,1463,0)
 ;;=Z76.5^^8^136^19
 ;;^UTILITY(U,$J,358.3,1463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1463,1,3,0)
 ;;=3^Malingerer [conscious simulation]
 ;;^UTILITY(U,$J,358.3,1463,1,4,0)
 ;;=4^Z76.5
 ;;^UTILITY(U,$J,358.3,1463,2)
 ;;=^5063302
 ;;^UTILITY(U,$J,358.3,1464,0)
 ;;=Z53.09^^8^136^21
 ;;^UTILITY(U,$J,358.3,1464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1464,1,3,0)
 ;;=3^Proc/trtmt not crd out bec of contraindication
 ;;^UTILITY(U,$J,358.3,1464,1,4,0)
 ;;=4^Z53.09
 ;;^UTILITY(U,$J,358.3,1464,2)
 ;;=^5063093
 ;;^UTILITY(U,$J,358.3,1465,0)
 ;;=Z53.29^^8^136^23
 ;;^UTILITY(U,$J,358.3,1465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1465,1,3,0)
 ;;=3^Proc/trtmt not crd out bec pt decision for oth reasons
 ;;^UTILITY(U,$J,358.3,1465,1,4,0)
 ;;=4^Z53.29
 ;;^UTILITY(U,$J,358.3,1465,2)
 ;;=^5063097
 ;;^UTILITY(U,$J,358.3,1466,0)
 ;;=Z53.1^^8^136^22
 ;;^UTILITY(U,$J,358.3,1466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1466,1,3,0)
 ;;=3^Proc/trtmt not crd out bec pt belief and group pressure
 ;;^UTILITY(U,$J,358.3,1466,1,4,0)
 ;;=4^Z53.1
 ;;^UTILITY(U,$J,358.3,1466,2)
 ;;=^5063094
 ;;^UTILITY(U,$J,358.3,1467,0)
 ;;=Z53.21^^8^136^25
 ;;^UTILITY(U,$J,358.3,1467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1467,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t pt lv bef seen by hlth care prov
