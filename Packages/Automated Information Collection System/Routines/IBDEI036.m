IBDEI036 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1075,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jugular)
 ;;^UTILITY(U,$J,358.3,1076,0)
 ;;=36245^^10^106^39^^^^1
 ;;^UTILITY(U,$J,358.3,1076,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1076,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,1076,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,1077,0)
 ;;=36246^^10^106^40^^^^1
 ;;^UTILITY(U,$J,358.3,1077,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1077,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,1077,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,1078,0)
 ;;=36247^^10^106^41^^^^1
 ;;^UTILITY(U,$J,358.3,1078,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1078,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,1078,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,1079,0)
 ;;=75962^^10^106^59^^^^1
 ;;^UTILITY(U,$J,358.3,1079,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1079,1,2,0)
 ;;=2^75962
 ;;^UTILITY(U,$J,358.3,1079,1,3,0)
 ;;=3^Translum Ball Angioplasty,Peripheral Artery, Rad S&I
 ;;^UTILITY(U,$J,358.3,1080,0)
 ;;=75964^^10^106^1^^^^1
 ;;^UTILITY(U,$J,358.3,1080,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1080,1,2,0)
 ;;=2^75964
 ;;^UTILITY(U,$J,358.3,1080,1,3,0)
 ;;=3^     Each Add Artery (W/75962)
 ;;^UTILITY(U,$J,358.3,1081,0)
 ;;=75791^^10^106^10^^^^1
 ;;^UTILITY(U,$J,358.3,1081,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1081,1,2,0)
 ;;=2^75791
 ;;^UTILITY(U,$J,358.3,1081,1,3,0)
 ;;=3^Arteriovenous Shunt
 ;;^UTILITY(U,$J,358.3,1082,0)
 ;;=37220^^10^106^22^^^^1
 ;;^UTILITY(U,$J,358.3,1082,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1082,1,2,0)
 ;;=2^37220
 ;;^UTILITY(U,$J,358.3,1082,1,3,0)
 ;;=3^Iliac Revasc,Unilat,1st Vessel
 ;;^UTILITY(U,$J,358.3,1083,0)
 ;;=37221^^10^106^20^^^^1
 ;;^UTILITY(U,$J,358.3,1083,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1083,1,2,0)
 ;;=2^37221
 ;;^UTILITY(U,$J,358.3,1083,1,3,0)
 ;;=3^Iliac Revasc w/Stent
 ;;^UTILITY(U,$J,358.3,1084,0)
 ;;=37222^^10^106^23^^^^1
 ;;^UTILITY(U,$J,358.3,1084,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1084,1,2,0)
 ;;=2^37222
 ;;^UTILITY(U,$J,358.3,1084,1,3,0)
 ;;=3^Iliac Revasc,ea add Vessel
 ;;^UTILITY(U,$J,358.3,1085,0)
 ;;=37223^^10^106^21^^^^1
 ;;^UTILITY(U,$J,358.3,1085,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1085,1,2,0)
 ;;=2^37223
 ;;^UTILITY(U,$J,358.3,1085,1,3,0)
 ;;=3^Iliac Revasc w/Stent,Add-on
 ;;^UTILITY(U,$J,358.3,1086,0)
 ;;=37224^^10^106^17^^^^1
 ;;^UTILITY(U,$J,358.3,1086,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1086,1,2,0)
 ;;=2^37224
 ;;^UTILITY(U,$J,358.3,1086,1,3,0)
 ;;=3^Fem/Popl Revas w/TLA 1st Vessel
 ;;^UTILITY(U,$J,358.3,1087,0)
 ;;=37225^^10^106^16^^^^1
 ;;^UTILITY(U,$J,358.3,1087,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1087,1,2,0)
 ;;=2^37225
 ;;^UTILITY(U,$J,358.3,1087,1,3,0)
 ;;=3^Fem/Popl Revas w/Ather
 ;;^UTILITY(U,$J,358.3,1088,0)
 ;;=37226^^10^106^18^^^^1
 ;;^UTILITY(U,$J,358.3,1088,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1088,1,2,0)
 ;;=2^37226
 ;;^UTILITY(U,$J,358.3,1088,1,3,0)
 ;;=3^Fem/Popl Revasc w/Stent
 ;;^UTILITY(U,$J,358.3,1089,0)
 ;;=37227^^10^106^19^^^^1
 ;;^UTILITY(U,$J,358.3,1089,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1089,1,2,0)
 ;;=2^37227
 ;;^UTILITY(U,$J,358.3,1089,1,3,0)
 ;;=3^Fem/Popl Revasc w/Stent & Ather
 ;;^UTILITY(U,$J,358.3,1090,0)
 ;;=37228^^10^106^51^^^^1
 ;;^UTILITY(U,$J,358.3,1090,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1090,1,2,0)
 ;;=2^37228
 ;;^UTILITY(U,$J,358.3,1090,1,3,0)
 ;;=3^TIB/Per Revasc w/TLA,1st Vessel
 ;;^UTILITY(U,$J,358.3,1091,0)
 ;;=37229^^10^106^46^^^^1
 ;;^UTILITY(U,$J,358.3,1091,1,0)
 ;;=^358.31IA^3^2
