IBDEI1K8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26466,1,3,0)
 ;;=3^Non-phys Team Conf w/o Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,26467,0)
 ;;=99366^^99^1259^1^^^^1
 ;;^UTILITY(U,$J,358.3,26467,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26467,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,26467,1,3,0)
 ;;=3^Non-phys Team Conf w/ Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,26468,0)
 ;;=90785^^99^1260^1^^^^1
 ;;^UTILITY(U,$J,358.3,26468,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26468,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,26468,1,3,0)
 ;;=3^Interactive Complexity
 ;;^UTILITY(U,$J,358.3,26469,0)
 ;;=H0001^^99^1261^1^^^^1
 ;;^UTILITY(U,$J,358.3,26469,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26469,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,26469,1,3,0)
 ;;=3^Addictions Assessment,Alcohol/Drug
 ;;^UTILITY(U,$J,358.3,26470,0)
 ;;=H0002^^99^1261^11^^^^1
 ;;^UTILITY(U,$J,358.3,26470,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26470,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,26470,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,26471,0)
 ;;=H0003^^99^1261^6^^^^1
 ;;^UTILITY(U,$J,358.3,26471,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26471,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,26471,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,26472,0)
 ;;=H0004^^99^1261^9^^^^1
 ;;^UTILITY(U,$J,358.3,26472,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26472,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,26472,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,26473,0)
 ;;=H0005^^99^1261^2^^^^1
 ;;^UTILITY(U,$J,358.3,26473,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26473,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,26473,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,26474,0)
 ;;=H0006^^99^1261^5^^^^1
 ;;^UTILITY(U,$J,358.3,26474,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26474,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,26474,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,26475,0)
 ;;=H0020^^99^1261^10^^^^1
 ;;^UTILITY(U,$J,358.3,26475,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26475,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,26475,1,3,0)
 ;;=3^Methadone Admin &/or Svc by Licensed Program
 ;;^UTILITY(U,$J,358.3,26476,0)
 ;;=H0025^^99^1261^3^^^^1
 ;;^UTILITY(U,$J,358.3,26476,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26476,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,26476,1,3,0)
 ;;=3^Addictions Health Prevention Education Service
 ;;^UTILITY(U,$J,358.3,26477,0)
 ;;=H0030^^99^1261^4^^^^1
 ;;^UTILITY(U,$J,358.3,26477,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26477,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,26477,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,26478,0)
 ;;=H0007^^99^1261^8^^^^1
 ;;^UTILITY(U,$J,358.3,26478,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26478,1,2,0)
 ;;=2^H0007
 ;;^UTILITY(U,$J,358.3,26478,1,3,0)
 ;;=3^Alcohol/Drug Svcs,Crisis Intervention
 ;;^UTILITY(U,$J,358.3,26479,0)
 ;;=H0014^^99^1261^7^^^^1
 ;;^UTILITY(U,$J,358.3,26479,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26479,1,2,0)
 ;;=2^H0014
 ;;^UTILITY(U,$J,358.3,26479,1,3,0)
 ;;=3^Alcohol/Drug Svcs,Ambulatory Detox
 ;;^UTILITY(U,$J,358.3,26480,0)
 ;;=90791^^99^1262^1^^^^1
 ;;^UTILITY(U,$J,358.3,26480,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26480,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,26480,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation
 ;;^UTILITY(U,$J,358.3,26481,0)
 ;;=99354^^99^1263^1^^^^1
 ;;^UTILITY(U,$J,358.3,26481,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26481,1,2,0)
 ;;=2^99354
