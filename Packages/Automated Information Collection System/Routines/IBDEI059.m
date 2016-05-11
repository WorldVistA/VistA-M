IBDEI059 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2074,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,2075,0)
 ;;=36011^^12^167^41^^^^1
 ;;^UTILITY(U,$J,358.3,2075,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2075,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,2075,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jug)
 ;;^UTILITY(U,$J,358.3,2076,0)
 ;;=36245^^12^167^35^^^^1
 ;;^UTILITY(U,$J,358.3,2076,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2076,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,2076,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,2077,0)
 ;;=36246^^12^167^36^^^^1
 ;;^UTILITY(U,$J,358.3,2077,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2077,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,2077,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,2078,0)
 ;;=36247^^12^167^38^^^^1
 ;;^UTILITY(U,$J,358.3,2078,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2078,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,2078,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,2079,0)
 ;;=36216^^12^167^37^^^^1
 ;;^UTILITY(U,$J,358.3,2079,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2079,1,2,0)
 ;;=2^36216
 ;;^UTILITY(U,$J,358.3,2079,1,3,0)
 ;;=3^Select Cath 2nd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,2080,0)
 ;;=36217^^12^167^39^^^^1
 ;;^UTILITY(U,$J,358.3,2080,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2080,1,2,0)
 ;;=2^36217
 ;;^UTILITY(U,$J,358.3,2080,1,3,0)
 ;;=3^Select Cath 3rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,2081,0)
 ;;=36218^^12^167^5^^^^1
 ;;^UTILITY(U,$J,358.3,2081,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2081,1,2,0)
 ;;=2^36218
 ;;^UTILITY(U,$J,358.3,2081,1,3,0)
 ;;=3^Each Addl 2nd/3rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,2082,0)
 ;;=36248^^12^167^4^^^^1
 ;;^UTILITY(U,$J,358.3,2082,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2082,1,2,0)
 ;;=2^36248
 ;;^UTILITY(U,$J,358.3,2082,1,3,0)
 ;;=3^Each Addl 2nd/3rd Order Pelvic/Le
 ;;^UTILITY(U,$J,358.3,2083,0)
 ;;=36200^^12^167^13^^^^1
 ;;^UTILITY(U,$J,358.3,2083,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2083,1,2,0)
 ;;=2^36200
 ;;^UTILITY(U,$J,358.3,2083,1,3,0)
 ;;=3^Non-Select Cath, Aorta
 ;;^UTILITY(U,$J,358.3,2084,0)
 ;;=33010^^12^167^56^^^^1
 ;;^UTILITY(U,$J,358.3,2084,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2084,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,2084,1,3,0)
 ;;=3^Visceral Selective
 ;;^UTILITY(U,$J,358.3,2085,0)
 ;;=35471^^12^167^31^^^^1
 ;;^UTILITY(U,$J,358.3,2085,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2085,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,2085,1,3,0)
 ;;=3^Repair Arterial Blockage
 ;;^UTILITY(U,$J,358.3,2086,0)
 ;;=35475^^12^167^15^^^^1
 ;;^UTILITY(U,$J,358.3,2086,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2086,1,2,0)
 ;;=2^35475
 ;;^UTILITY(U,$J,358.3,2086,1,3,0)
 ;;=3^Pelvic Selective
 ;;^UTILITY(U,$J,358.3,2087,0)
 ;;=36005^^12^167^6^^^^1
 ;;^UTILITY(U,$J,358.3,2087,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2087,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,2087,1,3,0)
 ;;=3^Injection Ext Venography
 ;;^UTILITY(U,$J,358.3,2088,0)
 ;;=36147^^12^167^1^^^^1
 ;;^UTILITY(U,$J,358.3,2088,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2088,1,2,0)
 ;;=2^36147
 ;;^UTILITY(U,$J,358.3,2088,1,3,0)
 ;;=3^Access AV Dial Grft for Eval
 ;;^UTILITY(U,$J,358.3,2089,0)
 ;;=36148^^12^167^2^^^^1
 ;;^UTILITY(U,$J,358.3,2089,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2089,1,2,0)
 ;;=2^36148
 ;;^UTILITY(U,$J,358.3,2089,1,3,0)
 ;;=3^Access AV Dial Grft for Eval,Ea Addl
 ;;^UTILITY(U,$J,358.3,2090,0)
 ;;=36251^^12^167^33^^^^1
