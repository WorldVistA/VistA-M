IBDEI05D ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1857,0)
 ;;=75731^^17^172^2^^^^1
 ;;^UTILITY(U,$J,358.3,1857,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1857,1,2,0)
 ;;=2^75731
 ;;^UTILITY(U,$J,358.3,1857,1,3,0)
 ;;=3^Adrenal Unilat Selective
 ;;^UTILITY(U,$J,358.3,1858,0)
 ;;=75733^^17^172^1^^^^1
 ;;^UTILITY(U,$J,358.3,1858,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1858,1,2,0)
 ;;=2^75733
 ;;^UTILITY(U,$J,358.3,1858,1,3,0)
 ;;=3^Adrenal Bilat Selective
 ;;^UTILITY(U,$J,358.3,1859,0)
 ;;=75736^^17^172^26^^^^1
 ;;^UTILITY(U,$J,358.3,1859,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1859,1,2,0)
 ;;=2^75736
 ;;^UTILITY(U,$J,358.3,1859,1,3,0)
 ;;=3^Pelvic Selective
 ;;^UTILITY(U,$J,358.3,1860,0)
 ;;=75741^^17^172^33^^^^1
 ;;^UTILITY(U,$J,358.3,1860,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1860,1,2,0)
 ;;=2^75741
 ;;^UTILITY(U,$J,358.3,1860,1,3,0)
 ;;=3^Pulmonary Unilat Selective
 ;;^UTILITY(U,$J,358.3,1861,0)
 ;;=75743^^17^172^31^^^^1
 ;;^UTILITY(U,$J,358.3,1861,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1861,1,2,0)
 ;;=2^75743
 ;;^UTILITY(U,$J,358.3,1861,1,3,0)
 ;;=3^Pulmonary Bilat Selective
 ;;^UTILITY(U,$J,358.3,1862,0)
 ;;=75746^^17^172^32^^^^1
 ;;^UTILITY(U,$J,358.3,1862,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1862,1,2,0)
 ;;=2^75746
 ;;^UTILITY(U,$J,358.3,1862,1,3,0)
 ;;=3^Pulmonary By Nonselective
 ;;^UTILITY(U,$J,358.3,1863,0)
 ;;=75756^^17^172^23^^^^1
 ;;^UTILITY(U,$J,358.3,1863,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1863,1,2,0)
 ;;=2^75756
 ;;^UTILITY(U,$J,358.3,1863,1,3,0)
 ;;=3^Internal Mammary
 ;;^UTILITY(U,$J,358.3,1864,0)
 ;;=37250^^17^172^24^^^^1
 ;;^UTILITY(U,$J,358.3,1864,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1864,1,2,0)
 ;;=2^37250
 ;;^UTILITY(U,$J,358.3,1864,1,3,0)
 ;;=3^Intravas Us,Non/Cor,Diag/Thera Interv, Each Ves
 ;;^UTILITY(U,$J,358.3,1865,0)
 ;;=35475^^17^172^27^^^^1
 ;;^UTILITY(U,$J,358.3,1865,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1865,1,2,0)
 ;;=2^35475
 ;;^UTILITY(U,$J,358.3,1865,1,3,0)
 ;;=3^Perc Angioplasty, Brachioceph Trunk/Branch, Each
 ;;^UTILITY(U,$J,358.3,1866,0)
 ;;=35471^^17^172^28^^^^1
 ;;^UTILITY(U,$J,358.3,1866,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1866,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,1866,1,3,0)
 ;;=3^Perc Angioplasty, Renal/Visc
 ;;^UTILITY(U,$J,358.3,1867,0)
 ;;=36215^^17^172^40^^^^1
 ;;^UTILITY(U,$J,358.3,1867,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1867,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,1867,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,1868,0)
 ;;=36011^^17^172^41^^^^1
 ;;^UTILITY(U,$J,358.3,1868,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1868,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1868,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jugular)
 ;;^UTILITY(U,$J,358.3,1869,0)
 ;;=36245^^17^172^37^^^^1
 ;;^UTILITY(U,$J,358.3,1869,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1869,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,1869,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,1870,0)
 ;;=36246^^17^172^38^^^^1
 ;;^UTILITY(U,$J,358.3,1870,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1870,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,1870,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,1871,0)
 ;;=36247^^17^172^39^^^^1
 ;;^UTILITY(U,$J,358.3,1871,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1871,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,1871,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,1872,0)
 ;;=75962^^17^172^51^^^^1
 ;;^UTILITY(U,$J,358.3,1872,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1872,1,2,0)
 ;;=2^75962
