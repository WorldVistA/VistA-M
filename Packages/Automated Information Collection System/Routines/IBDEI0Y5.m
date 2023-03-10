IBDEI0Y5 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15389,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15389,1,2,0)
 ;;=2^96375
 ;;^UTILITY(U,$J,358.3,15389,1,3,0)
 ;;=3^IV Push,Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,15390,0)
 ;;=17000^^59^731^15^^^^1
 ;;^UTILITY(U,$J,358.3,15390,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15390,1,2,0)
 ;;=2^17000
 ;;^UTILITY(U,$J,358.3,15390,1,3,0)
 ;;=3^Destr ben les, any method, 1st les
 ;;^UTILITY(U,$J,358.3,15391,0)
 ;;=17003^^59^731^16^^^^1
 ;;^UTILITY(U,$J,358.3,15391,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15391,1,2,0)
 ;;=2^17003
 ;;^UTILITY(U,$J,358.3,15391,1,3,0)
 ;;=3^Destr ben les, any method,ea addl les (2-14)
 ;;^UTILITY(U,$J,358.3,15392,0)
 ;;=17004^^59^731^17^^^^1
 ;;^UTILITY(U,$J,358.3,15392,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15392,1,2,0)
 ;;=2^17004
 ;;^UTILITY(U,$J,358.3,15392,1,3,0)
 ;;=3^Destr ben les,15 or more
 ;;^UTILITY(U,$J,358.3,15393,0)
 ;;=10060^^59^731^22^^^^1
 ;;^UTILITY(U,$J,358.3,15393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15393,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,15393,1,3,0)
 ;;=3^I&D Abscess
 ;;^UTILITY(U,$J,358.3,15394,0)
 ;;=10061^^59^731^23^^^^1
 ;;^UTILITY(U,$J,358.3,15394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15394,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,15394,1,3,0)
 ;;=3^I&D Complicated Abscess
 ;;^UTILITY(U,$J,358.3,15395,0)
 ;;=12001^^59^731^40^^^^1
 ;;^UTILITY(U,$J,358.3,15395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15395,1,2,0)
 ;;=2^12001
 ;;^UTILITY(U,$J,358.3,15395,1,3,0)
 ;;=3^Suture Simple Wound,Trunk/Ext 2.5 cm or <
 ;;^UTILITY(U,$J,358.3,15396,0)
 ;;=12002^^59^731^41^^^^1
 ;;^UTILITY(U,$J,358.3,15396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15396,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,15396,1,3,0)
 ;;=3^Suture Simple Wound,Trunk/Ext 2.6-7.5 cm
 ;;^UTILITY(U,$J,358.3,15397,0)
 ;;=11042^^59^731^14^^^^1
 ;;^UTILITY(U,$J,358.3,15397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15397,1,2,0)
 ;;=2^11042
 ;;^UTILITY(U,$J,358.3,15397,1,3,0)
 ;;=3^Debridement, Skin & Subcu. Tissue,1st 20sq cm
 ;;^UTILITY(U,$J,358.3,15398,0)
 ;;=20550^^59^731^26^^^^1
 ;;^UTILITY(U,$J,358.3,15398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15398,1,2,0)
 ;;=2^20550
 ;;^UTILITY(U,$J,358.3,15398,1,3,0)
 ;;=3^Injection,Tendon Sheath,Ligament,Ganglion Cyst
 ;;^UTILITY(U,$J,358.3,15399,0)
 ;;=20551^^59^731^25^^^^1
 ;;^UTILITY(U,$J,358.3,15399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15399,1,2,0)
 ;;=2^20551
 ;;^UTILITY(U,$J,358.3,15399,1,3,0)
 ;;=3^Injection,Tendon Origin/Insertion
 ;;^UTILITY(U,$J,358.3,15400,0)
 ;;=20552^^59^731^27^^^^1
 ;;^UTILITY(U,$J,358.3,15400,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15400,1,2,0)
 ;;=2^20552
 ;;^UTILITY(U,$J,358.3,15400,1,3,0)
 ;;=3^Injection,Trigger Point, 1 or 2 Muscle groups
 ;;^UTILITY(U,$J,358.3,15401,0)
 ;;=20600^^59^731^10^^^^1
 ;;^UTILITY(U,$J,358.3,15401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15401,1,2,0)
 ;;=2^20600
 ;;^UTILITY(U,$J,358.3,15401,1,3,0)
 ;;=3^Arthrocentesis,Small Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,15402,0)
 ;;=20605^^59^731^6^^^^1
 ;;^UTILITY(U,$J,358.3,15402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15402,1,2,0)
 ;;=2^20605
 ;;^UTILITY(U,$J,358.3,15402,1,3,0)
 ;;=3^Arthrocentesis,Intermediate Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,15403,0)
 ;;=20610^^59^731^8^^^^1
 ;;^UTILITY(U,$J,358.3,15403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15403,1,2,0)
 ;;=2^20610
