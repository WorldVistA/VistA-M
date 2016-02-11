IBDEI0E2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6133,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Lower Leg,Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,6133,1,4,0)
 ;;=4^L97.822
 ;;^UTILITY(U,$J,358.3,6133,2)
 ;;=^5009566
 ;;^UTILITY(U,$J,358.3,6134,0)
 ;;=L97.823^^40^383^109
 ;;^UTILITY(U,$J,358.3,6134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6134,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Lower Leg,Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,6134,1,4,0)
 ;;=4^L97.823
 ;;^UTILITY(U,$J,358.3,6134,2)
 ;;=^5009567
 ;;^UTILITY(U,$J,358.3,6135,0)
 ;;=L97.824^^40^383^110
 ;;^UTILITY(U,$J,358.3,6135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6135,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Lower Leg,Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,6135,1,4,0)
 ;;=4^L97.824
 ;;^UTILITY(U,$J,358.3,6135,2)
 ;;=^5009568
 ;;^UTILITY(U,$J,358.3,6136,0)
 ;;=L97.829^^40^383^111
 ;;^UTILITY(U,$J,358.3,6136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6136,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Lower Leg,Unspec Severity
 ;;^UTILITY(U,$J,358.3,6136,1,4,0)
 ;;=4^L97.829
 ;;^UTILITY(U,$J,358.3,6136,2)
 ;;=^5009569
 ;;^UTILITY(U,$J,358.3,6137,0)
 ;;=C61.^^40^384^26
 ;;^UTILITY(U,$J,358.3,6137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6137,1,3,0)
 ;;=3^Malig Neop of Prostate
 ;;^UTILITY(U,$J,358.3,6137,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,6137,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,6138,0)
 ;;=C67.9^^40^384^24
 ;;^UTILITY(U,$J,358.3,6138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6138,1,3,0)
 ;;=3^Malig Neop of Bladder,Unspec
 ;;^UTILITY(U,$J,358.3,6138,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,6138,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,6139,0)
 ;;=C64.1^^40^384^27
 ;;^UTILITY(U,$J,358.3,6139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6139,1,3,0)
 ;;=3^Malig Neop of Right Kidney
 ;;^UTILITY(U,$J,358.3,6139,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,6139,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,6140,0)
 ;;=C64.2^^40^384^25
 ;;^UTILITY(U,$J,358.3,6140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6140,1,3,0)
 ;;=3^Malig Neop of Left Kidney
 ;;^UTILITY(U,$J,358.3,6140,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,6140,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,6141,0)
 ;;=D17.6^^40^384^2
 ;;^UTILITY(U,$J,358.3,6141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6141,1,3,0)
 ;;=3^Benign Lipomatous Neop of Spermatic Cord
 ;;^UTILITY(U,$J,358.3,6141,1,4,0)
 ;;=4^D17.6
 ;;^UTILITY(U,$J,358.3,6141,2)
 ;;=^5002016
 ;;^UTILITY(U,$J,358.3,6142,0)
 ;;=N20.0^^40^384^4
 ;;^UTILITY(U,$J,358.3,6142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6142,1,3,0)
 ;;=3^Calculus of Kidney
 ;;^UTILITY(U,$J,358.3,6142,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,6142,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,6143,0)
 ;;=N20.2^^40^384^5
 ;;^UTILITY(U,$J,358.3,6143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6143,1,3,0)
 ;;=3^Calculus of Kidney w/ Calculus of Ureter
 ;;^UTILITY(U,$J,358.3,6143,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,6143,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,6144,0)
 ;;=N32.0^^40^384^3
 ;;^UTILITY(U,$J,358.3,6144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6144,1,3,0)
 ;;=3^Bladder-Neck Obstruction
 ;;^UTILITY(U,$J,358.3,6144,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,6144,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,6145,0)
 ;;=N31.1^^40^384^33
 ;;^UTILITY(U,$J,358.3,6145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6145,1,3,0)
 ;;=3^Reflex Neuropathic Bladder NEC
 ;;^UTILITY(U,$J,358.3,6145,1,4,0)
 ;;=4^N31.1
 ;;^UTILITY(U,$J,358.3,6145,2)
 ;;=^5015645
 ;;^UTILITY(U,$J,358.3,6146,0)
 ;;=N31.9^^40^384^29
 ;;^UTILITY(U,$J,358.3,6146,1,0)
 ;;=^358.31IA^4^2
