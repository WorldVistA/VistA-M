IBDEI03L ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1314,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,1314,1,3,0)
 ;;=3^Cardiovascular Stress Test
 ;;^UTILITY(U,$J,358.3,1315,0)
 ;;=93660^^10^118^16
 ;;^UTILITY(U,$J,358.3,1315,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1315,1,2,0)
 ;;=2^93660
 ;;^UTILITY(U,$J,358.3,1315,1,3,0)
 ;;=3^Tilt Test Study
 ;;^UTILITY(U,$J,358.3,1316,0)
 ;;=78472^^10^118^2^^^^1
 ;;^UTILITY(U,$J,358.3,1316,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1316,1,2,0)
 ;;=2^78472
 ;;^UTILITY(U,$J,358.3,1316,1,3,0)
 ;;=3^Cardiac Blood Pool Gate+EF 
 ;;^UTILITY(U,$J,358.3,1317,0)
 ;;=78473^^10^118^1^^^^1
 ;;^UTILITY(U,$J,358.3,1317,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1317,1,2,0)
 ;;=2^78473
 ;;^UTILITY(U,$J,358.3,1317,1,3,0)
 ;;=3^Cardiac Blood Pool Gate mult
 ;;^UTILITY(U,$J,358.3,1318,0)
 ;;=78481^^10^118^3^^^^1
 ;;^UTILITY(U,$J,358.3,1318,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1318,1,2,0)
 ;;=2^78481
 ;;^UTILITY(U,$J,358.3,1318,1,3,0)
 ;;=3^Cardiac Blood Pool Imag
 ;;^UTILITY(U,$J,358.3,1319,0)
 ;;=78483^^10^118^5^^^^1
 ;;^UTILITY(U,$J,358.3,1319,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1319,1,2,0)
 ;;=2^78483
 ;;^UTILITY(U,$J,358.3,1319,1,3,0)
 ;;=3^Cardiac Blood Pool Imag mult
 ;;^UTILITY(U,$J,358.3,1320,0)
 ;;=78491^^10^118^14^^^^1
 ;;^UTILITY(U,$J,358.3,1320,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1320,1,2,0)
 ;;=2^78491
 ;;^UTILITY(U,$J,358.3,1320,1,3,0)
 ;;=3^PET, Single, Rest or stress
 ;;^UTILITY(U,$J,358.3,1321,0)
 ;;=78492^^10^118^15^^^^1
 ;;^UTILITY(U,$J,358.3,1321,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1321,1,2,0)
 ;;=2^78492
 ;;^UTILITY(U,$J,358.3,1321,1,3,0)
 ;;=3^PET, multiple, rest or stress
 ;;^UTILITY(U,$J,358.3,1322,0)
 ;;=78496^^10^118^4^^^^1
 ;;^UTILITY(U,$J,358.3,1322,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1322,1,2,0)
 ;;=2^78496
 ;;^UTILITY(U,$J,358.3,1322,1,3,0)
 ;;=3^Cardiac Blood Pool Imag Gate sgl+EF
 ;;^UTILITY(U,$J,358.3,1323,0)
 ;;=78451^^10^118^11^^^^1
 ;;^UTILITY(U,$J,358.3,1323,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1323,1,2,0)
 ;;=2^78451
 ;;^UTILITY(U,$J,358.3,1323,1,3,0)
 ;;=3^HT Muscle Image Spect,Single
 ;;^UTILITY(U,$J,358.3,1324,0)
 ;;=78452^^10^118^10^^^^1
 ;;^UTILITY(U,$J,358.3,1324,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1324,1,2,0)
 ;;=2^78452
 ;;^UTILITY(U,$J,358.3,1324,1,3,0)
 ;;=3^HT Muscle Image Spect,Multi
 ;;^UTILITY(U,$J,358.3,1325,0)
 ;;=78453^^10^118^13^^^^1
 ;;^UTILITY(U,$J,358.3,1325,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1325,1,2,0)
 ;;=2^78453
 ;;^UTILITY(U,$J,358.3,1325,1,3,0)
 ;;=3^HT Muscle Image,Planar,Single
 ;;^UTILITY(U,$J,358.3,1326,0)
 ;;=78454^^10^118^12^^^^1
 ;;^UTILITY(U,$J,358.3,1326,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1326,1,2,0)
 ;;=2^78454
 ;;^UTILITY(U,$J,358.3,1326,1,3,0)
 ;;=3^HT Muscle Image,Planar,Multi
 ;;^UTILITY(U,$J,358.3,1327,0)
 ;;=93641^^10^118^8^^^^1
 ;;^UTILITY(U,$J,358.3,1327,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1327,1,2,0)
 ;;=2^93641
 ;;^UTILITY(U,$J,358.3,1327,1,3,0)
 ;;=3^Electrophysiology Eval,Pulse Generator
 ;;^UTILITY(U,$J,358.3,1328,0)
 ;;=93642^^10^118^9^^^^1
 ;;^UTILITY(U,$J,358.3,1328,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1328,1,2,0)
 ;;=2^93642
 ;;^UTILITY(U,$J,358.3,1328,1,3,0)
 ;;=3^Electrophysiology Eval,Sensing/Therapeutic Parameters
 ;;^UTILITY(U,$J,358.3,1329,0)
 ;;=93797^^10^118^6^^^^1
 ;;^UTILITY(U,$J,358.3,1329,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1329,1,2,0)
 ;;=2^93797
 ;;^UTILITY(U,$J,358.3,1329,1,3,0)
 ;;=3^Cardiac Rehab w/o ECG Monitoring
 ;;^UTILITY(U,$J,358.3,1330,0)
 ;;=93799^^10^118^17^^^^1
 ;;^UTILITY(U,$J,358.3,1330,1,0)
 ;;=^358.31IA^3^2
