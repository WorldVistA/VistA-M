IBDEI2LJ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41455,1,3,0)
 ;;=3^97606
 ;;^UTILITY(U,$J,358.3,41456,0)
 ;;=97602^^154^2045^11^^^^1
 ;;^UTILITY(U,$J,358.3,41456,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41456,1,2,0)
 ;;=2^Removal devitalized tissue w/o anesth
 ;;^UTILITY(U,$J,358.3,41456,1,3,0)
 ;;=3^97602
 ;;^UTILITY(U,$J,358.3,41457,0)
 ;;=G0281^^154^2045^5^^^^1
 ;;^UTILITY(U,$J,358.3,41457,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41457,1,2,0)
 ;;=2^Electrical Stimulation,Wound Care
 ;;^UTILITY(U,$J,358.3,41457,1,3,0)
 ;;=3^G0281
 ;;^UTILITY(U,$J,358.3,41458,0)
 ;;=G0283^^154^2045^4^^^^1
 ;;^UTILITY(U,$J,358.3,41458,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41458,1,2,0)
 ;;=2^Electrical Stimulation,Oth than Wnd Care
 ;;^UTILITY(U,$J,358.3,41458,1,3,0)
 ;;=3^G0283
 ;;^UTILITY(U,$J,358.3,41459,0)
 ;;=G0329^^154^2045^6^^^^1
 ;;^UTILITY(U,$J,358.3,41459,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41459,1,2,0)
 ;;=2^Electromagnetic Therapy,Wound Care
 ;;^UTILITY(U,$J,358.3,41459,1,3,0)
 ;;=3^G0329
 ;;^UTILITY(U,$J,358.3,41460,0)
 ;;=97610^^154^2045^12^^^^1
 ;;^UTILITY(U,$J,358.3,41460,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41460,1,2,0)
 ;;=2^US LF Non-Contact Non-Therm,Wnd Assess
 ;;^UTILITY(U,$J,358.3,41460,1,3,0)
 ;;=3^97610
 ;;^UTILITY(U,$J,358.3,41461,0)
 ;;=97607^^154^2045^8^^^^1
 ;;^UTILITY(U,$J,358.3,41461,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41461,1,2,0)
 ;;=2^Neg Press Wound Tx </= 50 Sq Cm using non-DME
 ;;^UTILITY(U,$J,358.3,41461,1,3,0)
 ;;=3^97607
 ;;^UTILITY(U,$J,358.3,41462,0)
 ;;=97608^^154^2045^10^^^^1
 ;;^UTILITY(U,$J,358.3,41462,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41462,1,2,0)
 ;;=2^Neg Press Wound Tx > 50 Sq Cm using non-DME
 ;;^UTILITY(U,$J,358.3,41462,1,3,0)
 ;;=3^97608
 ;;^UTILITY(U,$J,358.3,41463,0)
 ;;=G0282^^154^2045^3^^^^1
 ;;^UTILITY(U,$J,358.3,41463,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41463,1,2,0)
 ;;=2^Elect Stim Wound Care Not Described by G0281
 ;;^UTILITY(U,$J,358.3,41463,1,3,0)
 ;;=3^G0282
 ;;^UTILITY(U,$J,358.3,41464,0)
 ;;=93797^^154^2046^2^^^^1
 ;;^UTILITY(U,$J,358.3,41464,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41464,1,2,0)
 ;;=2^Cardiac Rehab w/o Contin ECG Monitor
 ;;^UTILITY(U,$J,358.3,41464,1,3,0)
 ;;=3^93797
 ;;^UTILITY(U,$J,358.3,41465,0)
 ;;=93798^^154^2046^1^^^^1
 ;;^UTILITY(U,$J,358.3,41465,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41465,1,2,0)
 ;;=2^Cardiac Rehab w/Contin ECG Monitor
 ;;^UTILITY(U,$J,358.3,41465,1,3,0)
 ;;=3^93798
 ;;^UTILITY(U,$J,358.3,41466,0)
 ;;=G0422^^154^2046^3^^^^1
 ;;^UTILITY(U,$J,358.3,41466,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41466,1,2,0)
 ;;=2^Intens Card Rehab w/ or w/o ECG,per Session
 ;;^UTILITY(U,$J,358.3,41466,1,3,0)
 ;;=3^G0422
 ;;^UTILITY(U,$J,358.3,41467,0)
 ;;=G0424^^154^2046^4^^^^1
 ;;^UTILITY(U,$J,358.3,41467,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41467,1,2,0)
 ;;=2^Pulm Rehab w/ Exer,1hr,per Session,Max 2/day
 ;;^UTILITY(U,$J,358.3,41467,1,3,0)
 ;;=3^G0424
 ;;^UTILITY(U,$J,358.3,41468,0)
 ;;=98960^^154^2047^3^^^^1
 ;;^UTILITY(U,$J,358.3,41468,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41468,1,2,0)
 ;;=2^Ed/Train Self-Mgmt nonphy;1 pt ea 30min
 ;;^UTILITY(U,$J,358.3,41468,1,3,0)
 ;;=3^98960
 ;;^UTILITY(U,$J,358.3,41469,0)
 ;;=98961^^154^2047^1^^^^1
 ;;^UTILITY(U,$J,358.3,41469,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41469,1,2,0)
 ;;=2^Ed/Train Self-Mgmt HCP;2-4 pts ea 30min
