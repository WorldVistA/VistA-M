IBDEI017 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3)
 ;;=^IBE(358.3,
 ;;^UTILITY(U,$J,358.3,0)
 ;;=IMP/EXP SELECTION^358.3I^34806^34806
 ;;^UTILITY(U,$J,358.3,1,0)
 ;;=H0001^^1^1^1^^^^1
 ;;^UTILITY(U,$J,358.3,1,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,1,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,2,0)
 ;;=H0002^^1^1^11^^^^1
 ;;^UTILITY(U,$J,358.3,2,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,2,1,3,0)
 ;;=3^Screen for Addictions Admit
 ;;^UTILITY(U,$J,358.3,3,0)
 ;;=H0004^^1^1^7
 ;;^UTILITY(U,$J,358.3,3,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,3,1,3,0)
 ;;=3^Individual Counseling per 15 min
 ;;^UTILITY(U,$J,358.3,4,0)
 ;;=H0005^^1^1^3^^^^1
 ;;^UTILITY(U,$J,358.3,4,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,4,1,3,0)
 ;;=3^Addictions Group
 ;;^UTILITY(U,$J,358.3,5,0)
 ;;=H0020^^1^1^8^^^^1
 ;;^UTILITY(U,$J,358.3,5,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,5,1,3,0)
 ;;=3^Methadone Administration
 ;;^UTILITY(U,$J,358.3,6,0)
 ;;=H0030^^1^1^4^^^^1
 ;;^UTILITY(U,$J,358.3,6,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,6,1,3,0)
 ;;=3^Addictions Phone Services
 ;;^UTILITY(U,$J,358.3,7,0)
 ;;=H0025^^1^1^2^^^^1
 ;;^UTILITY(U,$J,358.3,7,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,7,1,3,0)
 ;;=3^Addictions Education Service
 ;;^UTILITY(U,$J,358.3,8,0)
 ;;=H0046^^1^1^9^^^^1
 ;;^UTILITY(U,$J,358.3,8,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,8,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,9,0)
 ;;=H0003^^1^1^6^^^^1
 ;;^UTILITY(U,$J,358.3,9,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,9,1,3,0)
 ;;=3^Alcohol/Drug Scrn;lab analysis
 ;;^UTILITY(U,$J,358.3,10,0)
 ;;=H0006^^1^1^5^^^^1
 ;;^UTILITY(U,$J,358.3,10,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,10,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,11,0)
 ;;=H2027^^1^1^10^^^^1
 ;;^UTILITY(U,$J,358.3,11,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11,1,2,0)
 ;;=2^H2027
 ;;^UTILITY(U,$J,358.3,11,1,3,0)
 ;;=3^Psychoeducational Svc,per 15min
 ;;^UTILITY(U,$J,358.3,12,0)
 ;;=90791^^1^2^1^^^^1
 ;;^UTILITY(U,$J,358.3,12,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,12,1,3,0)
 ;;=3^Psych Diagnostic Eval
 ;;^UTILITY(U,$J,358.3,13,0)
 ;;=90792^^1^2^2^^^^1
 ;;^UTILITY(U,$J,358.3,13,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13,1,2,0)
 ;;=2^90792
 ;;^UTILITY(U,$J,358.3,13,1,3,0)
 ;;=3^Psych Diag Eval w/ Med Svcs
 ;;^UTILITY(U,$J,358.3,14,0)
 ;;=90853^^1^3^13^^^^1
 ;;^UTILITY(U,$J,358.3,14,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14,1,2,0)
 ;;=2^90853
 ;;^UTILITY(U,$J,358.3,14,1,3,0)
 ;;=3^Group Psychotherapy
 ;;^UTILITY(U,$J,358.3,15,0)
 ;;=90846^^1^3^14^^^^1
 ;;^UTILITY(U,$J,358.3,15,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15,1,2,0)
 ;;=2^90846
 ;;^UTILITY(U,$J,358.3,15,1,3,0)
 ;;=3^Family Psychotherapy w/o pt.
 ;;^UTILITY(U,$J,358.3,16,0)
 ;;=90847^^1^3^15^^^^1
 ;;^UTILITY(U,$J,358.3,16,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,16,1,3,0)
 ;;=3^Family Psychotherpy w/pt.
 ;;^UTILITY(U,$J,358.3,17,0)
 ;;=90875^^1^3^16^^^^1
 ;;^UTILITY(U,$J,358.3,17,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,17,1,3,0)
 ;;=3^Psych Thpy w/ Biofeedback 20-30min
