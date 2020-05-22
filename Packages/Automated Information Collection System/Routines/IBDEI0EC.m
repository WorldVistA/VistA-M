IBDEI0EC ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6155,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6155,1,2,0)
 ;;=2^J3240
 ;;^UTILITY(U,$J,358.3,6155,1,3,0)
 ;;=3^Thyrotropin Alpha 0.9mg
 ;;^UTILITY(U,$J,358.3,6156,0)
 ;;=Q9957^^52^397^4^^^^1
 ;;^UTILITY(U,$J,358.3,6156,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6156,1,2,0)
 ;;=2^Q9957
 ;;^UTILITY(U,$J,358.3,6156,1,3,0)
 ;;=3^Definity per ML
 ;;^UTILITY(U,$J,358.3,6157,0)
 ;;=C9041^^52^397^3^^^^1
 ;;^UTILITY(U,$J,358.3,6157,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6157,1,2,0)
 ;;=2^C9041
 ;;^UTILITY(U,$J,358.3,6157,1,3,0)
 ;;=3^Coagulation Factor Xa 10mg
 ;;^UTILITY(U,$J,358.3,6158,0)
 ;;=J1444^^52^397^8^^^^1
 ;;^UTILITY(U,$J,358.3,6158,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6158,1,2,0)
 ;;=2^J1444
 ;;^UTILITY(U,$J,358.3,6158,1,3,0)
 ;;=3^Ferric Pyrophosphate Citrate Powder 0.1mg
 ;;^UTILITY(U,$J,358.3,6159,0)
 ;;=93015^^52^398^7
 ;;^UTILITY(U,$J,358.3,6159,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6159,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,6159,1,3,0)
 ;;=3^Cardiovascular Stress Test
 ;;^UTILITY(U,$J,358.3,6160,0)
 ;;=93660^^52^398^16
 ;;^UTILITY(U,$J,358.3,6160,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6160,1,2,0)
 ;;=2^93660
 ;;^UTILITY(U,$J,358.3,6160,1,3,0)
 ;;=3^Tilt Test Study
 ;;^UTILITY(U,$J,358.3,6161,0)
 ;;=78472^^52^398^2^^^^1
 ;;^UTILITY(U,$J,358.3,6161,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6161,1,2,0)
 ;;=2^78472
 ;;^UTILITY(U,$J,358.3,6161,1,3,0)
 ;;=3^Cardiac Blood Pool Gate+EF 
 ;;^UTILITY(U,$J,358.3,6162,0)
 ;;=78473^^52^398^1^^^^1
 ;;^UTILITY(U,$J,358.3,6162,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6162,1,2,0)
 ;;=2^78473
 ;;^UTILITY(U,$J,358.3,6162,1,3,0)
 ;;=3^Cardiac Blood Pool Gate Mult,Add-on
 ;;^UTILITY(U,$J,358.3,6163,0)
 ;;=78481^^52^398^3^^^^1
 ;;^UTILITY(U,$J,358.3,6163,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6163,1,2,0)
 ;;=2^78481
 ;;^UTILITY(U,$J,358.3,6163,1,3,0)
 ;;=3^Cardiac Blood Pool Imag
 ;;^UTILITY(U,$J,358.3,6164,0)
 ;;=78483^^52^398^5^^^^1
 ;;^UTILITY(U,$J,358.3,6164,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6164,1,2,0)
 ;;=2^78483
 ;;^UTILITY(U,$J,358.3,6164,1,3,0)
 ;;=3^Cardiac Blood Pool Imag Mult,Add-On
 ;;^UTILITY(U,$J,358.3,6165,0)
 ;;=78491^^52^398^14^^^^1
 ;;^UTILITY(U,$J,358.3,6165,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6165,1,2,0)
 ;;=2^78491
 ;;^UTILITY(U,$J,358.3,6165,1,3,0)
 ;;=3^PET, Single, Rest or stress
 ;;^UTILITY(U,$J,358.3,6166,0)
 ;;=78492^^52^398^15^^^^1
 ;;^UTILITY(U,$J,358.3,6166,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6166,1,2,0)
 ;;=2^78492
 ;;^UTILITY(U,$J,358.3,6166,1,3,0)
 ;;=3^PET, multiple, rest or stress
 ;;^UTILITY(U,$J,358.3,6167,0)
 ;;=78496^^52^398^4^^^^1
 ;;^UTILITY(U,$J,358.3,6167,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6167,1,2,0)
 ;;=2^78496
 ;;^UTILITY(U,$J,358.3,6167,1,3,0)
 ;;=3^Cardiac Blood Pool Imag Gate sgl+EF,Add-On
 ;;^UTILITY(U,$J,358.3,6168,0)
 ;;=78451^^52^398^11^^^^1
 ;;^UTILITY(U,$J,358.3,6168,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6168,1,2,0)
 ;;=2^78451
 ;;^UTILITY(U,$J,358.3,6168,1,3,0)
 ;;=3^HT Muscle Image Spect,Single
 ;;^UTILITY(U,$J,358.3,6169,0)
 ;;=78452^^52^398^10^^^^1
 ;;^UTILITY(U,$J,358.3,6169,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6169,1,2,0)
 ;;=2^78452
 ;;^UTILITY(U,$J,358.3,6169,1,3,0)
 ;;=3^HT Muscle Image Spect,Multi,Add-On
 ;;^UTILITY(U,$J,358.3,6170,0)
 ;;=78453^^52^398^13^^^^1
 ;;^UTILITY(U,$J,358.3,6170,1,0)
 ;;=^358.31IA^3^2
