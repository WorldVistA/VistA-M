IBDEI1ZF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33192,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,33192,1,3,0)
 ;;=3^Behavior Intervent,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,33193,0)
 ;;=96153^^147^1624^4^^^^1
 ;;^UTILITY(U,$J,358.3,33193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33193,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,33193,1,3,0)
 ;;=3^Behavior Intervent,Grp,ea 15min
 ;;^UTILITY(U,$J,358.3,33194,0)
 ;;=96154^^147^1624^5^^^^1
 ;;^UTILITY(U,$J,358.3,33194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33194,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,33194,1,3,0)
 ;;=3^Behavior Intervent,Fam w/Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,33195,0)
 ;;=96155^^147^1624^6^^^^1
 ;;^UTILITY(U,$J,358.3,33195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33195,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,33195,1,3,0)
 ;;=3^Behavior Intervent,Fam w/o Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,33196,0)
 ;;=99368^^147^1625^2^^^^1
 ;;^UTILITY(U,$J,358.3,33196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33196,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,33196,1,3,0)
 ;;=3^Non-phys Team Conf w/o Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,33197,0)
 ;;=99366^^147^1625^1^^^^1
 ;;^UTILITY(U,$J,358.3,33197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33197,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,33197,1,3,0)
 ;;=3^Non-phys Team Conf w/ Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,33198,0)
 ;;=90785^^147^1626^1^^^^1
 ;;^UTILITY(U,$J,358.3,33198,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33198,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,33198,1,3,0)
 ;;=3^Interactive Complexity
 ;;^UTILITY(U,$J,358.3,33199,0)
 ;;=H0001^^147^1627^1^^^^1
 ;;^UTILITY(U,$J,358.3,33199,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33199,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,33199,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,33200,0)
 ;;=H0002^^147^1627^9^^^^1
 ;;^UTILITY(U,$J,358.3,33200,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33200,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,33200,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,33201,0)
 ;;=H0003^^147^1627^6^^^^1
 ;;^UTILITY(U,$J,358.3,33201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33201,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,33201,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,33202,0)
 ;;=H0004^^147^1627^7^^^^1
 ;;^UTILITY(U,$J,358.3,33202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33202,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,33202,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,33203,0)
 ;;=H0005^^147^1627^2^^^^1
 ;;^UTILITY(U,$J,358.3,33203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33203,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,33203,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,33204,0)
 ;;=H0006^^147^1627^5^^^^1
 ;;^UTILITY(U,$J,358.3,33204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33204,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,33204,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,33205,0)
 ;;=H0020^^147^1627^8^^^^1
 ;;^UTILITY(U,$J,358.3,33205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33205,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,33205,1,3,0)
 ;;=3^Methadone Admin &/or Svc by Licensed Program
 ;;^UTILITY(U,$J,358.3,33206,0)
 ;;=H0025^^147^1627^3^^^^1
 ;;^UTILITY(U,$J,358.3,33206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33206,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,33206,1,3,0)
 ;;=3^Addictions Health Prevention Education Service
 ;;^UTILITY(U,$J,358.3,33207,0)
 ;;=H0030^^147^1627^4^^^^1
 ;;^UTILITY(U,$J,358.3,33207,1,0)
 ;;=^358.31IA^3^2
