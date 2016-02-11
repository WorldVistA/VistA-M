IBDEI15F ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19189,0)
 ;;=J18.9^^94^918^67
 ;;^UTILITY(U,$J,358.3,19189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19189,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,19189,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,19189,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,19190,0)
 ;;=J18.8^^94^918^68
 ;;^UTILITY(U,$J,358.3,19190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19190,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,19190,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,19190,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,19191,0)
 ;;=J11.00^^94^918^28
 ;;^UTILITY(U,$J,358.3,19191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19191,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,19191,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,19191,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,19192,0)
 ;;=J12.9^^94^918^69
 ;;^UTILITY(U,$J,358.3,19192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19192,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,19192,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,19192,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,19193,0)
 ;;=J10.08^^94^918^41
 ;;^UTILITY(U,$J,358.3,19193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19193,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,19193,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,19193,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,19194,0)
 ;;=J10.00^^94^918^40
 ;;^UTILITY(U,$J,358.3,19194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19194,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,19194,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,19194,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,19195,0)
 ;;=J11.08^^94^918^43
 ;;^UTILITY(U,$J,358.3,19195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19195,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,19195,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,19195,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,19196,0)
 ;;=J10.1^^94^918^42
 ;;^UTILITY(U,$J,358.3,19196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19196,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,19196,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,19196,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,19197,0)
 ;;=J10.01^^94^918^39
 ;;^UTILITY(U,$J,358.3,19197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19197,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,19197,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,19197,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,19198,0)
 ;;=J11.1^^94^918^44
 ;;^UTILITY(U,$J,358.3,19198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19198,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,19198,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,19198,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,19199,0)
 ;;=N12.^^94^918^85
 ;;^UTILITY(U,$J,358.3,19199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19199,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,19199,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,19199,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,19200,0)
 ;;=N11.9^^94^918^86
 ;;^UTILITY(U,$J,358.3,19200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19200,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,19200,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,19200,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,19201,0)
 ;;=N13.6^^94^918^73
 ;;^UTILITY(U,$J,358.3,19201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19201,1,3,0)
 ;;=3^Pyonephrosis
