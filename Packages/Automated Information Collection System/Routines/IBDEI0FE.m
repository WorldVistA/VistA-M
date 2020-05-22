IBDEI0FE ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6631,1,3,0)
 ;;=3^Secondary Pulmonary Hypertension
 ;;^UTILITY(U,$J,358.3,6631,1,4,0)
 ;;=4^I27.21
 ;;^UTILITY(U,$J,358.3,6631,2)
 ;;=^5151377
 ;;^UTILITY(U,$J,358.3,6632,0)
 ;;=I27.81^^53^427^1
 ;;^UTILITY(U,$J,358.3,6632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6632,1,3,0)
 ;;=3^Cor Pulmonale,Chronic
 ;;^UTILITY(U,$J,358.3,6632,1,4,0)
 ;;=4^I27.81
 ;;^UTILITY(U,$J,358.3,6632,2)
 ;;=^5007152
 ;;^UTILITY(U,$J,358.3,6633,0)
 ;;=I27.89^^53^427^5
 ;;^UTILITY(U,$J,358.3,6633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6633,1,3,0)
 ;;=3^Pulmonary Heart Disease,Oth Specified
 ;;^UTILITY(U,$J,358.3,6633,1,4,0)
 ;;=4^I27.89
 ;;^UTILITY(U,$J,358.3,6633,2)
 ;;=^5007153
 ;;^UTILITY(U,$J,358.3,6634,0)
 ;;=I26.09^^53^427^3
 ;;^UTILITY(U,$J,358.3,6634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6634,1,3,0)
 ;;=3^Pulmonary Embolism w/ Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,6634,1,4,0)
 ;;=4^I26.09
 ;;^UTILITY(U,$J,358.3,6634,2)
 ;;=^5007147
 ;;^UTILITY(U,$J,358.3,6635,0)
 ;;=I26.90^^53^427^7
 ;;^UTILITY(U,$J,358.3,6635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6635,1,3,0)
 ;;=3^Septic Pulmonary Embolism w/o Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,6635,1,4,0)
 ;;=4^I26.90
 ;;^UTILITY(U,$J,358.3,6635,2)
 ;;=^5007148
 ;;^UTILITY(U,$J,358.3,6636,0)
 ;;=I26.99^^53^427^4
 ;;^UTILITY(U,$J,358.3,6636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6636,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale NEC
 ;;^UTILITY(U,$J,358.3,6636,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,6636,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,6637,0)
 ;;=Z95.0^^53^428^2
 ;;^UTILITY(U,$J,358.3,6637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6637,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,6637,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,6637,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,6638,0)
 ;;=Z95.810^^53^428^1
 ;;^UTILITY(U,$J,358.3,6638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6638,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,6638,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,6638,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,6639,0)
 ;;=I50.1^^53^429^14
 ;;^UTILITY(U,$J,358.3,6639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6639,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,6639,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,6639,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,6640,0)
 ;;=I50.20^^53^429^12
 ;;^UTILITY(U,$J,358.3,6640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6640,1,3,0)
 ;;=3^Heart Failure,Systolic,Unspec
 ;;^UTILITY(U,$J,358.3,6640,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,6640,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,6641,0)
 ;;=I50.21^^53^429^9
 ;;^UTILITY(U,$J,358.3,6641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6641,1,3,0)
 ;;=3^Heart Failure,Systolic,Acute
 ;;^UTILITY(U,$J,358.3,6641,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,6641,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,6642,0)
 ;;=I50.22^^53^429^11
 ;;^UTILITY(U,$J,358.3,6642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6642,1,3,0)
 ;;=3^Heart Failure,Systolic,Chronic
 ;;^UTILITY(U,$J,358.3,6642,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,6642,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,6643,0)
 ;;=I50.23^^53^429^10
 ;;^UTILITY(U,$J,358.3,6643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6643,1,3,0)
 ;;=3^Heart Failure,Systolic,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6643,1,4,0)
 ;;=4^I50.23
