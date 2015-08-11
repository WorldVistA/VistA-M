IBDEI03E ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1202,0)
 ;;=37235^^10^110^48^^^^1
 ;;^UTILITY(U,$J,358.3,1202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1202,1,2,0)
 ;;=2^37235
 ;;^UTILITY(U,$J,358.3,1202,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent & Ather,Add-On
 ;;^UTILITY(U,$J,358.3,1203,0)
 ;;=37215^^10^110^53^^^^1
 ;;^UTILITY(U,$J,358.3,1203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1203,1,2,0)
 ;;=2^37215
 ;;^UTILITY(U,$J,358.3,1203,1,3,0)
 ;;=3^Transcath Stent CCA w/ EPS
 ;;^UTILITY(U,$J,358.3,1204,0)
 ;;=37216^^10^110^54^^^^1
 ;;^UTILITY(U,$J,358.3,1204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1204,1,2,0)
 ;;=2^37216
 ;;^UTILITY(U,$J,358.3,1204,1,3,0)
 ;;=3^Transcath Stent CCA w/o EPS
 ;;^UTILITY(U,$J,358.3,1205,0)
 ;;=37188^^10^110^55^^^^1
 ;;^UTILITY(U,$J,358.3,1205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1205,1,2,0)
 ;;=2^37188
 ;;^UTILITY(U,$J,358.3,1205,1,3,0)
 ;;=3^Venous Mech Thrombectomy,Add-On
 ;;^UTILITY(U,$J,358.3,1206,0)
 ;;=93561^^10^111^15^^^^1
 ;;^UTILITY(U,$J,358.3,1206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1206,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,1206,1,3,0)
 ;;=3^Thermal Dilution Study W/Cardiac Output
 ;;^UTILITY(U,$J,358.3,1207,0)
 ;;=93571^^10^111^10^^^^1
 ;;^UTILITY(U,$J,358.3,1207,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1207,1,2,0)
 ;;=2^93571
 ;;^UTILITY(U,$J,358.3,1207,1,3,0)
 ;;=3^Intravascular Dopplar Add-On, First Vessel
 ;;^UTILITY(U,$J,358.3,1208,0)
 ;;=93572^^10^111^11^^^^1
 ;;^UTILITY(U,$J,358.3,1208,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1208,1,2,0)
 ;;=2^93572
 ;;^UTILITY(U,$J,358.3,1208,1,3,0)
 ;;=3^Intravascular Dopplar, Each Addl Vessel
 ;;^UTILITY(U,$J,358.3,1209,0)
 ;;=93740^^10^111^14^^^^1
 ;;^UTILITY(U,$J,358.3,1209,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1209,1,2,0)
 ;;=2^93740
 ;;^UTILITY(U,$J,358.3,1209,1,3,0)
 ;;=3^Temperature Gradient Studies
 ;;^UTILITY(U,$J,358.3,1210,0)
 ;;=93784^^10^111^2^^^^1
 ;;^UTILITY(U,$J,358.3,1210,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1210,1,2,0)
 ;;=2^93784
 ;;^UTILITY(U,$J,358.3,1210,1,3,0)
 ;;=3^Amb BP Monitor 24+ hrs,Int&Rpt
 ;;^UTILITY(U,$J,358.3,1211,0)
 ;;=93786^^10^111^3^^^^1
 ;;^UTILITY(U,$J,358.3,1211,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1211,1,2,0)
 ;;=2^93786
 ;;^UTILITY(U,$J,358.3,1211,1,3,0)
 ;;=3^Amb BP Monitor 24+ hrs,Record Only
 ;;^UTILITY(U,$J,358.3,1212,0)
 ;;=93788^^10^111^1^^^^1
 ;;^UTILITY(U,$J,358.3,1212,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1212,1,2,0)
 ;;=2^93788
 ;;^UTILITY(U,$J,358.3,1212,1,3,0)
 ;;=3^Amb BP Analysis & Rpt
 ;;^UTILITY(U,$J,358.3,1213,0)
 ;;=93790^^10^111^4^^^^1
 ;;^UTILITY(U,$J,358.3,1213,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1213,1,2,0)
 ;;=2^93790
 ;;^UTILITY(U,$J,358.3,1213,1,3,0)
 ;;=3^Amb BP Review w/ Int&Rpt
 ;;^UTILITY(U,$J,358.3,1214,0)
 ;;=34800^^10^112^1^^^^1
 ;;^UTILITY(U,$J,358.3,1214,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1214,1,2,0)
 ;;=2^34800
 ;;^UTILITY(U,$J,358.3,1214,1,3,0)
 ;;=3^Endovasc Abd Repair,Infrarenal AAA w/Tube
 ;;^UTILITY(U,$J,358.3,1215,0)
 ;;=34802^^10^112^2^^^^1
 ;;^UTILITY(U,$J,358.3,1215,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1215,1,2,0)
 ;;=2^34802
 ;;^UTILITY(U,$J,358.3,1215,1,3,0)
 ;;=3^Endovasc Abd Repr,Infrarenal AAA w/Bifurc,1 Dock Limb
 ;;^UTILITY(U,$J,358.3,1216,0)
 ;;=34803^^10^112^3^^^^1
 ;;^UTILITY(U,$J,358.3,1216,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1216,1,2,0)
 ;;=2^34803
 ;;^UTILITY(U,$J,358.3,1216,1,3,0)
 ;;=3^Endovasc Abd Repr,Infrarenal AAA w/Bifurc,2 Dock Limbs
 ;;^UTILITY(U,$J,358.3,1217,0)
 ;;=93279^^10^113^11^^^^1
 ;;^UTILITY(U,$J,358.3,1217,1,0)
 ;;=^358.31IA^3^2
