IBDEI05T ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2112,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2112,1,2,0)
 ;;=2^78483
 ;;^UTILITY(U,$J,358.3,2112,1,3,0)
 ;;=3^Cardiac Blood Pool Imag mult
 ;;^UTILITY(U,$J,358.3,2113,0)
 ;;=78491^^17^184^14^^^^1
 ;;^UTILITY(U,$J,358.3,2113,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2113,1,2,0)
 ;;=2^78491
 ;;^UTILITY(U,$J,358.3,2113,1,3,0)
 ;;=3^PET, Single, Rest or stress
 ;;^UTILITY(U,$J,358.3,2114,0)
 ;;=78492^^17^184^15^^^^1
 ;;^UTILITY(U,$J,358.3,2114,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2114,1,2,0)
 ;;=2^78492
 ;;^UTILITY(U,$J,358.3,2114,1,3,0)
 ;;=3^PET, multiple, rest or stress
 ;;^UTILITY(U,$J,358.3,2115,0)
 ;;=78496^^17^184^4^^^^1
 ;;^UTILITY(U,$J,358.3,2115,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2115,1,2,0)
 ;;=2^78496
 ;;^UTILITY(U,$J,358.3,2115,1,3,0)
 ;;=3^Cardiac Blood Pool Imag Gate sgl+EF
 ;;^UTILITY(U,$J,358.3,2116,0)
 ;;=78451^^17^184^11^^^^1
 ;;^UTILITY(U,$J,358.3,2116,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2116,1,2,0)
 ;;=2^78451
 ;;^UTILITY(U,$J,358.3,2116,1,3,0)
 ;;=3^HT Muscle Image Spect,Single
 ;;^UTILITY(U,$J,358.3,2117,0)
 ;;=78452^^17^184^10^^^^1
 ;;^UTILITY(U,$J,358.3,2117,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2117,1,2,0)
 ;;=2^78452
 ;;^UTILITY(U,$J,358.3,2117,1,3,0)
 ;;=3^HT Muscle Image Spect,Multi
 ;;^UTILITY(U,$J,358.3,2118,0)
 ;;=78453^^17^184^13^^^^1
 ;;^UTILITY(U,$J,358.3,2118,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2118,1,2,0)
 ;;=2^78453
 ;;^UTILITY(U,$J,358.3,2118,1,3,0)
 ;;=3^HT Muscle Image,Planar,Single
 ;;^UTILITY(U,$J,358.3,2119,0)
 ;;=78454^^17^184^12^^^^1
 ;;^UTILITY(U,$J,358.3,2119,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2119,1,2,0)
 ;;=2^78454
 ;;^UTILITY(U,$J,358.3,2119,1,3,0)
 ;;=3^HT Muscle Image,Planar,Multi
 ;;^UTILITY(U,$J,358.3,2120,0)
 ;;=93641^^17^184^8^^^^1
 ;;^UTILITY(U,$J,358.3,2120,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2120,1,2,0)
 ;;=2^93641
 ;;^UTILITY(U,$J,358.3,2120,1,3,0)
 ;;=3^Electrophysiology Eval,Pulse Generator
 ;;^UTILITY(U,$J,358.3,2121,0)
 ;;=93642^^17^184^9^^^^1
 ;;^UTILITY(U,$J,358.3,2121,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2121,1,2,0)
 ;;=2^93642
 ;;^UTILITY(U,$J,358.3,2121,1,3,0)
 ;;=3^Electrophysiology Eval,Sensing/Therapeutic Parameters
 ;;^UTILITY(U,$J,358.3,2122,0)
 ;;=93797^^17^184^6^^^^1
 ;;^UTILITY(U,$J,358.3,2122,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2122,1,2,0)
 ;;=2^93797
 ;;^UTILITY(U,$J,358.3,2122,1,3,0)
 ;;=3^Cardiac Rehab w/o ECG Monitoring
 ;;^UTILITY(U,$J,358.3,2123,0)
 ;;=93799^^17^184^17^^^^1
 ;;^UTILITY(U,$J,358.3,2123,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2123,1,2,0)
 ;;=2^93799
 ;;^UTILITY(U,$J,358.3,2123,1,3,0)
 ;;=3^Unlisted Cardiovascular Procedure
 ;;^UTILITY(U,$J,358.3,2124,0)
 ;;=93015^^17^185^1^^^^1
 ;;^UTILITY(U,$J,358.3,2124,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2124,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,2124,1,3,0)
 ;;=3^Cardiovascular Stress Test
 ;;^UTILITY(U,$J,358.3,2125,0)
 ;;=93016^^17^185^5^^^^1
 ;;^UTILITY(U,$J,358.3,2125,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2125,1,2,0)
 ;;=2^93016
 ;;^UTILITY(U,$J,358.3,2125,1,3,0)
 ;;=3^Stress Test, Phy Super Only No Report
 ;;^UTILITY(U,$J,358.3,2126,0)
 ;;=93017^^17^185^6^^^^1
 ;;^UTILITY(U,$J,358.3,2126,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2126,1,2,0)
 ;;=2^93017
 ;;^UTILITY(U,$J,358.3,2126,1,3,0)
 ;;=3^Stress Test, Tracing Only
 ;;^UTILITY(U,$J,358.3,2127,0)
 ;;=93018^^17^185^4^^^^1
 ;;^UTILITY(U,$J,358.3,2127,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2127,1,2,0)
 ;;=2^93018
 ;;^UTILITY(U,$J,358.3,2127,1,3,0)
 ;;=3^Stress Test, Interr & Report Only
