IBDEI0KY ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9270,0)
 ;;=16000^^70^631^12^^^^1
 ;;^UTILITY(U,$J,358.3,9270,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9270,1,2,0)
 ;;=2^16000
 ;;^UTILITY(U,$J,358.3,9270,1,3,0)
 ;;=3^1st Degree Burn Treatment
 ;;^UTILITY(U,$J,358.3,9271,0)
 ;;=16020^^70^631^13^^^^1
 ;;^UTILITY(U,$J,358.3,9271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9271,1,2,0)
 ;;=2^16020
 ;;^UTILITY(U,$J,358.3,9271,1,3,0)
 ;;=3^Partial Thickness Dress/Debride < 5%
 ;;^UTILITY(U,$J,358.3,9272,0)
 ;;=16025^^70^631^14^^^^1
 ;;^UTILITY(U,$J,358.3,9272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9272,1,2,0)
 ;;=2^16025
 ;;^UTILITY(U,$J,358.3,9272,1,3,0)
 ;;=3^Partial Thickness Dress/Debride 5-10%
 ;;^UTILITY(U,$J,358.3,9273,0)
 ;;=16030^^70^631^15^^^^1
 ;;^UTILITY(U,$J,358.3,9273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9273,1,2,0)
 ;;=2^16030
 ;;^UTILITY(U,$J,358.3,9273,1,3,0)
 ;;=3^Partial Thickness Dress/Debride > 10%
 ;;^UTILITY(U,$J,358.3,9274,0)
 ;;=64450^^70^631^1^^^^1
 ;;^UTILITY(U,$J,358.3,9274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9274,1,2,0)
 ;;=2^64450
 ;;^UTILITY(U,$J,358.3,9274,1,3,0)
 ;;=3^Peripheral Nerve Block
 ;;^UTILITY(U,$J,358.3,9275,0)
 ;;=97602^^70^631^2^^^^1
 ;;^UTILITY(U,$J,358.3,9275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9275,1,2,0)
 ;;=2^97602
 ;;^UTILITY(U,$J,358.3,9275,1,3,0)
 ;;=3^Wound Care,Non-Selective Debridement
 ;;^UTILITY(U,$J,358.3,9276,0)
 ;;=10060^^70^631^3^^^^1
 ;;^UTILITY(U,$J,358.3,9276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9276,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,9276,1,3,0)
 ;;=3^Abscess I&D,Simp/Single
 ;;^UTILITY(U,$J,358.3,9277,0)
 ;;=10061^^70^631^4^^^^1
 ;;^UTILITY(U,$J,358.3,9277,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9277,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,9277,1,3,0)
 ;;=3^Abscess I&D,Complex/Multiple
 ;;^UTILITY(U,$J,358.3,9278,0)
 ;;=26010^^70^631^5^^^^1
 ;;^UTILITY(U,$J,358.3,9278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9278,1,2,0)
 ;;=2^26010
 ;;^UTILITY(U,$J,358.3,9278,1,3,0)
 ;;=3^Finger Abscess,Drainage,Simple
 ;;^UTILITY(U,$J,358.3,9279,0)
 ;;=11740^^70^631^7^^^^1
 ;;^UTILITY(U,$J,358.3,9279,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9279,1,2,0)
 ;;=2^11740
 ;;^UTILITY(U,$J,358.3,9279,1,3,0)
 ;;=3^Subungual Hematoma Drainage
 ;;^UTILITY(U,$J,358.3,9280,0)
 ;;=46320^^70^631^8^^^^1
 ;;^UTILITY(U,$J,358.3,9280,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9280,1,2,0)
 ;;=2^46320
 ;;^UTILITY(U,$J,358.3,9280,1,3,0)
 ;;=3^Hemorrhoid Excision,Thrombosed,External
 ;;^UTILITY(U,$J,358.3,9281,0)
 ;;=46050^^70^631^9^^^^1
 ;;^UTILITY(U,$J,358.3,9281,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9281,1,2,0)
 ;;=2^46050
 ;;^UTILITY(U,$J,358.3,9281,1,3,0)
 ;;=3^Perianal Abscess I&D
 ;;^UTILITY(U,$J,358.3,9282,0)
 ;;=56420^^70^631^10^^^^1
 ;;^UTILITY(U,$J,358.3,9282,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9282,1,2,0)
 ;;=2^56420
 ;;^UTILITY(U,$J,358.3,9282,1,3,0)
 ;;=3^Bartholin's Cyst I&D
 ;;^UTILITY(U,$J,358.3,9283,0)
 ;;=56405^^70^631^11^^^^1
 ;;^UTILITY(U,$J,358.3,9283,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9283,1,2,0)
 ;;=2^56405
 ;;^UTILITY(U,$J,358.3,9283,1,3,0)
 ;;=3^Vulva/Perineal Abscess I&D
 ;;^UTILITY(U,$J,358.3,9284,0)
 ;;=10120^^70^631^6^^^^1
 ;;^UTILITY(U,$J,358.3,9284,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9284,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,9284,1,3,0)
 ;;=3^Foreign Body Removal,Subq,Simple
