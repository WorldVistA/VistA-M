IBDEI038 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1107,0)
 ;;=35472^^10^106^31^^^^1
 ;;^UTILITY(U,$J,358.3,1107,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1107,1,2,0)
 ;;=2^35472
 ;;^UTILITY(U,$J,358.3,1107,1,3,0)
 ;;=3^Perc Angioplasty,Aortic
 ;;^UTILITY(U,$J,358.3,1108,0)
 ;;=35476^^10^106^32^^^^1
 ;;^UTILITY(U,$J,358.3,1108,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1108,1,2,0)
 ;;=2^35476
 ;;^UTILITY(U,$J,358.3,1108,1,3,0)
 ;;=3^Perc Angioplasty,Venous
 ;;^UTILITY(U,$J,358.3,1109,0)
 ;;=37236^^10^106^57^^^^1
 ;;^UTILITY(U,$J,358.3,1109,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1109,1,2,0)
 ;;=2^37236
 ;;^UTILITY(U,$J,358.3,1109,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent,Init Art
 ;;^UTILITY(U,$J,358.3,1110,0)
 ;;=37237^^10^106^55^^^^1
 ;;^UTILITY(U,$J,358.3,1110,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1110,1,2,0)
 ;;=2^37237
 ;;^UTILITY(U,$J,358.3,1110,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,1111,0)
 ;;=37238^^10^106^54^^^^1
 ;;^UTILITY(U,$J,358.3,1111,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1111,1,2,0)
 ;;=2^37238
 ;;^UTILITY(U,$J,358.3,1111,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stent,Init Vein
 ;;^UTILITY(U,$J,358.3,1112,0)
 ;;=37239^^10^106^56^^^^1
 ;;^UTILITY(U,$J,358.3,1112,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1112,1,2,0)
 ;;=2^37239
 ;;^UTILITY(U,$J,358.3,1112,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Vein
 ;;^UTILITY(U,$J,358.3,1113,0)
 ;;=75978^^10^106^36^^^^1
 ;;^UTILITY(U,$J,358.3,1113,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1113,1,2,0)
 ;;=2^75978
 ;;^UTILITY(U,$J,358.3,1113,1,3,0)
 ;;=3^Repair Venous Blockage
 ;;^UTILITY(U,$J,358.3,1114,0)
 ;;=75894^^10^106^58^^^^1
 ;;^UTILITY(U,$J,358.3,1114,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1114,1,2,0)
 ;;=2^75894
 ;;^UTILITY(U,$J,358.3,1114,1,3,0)
 ;;=3^Transcath Rpr Iliac Art Aneur,AV,Rad S&I
 ;;^UTILITY(U,$J,358.3,1115,0)
 ;;=75962^^10^106^53^^^^1
 ;;^UTILITY(U,$J,358.3,1115,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1115,1,2,0)
 ;;=2^75962
 ;;^UTILITY(U,$J,358.3,1115,1,3,0)
 ;;=3^Tranlum Ball Angiopl,Venous Art,Rad S&I
 ;;^UTILITY(U,$J,358.3,1116,0)
 ;;=0237T^^10^106^60^^^^1
 ;;^UTILITY(U,$J,358.3,1116,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1116,1,2,0)
 ;;=2^0237T
 ;;^UTILITY(U,$J,358.3,1116,1,3,0)
 ;;=3^Trluml Perip Athrc Brchiocph
 ;;^UTILITY(U,$J,358.3,1117,0)
 ;;=0238T^^10^106^61^^^^1
 ;;^UTILITY(U,$J,358.3,1117,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1117,1,2,0)
 ;;=2^0238T
 ;;^UTILITY(U,$J,358.3,1117,1,3,0)
 ;;=3^Trluml Perip Athrc Iliac Art
 ;;^UTILITY(U,$J,358.3,1118,0)
 ;;=75820^^10^106^63^^^^1
 ;;^UTILITY(U,$J,358.3,1118,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1118,1,2,0)
 ;;=2^75820
 ;;^UTILITY(U,$J,358.3,1118,1,3,0)
 ;;=3^Vein X-Ray,Arm/Leg,Unilat
 ;;^UTILITY(U,$J,358.3,1119,0)
 ;;=75822^^10^106^64^^^^1
 ;;^UTILITY(U,$J,358.3,1119,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1119,1,2,0)
 ;;=2^75822
 ;;^UTILITY(U,$J,358.3,1119,1,3,0)
 ;;=3^Vein X-Ray,Arms/Legs,Bilat
 ;;^UTILITY(U,$J,358.3,1120,0)
 ;;=75827^^10^106^65^^^^1
 ;;^UTILITY(U,$J,358.3,1120,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1120,1,2,0)
 ;;=2^75827
 ;;^UTILITY(U,$J,358.3,1120,1,3,0)
 ;;=3^Vein X-Ray,Chest
 ;;^UTILITY(U,$J,358.3,1121,0)
 ;;=36005^^10^107^1^^^^1
 ;;^UTILITY(U,$J,358.3,1121,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1121,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,1121,1,3,0)
 ;;=3^Contrast Venography
 ;;^UTILITY(U,$J,358.3,1122,0)
 ;;=92950^^10^108^1^^^^1
 ;;^UTILITY(U,$J,358.3,1122,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1122,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,1122,1,3,0)
 ;;=3^CPR
