IBDEI0K8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8924,1,3,0)
 ;;=3^HTN Hrt & CKD w/o Hrt Failure w/ Stage 1-4 Chr Kidney
 ;;^UTILITY(U,$J,358.3,8924,1,4,0)
 ;;=4^I13.10
 ;;^UTILITY(U,$J,358.3,8924,2)
 ;;=^5007068
 ;;^UTILITY(U,$J,358.3,8925,0)
 ;;=I15.1^^69^607^11
 ;;^UTILITY(U,$J,358.3,8925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8925,1,3,0)
 ;;=3^Hypertension Secondary to Oth Renal Disorders
 ;;^UTILITY(U,$J,358.3,8925,1,4,0)
 ;;=4^I15.1
 ;;^UTILITY(U,$J,358.3,8925,2)
 ;;=^5007072
 ;;^UTILITY(U,$J,358.3,8926,0)
 ;;=I15.2^^69^607^10
 ;;^UTILITY(U,$J,358.3,8926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8926,1,3,0)
 ;;=3^Hypertension Secondary to Endocrine Disorders
 ;;^UTILITY(U,$J,358.3,8926,1,4,0)
 ;;=4^I15.2
 ;;^UTILITY(U,$J,358.3,8926,2)
 ;;=^5007073
 ;;^UTILITY(U,$J,358.3,8927,0)
 ;;=I50.1^^69^607^16
 ;;^UTILITY(U,$J,358.3,8927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8927,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,8927,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,8927,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,8928,0)
 ;;=E26.09^^69^607^17
 ;;^UTILITY(U,$J,358.3,8928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8928,1,3,0)
 ;;=3^Primary Hyperaldosteronism,Other
 ;;^UTILITY(U,$J,358.3,8928,1,4,0)
 ;;=4^E26.09
 ;;^UTILITY(U,$J,358.3,8928,2)
 ;;=^5002735
 ;;^UTILITY(U,$J,358.3,8929,0)
 ;;=I15.8^^69^607^18
 ;;^UTILITY(U,$J,358.3,8929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8929,1,3,0)
 ;;=3^Secondary Hypertension,Other
 ;;^UTILITY(U,$J,358.3,8929,1,4,0)
 ;;=4^I15.8
 ;;^UTILITY(U,$J,358.3,8929,2)
 ;;=^5007074
 ;;^UTILITY(U,$J,358.3,8930,0)
 ;;=E27.5^^69^607^1
 ;;^UTILITY(U,$J,358.3,8930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8930,1,3,0)
 ;;=3^Adrenomedullary Hyperfunction
 ;;^UTILITY(U,$J,358.3,8930,1,4,0)
 ;;=4^E27.5
 ;;^UTILITY(U,$J,358.3,8930,2)
 ;;=^5002744
 ;;^UTILITY(U,$J,358.3,8931,0)
 ;;=E26.01^^69^607^4
 ;;^UTILITY(U,$J,358.3,8931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8931,1,3,0)
 ;;=3^Conn's Syndrome
 ;;^UTILITY(U,$J,358.3,8931,1,4,0)
 ;;=4^E26.01
 ;;^UTILITY(U,$J,358.3,8931,2)
 ;;=^329905
 ;;^UTILITY(U,$J,358.3,8932,0)
 ;;=I15.9^^69^607^19
 ;;^UTILITY(U,$J,358.3,8932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8932,1,3,0)
 ;;=3^Secondary Hypertension,Unspec
 ;;^UTILITY(U,$J,358.3,8932,1,4,0)
 ;;=4^I15.9
 ;;^UTILITY(U,$J,358.3,8932,2)
 ;;=^5007075
 ;;^UTILITY(U,$J,358.3,8933,0)
 ;;=B20.^^69^608^3
 ;;^UTILITY(U,$J,358.3,8933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8933,1,3,0)
 ;;=3^HIV Disease
 ;;^UTILITY(U,$J,358.3,8933,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,8933,2)
 ;;=^5000555
 ;;^UTILITY(U,$J,358.3,8934,0)
 ;;=J18.9^^69^608^6
 ;;^UTILITY(U,$J,358.3,8934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8934,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,8934,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,8934,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,8935,0)
 ;;=J10.1^^69^608^1
 ;;^UTILITY(U,$J,358.3,8935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8935,1,3,0)
 ;;=3^Flu w/ Respiratory Manifestations
 ;;^UTILITY(U,$J,358.3,8935,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,8935,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,8936,0)
 ;;=K52.9^^69^608^2
 ;;^UTILITY(U,$J,358.3,8936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8936,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective,Unspec
 ;;^UTILITY(U,$J,358.3,8936,1,4,0)
 ;;=4^K52.9
