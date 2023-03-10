IBDEI1D7 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22070,1,3,0)
 ;;=3^Trigger point INJ, 1 or 2 muscles
 ;;^UTILITY(U,$J,358.3,22071,0)
 ;;=20553^^71^943^7^^^^1
 ;;^UTILITY(U,$J,358.3,22071,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22071,1,2,0)
 ;;=2^20553
 ;;^UTILITY(U,$J,358.3,22071,1,3,0)
 ;;=3^Trigger point INJ, 3 or more muscles
 ;;^UTILITY(U,$J,358.3,22072,0)
 ;;=20550^^71^943^5^^^^1
 ;;^UTILITY(U,$J,358.3,22072,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22072,1,2,0)
 ;;=2^20550
 ;;^UTILITY(U,$J,358.3,22072,1,3,0)
 ;;=3^INJ tendon sheath/ligament
 ;;^UTILITY(U,$J,358.3,22073,0)
 ;;=20551^^71^943^4^^^^1
 ;;^UTILITY(U,$J,358.3,22073,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22073,1,2,0)
 ;;=2^20551
 ;;^UTILITY(U,$J,358.3,22073,1,3,0)
 ;;=3^INJ tendon insertion/origin
 ;;^UTILITY(U,$J,358.3,22074,0)
 ;;=J0585^^71^943^1^^^^1
 ;;^UTILITY(U,$J,358.3,22074,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22074,1,2,0)
 ;;=2^J0585
 ;;^UTILITY(U,$J,358.3,22074,1,3,0)
 ;;=3^Botulinum Toxin A, per unit
 ;;^UTILITY(U,$J,358.3,22075,0)
 ;;=J0587^^71^943^2^^^^1
 ;;^UTILITY(U,$J,358.3,22075,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22075,1,2,0)
 ;;=2^J0587
 ;;^UTILITY(U,$J,358.3,22075,1,3,0)
 ;;=3^Botulinum Toxin B, 100 Units
 ;;^UTILITY(U,$J,358.3,22076,0)
 ;;=64615^^71^943^3^^^^1
 ;;^UTILITY(U,$J,358.3,22076,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22076,1,2,0)
 ;;=2^64615
 ;;^UTILITY(U,$J,358.3,22076,1,3,0)
 ;;=3^Chemodenervation Muscle for Migraine
 ;;^UTILITY(U,$J,358.3,22077,0)
 ;;=97810^^71^944^1^^^^1
 ;;^UTILITY(U,$J,358.3,22077,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22077,1,2,0)
 ;;=2^97810
 ;;^UTILITY(U,$J,358.3,22077,1,3,0)
 ;;=3^Acupuncture w/o Stimul 15 Min
 ;;^UTILITY(U,$J,358.3,22078,0)
 ;;=97811^^71^944^2^^^^1
 ;;^UTILITY(U,$J,358.3,22078,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22078,1,2,0)
 ;;=2^97811
 ;;^UTILITY(U,$J,358.3,22078,1,3,0)
 ;;=3^Acupuncture w/o Stimul,Ea Addl 15 Min
 ;;^UTILITY(U,$J,358.3,22079,0)
 ;;=97813^^71^944^3^^^^1
 ;;^UTILITY(U,$J,358.3,22079,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22079,1,2,0)
 ;;=2^97813
 ;;^UTILITY(U,$J,358.3,22079,1,3,0)
 ;;=3^Acupuncture w/ Stimul 15 Min
 ;;^UTILITY(U,$J,358.3,22080,0)
 ;;=97814^^71^944^4^^^^1
 ;;^UTILITY(U,$J,358.3,22080,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22080,1,2,0)
 ;;=2^97814
 ;;^UTILITY(U,$J,358.3,22080,1,3,0)
 ;;=3^Acupuncture w/ Stimul,Ea Addl 15 Min
 ;;^UTILITY(U,$J,358.3,22081,0)
 ;;=11719^^71^945^3^^^^1
 ;;^UTILITY(U,$J,358.3,22081,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22081,1,2,0)
 ;;=2^11719
 ;;^UTILITY(U,$J,358.3,22081,1,3,0)
 ;;=3^Trim Nondystrophic Nails,Any Number
 ;;^UTILITY(U,$J,358.3,22082,0)
 ;;=11720^^71^945^1^^^^1
 ;;^UTILITY(U,$J,358.3,22082,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22082,1,2,0)
 ;;=2^11720
 ;;^UTILITY(U,$J,358.3,22082,1,3,0)
 ;;=3^Debride Nail(s);1-5
 ;;^UTILITY(U,$J,358.3,22083,0)
 ;;=11721^^71^945^2^^^^1
 ;;^UTILITY(U,$J,358.3,22083,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22083,1,2,0)
 ;;=2^11721
 ;;^UTILITY(U,$J,358.3,22083,1,3,0)
 ;;=3^Debride Nails;6 or more
 ;;^UTILITY(U,$J,358.3,22084,0)
 ;;=J0475^^71^946^5^^^^1
 ;;^UTILITY(U,$J,358.3,22084,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22084,1,2,0)
 ;;=2^J0475
 ;;^UTILITY(U,$J,358.3,22084,1,3,0)
 ;;=3^Baclofen 10mg
 ;;^UTILITY(U,$J,358.3,22085,0)
 ;;=J0476^^71^946^6^^^^1
 ;;^UTILITY(U,$J,358.3,22085,1,0)
 ;;=^358.31IA^3^2
