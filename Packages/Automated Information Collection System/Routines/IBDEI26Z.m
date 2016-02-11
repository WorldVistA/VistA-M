IBDEI26Z ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36802,1,3,0)
 ;;=3^Hodgkin Lymphoma,Classical,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,36802,1,4,0)
 ;;=4^C81.70
 ;;^UTILITY(U,$J,358.3,36802,2)
 ;;=^5001441
 ;;^UTILITY(U,$J,358.3,36803,0)
 ;;=C81.79^^169^1859^40
 ;;^UTILITY(U,$J,358.3,36803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36803,1,3,0)
 ;;=3^Hodgkin Lymphoma,Classical,Extrnod/Solid Organ Sites NEC
 ;;^UTILITY(U,$J,358.3,36803,1,4,0)
 ;;=4^C81.79
 ;;^UTILITY(U,$J,358.3,36803,2)
 ;;=^5001450
 ;;^UTILITY(U,$J,358.3,36804,0)
 ;;=C82.50^^169^1859^20
 ;;^UTILITY(U,$J,358.3,36804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36804,1,3,0)
 ;;=3^Diffuse Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,36804,1,4,0)
 ;;=4^C82.50
 ;;^UTILITY(U,$J,358.3,36804,2)
 ;;=^5001511
 ;;^UTILITY(U,$J,358.3,36805,0)
 ;;=C82.59^^169^1859^19
 ;;^UTILITY(U,$J,358.3,36805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36805,1,3,0)
 ;;=3^Diffuse Follicle Center Lymphoma,Extrnod/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,36805,1,4,0)
 ;;=4^C82.59
 ;;^UTILITY(U,$J,358.3,36805,2)
 ;;=^5001520
 ;;^UTILITY(U,$J,358.3,36806,0)
 ;;=C82.80^^169^1859^24
 ;;^UTILITY(U,$J,358.3,36806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36806,1,3,0)
 ;;=3^Follicular Lymphoma,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,36806,1,4,0)
 ;;=4^C82.80
 ;;^UTILITY(U,$J,358.3,36806,2)
 ;;=^5001531
 ;;^UTILITY(U,$J,358.3,36807,0)
 ;;=C82.89^^169^1859^23
 ;;^UTILITY(U,$J,358.3,36807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36807,1,3,0)
 ;;=3^Follicular Lymphoma,Extrnod/Solid Organ Sites NEC
 ;;^UTILITY(U,$J,358.3,36807,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,36807,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,36808,0)
 ;;=C83.00^^169^1859^75
 ;;^UTILITY(U,$J,358.3,36808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36808,1,3,0)
 ;;=3^Small Cell B-Cell Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,36808,1,4,0)
 ;;=4^C83.00
 ;;^UTILITY(U,$J,358.3,36808,2)
 ;;=^5001551
 ;;^UTILITY(U,$J,358.3,36809,0)
 ;;=C83.09^^169^1859^74
 ;;^UTILITY(U,$J,358.3,36809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36809,1,3,0)
 ;;=3^Small Cell B-Cell Lymphoma,Extrnod/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,36809,1,4,0)
 ;;=4^C83.09
 ;;^UTILITY(U,$J,358.3,36809,2)
 ;;=^5001560
 ;;^UTILITY(U,$J,358.3,36810,0)
 ;;=C83.30^^169^1859^21
 ;;^UTILITY(U,$J,358.3,36810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36810,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,36810,1,4,0)
 ;;=4^C83.30
 ;;^UTILITY(U,$J,358.3,36810,2)
 ;;=^5001571
 ;;^UTILITY(U,$J,358.3,36811,0)
 ;;=C83.80^^169^1859^66
 ;;^UTILITY(U,$J,358.3,36811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36811,1,3,0)
 ;;=3^Non-Follicular Lymphoma,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,36811,1,4,0)
 ;;=4^C83.80
 ;;^UTILITY(U,$J,358.3,36811,2)
 ;;=^5001601
 ;;^UTILITY(U,$J,358.3,36812,0)
 ;;=C83.89^^169^1859^65
 ;;^UTILITY(U,$J,358.3,36812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36812,1,3,0)
 ;;=3^Non-Follicular Lymphoma,Extrnod/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,36812,1,4,0)
 ;;=4^C83.89
 ;;^UTILITY(U,$J,358.3,36812,2)
 ;;=^5001610
 ;;^UTILITY(U,$J,358.3,36813,0)
 ;;=C83.90^^169^1859^68
 ;;^UTILITY(U,$J,358.3,36813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36813,1,3,0)
 ;;=3^Non-Follicular Lymphoma,Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,36813,1,4,0)
 ;;=4^C83.90
 ;;^UTILITY(U,$J,358.3,36813,2)
 ;;=^5001611
 ;;^UTILITY(U,$J,358.3,36814,0)
 ;;=C83.99^^169^1859^67
 ;;^UTILITY(U,$J,358.3,36814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36814,1,3,0)
 ;;=3^Non-Follicular Lymphoma,Unspec,Extranod/Solid Organ Sites
