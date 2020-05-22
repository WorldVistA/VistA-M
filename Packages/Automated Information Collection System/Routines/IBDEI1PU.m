IBDEI1PU ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27415,0)
 ;;=H2026^^112^1328^7^^^^1
 ;;^UTILITY(U,$J,358.3,27415,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27415,1,2,0)
 ;;=2^H2026
 ;;^UTILITY(U,$J,358.3,27415,1,3,0)
 ;;=3^Ongoing Supp to Maint Employ,per diem
 ;;^UTILITY(U,$J,358.3,27416,0)
 ;;=H2017^^112^1328^8^^^^1
 ;;^UTILITY(U,$J,358.3,27416,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27416,1,2,0)
 ;;=2^H2017
 ;;^UTILITY(U,$J,358.3,27416,1,3,0)
 ;;=3^Psychosocial Rehab Svc,per 15 min
 ;;^UTILITY(U,$J,358.3,27417,0)
 ;;=H2018^^112^1328^9^^^^1
 ;;^UTILITY(U,$J,358.3,27417,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27417,1,2,0)
 ;;=2^H2018
 ;;^UTILITY(U,$J,358.3,27417,1,3,0)
 ;;=3^Psychosocial Rehab Svc,per diem
 ;;^UTILITY(U,$J,358.3,27418,0)
 ;;=H2014^^112^1328^10^^^^1
 ;;^UTILITY(U,$J,358.3,27418,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27418,1,2,0)
 ;;=2^H2014
 ;;^UTILITY(U,$J,358.3,27418,1,3,0)
 ;;=3^Skills Training/Development,per 15 min
 ;;^UTILITY(U,$J,358.3,27419,0)
 ;;=H2023^^112^1328^11^^^^1
 ;;^UTILITY(U,$J,358.3,27419,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27419,1,2,0)
 ;;=2^H2023
 ;;^UTILITY(U,$J,358.3,27419,1,3,0)
 ;;=3^Supported Employment,per 15 min
 ;;^UTILITY(U,$J,358.3,27420,0)
 ;;=H2024^^112^1328^12^^^^1
 ;;^UTILITY(U,$J,358.3,27420,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27420,1,2,0)
 ;;=2^H2024
 ;;^UTILITY(U,$J,358.3,27420,1,3,0)
 ;;=3^Supported Employment,per diem
 ;;^UTILITY(U,$J,358.3,27421,0)
 ;;=99368^^112^1329^3^^^^1
 ;;^UTILITY(U,$J,358.3,27421,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27421,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,27421,1,3,0)
 ;;=3^Non-Phys Team Conf w/o Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,27422,0)
 ;;=99366^^112^1329^1^^^^1
 ;;^UTILITY(U,$J,358.3,27422,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27422,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,27422,1,3,0)
 ;;=3^Non-Phys Team Conf w/ Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,27423,0)
 ;;=H0001^^112^1330^1^^^^1
 ;;^UTILITY(U,$J,358.3,27423,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27423,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,27423,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,27424,0)
 ;;=H0002^^112^1330^9^^^^1
 ;;^UTILITY(U,$J,358.3,27424,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27424,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,27424,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,27425,0)
 ;;=H0003^^112^1330^6^^^^1
 ;;^UTILITY(U,$J,358.3,27425,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27425,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,27425,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,27426,0)
 ;;=H0004^^112^1330^7^^^^1
 ;;^UTILITY(U,$J,358.3,27426,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27426,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,27426,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,27427,0)
 ;;=H0005^^112^1330^3^^^^1
 ;;^UTILITY(U,$J,358.3,27427,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27427,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,27427,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,27428,0)
 ;;=H0006^^112^1330^5^^^^1
 ;;^UTILITY(U,$J,358.3,27428,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27428,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,27428,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,27429,0)
 ;;=H0020^^112^1330^8^^^^1
