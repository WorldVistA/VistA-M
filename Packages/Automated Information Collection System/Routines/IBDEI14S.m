IBDEI14S ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18359,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18359,1,2,0)
 ;;=2^90673
 ;;^UTILITY(U,$J,358.3,18359,1,3,0)
 ;;=3^Flu Vaccine,Trivalent RIV3,DNA,HA,Pres ABX Free
 ;;^UTILITY(U,$J,358.3,18360,0)
 ;;=90656^^62^820^2^^^^1
 ;;^UTILITY(U,$J,358.3,18360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18360,1,2,0)
 ;;=2^90656
 ;;^UTILITY(U,$J,358.3,18360,1,3,0)
 ;;=3^Flu Vaccine,Trivalent,Split Virus,0.5ml,Prsv Free
 ;;^UTILITY(U,$J,358.3,18361,0)
 ;;=90658^^62^820^3^^^^1
 ;;^UTILITY(U,$J,358.3,18361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18361,1,2,0)
 ;;=2^90658
 ;;^UTILITY(U,$J,358.3,18361,1,3,0)
 ;;=3^Flu Vaccine,Trivalent,Split Virus,0.5ml
 ;;^UTILITY(U,$J,358.3,18362,0)
 ;;=90662^^62^820^4^^^^1
 ;;^UTILITY(U,$J,358.3,18362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18362,1,2,0)
 ;;=2^90662
 ;;^UTILITY(U,$J,358.3,18362,1,3,0)
 ;;=3^Flu Virus,Split Virus,High Dose,Prsv Free
 ;;^UTILITY(U,$J,358.3,18363,0)
 ;;=90732^^62^820^5^^^^1
 ;;^UTILITY(U,$J,358.3,18363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18363,1,2,0)
 ;;=2^90732
 ;;^UTILITY(U,$J,358.3,18363,1,3,0)
 ;;=3^Pneumovax 23-Valent (PPSV23) SQ/IM
 ;;^UTILITY(U,$J,358.3,18364,0)
 ;;=31610^^62^821^1^^^^1
 ;;^UTILITY(U,$J,358.3,18364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18364,1,2,0)
 ;;=2^31610
 ;;^UTILITY(U,$J,358.3,18364,1,3,0)
 ;;=3^Trach Fenestration w/ Skin Flaps
 ;;^UTILITY(U,$J,358.3,18365,0)
 ;;=31605^^62^821^3^^^^1
 ;;^UTILITY(U,$J,358.3,18365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18365,1,2,0)
 ;;=2^31605
 ;;^UTILITY(U,$J,358.3,18365,1,3,0)
 ;;=3^Tracheostomy,Emerg,Cricothyroid
 ;;^UTILITY(U,$J,358.3,18366,0)
 ;;=31603^^62^821^2^^^^1
 ;;^UTILITY(U,$J,358.3,18366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18366,1,2,0)
 ;;=2^31603
 ;;^UTILITY(U,$J,358.3,18366,1,3,0)
 ;;=3^Tracheostomy Emerg,Transtracheal
 ;;^UTILITY(U,$J,358.3,18367,0)
 ;;=31600^^62^821^4^^^^1
 ;;^UTILITY(U,$J,358.3,18367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18367,1,2,0)
 ;;=2^31600
 ;;^UTILITY(U,$J,358.3,18367,1,3,0)
 ;;=3^Tracheostomy,Planned
 ;;^UTILITY(U,$J,358.3,18368,0)
 ;;=99358^^62^822^1^^^^1
 ;;^UTILITY(U,$J,358.3,18368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18368,1,2,0)
 ;;=2^99358
 ;;^UTILITY(U,$J,358.3,18368,1,3,0)
 ;;=3^Prolonged Svc,Before/After Visit,1st hr
 ;;^UTILITY(U,$J,358.3,18369,0)
 ;;=99359^^62^822^2^^^^1
 ;;^UTILITY(U,$J,358.3,18369,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18369,1,2,0)
 ;;=2^99359
 ;;^UTILITY(U,$J,358.3,18369,1,3,0)
 ;;=3^Prolonged Svc,Before/After Visit,Ea Add 30min
 ;;^UTILITY(U,$J,358.3,18370,0)
 ;;=99417^^62^822^3^^^^1
 ;;^UTILITY(U,$J,358.3,18370,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18370,1,2,0)
 ;;=2^99417
 ;;^UTILITY(U,$J,358.3,18370,1,3,0)
 ;;=3^Prolonged Svc,Ea 15min;Only with 99205 or 99215
 ;;^UTILITY(U,$J,358.3,18371,0)
 ;;=31500^^62^823^5^^^^1
 ;;^UTILITY(U,$J,358.3,18371,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18371,1,2,0)
 ;;=2^31500
 ;;^UTILITY(U,$J,358.3,18371,1,3,0)
 ;;=3^Intub,Endotrach,Emergency Proc
 ;;^UTILITY(U,$J,358.3,18372,0)
 ;;=92950^^62^823^4^^^^1
 ;;^UTILITY(U,$J,358.3,18372,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18372,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,18372,1,3,0)
 ;;=3^Heart/Lung Resusc/CPR
 ;;^UTILITY(U,$J,358.3,18373,0)
 ;;=99078^^62^823^3^^^^1
 ;;^UTILITY(U,$J,358.3,18373,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18373,1,2,0)
 ;;=2^99078
