IBDEI05C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1840,1,3,0)
 ;;=3^EP & Ablate Ventric Tachy
 ;;^UTILITY(U,$J,358.3,1841,0)
 ;;=93655^^17^171^2^^^^1
 ;;^UTILITY(U,$J,358.3,1841,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1841,1,2,0)
 ;;=2^93655
 ;;^UTILITY(U,$J,358.3,1841,1,3,0)
 ;;=3^Ablate Arrhythmia Add On
 ;;^UTILITY(U,$J,358.3,1842,0)
 ;;=93656^^17^171^28^^^^1
 ;;^UTILITY(U,$J,358.3,1842,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1842,1,2,0)
 ;;=2^93656
 ;;^UTILITY(U,$J,358.3,1842,1,3,0)
 ;;=3^Tx Atrial Fib Pulm Vein Isol
 ;;^UTILITY(U,$J,358.3,1843,0)
 ;;=93657^^17^171^29^^^^1
 ;;^UTILITY(U,$J,358.3,1843,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1843,1,2,0)
 ;;=2^93657
 ;;^UTILITY(U,$J,358.3,1843,1,3,0)
 ;;=3^Tx L/R Atrial Fib Addl
 ;;^UTILITY(U,$J,358.3,1844,0)
 ;;=93631^^17^171^7^^^^1
 ;;^UTILITY(U,$J,358.3,1844,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1844,1,2,0)
 ;;=2^93631
 ;;^UTILITY(U,$J,358.3,1844,1,3,0)
 ;;=3^Endocardial Pacing and Mapping
 ;;^UTILITY(U,$J,358.3,1845,0)
 ;;=93623^^17^171^25^^^^1
 ;;^UTILITY(U,$J,358.3,1845,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1845,1,2,0)
 ;;=2^93623
 ;;^UTILITY(U,$J,358.3,1845,1,3,0)
 ;;=3^Pacing & Prog Stim Drug after IV Inf
 ;;^UTILITY(U,$J,358.3,1846,0)
 ;;=93660^^17^171^27^^^^1
 ;;^UTILITY(U,$J,358.3,1846,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1846,1,2,0)
 ;;=2^93660
 ;;^UTILITY(U,$J,358.3,1846,1,3,0)
 ;;=3^Tilt Table Eval w/ECG
 ;;^UTILITY(U,$J,358.3,1847,0)
 ;;=93662^^17^171^22^^^^1
 ;;^UTILITY(U,$J,358.3,1847,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1847,1,2,0)
 ;;=2^93662
 ;;^UTILITY(U,$J,358.3,1847,1,3,0)
 ;;=3^Intracardiac Echo during Tx Intervention
 ;;^UTILITY(U,$J,358.3,1848,0)
 ;;=93613^^17^171^6^^^^1
 ;;^UTILITY(U,$J,358.3,1848,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1848,1,2,0)
 ;;=2^93613
 ;;^UTILITY(U,$J,358.3,1848,1,3,0)
 ;;=3^Electrophys 3D Mapping
 ;;^UTILITY(U,$J,358.3,1849,0)
 ;;=75605^^17^172^8^^^^1
 ;;^UTILITY(U,$J,358.3,1849,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1849,1,2,0)
 ;;=2^75605
 ;;^UTILITY(U,$J,358.3,1849,1,3,0)
 ;;=3^Ao Thoracic w/ Serialography
 ;;^UTILITY(U,$J,358.3,1850,0)
 ;;=75625^^17^172^7^^^^1
 ;;^UTILITY(U,$J,358.3,1850,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1850,1,2,0)
 ;;=2^75625
 ;;^UTILITY(U,$J,358.3,1850,1,3,0)
 ;;=3^Ao Abd w/o Runoff
 ;;^UTILITY(U,$J,358.3,1851,0)
 ;;=75630^^17^172^6^^^^1
 ;;^UTILITY(U,$J,358.3,1851,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1851,1,2,0)
 ;;=2^75630
 ;;^UTILITY(U,$J,358.3,1851,1,3,0)
 ;;=3^Ao Abd w/ Bilat Iliacs
 ;;^UTILITY(U,$J,358.3,1852,0)
 ;;=75658^^17^172^10^^^^1
 ;;^UTILITY(U,$J,358.3,1852,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1852,1,2,0)
 ;;=2^75658
 ;;^UTILITY(U,$J,358.3,1852,1,3,0)
 ;;=3^Brachial
 ;;^UTILITY(U,$J,358.3,1853,0)
 ;;=75705^^17^172^5^^^^1
 ;;^UTILITY(U,$J,358.3,1853,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1853,1,2,0)
 ;;=2^75705
 ;;^UTILITY(U,$J,358.3,1853,1,3,0)
 ;;=3^Angiography,Spinal Selective,S&I
 ;;^UTILITY(U,$J,358.3,1854,0)
 ;;=75710^^17^172^4^^^^1
 ;;^UTILITY(U,$J,358.3,1854,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1854,1,2,0)
 ;;=2^75710
 ;;^UTILITY(U,$J,358.3,1854,1,3,0)
 ;;=3^Angiography,Extremity,Unilateral,S&I
 ;;^UTILITY(U,$J,358.3,1855,0)
 ;;=75716^^17^172^61^^^^1
 ;;^UTILITY(U,$J,358.3,1855,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1855,1,2,0)
 ;;=2^75716
 ;;^UTILITY(U,$J,358.3,1855,1,3,0)
 ;;=3^Ue/Le Bilat
 ;;^UTILITY(U,$J,358.3,1856,0)
 ;;=75726^^17^172^65^^^^1
 ;;^UTILITY(U,$J,358.3,1856,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1856,1,2,0)
 ;;=2^75726
 ;;^UTILITY(U,$J,358.3,1856,1,3,0)
 ;;=3^Visceral Selective
