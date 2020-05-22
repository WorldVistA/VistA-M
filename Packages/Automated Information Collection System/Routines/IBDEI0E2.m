IBDEI0E2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6005,1,3,0)
 ;;=3^Place Cath Carotid Art
 ;;^UTILITY(U,$J,358.3,6006,0)
 ;;=36225^^52^390^19^^^^1
 ;;^UTILITY(U,$J,358.3,6006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6006,1,2,0)
 ;;=2^36225
 ;;^UTILITY(U,$J,358.3,6006,1,3,0)
 ;;=3^Place Cath Subclavian Art
 ;;^UTILITY(U,$J,358.3,6007,0)
 ;;=36226^^52^390^22^^^^1
 ;;^UTILITY(U,$J,358.3,6007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6007,1,2,0)
 ;;=2^36226
 ;;^UTILITY(U,$J,358.3,6007,1,3,0)
 ;;=3^Place Cath Vertebral Art
 ;;^UTILITY(U,$J,358.3,6008,0)
 ;;=36227^^52^390^23^^^^1
 ;;^UTILITY(U,$J,358.3,6008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6008,1,2,0)
 ;;=2^36227
 ;;^UTILITY(U,$J,358.3,6008,1,3,0)
 ;;=3^Place Cath Xtrnl Carotid
 ;;^UTILITY(U,$J,358.3,6009,0)
 ;;=36228^^52^390^18^^^^1
 ;;^UTILITY(U,$J,358.3,6009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6009,1,2,0)
 ;;=2^36228
 ;;^UTILITY(U,$J,358.3,6009,1,3,0)
 ;;=3^Place Cath Intracranial Art
 ;;^UTILITY(U,$J,358.3,6010,0)
 ;;=36221^^52^390^21^^^^1
 ;;^UTILITY(U,$J,358.3,6010,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6010,1,2,0)
 ;;=2^36221
 ;;^UTILITY(U,$J,358.3,6010,1,3,0)
 ;;=3^Place Cath Thoracic Aorta
 ;;^UTILITY(U,$J,358.3,6011,0)
 ;;=37197^^52^390^29^^^^1
 ;;^UTILITY(U,$J,358.3,6011,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6011,1,2,0)
 ;;=2^37197
 ;;^UTILITY(U,$J,358.3,6011,1,3,0)
 ;;=3^Remove Intrvas Foreign Body,Broken Cath
 ;;^UTILITY(U,$J,358.3,6012,0)
 ;;=36000^^52^390^24^^^^1
 ;;^UTILITY(U,$J,358.3,6012,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6012,1,2,0)
 ;;=2^36000
 ;;^UTILITY(U,$J,358.3,6012,1,3,0)
 ;;=3^Place Needle/Intracath in Vein
 ;;^UTILITY(U,$J,358.3,6013,0)
 ;;=36010^^52^390^20^^^^1
 ;;^UTILITY(U,$J,358.3,6013,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6013,1,2,0)
 ;;=2^36010
 ;;^UTILITY(U,$J,358.3,6013,1,3,0)
 ;;=3^Place Cath Sup/Inf Vena Cava
 ;;^UTILITY(U,$J,358.3,6014,0)
 ;;=37187^^52^390^12^^^^1
 ;;^UTILITY(U,$J,358.3,6014,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6014,1,2,0)
 ;;=2^37187
 ;;^UTILITY(U,$J,358.3,6014,1,3,0)
 ;;=3^PTCA Thrombectomy (non-cardio),Vein(s),Init
 ;;^UTILITY(U,$J,358.3,6015,0)
 ;;=37236^^52^390^53^^^^1
 ;;^UTILITY(U,$J,358.3,6015,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6015,1,2,0)
 ;;=2^37236
 ;;^UTILITY(U,$J,358.3,6015,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent,Init Art
 ;;^UTILITY(U,$J,358.3,6016,0)
 ;;=37237^^52^390^52^^^^1
 ;;^UTILITY(U,$J,358.3,6016,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6016,1,2,0)
 ;;=2^37237
 ;;^UTILITY(U,$J,358.3,6016,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,6017,0)
 ;;=37214^^52^390^4^^^^1
 ;;^UTILITY(U,$J,358.3,6017,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6017,1,2,0)
 ;;=2^37214
 ;;^UTILITY(U,$J,358.3,6017,1,3,0)
 ;;=3^Cess Tx w/ Cath Removal,Art/Ven Inf
 ;;^UTILITY(U,$J,358.3,6018,0)
 ;;=37184^^52^390^25^^^^1
 ;;^UTILITY(U,$J,358.3,6018,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6018,1,2,0)
 ;;=2^37184
 ;;^UTILITY(U,$J,358.3,6018,1,3,0)
 ;;=3^Prim Art Mech Thrombectomy (Non-Cardio)
 ;;^UTILITY(U,$J,358.3,6019,0)
 ;;=37185^^52^390^26^^^^1
 ;;^UTILITY(U,$J,358.3,6019,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6019,1,2,0)
 ;;=2^37185
 ;;^UTILITY(U,$J,358.3,6019,1,3,0)
 ;;=3^Prim Art Mech Thrombectomy,Add-On
 ;;^UTILITY(U,$J,358.3,6020,0)
 ;;=36002^^52^390^27^^^^1
 ;;^UTILITY(U,$J,358.3,6020,1,0)
 ;;=^358.31IA^3^2
