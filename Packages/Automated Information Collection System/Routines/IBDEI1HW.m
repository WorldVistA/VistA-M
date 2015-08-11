IBDEI1HW ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26843,1,3,0)
 ;;=3^501.
 ;;^UTILITY(U,$J,358.3,26843,1,4,0)
 ;;=4^Asbestos Plaques/Pleural Thickening
 ;;^UTILITY(U,$J,358.3,26843,2)
 ;;=Asbestos Plaques^10704
 ;;^UTILITY(U,$J,358.3,26844,0)
 ;;=510.9^^161^1656^3
 ;;^UTILITY(U,$J,358.3,26844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26844,1,3,0)
 ;;=3^510.9
 ;;^UTILITY(U,$J,358.3,26844,1,4,0)
 ;;=4^Empyema
 ;;^UTILITY(U,$J,358.3,26844,2)
 ;;=^39810
 ;;^UTILITY(U,$J,358.3,26845,0)
 ;;=511.9^^161^1656^6
 ;;^UTILITY(U,$J,358.3,26845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26845,1,3,0)
 ;;=3^511.9
 ;;^UTILITY(U,$J,358.3,26845,1,4,0)
 ;;=4^Pleural Effusion
 ;;^UTILITY(U,$J,358.3,26845,2)
 ;;=Pleural Effusion^123973
 ;;^UTILITY(U,$J,358.3,26846,0)
 ;;=510.0^^161^1656^4
 ;;^UTILITY(U,$J,358.3,26846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26846,1,3,0)
 ;;=3^510.0
 ;;^UTILITY(U,$J,358.3,26846,1,4,0)
 ;;=4^Empyema w/ Fistula
 ;;^UTILITY(U,$J,358.3,26846,2)
 ;;=^39807
 ;;^UTILITY(U,$J,358.3,26847,0)
 ;;=511.81^^161^1656^5
 ;;^UTILITY(U,$J,358.3,26847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26847,1,3,0)
 ;;=3^511.81
 ;;^UTILITY(U,$J,358.3,26847,1,4,0)
 ;;=4^Malignant Pleural Effusion
 ;;^UTILITY(U,$J,358.3,26847,2)
 ;;=^336603
 ;;^UTILITY(U,$J,358.3,26848,0)
 ;;=511.89^^161^1656^2
 ;;^UTILITY(U,$J,358.3,26848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26848,1,3,0)
 ;;=3^511.89
 ;;^UTILITY(U,$J,358.3,26848,1,4,0)
 ;;=4^Effusion NEC Exc TB
 ;;^UTILITY(U,$J,358.3,26848,2)
 ;;=^336604
 ;;^UTILITY(U,$J,358.3,26849,0)
 ;;=039.1^^161^1657^30
 ;;^UTILITY(U,$J,358.3,26849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26849,1,3,0)
 ;;=3^039.1
 ;;^UTILITY(U,$J,358.3,26849,1,4,0)
 ;;=4^Nocardiosis, Pulmonary
 ;;^UTILITY(U,$J,358.3,26849,2)
 ;;=Nocardiosis, Pulmonary^266495
 ;;^UTILITY(U,$J,358.3,26850,0)
 ;;=466.0^^161^1657^7
 ;;^UTILITY(U,$J,358.3,26850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26850,1,3,0)
 ;;=3^466.0
 ;;^UTILITY(U,$J,358.3,26850,1,4,0)
 ;;=4^Bronchitis,Acute
 ;;^UTILITY(U,$J,358.3,26850,2)
 ;;=Acute Bronchitis^259084
 ;;^UTILITY(U,$J,358.3,26851,0)
 ;;=518.6^^161^1657^2
 ;;^UTILITY(U,$J,358.3,26851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26851,1,3,0)
 ;;=3^518.6
 ;;^UTILITY(U,$J,358.3,26851,1,4,0)
 ;;=4^Allergic Bronchopulm Aspergillosis
 ;;^UTILITY(U,$J,358.3,26851,2)
 ;;=Allergic Bronchopulm Aspergillosis^10945
 ;;^UTILITY(U,$J,358.3,26852,0)
 ;;=486.^^161^1657^58
 ;;^UTILITY(U,$J,358.3,26852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26852,1,3,0)
 ;;=3^486.
 ;;^UTILITY(U,$J,358.3,26852,1,4,0)
 ;;=4^Pneumonia,Organism Unspec
 ;;^UTILITY(U,$J,358.3,26852,2)
 ;;=Atypical Pneumonia^95632
 ;;^UTILITY(U,$J,358.3,26853,0)
 ;;=482.9^^161^1657^5
 ;;^UTILITY(U,$J,358.3,26853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26853,1,3,0)
 ;;=3^482.9
 ;;^UTILITY(U,$J,358.3,26853,1,4,0)
 ;;=4^Bacterial Pneumonia,Unspec
 ;;^UTILITY(U,$J,358.3,26853,2)
 ;;=Bacterial Pneumonia^12347
 ;;^UTILITY(U,$J,358.3,26854,0)
 ;;=466.19^^161^1657^1
 ;;^UTILITY(U,$J,358.3,26854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26854,1,3,0)
 ;;=3^466.19
 ;;^UTILITY(U,$J,358.3,26854,1,4,0)
 ;;=4^Acute Bronchiolitis
 ;;^UTILITY(U,$J,358.3,26854,2)
 ;;=Acute Bronchiolitis^304310
 ;;^UTILITY(U,$J,358.3,26855,0)
 ;;=491.21^^161^1657^11
 ;;^UTILITY(U,$J,358.3,26855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26855,1,3,0)
 ;;=3^491.21
 ;;^UTILITY(U,$J,358.3,26855,1,4,0)
 ;;=4^COPD w/ Chr Bronchitis,Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,26855,2)
 ;;=COPD with Chronic Bronchitis, Acute exacerbation^269954
 ;;^UTILITY(U,$J,358.3,26856,0)
 ;;=491.20^^161^1657^12
