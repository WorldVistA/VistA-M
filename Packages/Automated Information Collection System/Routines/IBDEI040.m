IBDEI040 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1441,1,3,0)
 ;;=3^Underdosing of unspecified systemic antibiotic, init encntr
 ;;^UTILITY(U,$J,358.3,1441,1,4,0)
 ;;=4^T36.96XA
 ;;^UTILITY(U,$J,358.3,1441,2)
 ;;=^5049433
 ;;^UTILITY(U,$J,358.3,1442,0)
 ;;=T36.96XD^^8^135^90
 ;;^UTILITY(U,$J,358.3,1442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1442,1,3,0)
 ;;=3^Underdosing of unspecified systemic antibiotic, subs encntr
 ;;^UTILITY(U,$J,358.3,1442,1,4,0)
 ;;=4^T36.96XD
 ;;^UTILITY(U,$J,358.3,1442,2)
 ;;=^5049434
 ;;^UTILITY(U,$J,358.3,1443,0)
 ;;=T36.96XS^^8^135^91
 ;;^UTILITY(U,$J,358.3,1443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1443,1,3,0)
 ;;=3^Underdosing of unspecified systemic antibiotic, sequela
 ;;^UTILITY(U,$J,358.3,1443,1,4,0)
 ;;=4^T36.96XS
 ;;^UTILITY(U,$J,358.3,1443,2)
 ;;=^5049435
 ;;^UTILITY(U,$J,358.3,1444,0)
 ;;=Z45.320^^8^136^1
 ;;^UTILITY(U,$J,358.3,1444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1444,1,3,0)
 ;;=3^Adjust/Mgmt of Bone Conduction Device
 ;;^UTILITY(U,$J,358.3,1444,1,4,0)
 ;;=4^Z45.320
 ;;^UTILITY(U,$J,358.3,1444,2)
 ;;=^5063001
 ;;^UTILITY(U,$J,358.3,1445,0)
 ;;=Z45.321^^8^136^2
 ;;^UTILITY(U,$J,358.3,1445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1445,1,3,0)
 ;;=3^Adjust/Mgmt of Cochlear Device
 ;;^UTILITY(U,$J,358.3,1445,1,4,0)
 ;;=4^Z45.321
 ;;^UTILITY(U,$J,358.3,1445,2)
 ;;=^5063002
 ;;^UTILITY(U,$J,358.3,1446,0)
 ;;=Z45.328^^8^136^3
 ;;^UTILITY(U,$J,358.3,1446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1446,1,3,0)
 ;;=3^Adjust/Mgmt of Implanted Hearing Device
 ;;^UTILITY(U,$J,358.3,1446,1,4,0)
 ;;=4^Z45.328
 ;;^UTILITY(U,$J,358.3,1446,2)
 ;;=^5063003
 ;;^UTILITY(U,$J,358.3,1447,0)
 ;;=Z02.0^^8^136^6
 ;;^UTILITY(U,$J,358.3,1447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1447,1,3,0)
 ;;=3^Exam for Admission to Educational Institution
 ;;^UTILITY(U,$J,358.3,1447,1,4,0)
 ;;=4^Z02.0
 ;;^UTILITY(U,$J,358.3,1447,2)
 ;;=^5062633
 ;;^UTILITY(U,$J,358.3,1448,0)
 ;;=Z02.2^^8^136^7
 ;;^UTILITY(U,$J,358.3,1448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1448,1,3,0)
 ;;=3^Exam for Admission to Residential Institution
 ;;^UTILITY(U,$J,358.3,1448,1,4,0)
 ;;=4^Z02.2
 ;;^UTILITY(U,$J,358.3,1448,2)
 ;;=^5062635
 ;;^UTILITY(U,$J,358.3,1449,0)
 ;;=Z02.4^^8^136^8
 ;;^UTILITY(U,$J,358.3,1449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1449,1,3,0)
 ;;=3^Exam for Driving License
 ;;^UTILITY(U,$J,358.3,1449,1,4,0)
 ;;=4^Z02.4
 ;;^UTILITY(U,$J,358.3,1449,2)
 ;;=^5062637
 ;;^UTILITY(U,$J,358.3,1450,0)
 ;;=Z02.6^^8^136^10
 ;;^UTILITY(U,$J,358.3,1450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1450,1,3,0)
 ;;=3^Exam for Insurance Purposes
 ;;^UTILITY(U,$J,358.3,1450,1,4,0)
 ;;=4^Z02.6
 ;;^UTILITY(U,$J,358.3,1450,2)
 ;;=^5062639
 ;;^UTILITY(U,$J,358.3,1451,0)
 ;;=Z02.5^^8^136^12
 ;;^UTILITY(U,$J,358.3,1451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1451,1,3,0)
 ;;=3^Exam for Sport Participation
 ;;^UTILITY(U,$J,358.3,1451,1,4,0)
 ;;=4^Z02.5
 ;;^UTILITY(U,$J,358.3,1451,2)
 ;;=^5062638
 ;;^UTILITY(U,$J,358.3,1452,0)
 ;;=Z02.3^^8^136^11
 ;;^UTILITY(U,$J,358.3,1452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1452,1,3,0)
 ;;=3^Exam for Recruitment to Armed Forces
 ;;^UTILITY(U,$J,358.3,1452,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,1452,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,1453,0)
 ;;=Z01.118^^8^136^4
 ;;^UTILITY(U,$J,358.3,1453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1453,1,3,0)
 ;;=3^Ears/Hearing Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,1453,1,4,0)
 ;;=4^Z01.118
 ;;^UTILITY(U,$J,358.3,1453,2)
 ;;=^5062616
 ;;^UTILITY(U,$J,358.3,1454,0)
 ;;=Z01.10^^8^136^5
 ;;^UTILITY(U,$J,358.3,1454,1,0)
 ;;=^358.31IA^4^2
