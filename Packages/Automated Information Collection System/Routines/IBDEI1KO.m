IBDEI1KO ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25129,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,25130,0)
 ;;=J12.9^^107^1213^69
 ;;^UTILITY(U,$J,358.3,25130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25130,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,25130,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,25130,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,25131,0)
 ;;=J10.08^^107^1213^41
 ;;^UTILITY(U,$J,358.3,25131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25131,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,25131,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,25131,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,25132,0)
 ;;=J10.00^^107^1213^40
 ;;^UTILITY(U,$J,358.3,25132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25132,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,25132,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,25132,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,25133,0)
 ;;=J11.08^^107^1213^43
 ;;^UTILITY(U,$J,358.3,25133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25133,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,25133,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,25133,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,25134,0)
 ;;=J10.1^^107^1213^42
 ;;^UTILITY(U,$J,358.3,25134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25134,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,25134,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,25134,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,25135,0)
 ;;=J10.01^^107^1213^39
 ;;^UTILITY(U,$J,358.3,25135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25135,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,25135,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,25135,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,25136,0)
 ;;=J11.1^^107^1213^44
 ;;^UTILITY(U,$J,358.3,25136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25136,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,25136,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,25136,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,25137,0)
 ;;=N12.^^107^1213^85
 ;;^UTILITY(U,$J,358.3,25137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25137,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,25137,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,25137,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,25138,0)
 ;;=N11.9^^107^1213^86
 ;;^UTILITY(U,$J,358.3,25138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25138,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,25138,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,25138,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,25139,0)
 ;;=N13.6^^107^1213^73
 ;;^UTILITY(U,$J,358.3,25139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25139,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,25139,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,25139,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,25140,0)
 ;;=N30.91^^107^1213^19
 ;;^UTILITY(U,$J,358.3,25140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25140,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,25140,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,25140,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,25141,0)
 ;;=N30.90^^107^1213^20
 ;;^UTILITY(U,$J,358.3,25141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25141,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
