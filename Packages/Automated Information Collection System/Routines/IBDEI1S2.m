IBDEI1S2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30209,0)
 ;;=C94.41^^118^1502^6
 ;;^UTILITY(U,$J,358.3,30209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30209,1,3,0)
 ;;=3^Acute panmyelosis with myelofibrosis, in remission
 ;;^UTILITY(U,$J,358.3,30209,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,30209,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,30210,0)
 ;;=C94.40^^118^1502^4
 ;;^UTILITY(U,$J,358.3,30210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30210,1,3,0)
 ;;=3^Acute panmyelosis w myelofibrosis not achieve remission
 ;;^UTILITY(U,$J,358.3,30210,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,30210,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,30211,0)
 ;;=D47.2^^118^1502^55
 ;;^UTILITY(U,$J,358.3,30211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30211,1,3,0)
 ;;=3^Monoclonal gammopathy
 ;;^UTILITY(U,$J,358.3,30211,1,4,0)
 ;;=4^D47.2
 ;;^UTILITY(U,$J,358.3,30211,2)
 ;;=^5002257
 ;;^UTILITY(U,$J,358.3,30212,0)
 ;;=C88.0^^118^1502^76
 ;;^UTILITY(U,$J,358.3,30212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30212,1,3,0)
 ;;=3^Waldenstrom macroglobulinemia
 ;;^UTILITY(U,$J,358.3,30212,1,4,0)
 ;;=4^C88.0
 ;;^UTILITY(U,$J,358.3,30212,2)
 ;;=^5001748
 ;;^UTILITY(U,$J,358.3,30213,0)
 ;;=C81.70^^118^1502^41
 ;;^UTILITY(U,$J,358.3,30213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30213,1,3,0)
 ;;=3^Hodgkin Lymphoma,Classical,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,30213,1,4,0)
 ;;=4^C81.70
 ;;^UTILITY(U,$J,358.3,30213,2)
 ;;=^5001441
 ;;^UTILITY(U,$J,358.3,30214,0)
 ;;=C81.79^^118^1502^40
 ;;^UTILITY(U,$J,358.3,30214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30214,1,3,0)
 ;;=3^Hodgkin Lymphoma,Classical,Extrnod/Solid Organ Sites NEC
 ;;^UTILITY(U,$J,358.3,30214,1,4,0)
 ;;=4^C81.79
 ;;^UTILITY(U,$J,358.3,30214,2)
 ;;=^5001450
 ;;^UTILITY(U,$J,358.3,30215,0)
 ;;=C82.50^^118^1502^20
 ;;^UTILITY(U,$J,358.3,30215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30215,1,3,0)
 ;;=3^Diffuse Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,30215,1,4,0)
 ;;=4^C82.50
 ;;^UTILITY(U,$J,358.3,30215,2)
 ;;=^5001511
 ;;^UTILITY(U,$J,358.3,30216,0)
 ;;=C82.59^^118^1502^19
 ;;^UTILITY(U,$J,358.3,30216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30216,1,3,0)
 ;;=3^Diffuse Follicle Center Lymphoma,Extrnod/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,30216,1,4,0)
 ;;=4^C82.59
 ;;^UTILITY(U,$J,358.3,30216,2)
 ;;=^5001520
 ;;^UTILITY(U,$J,358.3,30217,0)
 ;;=C82.80^^118^1502^24
 ;;^UTILITY(U,$J,358.3,30217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30217,1,3,0)
 ;;=3^Follicular Lymphoma,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,30217,1,4,0)
 ;;=4^C82.80
 ;;^UTILITY(U,$J,358.3,30217,2)
 ;;=^5001531
 ;;^UTILITY(U,$J,358.3,30218,0)
 ;;=C82.89^^118^1502^23
 ;;^UTILITY(U,$J,358.3,30218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30218,1,3,0)
 ;;=3^Follicular Lymphoma,Extrnod/Solid Organ Sites NEC
 ;;^UTILITY(U,$J,358.3,30218,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,30218,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,30219,0)
 ;;=C83.00^^118^1502^75
 ;;^UTILITY(U,$J,358.3,30219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30219,1,3,0)
 ;;=3^Small Cell B-Cell Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,30219,1,4,0)
 ;;=4^C83.00
 ;;^UTILITY(U,$J,358.3,30219,2)
 ;;=^5001551
 ;;^UTILITY(U,$J,358.3,30220,0)
 ;;=C83.09^^118^1502^74
 ;;^UTILITY(U,$J,358.3,30220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30220,1,3,0)
 ;;=3^Small Cell B-Cell Lymphoma,Extrnod/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,30220,1,4,0)
 ;;=4^C83.09
 ;;^UTILITY(U,$J,358.3,30220,2)
 ;;=^5001560
 ;;^UTILITY(U,$J,358.3,30221,0)
 ;;=C83.30^^118^1502^21
 ;;^UTILITY(U,$J,358.3,30221,1,0)
 ;;=^358.31IA^4^2
