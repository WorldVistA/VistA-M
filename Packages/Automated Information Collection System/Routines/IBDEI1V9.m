IBDEI1V9 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29811,0)
 ;;=99366^^119^1508^1^^^^1
 ;;^UTILITY(U,$J,358.3,29811,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29811,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,29811,1,3,0)
 ;;=3^Non-Rx Prov Team Conf w/ Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,29812,0)
 ;;=90785^^119^1509^1^^^^1
 ;;^UTILITY(U,$J,358.3,29812,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29812,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,29812,1,3,0)
 ;;=3^Interactive Complexity
 ;;^UTILITY(U,$J,358.3,29813,0)
 ;;=H0001^^119^1510^1^^^^1
 ;;^UTILITY(U,$J,358.3,29813,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29813,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,29813,1,3,0)
 ;;=3^Addictions Assessment,Alcohol and/or Drug
 ;;^UTILITY(U,$J,358.3,29814,0)
 ;;=H0002^^119^1510^11^^^^1
 ;;^UTILITY(U,$J,358.3,29814,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29814,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,29814,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,29815,0)
 ;;=H0003^^119^1510^6^^^^1
 ;;^UTILITY(U,$J,358.3,29815,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29815,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,29815,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,29816,0)
 ;;=H0004^^119^1510^9^^^^1
 ;;^UTILITY(U,$J,358.3,29816,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29816,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,29816,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,29817,0)
 ;;=H0005^^119^1510^2^^^^1
 ;;^UTILITY(U,$J,358.3,29817,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29817,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,29817,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,29818,0)
 ;;=H0006^^119^1510^5^^^^1
 ;;^UTILITY(U,$J,358.3,29818,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29818,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,29818,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,29819,0)
 ;;=H0020^^119^1510^10^^^^1
 ;;^UTILITY(U,$J,358.3,29819,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29819,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,29819,1,3,0)
 ;;=3^Methadone Admin &/or Svc by Licensed Program
 ;;^UTILITY(U,$J,358.3,29820,0)
 ;;=H0025^^119^1510^3^^^^1
 ;;^UTILITY(U,$J,358.3,29820,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29820,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,29820,1,3,0)
 ;;=3^Addictions Health Prevention Education Service
 ;;^UTILITY(U,$J,358.3,29821,0)
 ;;=H0030^^119^1510^4^^^^1
 ;;^UTILITY(U,$J,358.3,29821,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29821,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,29821,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,29822,0)
 ;;=H0007^^119^1510^8^^^^1
 ;;^UTILITY(U,$J,358.3,29822,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29822,1,2,0)
 ;;=2^H0007
 ;;^UTILITY(U,$J,358.3,29822,1,3,0)
 ;;=3^Alcohol/Drug Svcs,Crisis Intervention
 ;;^UTILITY(U,$J,358.3,29823,0)
 ;;=H0014^^119^1510^7^^^^1
 ;;^UTILITY(U,$J,358.3,29823,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29823,1,2,0)
 ;;=2^H0014
 ;;^UTILITY(U,$J,358.3,29823,1,3,0)
 ;;=3^Alcohol/Drug Svcs,Ambulatory Detox
 ;;^UTILITY(U,$J,358.3,29824,0)
 ;;=90791^^119^1511^1^^^^1
 ;;^UTILITY(U,$J,358.3,29824,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29824,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,29824,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation
 ;;^UTILITY(U,$J,358.3,29825,0)
 ;;=99354^^119^1512^1^^^^1
