IBDEI057 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1760,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Single
 ;;^UTILITY(U,$J,358.3,1761,0)
 ;;=33228^^17^169^48^^^^1
 ;;^UTILITY(U,$J,358.3,1761,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1761,1,2,0)
 ;;=2^33228
 ;;^UTILITY(U,$J,358.3,1761,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Dual
 ;;^UTILITY(U,$J,358.3,1762,0)
 ;;=33229^^17^169^49^^^^1
 ;;^UTILITY(U,$J,358.3,1762,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1762,1,2,0)
 ;;=2^33229
 ;;^UTILITY(U,$J,358.3,1762,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Mult
 ;;^UTILITY(U,$J,358.3,1763,0)
 ;;=33230^^17^169^19^^^^1
 ;;^UTILITY(U,$J,358.3,1763,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1763,1,2,0)
 ;;=2^33230
 ;;^UTILITY(U,$J,358.3,1763,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Single
 ;;^UTILITY(U,$J,358.3,1764,0)
 ;;=33231^^17^169^18^^^^1
 ;;^UTILITY(U,$J,358.3,1764,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1764,1,2,0)
 ;;=2^33231
 ;;^UTILITY(U,$J,358.3,1764,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Mult
 ;;^UTILITY(U,$J,358.3,1765,0)
 ;;=33233^^17^169^44^^^^1
 ;;^UTILITY(U,$J,358.3,1765,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1765,1,2,0)
 ;;=2^33233
 ;;^UTILITY(U,$J,358.3,1765,1,3,0)
 ;;=3^Removal of PM Generator Only
 ;;^UTILITY(U,$J,358.3,1766,0)
 ;;=33262^^17^169^54^^^^1
 ;;^UTILITY(U,$J,358.3,1766,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1766,1,2,0)
 ;;=2^33262
 ;;^UTILITY(U,$J,358.3,1766,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Single
 ;;^UTILITY(U,$J,358.3,1767,0)
 ;;=33263^^17^169^52^^^^1
 ;;^UTILITY(U,$J,358.3,1767,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1767,1,2,0)
 ;;=2^33263
 ;;^UTILITY(U,$J,358.3,1767,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Dual
 ;;^UTILITY(U,$J,358.3,1768,0)
 ;;=33264^^17^169^53^^^^1
 ;;^UTILITY(U,$J,358.3,1768,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1768,1,2,0)
 ;;=2^33264
 ;;^UTILITY(U,$J,358.3,1768,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Multiple
 ;;^UTILITY(U,$J,358.3,1769,0)
 ;;=93286^^17^169^40^^^^1
 ;;^UTILITY(U,$J,358.3,1769,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1769,1,2,0)
 ;;=2^93286
 ;;^UTILITY(U,$J,358.3,1769,1,3,0)
 ;;=3^Pre-Op PM Device Eval w/Review&Rpt
 ;;^UTILITY(U,$J,358.3,1770,0)
 ;;=93287^^17^169^39^^^^1
 ;;^UTILITY(U,$J,358.3,1770,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1770,1,2,0)
 ;;=2^93287
 ;;^UTILITY(U,$J,358.3,1770,1,3,0)
 ;;=3^Pre-Op ICD Device Eval
 ;;^UTILITY(U,$J,358.3,1771,0)
 ;;=93290^^17^169^12^^^^1
 ;;^UTILITY(U,$J,358.3,1771,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1771,1,2,0)
 ;;=2^93290
 ;;^UTILITY(U,$J,358.3,1771,1,3,0)
 ;;=3^ICM Device Eval
 ;;^UTILITY(U,$J,358.3,1772,0)
 ;;=93293^^17^169^35^^^^1
 ;;^UTILITY(U,$J,358.3,1772,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1772,1,2,0)
 ;;=2^93293
 ;;^UTILITY(U,$J,358.3,1772,1,3,0)
 ;;=3^PM Phone R-Strip Device Eval
 ;;^UTILITY(U,$J,358.3,1773,0)
 ;;=33223^^17^169^59^^^^1
 ;;^UTILITY(U,$J,358.3,1773,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1773,1,2,0)
 ;;=2^33223
 ;;^UTILITY(U,$J,358.3,1773,1,3,0)
 ;;=3^Revision Skin Pckt, ICD
 ;;^UTILITY(U,$J,358.3,1774,0)
 ;;=33224^^17^169^25^^^^1
 ;;^UTILITY(U,$J,358.3,1774,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1774,1,2,0)
 ;;=2^33224
 ;;^UTILITY(U,$J,358.3,1774,1,3,0)
 ;;=3^Insertion of Pacing Electrode
 ;;^UTILITY(U,$J,358.3,1775,0)
 ;;=33214^^17^169^65^^^^1
 ;;^UTILITY(U,$J,358.3,1775,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1775,1,2,0)
 ;;=2^33214
 ;;^UTILITY(U,$J,358.3,1775,1,3,0)
 ;;=3^Upgrade Sng to Dual PM System
 ;;^UTILITY(U,$J,358.3,1776,0)
 ;;=33215^^17^169^57^^^^1
 ;;^UTILITY(U,$J,358.3,1776,1,0)
 ;;=^358.31IA^3^2
