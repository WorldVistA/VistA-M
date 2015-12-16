IBDEI086 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3326,0)
 ;;=H0020^^9^123^8^^^^1
 ;;^UTILITY(U,$J,358.3,3326,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3326,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,3326,1,3,0)
 ;;=3^Methadone Admin/Service by Licensed Program
 ;;^UTILITY(U,$J,358.3,3327,0)
 ;;=H0030^^9^123^4^^^^1
 ;;^UTILITY(U,$J,358.3,3327,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3327,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,3327,1,3,0)
 ;;=3^Addictions Phone Services
 ;;^UTILITY(U,$J,358.3,3328,0)
 ;;=H0025^^9^123^3^^^^1
 ;;^UTILITY(U,$J,358.3,3328,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3328,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,3328,1,3,0)
 ;;=3^Addictions Hlth Prevention Ed Service
 ;;^UTILITY(U,$J,358.3,3329,0)
 ;;=H0046^^9^123^9^^^^1
 ;;^UTILITY(U,$J,358.3,3329,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3329,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,3329,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,3330,0)
 ;;=H0003^^9^123^6^^^^1
 ;;^UTILITY(U,$J,358.3,3330,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3330,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,3330,1,3,0)
 ;;=3^Alcohol/Drug Scrn;lab analysis
 ;;^UTILITY(U,$J,358.3,3331,0)
 ;;=H0006^^9^123^5^^^^1
 ;;^UTILITY(U,$J,358.3,3331,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3331,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,3331,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,3332,0)
 ;;=H2027^^9^123^10^^^^1
 ;;^UTILITY(U,$J,358.3,3332,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3332,1,2,0)
 ;;=2^H2027
 ;;^UTILITY(U,$J,358.3,3332,1,3,0)
 ;;=3^Psychoeducational Svc,per 15min
 ;;^UTILITY(U,$J,358.3,3333,0)
 ;;=90791^^9^124^1^^^^1
 ;;^UTILITY(U,$J,358.3,3333,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3333,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,3333,1,3,0)
 ;;=3^Psych Diagnostic Eval
 ;;^UTILITY(U,$J,358.3,3334,0)
 ;;=90792^^9^124^2^^^^1
 ;;^UTILITY(U,$J,358.3,3334,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3334,1,2,0)
 ;;=2^90792
 ;;^UTILITY(U,$J,358.3,3334,1,3,0)
 ;;=3^Psych Diag Eval w/ Med Svcs
 ;;^UTILITY(U,$J,358.3,3335,0)
 ;;=90853^^9^125^3^^^^1
 ;;^UTILITY(U,$J,358.3,3335,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3335,1,2,0)
 ;;=2^90853
 ;;^UTILITY(U,$J,358.3,3335,1,3,0)
 ;;=3^Group Psychotherapy
 ;;^UTILITY(U,$J,358.3,3336,0)
 ;;=90846^^9^125^1^^^^1
 ;;^UTILITY(U,$J,358.3,3336,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3336,1,2,0)
 ;;=2^90846
 ;;^UTILITY(U,$J,358.3,3336,1,3,0)
 ;;=3^Family Psychotherapy w/o Pt
 ;;^UTILITY(U,$J,358.3,3337,0)
 ;;=90847^^9^125^2^^^^1
 ;;^UTILITY(U,$J,358.3,3337,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3337,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,3337,1,3,0)
 ;;=3^Family Psychotherpy w/ Pt
 ;;^UTILITY(U,$J,358.3,3338,0)
 ;;=90875^^9^125^17^^^^1
 ;;^UTILITY(U,$J,358.3,3338,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3338,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,3338,1,3,0)
 ;;=3^Psych Thpy w/ Biofeedback 20-30min
 ;;^UTILITY(U,$J,358.3,3339,0)
 ;;=90876^^9^125^18^^^^1
 ;;^UTILITY(U,$J,358.3,3339,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3339,1,2,0)
 ;;=2^90876
 ;;^UTILITY(U,$J,358.3,3339,1,3,0)
 ;;=3^Psych Thpy w/ Biofeedback 45-50min
 ;;^UTILITY(U,$J,358.3,3340,0)
 ;;=90832^^9^125^11^^^^1
 ;;^UTILITY(U,$J,358.3,3340,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3340,1,2,0)
 ;;=2^90832
 ;;^UTILITY(U,$J,358.3,3340,1,3,0)
 ;;=3^PsyTx Pt/Fam 16-37 Min
 ;;^UTILITY(U,$J,358.3,3341,0)
 ;;=90834^^9^125^13^^^^1
 ;;^UTILITY(U,$J,358.3,3341,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3341,1,2,0)
 ;;=2^90834
 ;;^UTILITY(U,$J,358.3,3341,1,3,0)
 ;;=3^PsyTx Pt/Fam 38-52 Min
 ;;^UTILITY(U,$J,358.3,3342,0)
 ;;=90837^^9^125^15^^^^1
