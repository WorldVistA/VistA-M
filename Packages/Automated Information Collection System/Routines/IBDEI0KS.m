IBDEI0KS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9181,1,2,0)
 ;;=2^29705
 ;;^UTILITY(U,$J,358.3,9181,1,3,0)
 ;;=3^Cast Removal,Long
 ;;^UTILITY(U,$J,358.3,9182,0)
 ;;=29540^^70^625^12^^^^1
 ;;^UTILITY(U,$J,358.3,9182,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9182,1,2,0)
 ;;=2^29540
 ;;^UTILITY(U,$J,358.3,9182,1,3,0)
 ;;=3^Strapping;Ankle/Foot
 ;;^UTILITY(U,$J,358.3,9183,0)
 ;;=29260^^70^625^15^^^^1
 ;;^UTILITY(U,$J,358.3,9183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9183,1,2,0)
 ;;=2^29260
 ;;^UTILITY(U,$J,358.3,9183,1,3,0)
 ;;=3^Strapping;Elbow/Wrist
 ;;^UTILITY(U,$J,358.3,9184,0)
 ;;=29280^^70^625^14^^^^1
 ;;^UTILITY(U,$J,358.3,9184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9184,1,2,0)
 ;;=2^29280
 ;;^UTILITY(U,$J,358.3,9184,1,3,0)
 ;;=3^Strapping;Finger/Hand
 ;;^UTILITY(U,$J,358.3,9185,0)
 ;;=29530^^70^625^13^^^^1
 ;;^UTILITY(U,$J,358.3,9185,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9185,1,2,0)
 ;;=2^29530
 ;;^UTILITY(U,$J,358.3,9185,1,3,0)
 ;;=3^Strapping;Knee
 ;;^UTILITY(U,$J,358.3,9186,0)
 ;;=29550^^70^625^11^^^^1
 ;;^UTILITY(U,$J,358.3,9186,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9186,1,2,0)
 ;;=2^29550
 ;;^UTILITY(U,$J,358.3,9186,1,3,0)
 ;;=3^Strapping;Toes
 ;;^UTILITY(U,$J,358.3,9187,0)
 ;;=20610^^70^625^1^^^^1
 ;;^UTILITY(U,$J,358.3,9187,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9187,1,2,0)
 ;;=2^20610
 ;;^UTILITY(U,$J,358.3,9187,1,3,0)
 ;;=3^Arthocentesis,Knee/Shldr/Hip w/o US Guidance
 ;;^UTILITY(U,$J,358.3,9188,0)
 ;;=20611^^70^625^2^^^^1
 ;;^UTILITY(U,$J,358.3,9188,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9188,1,2,0)
 ;;=2^20611
 ;;^UTILITY(U,$J,358.3,9188,1,3,0)
 ;;=3^Arthocentesis,Knee/Shldr/Hip w/ US Guidance
 ;;^UTILITY(U,$J,358.3,9189,0)
 ;;=20605^^70^625^3^^^^1
 ;;^UTILITY(U,$J,358.3,9189,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9189,1,2,0)
 ;;=2^20605
 ;;^UTILITY(U,$J,358.3,9189,1,3,0)
 ;;=3^Arthrocentesis,Wrst/Elb/Ank/Ac Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,9190,0)
 ;;=20606^^70^625^4^^^^1
 ;;^UTILITY(U,$J,358.3,9190,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9190,1,2,0)
 ;;=2^20606
 ;;^UTILITY(U,$J,358.3,9190,1,3,0)
 ;;=3^Arthrocentesis,Wrst/Elb/Ank/Ac Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,9191,0)
 ;;=23650^^70^625^5^^^^1
 ;;^UTILITY(U,$J,358.3,9191,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9191,1,2,0)
 ;;=2^23650
 ;;^UTILITY(U,$J,358.3,9191,1,3,0)
 ;;=3^Shld Disloc;Closed Txmt w/ Manip w/o Anesth
 ;;^UTILITY(U,$J,358.3,9192,0)
 ;;=29130^^70^625^6^^^^1
 ;;^UTILITY(U,$J,358.3,9192,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9192,1,2,0)
 ;;=2^29130
 ;;^UTILITY(U,$J,358.3,9192,1,3,0)
 ;;=3^Apply Finger Splint;Static
 ;;^UTILITY(U,$J,358.3,9193,0)
 ;;=29105^^70^625^8^^^^1
 ;;^UTILITY(U,$J,358.3,9193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9193,1,2,0)
 ;;=2^29105
 ;;^UTILITY(U,$J,358.3,9193,1,3,0)
 ;;=3^Apply Long Arm Splint
 ;;^UTILITY(U,$J,358.3,9194,0)
 ;;=29125^^70^625^7^^^^1
 ;;^UTILITY(U,$J,358.3,9194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9194,1,2,0)
 ;;=2^29125
 ;;^UTILITY(U,$J,358.3,9194,1,3,0)
 ;;=3^Apply Forearm Splint;Static
 ;;^UTILITY(U,$J,358.3,9195,0)
 ;;=29515^^70^625^9^^^^1
 ;;^UTILITY(U,$J,358.3,9195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9195,1,2,0)
 ;;=2^29515
 ;;^UTILITY(U,$J,358.3,9195,1,3,0)
 ;;=3^Apply Lower Leg Splint
 ;;^UTILITY(U,$J,358.3,9196,0)
 ;;=29505^^70^625^10^^^^1
