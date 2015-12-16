IBDEI0YN ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16890,1,3,0)
 ;;=3^511.81
 ;;^UTILITY(U,$J,358.3,16890,1,4,0)
 ;;=4^Malignant Pleural Effusion
 ;;^UTILITY(U,$J,358.3,16890,2)
 ;;=^336603
 ;;^UTILITY(U,$J,358.3,16891,0)
 ;;=511.89^^87^1027^2
 ;;^UTILITY(U,$J,358.3,16891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16891,1,3,0)
 ;;=3^511.89
 ;;^UTILITY(U,$J,358.3,16891,1,4,0)
 ;;=4^Effusion NEC Exc TB
 ;;^UTILITY(U,$J,358.3,16891,2)
 ;;=^336604
 ;;^UTILITY(U,$J,358.3,16892,0)
 ;;=039.1^^87^1028^30
 ;;^UTILITY(U,$J,358.3,16892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16892,1,3,0)
 ;;=3^039.1
 ;;^UTILITY(U,$J,358.3,16892,1,4,0)
 ;;=4^Nocardiosis, Pulmonary
 ;;^UTILITY(U,$J,358.3,16892,2)
 ;;=Nocardiosis, Pulmonary^266495
 ;;^UTILITY(U,$J,358.3,16893,0)
 ;;=466.0^^87^1028^7
 ;;^UTILITY(U,$J,358.3,16893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16893,1,3,0)
 ;;=3^466.0
 ;;^UTILITY(U,$J,358.3,16893,1,4,0)
 ;;=4^Bronchitis,Acute
 ;;^UTILITY(U,$J,358.3,16893,2)
 ;;=Acute Bronchitis^259084
 ;;^UTILITY(U,$J,358.3,16894,0)
 ;;=518.6^^87^1028^2
 ;;^UTILITY(U,$J,358.3,16894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16894,1,3,0)
 ;;=3^518.6
 ;;^UTILITY(U,$J,358.3,16894,1,4,0)
 ;;=4^Allergic Bronchopulm Aspergillosis
 ;;^UTILITY(U,$J,358.3,16894,2)
 ;;=Allergic Bronchopulm Aspergillosis^10945
 ;;^UTILITY(U,$J,358.3,16895,0)
 ;;=486.^^87^1028^58
 ;;^UTILITY(U,$J,358.3,16895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16895,1,3,0)
 ;;=3^486.
 ;;^UTILITY(U,$J,358.3,16895,1,4,0)
 ;;=4^Pneumonia,Organism Unspec
 ;;^UTILITY(U,$J,358.3,16895,2)
 ;;=Atypical Pneumonia^95632
 ;;^UTILITY(U,$J,358.3,16896,0)
 ;;=482.9^^87^1028^5
 ;;^UTILITY(U,$J,358.3,16896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16896,1,3,0)
 ;;=3^482.9
 ;;^UTILITY(U,$J,358.3,16896,1,4,0)
 ;;=4^Bacterial Pneumonia,Unspec
 ;;^UTILITY(U,$J,358.3,16896,2)
 ;;=Bacterial Pneumonia^12347
 ;;^UTILITY(U,$J,358.3,16897,0)
 ;;=466.19^^87^1028^1
 ;;^UTILITY(U,$J,358.3,16897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16897,1,3,0)
 ;;=3^466.19
 ;;^UTILITY(U,$J,358.3,16897,1,4,0)
 ;;=4^Acute Bronchiolitis
 ;;^UTILITY(U,$J,358.3,16897,2)
 ;;=Acute Bronchiolitis^304310
 ;;^UTILITY(U,$J,358.3,16898,0)
 ;;=491.21^^87^1028^11
 ;;^UTILITY(U,$J,358.3,16898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16898,1,3,0)
 ;;=3^491.21
 ;;^UTILITY(U,$J,358.3,16898,1,4,0)
 ;;=4^COPD w/ Chr Bronchitis,Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,16898,2)
 ;;=COPD with Chronic Bronchitis, Acute exacerbation^269954
 ;;^UTILITY(U,$J,358.3,16899,0)
 ;;=491.20^^87^1028^12
 ;;^UTILITY(U,$J,358.3,16899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16899,1,3,0)
 ;;=3^491.20
 ;;^UTILITY(U,$J,358.3,16899,1,4,0)
 ;;=4^COPD w/ Chr Bronchitis,Stable
 ;;^UTILITY(U,$J,358.3,16899,2)
 ;;=COPD with Chronic Bronchitis, Stable^269953
 ;;^UTILITY(U,$J,358.3,16900,0)
 ;;=116.0^^87^1028^15
 ;;^UTILITY(U,$J,358.3,16900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16900,1,3,0)
 ;;=3^116.0
 ;;^UTILITY(U,$J,358.3,16900,1,4,0)
 ;;=4^Fungus, Blastomycosis
 ;;^UTILITY(U,$J,358.3,16900,2)
 ;;=Blastomycosis^15213
 ;;^UTILITY(U,$J,358.3,16901,0)
 ;;=117.5^^87^1028^17
 ;;^UTILITY(U,$J,358.3,16901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16901,1,3,0)
 ;;=3^117.5
 ;;^UTILITY(U,$J,358.3,16901,1,4,0)
 ;;=4^Fungus, Cryptococcosis
 ;;^UTILITY(U,$J,358.3,16901,2)
 ;;=Cryptococcosis^29608
 ;;^UTILITY(U,$J,358.3,16902,0)
 ;;=117.3^^87^1028^14
 ;;^UTILITY(U,$J,358.3,16902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16902,1,3,0)
 ;;=3^117.3
 ;;^UTILITY(U,$J,358.3,16902,1,4,0)
 ;;=4^Fungus, Aspergillosis
 ;;^UTILITY(U,$J,358.3,16902,2)
 ;;=Aspergillosis^10935
