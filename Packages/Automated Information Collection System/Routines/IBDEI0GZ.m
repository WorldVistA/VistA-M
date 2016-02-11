IBDEI0GZ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7586,1,4,0)
 ;;=4^I12.0
 ;;^UTILITY(U,$J,358.3,7586,2)
 ;;=^5007065
 ;;^UTILITY(U,$J,358.3,7587,0)
 ;;=I13.0^^52^508^6
 ;;^UTILITY(U,$J,358.3,7587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7587,1,3,0)
 ;;=3^HTN Hrt & CKD w/ Hrt Failure w/ Stage 1-4 Chr Kidney
 ;;^UTILITY(U,$J,358.3,7587,1,4,0)
 ;;=4^I13.0
 ;;^UTILITY(U,$J,358.3,7587,2)
 ;;=^5007067
 ;;^UTILITY(U,$J,358.3,7588,0)
 ;;=I13.10^^52^508^9
 ;;^UTILITY(U,$J,358.3,7588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7588,1,3,0)
 ;;=3^HTN Hrt & CKD w/o Hrt Failure w/ Stage 1-4 Chr Kidney
 ;;^UTILITY(U,$J,358.3,7588,1,4,0)
 ;;=4^I13.10
 ;;^UTILITY(U,$J,358.3,7588,2)
 ;;=^5007068
 ;;^UTILITY(U,$J,358.3,7589,0)
 ;;=I15.1^^52^508^11
 ;;^UTILITY(U,$J,358.3,7589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7589,1,3,0)
 ;;=3^Hypertension Secondary to Oth Renal Disorders
 ;;^UTILITY(U,$J,358.3,7589,1,4,0)
 ;;=4^I15.1
 ;;^UTILITY(U,$J,358.3,7589,2)
 ;;=^5007072
 ;;^UTILITY(U,$J,358.3,7590,0)
 ;;=I15.2^^52^508^10
 ;;^UTILITY(U,$J,358.3,7590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7590,1,3,0)
 ;;=3^Hypertension Secondary to Endocrine Disorders
 ;;^UTILITY(U,$J,358.3,7590,1,4,0)
 ;;=4^I15.2
 ;;^UTILITY(U,$J,358.3,7590,2)
 ;;=^5007073
 ;;^UTILITY(U,$J,358.3,7591,0)
 ;;=I50.1^^52^508^16
 ;;^UTILITY(U,$J,358.3,7591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7591,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,7591,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,7591,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,7592,0)
 ;;=E26.09^^52^508^17
 ;;^UTILITY(U,$J,358.3,7592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7592,1,3,0)
 ;;=3^Primary Hyperaldosteronism,Other
 ;;^UTILITY(U,$J,358.3,7592,1,4,0)
 ;;=4^E26.09
 ;;^UTILITY(U,$J,358.3,7592,2)
 ;;=^5002735
 ;;^UTILITY(U,$J,358.3,7593,0)
 ;;=I15.8^^52^508^18
 ;;^UTILITY(U,$J,358.3,7593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7593,1,3,0)
 ;;=3^Secondary Hypertension,Other
 ;;^UTILITY(U,$J,358.3,7593,1,4,0)
 ;;=4^I15.8
 ;;^UTILITY(U,$J,358.3,7593,2)
 ;;=^5007074
 ;;^UTILITY(U,$J,358.3,7594,0)
 ;;=E27.5^^52^508^1
 ;;^UTILITY(U,$J,358.3,7594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7594,1,3,0)
 ;;=3^Adrenomedullary Hyperfunction
 ;;^UTILITY(U,$J,358.3,7594,1,4,0)
 ;;=4^E27.5
 ;;^UTILITY(U,$J,358.3,7594,2)
 ;;=^5002744
 ;;^UTILITY(U,$J,358.3,7595,0)
 ;;=E26.01^^52^508^4
 ;;^UTILITY(U,$J,358.3,7595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7595,1,3,0)
 ;;=3^Conn's Syndrome
 ;;^UTILITY(U,$J,358.3,7595,1,4,0)
 ;;=4^E26.01
 ;;^UTILITY(U,$J,358.3,7595,2)
 ;;=^329905
 ;;^UTILITY(U,$J,358.3,7596,0)
 ;;=I15.9^^52^508^19
 ;;^UTILITY(U,$J,358.3,7596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7596,1,3,0)
 ;;=3^Secondary Hypertension,Unspec
 ;;^UTILITY(U,$J,358.3,7596,1,4,0)
 ;;=4^I15.9
 ;;^UTILITY(U,$J,358.3,7596,2)
 ;;=^5007075
 ;;^UTILITY(U,$J,358.3,7597,0)
 ;;=B20.^^52^509^3
 ;;^UTILITY(U,$J,358.3,7597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7597,1,3,0)
 ;;=3^HIV Disease
 ;;^UTILITY(U,$J,358.3,7597,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,7597,2)
 ;;=^5000555
 ;;^UTILITY(U,$J,358.3,7598,0)
 ;;=J18.9^^52^509^6
 ;;^UTILITY(U,$J,358.3,7598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7598,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,7598,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,7598,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,7599,0)
 ;;=J10.1^^52^509^1
 ;;^UTILITY(U,$J,358.3,7599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7599,1,3,0)
 ;;=3^Flu w/ Respiratory Manifestations
 ;;^UTILITY(U,$J,358.3,7599,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,7599,2)
 ;;=^5008151
