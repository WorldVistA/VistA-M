IBDEI1H2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23544,1,3,0)
 ;;=3^Genital Syphilis,Primary
 ;;^UTILITY(U,$J,358.3,23544,1,4,0)
 ;;=4^A51.0
 ;;^UTILITY(U,$J,358.3,23544,2)
 ;;=^5000272
 ;;^UTILITY(U,$J,358.3,23545,0)
 ;;=N41.9^^105^1174^72
 ;;^UTILITY(U,$J,358.3,23545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23545,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
 ;;^UTILITY(U,$J,358.3,23545,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,23545,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,23546,0)
 ;;=N72.^^105^1174^70
 ;;^UTILITY(U,$J,358.3,23546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23546,1,3,0)
 ;;=3^Inflammatory Disease of Cervix Uteri
 ;;^UTILITY(U,$J,358.3,23546,1,4,0)
 ;;=4^N72.
 ;;^UTILITY(U,$J,358.3,23546,2)
 ;;=^5015812
 ;;^UTILITY(U,$J,358.3,23547,0)
 ;;=A56.11^^105^1174^69
 ;;^UTILITY(U,$J,358.3,23547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23547,1,3,0)
 ;;=3^Inflammatory Disease Chlamydial Female Pelvic
 ;;^UTILITY(U,$J,358.3,23547,1,4,0)
 ;;=4^A56.11
 ;;^UTILITY(U,$J,358.3,23547,2)
 ;;=^5000342
 ;;^UTILITY(U,$J,358.3,23548,0)
 ;;=N73.9^^105^1174^71
 ;;^UTILITY(U,$J,358.3,23548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23548,1,3,0)
 ;;=3^Inflammatory Disease of Female Pelvice,Unspec
 ;;^UTILITY(U,$J,358.3,23548,1,4,0)
 ;;=4^N73.9
 ;;^UTILITY(U,$J,358.3,23548,2)
 ;;=^5015820
 ;;^UTILITY(U,$J,358.3,23549,0)
 ;;=J10.01^^105^1174^75
 ;;^UTILITY(U,$J,358.3,23549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23549,1,3,0)
 ;;=3^Influenza d/t Oth Indent Flu Virus w/ Same Oth Ident Flu Virus
 ;;^UTILITY(U,$J,358.3,23549,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,23549,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,23550,0)
 ;;=J10.00^^105^1174^76
 ;;^UTILITY(U,$J,358.3,23550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23550,1,3,0)
 ;;=3^Influenza d/t Oth Indent Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,23550,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,23550,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,23551,0)
 ;;=J10.08^^105^1174^74
 ;;^UTILITY(U,$J,358.3,23551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23551,1,3,0)
 ;;=3^Influenza d/t Oth Indent Flu Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,23551,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,23551,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,23552,0)
 ;;=J10.1^^105^1174^77
 ;;^UTILITY(U,$J,358.3,23552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23552,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,23552,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,23552,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,23553,0)
 ;;=J11.08^^105^1174^78
 ;;^UTILITY(U,$J,358.3,23553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23553,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,23553,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,23553,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,23554,0)
 ;;=A52.9^^105^1174^84
 ;;^UTILITY(U,$J,358.3,23554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23554,1,3,0)
 ;;=3^Late Syphilis,Unspec
 ;;^UTILITY(U,$J,358.3,23554,1,4,0)
 ;;=4^A52.9
 ;;^UTILITY(U,$J,358.3,23554,2)
 ;;=^5000308
 ;;^UTILITY(U,$J,358.3,23555,0)
 ;;=A69.21^^105^1174^88
 ;;^UTILITY(U,$J,358.3,23555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23555,1,3,0)
 ;;=3^Meningitis d/t Lyme Disease
 ;;^UTILITY(U,$J,358.3,23555,1,4,0)
 ;;=4^A69.21
 ;;^UTILITY(U,$J,358.3,23555,2)
 ;;=^5000376
