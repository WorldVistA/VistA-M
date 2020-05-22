IBDEI156 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18358,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18358,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,18358,1,3,0)
 ;;=3^Methadone Admin &/or Svc by Licensed Program
 ;;^UTILITY(U,$J,358.3,18359,0)
 ;;=H0025^^90^932^2^^^^1
 ;;^UTILITY(U,$J,358.3,18359,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18359,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,18359,1,3,0)
 ;;=3^Addictions Health Prevention Ed Service
 ;;^UTILITY(U,$J,358.3,18360,0)
 ;;=H0030^^90^932^3^^^^1
 ;;^UTILITY(U,$J,358.3,18360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18360,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,18360,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,18361,0)
 ;;=90791^^90^933^1^^^^1
 ;;^UTILITY(U,$J,358.3,18361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18361,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,18361,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation
 ;;^UTILITY(U,$J,358.3,18362,0)
 ;;=96116^^90^934^1^^^^1
 ;;^UTILITY(U,$J,358.3,18362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18362,1,2,0)
 ;;=2^96116
 ;;^UTILITY(U,$J,358.3,18362,1,3,0)
 ;;=3^Neurobehav Status Exam,F2F w/ Interp&Prep,1st hr
 ;;^UTILITY(U,$J,358.3,18363,0)
 ;;=96130^^90^934^5^^^^1
 ;;^UTILITY(U,$J,358.3,18363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18363,1,2,0)
 ;;=2^96130
 ;;^UTILITY(U,$J,358.3,18363,1,3,0)
 ;;=3^Psych Test Eval,1st hr
 ;;^UTILITY(U,$J,358.3,18364,0)
 ;;=96131^^90^934^6^^^^1
 ;;^UTILITY(U,$J,358.3,18364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18364,1,2,0)
 ;;=2^96131
 ;;^UTILITY(U,$J,358.3,18364,1,3,0)
 ;;=3^Psych Test Eval,Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,18365,0)
 ;;=96132^^90^934^3^^^^1
 ;;^UTILITY(U,$J,358.3,18365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18365,1,2,0)
 ;;=2^96132
 ;;^UTILITY(U,$J,358.3,18365,1,3,0)
 ;;=3^Neuropsych Test Eval,1st Hr
 ;;^UTILITY(U,$J,358.3,18366,0)
 ;;=96133^^90^934^4^^^^1
 ;;^UTILITY(U,$J,358.3,18366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18366,1,2,0)
 ;;=2^96133
 ;;^UTILITY(U,$J,358.3,18366,1,3,0)
 ;;=3^Neuropsych Test Eval,Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,18367,0)
 ;;=96136^^90^934^7^^^^1
 ;;^UTILITY(U,$J,358.3,18367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18367,1,2,0)
 ;;=2^96136
 ;;^UTILITY(U,$J,358.3,18367,1,3,0)
 ;;=3^Psych/Nrpsych 2+ Tst,Provider,1st 30 min
 ;;^UTILITY(U,$J,358.3,18368,0)
 ;;=96137^^90^934^8^^^^1
 ;;^UTILITY(U,$J,358.3,18368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18368,1,2,0)
 ;;=2^96137
 ;;^UTILITY(U,$J,358.3,18368,1,3,0)
 ;;=3^Psych/Nrpsych 2+ Tst,Provider,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,18369,0)
 ;;=96138^^90^934^9^^^^1
 ;;^UTILITY(U,$J,358.3,18369,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18369,1,2,0)
 ;;=2^96138
 ;;^UTILITY(U,$J,358.3,18369,1,3,0)
 ;;=3^Psych/Nrpsych 2+ Tst,Tech,1st 30 min
 ;;^UTILITY(U,$J,358.3,18370,0)
 ;;=96139^^90^934^10^^^^1
 ;;^UTILITY(U,$J,358.3,18370,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18370,1,2,0)
 ;;=2^96139
 ;;^UTILITY(U,$J,358.3,18370,1,3,0)
 ;;=3^Psych/Nrpsych 2+ Tst,Tech,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,18371,0)
 ;;=96121^^90^934^2^^^^1
 ;;^UTILITY(U,$J,358.3,18371,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18371,1,2,0)
 ;;=2^96121
 ;;^UTILITY(U,$J,358.3,18371,1,3,0)
 ;;=3^Neurobehav Status Exam,F2F w/ Interp&Prep,Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,18372,0)
 ;;=T74.11XA^^91^935^7
 ;;^UTILITY(U,$J,358.3,18372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18372,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Init Enctr
