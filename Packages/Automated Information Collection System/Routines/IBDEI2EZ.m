IBDEI2EZ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38542,1,2,0)
 ;;=2^11042
 ;;^UTILITY(U,$J,358.3,38542,1,3,0)
 ;;=3^Debridement, Skin & Subcu. Tissue,1st 20sq cm
 ;;^UTILITY(U,$J,358.3,38543,0)
 ;;=20550^^151^1965^24^^^^1
 ;;^UTILITY(U,$J,358.3,38543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38543,1,2,0)
 ;;=2^20550
 ;;^UTILITY(U,$J,358.3,38543,1,3,0)
 ;;=3^Injection,Tendon Sheath,Ligament,Ganglion Cyst
 ;;^UTILITY(U,$J,358.3,38544,0)
 ;;=20551^^151^1965^23^^^^1
 ;;^UTILITY(U,$J,358.3,38544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38544,1,2,0)
 ;;=2^20551
 ;;^UTILITY(U,$J,358.3,38544,1,3,0)
 ;;=3^Injection,Tendon Origin/Insertion
 ;;^UTILITY(U,$J,358.3,38545,0)
 ;;=20552^^151^1965^25^^^^1
 ;;^UTILITY(U,$J,358.3,38545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38545,1,2,0)
 ;;=2^20552
 ;;^UTILITY(U,$J,358.3,38545,1,3,0)
 ;;=3^Injection,Trigger Point, 1 or 2 Muscle groups
 ;;^UTILITY(U,$J,358.3,38546,0)
 ;;=20600^^151^1965^10^^^^1
 ;;^UTILITY(U,$J,358.3,38546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38546,1,2,0)
 ;;=2^20600
 ;;^UTILITY(U,$J,358.3,38546,1,3,0)
 ;;=3^Arthrocentesis,Small Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,38547,0)
 ;;=20605^^151^1965^6^^^^1
 ;;^UTILITY(U,$J,358.3,38547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38547,1,2,0)
 ;;=2^20605
 ;;^UTILITY(U,$J,358.3,38547,1,3,0)
 ;;=3^Arthrocentesis,Intermediate Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,38548,0)
 ;;=20610^^151^1965^8^^^^1
 ;;^UTILITY(U,$J,358.3,38548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38548,1,2,0)
 ;;=2^20610
 ;;^UTILITY(U,$J,358.3,38548,1,3,0)
 ;;=3^Arthrocentesis,Major Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,38549,0)
 ;;=92950^^151^1965^11^^^^1
 ;;^UTILITY(U,$J,358.3,38549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38549,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,38549,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,38550,0)
 ;;=11055^^151^1965^42^^^^1
 ;;^UTILITY(U,$J,358.3,38550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38550,1,2,0)
 ;;=2^11055
 ;;^UTILITY(U,$J,358.3,38550,1,3,0)
 ;;=3^Trim Corn/Callous, One
 ;;^UTILITY(U,$J,358.3,38551,0)
 ;;=11056^^151^1965^40^^^^1
 ;;^UTILITY(U,$J,358.3,38551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38551,1,2,0)
 ;;=2^11056
 ;;^UTILITY(U,$J,358.3,38551,1,3,0)
 ;;=3^Trim Corn/Callous, 2 to 4
 ;;^UTILITY(U,$J,358.3,38552,0)
 ;;=11057^^151^1965^41^^^^1
 ;;^UTILITY(U,$J,358.3,38552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38552,1,2,0)
 ;;=2^11057
 ;;^UTILITY(U,$J,358.3,38552,1,3,0)
 ;;=3^Trim Corn/Callous, 5 or more
 ;;^UTILITY(U,$J,358.3,38553,0)
 ;;=12011^^151^1965^34^^^^1
 ;;^UTILITY(U,$J,358.3,38553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38553,1,2,0)
 ;;=2^12011
 ;;^UTILITY(U,$J,358.3,38553,1,3,0)
 ;;=3^Suture Simple Wound,Face,2.5 cm or <
 ;;^UTILITY(U,$J,358.3,38554,0)
 ;;=97597^^151^1965^12^^^^1
 ;;^UTILITY(U,$J,358.3,38554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38554,1,2,0)
 ;;=2^97597
 ;;^UTILITY(U,$J,358.3,38554,1,3,0)
 ;;=3^Debridement open wnd 1st 20sq cm
 ;;^UTILITY(U,$J,358.3,38555,0)
 ;;=97598^^151^1965^13^^^^1
 ;;^UTILITY(U,$J,358.3,38555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38555,1,2,0)
 ;;=2^97598
 ;;^UTILITY(U,$J,358.3,38555,1,3,0)
 ;;=3^Debridement open wnd ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,38556,0)
 ;;=11200^^151^1965^31^^^^1
 ;;^UTILITY(U,$J,358.3,38556,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38556,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,38556,1,3,0)
 ;;=3^Removal Skin Tags,up to 15 Lesions
