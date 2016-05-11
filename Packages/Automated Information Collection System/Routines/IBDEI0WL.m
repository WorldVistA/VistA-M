IBDEI0WL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15295,0)
 ;;=90785^^57^655^1^^^^1
 ;;^UTILITY(U,$J,358.3,15295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15295,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,15295,1,3,0)
 ;;=3^Interactive Complexity
 ;;^UTILITY(U,$J,358.3,15296,0)
 ;;=H0001^^57^656^1^^^^1
 ;;^UTILITY(U,$J,358.3,15296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15296,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,15296,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,15297,0)
 ;;=H0002^^57^656^10^^^^1
 ;;^UTILITY(U,$J,358.3,15297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15297,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,15297,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,15298,0)
 ;;=H0003^^57^656^6^^^^1
 ;;^UTILITY(U,$J,358.3,15298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15298,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,15298,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,15299,0)
 ;;=H0004^^57^656^7^^^^1
 ;;^UTILITY(U,$J,358.3,15299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15299,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,15299,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,15300,0)
 ;;=H0005^^57^656^2^^^^1
 ;;^UTILITY(U,$J,358.3,15300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15300,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,15300,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,15301,0)
 ;;=H0006^^57^656^5^^^^1
 ;;^UTILITY(U,$J,358.3,15301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15301,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,15301,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,15302,0)
 ;;=H0020^^57^656^8^^^^1
 ;;^UTILITY(U,$J,358.3,15302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15302,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,15302,1,3,0)
 ;;=3^Methadone Admin &/or Svc by Licensed Program
 ;;^UTILITY(U,$J,358.3,15303,0)
 ;;=H0025^^57^656^3^^^^1
 ;;^UTILITY(U,$J,358.3,15303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15303,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,15303,1,3,0)
 ;;=3^Addictions Health Prevention Ed Service
 ;;^UTILITY(U,$J,358.3,15304,0)
 ;;=H0030^^57^656^4^^^^1
 ;;^UTILITY(U,$J,358.3,15304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15304,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,15304,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,15305,0)
 ;;=H0046^^57^656^9^^^^1
 ;;^UTILITY(U,$J,358.3,15305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15305,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,15305,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,15306,0)
 ;;=90791^^57^657^1^^^^1
 ;;^UTILITY(U,$J,358.3,15306,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15306,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,15306,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation
 ;;^UTILITY(U,$J,358.3,15307,0)
 ;;=T74.11XA^^58^658^5
 ;;^UTILITY(U,$J,358.3,15307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15307,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,15307,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,15307,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,15308,0)
 ;;=T74.11XD^^58^658^6
 ;;^UTILITY(U,$J,358.3,15308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15308,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,15308,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,15308,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,15309,0)
 ;;=T76.11XA^^58^658^7
 ;;^UTILITY(U,$J,358.3,15309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15309,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
