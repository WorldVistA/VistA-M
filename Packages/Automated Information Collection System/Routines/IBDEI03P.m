IBDEI03P ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1398,1,3,0)
 ;;=3^Visceral Selective
 ;;^UTILITY(U,$J,358.3,1399,0)
 ;;=75731^^14^132^4^^^^1
 ;;^UTILITY(U,$J,358.3,1399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1399,1,2,0)
 ;;=2^75731
 ;;^UTILITY(U,$J,358.3,1399,1,3,0)
 ;;=3^Adrenal Unilat Selective
 ;;^UTILITY(U,$J,358.3,1400,0)
 ;;=75733^^14^132^3^^^^1
 ;;^UTILITY(U,$J,358.3,1400,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1400,1,2,0)
 ;;=2^75733
 ;;^UTILITY(U,$J,358.3,1400,1,3,0)
 ;;=3^Adrenal Bilat Selective
 ;;^UTILITY(U,$J,358.3,1401,0)
 ;;=75736^^14^132^29^^^^1
 ;;^UTILITY(U,$J,358.3,1401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1401,1,2,0)
 ;;=2^75736
 ;;^UTILITY(U,$J,358.3,1401,1,3,0)
 ;;=3^Pelvic Selective
 ;;^UTILITY(U,$J,358.3,1402,0)
 ;;=75741^^14^132^36^^^^1
 ;;^UTILITY(U,$J,358.3,1402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1402,1,2,0)
 ;;=2^75741
 ;;^UTILITY(U,$J,358.3,1402,1,3,0)
 ;;=3^Pulmonary Unilat Selective
 ;;^UTILITY(U,$J,358.3,1403,0)
 ;;=75743^^14^132^34^^^^1
 ;;^UTILITY(U,$J,358.3,1403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1403,1,2,0)
 ;;=2^75743
 ;;^UTILITY(U,$J,358.3,1403,1,3,0)
 ;;=3^Pulmonary Bilat Selective
 ;;^UTILITY(U,$J,358.3,1404,0)
 ;;=75746^^14^132^35^^^^1
 ;;^UTILITY(U,$J,358.3,1404,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1404,1,2,0)
 ;;=2^75746
 ;;^UTILITY(U,$J,358.3,1404,1,3,0)
 ;;=3^Pulmonary By Nonselective
 ;;^UTILITY(U,$J,358.3,1405,0)
 ;;=75756^^14^132^26^^^^1
 ;;^UTILITY(U,$J,358.3,1405,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1405,1,2,0)
 ;;=2^75756
 ;;^UTILITY(U,$J,358.3,1405,1,3,0)
 ;;=3^Internal Mammary
 ;;^UTILITY(U,$J,358.3,1406,0)
 ;;=37250^^14^132^27^^^^1
 ;;^UTILITY(U,$J,358.3,1406,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1406,1,2,0)
 ;;=2^37250
 ;;^UTILITY(U,$J,358.3,1406,1,3,0)
 ;;=3^Intravas Us,Non/Cor,Diag/Thera Interv, Each Ves
 ;;^UTILITY(U,$J,358.3,1407,0)
 ;;=35475^^14^132^30^^^^1
 ;;^UTILITY(U,$J,358.3,1407,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1407,1,2,0)
 ;;=2^35475
 ;;^UTILITY(U,$J,358.3,1407,1,3,0)
 ;;=3^Perc Angioplasty, Brachioceph Trunk/Branch, Each
 ;;^UTILITY(U,$J,358.3,1408,0)
 ;;=35471^^14^132^31^^^^1
 ;;^UTILITY(U,$J,358.3,1408,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1408,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,1408,1,3,0)
 ;;=3^Perc Angioplasty, Renal/Visc
 ;;^UTILITY(U,$J,358.3,1409,0)
 ;;=36215^^14^132^42^^^^1
 ;;^UTILITY(U,$J,358.3,1409,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1409,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,1409,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,1410,0)
 ;;=36011^^14^132^43^^^^1
 ;;^UTILITY(U,$J,358.3,1410,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1410,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1410,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jugular)
 ;;^UTILITY(U,$J,358.3,1411,0)
 ;;=36245^^14^132^39^^^^1
 ;;^UTILITY(U,$J,358.3,1411,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1411,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,1411,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,1412,0)
 ;;=36246^^14^132^40^^^^1
 ;;^UTILITY(U,$J,358.3,1412,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1412,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,1412,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,1413,0)
 ;;=36247^^14^132^41^^^^1
 ;;^UTILITY(U,$J,358.3,1413,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1413,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,1413,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,1414,0)
 ;;=75962^^14^132^59^^^^1
