IBDEI04D ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1516,1,3,0)
 ;;=3^Alzheimer's disease, unspecified
 ;;^UTILITY(U,$J,358.3,1516,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,1516,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,1517,0)
 ;;=G47.00^^3^44^13
 ;;^UTILITY(U,$J,358.3,1517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1517,1,3,0)
 ;;=3^Insomnia, unspecified
 ;;^UTILITY(U,$J,358.3,1517,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,1517,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,1518,0)
 ;;=Z86.59^^3^44^21
 ;;^UTILITY(U,$J,358.3,1518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1518,1,3,0)
 ;;=3^Personal history of other mental and behavioral disorders
 ;;^UTILITY(U,$J,358.3,1518,1,4,0)
 ;;=4^Z86.59
 ;;^UTILITY(U,$J,358.3,1518,2)
 ;;=^5063471
 ;;^UTILITY(U,$J,358.3,1519,0)
 ;;=Z91.19^^3^44^20
 ;;^UTILITY(U,$J,358.3,1519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1519,1,3,0)
 ;;=3^Patient's noncompliance w oth medical treatment and regimen
 ;;^UTILITY(U,$J,358.3,1519,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,1519,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,1520,0)
 ;;=M02.30^^3^45^86
 ;;^UTILITY(U,$J,358.3,1520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1520,1,3,0)
 ;;=3^Reiter's disease, unspecified site
 ;;^UTILITY(U,$J,358.3,1520,1,4,0)
 ;;=4^M02.30
 ;;^UTILITY(U,$J,358.3,1520,2)
 ;;=^5009790
 ;;^UTILITY(U,$J,358.3,1521,0)
 ;;=M10.00^^3^45^39
 ;;^UTILITY(U,$J,358.3,1521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1521,1,3,0)
 ;;=3^Idiopathic gout, unspecified site
 ;;^UTILITY(U,$J,358.3,1521,1,4,0)
 ;;=4^M10.00
 ;;^UTILITY(U,$J,358.3,1521,2)
 ;;=^5010284
 ;;^UTILITY(U,$J,358.3,1522,0)
 ;;=M10.9^^3^45^34
 ;;^UTILITY(U,$J,358.3,1522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1522,1,3,0)
 ;;=3^Gout, unspecified
 ;;^UTILITY(U,$J,358.3,1522,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,1522,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,1523,0)
 ;;=G90.59^^3^45^19
 ;;^UTILITY(U,$J,358.3,1523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1523,1,3,0)
 ;;=3^Complex regional pain syndrome I of other specified site
 ;;^UTILITY(U,$J,358.3,1523,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,1523,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,1524,0)
 ;;=G56.01^^3^45^14
 ;;^UTILITY(U,$J,358.3,1524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1524,1,3,0)
 ;;=3^Carpal tunnel syndrome, right upper limb
 ;;^UTILITY(U,$J,358.3,1524,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,1524,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,1525,0)
 ;;=G56.02^^3^45^13
 ;;^UTILITY(U,$J,358.3,1525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1525,1,3,0)
 ;;=3^Carpal tunnel syndrome, left upper limb
 ;;^UTILITY(U,$J,358.3,1525,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,1525,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,1526,0)
 ;;=G56.21^^3^45^47
 ;;^UTILITY(U,$J,358.3,1526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1526,1,3,0)
 ;;=3^Lesion of ulnar nerve, right upper limb
 ;;^UTILITY(U,$J,358.3,1526,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,1526,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,1527,0)
 ;;=G56.22^^3^45^46
 ;;^UTILITY(U,$J,358.3,1527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1527,1,3,0)
 ;;=3^Lesion of ulnar nerve, left upper limb
 ;;^UTILITY(U,$J,358.3,1527,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,1527,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,1528,0)
 ;;=G60.9^^3^45^35
 ;;^UTILITY(U,$J,358.3,1528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1528,1,3,0)
 ;;=3^Hereditary and idiopathic neuropathy, unspecified
 ;;^UTILITY(U,$J,358.3,1528,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,1528,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,1529,0)
 ;;=M26.60^^3^45^110
 ;;^UTILITY(U,$J,358.3,1529,1,0)
 ;;=^358.31IA^4^2
