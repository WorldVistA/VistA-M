IBDEI0TC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13758,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,13758,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,13759,0)
 ;;=J11.08^^53^595^43
 ;;^UTILITY(U,$J,358.3,13759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13759,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,13759,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,13759,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,13760,0)
 ;;=J10.1^^53^595^42
 ;;^UTILITY(U,$J,358.3,13760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13760,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,13760,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,13760,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,13761,0)
 ;;=J10.01^^53^595^39
 ;;^UTILITY(U,$J,358.3,13761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13761,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,13761,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,13761,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,13762,0)
 ;;=J11.1^^53^595^44
 ;;^UTILITY(U,$J,358.3,13762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13762,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,13762,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,13762,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,13763,0)
 ;;=N12.^^53^595^85
 ;;^UTILITY(U,$J,358.3,13763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13763,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,13763,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,13763,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,13764,0)
 ;;=N11.9^^53^595^86
 ;;^UTILITY(U,$J,358.3,13764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13764,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,13764,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,13764,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,13765,0)
 ;;=N13.6^^53^595^73
 ;;^UTILITY(U,$J,358.3,13765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13765,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,13765,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,13765,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,13766,0)
 ;;=N30.91^^53^595^19
 ;;^UTILITY(U,$J,358.3,13766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13766,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,13766,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,13766,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,13767,0)
 ;;=N30.90^^53^595^20
 ;;^UTILITY(U,$J,358.3,13767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13767,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,13767,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,13767,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,13768,0)
 ;;=N41.9^^53^595^38
 ;;^UTILITY(U,$J,358.3,13768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13768,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
 ;;^UTILITY(U,$J,358.3,13768,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,13768,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,13769,0)
 ;;=N70.91^^53^595^75
 ;;^UTILITY(U,$J,358.3,13769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13769,1,3,0)
 ;;=3^Salpingitis,Unspec
 ;;^UTILITY(U,$J,358.3,13769,1,4,0)
 ;;=4^N70.91
 ;;^UTILITY(U,$J,358.3,13769,2)
 ;;=^5015806
 ;;^UTILITY(U,$J,358.3,13770,0)
 ;;=N70.93^^53^595^74
 ;;^UTILITY(U,$J,358.3,13770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13770,1,3,0)
 ;;=3^Salpingitis & Oophoritis,Unspec
 ;;^UTILITY(U,$J,358.3,13770,1,4,0)
 ;;=4^N70.93
 ;;^UTILITY(U,$J,358.3,13770,2)
 ;;=^5015808
 ;;^UTILITY(U,$J,358.3,13771,0)
 ;;=N70.92^^53^595^55
 ;;^UTILITY(U,$J,358.3,13771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13771,1,3,0)
 ;;=3^Oophoritis,Unspec
