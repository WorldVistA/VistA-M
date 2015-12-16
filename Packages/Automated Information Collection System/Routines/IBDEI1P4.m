IBDEI1P4 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30079,0)
 ;;=O24.011^^178^1913^62
 ;;^UTILITY(U,$J,358.3,30079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30079,1,3,0)
 ;;=3^Pre-existing diabetes, type 1, in pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,30079,1,4,0)
 ;;=4^O24.011
 ;;^UTILITY(U,$J,358.3,30079,2)
 ;;=^5016255
 ;;^UTILITY(U,$J,358.3,30080,0)
 ;;=O24.012^^178^1913^58
 ;;^UTILITY(U,$J,358.3,30080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30080,1,3,0)
 ;;=3^Pre-exist diabetes, type 1, in pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,30080,1,4,0)
 ;;=4^O24.012
 ;;^UTILITY(U,$J,358.3,30080,2)
 ;;=^5016256
 ;;^UTILITY(U,$J,358.3,30081,0)
 ;;=O24.013^^178^1913^63
 ;;^UTILITY(U,$J,358.3,30081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30081,1,3,0)
 ;;=3^Pre-existing diabetes, type 1, in pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,30081,1,4,0)
 ;;=4^O24.013
 ;;^UTILITY(U,$J,358.3,30081,2)
 ;;=^5016257
 ;;^UTILITY(U,$J,358.3,30082,0)
 ;;=O24.111^^178^1913^64
 ;;^UTILITY(U,$J,358.3,30082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30082,1,3,0)
 ;;=3^Pre-existing diabetes, type 2, in pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,30082,1,4,0)
 ;;=4^O24.111
 ;;^UTILITY(U,$J,358.3,30082,2)
 ;;=^5016261
 ;;^UTILITY(U,$J,358.3,30083,0)
 ;;=O24.112^^178^1913^59
 ;;^UTILITY(U,$J,358.3,30083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30083,1,3,0)
 ;;=3^Pre-exist diabetes, type 2, in pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,30083,1,4,0)
 ;;=4^O24.112
 ;;^UTILITY(U,$J,358.3,30083,2)
 ;;=^5016262
 ;;^UTILITY(U,$J,358.3,30084,0)
 ;;=O24.113^^178^1913^65
 ;;^UTILITY(U,$J,358.3,30084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30084,1,3,0)
 ;;=3^Pre-existing diabetes, type 2, in pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,30084,1,4,0)
 ;;=4^O24.113
 ;;^UTILITY(U,$J,358.3,30084,2)
 ;;=^5016263
 ;;^UTILITY(U,$J,358.3,30085,0)
 ;;=O24.03^^178^1913^60
 ;;^UTILITY(U,$J,358.3,30085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30085,1,3,0)
 ;;=3^Pre-existing diabetes mellitus, type 1, in the puerperium
 ;;^UTILITY(U,$J,358.3,30085,1,4,0)
 ;;=4^O24.03
 ;;^UTILITY(U,$J,358.3,30085,2)
 ;;=^5016260
 ;;^UTILITY(U,$J,358.3,30086,0)
 ;;=O24.13^^178^1913^61
 ;;^UTILITY(U,$J,358.3,30086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30086,1,3,0)
 ;;=3^Pre-existing diabetes mellitus, type 2, in the puerperium
 ;;^UTILITY(U,$J,358.3,30086,1,4,0)
 ;;=4^O24.13
 ;;^UTILITY(U,$J,358.3,30086,2)
 ;;=^5016266
 ;;^UTILITY(U,$J,358.3,30087,0)
 ;;=O99.281^^178^1913^16
 ;;^UTILITY(U,$J,358.3,30087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30087,1,3,0)
 ;;=3^Endo, nutritional and metab diseases comp preg, first tri
 ;;^UTILITY(U,$J,358.3,30087,1,4,0)
 ;;=4^O99.281
 ;;^UTILITY(U,$J,358.3,30087,2)
 ;;=^5017935
 ;;^UTILITY(U,$J,358.3,30088,0)
 ;;=O99.282^^178^1913^17
 ;;^UTILITY(U,$J,358.3,30088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30088,1,3,0)
 ;;=3^Endo, nutritional and metab diseases comp preg, second tri
 ;;^UTILITY(U,$J,358.3,30088,1,4,0)
 ;;=4^O99.282
 ;;^UTILITY(U,$J,358.3,30088,2)
 ;;=^5017936
 ;;^UTILITY(U,$J,358.3,30089,0)
 ;;=O99.283^^178^1913^18
 ;;^UTILITY(U,$J,358.3,30089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30089,1,3,0)
 ;;=3^Endo, nutritional and metab diseases comp preg, third tri
 ;;^UTILITY(U,$J,358.3,30089,1,4,0)
 ;;=4^O99.283
 ;;^UTILITY(U,$J,358.3,30089,2)
 ;;=^5017937
 ;;^UTILITY(U,$J,358.3,30090,0)
 ;;=O99.285^^178^1913^19
 ;;^UTILITY(U,$J,358.3,30090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30090,1,3,0)
 ;;=3^Endocrine, nutritional and metabolic diseases comp the puerp
