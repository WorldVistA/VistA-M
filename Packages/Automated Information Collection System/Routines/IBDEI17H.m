IBDEI17H ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21338,1,3,0)
 ;;=3^Transcath Closure of ASD
 ;;^UTILITY(U,$J,358.3,21339,0)
 ;;=36100^^117^1330^11^^^^1
 ;;^UTILITY(U,$J,358.3,21339,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21339,1,2,0)
 ;;=2^36100
 ;;^UTILITY(U,$J,358.3,21339,1,3,0)
 ;;=3^Intro Needle Or Cath Carotid Or Vert. Artery
 ;;^UTILITY(U,$J,358.3,21340,0)
 ;;=36120^^117^1330^10^^^^1
 ;;^UTILITY(U,$J,358.3,21340,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21340,1,2,0)
 ;;=2^36120
 ;;^UTILITY(U,$J,358.3,21340,1,3,0)
 ;;=3^Intro Needle Or Cath Brachial Artery
 ;;^UTILITY(U,$J,358.3,21341,0)
 ;;=36140^^117^1330^12^^^^1
 ;;^UTILITY(U,$J,358.3,21341,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21341,1,2,0)
 ;;=2^36140
 ;;^UTILITY(U,$J,358.3,21341,1,3,0)
 ;;=3^Intro Needle Or Cath Ext Artery
 ;;^UTILITY(U,$J,358.3,21342,0)
 ;;=36215^^117^1330^40^^^^1
 ;;^UTILITY(U,$J,358.3,21342,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21342,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,21342,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,21343,0)
 ;;=36011^^117^1330^41^^^^1
 ;;^UTILITY(U,$J,358.3,21343,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21343,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,21343,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jug)
 ;;^UTILITY(U,$J,358.3,21344,0)
 ;;=36245^^117^1330^35^^^^1
 ;;^UTILITY(U,$J,358.3,21344,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21344,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,21344,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,21345,0)
 ;;=36246^^117^1330^36^^^^1
 ;;^UTILITY(U,$J,358.3,21345,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21345,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,21345,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,21346,0)
 ;;=36247^^117^1330^38^^^^1
 ;;^UTILITY(U,$J,358.3,21346,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21346,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,21346,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,21347,0)
 ;;=36216^^117^1330^37^^^^1
 ;;^UTILITY(U,$J,358.3,21347,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21347,1,2,0)
 ;;=2^36216
 ;;^UTILITY(U,$J,358.3,21347,1,3,0)
 ;;=3^Select Cath 2nd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,21348,0)
 ;;=36217^^117^1330^39^^^^1
 ;;^UTILITY(U,$J,358.3,21348,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21348,1,2,0)
 ;;=2^36217
 ;;^UTILITY(U,$J,358.3,21348,1,3,0)
 ;;=3^Select Cath 3rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,21349,0)
 ;;=36218^^117^1330^5^^^^1
 ;;^UTILITY(U,$J,358.3,21349,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21349,1,2,0)
 ;;=2^36218
 ;;^UTILITY(U,$J,358.3,21349,1,3,0)
 ;;=3^Each Addl 2nd/3rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,21350,0)
 ;;=36248^^117^1330^4^^^^1
 ;;^UTILITY(U,$J,358.3,21350,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21350,1,2,0)
 ;;=2^36248
 ;;^UTILITY(U,$J,358.3,21350,1,3,0)
 ;;=3^Each Addl 2nd/3rd Order Pelvic/Le
 ;;^UTILITY(U,$J,358.3,21351,0)
 ;;=36200^^117^1330^13^^^^1
 ;;^UTILITY(U,$J,358.3,21351,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21351,1,2,0)
 ;;=2^36200
 ;;^UTILITY(U,$J,358.3,21351,1,3,0)
 ;;=3^Non-Select Cath, Aorta
 ;;^UTILITY(U,$J,358.3,21352,0)
 ;;=33010^^117^1330^56^^^^1
 ;;^UTILITY(U,$J,358.3,21352,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21352,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,21352,1,3,0)
 ;;=3^Visceral Selective
 ;;^UTILITY(U,$J,358.3,21353,0)
 ;;=35471^^117^1330^31^^^^1
 ;;^UTILITY(U,$J,358.3,21353,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21353,1,2,0)
 ;;=2^35471
