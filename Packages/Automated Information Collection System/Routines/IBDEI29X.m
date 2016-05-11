IBDEI29X ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38569,1,2,0)
 ;;=2^97039
 ;;^UTILITY(U,$J,358.3,38569,1,3,0)
 ;;=3^Unlisted PT Modality
 ;;^UTILITY(U,$J,358.3,38570,0)
 ;;=97124^^147^1882^10^^^^1
 ;;^UTILITY(U,$J,358.3,38570,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38570,1,2,0)
 ;;=2^97124
 ;;^UTILITY(U,$J,358.3,38570,1,3,0)
 ;;=3^Therapeutic Massage
 ;;^UTILITY(U,$J,358.3,38571,0)
 ;;=97110^^147^1882^9^^^^1
 ;;^UTILITY(U,$J,358.3,38571,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38571,1,2,0)
 ;;=2^97110
 ;;^UTILITY(U,$J,358.3,38571,1,3,0)
 ;;=3^Therapeutic Ex/Record/Flex
 ;;^UTILITY(U,$J,358.3,38572,0)
 ;;=97035^^147^1882^11^^^^1
 ;;^UTILITY(U,$J,358.3,38572,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38572,1,2,0)
 ;;=2^97035
 ;;^UTILITY(U,$J,358.3,38572,1,3,0)
 ;;=3^Ultrasound Ea 15Min
 ;;^UTILITY(U,$J,358.3,38573,0)
 ;;=20552^^147^1883^6^^^^1
 ;;^UTILITY(U,$J,358.3,38573,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38573,1,2,0)
 ;;=2^20552
 ;;^UTILITY(U,$J,358.3,38573,1,3,0)
 ;;=3^Trigger Point Inj,1-2 Muscles
 ;;^UTILITY(U,$J,358.3,38574,0)
 ;;=20553^^147^1883^7^^^^1
 ;;^UTILITY(U,$J,358.3,38574,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38574,1,2,0)
 ;;=2^20553
 ;;^UTILITY(U,$J,358.3,38574,1,3,0)
 ;;=3^Trigger Point Inj,3 or More Muscles
 ;;^UTILITY(U,$J,358.3,38575,0)
 ;;=64405^^147^1883^5^^^^1
 ;;^UTILITY(U,$J,358.3,38575,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38575,1,2,0)
 ;;=2^64405
 ;;^UTILITY(U,$J,358.3,38575,1,3,0)
 ;;=3^Nerve Block,Occipital
 ;;^UTILITY(U,$J,358.3,38576,0)
 ;;=64615^^147^1883^4^^^^1
 ;;^UTILITY(U,$J,358.3,38576,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38576,1,2,0)
 ;;=2^64615
 ;;^UTILITY(U,$J,358.3,38576,1,3,0)
 ;;=3^Chemodenervation Muscle for Migraine
 ;;^UTILITY(U,$J,358.3,38577,0)
 ;;=J0585^^147^1883^2^^^^1
 ;;^UTILITY(U,$J,358.3,38577,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38577,1,2,0)
 ;;=2^J0585
 ;;^UTILITY(U,$J,358.3,38577,1,3,0)
 ;;=3^Botulinum Toxin A,per unit
 ;;^UTILITY(U,$J,358.3,38578,0)
 ;;=J0587^^147^1883^3^^^^1
 ;;^UTILITY(U,$J,358.3,38578,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38578,1,2,0)
 ;;=2^J0587
 ;;^UTILITY(U,$J,358.3,38578,1,3,0)
 ;;=3^Botulinum Toxin B,100 units
 ;;^UTILITY(U,$J,358.3,38579,0)
 ;;=J0586^^147^1883^1^^^^1
 ;;^UTILITY(U,$J,358.3,38579,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38579,1,2,0)
 ;;=2^J0586
 ;;^UTILITY(U,$J,358.3,38579,1,3,0)
 ;;=3^Botulinum Toxin A,5 units
 ;;^UTILITY(U,$J,358.3,38580,0)
 ;;=99415^^147^1884^1^^^^1
 ;;^UTILITY(U,$J,358.3,38580,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38580,1,2,0)
 ;;=2^99415
 ;;^UTILITY(U,$J,358.3,38580,1,3,0)
 ;;=3^Prolonged Clin Staff Svcs,1st hr        
 ;;^UTILITY(U,$J,358.3,38581,0)
 ;;=99416^^147^1884^2^^^^1
 ;;^UTILITY(U,$J,358.3,38581,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38581,1,2,0)
 ;;=2^99416
 ;;^UTILITY(U,$J,358.3,38581,1,3,0)
 ;;=3^Prolonged Clin Staff Svcs,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,38582,0)
 ;;=Z87.81^^148^1885^2
 ;;^UTILITY(U,$J,358.3,38582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38582,1,3,0)
 ;;=3^Personal history of (healed) traumatic fracture
 ;;^UTILITY(U,$J,358.3,38582,1,4,0)
 ;;=4^Z87.81
 ;;^UTILITY(U,$J,358.3,38582,2)
 ;;=^5063513
 ;;^UTILITY(U,$J,358.3,38583,0)
 ;;=Z87.828^^148^1885^3
 ;;^UTILITY(U,$J,358.3,38583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38583,1,3,0)
 ;;=3^Personal history of oth (healed) physical injury and trauma
 ;;^UTILITY(U,$J,358.3,38583,1,4,0)
 ;;=4^Z87.828
 ;;^UTILITY(U,$J,358.3,38583,2)
 ;;=^5063516
 ;;^UTILITY(U,$J,358.3,38584,0)
 ;;=S06.9X9S^^148^1885^1
 ;;^UTILITY(U,$J,358.3,38584,1,0)
 ;;=^358.31IA^4^2
