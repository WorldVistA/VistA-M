IBDEI172 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19394,1,2,0)
 ;;=2^Electrical Stimulation,Wound Care
 ;;^UTILITY(U,$J,358.3,19394,1,3,0)
 ;;=3^G0281
 ;;^UTILITY(U,$J,358.3,19395,0)
 ;;=G0283^^66^863^4^^^^1
 ;;^UTILITY(U,$J,358.3,19395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19395,1,2,0)
 ;;=2^Electrical Stimulation,Oth than Wnd Care
 ;;^UTILITY(U,$J,358.3,19395,1,3,0)
 ;;=3^G0283
 ;;^UTILITY(U,$J,358.3,19396,0)
 ;;=G0329^^66^863^6^^^^1
 ;;^UTILITY(U,$J,358.3,19396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19396,1,2,0)
 ;;=2^Electromagnetic Therapy,Wound Care
 ;;^UTILITY(U,$J,358.3,19396,1,3,0)
 ;;=3^G0329
 ;;^UTILITY(U,$J,358.3,19397,0)
 ;;=97610^^66^863^12^^^^1
 ;;^UTILITY(U,$J,358.3,19397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19397,1,2,0)
 ;;=2^US LF Non-Contact Non-Therm,Wnd Assess
 ;;^UTILITY(U,$J,358.3,19397,1,3,0)
 ;;=3^97610
 ;;^UTILITY(U,$J,358.3,19398,0)
 ;;=97607^^66^863^8^^^^1
 ;;^UTILITY(U,$J,358.3,19398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19398,1,2,0)
 ;;=2^Neg Press Wound Tx </= 50 Sq Cm using non-DME
 ;;^UTILITY(U,$J,358.3,19398,1,3,0)
 ;;=3^97607
 ;;^UTILITY(U,$J,358.3,19399,0)
 ;;=97608^^66^863^10^^^^1
 ;;^UTILITY(U,$J,358.3,19399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19399,1,2,0)
 ;;=2^Neg Press Wound Tx > 50 Sq Cm using non-DME
 ;;^UTILITY(U,$J,358.3,19399,1,3,0)
 ;;=3^97608
 ;;^UTILITY(U,$J,358.3,19400,0)
 ;;=G0282^^66^863^3^^^^1
 ;;^UTILITY(U,$J,358.3,19400,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19400,1,2,0)
 ;;=2^Elect Stim Wound Care Not Described by G0281
 ;;^UTILITY(U,$J,358.3,19400,1,3,0)
 ;;=3^G0282
 ;;^UTILITY(U,$J,358.3,19401,0)
 ;;=93797^^66^864^2^^^^1
 ;;^UTILITY(U,$J,358.3,19401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19401,1,2,0)
 ;;=2^Cardiac Rehab w/o Contin ECG Monitor
 ;;^UTILITY(U,$J,358.3,19401,1,3,0)
 ;;=3^93797
 ;;^UTILITY(U,$J,358.3,19402,0)
 ;;=93798^^66^864^1^^^^1
 ;;^UTILITY(U,$J,358.3,19402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19402,1,2,0)
 ;;=2^Cardiac Rehab w/Contin ECG Monitor
 ;;^UTILITY(U,$J,358.3,19402,1,3,0)
 ;;=3^93798
 ;;^UTILITY(U,$J,358.3,19403,0)
 ;;=G0422^^66^864^3^^^^1
 ;;^UTILITY(U,$J,358.3,19403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19403,1,2,0)
 ;;=2^Intens Card Rehab w/ or w/o ECG,per Session
 ;;^UTILITY(U,$J,358.3,19403,1,3,0)
 ;;=3^G0422
 ;;^UTILITY(U,$J,358.3,19404,0)
 ;;=98960^^66^865^3^^^^1
 ;;^UTILITY(U,$J,358.3,19404,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19404,1,2,0)
 ;;=2^Ed/Train Self-Mgmt nonphy;1 pt ea 30min
 ;;^UTILITY(U,$J,358.3,19404,1,3,0)
 ;;=3^98960
 ;;^UTILITY(U,$J,358.3,19405,0)
 ;;=98961^^66^865^1^^^^1
 ;;^UTILITY(U,$J,358.3,19405,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19405,1,2,0)
 ;;=2^Ed/Train Self-Mgmt HCP;2-4 pts ea 30min
 ;;^UTILITY(U,$J,358.3,19405,1,3,0)
 ;;=3^98961
 ;;^UTILITY(U,$J,358.3,19406,0)
 ;;=98962^^66^865^2^^^^1
 ;;^UTILITY(U,$J,358.3,19406,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19406,1,2,0)
 ;;=2^Ed/Train Self-Mgmt HCP;5-8 pts ea 30min
 ;;^UTILITY(U,$J,358.3,19406,1,3,0)
 ;;=3^98962
 ;;^UTILITY(U,$J,358.3,19407,0)
 ;;=97760^^66^865^4^^^^1
 ;;^UTILITY(U,$J,358.3,19407,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19407,1,2,0)
 ;;=2^Orthotic Mgmt/Trng,1st Encntr,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19407,1,3,0)
 ;;=3^97760
 ;;^UTILITY(U,$J,358.3,19408,0)
 ;;=97761^^66^865^5^^^^1
 ;;^UTILITY(U,$J,358.3,19408,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19408,1,2,0)
 ;;=2^Prosthetics Trng,1st Encntr,Ea 15 min
