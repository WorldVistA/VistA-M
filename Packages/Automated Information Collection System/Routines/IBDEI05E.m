IBDEI05E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1872,1,3,0)
 ;;=3^Tranlum Ball Angio,Periph Art,Rad S&I
 ;;^UTILITY(U,$J,358.3,1873,0)
 ;;=75964^^17^172^53^^^^1
 ;;^UTILITY(U,$J,358.3,1873,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1873,1,2,0)
 ;;=2^75964
 ;;^UTILITY(U,$J,358.3,1873,1,3,0)
 ;;=3^Tranlum Ball Angio,Venous Art,Rad S&I,Ea Addl Artery
 ;;^UTILITY(U,$J,358.3,1874,0)
 ;;=75791^^17^172^9^^^^1
 ;;^UTILITY(U,$J,358.3,1874,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1874,1,2,0)
 ;;=2^75791
 ;;^UTILITY(U,$J,358.3,1874,1,3,0)
 ;;=3^Arteriovenous Shunt
 ;;^UTILITY(U,$J,358.3,1875,0)
 ;;=37220^^17^172^20^^^^1
 ;;^UTILITY(U,$J,358.3,1875,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1875,1,2,0)
 ;;=2^37220
 ;;^UTILITY(U,$J,358.3,1875,1,3,0)
 ;;=3^Iliac Revasc,Unilat,1st Vessel
 ;;^UTILITY(U,$J,358.3,1876,0)
 ;;=37221^^17^172^18^^^^1
 ;;^UTILITY(U,$J,358.3,1876,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1876,1,2,0)
 ;;=2^37221
 ;;^UTILITY(U,$J,358.3,1876,1,3,0)
 ;;=3^Iliac Revasc w/ Stent
 ;;^UTILITY(U,$J,358.3,1877,0)
 ;;=37222^^17^172^21^^^^1
 ;;^UTILITY(U,$J,358.3,1877,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1877,1,2,0)
 ;;=2^37222
 ;;^UTILITY(U,$J,358.3,1877,1,3,0)
 ;;=3^Iliac Revasc,ea add Vessel
 ;;^UTILITY(U,$J,358.3,1878,0)
 ;;=37223^^17^172^19^^^^1
 ;;^UTILITY(U,$J,358.3,1878,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1878,1,2,0)
 ;;=2^37223
 ;;^UTILITY(U,$J,358.3,1878,1,3,0)
 ;;=3^Iliac Revasc w/ Stent,Add-on
 ;;^UTILITY(U,$J,358.3,1879,0)
 ;;=37224^^17^172^15^^^^1
 ;;^UTILITY(U,$J,358.3,1879,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1879,1,2,0)
 ;;=2^37224
 ;;^UTILITY(U,$J,358.3,1879,1,3,0)
 ;;=3^Fem/Popl Revas w/ TLA 1st Vessel
 ;;^UTILITY(U,$J,358.3,1880,0)
 ;;=37225^^17^172^14^^^^1
 ;;^UTILITY(U,$J,358.3,1880,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1880,1,2,0)
 ;;=2^37225
 ;;^UTILITY(U,$J,358.3,1880,1,3,0)
 ;;=3^Fem/Popl Revas w/ Ather
 ;;^UTILITY(U,$J,358.3,1881,0)
 ;;=37226^^17^172^16^^^^1
 ;;^UTILITY(U,$J,358.3,1881,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1881,1,2,0)
 ;;=2^37226
 ;;^UTILITY(U,$J,358.3,1881,1,3,0)
 ;;=3^Fem/Popl Revasc w/ Stent
 ;;^UTILITY(U,$J,358.3,1882,0)
 ;;=37227^^17^172^17^^^^1
 ;;^UTILITY(U,$J,358.3,1882,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1882,1,2,0)
 ;;=2^37227
 ;;^UTILITY(U,$J,358.3,1882,1,3,0)
 ;;=3^Fem/Popl Revasc w/ Stent & Ather
 ;;^UTILITY(U,$J,358.3,1883,0)
 ;;=37228^^17^172^49^^^^1
 ;;^UTILITY(U,$J,358.3,1883,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1883,1,2,0)
 ;;=2^37228
 ;;^UTILITY(U,$J,358.3,1883,1,3,0)
 ;;=3^TIB/Per Revasc w/ TLA,1st Vessel
 ;;^UTILITY(U,$J,358.3,1884,0)
 ;;=37229^^17^172^44^^^^1
 ;;^UTILITY(U,$J,358.3,1884,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1884,1,2,0)
 ;;=2^37229
 ;;^UTILITY(U,$J,358.3,1884,1,3,0)
 ;;=3^TIB/Per Revasc w/ Ather
 ;;^UTILITY(U,$J,358.3,1885,0)
 ;;=37230^^17^172^46^^^^1
 ;;^UTILITY(U,$J,358.3,1885,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1885,1,2,0)
 ;;=2^37230
 ;;^UTILITY(U,$J,358.3,1885,1,3,0)
 ;;=3^TIB/Per Revasc w/ Stent
 ;;^UTILITY(U,$J,358.3,1886,0)
 ;;=37231^^17^172^43^^^^1
 ;;^UTILITY(U,$J,358.3,1886,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1886,1,2,0)
 ;;=2^37231
 ;;^UTILITY(U,$J,358.3,1886,1,3,0)
 ;;=3^TIB/Per Revasc Stent & Ather
 ;;^UTILITY(U,$J,358.3,1887,0)
 ;;=37232^^17^172^50^^^^1
 ;;^UTILITY(U,$J,358.3,1887,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1887,1,2,0)
 ;;=2^37232
 ;;^UTILITY(U,$J,358.3,1887,1,3,0)
 ;;=3^TIB/Per Revasc,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,1888,0)
 ;;=37233^^17^172^45^^^^1
 ;;^UTILITY(U,$J,358.3,1888,1,0)
 ;;=^358.31IA^3^2
