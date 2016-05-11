IBDEI03F ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1165,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1165,1,2,0)
 ;;=2^V5275
 ;;^UTILITY(U,$J,358.3,1165,1,3,0)
 ;;=3^Ear Impression, Each
 ;;^UTILITY(U,$J,358.3,1166,0)
 ;;=92590^^7^119^10^^^^1
 ;;^UTILITY(U,$J,358.3,1166,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1166,1,2,0)
 ;;=2^92590
 ;;^UTILITY(U,$J,358.3,1166,1,3,0)
 ;;=3^HA Assessment,Monaural
 ;;^UTILITY(U,$J,358.3,1167,0)
 ;;=92591^^7^119^9^^^^1
 ;;^UTILITY(U,$J,358.3,1167,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1167,1,2,0)
 ;;=2^92591
 ;;^UTILITY(U,$J,358.3,1167,1,3,0)
 ;;=3^HA Assessment,Binaural
 ;;^UTILITY(U,$J,358.3,1168,0)
 ;;=92594^^7^119^8^^^^1
 ;;^UTILITY(U,$J,358.3,1168,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1168,1,2,0)
 ;;=2^92594
 ;;^UTILITY(U,$J,358.3,1168,1,3,0)
 ;;=3^Electroacoustic Eval for HA,Monaural
 ;;^UTILITY(U,$J,358.3,1169,0)
 ;;=92595^^7^119^7^^^^1
 ;;^UTILITY(U,$J,358.3,1169,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1169,1,2,0)
 ;;=2^92595
 ;;^UTILITY(U,$J,358.3,1169,1,3,0)
 ;;=3^Electroacoustic Eval for HA,Binaural
 ;;^UTILITY(U,$J,358.3,1170,0)
 ;;=92592^^7^119^12^^^^1
 ;;^UTILITY(U,$J,358.3,1170,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1170,1,2,0)
 ;;=2^92592
 ;;^UTILITY(U,$J,358.3,1170,1,3,0)
 ;;=3^HA Check,Monaural
 ;;^UTILITY(U,$J,358.3,1171,0)
 ;;=92593^^7^119^11^^^^1
 ;;^UTILITY(U,$J,358.3,1171,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1171,1,2,0)
 ;;=2^92593
 ;;^UTILITY(U,$J,358.3,1171,1,3,0)
 ;;=3^HA Check,Binaural
 ;;^UTILITY(U,$J,358.3,1172,0)
 ;;=V5014^^7^119^13^^^^1
 ;;^UTILITY(U,$J,358.3,1172,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1172,1,2,0)
 ;;=2^V5014
 ;;^UTILITY(U,$J,358.3,1172,1,3,0)
 ;;=3^HA Repair/Modification
 ;;^UTILITY(U,$J,358.3,1173,0)
 ;;=V5020^^7^119^16^^^^1
 ;;^UTILITY(U,$J,358.3,1173,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1173,1,2,0)
 ;;=2^V5020
 ;;^UTILITY(U,$J,358.3,1173,1,3,0)
 ;;=3^Real-Ear(Probe Tube) Measurement
 ;;^UTILITY(U,$J,358.3,1174,0)
 ;;=S0618^^7^119^1^^^^1
 ;;^UTILITY(U,$J,358.3,1174,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1174,1,2,0)
 ;;=2^S0618
 ;;^UTILITY(U,$J,358.3,1174,1,3,0)
 ;;=3^Audiometry For Hearing Aid
 ;;^UTILITY(U,$J,358.3,1175,0)
 ;;=97762^^7^119^2^^^^1
 ;;^UTILITY(U,$J,358.3,1175,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1175,1,2,0)
 ;;=2^97762
 ;;^UTILITY(U,$J,358.3,1175,1,3,0)
 ;;=3^C/O for Orthotic/Prosth Use
 ;;^UTILITY(U,$J,358.3,1176,0)
 ;;=98960^^7^119^4^^^^1
 ;;^UTILITY(U,$J,358.3,1176,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1176,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,1176,1,3,0)
 ;;=3^Education & Training, Individual
 ;;^UTILITY(U,$J,358.3,1177,0)
 ;;=98961^^7^119^5^^^^1
 ;;^UTILITY(U,$J,358.3,1177,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1177,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,1177,1,3,0)
 ;;=3^Education & Training,2-4 Patients
 ;;^UTILITY(U,$J,358.3,1178,0)
 ;;=98962^^7^119^6^^^^1
 ;;^UTILITY(U,$J,358.3,1178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1178,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,1178,1,3,0)
 ;;=3^Education & Training,5-8 Patients
 ;;^UTILITY(U,$J,358.3,1179,0)
 ;;=V5299^^7^119^15^^^^1
 ;;^UTILITY(U,$J,358.3,1179,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1179,1,2,0)
 ;;=2^V5299
 ;;^UTILITY(U,$J,358.3,1179,1,3,0)
 ;;=3^Hearing Services 
 ;;^UTILITY(U,$J,358.3,1180,0)
 ;;=V5011^^7^119^14^^^^1
 ;;^UTILITY(U,$J,358.3,1180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1180,1,2,0)
 ;;=2^V5011
 ;;^UTILITY(U,$J,358.3,1180,1,3,0)
 ;;=3^Hearing Aid Fitting/Checking
 ;;^UTILITY(U,$J,358.3,1181,0)
 ;;=69200^^7^120^1^^^^1
 ;;^UTILITY(U,$J,358.3,1181,1,0)
 ;;=^358.31IA^3^2
