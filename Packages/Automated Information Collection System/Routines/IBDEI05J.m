IBDEI05J ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2235,0)
 ;;=93015^^12^175^7
 ;;^UTILITY(U,$J,358.3,2235,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2235,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,2235,1,3,0)
 ;;=3^Cardiovascular Stress Test
 ;;^UTILITY(U,$J,358.3,2236,0)
 ;;=93660^^12^175^16
 ;;^UTILITY(U,$J,358.3,2236,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2236,1,2,0)
 ;;=2^93660
 ;;^UTILITY(U,$J,358.3,2236,1,3,0)
 ;;=3^Tilt Test Study
 ;;^UTILITY(U,$J,358.3,2237,0)
 ;;=78472^^12^175^2^^^^1
 ;;^UTILITY(U,$J,358.3,2237,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2237,1,2,0)
 ;;=2^78472
 ;;^UTILITY(U,$J,358.3,2237,1,3,0)
 ;;=3^Cardiac Blood Pool Gate+EF 
 ;;^UTILITY(U,$J,358.3,2238,0)
 ;;=78473^^12^175^1^^^^1
 ;;^UTILITY(U,$J,358.3,2238,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2238,1,2,0)
 ;;=2^78473
 ;;^UTILITY(U,$J,358.3,2238,1,3,0)
 ;;=3^Cardiac Blood Pool Gate mult
 ;;^UTILITY(U,$J,358.3,2239,0)
 ;;=78481^^12^175^3^^^^1
 ;;^UTILITY(U,$J,358.3,2239,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2239,1,2,0)
 ;;=2^78481
 ;;^UTILITY(U,$J,358.3,2239,1,3,0)
 ;;=3^Cardiac Blood Pool Imag
 ;;^UTILITY(U,$J,358.3,2240,0)
 ;;=78483^^12^175^5^^^^1
 ;;^UTILITY(U,$J,358.3,2240,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2240,1,2,0)
 ;;=2^78483
 ;;^UTILITY(U,$J,358.3,2240,1,3,0)
 ;;=3^Cardiac Blood Pool Imag mult
 ;;^UTILITY(U,$J,358.3,2241,0)
 ;;=78491^^12^175^14^^^^1
 ;;^UTILITY(U,$J,358.3,2241,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2241,1,2,0)
 ;;=2^78491
 ;;^UTILITY(U,$J,358.3,2241,1,3,0)
 ;;=3^PET, Single, Rest or stress
 ;;^UTILITY(U,$J,358.3,2242,0)
 ;;=78492^^12^175^15^^^^1
 ;;^UTILITY(U,$J,358.3,2242,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2242,1,2,0)
 ;;=2^78492
 ;;^UTILITY(U,$J,358.3,2242,1,3,0)
 ;;=3^PET, multiple, rest or stress
 ;;^UTILITY(U,$J,358.3,2243,0)
 ;;=78496^^12^175^4^^^^1
 ;;^UTILITY(U,$J,358.3,2243,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2243,1,2,0)
 ;;=2^78496
 ;;^UTILITY(U,$J,358.3,2243,1,3,0)
 ;;=3^Cardiac Blood Pool Imag Gate sgl+EF
 ;;^UTILITY(U,$J,358.3,2244,0)
 ;;=78451^^12^175^11^^^^1
 ;;^UTILITY(U,$J,358.3,2244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2244,1,2,0)
 ;;=2^78451
 ;;^UTILITY(U,$J,358.3,2244,1,3,0)
 ;;=3^HT Muscle Image Spect,Single
 ;;^UTILITY(U,$J,358.3,2245,0)
 ;;=78452^^12^175^10^^^^1
 ;;^UTILITY(U,$J,358.3,2245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2245,1,2,0)
 ;;=2^78452
 ;;^UTILITY(U,$J,358.3,2245,1,3,0)
 ;;=3^HT Muscle Image Spect,Multi
 ;;^UTILITY(U,$J,358.3,2246,0)
 ;;=78453^^12^175^13^^^^1
 ;;^UTILITY(U,$J,358.3,2246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2246,1,2,0)
 ;;=2^78453
 ;;^UTILITY(U,$J,358.3,2246,1,3,0)
 ;;=3^HT Muscle Image,Planar,Single
 ;;^UTILITY(U,$J,358.3,2247,0)
 ;;=78454^^12^175^12^^^^1
 ;;^UTILITY(U,$J,358.3,2247,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2247,1,2,0)
 ;;=2^78454
 ;;^UTILITY(U,$J,358.3,2247,1,3,0)
 ;;=3^HT Muscle Image,Planar,Multi
 ;;^UTILITY(U,$J,358.3,2248,0)
 ;;=93641^^12^175^8^^^^1
 ;;^UTILITY(U,$J,358.3,2248,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2248,1,2,0)
 ;;=2^93641
 ;;^UTILITY(U,$J,358.3,2248,1,3,0)
 ;;=3^Electrophysiology Eval,Pulse Generator
 ;;^UTILITY(U,$J,358.3,2249,0)
 ;;=93642^^12^175^9^^^^1
 ;;^UTILITY(U,$J,358.3,2249,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2249,1,2,0)
 ;;=2^93642
 ;;^UTILITY(U,$J,358.3,2249,1,3,0)
 ;;=3^Electrophysiology Eval,Sensing/Therapeutic Parameters
 ;;^UTILITY(U,$J,358.3,2250,0)
 ;;=93797^^12^175^6^^^^1
 ;;^UTILITY(U,$J,358.3,2250,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2250,1,2,0)
 ;;=2^93797
 ;;^UTILITY(U,$J,358.3,2250,1,3,0)
 ;;=3^Cardiac Rehab w/o ECG Monitoring
