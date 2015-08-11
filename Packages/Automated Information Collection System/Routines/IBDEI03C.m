IBDEI03C ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1170,0)
 ;;=36252^^10^110^34^^^^1
 ;;^UTILITY(U,$J,358.3,1170,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1170,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,1170,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art Bilat
 ;;^UTILITY(U,$J,358.3,1171,0)
 ;;=36254^^10^110^7^^^^1
 ;;^UTILITY(U,$J,358.3,1171,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1171,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,1171,1,3,0)
 ;;=3^Ins Cath Ren Art 2nd+ Bilat
 ;;^UTILITY(U,$J,358.3,1172,0)
 ;;=36253^^10^110^8^^^^1
 ;;^UTILITY(U,$J,358.3,1172,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1172,1,2,0)
 ;;=2^36253
 ;;^UTILITY(U,$J,358.3,1172,1,3,0)
 ;;=3^Ins Cath Ren Art 2nd+ Unilat
 ;;^UTILITY(U,$J,358.3,1173,0)
 ;;=37191^^10^110^9^^^^1
 ;;^UTILITY(U,$J,358.3,1173,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1173,1,2,0)
 ;;=2^37191
 ;;^UTILITY(U,$J,358.3,1173,1,3,0)
 ;;=3^Ins Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,1174,0)
 ;;=36222^^10^110^18^^^^1
 ;;^UTILITY(U,$J,358.3,1174,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1174,1,2,0)
 ;;=2^36222
 ;;^UTILITY(U,$J,358.3,1174,1,3,0)
 ;;=3^Place Cath Carotid/Inom Art
 ;;^UTILITY(U,$J,358.3,1175,0)
 ;;=36223^^10^110^17^^^^1
 ;;^UTILITY(U,$J,358.3,1175,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1175,1,2,0)
 ;;=2^36223
 ;;^UTILITY(U,$J,358.3,1175,1,3,0)
 ;;=3^Place Cath Carotid Inc Extracranial
 ;;^UTILITY(U,$J,358.3,1176,0)
 ;;=36224^^10^110^16^^^^1
 ;;^UTILITY(U,$J,358.3,1176,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1176,1,2,0)
 ;;=2^36224
 ;;^UTILITY(U,$J,358.3,1176,1,3,0)
 ;;=3^Place Cath Carotid Art
 ;;^UTILITY(U,$J,358.3,1177,0)
 ;;=36225^^10^110^20^^^^1
 ;;^UTILITY(U,$J,358.3,1177,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1177,1,2,0)
 ;;=2^36225
 ;;^UTILITY(U,$J,358.3,1177,1,3,0)
 ;;=3^Place Cath Subclavian Art
 ;;^UTILITY(U,$J,358.3,1178,0)
 ;;=36226^^10^110^22^^^^1
 ;;^UTILITY(U,$J,358.3,1178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1178,1,2,0)
 ;;=2^36226
 ;;^UTILITY(U,$J,358.3,1178,1,3,0)
 ;;=3^Place Cath Vertebral Art
 ;;^UTILITY(U,$J,358.3,1179,0)
 ;;=36227^^10^110^23^^^^1
 ;;^UTILITY(U,$J,358.3,1179,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1179,1,2,0)
 ;;=2^36227
 ;;^UTILITY(U,$J,358.3,1179,1,3,0)
 ;;=3^Place Cath Xtrnl Carotid
 ;;^UTILITY(U,$J,358.3,1180,0)
 ;;=36228^^10^110^19^^^^1
 ;;^UTILITY(U,$J,358.3,1180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1180,1,2,0)
 ;;=2^36228
 ;;^UTILITY(U,$J,358.3,1180,1,3,0)
 ;;=3^Place Cath Intracranial Art
 ;;^UTILITY(U,$J,358.3,1181,0)
 ;;=36221^^10^110^21^^^^1
 ;;^UTILITY(U,$J,358.3,1181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1181,1,2,0)
 ;;=2^36221
 ;;^UTILITY(U,$J,358.3,1181,1,3,0)
 ;;=3^Place Cath Thoracic Aorta
 ;;^UTILITY(U,$J,358.3,1182,0)
 ;;=37197^^10^110^30^^^^1
 ;;^UTILITY(U,$J,358.3,1182,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1182,1,2,0)
 ;;=2^37197
 ;;^UTILITY(U,$J,358.3,1182,1,3,0)
 ;;=3^Remove Intrvas Foreign Body,Broken Cath
 ;;^UTILITY(U,$J,358.3,1183,0)
 ;;=36000^^10^110^25^^^^1
 ;;^UTILITY(U,$J,358.3,1183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1183,1,2,0)
 ;;=2^36000
 ;;^UTILITY(U,$J,358.3,1183,1,3,0)
 ;;=3^Placement of Needle in Vein
 ;;^UTILITY(U,$J,358.3,1184,0)
 ;;=36010^^10^110^24^^^^1
 ;;^UTILITY(U,$J,358.3,1184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1184,1,2,0)
 ;;=2^36010
 ;;^UTILITY(U,$J,358.3,1184,1,3,0)
 ;;=3^Placement of Cath in Vein
 ;;^UTILITY(U,$J,358.3,1185,0)
 ;;=37187^^10^110^14^^^^1
 ;;^UTILITY(U,$J,358.3,1185,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1185,1,2,0)
 ;;=2^37187
 ;;^UTILITY(U,$J,358.3,1185,1,3,0)
 ;;=3^PTCA Thrombectomy,Vein(s)
