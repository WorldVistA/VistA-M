IBDEI0E3 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6020,1,2,0)
 ;;=2^36002
 ;;^UTILITY(U,$J,358.3,6020,1,3,0)
 ;;=3^Pseudoaneurysm Injection Trt
 ;;^UTILITY(U,$J,358.3,6021,0)
 ;;=37193^^52^390^28^^^^1
 ;;^UTILITY(U,$J,358.3,6021,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6021,1,2,0)
 ;;=2^37193
 ;;^UTILITY(U,$J,358.3,6021,1,3,0)
 ;;=3^Remove Endovas Vena Cava Filter
 ;;^UTILITY(U,$J,358.3,6022,0)
 ;;=37212^^52^390^44^^^^1
 ;;^UTILITY(U,$J,358.3,6022,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6022,1,2,0)
 ;;=2^37212
 ;;^UTILITY(U,$J,358.3,6022,1,3,0)
 ;;=3^Thrombolytic Venous Therapy
 ;;^UTILITY(U,$J,358.3,6023,0)
 ;;=37213^^52^390^43^^^^1
 ;;^UTILITY(U,$J,358.3,6023,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6023,1,2,0)
 ;;=2^37213
 ;;^UTILITY(U,$J,358.3,6023,1,3,0)
 ;;=3^Thrombolytic Art/Ven Therapy
 ;;^UTILITY(U,$J,358.3,6024,0)
 ;;=37229^^52^390^46^^^^1
 ;;^UTILITY(U,$J,358.3,6024,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6024,1,2,0)
 ;;=2^37229
 ;;^UTILITY(U,$J,358.3,6024,1,3,0)
 ;;=3^Tib/Per Revasc w/ Ather
 ;;^UTILITY(U,$J,358.3,6025,0)
 ;;=37230^^52^390^48^^^^1
 ;;^UTILITY(U,$J,358.3,6025,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6025,1,2,0)
 ;;=2^37230
 ;;^UTILITY(U,$J,358.3,6025,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent
 ;;^UTILITY(U,$J,358.3,6026,0)
 ;;=37231^^52^390^49^^^^1
 ;;^UTILITY(U,$J,358.3,6026,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6026,1,2,0)
 ;;=2^37231
 ;;^UTILITY(U,$J,358.3,6026,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent & Ather
 ;;^UTILITY(U,$J,358.3,6027,0)
 ;;=37232^^52^390^45^^^^1
 ;;^UTILITY(U,$J,358.3,6027,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6027,1,2,0)
 ;;=2^37232
 ;;^UTILITY(U,$J,358.3,6027,1,3,0)
 ;;=3^Tib/Per Revasc (Same Vessel),Add-on
 ;;^UTILITY(U,$J,358.3,6028,0)
 ;;=37233^^52^390^47^^^^1
 ;;^UTILITY(U,$J,358.3,6028,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6028,1,2,0)
 ;;=2^37233
 ;;^UTILITY(U,$J,358.3,6028,1,3,0)
 ;;=3^Tib/Per Revasc w/ Ather (Same Vessel),Add-On
 ;;^UTILITY(U,$J,358.3,6029,0)
 ;;=37234^^52^390^51^^^^1
 ;;^UTILITY(U,$J,358.3,6029,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6029,1,2,0)
 ;;=2^37234
 ;;^UTILITY(U,$J,358.3,6029,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent (Same Vessel),Add-On
 ;;^UTILITY(U,$J,358.3,6030,0)
 ;;=37235^^52^390^50^^^^1
 ;;^UTILITY(U,$J,358.3,6030,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6030,1,2,0)
 ;;=2^37235
 ;;^UTILITY(U,$J,358.3,6030,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent & Ather (Same Vessel),Add-On
 ;;^UTILITY(U,$J,358.3,6031,0)
 ;;=37215^^52^390^54^^^^1
 ;;^UTILITY(U,$J,358.3,6031,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6031,1,2,0)
 ;;=2^37215
 ;;^UTILITY(U,$J,358.3,6031,1,3,0)
 ;;=3^Transcath Stent CCA w/ EPS
 ;;^UTILITY(U,$J,358.3,6032,0)
 ;;=37216^^52^390^55^^^^1
 ;;^UTILITY(U,$J,358.3,6032,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6032,1,2,0)
 ;;=2^37216
 ;;^UTILITY(U,$J,358.3,6032,1,3,0)
 ;;=3^Transcath Stent CCA w/o EPS
 ;;^UTILITY(U,$J,358.3,6033,0)
 ;;=37188^^52^390^13^^^^1
 ;;^UTILITY(U,$J,358.3,6033,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6033,1,2,0)
 ;;=2^37188
 ;;^UTILITY(U,$J,358.3,6033,1,3,0)
 ;;=3^Percut Mech Thrombectomy,Sub Day of Thromb Tx
 ;;^UTILITY(U,$J,358.3,6034,0)
 ;;=36901^^52^390^1^^^^1
 ;;^UTILITY(U,$J,358.3,6034,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6034,1,2,0)
 ;;=2^36901
 ;;^UTILITY(U,$J,358.3,6034,1,3,0)
 ;;=3^Access AV Dial Graft Inf/Sup Vena Cava
 ;;^UTILITY(U,$J,358.3,6035,0)
 ;;=36902^^52^390^2^^^^1
