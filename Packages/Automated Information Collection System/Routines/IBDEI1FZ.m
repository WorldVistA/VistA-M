IBDEI1FZ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24499,0)
 ;;=Q3014^^91^1082^7^^^^1
 ;;^UTILITY(U,$J,358.3,24499,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24499,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,24499,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,24500,0)
 ;;=90889^^91^1082^4^^^^1
 ;;^UTILITY(U,$J,358.3,24500,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24500,1,2,0)
 ;;=2^90889
 ;;^UTILITY(U,$J,358.3,24500,1,3,0)
 ;;=3^Preparation of Report
 ;;^UTILITY(U,$J,358.3,24501,0)
 ;;=G0177^^91^1082^8^^^^1
 ;;^UTILITY(U,$J,358.3,24501,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24501,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,24501,1,3,0)
 ;;=3^Train/Ed Svcs for Care/Tx of Disabiling MH Problem,45+ min
 ;;^UTILITY(U,$J,358.3,24502,0)
 ;;=99368^^91^1083^3^^^^1
 ;;^UTILITY(U,$J,358.3,24502,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24502,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,24502,1,3,0)
 ;;=3^Non-Phys Team Conf w/o Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,24503,0)
 ;;=99366^^91^1083^1^^^^1
 ;;^UTILITY(U,$J,358.3,24503,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24503,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,24503,1,3,0)
 ;;=3^Non-Phys Team Conf w/ Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,24504,0)
 ;;=H0001^^91^1084^1^^^^1
 ;;^UTILITY(U,$J,358.3,24504,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24504,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,24504,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,24505,0)
 ;;=H0002^^91^1084^9^^^^1
 ;;^UTILITY(U,$J,358.3,24505,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24505,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,24505,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,24506,0)
 ;;=H0003^^91^1084^6^^^^1
 ;;^UTILITY(U,$J,358.3,24506,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24506,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,24506,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,24507,0)
 ;;=H0004^^91^1084^7^^^^1
 ;;^UTILITY(U,$J,358.3,24507,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24507,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,24507,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,24508,0)
 ;;=H0005^^91^1084^3^^^^1
 ;;^UTILITY(U,$J,358.3,24508,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24508,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,24508,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,24509,0)
 ;;=H0006^^91^1084^5^^^^1
 ;;^UTILITY(U,$J,358.3,24509,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24509,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,24509,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,24510,0)
 ;;=H0020^^91^1084^8^^^^1
 ;;^UTILITY(U,$J,358.3,24510,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24510,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,24510,1,3,0)
 ;;=3^Methadone Administration &/or Svc by Lincensed Program
 ;;^UTILITY(U,$J,358.3,24511,0)
 ;;=H0025^^91^1084^2^^^^1
 ;;^UTILITY(U,$J,358.3,24511,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24511,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,24511,1,3,0)
 ;;=3^Addictions Health Prevention/Education
 ;;^UTILITY(U,$J,358.3,24512,0)
 ;;=H0030^^91^1084^4^^^^1
 ;;^UTILITY(U,$J,358.3,24512,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24512,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,24512,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,24513,0)
 ;;=99600^^91^1085^1^^^^1
 ;;^UTILITY(U,$J,358.3,24513,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24513,1,2,0)
 ;;=2^99600
 ;;^UTILITY(U,$J,358.3,24513,1,3,0)
 ;;=3^Case Management in Pts Home
