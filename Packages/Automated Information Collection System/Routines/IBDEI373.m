IBDEI373 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51014,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,51014,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,51014,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,51015,0)
 ;;=J12.9^^193^2499^69
 ;;^UTILITY(U,$J,358.3,51015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51015,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,51015,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,51015,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,51016,0)
 ;;=J10.08^^193^2499^41
 ;;^UTILITY(U,$J,358.3,51016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51016,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,51016,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,51016,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,51017,0)
 ;;=J10.00^^193^2499^40
 ;;^UTILITY(U,$J,358.3,51017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51017,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,51017,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,51017,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,51018,0)
 ;;=J11.08^^193^2499^43
 ;;^UTILITY(U,$J,358.3,51018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51018,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,51018,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,51018,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,51019,0)
 ;;=J10.1^^193^2499^42
 ;;^UTILITY(U,$J,358.3,51019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51019,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,51019,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,51019,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,51020,0)
 ;;=J10.01^^193^2499^39
 ;;^UTILITY(U,$J,358.3,51020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51020,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,51020,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,51020,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,51021,0)
 ;;=J11.1^^193^2499^44
 ;;^UTILITY(U,$J,358.3,51021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51021,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,51021,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,51021,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,51022,0)
 ;;=N12.^^193^2499^85
 ;;^UTILITY(U,$J,358.3,51022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51022,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,51022,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,51022,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,51023,0)
 ;;=N11.9^^193^2499^86
 ;;^UTILITY(U,$J,358.3,51023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51023,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
 ;;^UTILITY(U,$J,358.3,51023,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,51023,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,51024,0)
 ;;=N13.6^^193^2499^73
 ;;^UTILITY(U,$J,358.3,51024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51024,1,3,0)
 ;;=3^Pyonephrosis
 ;;^UTILITY(U,$J,358.3,51024,1,4,0)
 ;;=4^N13.6
 ;;^UTILITY(U,$J,358.3,51024,2)
 ;;=^101552
 ;;^UTILITY(U,$J,358.3,51025,0)
 ;;=N30.91^^193^2499^19
 ;;^UTILITY(U,$J,358.3,51025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51025,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,51025,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,51025,2)
 ;;=^5015643
