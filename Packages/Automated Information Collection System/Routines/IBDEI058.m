IBDEI058 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2059,0)
 ;;=93462^^12^166^14^^^^1
 ;;^UTILITY(U,$J,358.3,2059,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2059,1,2,0)
 ;;=2^93462
 ;;^UTILITY(U,$J,358.3,2059,1,3,0)
 ;;=3^Lt Hrt Cath Trnsptl Puncture
 ;;^UTILITY(U,$J,358.3,2060,0)
 ;;=93561^^12^166^7^^^^1
 ;;^UTILITY(U,$J,358.3,2060,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2060,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,2060,1,3,0)
 ;;=3^Indicator Dilution Study-Arterial/Ven
 ;;^UTILITY(U,$J,358.3,2061,0)
 ;;=93562^^12^166^22^^^^1
 ;;^UTILITY(U,$J,358.3,2061,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2061,1,2,0)
 ;;=2^93562
 ;;^UTILITY(U,$J,358.3,2061,1,3,0)
 ;;=3^Subsq Measure of Cardiac Output
 ;;^UTILITY(U,$J,358.3,2062,0)
 ;;=93463^^12^166^15^^^^1
 ;;^UTILITY(U,$J,358.3,2062,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2062,1,2,0)
 ;;=2^93463
 ;;^UTILITY(U,$J,358.3,2062,1,3,0)
 ;;=3^Pharm agent admin, when performed
 ;;^UTILITY(U,$J,358.3,2063,0)
 ;;=93505^^12^166^6^^^^1
 ;;^UTILITY(U,$J,358.3,2063,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2063,1,2,0)
 ;;=2^93505
 ;;^UTILITY(U,$J,358.3,2063,1,3,0)
 ;;=3^Endomyocardial Biopsy
 ;;^UTILITY(U,$J,358.3,2064,0)
 ;;=93464^^12^166^16^^^^1
 ;;^UTILITY(U,$J,358.3,2064,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2064,1,2,0)
 ;;=2^93464
 ;;^UTILITY(U,$J,358.3,2064,1,3,0)
 ;;=3^Phys Exercise Tst w/Hemodynamic Meas
 ;;^UTILITY(U,$J,358.3,2065,0)
 ;;=93564^^12^166^8^^^^1
 ;;^UTILITY(U,$J,358.3,2065,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2065,1,2,0)
 ;;=2^93564
 ;;^UTILITY(U,$J,358.3,2065,1,3,0)
 ;;=3^Inject Hrt Cong Cath Art/Grft
 ;;^UTILITY(U,$J,358.3,2066,0)
 ;;=93568^^12^166^9^^^^1
 ;;^UTILITY(U,$J,358.3,2066,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2066,1,2,0)
 ;;=2^93568
 ;;^UTILITY(U,$J,358.3,2066,1,3,0)
 ;;=3^Inject Pulm Art Hrt Cath
 ;;^UTILITY(U,$J,358.3,2067,0)
 ;;=93566^^12^166^10^^^^1
 ;;^UTILITY(U,$J,358.3,2067,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2067,1,2,0)
 ;;=2^93566
 ;;^UTILITY(U,$J,358.3,2067,1,3,0)
 ;;=3^Inject R Ventr/Atrial Angio
 ;;^UTILITY(U,$J,358.3,2068,0)
 ;;=93567^^12^166^11^^^^1
 ;;^UTILITY(U,$J,358.3,2068,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2068,1,2,0)
 ;;=2^93567
 ;;^UTILITY(U,$J,358.3,2068,1,3,0)
 ;;=3^Inject Suprvlv Aortography
 ;;^UTILITY(U,$J,358.3,2069,0)
 ;;=93532^^12^166^17^^^^1
 ;;^UTILITY(U,$J,358.3,2069,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2069,1,2,0)
 ;;=2^93532
 ;;^UTILITY(U,$J,358.3,2069,1,3,0)
 ;;=3^R&L HC for Congenital Card Anomalies
 ;;^UTILITY(U,$J,358.3,2070,0)
 ;;=93580^^12^166^24^^^^1
 ;;^UTILITY(U,$J,358.3,2070,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2070,1,2,0)
 ;;=2^93580
 ;;^UTILITY(U,$J,358.3,2070,1,3,0)
 ;;=3^Transcath Closure of ASD
 ;;^UTILITY(U,$J,358.3,2071,0)
 ;;=36100^^12^167^11^^^^1
 ;;^UTILITY(U,$J,358.3,2071,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2071,1,2,0)
 ;;=2^36100
 ;;^UTILITY(U,$J,358.3,2071,1,3,0)
 ;;=3^Intro Needle Or Cath Carotid Or Vert. Artery
 ;;^UTILITY(U,$J,358.3,2072,0)
 ;;=36120^^12^167^10^^^^1
 ;;^UTILITY(U,$J,358.3,2072,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2072,1,2,0)
 ;;=2^36120
 ;;^UTILITY(U,$J,358.3,2072,1,3,0)
 ;;=3^Intro Needle Or Cath Brachial Artery
 ;;^UTILITY(U,$J,358.3,2073,0)
 ;;=36140^^12^167^12^^^^1
 ;;^UTILITY(U,$J,358.3,2073,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2073,1,2,0)
 ;;=2^36140
 ;;^UTILITY(U,$J,358.3,2073,1,3,0)
 ;;=3^Intro Needle Or Cath Ext Artery
 ;;^UTILITY(U,$J,358.3,2074,0)
 ;;=36215^^12^167^40^^^^1
 ;;^UTILITY(U,$J,358.3,2074,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2074,1,2,0)
 ;;=2^36215
