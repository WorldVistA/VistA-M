IBDEI050 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1661,1,3,0)
 ;;=3^Blindness Rt Eye,Low Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,1661,1,4,0)
 ;;=4^H54.11
 ;;^UTILITY(U,$J,358.3,1661,2)
 ;;=^5006359
 ;;^UTILITY(U,$J,358.3,1662,0)
 ;;=H54.12^^16^166^5
 ;;^UTILITY(U,$J,358.3,1662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1662,1,3,0)
 ;;=3^Blindness Lt Eye,Low Vision Rt Eye
 ;;^UTILITY(U,$J,358.3,1662,1,4,0)
 ;;=4^H54.12
 ;;^UTILITY(U,$J,358.3,1662,2)
 ;;=^5006360
 ;;^UTILITY(U,$J,358.3,1663,0)
 ;;=H54.2^^16^166^23
 ;;^UTILITY(U,$J,358.3,1663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1663,1,3,0)
 ;;=3^Low Vision,Both Eyes
 ;;^UTILITY(U,$J,358.3,1663,1,4,0)
 ;;=4^H54.2
 ;;^UTILITY(U,$J,358.3,1663,2)
 ;;=^5006361
 ;;^UTILITY(U,$J,358.3,1664,0)
 ;;=H54.40^^16^166^8
 ;;^UTILITY(U,$J,358.3,1664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1664,1,3,0)
 ;;=3^Blindness,One Eye,Unspec Eye
 ;;^UTILITY(U,$J,358.3,1664,1,4,0)
 ;;=4^H54.40
 ;;^UTILITY(U,$J,358.3,1664,2)
 ;;=^5006362
 ;;^UTILITY(U,$J,358.3,1665,0)
 ;;=H54.41^^16^166^7
 ;;^UTILITY(U,$J,358.3,1665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1665,1,3,0)
 ;;=3^Blindness Rt Eye,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,1665,1,4,0)
 ;;=4^H54.41
 ;;^UTILITY(U,$J,358.3,1665,2)
 ;;=^5006363
 ;;^UTILITY(U,$J,358.3,1666,0)
 ;;=H54.51^^16^166^22
 ;;^UTILITY(U,$J,358.3,1666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1666,1,3,0)
 ;;=3^Low Vision Rt Eye,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,1666,1,4,0)
 ;;=4^H54.51
 ;;^UTILITY(U,$J,358.3,1666,2)
 ;;=^5006365
 ;;^UTILITY(U,$J,358.3,1667,0)
 ;;=H54.52^^16^166^21
 ;;^UTILITY(U,$J,358.3,1667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1667,1,3,0)
 ;;=3^Low Vision Lt Eye,Normal Vision Rt Eye
 ;;^UTILITY(U,$J,358.3,1667,1,4,0)
 ;;=4^H54.52
 ;;^UTILITY(U,$J,358.3,1667,2)
 ;;=^5133519
 ;;^UTILITY(U,$J,358.3,1668,0)
 ;;=H54.61^^16^166^33
 ;;^UTILITY(U,$J,358.3,1668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1668,1,3,0)
 ;;=3^Unqualified Visual Loss Rt Eye,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,1668,1,4,0)
 ;;=4^H54.61
 ;;^UTILITY(U,$J,358.3,1668,2)
 ;;=^5006367
 ;;^UTILITY(U,$J,358.3,1669,0)
 ;;=H54.62^^16^166^32
 ;;^UTILITY(U,$J,358.3,1669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1669,1,3,0)
 ;;=3^Unqualified Visual Loss Lt Eye,Normal Vision Rt Eye
 ;;^UTILITY(U,$J,358.3,1669,1,4,0)
 ;;=4^H54.62
 ;;^UTILITY(U,$J,358.3,1669,2)
 ;;=^5133520
 ;;^UTILITY(U,$J,358.3,1670,0)
 ;;=H54.7^^16^166^46
 ;;^UTILITY(U,$J,358.3,1670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1670,1,3,0)
 ;;=3^Visual Loss,Unspec
 ;;^UTILITY(U,$J,358.3,1670,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,1670,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,1671,0)
 ;;=H54.8^^16^166^20
 ;;^UTILITY(U,$J,358.3,1671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1671,1,3,0)
 ;;=3^Legal Blindness,USA Definition
 ;;^UTILITY(U,$J,358.3,1671,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,1671,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,1672,0)
 ;;=H51.11^^16^166^13
 ;;^UTILITY(U,$J,358.3,1672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1672,1,3,0)
 ;;=3^Convergence Insufficiency
 ;;^UTILITY(U,$J,358.3,1672,1,4,0)
 ;;=4^H51.11
 ;;^UTILITY(U,$J,358.3,1672,2)
 ;;=^5006251
 ;;^UTILITY(U,$J,358.3,1673,0)
 ;;=H51.12^^16^166^12
 ;;^UTILITY(U,$J,358.3,1673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1673,1,3,0)
 ;;=3^Convergence Excess
 ;;^UTILITY(U,$J,358.3,1673,1,4,0)
 ;;=4^H51.12
 ;;^UTILITY(U,$J,358.3,1673,2)
 ;;=^5006252
 ;;^UTILITY(U,$J,358.3,1674,0)
 ;;=H51.9^^16^166^1
 ;;^UTILITY(U,$J,358.3,1674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1674,1,3,0)
 ;;=3^Binocular Movement Disorder,Unspec
