IBDEI03B ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1154,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1154,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1154,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jug)
 ;;^UTILITY(U,$J,358.3,1155,0)
 ;;=36245^^10^110^35^^^^1
 ;;^UTILITY(U,$J,358.3,1155,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1155,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,1155,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1156,0)
 ;;=36246^^10^110^36^^^^1
 ;;^UTILITY(U,$J,358.3,1156,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1156,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,1156,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1157,0)
 ;;=36247^^10^110^38^^^^1
 ;;^UTILITY(U,$J,358.3,1157,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1157,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,1157,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1158,0)
 ;;=36216^^10^110^37^^^^1
 ;;^UTILITY(U,$J,358.3,1158,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1158,1,2,0)
 ;;=2^36216
 ;;^UTILITY(U,$J,358.3,1158,1,3,0)
 ;;=3^Select Cath 2nd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,1159,0)
 ;;=36217^^10^110^39^^^^1
 ;;^UTILITY(U,$J,358.3,1159,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1159,1,2,0)
 ;;=2^36217
 ;;^UTILITY(U,$J,358.3,1159,1,3,0)
 ;;=3^Select Cath 3rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,1160,0)
 ;;=36218^^10^110^5^^^^1
 ;;^UTILITY(U,$J,358.3,1160,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1160,1,2,0)
 ;;=2^36218
 ;;^UTILITY(U,$J,358.3,1160,1,3,0)
 ;;=3^Each Addl 2nd/3rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,1161,0)
 ;;=36248^^10^110^4^^^^1
 ;;^UTILITY(U,$J,358.3,1161,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1161,1,2,0)
 ;;=2^36248
 ;;^UTILITY(U,$J,358.3,1161,1,3,0)
 ;;=3^Each Addl 2nd/3rd Order Pelvic/Le
 ;;^UTILITY(U,$J,358.3,1162,0)
 ;;=36200^^10^110^13^^^^1
 ;;^UTILITY(U,$J,358.3,1162,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1162,1,2,0)
 ;;=2^36200
 ;;^UTILITY(U,$J,358.3,1162,1,3,0)
 ;;=3^Non-Select Cath, Aorta
 ;;^UTILITY(U,$J,358.3,1163,0)
 ;;=33010^^10^110^56^^^^1
 ;;^UTILITY(U,$J,358.3,1163,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1163,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,1163,1,3,0)
 ;;=3^Visceral Selective
 ;;^UTILITY(U,$J,358.3,1164,0)
 ;;=35471^^10^110^31^^^^1
 ;;^UTILITY(U,$J,358.3,1164,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1164,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,1164,1,3,0)
 ;;=3^Repair Arterial Blockage
 ;;^UTILITY(U,$J,358.3,1165,0)
 ;;=35475^^10^110^15^^^^1
 ;;^UTILITY(U,$J,358.3,1165,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1165,1,2,0)
 ;;=2^35475
 ;;^UTILITY(U,$J,358.3,1165,1,3,0)
 ;;=3^Pelvic Selective
 ;;^UTILITY(U,$J,358.3,1166,0)
 ;;=36005^^10^110^6^^^^1
 ;;^UTILITY(U,$J,358.3,1166,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1166,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,1166,1,3,0)
 ;;=3^Injection Ext Venography
 ;;^UTILITY(U,$J,358.3,1167,0)
 ;;=36147^^10^110^1^^^^1
 ;;^UTILITY(U,$J,358.3,1167,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1167,1,2,0)
 ;;=2^36147
 ;;^UTILITY(U,$J,358.3,1167,1,3,0)
 ;;=3^Access AV Dial Grft for Eval
 ;;^UTILITY(U,$J,358.3,1168,0)
 ;;=36148^^10^110^2^^^^1
 ;;^UTILITY(U,$J,358.3,1168,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1168,1,2,0)
 ;;=2^36148
 ;;^UTILITY(U,$J,358.3,1168,1,3,0)
 ;;=3^Access AV Dial Grft for Eval,Ea Addl
 ;;^UTILITY(U,$J,358.3,1169,0)
 ;;=36251^^10^110^33^^^^1
 ;;^UTILITY(U,$J,358.3,1169,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1169,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,1169,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art
