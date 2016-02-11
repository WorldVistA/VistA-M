IBDEI05I ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1935,1,3,0)
 ;;=3^Endomyocardial Biopsy
 ;;^UTILITY(U,$J,358.3,1936,0)
 ;;=93464^^17^175^16^^^^1
 ;;^UTILITY(U,$J,358.3,1936,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1936,1,2,0)
 ;;=2^93464
 ;;^UTILITY(U,$J,358.3,1936,1,3,0)
 ;;=3^Phys Exercise Tst w/Hemodynamic Meas
 ;;^UTILITY(U,$J,358.3,1937,0)
 ;;=93564^^17^175^8^^^^1
 ;;^UTILITY(U,$J,358.3,1937,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1937,1,2,0)
 ;;=2^93564
 ;;^UTILITY(U,$J,358.3,1937,1,3,0)
 ;;=3^Inject Hrt Cong Cath Art/Grft
 ;;^UTILITY(U,$J,358.3,1938,0)
 ;;=93568^^17^175^9^^^^1
 ;;^UTILITY(U,$J,358.3,1938,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1938,1,2,0)
 ;;=2^93568
 ;;^UTILITY(U,$J,358.3,1938,1,3,0)
 ;;=3^Inject Pulm Art Hrt Cath
 ;;^UTILITY(U,$J,358.3,1939,0)
 ;;=93566^^17^175^10^^^^1
 ;;^UTILITY(U,$J,358.3,1939,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1939,1,2,0)
 ;;=2^93566
 ;;^UTILITY(U,$J,358.3,1939,1,3,0)
 ;;=3^Inject R Ventr/Atrial Angio
 ;;^UTILITY(U,$J,358.3,1940,0)
 ;;=93567^^17^175^11^^^^1
 ;;^UTILITY(U,$J,358.3,1940,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1940,1,2,0)
 ;;=2^93567
 ;;^UTILITY(U,$J,358.3,1940,1,3,0)
 ;;=3^Inject Suprvlv Aortography
 ;;^UTILITY(U,$J,358.3,1941,0)
 ;;=93532^^17^175^17^^^^1
 ;;^UTILITY(U,$J,358.3,1941,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1941,1,2,0)
 ;;=2^93532
 ;;^UTILITY(U,$J,358.3,1941,1,3,0)
 ;;=3^R&L HC for Congenital Card Anomalies
 ;;^UTILITY(U,$J,358.3,1942,0)
 ;;=93580^^17^175^24^^^^1
 ;;^UTILITY(U,$J,358.3,1942,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1942,1,2,0)
 ;;=2^93580
 ;;^UTILITY(U,$J,358.3,1942,1,3,0)
 ;;=3^Transcath Closure of ASD
 ;;^UTILITY(U,$J,358.3,1943,0)
 ;;=36100^^17^176^11^^^^1
 ;;^UTILITY(U,$J,358.3,1943,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1943,1,2,0)
 ;;=2^36100
 ;;^UTILITY(U,$J,358.3,1943,1,3,0)
 ;;=3^Intro Needle Or Cath Carotid Or Vert. Artery
 ;;^UTILITY(U,$J,358.3,1944,0)
 ;;=36120^^17^176^10^^^^1
 ;;^UTILITY(U,$J,358.3,1944,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1944,1,2,0)
 ;;=2^36120
 ;;^UTILITY(U,$J,358.3,1944,1,3,0)
 ;;=3^Intro Needle Or Cath Brachial Artery
 ;;^UTILITY(U,$J,358.3,1945,0)
 ;;=36140^^17^176^12^^^^1
 ;;^UTILITY(U,$J,358.3,1945,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1945,1,2,0)
 ;;=2^36140
 ;;^UTILITY(U,$J,358.3,1945,1,3,0)
 ;;=3^Intro Needle Or Cath Ext Artery
 ;;^UTILITY(U,$J,358.3,1946,0)
 ;;=36215^^17^176^40^^^^1
 ;;^UTILITY(U,$J,358.3,1946,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1946,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,1946,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,1947,0)
 ;;=36011^^17^176^41^^^^1
 ;;^UTILITY(U,$J,358.3,1947,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1947,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1947,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jug)
 ;;^UTILITY(U,$J,358.3,1948,0)
 ;;=36245^^17^176^35^^^^1
 ;;^UTILITY(U,$J,358.3,1948,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1948,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,1948,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1949,0)
 ;;=36246^^17^176^36^^^^1
 ;;^UTILITY(U,$J,358.3,1949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1949,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,1949,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1950,0)
 ;;=36247^^17^176^38^^^^1
 ;;^UTILITY(U,$J,358.3,1950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1950,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,1950,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1951,0)
 ;;=36216^^17^176^37^^^^1
