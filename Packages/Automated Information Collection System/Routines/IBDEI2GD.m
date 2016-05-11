IBDEI2GD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41600,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,41600,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,41600,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,41601,0)
 ;;=J10.08^^159^2006^41
 ;;^UTILITY(U,$J,358.3,41601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41601,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,41601,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,41601,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,41602,0)
 ;;=J10.00^^159^2006^40
 ;;^UTILITY(U,$J,358.3,41602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41602,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,41602,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,41602,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,41603,0)
 ;;=J11.08^^159^2006^43
 ;;^UTILITY(U,$J,358.3,41603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41603,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,41603,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,41603,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,41604,0)
 ;;=J10.1^^159^2006^42
 ;;^UTILITY(U,$J,358.3,41604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41604,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,41604,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,41604,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,41605,0)
 ;;=J10.01^^159^2006^39
 ;;^UTILITY(U,$J,358.3,41605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41605,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,41605,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,41605,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,41606,0)
 ;;=J11.1^^159^2006^44
 ;;^UTILITY(U,$J,358.3,41606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41606,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,41606,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,41606,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,41607,0)
 ;;=N12.^^159^2006^85
 ;;^UTILITY(U,$J,358.3,41607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41607,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,41607,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,41607,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,41608,0)
 ;;=N11.9^^159^2006^86
 ;;^UTILITY(U,$J,358.3,41608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41608,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,41608,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,41608,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,41609,0)
 ;;=N13.6^^159^2006^73
 ;;^UTILITY(U,$J,358.3,41609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41609,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,41609,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,41609,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,41610,0)
 ;;=N30.91^^159^2006^19
 ;;^UTILITY(U,$J,358.3,41610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41610,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,41610,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,41610,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,41611,0)
 ;;=N30.90^^159^2006^20
 ;;^UTILITY(U,$J,358.3,41611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41611,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,41611,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,41611,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,41612,0)
 ;;=N41.9^^159^2006^38
 ;;^UTILITY(U,$J,358.3,41612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41612,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
