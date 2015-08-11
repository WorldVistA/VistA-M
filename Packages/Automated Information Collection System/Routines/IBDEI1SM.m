IBDEI1SM ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32029,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,32029,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,32030,0)
 ;;=J10.08^^190^1945^36
 ;;^UTILITY(U,$J,358.3,32030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32030,1,3,0)
 ;;=3^Influenza d/t Oth Indent Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,32030,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,32030,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,32031,0)
 ;;=J10.00^^190^1945^35
 ;;^UTILITY(U,$J,358.3,32031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32031,1,3,0)
 ;;=3^Influenza d/t Oth Indent Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,32031,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,32031,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,32032,0)
 ;;=J11.08^^190^1945^38
 ;;^UTILITY(U,$J,358.3,32032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32032,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,32032,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,32032,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,32033,0)
 ;;=J10.1^^190^1945^37
 ;;^UTILITY(U,$J,358.3,32033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32033,1,3,0)
 ;;=3^Influenza d/t Oth Indent Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,32033,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,32033,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,32034,0)
 ;;=J10.01^^190^1945^34
 ;;^UTILITY(U,$J,358.3,32034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32034,1,3,0)
 ;;=3^Influenza d/t Oth Indent Flu Virus w/ Same Oth INdent Flu Virus
 ;;^UTILITY(U,$J,358.3,32034,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,32034,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,32035,0)
 ;;=J11.1^^190^1945^39
 ;;^UTILITY(U,$J,358.3,32035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32035,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,32035,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,32035,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,32036,0)
 ;;=N12.^^190^1945^77
 ;;^UTILITY(U,$J,358.3,32036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32036,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,32036,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,32036,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,32037,0)
 ;;=N11.9^^190^1945^78
 ;;^UTILITY(U,$J,358.3,32037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32037,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,32037,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,32037,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,32038,0)
 ;;=N13.6^^190^1945^66
 ;;^UTILITY(U,$J,358.3,32038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32038,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,32038,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,32038,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,32039,0)
 ;;=N30.91^^190^1945^18
 ;;^UTILITY(U,$J,358.3,32039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32039,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,32039,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,32039,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,32040,0)
 ;;=N30.90^^190^1945^19
 ;;^UTILITY(U,$J,358.3,32040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32040,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,32040,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,32040,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,32041,0)
 ;;=N41.9^^190^1945^33
 ;;^UTILITY(U,$J,358.3,32041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32041,1,3,0)
 ;;=3^Inflammatory Disease of Prostate,Unspec
 ;;^UTILITY(U,$J,358.3,32041,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,32041,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,32042,0)
 ;;=N70.91^^190^1945^68
