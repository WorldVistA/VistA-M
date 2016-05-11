IBDEI0BH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5188,1,3,0)
 ;;=3^Glucocorticoid-Remediable Aldosteronism
 ;;^UTILITY(U,$J,358.3,5188,1,4,0)
 ;;=4^E26.02
 ;;^UTILITY(U,$J,358.3,5188,2)
 ;;=^329904
 ;;^UTILITY(U,$J,358.3,5189,0)
 ;;=I12.9^^27^334^14
 ;;^UTILITY(U,$J,358.3,5189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5189,1,3,0)
 ;;=3^Hypertensive CKD Stage 1-4
 ;;^UTILITY(U,$J,358.3,5189,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,5189,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,5190,0)
 ;;=I12.0^^27^334^15
 ;;^UTILITY(U,$J,358.3,5190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5190,1,3,0)
 ;;=3^Hypertensive CKD Stage 5 or ESRD
 ;;^UTILITY(U,$J,358.3,5190,1,4,0)
 ;;=4^I12.0
 ;;^UTILITY(U,$J,358.3,5190,2)
 ;;=^5007065
 ;;^UTILITY(U,$J,358.3,5191,0)
 ;;=I13.0^^27^334^6
 ;;^UTILITY(U,$J,358.3,5191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5191,1,3,0)
 ;;=3^HTN Hrt & CKD w/ Hrt Failure w/ Stage 1-4 Chr Kidney
 ;;^UTILITY(U,$J,358.3,5191,1,4,0)
 ;;=4^I13.0
 ;;^UTILITY(U,$J,358.3,5191,2)
 ;;=^5007067
 ;;^UTILITY(U,$J,358.3,5192,0)
 ;;=I13.10^^27^334^9
 ;;^UTILITY(U,$J,358.3,5192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5192,1,3,0)
 ;;=3^HTN Hrt & CKD w/o Hrt Failure w/ Stage 1-4 Chr Kidney
 ;;^UTILITY(U,$J,358.3,5192,1,4,0)
 ;;=4^I13.10
 ;;^UTILITY(U,$J,358.3,5192,2)
 ;;=^5007068
 ;;^UTILITY(U,$J,358.3,5193,0)
 ;;=I15.1^^27^334^11
 ;;^UTILITY(U,$J,358.3,5193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5193,1,3,0)
 ;;=3^Hypertension Secondary to Oth Renal Disorders
 ;;^UTILITY(U,$J,358.3,5193,1,4,0)
 ;;=4^I15.1
 ;;^UTILITY(U,$J,358.3,5193,2)
 ;;=^5007072
 ;;^UTILITY(U,$J,358.3,5194,0)
 ;;=I15.2^^27^334^10
 ;;^UTILITY(U,$J,358.3,5194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5194,1,3,0)
 ;;=3^Hypertension Secondary to Endocrine Disorders
 ;;^UTILITY(U,$J,358.3,5194,1,4,0)
 ;;=4^I15.2
 ;;^UTILITY(U,$J,358.3,5194,2)
 ;;=^5007073
 ;;^UTILITY(U,$J,358.3,5195,0)
 ;;=I50.1^^27^334^16
 ;;^UTILITY(U,$J,358.3,5195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5195,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,5195,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,5195,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,5196,0)
 ;;=E26.09^^27^334^17
 ;;^UTILITY(U,$J,358.3,5196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5196,1,3,0)
 ;;=3^Primary Hyperaldosteronism,Other
 ;;^UTILITY(U,$J,358.3,5196,1,4,0)
 ;;=4^E26.09
 ;;^UTILITY(U,$J,358.3,5196,2)
 ;;=^5002735
 ;;^UTILITY(U,$J,358.3,5197,0)
 ;;=I15.8^^27^334^18
 ;;^UTILITY(U,$J,358.3,5197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5197,1,3,0)
 ;;=3^Secondary Hypertension,Other
 ;;^UTILITY(U,$J,358.3,5197,1,4,0)
 ;;=4^I15.8
 ;;^UTILITY(U,$J,358.3,5197,2)
 ;;=^5007074
 ;;^UTILITY(U,$J,358.3,5198,0)
 ;;=E27.5^^27^334^1
 ;;^UTILITY(U,$J,358.3,5198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5198,1,3,0)
 ;;=3^Adrenomedullary Hyperfunction
 ;;^UTILITY(U,$J,358.3,5198,1,4,0)
 ;;=4^E27.5
 ;;^UTILITY(U,$J,358.3,5198,2)
 ;;=^5002744
 ;;^UTILITY(U,$J,358.3,5199,0)
 ;;=E26.01^^27^334^4
 ;;^UTILITY(U,$J,358.3,5199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5199,1,3,0)
 ;;=3^Conn's Syndrome
 ;;^UTILITY(U,$J,358.3,5199,1,4,0)
 ;;=4^E26.01
 ;;^UTILITY(U,$J,358.3,5199,2)
 ;;=^329905
 ;;^UTILITY(U,$J,358.3,5200,0)
 ;;=I15.9^^27^334^19
 ;;^UTILITY(U,$J,358.3,5200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5200,1,3,0)
 ;;=3^Secondary Hypertension,Unspec
 ;;^UTILITY(U,$J,358.3,5200,1,4,0)
 ;;=4^I15.9
 ;;^UTILITY(U,$J,358.3,5200,2)
 ;;=^5007075
 ;;^UTILITY(U,$J,358.3,5201,0)
 ;;=B20.^^27^335^3
 ;;^UTILITY(U,$J,358.3,5201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5201,1,3,0)
 ;;=3^HIV Disease
