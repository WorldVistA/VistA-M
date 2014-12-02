IBDEI0RF ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13539,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13539,1,2,0)
 ;;=2^96366
 ;;^UTILITY(U,$J,358.3,13539,1,3,0)
 ;;=3^Infusion,IV e addl hour
 ;;^UTILITY(U,$J,358.3,13540,0)
 ;;=17000^^89^842^1^^^^1
 ;;^UTILITY(U,$J,358.3,13540,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13540,1,2,0)
 ;;=2^17000
 ;;^UTILITY(U,$J,358.3,13540,1,3,0)
 ;;=3^Destr ben les, any method, 1st les
 ;;^UTILITY(U,$J,358.3,13541,0)
 ;;=17003^^89^842^2^^^^1
 ;;^UTILITY(U,$J,358.3,13541,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13541,1,2,0)
 ;;=2^17003
 ;;^UTILITY(U,$J,358.3,13541,1,3,0)
 ;;=3^Destr ben les, any method, addt'l les, ea (use with 17000)
 ;;^UTILITY(U,$J,358.3,13542,0)
 ;;=17004^^89^842^3^^^^1
 ;;^UTILITY(U,$J,358.3,13542,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13542,1,2,0)
 ;;=2^17004
 ;;^UTILITY(U,$J,358.3,13542,1,3,0)
 ;;=3^Destr ben les, over 15
 ;;^UTILITY(U,$J,358.3,13543,0)
 ;;=10060^^89^842^13^^^^1
 ;;^UTILITY(U,$J,358.3,13543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13543,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,13543,1,3,0)
 ;;=3^I&D abscess
 ;;^UTILITY(U,$J,358.3,13544,0)
 ;;=10061^^89^842^12^^^^1
 ;;^UTILITY(U,$J,358.3,13544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13544,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,13544,1,3,0)
 ;;=3^I&D Complicated Abscess
 ;;^UTILITY(U,$J,358.3,13545,0)
 ;;=11042^^89^842^10^^^^1
 ;;^UTILITY(U,$J,358.3,13545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13545,1,2,0)
 ;;=2^11042
 ;;^UTILITY(U,$J,358.3,13545,1,3,0)
 ;;=3^Debridement, Skin & Subcu. Tissue
 ;;^UTILITY(U,$J,358.3,13546,0)
 ;;=20550^^89^842^15^^^^1
 ;;^UTILITY(U,$J,358.3,13546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13546,1,2,0)
 ;;=2^20550
 ;;^UTILITY(U,$J,358.3,13546,1,3,0)
 ;;=3^Injection, Tendon Sheath, Ligament, Ganglion Cyst
 ;;^UTILITY(U,$J,358.3,13547,0)
 ;;=20551^^89^842^14^^^^1
 ;;^UTILITY(U,$J,358.3,13547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13547,1,2,0)
 ;;=2^20551
 ;;^UTILITY(U,$J,358.3,13547,1,3,0)
 ;;=3^Injection, Tendon Origin/Insertion
 ;;^UTILITY(U,$J,358.3,13548,0)
 ;;=20552^^89^842^16^^^^1
 ;;^UTILITY(U,$J,358.3,13548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13548,1,2,0)
 ;;=2^20552
 ;;^UTILITY(U,$J,358.3,13548,1,3,0)
 ;;=3^Injection, Trigger Point, 1 or 2 Muscle groups
 ;;^UTILITY(U,$J,358.3,13549,0)
 ;;=20600^^89^842^4^^^^1
 ;;^UTILITY(U,$J,358.3,13549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13549,1,2,0)
 ;;=2^20600
 ;;^UTILITY(U,$J,358.3,13549,1,3,0)
 ;;=3^Arthrocentesis, Fingers/Toes
 ;;^UTILITY(U,$J,358.3,13550,0)
 ;;=20605^^89^842^6^^^^1
 ;;^UTILITY(U,$J,358.3,13550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13550,1,2,0)
 ;;=2^20605
 ;;^UTILITY(U,$J,358.3,13550,1,3,0)
 ;;=3^Arthrocentesis, Wrist/Elbow/Ankle/AC Joint
 ;;^UTILITY(U,$J,358.3,13551,0)
 ;;=20610^^89^842^5^^^^1
 ;;^UTILITY(U,$J,358.3,13551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13551,1,2,0)
 ;;=2^20610
 ;;^UTILITY(U,$J,358.3,13551,1,3,0)
 ;;=3^Arthrocentesis, Knee/Shoulder/Hip
 ;;^UTILITY(U,$J,358.3,13552,0)
 ;;=30901^^89^842^18^^^^1
 ;;^UTILITY(U,$J,358.3,13552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13552,1,2,0)
 ;;=2^30901
 ;;^UTILITY(U,$J,358.3,13552,1,3,0)
 ;;=3^Nasal Packing
 ;;^UTILITY(U,$J,358.3,13553,0)
 ;;=31500^^89^842^11^^^^1
 ;;^UTILITY(U,$J,358.3,13553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13553,1,2,0)
 ;;=2^31500
 ;;^UTILITY(U,$J,358.3,13553,1,3,0)
 ;;=3^Endotrach Intubation
 ;;^UTILITY(U,$J,358.3,13554,0)
 ;;=92950^^89^842^7^^^^1
 ;;^UTILITY(U,$J,358.3,13554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13554,1,2,0)
 ;;=2^92950
