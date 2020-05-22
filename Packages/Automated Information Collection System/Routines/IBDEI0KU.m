IBDEI0KU ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9210,1,3,0)
 ;;=3^Albuterol,Inhale,Non-Compd,Concentrate Frm 1mg
 ;;^UTILITY(U,$J,358.3,9211,0)
 ;;=J7644^^70^626^8^^^^1
 ;;^UTILITY(U,$J,358.3,9211,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9211,1,2,0)
 ;;=2^J7644
 ;;^UTILITY(U,$J,358.3,9211,1,3,0)
 ;;=3^Ipratropium Bromide Inhale,Non-Compd,Unit per mg
 ;;^UTILITY(U,$J,358.3,9212,0)
 ;;=J7620^^70^626^2^^^^1
 ;;^UTILITY(U,$J,358.3,9212,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9212,1,2,0)
 ;;=2^J7620
 ;;^UTILITY(U,$J,358.3,9212,1,3,0)
 ;;=3^Albuterol 2.5mg/Ipratropium Bromide 0.5mg Non-Comp
 ;;^UTILITY(U,$J,358.3,9213,0)
 ;;=36556^^70^627^5^^^^1
 ;;^UTILITY(U,$J,358.3,9213,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9213,1,2,0)
 ;;=2^36556
 ;;^UTILITY(U,$J,358.3,9213,1,3,0)
 ;;=3^Central Venous Line
 ;;^UTILITY(U,$J,358.3,9214,0)
 ;;=36600^^70^627^3^^^^1
 ;;^UTILITY(U,$J,358.3,9214,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9214,1,2,0)
 ;;=2^36600
 ;;^UTILITY(U,$J,358.3,9214,1,3,0)
 ;;=3^Arterial Puncture (ABG)
 ;;^UTILITY(U,$J,358.3,9215,0)
 ;;=36680^^70^627^4^^^^1
 ;;^UTILITY(U,$J,358.3,9215,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9215,1,2,0)
 ;;=2^36680
 ;;^UTILITY(U,$J,358.3,9215,1,3,0)
 ;;=3^Intraosseous Line Placement
 ;;^UTILITY(U,$J,358.3,9216,0)
 ;;=37195^^70^627^16^^^^1
 ;;^UTILITY(U,$J,358.3,9216,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9216,1,2,0)
 ;;=2^37195
 ;;^UTILITY(U,$J,358.3,9216,1,3,0)
 ;;=3^Thrombolysis Cerebral,IV Infusion
 ;;^UTILITY(U,$J,358.3,9217,0)
 ;;=92953^^70^627^10^^^^1
 ;;^UTILITY(U,$J,358.3,9217,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9217,1,2,0)
 ;;=2^92953
 ;;^UTILITY(U,$J,358.3,9217,1,3,0)
 ;;=3^Pacing,Transcutaneous
 ;;^UTILITY(U,$J,358.3,9218,0)
 ;;=92960^^70^627^9^^^^1
 ;;^UTILITY(U,$J,358.3,9218,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9218,1,2,0)
 ;;=2^92960
 ;;^UTILITY(U,$J,358.3,9218,1,3,0)
 ;;=3^Defibrillation for Cardioversion,External (NOT in CPR)
 ;;^UTILITY(U,$J,358.3,9219,0)
 ;;=92977^^70^627^15^^^^1
 ;;^UTILITY(U,$J,358.3,9219,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9219,1,2,0)
 ;;=2^92977
 ;;^UTILITY(U,$J,358.3,9219,1,3,0)
 ;;=3^Thrombolysis Coronary,IV Infusion
 ;;^UTILITY(U,$J,358.3,9220,0)
 ;;=36430^^70^627^19^^^^1
 ;;^UTILITY(U,$J,358.3,9220,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9220,1,2,0)
 ;;=2^36430
 ;;^UTILITY(U,$J,358.3,9220,1,3,0)
 ;;=3^Transfusion,Blood/Blood Components
 ;;^UTILITY(U,$J,358.3,9221,0)
 ;;=31500^^70^627^6^^^^1
 ;;^UTILITY(U,$J,358.3,9221,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9221,1,2,0)
 ;;=2^31500
 ;;^UTILITY(U,$J,358.3,9221,1,3,0)
 ;;=3^Enodotracheal Intubation
 ;;^UTILITY(U,$J,358.3,9222,0)
 ;;=31505^^70^627^7^^^^1
 ;;^UTILITY(U,$J,358.3,9222,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9222,1,2,0)
 ;;=2^31505
 ;;^UTILITY(U,$J,358.3,9222,1,3,0)
 ;;=3^Indirect Laryngoscopy
 ;;^UTILITY(U,$J,358.3,9223,0)
 ;;=92950^^70^627^8^^^^1
 ;;^UTILITY(U,$J,358.3,9223,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9223,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,9223,1,3,0)
 ;;=3^CPR Resuscitation
 ;;^UTILITY(U,$J,358.3,9224,0)
 ;;=32554^^70^627^11^^^^1
 ;;^UTILITY(U,$J,358.3,9224,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9224,1,2,0)
 ;;=2^32554
 ;;^UTILITY(U,$J,358.3,9224,1,3,0)
 ;;=3^Thoracentesis w/o Imaging Guidance
 ;;^UTILITY(U,$J,358.3,9225,0)
 ;;=32555^^70^627^12^^^^1
 ;;^UTILITY(U,$J,358.3,9225,1,0)
 ;;=^358.31IA^3^2
