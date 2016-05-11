IBDEI05A ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2090,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2090,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,2090,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art
 ;;^UTILITY(U,$J,358.3,2091,0)
 ;;=36252^^12^167^34^^^^1
 ;;^UTILITY(U,$J,358.3,2091,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2091,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,2091,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art Bilat
 ;;^UTILITY(U,$J,358.3,2092,0)
 ;;=36254^^12^167^7^^^^1
 ;;^UTILITY(U,$J,358.3,2092,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2092,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,2092,1,3,0)
 ;;=3^Ins Cath Ren Art 2nd+ Bilat
 ;;^UTILITY(U,$J,358.3,2093,0)
 ;;=36253^^12^167^8^^^^1
 ;;^UTILITY(U,$J,358.3,2093,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2093,1,2,0)
 ;;=2^36253
 ;;^UTILITY(U,$J,358.3,2093,1,3,0)
 ;;=3^Ins Cath Ren Art 2nd+ Unilat
 ;;^UTILITY(U,$J,358.3,2094,0)
 ;;=37191^^12^167^9^^^^1
 ;;^UTILITY(U,$J,358.3,2094,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2094,1,2,0)
 ;;=2^37191
 ;;^UTILITY(U,$J,358.3,2094,1,3,0)
 ;;=3^Ins Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,2095,0)
 ;;=36222^^12^167^18^^^^1
 ;;^UTILITY(U,$J,358.3,2095,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2095,1,2,0)
 ;;=2^36222
 ;;^UTILITY(U,$J,358.3,2095,1,3,0)
 ;;=3^Place Cath Carotid/Inom Art
 ;;^UTILITY(U,$J,358.3,2096,0)
 ;;=36223^^12^167^17^^^^1
 ;;^UTILITY(U,$J,358.3,2096,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2096,1,2,0)
 ;;=2^36223
 ;;^UTILITY(U,$J,358.3,2096,1,3,0)
 ;;=3^Place Cath Carotid Inc Extracranial
 ;;^UTILITY(U,$J,358.3,2097,0)
 ;;=36224^^12^167^16^^^^1
 ;;^UTILITY(U,$J,358.3,2097,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2097,1,2,0)
 ;;=2^36224
 ;;^UTILITY(U,$J,358.3,2097,1,3,0)
 ;;=3^Place Cath Carotid Art
 ;;^UTILITY(U,$J,358.3,2098,0)
 ;;=36225^^12^167^20^^^^1
 ;;^UTILITY(U,$J,358.3,2098,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2098,1,2,0)
 ;;=2^36225
 ;;^UTILITY(U,$J,358.3,2098,1,3,0)
 ;;=3^Place Cath Subclavian Art
 ;;^UTILITY(U,$J,358.3,2099,0)
 ;;=36226^^12^167^22^^^^1
 ;;^UTILITY(U,$J,358.3,2099,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2099,1,2,0)
 ;;=2^36226
 ;;^UTILITY(U,$J,358.3,2099,1,3,0)
 ;;=3^Place Cath Vertebral Art
 ;;^UTILITY(U,$J,358.3,2100,0)
 ;;=36227^^12^167^23^^^^1
 ;;^UTILITY(U,$J,358.3,2100,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2100,1,2,0)
 ;;=2^36227
 ;;^UTILITY(U,$J,358.3,2100,1,3,0)
 ;;=3^Place Cath Xtrnl Carotid
 ;;^UTILITY(U,$J,358.3,2101,0)
 ;;=36228^^12^167^19^^^^1
 ;;^UTILITY(U,$J,358.3,2101,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2101,1,2,0)
 ;;=2^36228
 ;;^UTILITY(U,$J,358.3,2101,1,3,0)
 ;;=3^Place Cath Intracranial Art
 ;;^UTILITY(U,$J,358.3,2102,0)
 ;;=36221^^12^167^21^^^^1
 ;;^UTILITY(U,$J,358.3,2102,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2102,1,2,0)
 ;;=2^36221
 ;;^UTILITY(U,$J,358.3,2102,1,3,0)
 ;;=3^Place Cath Thoracic Aorta
 ;;^UTILITY(U,$J,358.3,2103,0)
 ;;=37197^^12^167^30^^^^1
 ;;^UTILITY(U,$J,358.3,2103,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2103,1,2,0)
 ;;=2^37197
 ;;^UTILITY(U,$J,358.3,2103,1,3,0)
 ;;=3^Remove Intrvas Foreign Body,Broken Cath
 ;;^UTILITY(U,$J,358.3,2104,0)
 ;;=36000^^12^167^25^^^^1
 ;;^UTILITY(U,$J,358.3,2104,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2104,1,2,0)
 ;;=2^36000
 ;;^UTILITY(U,$J,358.3,2104,1,3,0)
 ;;=3^Placement of Needle in Vein
 ;;^UTILITY(U,$J,358.3,2105,0)
 ;;=36010^^12^167^24^^^^1
 ;;^UTILITY(U,$J,358.3,2105,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2105,1,2,0)
 ;;=2^36010
 ;;^UTILITY(U,$J,358.3,2105,1,3,0)
 ;;=3^Placement of Cath in Vein
 ;;^UTILITY(U,$J,358.3,2106,0)
 ;;=37187^^12^167^14^^^^1
