IBDEI2VR ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48360,1,2,0)
 ;;=2^Neg Press Wound Tx > 50 Sq Cm using DME
 ;;^UTILITY(U,$J,358.3,48360,1,3,0)
 ;;=3^97606
 ;;^UTILITY(U,$J,358.3,48361,0)
 ;;=97602^^215^2398^10^^^^1
 ;;^UTILITY(U,$J,358.3,48361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48361,1,2,0)
 ;;=2^Removal devitalized tissue w/o anesth
 ;;^UTILITY(U,$J,358.3,48361,1,3,0)
 ;;=3^97602
 ;;^UTILITY(U,$J,358.3,48362,0)
 ;;=G0281^^215^2398^4^^^^1
 ;;^UTILITY(U,$J,358.3,48362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48362,1,2,0)
 ;;=2^Electrical Stimulation,Wound Care
 ;;^UTILITY(U,$J,358.3,48362,1,3,0)
 ;;=3^G0281
 ;;^UTILITY(U,$J,358.3,48363,0)
 ;;=G0283^^215^2398^3^^^^1
 ;;^UTILITY(U,$J,358.3,48363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48363,1,2,0)
 ;;=2^Electrical Stimulation,Oth than Wnd Care
 ;;^UTILITY(U,$J,358.3,48363,1,3,0)
 ;;=3^G0283
 ;;^UTILITY(U,$J,358.3,48364,0)
 ;;=G0329^^215^2398^5^^^^1
 ;;^UTILITY(U,$J,358.3,48364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48364,1,2,0)
 ;;=2^Electromagnetic Therapy,Wound Care
 ;;^UTILITY(U,$J,358.3,48364,1,3,0)
 ;;=3^G0329
 ;;^UTILITY(U,$J,358.3,48365,0)
 ;;=97610^^215^2398^11^^^^1
 ;;^UTILITY(U,$J,358.3,48365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48365,1,2,0)
 ;;=2^US LF Non-Contact Non-Therm,Wnd Assess
 ;;^UTILITY(U,$J,358.3,48365,1,3,0)
 ;;=3^97610
 ;;^UTILITY(U,$J,358.3,48366,0)
 ;;=97607^^215^2398^7^^^^1
 ;;^UTILITY(U,$J,358.3,48366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48366,1,2,0)
 ;;=2^Neg Press Wound Tx </= 50 Sq Cm using non-DME
 ;;^UTILITY(U,$J,358.3,48366,1,3,0)
 ;;=3^97607
 ;;^UTILITY(U,$J,358.3,48367,0)
 ;;=97608^^215^2398^9^^^^1
 ;;^UTILITY(U,$J,358.3,48367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48367,1,2,0)
 ;;=2^Neg Press Wound Tx > 50 Sq Cm using non-DME
 ;;^UTILITY(U,$J,358.3,48367,1,3,0)
 ;;=3^97608
 ;;^UTILITY(U,$J,358.3,48368,0)
 ;;=93797^^215^2399^2^^^^1
 ;;^UTILITY(U,$J,358.3,48368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48368,1,2,0)
 ;;=2^Cardiac Rehab w/o Contin ECG Monitor
 ;;^UTILITY(U,$J,358.3,48368,1,3,0)
 ;;=3^93797
 ;;^UTILITY(U,$J,358.3,48369,0)
 ;;=93798^^215^2399^1^^^^1
 ;;^UTILITY(U,$J,358.3,48369,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48369,1,2,0)
 ;;=2^Cardiac Rehab w/Contin ECG Monitor
 ;;^UTILITY(U,$J,358.3,48369,1,3,0)
 ;;=3^93798
 ;;^UTILITY(U,$J,358.3,48370,0)
 ;;=G0422^^215^2399^3^^^^1
 ;;^UTILITY(U,$J,358.3,48370,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48370,1,2,0)
 ;;=2^Intens Card Rehab w/ or w/o ECG,per Session
 ;;^UTILITY(U,$J,358.3,48370,1,3,0)
 ;;=3^G0422
 ;;^UTILITY(U,$J,358.3,48371,0)
 ;;=G0424^^215^2399^4^^^^1
 ;;^UTILITY(U,$J,358.3,48371,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48371,1,2,0)
 ;;=2^Pulm Rehab w/ Exer,1hr,per Session,Max 2/day
 ;;^UTILITY(U,$J,358.3,48371,1,3,0)
 ;;=3^G0424
 ;;^UTILITY(U,$J,358.3,48372,0)
 ;;=98960^^215^2400^3^^^^1
 ;;^UTILITY(U,$J,358.3,48372,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48372,1,2,0)
 ;;=2^Ed/Train Self-Mgmt nonphy;1 pt ea 30min
 ;;^UTILITY(U,$J,358.3,48372,1,3,0)
 ;;=3^98960
 ;;^UTILITY(U,$J,358.3,48373,0)
 ;;=98961^^215^2400^1^^^^1
 ;;^UTILITY(U,$J,358.3,48373,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48373,1,2,0)
 ;;=2^Ed/Train Self-Mgmt HCP;2-4 pts ea 30min
 ;;^UTILITY(U,$J,358.3,48373,1,3,0)
 ;;=3^98961
 ;;^UTILITY(U,$J,358.3,48374,0)
 ;;=98962^^215^2400^2^^^^1
 ;;^UTILITY(U,$J,358.3,48374,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48374,1,2,0)
 ;;=2^Ed/Train Self-Mgmt HCP;5-8 pts ea 30min
 ;;^UTILITY(U,$J,358.3,48374,1,3,0)
 ;;=3^98962
