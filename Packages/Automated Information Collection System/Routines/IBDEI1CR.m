IBDEI1CR ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24265,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24265,1,2,0)
 ;;=2^17004
 ;;^UTILITY(U,$J,358.3,24265,1,3,0)
 ;;=3^Destr ben les,ea addl les 15 or more
 ;;^UTILITY(U,$J,358.3,24266,0)
 ;;=10060^^144^1513^16^^^^1
 ;;^UTILITY(U,$J,358.3,24266,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24266,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,24266,1,3,0)
 ;;=3^I&D Abscess
 ;;^UTILITY(U,$J,358.3,24267,0)
 ;;=10061^^144^1513^17^^^^1
 ;;^UTILITY(U,$J,358.3,24267,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24267,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,24267,1,3,0)
 ;;=3^I&D Complicated Abscess
 ;;^UTILITY(U,$J,358.3,24268,0)
 ;;=12001^^144^1513^25^^^^1
 ;;^UTILITY(U,$J,358.3,24268,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24268,1,2,0)
 ;;=2^12001
 ;;^UTILITY(U,$J,358.3,24268,1,3,0)
 ;;=3^Suture Simple wounds 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,24269,0)
 ;;=12002^^144^1513^24^^^^1
 ;;^UTILITY(U,$J,358.3,24269,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24269,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,24269,1,3,0)
 ;;=3^Suture Simple Wounds 2.6-7.5 cm
 ;;^UTILITY(U,$J,358.3,24270,0)
 ;;=11042^^144^1513^12^^^^1
 ;;^UTILITY(U,$J,358.3,24270,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24270,1,2,0)
 ;;=2^11042
 ;;^UTILITY(U,$J,358.3,24270,1,3,0)
 ;;=3^Debridement, Skin & Subcu. Tissue,1st 20sq cm
 ;;^UTILITY(U,$J,358.3,24271,0)
 ;;=20550^^144^1513^20^^^^1
 ;;^UTILITY(U,$J,358.3,24271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24271,1,2,0)
 ;;=2^20550
 ;;^UTILITY(U,$J,358.3,24271,1,3,0)
 ;;=3^Injection, Tendon Sheath, Ligament, Ganglion Cyst
 ;;^UTILITY(U,$J,358.3,24272,0)
 ;;=20551^^144^1513^19^^^^1
 ;;^UTILITY(U,$J,358.3,24272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24272,1,2,0)
 ;;=2^20551
 ;;^UTILITY(U,$J,358.3,24272,1,3,0)
 ;;=3^Injection, Tendon Origin/Insertion
 ;;^UTILITY(U,$J,358.3,24273,0)
 ;;=20552^^144^1513^21^^^^1
 ;;^UTILITY(U,$J,358.3,24273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24273,1,2,0)
 ;;=2^20552
 ;;^UTILITY(U,$J,358.3,24273,1,3,0)
 ;;=3^Injection, Trigger Point, 1 or 2 Muscle groups
 ;;^UTILITY(U,$J,358.3,24274,0)
 ;;=20600^^144^1513^2^^^^1
 ;;^UTILITY(U,$J,358.3,24274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24274,1,2,0)
 ;;=2^20600
 ;;^UTILITY(U,$J,358.3,24274,1,3,0)
 ;;=3^Arthrocentesis,Small Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,24275,0)
 ;;=20605^^144^1513^4^^^^1
 ;;^UTILITY(U,$J,358.3,24275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24275,1,2,0)
 ;;=2^20605
 ;;^UTILITY(U,$J,358.3,24275,1,3,0)
 ;;=3^Arthrocentesis,Intermediate Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,24276,0)
 ;;=20610^^144^1513^6^^^^1
 ;;^UTILITY(U,$J,358.3,24276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24276,1,2,0)
 ;;=2^20610
 ;;^UTILITY(U,$J,358.3,24276,1,3,0)
 ;;=3^Arthrocentesis,Major Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,24277,0)
 ;;=92950^^144^1513^9^^^^1
 ;;^UTILITY(U,$J,358.3,24277,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24277,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,24277,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,24278,0)
 ;;=11055^^144^1513^29^^^^1
 ;;^UTILITY(U,$J,358.3,24278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24278,1,2,0)
 ;;=2^11055
 ;;^UTILITY(U,$J,358.3,24278,1,3,0)
 ;;=3^Trim Corn/Callous, One
 ;;^UTILITY(U,$J,358.3,24279,0)
 ;;=11056^^144^1513^27^^^^1
 ;;^UTILITY(U,$J,358.3,24279,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24279,1,2,0)
 ;;=2^11056
 ;;^UTILITY(U,$J,358.3,24279,1,3,0)
 ;;=3^Trim Corn/Callous, 2 to 4
 ;;^UTILITY(U,$J,358.3,24280,0)
 ;;=11057^^144^1513^28^^^^1
 ;;^UTILITY(U,$J,358.3,24280,1,0)
 ;;=^358.31IA^3^2
