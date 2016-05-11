IBDEI05B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2106,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2106,1,2,0)
 ;;=2^37187
 ;;^UTILITY(U,$J,358.3,2106,1,3,0)
 ;;=3^PTCA Thrombectomy,Vein(s)
 ;;^UTILITY(U,$J,358.3,2107,0)
 ;;=37236^^12^167^52^^^^1
 ;;^UTILITY(U,$J,358.3,2107,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2107,1,2,0)
 ;;=2^37236
 ;;^UTILITY(U,$J,358.3,2107,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent,Init Art
 ;;^UTILITY(U,$J,358.3,2108,0)
 ;;=37237^^12^167^51^^^^1
 ;;^UTILITY(U,$J,358.3,2108,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2108,1,2,0)
 ;;=2^37237
 ;;^UTILITY(U,$J,358.3,2108,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,2109,0)
 ;;=37214^^12^167^3^^^^1
 ;;^UTILITY(U,$J,358.3,2109,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2109,1,2,0)
 ;;=2^37214
 ;;^UTILITY(U,$J,358.3,2109,1,3,0)
 ;;=3^Cessj Therapy Cath Removal
 ;;^UTILITY(U,$J,358.3,2110,0)
 ;;=37184^^12^167^26^^^^1
 ;;^UTILITY(U,$J,358.3,2110,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2110,1,2,0)
 ;;=2^37184
 ;;^UTILITY(U,$J,358.3,2110,1,3,0)
 ;;=3^Prim Art Mech Thrombectomy
 ;;^UTILITY(U,$J,358.3,2111,0)
 ;;=37185^^12^167^27^^^^1
 ;;^UTILITY(U,$J,358.3,2111,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2111,1,2,0)
 ;;=2^37185
 ;;^UTILITY(U,$J,358.3,2111,1,3,0)
 ;;=3^Prim Art Mech Thrombectomy,Add-On
 ;;^UTILITY(U,$J,358.3,2112,0)
 ;;=36002^^12^167^28^^^^1
 ;;^UTILITY(U,$J,358.3,2112,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2112,1,2,0)
 ;;=2^36002
 ;;^UTILITY(U,$J,358.3,2112,1,3,0)
 ;;=3^Pseudoaneurysm Injection Trt
 ;;^UTILITY(U,$J,358.3,2113,0)
 ;;=33011^^12^167^32^^^^1
 ;;^UTILITY(U,$J,358.3,2113,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2113,1,2,0)
 ;;=2^33011
 ;;^UTILITY(U,$J,358.3,2113,1,3,0)
 ;;=3^Repeat Drainage of Heart Sac
 ;;^UTILITY(U,$J,358.3,2114,0)
 ;;=37193^^12^167^29^^^^1
 ;;^UTILITY(U,$J,358.3,2114,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2114,1,2,0)
 ;;=2^37193
 ;;^UTILITY(U,$J,358.3,2114,1,3,0)
 ;;=3^Remove Endovas Vena Cava Filter
 ;;^UTILITY(U,$J,358.3,2115,0)
 ;;=37212^^12^167^43^^^^1
 ;;^UTILITY(U,$J,358.3,2115,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2115,1,2,0)
 ;;=2^37212
 ;;^UTILITY(U,$J,358.3,2115,1,3,0)
 ;;=3^Thrombolytic Venous Therapy
 ;;^UTILITY(U,$J,358.3,2116,0)
 ;;=37213^^12^167^42^^^^1
 ;;^UTILITY(U,$J,358.3,2116,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2116,1,2,0)
 ;;=2^37213
 ;;^UTILITY(U,$J,358.3,2116,1,3,0)
 ;;=3^Thrombolytic Art/Ven Therapy
 ;;^UTILITY(U,$J,358.3,2117,0)
 ;;=37229^^12^167^44^^^^1
 ;;^UTILITY(U,$J,358.3,2117,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2117,1,2,0)
 ;;=2^37229
 ;;^UTILITY(U,$J,358.3,2117,1,3,0)
 ;;=3^Tib/Per Revasc w/ Ather
 ;;^UTILITY(U,$J,358.3,2118,0)
 ;;=37230^^12^167^46^^^^1
 ;;^UTILITY(U,$J,358.3,2118,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2118,1,2,0)
 ;;=2^37230
 ;;^UTILITY(U,$J,358.3,2118,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent
 ;;^UTILITY(U,$J,358.3,2119,0)
 ;;=37231^^12^167^47^^^^1
 ;;^UTILITY(U,$J,358.3,2119,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2119,1,2,0)
 ;;=2^37231
 ;;^UTILITY(U,$J,358.3,2119,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent & Ather
 ;;^UTILITY(U,$J,358.3,2120,0)
 ;;=37232^^12^167^50^^^^1
 ;;^UTILITY(U,$J,358.3,2120,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2120,1,2,0)
 ;;=2^37232
 ;;^UTILITY(U,$J,358.3,2120,1,3,0)
 ;;=3^Tib/Per Revasc,Add-on
 ;;^UTILITY(U,$J,358.3,2121,0)
 ;;=37233^^12^167^45^^^^1
 ;;^UTILITY(U,$J,358.3,2121,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2121,1,2,0)
 ;;=2^37233
 ;;^UTILITY(U,$J,358.3,2121,1,3,0)
 ;;=3^Tib/Per Revasc w/ Ather,Add-On
 ;;^UTILITY(U,$J,358.3,2122,0)
 ;;=37234^^12^167^49^^^^1
