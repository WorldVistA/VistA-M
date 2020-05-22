IBDEI0HS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7744,2)
 ;;=^5008809
 ;;^UTILITY(U,$J,358.3,7745,0)
 ;;=K72.91^^63^499^6
 ;;^UTILITY(U,$J,358.3,7745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7745,1,3,0)
 ;;=3^Hepatic Failure w/ Coma
 ;;^UTILITY(U,$J,358.3,7745,1,4,0)
 ;;=4^K72.91
 ;;^UTILITY(U,$J,358.3,7745,2)
 ;;=^5008810
 ;;^UTILITY(U,$J,358.3,7746,0)
 ;;=J96.00^^63^500^19
 ;;^UTILITY(U,$J,358.3,7746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7746,1,3,0)
 ;;=3^Respiratory Failure,Acute
 ;;^UTILITY(U,$J,358.3,7746,1,4,0)
 ;;=4^J96.00
 ;;^UTILITY(U,$J,358.3,7746,2)
 ;;=^5008347
 ;;^UTILITY(U,$J,358.3,7747,0)
 ;;=J96.90^^63^500^22
 ;;^UTILITY(U,$J,358.3,7747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7747,1,3,0)
 ;;=3^Respiratory Failure,Unspec
 ;;^UTILITY(U,$J,358.3,7747,1,4,0)
 ;;=4^J96.90
 ;;^UTILITY(U,$J,358.3,7747,2)
 ;;=^5008356
 ;;^UTILITY(U,$J,358.3,7748,0)
 ;;=J96.20^^63^500^20
 ;;^UTILITY(U,$J,358.3,7748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7748,1,3,0)
 ;;=3^Respiratory Failure,Acute/Chronic
 ;;^UTILITY(U,$J,358.3,7748,1,4,0)
 ;;=4^J96.20
 ;;^UTILITY(U,$J,358.3,7748,2)
 ;;=^5008353
 ;;^UTILITY(U,$J,358.3,7749,0)
 ;;=J95.822^^63^500^21
 ;;^UTILITY(U,$J,358.3,7749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7749,1,3,0)
 ;;=3^Respiratory Failure,Postprocedural,Acute/Chronic
 ;;^UTILITY(U,$J,358.3,7749,1,4,0)
 ;;=4^J95.822
 ;;^UTILITY(U,$J,358.3,7749,2)
 ;;=^5008339
 ;;^UTILITY(U,$J,358.3,7750,0)
 ;;=J44.1^^63^500^2
 ;;^UTILITY(U,$J,358.3,7750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7750,1,3,0)
 ;;=3^COPD w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,7750,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,7750,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,7751,0)
 ;;=J90.^^63^500^12
 ;;^UTILITY(U,$J,358.3,7751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7751,1,3,0)
 ;;=3^Pleural Effusion NEC
 ;;^UTILITY(U,$J,358.3,7751,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,7751,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,7752,0)
 ;;=J18.9^^63^500^14
 ;;^UTILITY(U,$J,358.3,7752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7752,1,3,0)
 ;;=3^Pneumonia,Organism Unspec
 ;;^UTILITY(U,$J,358.3,7752,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,7752,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,7753,0)
 ;;=J15.9^^63^500^13
 ;;^UTILITY(U,$J,358.3,7753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7753,1,3,0)
 ;;=3^Pneumonia,Bacterial
 ;;^UTILITY(U,$J,358.3,7753,1,4,0)
 ;;=4^J15.9
 ;;^UTILITY(U,$J,358.3,7753,2)
 ;;=^5008178
 ;;^UTILITY(U,$J,358.3,7754,0)
 ;;=J69.0^^63^500^15
 ;;^UTILITY(U,$J,358.3,7754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7754,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Food/Vomit
 ;;^UTILITY(U,$J,358.3,7754,1,4,0)
 ;;=4^J69.0
 ;;^UTILITY(U,$J,358.3,7754,2)
 ;;=^5008288
 ;;^UTILITY(U,$J,358.3,7755,0)
 ;;=J11.00^^63^500^4
 ;;^UTILITY(U,$J,358.3,7755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7755,1,3,0)
 ;;=3^Flu d/t Flu Virus w/ Unspec Type of Pneumonia
 ;;^UTILITY(U,$J,358.3,7755,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,7755,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,7756,0)
 ;;=C34.91^^63^500^9
 ;;^UTILITY(U,$J,358.3,7756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7756,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,7756,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,7756,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,7757,0)
 ;;=C34.92^^63^500^6
 ;;^UTILITY(U,$J,358.3,7757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7757,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung
