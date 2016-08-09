IBDEI02U ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2423,1,3,0)
 ;;=3^Rt Hrt Angio,Bypass Grft,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2424,0)
 ;;=93458^^15^176^3^^^^1
 ;;^UTILITY(U,$J,358.3,2424,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2424,1,2,0)
 ;;=2^93458
 ;;^UTILITY(U,$J,358.3,2424,1,3,0)
 ;;=3^Cor Angio, LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2425,0)
 ;;=93459^^15^176^13^^^^1
 ;;^UTILITY(U,$J,358.3,2425,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2425,1,2,0)
 ;;=2^93459
 ;;^UTILITY(U,$J,358.3,2425,1,3,0)
 ;;=3^Lt Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2426,0)
 ;;=93460^^15^176^4^^^^1
 ;;^UTILITY(U,$J,358.3,2426,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2426,1,2,0)
 ;;=2^93460
 ;;^UTILITY(U,$J,358.3,2426,1,3,0)
 ;;=3^Cor Angio, RHC/LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2427,0)
 ;;=93461^^15^176^19^^^^1
 ;;^UTILITY(U,$J,358.3,2427,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2427,1,2,0)
 ;;=2^93461
 ;;^UTILITY(U,$J,358.3,2427,1,3,0)
 ;;=3^R&L Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2428,0)
 ;;=93462^^15^176^14^^^^1
 ;;^UTILITY(U,$J,358.3,2428,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2428,1,2,0)
 ;;=2^93462
 ;;^UTILITY(U,$J,358.3,2428,1,3,0)
 ;;=3^Lt Hrt Cath Trnsptl Puncture
 ;;^UTILITY(U,$J,358.3,2429,0)
 ;;=93561^^15^176^7^^^^1
 ;;^UTILITY(U,$J,358.3,2429,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2429,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,2429,1,3,0)
 ;;=3^Indicator Dilution Study-Arterial/Ven
 ;;^UTILITY(U,$J,358.3,2430,0)
 ;;=93562^^15^176^22^^^^1
 ;;^UTILITY(U,$J,358.3,2430,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2430,1,2,0)
 ;;=2^93562
 ;;^UTILITY(U,$J,358.3,2430,1,3,0)
 ;;=3^Subsq Measure of Cardiac Output
 ;;^UTILITY(U,$J,358.3,2431,0)
 ;;=93463^^15^176^15^^^^1
 ;;^UTILITY(U,$J,358.3,2431,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2431,1,2,0)
 ;;=2^93463
 ;;^UTILITY(U,$J,358.3,2431,1,3,0)
 ;;=3^Pharm agent admin, when performed
 ;;^UTILITY(U,$J,358.3,2432,0)
 ;;=93505^^15^176^6^^^^1
 ;;^UTILITY(U,$J,358.3,2432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2432,1,2,0)
 ;;=2^93505
 ;;^UTILITY(U,$J,358.3,2432,1,3,0)
 ;;=3^Endomyocardial Biopsy
 ;;^UTILITY(U,$J,358.3,2433,0)
 ;;=93464^^15^176^16^^^^1
 ;;^UTILITY(U,$J,358.3,2433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2433,1,2,0)
 ;;=2^93464
 ;;^UTILITY(U,$J,358.3,2433,1,3,0)
 ;;=3^Phys Exercise Tst w/Hemodynamic Meas
 ;;^UTILITY(U,$J,358.3,2434,0)
 ;;=93564^^15^176^8^^^^1
 ;;^UTILITY(U,$J,358.3,2434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2434,1,2,0)
 ;;=2^93564
 ;;^UTILITY(U,$J,358.3,2434,1,3,0)
 ;;=3^Inject Hrt Cong Cath Art/Grft
 ;;^UTILITY(U,$J,358.3,2435,0)
 ;;=93568^^15^176^9^^^^1
 ;;^UTILITY(U,$J,358.3,2435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2435,1,2,0)
 ;;=2^93568
 ;;^UTILITY(U,$J,358.3,2435,1,3,0)
 ;;=3^Inject Pulm Art Hrt Cath
 ;;^UTILITY(U,$J,358.3,2436,0)
 ;;=93566^^15^176^10^^^^1
 ;;^UTILITY(U,$J,358.3,2436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2436,1,2,0)
 ;;=2^93566
 ;;^UTILITY(U,$J,358.3,2436,1,3,0)
 ;;=3^Inject R Ventr/Atrial Angio
 ;;^UTILITY(U,$J,358.3,2437,0)
 ;;=93567^^15^176^11^^^^1
 ;;^UTILITY(U,$J,358.3,2437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2437,1,2,0)
 ;;=2^93567
 ;;^UTILITY(U,$J,358.3,2437,1,3,0)
 ;;=3^Inject Suprvlv Aortography
 ;;^UTILITY(U,$J,358.3,2438,0)
 ;;=93532^^15^176^17^^^^1
 ;;^UTILITY(U,$J,358.3,2438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2438,1,2,0)
 ;;=2^93532
 ;;^UTILITY(U,$J,358.3,2438,1,3,0)
 ;;=3^R&L HC for Congenital Card Anomalies
 ;;^UTILITY(U,$J,358.3,2439,0)
 ;;=93580^^15^176^24^^^^1
 ;;^UTILITY(U,$J,358.3,2439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2439,1,2,0)
 ;;=2^93580
 ;;^UTILITY(U,$J,358.3,2439,1,3,0)
 ;;=3^Transcath Closure of ASD
 ;;^UTILITY(U,$J,358.3,2440,0)
 ;;=36100^^15^177^11^^^^1
 ;;^UTILITY(U,$J,358.3,2440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2440,1,2,0)
 ;;=2^36100
 ;;^UTILITY(U,$J,358.3,2440,1,3,0)
 ;;=3^Intro Needle Or Cath Carotid Or Vert. Artery
 ;;^UTILITY(U,$J,358.3,2441,0)
 ;;=36120^^15^177^10^^^^1
 ;;^UTILITY(U,$J,358.3,2441,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2441,1,2,0)
 ;;=2^36120
 ;;^UTILITY(U,$J,358.3,2441,1,3,0)
 ;;=3^Intro Needle Or Cath Brachial Artery
 ;;^UTILITY(U,$J,358.3,2442,0)
 ;;=36140^^15^177^12^^^^1
 ;;^UTILITY(U,$J,358.3,2442,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2442,1,2,0)
 ;;=2^36140
 ;;^UTILITY(U,$J,358.3,2442,1,3,0)
 ;;=3^Intro Needle Or Cath Ext Artery
 ;;^UTILITY(U,$J,358.3,2443,0)
 ;;=36215^^15^177^40^^^^1
 ;;^UTILITY(U,$J,358.3,2443,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2443,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,2443,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,2444,0)
 ;;=36011^^15^177^41^^^^1
 ;;^UTILITY(U,$J,358.3,2444,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2444,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,2444,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jug)
 ;;^UTILITY(U,$J,358.3,2445,0)
 ;;=36245^^15^177^35^^^^1
 ;;^UTILITY(U,$J,358.3,2445,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2445,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,2445,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,2446,0)
 ;;=36246^^15^177^36^^^^1
 ;;^UTILITY(U,$J,358.3,2446,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2446,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,2446,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,2447,0)
 ;;=36247^^15^177^38^^^^1
 ;;^UTILITY(U,$J,358.3,2447,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2447,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,2447,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,2448,0)
 ;;=36216^^15^177^37^^^^1
 ;;^UTILITY(U,$J,358.3,2448,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2448,1,2,0)
 ;;=2^36216
 ;;^UTILITY(U,$J,358.3,2448,1,3,0)
 ;;=3^Select Cath 2nd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,2449,0)
 ;;=36217^^15^177^39^^^^1
 ;;^UTILITY(U,$J,358.3,2449,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2449,1,2,0)
 ;;=2^36217
 ;;^UTILITY(U,$J,358.3,2449,1,3,0)
 ;;=3^Select Cath 3rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,2450,0)
 ;;=36218^^15^177^5^^^^1
 ;;^UTILITY(U,$J,358.3,2450,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2450,1,2,0)
 ;;=2^36218
 ;;^UTILITY(U,$J,358.3,2450,1,3,0)
 ;;=3^Each Addl 2nd/3rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,2451,0)
 ;;=36248^^15^177^4^^^^1
 ;;^UTILITY(U,$J,358.3,2451,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2451,1,2,0)
 ;;=2^36248
 ;;^UTILITY(U,$J,358.3,2451,1,3,0)
 ;;=3^Each Addl 2nd/3rd Order Pelvic/Le
 ;;^UTILITY(U,$J,358.3,2452,0)
 ;;=36200^^15^177^13^^^^1
 ;;^UTILITY(U,$J,358.3,2452,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2452,1,2,0)
 ;;=2^36200
 ;;^UTILITY(U,$J,358.3,2452,1,3,0)
 ;;=3^Non-Select Cath, Aorta
 ;;^UTILITY(U,$J,358.3,2453,0)
 ;;=33010^^15^177^56^^^^1
 ;;^UTILITY(U,$J,358.3,2453,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2453,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,2453,1,3,0)
 ;;=3^Visceral Selective
 ;;^UTILITY(U,$J,358.3,2454,0)
 ;;=35471^^15^177^31^^^^1
 ;;^UTILITY(U,$J,358.3,2454,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2454,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,2454,1,3,0)
 ;;=3^Repair Arterial Blockage
 ;;^UTILITY(U,$J,358.3,2455,0)
 ;;=35475^^15^177^15^^^^1
 ;;^UTILITY(U,$J,358.3,2455,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2455,1,2,0)
 ;;=2^35475
 ;;^UTILITY(U,$J,358.3,2455,1,3,0)
 ;;=3^Pelvic Selective
 ;;^UTILITY(U,$J,358.3,2456,0)
 ;;=36005^^15^177^6^^^^1
 ;;^UTILITY(U,$J,358.3,2456,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2456,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,2456,1,3,0)
 ;;=3^Injection Ext Venography
 ;;^UTILITY(U,$J,358.3,2457,0)
 ;;=36147^^15^177^1^^^^1
