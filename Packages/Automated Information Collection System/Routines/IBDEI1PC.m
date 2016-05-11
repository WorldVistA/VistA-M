IBDEI1PC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28925,1,3,0)
 ;;=3^Diseases of the nervous sys comp pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28925,1,4,0)
 ;;=4^O99.351
 ;;^UTILITY(U,$J,358.3,28925,2)
 ;;=^5017965
 ;;^UTILITY(U,$J,358.3,28926,0)
 ;;=O99.352^^115^1453^11
 ;;^UTILITY(U,$J,358.3,28926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28926,1,3,0)
 ;;=3^Diseases of the nervous sys comp pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28926,1,4,0)
 ;;=4^O99.352
 ;;^UTILITY(U,$J,358.3,28926,2)
 ;;=^5017966
 ;;^UTILITY(U,$J,358.3,28927,0)
 ;;=O99.353^^115^1453^12
 ;;^UTILITY(U,$J,358.3,28927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28927,1,3,0)
 ;;=3^Diseases of the nervous sys comp pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28927,1,4,0)
 ;;=4^O99.353
 ;;^UTILITY(U,$J,358.3,28927,2)
 ;;=^5017967
 ;;^UTILITY(U,$J,358.3,28928,0)
 ;;=O26.851^^115^1453^24
 ;;^UTILITY(U,$J,358.3,28928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28928,1,3,0)
 ;;=3^Spotting complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28928,1,4,0)
 ;;=4^O26.851
 ;;^UTILITY(U,$J,358.3,28928,2)
 ;;=^5016349
 ;;^UTILITY(U,$J,358.3,28929,0)
 ;;=O26.852^^115^1453^25
 ;;^UTILITY(U,$J,358.3,28929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28929,1,3,0)
 ;;=3^Spotting complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28929,1,4,0)
 ;;=4^O26.852
 ;;^UTILITY(U,$J,358.3,28929,2)
 ;;=^5016350
 ;;^UTILITY(U,$J,358.3,28930,0)
 ;;=O26.853^^115^1453^26
 ;;^UTILITY(U,$J,358.3,28930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28930,1,3,0)
 ;;=3^Spotting complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28930,1,4,0)
 ;;=4^O26.853
 ;;^UTILITY(U,$J,358.3,28930,2)
 ;;=^5016351
 ;;^UTILITY(U,$J,358.3,28931,0)
 ;;=O26.841^^115^1453^28
 ;;^UTILITY(U,$J,358.3,28931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28931,1,3,0)
 ;;=3^Uterine size-date discrepancy, first trimester
 ;;^UTILITY(U,$J,358.3,28931,1,4,0)
 ;;=4^O26.841
 ;;^UTILITY(U,$J,358.3,28931,2)
 ;;=^5016345
 ;;^UTILITY(U,$J,358.3,28932,0)
 ;;=O26.842^^115^1453^29
 ;;^UTILITY(U,$J,358.3,28932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28932,1,3,0)
 ;;=3^Uterine size-date discrepancy, second trimester
 ;;^UTILITY(U,$J,358.3,28932,1,4,0)
 ;;=4^O26.842
 ;;^UTILITY(U,$J,358.3,28932,2)
 ;;=^5016346
 ;;^UTILITY(U,$J,358.3,28933,0)
 ;;=O26.843^^115^1453^30
 ;;^UTILITY(U,$J,358.3,28933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28933,1,3,0)
 ;;=3^Uterine size-date discrepancy, third trimester
 ;;^UTILITY(U,$J,358.3,28933,1,4,0)
 ;;=4^O26.843
 ;;^UTILITY(U,$J,358.3,28933,2)
 ;;=^5016347
 ;;^UTILITY(U,$J,358.3,28934,0)
 ;;=O26.872^^115^1453^6
 ;;^UTILITY(U,$J,358.3,28934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28934,1,3,0)
 ;;=3^Cervical shortening, second trimester
 ;;^UTILITY(U,$J,358.3,28934,1,4,0)
 ;;=4^O26.872
 ;;^UTILITY(U,$J,358.3,28934,2)
 ;;=^5016354
 ;;^UTILITY(U,$J,358.3,28935,0)
 ;;=O26.873^^115^1453^7
 ;;^UTILITY(U,$J,358.3,28935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28935,1,3,0)
 ;;=3^Cervical shortening, third trimester
 ;;^UTILITY(U,$J,358.3,28935,1,4,0)
 ;;=4^O26.873
 ;;^UTILITY(U,$J,358.3,28935,2)
 ;;=^5016355
 ;;^UTILITY(U,$J,358.3,28936,0)
 ;;=O30.001^^115^1454^77
 ;;^UTILITY(U,$J,358.3,28936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28936,1,3,0)
 ;;=3^Twin pregnancy, unsp num plcnta & amnio sacs, first trimester
 ;;^UTILITY(U,$J,358.3,28936,1,4,0)
 ;;=4^O30.001
 ;;^UTILITY(U,$J,358.3,28936,2)
 ;;=^5016429
 ;;^UTILITY(U,$J,358.3,28937,0)
 ;;=O30.002^^115^1454^78
