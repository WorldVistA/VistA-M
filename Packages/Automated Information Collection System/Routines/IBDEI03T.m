IBDEI03T ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1461,1,2,0)
 ;;=2^93459
 ;;^UTILITY(U,$J,358.3,1461,1,3,0)
 ;;=3^Lt Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1462,0)
 ;;=93460^^14^135^4^^^^1
 ;;^UTILITY(U,$J,358.3,1462,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1462,1,2,0)
 ;;=2^93460
 ;;^UTILITY(U,$J,358.3,1462,1,3,0)
 ;;=3^Cor Angio, RHC/LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1463,0)
 ;;=93461^^14^135^14^^^^1
 ;;^UTILITY(U,$J,358.3,1463,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1463,1,2,0)
 ;;=2^93461
 ;;^UTILITY(U,$J,358.3,1463,1,3,0)
 ;;=3^R&L Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1464,0)
 ;;=93462^^14^135^10^^^^1
 ;;^UTILITY(U,$J,358.3,1464,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1464,1,2,0)
 ;;=2^93462
 ;;^UTILITY(U,$J,358.3,1464,1,3,0)
 ;;=3^Lt Hrt Cath Trnsptl Puncture
 ;;^UTILITY(U,$J,358.3,1465,0)
 ;;=93561^^14^135^7^^^^1
 ;;^UTILITY(U,$J,358.3,1465,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1465,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,1465,1,3,0)
 ;;=3^Indicator Dilution Study-Arterial/Ven
 ;;^UTILITY(U,$J,358.3,1466,0)
 ;;=93562^^14^135^17^^^^1
 ;;^UTILITY(U,$J,358.3,1466,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1466,1,2,0)
 ;;=2^93562
 ;;^UTILITY(U,$J,358.3,1466,1,3,0)
 ;;=3^Subsq Measure of Cardiac Output
 ;;^UTILITY(U,$J,358.3,1467,0)
 ;;=93463^^14^135^11^^^^1
 ;;^UTILITY(U,$J,358.3,1467,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1467,1,2,0)
 ;;=2^93463
 ;;^UTILITY(U,$J,358.3,1467,1,3,0)
 ;;=3^Pharm agent admin, when performed
 ;;^UTILITY(U,$J,358.3,1468,0)
 ;;=93505^^14^135^6^^^^1
 ;;^UTILITY(U,$J,358.3,1468,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1468,1,2,0)
 ;;=2^93505
 ;;^UTILITY(U,$J,358.3,1468,1,3,0)
 ;;=3^Endomyocardial Biopsy
 ;;^UTILITY(U,$J,358.3,1469,0)
 ;;=93464^^14^135^12^^^^1
 ;;^UTILITY(U,$J,358.3,1469,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1469,1,2,0)
 ;;=2^93464
 ;;^UTILITY(U,$J,358.3,1469,1,3,0)
 ;;=3^Phys Exercise Tst w/Hemodynamic Meas
 ;;^UTILITY(U,$J,358.3,1470,0)
 ;;=36100^^14^136^10^^^^1
 ;;^UTILITY(U,$J,358.3,1470,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1470,1,2,0)
 ;;=2^36100
 ;;^UTILITY(U,$J,358.3,1470,1,3,0)
 ;;=3^Intro Needle Or Cath Carotid Or Vert. Artery
 ;;^UTILITY(U,$J,358.3,1471,0)
 ;;=36120^^14^136^9^^^^1
 ;;^UTILITY(U,$J,358.3,1471,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1471,1,2,0)
 ;;=2^36120
 ;;^UTILITY(U,$J,358.3,1471,1,3,0)
 ;;=3^Intro Needle Or Cath Brachial Artery
 ;;^UTILITY(U,$J,358.3,1472,0)
 ;;=36140^^14^136^11^^^^1
 ;;^UTILITY(U,$J,358.3,1472,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1472,1,2,0)
 ;;=2^36140
 ;;^UTILITY(U,$J,358.3,1472,1,3,0)
 ;;=3^Intro Needle Or Cath Ext Artery
 ;;^UTILITY(U,$J,358.3,1473,0)
 ;;=36215^^14^136^34^^^^1
 ;;^UTILITY(U,$J,358.3,1473,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1473,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,1473,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,1474,0)
 ;;=36011^^14^136^35^^^^1
 ;;^UTILITY(U,$J,358.3,1474,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1474,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1474,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jug)
 ;;^UTILITY(U,$J,358.3,1475,0)
 ;;=36245^^14^136^29^^^^1
 ;;^UTILITY(U,$J,358.3,1475,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1475,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,1475,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1476,0)
 ;;=36246^^14^136^30^^^^1
 ;;^UTILITY(U,$J,358.3,1476,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1476,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,1476,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelvic/Le Artery
