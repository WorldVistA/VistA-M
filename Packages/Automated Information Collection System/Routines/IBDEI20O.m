IBDEI20O ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34216,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,34216,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,34216,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,34217,0)
 ;;=J10.08^^131^1682^41
 ;;^UTILITY(U,$J,358.3,34217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34217,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,34217,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,34217,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,34218,0)
 ;;=J10.00^^131^1682^40
 ;;^UTILITY(U,$J,358.3,34218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34218,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,34218,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,34218,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,34219,0)
 ;;=J11.08^^131^1682^43
 ;;^UTILITY(U,$J,358.3,34219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34219,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,34219,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,34219,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,34220,0)
 ;;=J10.1^^131^1682^42
 ;;^UTILITY(U,$J,358.3,34220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34220,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,34220,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,34220,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,34221,0)
 ;;=J10.01^^131^1682^39
 ;;^UTILITY(U,$J,358.3,34221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34221,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,34221,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,34221,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,34222,0)
 ;;=J11.1^^131^1682^44
 ;;^UTILITY(U,$J,358.3,34222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34222,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,34222,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,34222,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,34223,0)
 ;;=N12.^^131^1682^85
 ;;^UTILITY(U,$J,358.3,34223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34223,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,34223,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,34223,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,34224,0)
 ;;=N11.9^^131^1682^86
 ;;^UTILITY(U,$J,358.3,34224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34224,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,34224,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,34224,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,34225,0)
 ;;=N13.6^^131^1682^73
 ;;^UTILITY(U,$J,358.3,34225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34225,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,34225,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,34225,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,34226,0)
 ;;=N30.91^^131^1682^19
 ;;^UTILITY(U,$J,358.3,34226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34226,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,34226,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,34226,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,34227,0)
 ;;=N30.90^^131^1682^20
 ;;^UTILITY(U,$J,358.3,34227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34227,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,34227,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,34227,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,34228,0)
 ;;=N41.9^^131^1682^38
 ;;^UTILITY(U,$J,358.3,34228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34228,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
