IBDEI1P9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28888,1,4,0)
 ;;=4^O24.112
 ;;^UTILITY(U,$J,358.3,28888,2)
 ;;=^5016262
 ;;^UTILITY(U,$J,358.3,28889,0)
 ;;=O24.113^^115^1452^65
 ;;^UTILITY(U,$J,358.3,28889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28889,1,3,0)
 ;;=3^Pre-existing diabetes, type 2, in pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28889,1,4,0)
 ;;=4^O24.113
 ;;^UTILITY(U,$J,358.3,28889,2)
 ;;=^5016263
 ;;^UTILITY(U,$J,358.3,28890,0)
 ;;=O24.03^^115^1452^60
 ;;^UTILITY(U,$J,358.3,28890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28890,1,3,0)
 ;;=3^Pre-existing diabetes mellitus, type 1, in the puerperium
 ;;^UTILITY(U,$J,358.3,28890,1,4,0)
 ;;=4^O24.03
 ;;^UTILITY(U,$J,358.3,28890,2)
 ;;=^5016260
 ;;^UTILITY(U,$J,358.3,28891,0)
 ;;=O24.13^^115^1452^61
 ;;^UTILITY(U,$J,358.3,28891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28891,1,3,0)
 ;;=3^Pre-existing diabetes mellitus, type 2, in the puerperium
 ;;^UTILITY(U,$J,358.3,28891,1,4,0)
 ;;=4^O24.13
 ;;^UTILITY(U,$J,358.3,28891,2)
 ;;=^5016266
 ;;^UTILITY(U,$J,358.3,28892,0)
 ;;=O99.281^^115^1452^16
 ;;^UTILITY(U,$J,358.3,28892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28892,1,3,0)
 ;;=3^Endo, nutritional and metab diseases comp preg, first tri
 ;;^UTILITY(U,$J,358.3,28892,1,4,0)
 ;;=4^O99.281
 ;;^UTILITY(U,$J,358.3,28892,2)
 ;;=^5017935
 ;;^UTILITY(U,$J,358.3,28893,0)
 ;;=O99.282^^115^1452^17
 ;;^UTILITY(U,$J,358.3,28893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28893,1,3,0)
 ;;=3^Endo, nutritional and metab diseases comp preg, second tri
 ;;^UTILITY(U,$J,358.3,28893,1,4,0)
 ;;=4^O99.282
 ;;^UTILITY(U,$J,358.3,28893,2)
 ;;=^5017936
 ;;^UTILITY(U,$J,358.3,28894,0)
 ;;=O99.283^^115^1452^18
 ;;^UTILITY(U,$J,358.3,28894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28894,1,3,0)
 ;;=3^Endo, nutritional and metab diseases comp preg, third tri
 ;;^UTILITY(U,$J,358.3,28894,1,4,0)
 ;;=4^O99.283
 ;;^UTILITY(U,$J,358.3,28894,2)
 ;;=^5017937
 ;;^UTILITY(U,$J,358.3,28895,0)
 ;;=O99.285^^115^1452^19
 ;;^UTILITY(U,$J,358.3,28895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28895,1,3,0)
 ;;=3^Endocrine, nutritional and metabolic diseases comp the puerp
 ;;^UTILITY(U,$J,358.3,28895,1,4,0)
 ;;=4^O99.285
 ;;^UTILITY(U,$J,358.3,28895,2)
 ;;=^5017939
 ;;^UTILITY(U,$J,358.3,28896,0)
 ;;=O99.011^^115^1452^3
 ;;^UTILITY(U,$J,358.3,28896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28896,1,3,0)
 ;;=3^Anemia complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28896,1,4,0)
 ;;=4^O99.011
 ;;^UTILITY(U,$J,358.3,28896,2)
 ;;=^5017916
 ;;^UTILITY(U,$J,358.3,28897,0)
 ;;=O99.012^^115^1452^4
 ;;^UTILITY(U,$J,358.3,28897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28897,1,3,0)
 ;;=3^Anemia complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28897,1,4,0)
 ;;=4^O99.012
 ;;^UTILITY(U,$J,358.3,28897,2)
 ;;=^5017917
 ;;^UTILITY(U,$J,358.3,28898,0)
 ;;=O99.013^^115^1452^5
 ;;^UTILITY(U,$J,358.3,28898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28898,1,3,0)
 ;;=3^Anemia complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28898,1,4,0)
 ;;=4^O99.013
 ;;^UTILITY(U,$J,358.3,28898,2)
 ;;=^5017918
 ;;^UTILITY(U,$J,358.3,28899,0)
 ;;=O99.03^^115^1452^6
 ;;^UTILITY(U,$J,358.3,28899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28899,1,3,0)
 ;;=3^Anemia complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28899,1,4,0)
 ;;=4^O99.03
 ;;^UTILITY(U,$J,358.3,28899,2)
 ;;=^5017921
 ;;^UTILITY(U,$J,358.3,28900,0)
 ;;=O99.321^^115^1452^12
 ;;^UTILITY(U,$J,358.3,28900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28900,1,3,0)
 ;;=3^Drug use complicating pregnancy, first trimester
