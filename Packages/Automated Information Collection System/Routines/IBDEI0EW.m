IBDEI0EW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6862,0)
 ;;=J12.9^^30^398^73
 ;;^UTILITY(U,$J,358.3,6862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6862,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,6862,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,6862,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,6863,0)
 ;;=J10.08^^30^398^42
 ;;^UTILITY(U,$J,358.3,6863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6863,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,6863,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,6863,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,6864,0)
 ;;=J10.00^^30^398^41
 ;;^UTILITY(U,$J,358.3,6864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6864,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,6864,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,6864,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,6865,0)
 ;;=J11.08^^30^398^44
 ;;^UTILITY(U,$J,358.3,6865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6865,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,6865,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,6865,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,6866,0)
 ;;=J10.1^^30^398^43
 ;;^UTILITY(U,$J,358.3,6866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6866,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,6866,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,6866,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,6867,0)
 ;;=J10.01^^30^398^40
 ;;^UTILITY(U,$J,358.3,6867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6867,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,6867,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,6867,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,6868,0)
 ;;=J11.1^^30^398^45
 ;;^UTILITY(U,$J,358.3,6868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6868,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,6868,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,6868,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,6869,0)
 ;;=N12.^^30^398^89
 ;;^UTILITY(U,$J,358.3,6869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6869,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,6869,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,6869,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,6870,0)
 ;;=N11.9^^30^398^90
 ;;^UTILITY(U,$J,358.3,6870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6870,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,6870,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,6870,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,6871,0)
 ;;=N13.6^^30^398^77
 ;;^UTILITY(U,$J,358.3,6871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6871,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,6871,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,6871,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,6872,0)
 ;;=N30.91^^30^398^20
 ;;^UTILITY(U,$J,358.3,6872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6872,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,6872,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,6872,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,6873,0)
 ;;=N30.90^^30^398^21
 ;;^UTILITY(U,$J,358.3,6873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6873,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,6873,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,6873,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,6874,0)
 ;;=N41.9^^30^398^39
 ;;^UTILITY(U,$J,358.3,6874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6874,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
 ;;^UTILITY(U,$J,358.3,6874,1,4,0)
 ;;=4^N41.9
