IBDEI24L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35686,1,3,0)
 ;;=3^Uterine size-date discrepancy, first trimester
 ;;^UTILITY(U,$J,358.3,35686,1,4,0)
 ;;=4^O26.841
 ;;^UTILITY(U,$J,358.3,35686,2)
 ;;=^5016345
 ;;^UTILITY(U,$J,358.3,35687,0)
 ;;=O26.842^^166^1825^29
 ;;^UTILITY(U,$J,358.3,35687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35687,1,3,0)
 ;;=3^Uterine size-date discrepancy, second trimester
 ;;^UTILITY(U,$J,358.3,35687,1,4,0)
 ;;=4^O26.842
 ;;^UTILITY(U,$J,358.3,35687,2)
 ;;=^5016346
 ;;^UTILITY(U,$J,358.3,35688,0)
 ;;=O26.843^^166^1825^30
 ;;^UTILITY(U,$J,358.3,35688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35688,1,3,0)
 ;;=3^Uterine size-date discrepancy, third trimester
 ;;^UTILITY(U,$J,358.3,35688,1,4,0)
 ;;=4^O26.843
 ;;^UTILITY(U,$J,358.3,35688,2)
 ;;=^5016347
 ;;^UTILITY(U,$J,358.3,35689,0)
 ;;=O26.872^^166^1825^6
 ;;^UTILITY(U,$J,358.3,35689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35689,1,3,0)
 ;;=3^Cervical shortening, second trimester
 ;;^UTILITY(U,$J,358.3,35689,1,4,0)
 ;;=4^O26.872
 ;;^UTILITY(U,$J,358.3,35689,2)
 ;;=^5016354
 ;;^UTILITY(U,$J,358.3,35690,0)
 ;;=O26.873^^166^1825^7
 ;;^UTILITY(U,$J,358.3,35690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35690,1,3,0)
 ;;=3^Cervical shortening, third trimester
 ;;^UTILITY(U,$J,358.3,35690,1,4,0)
 ;;=4^O26.873
 ;;^UTILITY(U,$J,358.3,35690,2)
 ;;=^5016355
 ;;^UTILITY(U,$J,358.3,35691,0)
 ;;=O30.001^^166^1826^77
 ;;^UTILITY(U,$J,358.3,35691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35691,1,3,0)
 ;;=3^Twin pregnancy, unsp num plcnta & amnio sacs, first trimester
 ;;^UTILITY(U,$J,358.3,35691,1,4,0)
 ;;=4^O30.001
 ;;^UTILITY(U,$J,358.3,35691,2)
 ;;=^5016429
 ;;^UTILITY(U,$J,358.3,35692,0)
 ;;=O30.002^^166^1826^78
 ;;^UTILITY(U,$J,358.3,35692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35692,1,3,0)
 ;;=3^Twin pregnancy, unsp num plcnta & amnio sacs, second trimester
 ;;^UTILITY(U,$J,358.3,35692,1,4,0)
 ;;=4^O30.002
 ;;^UTILITY(U,$J,358.3,35692,2)
 ;;=^5016430
 ;;^UTILITY(U,$J,358.3,35693,0)
 ;;=O30.003^^166^1826^79
 ;;^UTILITY(U,$J,358.3,35693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35693,1,3,0)
 ;;=3^Twin pregnancy, unsp num plcnta & amnio sacs, third trimester
 ;;^UTILITY(U,$J,358.3,35693,1,4,0)
 ;;=4^O30.003
 ;;^UTILITY(U,$J,358.3,35693,2)
 ;;=^5016431
 ;;^UTILITY(U,$J,358.3,35694,0)
 ;;=O30.011^^166^1826^71
 ;;^UTILITY(U,$J,358.3,35694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35694,1,3,0)
 ;;=3^Twin pregnancy, monochorionic/monoamniotic, first trimester
 ;;^UTILITY(U,$J,358.3,35694,1,4,0)
 ;;=4^O30.011
 ;;^UTILITY(U,$J,358.3,35694,2)
 ;;=^5016432
 ;;^UTILITY(U,$J,358.3,35695,0)
 ;;=O30.012^^166^1826^72
 ;;^UTILITY(U,$J,358.3,35695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35695,1,3,0)
 ;;=3^Twin pregnancy, monochorionic/monoamniotic, second trimester
 ;;^UTILITY(U,$J,358.3,35695,1,4,0)
 ;;=4^O30.012
 ;;^UTILITY(U,$J,358.3,35695,2)
 ;;=^5016433
 ;;^UTILITY(U,$J,358.3,35696,0)
 ;;=O30.013^^166^1826^73
 ;;^UTILITY(U,$J,358.3,35696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35696,1,3,0)
 ;;=3^Twin pregnancy, monochorionic/monoamniotic, third trimester
 ;;^UTILITY(U,$J,358.3,35696,1,4,0)
 ;;=4^O30.013
 ;;^UTILITY(U,$J,358.3,35696,2)
 ;;=^5016434
 ;;^UTILITY(U,$J,358.3,35697,0)
 ;;=O30.021^^166^1826^1
 ;;^UTILITY(U,$J,358.3,35697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35697,1,3,0)
 ;;=3^Conjoined twin pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,35697,1,4,0)
 ;;=4^O30.021
 ;;^UTILITY(U,$J,358.3,35697,2)
 ;;=^5016436
 ;;^UTILITY(U,$J,358.3,35698,0)
 ;;=O30.022^^166^1826^2
 ;;^UTILITY(U,$J,358.3,35698,1,0)
 ;;=^358.31IA^4^2
