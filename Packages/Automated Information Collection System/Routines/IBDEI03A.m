IBDEI03A ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1138,1,3,0)
 ;;=3^Lt Hrt Cath Trnsptl Puncture
 ;;^UTILITY(U,$J,358.3,1139,0)
 ;;=93561^^10^109^7^^^^1
 ;;^UTILITY(U,$J,358.3,1139,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1139,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,1139,1,3,0)
 ;;=3^Indicator Dilution Study-Arterial/Ven
 ;;^UTILITY(U,$J,358.3,1140,0)
 ;;=93562^^10^109^22^^^^1
 ;;^UTILITY(U,$J,358.3,1140,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1140,1,2,0)
 ;;=2^93562
 ;;^UTILITY(U,$J,358.3,1140,1,3,0)
 ;;=3^Subsq Measure of Cardiac Output
 ;;^UTILITY(U,$J,358.3,1141,0)
 ;;=93463^^10^109^15^^^^1
 ;;^UTILITY(U,$J,358.3,1141,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1141,1,2,0)
 ;;=2^93463
 ;;^UTILITY(U,$J,358.3,1141,1,3,0)
 ;;=3^Pharm agent admin, when performed
 ;;^UTILITY(U,$J,358.3,1142,0)
 ;;=93505^^10^109^6^^^^1
 ;;^UTILITY(U,$J,358.3,1142,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1142,1,2,0)
 ;;=2^93505
 ;;^UTILITY(U,$J,358.3,1142,1,3,0)
 ;;=3^Endomyocardial Biopsy
 ;;^UTILITY(U,$J,358.3,1143,0)
 ;;=93464^^10^109^16^^^^1
 ;;^UTILITY(U,$J,358.3,1143,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1143,1,2,0)
 ;;=2^93464
 ;;^UTILITY(U,$J,358.3,1143,1,3,0)
 ;;=3^Phys Exercise Tst w/Hemodynamic Meas
 ;;^UTILITY(U,$J,358.3,1144,0)
 ;;=93564^^10^109^8^^^^1
 ;;^UTILITY(U,$J,358.3,1144,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1144,1,2,0)
 ;;=2^93564
 ;;^UTILITY(U,$J,358.3,1144,1,3,0)
 ;;=3^Inject Hrt Cong Cath Art/Grft
 ;;^UTILITY(U,$J,358.3,1145,0)
 ;;=93568^^10^109^9^^^^1
 ;;^UTILITY(U,$J,358.3,1145,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1145,1,2,0)
 ;;=2^93568
 ;;^UTILITY(U,$J,358.3,1145,1,3,0)
 ;;=3^Inject Pulm Art Hrt Cath
 ;;^UTILITY(U,$J,358.3,1146,0)
 ;;=93566^^10^109^10^^^^1
 ;;^UTILITY(U,$J,358.3,1146,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1146,1,2,0)
 ;;=2^93566
 ;;^UTILITY(U,$J,358.3,1146,1,3,0)
 ;;=3^Inject R Ventr/Atrial Angio
 ;;^UTILITY(U,$J,358.3,1147,0)
 ;;=93567^^10^109^11^^^^1
 ;;^UTILITY(U,$J,358.3,1147,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1147,1,2,0)
 ;;=2^93567
 ;;^UTILITY(U,$J,358.3,1147,1,3,0)
 ;;=3^Inject Suprvlv Aortography
 ;;^UTILITY(U,$J,358.3,1148,0)
 ;;=93532^^10^109^17^^^^1
 ;;^UTILITY(U,$J,358.3,1148,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1148,1,2,0)
 ;;=2^93532
 ;;^UTILITY(U,$J,358.3,1148,1,3,0)
 ;;=3^R&L HC for Congenital Card Anomalies
 ;;^UTILITY(U,$J,358.3,1149,0)
 ;;=93580^^10^109^24^^^^1
 ;;^UTILITY(U,$J,358.3,1149,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1149,1,2,0)
 ;;=2^93580
 ;;^UTILITY(U,$J,358.3,1149,1,3,0)
 ;;=3^Transcath Closure of ASD
 ;;^UTILITY(U,$J,358.3,1150,0)
 ;;=36100^^10^110^11^^^^1
 ;;^UTILITY(U,$J,358.3,1150,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1150,1,2,0)
 ;;=2^36100
 ;;^UTILITY(U,$J,358.3,1150,1,3,0)
 ;;=3^Intro Needle Or Cath Carotid Or Vert. Artery
 ;;^UTILITY(U,$J,358.3,1151,0)
 ;;=36120^^10^110^10^^^^1
 ;;^UTILITY(U,$J,358.3,1151,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1151,1,2,0)
 ;;=2^36120
 ;;^UTILITY(U,$J,358.3,1151,1,3,0)
 ;;=3^Intro Needle Or Cath Brachial Artery
 ;;^UTILITY(U,$J,358.3,1152,0)
 ;;=36140^^10^110^12^^^^1
 ;;^UTILITY(U,$J,358.3,1152,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1152,1,2,0)
 ;;=2^36140
 ;;^UTILITY(U,$J,358.3,1152,1,3,0)
 ;;=3^Intro Needle Or Cath Ext Artery
 ;;^UTILITY(U,$J,358.3,1153,0)
 ;;=36215^^10^110^40^^^^1
 ;;^UTILITY(U,$J,358.3,1153,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1153,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,1153,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,1154,0)
 ;;=36011^^10^110^41^^^^1
