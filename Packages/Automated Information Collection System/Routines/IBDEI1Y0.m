IBDEI1Y0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32966,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,32966,1,3,0)
 ;;=3^Suture Simple Wound,Trunk/Ext 2.6-7.5 cm
 ;;^UTILITY(U,$J,358.3,32967,0)
 ;;=11042^^130^1650^12^^^^1
 ;;^UTILITY(U,$J,358.3,32967,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32967,1,2,0)
 ;;=2^11042
 ;;^UTILITY(U,$J,358.3,32967,1,3,0)
 ;;=3^Debridement, Skin & Subcu. Tissue,1st 20sq cm
 ;;^UTILITY(U,$J,358.3,32968,0)
 ;;=20550^^130^1650^21^^^^1
 ;;^UTILITY(U,$J,358.3,32968,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32968,1,2,0)
 ;;=2^20550
 ;;^UTILITY(U,$J,358.3,32968,1,3,0)
 ;;=3^Injection, Tendon Sheath, Ligament, Ganglion Cyst
 ;;^UTILITY(U,$J,358.3,32969,0)
 ;;=20551^^130^1650^20^^^^1
 ;;^UTILITY(U,$J,358.3,32969,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32969,1,2,0)
 ;;=2^20551
 ;;^UTILITY(U,$J,358.3,32969,1,3,0)
 ;;=3^Injection, Tendon Origin/Insertion
 ;;^UTILITY(U,$J,358.3,32970,0)
 ;;=20552^^130^1650^22^^^^1
 ;;^UTILITY(U,$J,358.3,32970,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32970,1,2,0)
 ;;=2^20552
 ;;^UTILITY(U,$J,358.3,32970,1,3,0)
 ;;=3^Injection, Trigger Point, 1 or 2 Muscle groups
 ;;^UTILITY(U,$J,358.3,32971,0)
 ;;=20600^^130^1650^6^^^^1
 ;;^UTILITY(U,$J,358.3,32971,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32971,1,2,0)
 ;;=2^20600
 ;;^UTILITY(U,$J,358.3,32971,1,3,0)
 ;;=3^Arthrocentesis,Small Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,32972,0)
 ;;=20605^^130^1650^2^^^^1
 ;;^UTILITY(U,$J,358.3,32972,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32972,1,2,0)
 ;;=2^20605
 ;;^UTILITY(U,$J,358.3,32972,1,3,0)
 ;;=3^Arthrocentesis,Intermediate Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,32973,0)
 ;;=20610^^130^1650^4^^^^1
 ;;^UTILITY(U,$J,358.3,32973,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32973,1,2,0)
 ;;=2^20610
 ;;^UTILITY(U,$J,358.3,32973,1,3,0)
 ;;=3^Arthrocentesis,Major Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,32974,0)
 ;;=92950^^130^1650^9^^^^1
 ;;^UTILITY(U,$J,358.3,32974,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32974,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,32974,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,32975,0)
 ;;=11055^^130^1650^35^^^^1
 ;;^UTILITY(U,$J,358.3,32975,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32975,1,2,0)
 ;;=2^11055
 ;;^UTILITY(U,$J,358.3,32975,1,3,0)
 ;;=3^Trim Corn/Callous, One
 ;;^UTILITY(U,$J,358.3,32976,0)
 ;;=11056^^130^1650^33^^^^1
 ;;^UTILITY(U,$J,358.3,32976,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32976,1,2,0)
 ;;=2^11056
 ;;^UTILITY(U,$J,358.3,32976,1,3,0)
 ;;=3^Trim Corn/Callous, 2 to 4
 ;;^UTILITY(U,$J,358.3,32977,0)
 ;;=11057^^130^1650^34^^^^1
 ;;^UTILITY(U,$J,358.3,32977,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32977,1,2,0)
 ;;=2^11057
 ;;^UTILITY(U,$J,358.3,32977,1,3,0)
 ;;=3^Trim Corn/Callous, 5 or more
 ;;^UTILITY(U,$J,358.3,32978,0)
 ;;=12011^^130^1650^29^^^^1
 ;;^UTILITY(U,$J,358.3,32978,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32978,1,2,0)
 ;;=2^12011
 ;;^UTILITY(U,$J,358.3,32978,1,3,0)
 ;;=3^Suture Simple Wound,Face,2.5 cm or <
 ;;^UTILITY(U,$J,358.3,32979,0)
 ;;=97597^^130^1650^10^^^^1
 ;;^UTILITY(U,$J,358.3,32979,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32979,1,2,0)
 ;;=2^97597
 ;;^UTILITY(U,$J,358.3,32979,1,3,0)
 ;;=3^Debridement open wnd 1st 20sq cm
 ;;^UTILITY(U,$J,358.3,32980,0)
 ;;=97598^^130^1650^11^^^^1
 ;;^UTILITY(U,$J,358.3,32980,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32980,1,2,0)
 ;;=2^97598
 ;;^UTILITY(U,$J,358.3,32980,1,3,0)
 ;;=3^Debridement open wnd ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,32981,0)
 ;;=11200^^130^1650^26^^^^1
 ;;^UTILITY(U,$J,358.3,32981,1,0)
 ;;=^358.31IA^3^2
