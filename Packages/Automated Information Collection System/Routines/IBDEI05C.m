IBDEI05C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2122,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2122,1,2,0)
 ;;=2^37234
 ;;^UTILITY(U,$J,358.3,2122,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent,Add-On
 ;;^UTILITY(U,$J,358.3,2123,0)
 ;;=37235^^12^167^48^^^^1
 ;;^UTILITY(U,$J,358.3,2123,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2123,1,2,0)
 ;;=2^37235
 ;;^UTILITY(U,$J,358.3,2123,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent & Ather,Add-On
 ;;^UTILITY(U,$J,358.3,2124,0)
 ;;=37215^^12^167^53^^^^1
 ;;^UTILITY(U,$J,358.3,2124,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2124,1,2,0)
 ;;=2^37215
 ;;^UTILITY(U,$J,358.3,2124,1,3,0)
 ;;=3^Transcath Stent CCA w/ EPS
 ;;^UTILITY(U,$J,358.3,2125,0)
 ;;=37216^^12^167^54^^^^1
 ;;^UTILITY(U,$J,358.3,2125,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2125,1,2,0)
 ;;=2^37216
 ;;^UTILITY(U,$J,358.3,2125,1,3,0)
 ;;=3^Transcath Stent CCA w/o EPS
 ;;^UTILITY(U,$J,358.3,2126,0)
 ;;=37188^^12^167^55^^^^1
 ;;^UTILITY(U,$J,358.3,2126,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2126,1,2,0)
 ;;=2^37188
 ;;^UTILITY(U,$J,358.3,2126,1,3,0)
 ;;=3^Venous Mech Thrombectomy,Add-On
 ;;^UTILITY(U,$J,358.3,2127,0)
 ;;=93561^^12^168^15^^^^1
 ;;^UTILITY(U,$J,358.3,2127,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2127,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,2127,1,3,0)
 ;;=3^Thermal Dilution Study W/Cardiac Output
 ;;^UTILITY(U,$J,358.3,2128,0)
 ;;=93571^^12^168^10^^^^1
 ;;^UTILITY(U,$J,358.3,2128,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2128,1,2,0)
 ;;=2^93571
 ;;^UTILITY(U,$J,358.3,2128,1,3,0)
 ;;=3^Intravascular Dopplar Add-On, First Vessel
 ;;^UTILITY(U,$J,358.3,2129,0)
 ;;=93572^^12^168^11^^^^1
 ;;^UTILITY(U,$J,358.3,2129,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2129,1,2,0)
 ;;=2^93572
 ;;^UTILITY(U,$J,358.3,2129,1,3,0)
 ;;=3^Intravascular Dopplar, Each Addl Vessel
 ;;^UTILITY(U,$J,358.3,2130,0)
 ;;=93740^^12^168^14^^^^1
 ;;^UTILITY(U,$J,358.3,2130,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2130,1,2,0)
 ;;=2^93740
 ;;^UTILITY(U,$J,358.3,2130,1,3,0)
 ;;=3^Temperature Gradient Studies
 ;;^UTILITY(U,$J,358.3,2131,0)
 ;;=93784^^12^168^2^^^^1
 ;;^UTILITY(U,$J,358.3,2131,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2131,1,2,0)
 ;;=2^93784
 ;;^UTILITY(U,$J,358.3,2131,1,3,0)
 ;;=3^Amb BP Monitor 24+ hrs,Int&Rpt
 ;;^UTILITY(U,$J,358.3,2132,0)
 ;;=93786^^12^168^3^^^^1
 ;;^UTILITY(U,$J,358.3,2132,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2132,1,2,0)
 ;;=2^93786
 ;;^UTILITY(U,$J,358.3,2132,1,3,0)
 ;;=3^Amb BP Monitor 24+ hrs,Record Only
 ;;^UTILITY(U,$J,358.3,2133,0)
 ;;=93788^^12^168^1^^^^1
 ;;^UTILITY(U,$J,358.3,2133,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2133,1,2,0)
 ;;=2^93788
 ;;^UTILITY(U,$J,358.3,2133,1,3,0)
 ;;=3^Amb BP Analysis & Rpt
 ;;^UTILITY(U,$J,358.3,2134,0)
 ;;=93790^^12^168^4^^^^1
 ;;^UTILITY(U,$J,358.3,2134,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2134,1,2,0)
 ;;=2^93790
 ;;^UTILITY(U,$J,358.3,2134,1,3,0)
 ;;=3^Amb BP Review w/ Int&Rpt
 ;;^UTILITY(U,$J,358.3,2135,0)
 ;;=34800^^12^169^1^^^^1
 ;;^UTILITY(U,$J,358.3,2135,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2135,1,2,0)
 ;;=2^34800
 ;;^UTILITY(U,$J,358.3,2135,1,3,0)
 ;;=3^Endovasc Abd Repair,Infrarenal AAA w/Tube
 ;;^UTILITY(U,$J,358.3,2136,0)
 ;;=34802^^12^169^2^^^^1
 ;;^UTILITY(U,$J,358.3,2136,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2136,1,2,0)
 ;;=2^34802
 ;;^UTILITY(U,$J,358.3,2136,1,3,0)
 ;;=3^Endovasc Abd Repr,Infrarenal AAA w/Bifurc,1 Dock Limb
 ;;^UTILITY(U,$J,358.3,2137,0)
 ;;=34803^^12^169^3^^^^1
 ;;^UTILITY(U,$J,358.3,2137,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2137,1,2,0)
 ;;=2^34803
 ;;^UTILITY(U,$J,358.3,2137,1,3,0)
 ;;=3^Endovasc Abd Repr,Infrarenal AAA w/Bifurc,2 Dock Limbs
