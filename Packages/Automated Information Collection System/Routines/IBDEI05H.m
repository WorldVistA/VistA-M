IBDEI05H ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1920,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1920,1,2,0)
 ;;=2^93451
 ;;^UTILITY(U,$J,358.3,1920,1,3,0)
 ;;=3^Right Hrt Cath incl O2 & Cardiac Outpt
 ;;^UTILITY(U,$J,358.3,1921,0)
 ;;=93452^^17^175^12^^^^1
 ;;^UTILITY(U,$J,358.3,1921,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1921,1,2,0)
 ;;=2^93452
 ;;^UTILITY(U,$J,358.3,1921,1,3,0)
 ;;=3^LHC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,1922,0)
 ;;=93453^^17^175^18^^^^1
 ;;^UTILITY(U,$J,358.3,1922,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1922,1,2,0)
 ;;=2^93453
 ;;^UTILITY(U,$J,358.3,1922,1,3,0)
 ;;=3^R&L HC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,1923,0)
 ;;=93454^^17^175^5^^^^1
 ;;^UTILITY(U,$J,358.3,1923,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1923,1,2,0)
 ;;=2^93454
 ;;^UTILITY(U,$J,358.3,1923,1,3,0)
 ;;=3^Coronary Angiography, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1924,0)
 ;;=93455^^17^175^1^^^^1
 ;;^UTILITY(U,$J,358.3,1924,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1924,1,2,0)
 ;;=2^93455
 ;;^UTILITY(U,$J,358.3,1924,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and Bypass angio
 ;;^UTILITY(U,$J,358.3,1925,0)
 ;;=93456^^17^175^2^^^^1
 ;;^UTILITY(U,$J,358.3,1925,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1925,1,2,0)
 ;;=2^93456
 ;;^UTILITY(U,$J,358.3,1925,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and R Heart Cath
 ;;^UTILITY(U,$J,358.3,1926,0)
 ;;=93457^^17^175^21^^^^1
 ;;^UTILITY(U,$J,358.3,1926,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1926,1,2,0)
 ;;=2^93457
 ;;^UTILITY(U,$J,358.3,1926,1,3,0)
 ;;=3^Rt Hrt Angio,Bypass Grft,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1927,0)
 ;;=93458^^17^175^3^^^^1
 ;;^UTILITY(U,$J,358.3,1927,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1927,1,2,0)
 ;;=2^93458
 ;;^UTILITY(U,$J,358.3,1927,1,3,0)
 ;;=3^Cor Angio, LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1928,0)
 ;;=93459^^17^175^13^^^^1
 ;;^UTILITY(U,$J,358.3,1928,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1928,1,2,0)
 ;;=2^93459
 ;;^UTILITY(U,$J,358.3,1928,1,3,0)
 ;;=3^Lt Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1929,0)
 ;;=93460^^17^175^4^^^^1
 ;;^UTILITY(U,$J,358.3,1929,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1929,1,2,0)
 ;;=2^93460
 ;;^UTILITY(U,$J,358.3,1929,1,3,0)
 ;;=3^Cor Angio, RHC/LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1930,0)
 ;;=93461^^17^175^19^^^^1
 ;;^UTILITY(U,$J,358.3,1930,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1930,1,2,0)
 ;;=2^93461
 ;;^UTILITY(U,$J,358.3,1930,1,3,0)
 ;;=3^R&L Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1931,0)
 ;;=93462^^17^175^14^^^^1
 ;;^UTILITY(U,$J,358.3,1931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1931,1,2,0)
 ;;=2^93462
 ;;^UTILITY(U,$J,358.3,1931,1,3,0)
 ;;=3^Lt Hrt Cath Trnsptl Puncture
 ;;^UTILITY(U,$J,358.3,1932,0)
 ;;=93561^^17^175^7^^^^1
 ;;^UTILITY(U,$J,358.3,1932,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1932,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,1932,1,3,0)
 ;;=3^Indicator Dilution Study-Arterial/Ven
 ;;^UTILITY(U,$J,358.3,1933,0)
 ;;=93562^^17^175^22^^^^1
 ;;^UTILITY(U,$J,358.3,1933,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1933,1,2,0)
 ;;=2^93562
 ;;^UTILITY(U,$J,358.3,1933,1,3,0)
 ;;=3^Subsq Measure of Cardiac Output
 ;;^UTILITY(U,$J,358.3,1934,0)
 ;;=93463^^17^175^15^^^^1
 ;;^UTILITY(U,$J,358.3,1934,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1934,1,2,0)
 ;;=2^93463
 ;;^UTILITY(U,$J,358.3,1934,1,3,0)
 ;;=3^Pharm agent admin, when performed
 ;;^UTILITY(U,$J,358.3,1935,0)
 ;;=93505^^17^175^6^^^^1
 ;;^UTILITY(U,$J,358.3,1935,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1935,1,2,0)
 ;;=2^93505
