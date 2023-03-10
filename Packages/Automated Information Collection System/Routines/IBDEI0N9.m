IBDEI0N9 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10475,1,2,0)
 ;;=2^99497
 ;;^UTILITY(U,$J,358.3,10475,1,3,0)
 ;;=3^Advance Care Planning,1st 30 min
 ;;^UTILITY(U,$J,358.3,10476,0)
 ;;=99498^^41^462^2^^^^1
 ;;^UTILITY(U,$J,358.3,10476,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10476,1,2,0)
 ;;=2^99498
 ;;^UTILITY(U,$J,358.3,10476,1,3,0)
 ;;=3^Advance Care Planning,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,10477,0)
 ;;=99366^^41^463^1^^^^1
 ;;^UTILITY(U,$J,358.3,10477,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10477,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,10477,1,3,0)
 ;;=3^Non-Phy Team Conf w/ Pt &/or Fam,30 min+
 ;;^UTILITY(U,$J,358.3,10478,0)
 ;;=90833^^41^464^1^^^^1
 ;;^UTILITY(U,$J,358.3,10478,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10478,1,2,0)
 ;;=2^90833
 ;;^UTILITY(U,$J,358.3,10478,1,3,0)
 ;;=3^Psychotherapy Services,30 min (w/ E&M)
 ;;^UTILITY(U,$J,358.3,10479,0)
 ;;=90836^^41^464^2^^^^1
 ;;^UTILITY(U,$J,358.3,10479,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10479,1,2,0)
 ;;=2^90836
 ;;^UTILITY(U,$J,358.3,10479,1,3,0)
 ;;=3^Psychotherapy Services,45 min (w/ E&M)
 ;;^UTILITY(U,$J,358.3,10480,0)
 ;;=90838^^41^464^3^^^^1
 ;;^UTILITY(U,$J,358.3,10480,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10480,1,2,0)
 ;;=2^90838
 ;;^UTILITY(U,$J,358.3,10480,1,3,0)
 ;;=3^Psychotherapy Services,60 min (w/ E&M)
 ;;^UTILITY(U,$J,358.3,10481,0)
 ;;=99354^^41^465^1^^^^1
 ;;^UTILITY(U,$J,358.3,10481,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10481,1,2,0)
 ;;=2^99354
 ;;^UTILITY(U,$J,358.3,10481,1,3,0)
 ;;=3^Prolonged Svc Office/Outpt;1st hr
 ;;^UTILITY(U,$J,358.3,10482,0)
 ;;=99355^^41^465^2^^^^1
 ;;^UTILITY(U,$J,358.3,10482,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10482,1,2,0)
 ;;=2^99355
 ;;^UTILITY(U,$J,358.3,10482,1,3,0)
 ;;=3^Prolonged Svc Office/Outpt;Ea Addl 30min
 ;;^UTILITY(U,$J,358.3,10483,0)
 ;;=99356^^41^465^3^^^^1
 ;;^UTILITY(U,$J,358.3,10483,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10483,1,2,0)
 ;;=2^99356
 ;;^UTILITY(U,$J,358.3,10483,1,3,0)
 ;;=3^Prolonged Svc,INPT/OBS,1st Hr
 ;;^UTILITY(U,$J,358.3,10484,0)
 ;;=99357^^41^465^4^^^^1
 ;;^UTILITY(U,$J,358.3,10484,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10484,1,2,0)
 ;;=2^99357
 ;;^UTILITY(U,$J,358.3,10484,1,3,0)
 ;;=3^Prolonged Svc,INPT/OBS,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,10485,0)
 ;;=90847^^41^466^1^^^^1
 ;;^UTILITY(U,$J,358.3,10485,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10485,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,10485,1,3,0)
 ;;=3^Family Psychotherapy w/ Patient
 ;;^UTILITY(U,$J,358.3,10486,0)
 ;;=90853^^41^466^3^^^^1
 ;;^UTILITY(U,$J,358.3,10486,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10486,1,2,0)
 ;;=2^90853
 ;;^UTILITY(U,$J,358.3,10486,1,3,0)
 ;;=3^Group Psychotherapy
 ;;^UTILITY(U,$J,358.3,10487,0)
 ;;=S9446^^41^466^4^^^^1
 ;;^UTILITY(U,$J,358.3,10487,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10487,1,2,0)
 ;;=2^S9446
 ;;^UTILITY(U,$J,358.3,10487,1,3,0)
 ;;=3^Patient Educ NOC Non-Phy Grp Session
 ;;^UTILITY(U,$J,358.3,10488,0)
 ;;=H0005^^41^466^2^^^^1
 ;;^UTILITY(U,$J,358.3,10488,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10488,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,10488,1,3,0)
 ;;=3^Group Counseling w/ Alcohol and Drug Tx Focus
 ;;^UTILITY(U,$J,358.3,10489,0)
 ;;=99368^^41^467^1^^^^1
 ;;^UTILITY(U,$J,358.3,10489,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10489,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,10489,1,3,0)
 ;;=3^Non-Phy Team Conf w/o Pt &/or Fam;30 min+
