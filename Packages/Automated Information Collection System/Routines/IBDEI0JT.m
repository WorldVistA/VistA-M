IBDEI0JT ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8914,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,8914,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,8914,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,8915,0)
 ;;=J10.00^^39^403^43
 ;;^UTILITY(U,$J,358.3,8915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8915,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,8915,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,8915,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,8916,0)
 ;;=J11.08^^39^403^46
 ;;^UTILITY(U,$J,358.3,8916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8916,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,8916,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,8916,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,8917,0)
 ;;=J10.1^^39^403^45
 ;;^UTILITY(U,$J,358.3,8917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8917,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,8917,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,8917,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,8918,0)
 ;;=J10.01^^39^403^42
 ;;^UTILITY(U,$J,358.3,8918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8918,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,8918,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,8918,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,8919,0)
 ;;=J11.1^^39^403^47
 ;;^UTILITY(U,$J,358.3,8919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8919,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,8919,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,8919,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,8920,0)
 ;;=N12.^^39^403^92
 ;;^UTILITY(U,$J,358.3,8920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8920,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,8920,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,8920,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,8921,0)
 ;;=N11.9^^39^403^93
 ;;^UTILITY(U,$J,358.3,8921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8921,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,8921,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,8921,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,8922,0)
 ;;=N13.6^^39^403^78
 ;;^UTILITY(U,$J,358.3,8922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8922,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,8922,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,8922,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,8923,0)
 ;;=N30.91^^39^403^22
 ;;^UTILITY(U,$J,358.3,8923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8923,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,8923,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,8923,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,8924,0)
 ;;=N30.90^^39^403^23
 ;;^UTILITY(U,$J,358.3,8924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8924,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,8924,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,8924,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,8925,0)
 ;;=N41.9^^39^403^41
 ;;^UTILITY(U,$J,358.3,8925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8925,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
 ;;^UTILITY(U,$J,358.3,8925,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,8925,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,8926,0)
 ;;=N70.91^^39^403^80
 ;;^UTILITY(U,$J,358.3,8926,1,0)
 ;;=^358.31IA^4^2
