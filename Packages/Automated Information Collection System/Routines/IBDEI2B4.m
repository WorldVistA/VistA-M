IBDEI2B4 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36827,1,3,0)
 ;;=3^Debride Subcut (epi/derm);20sq cm or <
 ;;^UTILITY(U,$J,358.3,36828,0)
 ;;=11045^^143^1866^4^^^^1
 ;;^UTILITY(U,$J,358.3,36828,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36828,1,2,0)
 ;;=2^11045
 ;;^UTILITY(U,$J,358.3,36828,1,3,0)
 ;;=3^Debride Subcut (epi/derm);Ea Addl 20sq cm
 ;;^UTILITY(U,$J,358.3,36829,0)
 ;;=17000^^143^1867^7^^^^1
 ;;^UTILITY(U,$J,358.3,36829,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36829,1,2,0)
 ;;=2^17000
 ;;^UTILITY(U,$J,358.3,36829,1,3,0)
 ;;=3^Destroy 1st Premalignant Lesion
 ;;^UTILITY(U,$J,358.3,36830,0)
 ;;=17004^^143^1867^6^^^^1
 ;;^UTILITY(U,$J,358.3,36830,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36830,1,2,0)
 ;;=2^17004
 ;;^UTILITY(U,$J,358.3,36830,1,3,0)
 ;;=3^Destroy 15+ Premalignant Lesions
 ;;^UTILITY(U,$J,358.3,36831,0)
 ;;=17110^^143^1867^4^^^^1
 ;;^UTILITY(U,$J,358.3,36831,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36831,1,2,0)
 ;;=2^17110
 ;;^UTILITY(U,$J,358.3,36831,1,3,0)
 ;;=3^Destroy 1-14 Benign Lesions
 ;;^UTILITY(U,$J,358.3,36832,0)
 ;;=17111^^143^1867^5^^^^1
 ;;^UTILITY(U,$J,358.3,36832,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36832,1,2,0)
 ;;=2^17111
 ;;^UTILITY(U,$J,358.3,36832,1,3,0)
 ;;=3^Destroy 15+ Benign Lesions
 ;;^UTILITY(U,$J,358.3,36833,0)
 ;;=17003^^143^1867^8^^^^1
 ;;^UTILITY(U,$J,358.3,36833,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36833,1,2,0)
 ;;=2^17003
 ;;^UTILITY(U,$J,358.3,36833,1,3,0)
 ;;=3^Destroy 2-14 Premalignant Lesions
 ;;^UTILITY(U,$J,358.3,36834,0)
 ;;=17106^^143^1867^1^^^^1
 ;;^UTILITY(U,$J,358.3,36834,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36834,1,2,0)
 ;;=2^17106
 ;;^UTILITY(U,$J,358.3,36834,1,3,0)
 ;;=3^Dest Cutan Vasc Prolif Lesion < 10 sq cm
 ;;^UTILITY(U,$J,358.3,36835,0)
 ;;=17107^^143^1867^2^^^^1
 ;;^UTILITY(U,$J,358.3,36835,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36835,1,2,0)
 ;;=2^17107
 ;;^UTILITY(U,$J,358.3,36835,1,3,0)
 ;;=3^Dest Cutan Vasc Prolif Lesion 10-50 sq cm
 ;;^UTILITY(U,$J,358.3,36836,0)
 ;;=17108^^143^1867^3^^^^1
 ;;^UTILITY(U,$J,358.3,36836,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36836,1,2,0)
 ;;=2^17108
 ;;^UTILITY(U,$J,358.3,36836,1,3,0)
 ;;=3^Dest Cutan Vasc Prolif Lesion > 50 sq cm
 ;;^UTILITY(U,$J,358.3,36837,0)
 ;;=17260^^143^1868^1^^^^1
 ;;^UTILITY(U,$J,358.3,36837,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36837,1,2,0)
 ;;=2^17260
 ;;^UTILITY(U,$J,358.3,36837,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,0.5cm or <
 ;;^UTILITY(U,$J,358.3,36838,0)
 ;;=17261^^143^1868^2^^^^1
 ;;^UTILITY(U,$J,358.3,36838,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36838,1,2,0)
 ;;=2^17261
 ;;^UTILITY(U,$J,358.3,36838,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,36839,0)
 ;;=17262^^143^1868^3^^^^1
 ;;^UTILITY(U,$J,358.3,36839,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36839,1,2,0)
 ;;=2^17262
 ;;^UTILITY(U,$J,358.3,36839,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,36840,0)
 ;;=17263^^143^1868^4^^^^1
 ;;^UTILITY(U,$J,358.3,36840,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36840,1,2,0)
 ;;=2^17263
 ;;^UTILITY(U,$J,358.3,36840,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,36841,0)
 ;;=17264^^143^1868^5^^^^1
 ;;^UTILITY(U,$J,358.3,36841,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36841,1,2,0)
 ;;=2^17264
 ;;^UTILITY(U,$J,358.3,36841,1,3,0)
 ;;=3^Dest Mal Lesion Tnk/Arm/Leg,3.1-4.0cm
