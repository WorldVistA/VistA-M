IBDEI015 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,17,1,3,0)
 ;;=3^Psych Thpy w/ Biofeedback 20-30min
 ;;^UTILITY(U,$J,358.3,18,0)
 ;;=90876^^1^3^18^^^^1
 ;;^UTILITY(U,$J,358.3,18,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18,1,2,0)
 ;;=2^90876
 ;;^UTILITY(U,$J,358.3,18,1,3,0)
 ;;=3^Psych Thpy w/ Biofeedback 45-50min
 ;;^UTILITY(U,$J,358.3,19,0)
 ;;=90832^^1^3^11^^^^1
 ;;^UTILITY(U,$J,358.3,19,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19,1,2,0)
 ;;=2^90832
 ;;^UTILITY(U,$J,358.3,19,1,3,0)
 ;;=3^PsyTx Pt/Fam 16-37 Min
 ;;^UTILITY(U,$J,358.3,20,0)
 ;;=90834^^1^3^13^^^^1
 ;;^UTILITY(U,$J,358.3,20,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20,1,2,0)
 ;;=2^90834
 ;;^UTILITY(U,$J,358.3,20,1,3,0)
 ;;=3^PsyTx Pt/Fam 38-52 Min
 ;;^UTILITY(U,$J,358.3,21,0)
 ;;=90837^^1^3^15^^^^1
 ;;^UTILITY(U,$J,358.3,21,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21,1,2,0)
 ;;=2^90837
 ;;^UTILITY(U,$J,358.3,21,1,3,0)
 ;;=3^PsyTx Pt/Fam 53-89 Min
 ;;^UTILITY(U,$J,358.3,22,0)
 ;;=90833^^1^3^12^^^^1
 ;;^UTILITY(U,$J,358.3,22,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22,1,2,0)
 ;;=2^90833
 ;;^UTILITY(U,$J,358.3,22,1,3,0)
 ;;=3^PsyTx Pt/Fam 16-37 Min-Report w/ E&M code
 ;;^UTILITY(U,$J,358.3,23,0)
 ;;=90836^^1^3^14^^^^1
 ;;^UTILITY(U,$J,358.3,23,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23,1,2,0)
 ;;=2^90836
 ;;^UTILITY(U,$J,358.3,23,1,3,0)
 ;;=3^PsyTx Pt/Fam 38-52 Min-Report w/ E&M code
 ;;^UTILITY(U,$J,358.3,24,0)
 ;;=90838^^1^3^16^^^^1
 ;;^UTILITY(U,$J,358.3,24,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24,1,2,0)
 ;;=2^90838
 ;;^UTILITY(U,$J,358.3,24,1,3,0)
 ;;=3^PsyTx Pt/Fam 53-89 Min-Report w/ E&M code
 ;;^UTILITY(U,$J,358.3,25,0)
 ;;=90839^^1^3^8^^^^1
 ;;^UTILITY(U,$J,358.3,25,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25,1,2,0)
 ;;=2^90839
 ;;^UTILITY(U,$J,358.3,25,1,3,0)
 ;;=3^PsyTx Crisis Initial 30-74 Min
 ;;^UTILITY(U,$J,358.3,26,0)
 ;;=90840^^1^3^9^^^^1
 ;;^UTILITY(U,$J,358.3,26,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26,1,2,0)
 ;;=2^90840
 ;;^UTILITY(U,$J,358.3,26,1,3,0)
 ;;=3^PsyTx Crisis,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,27,0)
 ;;=90785^^1^3^10^^^^1
 ;;^UTILITY(U,$J,358.3,27,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,27,1,3,0)
 ;;=3^PsyTx Interactive Complexity,Add-On
 ;;^UTILITY(U,$J,358.3,28,0)
 ;;=99354^^1^3^6^^^^1
 ;;^UTILITY(U,$J,358.3,28,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28,1,2,0)
 ;;=2^99354
 ;;^UTILITY(U,$J,358.3,28,1,3,0)
 ;;=3^Prolonged Svc/OPT 1st Hr,Add-On
 ;;^UTILITY(U,$J,358.3,29,0)
 ;;=99355^^1^3^7^^^^1
 ;;^UTILITY(U,$J,358.3,29,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29,1,2,0)
 ;;=2^99355
 ;;^UTILITY(U,$J,358.3,29,1,3,0)
 ;;=3^Prolonged Svc/OPT,Ea Addl 30 Min,Add-On
 ;;^UTILITY(U,$J,358.3,30,0)
 ;;=99356^^1^3^4^^^^1
 ;;^UTILITY(U,$J,358.3,30,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,30,1,2,0)
 ;;=2^99356
 ;;^UTILITY(U,$J,358.3,30,1,3,0)
 ;;=3^Prolonged Svc INPT/OBS 1st Hr,Add-On
 ;;^UTILITY(U,$J,358.3,31,0)
 ;;=99357^^1^3^5^^^^1
 ;;^UTILITY(U,$J,358.3,31,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31,1,2,0)
 ;;=2^99357
 ;;^UTILITY(U,$J,358.3,31,1,3,0)
 ;;=3^Prolonged Svc INPT/OBS,Ea Addl 30 Min,Add-On
 ;;^UTILITY(U,$J,358.3,32,0)
 ;;=96116^^1^4^2^^^^1
 ;;^UTILITY(U,$J,358.3,32,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32,1,2,0)
 ;;=2^96116
 ;;^UTILITY(U,$J,358.3,32,1,3,0)
 ;;=3^Neurobehavioral Status Exam,Ea Hr
 ;;^UTILITY(U,$J,358.3,33,0)
 ;;=96120^^1^4^3^^^^1
 ;;^UTILITY(U,$J,358.3,33,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33,1,2,0)
 ;;=2^96120
