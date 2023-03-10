IBDEI1K1 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25200,0)
 ;;=99368^^91^1139^3^^^^1
 ;;^UTILITY(U,$J,358.3,25200,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25200,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,25200,1,3,0)
 ;;=3^Non-Phys Team Conf w/o Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,25201,0)
 ;;=99366^^91^1139^1^^^^1
 ;;^UTILITY(U,$J,358.3,25201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25201,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,25201,1,3,0)
 ;;=3^Non-Phys Team Conf w/ Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,25202,0)
 ;;=H0001^^91^1140^1^^^^1
 ;;^UTILITY(U,$J,358.3,25202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25202,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,25202,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,25203,0)
 ;;=H0002^^91^1140^9^^^^1
 ;;^UTILITY(U,$J,358.3,25203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25203,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,25203,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,25204,0)
 ;;=H0003^^91^1140^6^^^^1
 ;;^UTILITY(U,$J,358.3,25204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25204,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,25204,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,25205,0)
 ;;=H0004^^91^1140^7^^^^1
 ;;^UTILITY(U,$J,358.3,25205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25205,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,25205,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,25206,0)
 ;;=H0005^^91^1140^3^^^^1
 ;;^UTILITY(U,$J,358.3,25206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25206,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,25206,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,25207,0)
 ;;=H0006^^91^1140^5^^^^1
 ;;^UTILITY(U,$J,358.3,25207,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25207,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,25207,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,25208,0)
 ;;=H0020^^91^1140^8^^^^1
 ;;^UTILITY(U,$J,358.3,25208,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25208,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,25208,1,3,0)
 ;;=3^Methadone Administration &/or Svc by Lincensed Program
 ;;^UTILITY(U,$J,358.3,25209,0)
 ;;=H0025^^91^1140^2^^^^1
 ;;^UTILITY(U,$J,358.3,25209,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25209,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,25209,1,3,0)
 ;;=3^Addictions Health Prevention/Education
 ;;^UTILITY(U,$J,358.3,25210,0)
 ;;=H0030^^91^1140^4^^^^1
 ;;^UTILITY(U,$J,358.3,25210,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25210,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,25210,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,25211,0)
 ;;=T1016^^91^1141^1^^^^1
 ;;^UTILITY(U,$J,358.3,25211,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25211,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,25211,1,3,0)
 ;;=3^Case Management per 15min
 ;;^UTILITY(U,$J,358.3,25212,0)
 ;;=96372^^91^1142^1^^^^1
 ;;^UTILITY(U,$J,358.3,25212,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25212,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,25212,1,3,0)
 ;;=3^Ther/Proph/Diag Inj SC/IM
 ;;^UTILITY(U,$J,358.3,25213,0)
 ;;=96374^^91^1142^2^^^^1
 ;;^UTILITY(U,$J,358.3,25213,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25213,1,2,0)
 ;;=2^96374
 ;;^UTILITY(U,$J,358.3,25213,1,3,0)
 ;;=3^Ther/Proph/Diag Inj IV Push
 ;;^UTILITY(U,$J,358.3,25214,0)
 ;;=96376^^91^1142^3^^^^1
 ;;^UTILITY(U,$J,358.3,25214,1,0)
 ;;=^358.31IA^3^2
