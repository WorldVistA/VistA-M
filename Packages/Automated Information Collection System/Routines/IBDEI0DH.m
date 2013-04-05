IBDEI0DH ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17968,1,3,0)
 ;;=3^710.2
 ;;^UTILITY(U,$J,358.3,17968,1,4,0)
 ;;=4^Sjogren's Syndrome
 ;;^UTILITY(U,$J,358.3,17968,2)
 ;;=Sjogren's Syndrome^192145^517.8
 ;;^UTILITY(U,$J,358.3,17969,0)
 ;;=516.30^^128^1106^5
 ;;^UTILITY(U,$J,358.3,17969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17969,1,3,0)
 ;;=3^516.30
 ;;^UTILITY(U,$J,358.3,17969,1,4,0)
 ;;=4^Idiopathic Pulmonary Fibrosis
 ;;^UTILITY(U,$J,358.3,17969,2)
 ;;=^340610
 ;;^UTILITY(U,$J,358.3,17970,0)
 ;;=501.^^128^1107^1
 ;;^UTILITY(U,$J,358.3,17970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17970,1,3,0)
 ;;=3^501.
 ;;^UTILITY(U,$J,358.3,17970,1,4,0)
 ;;=4^Asbestosis
 ;;^UTILITY(U,$J,358.3,17971,0)
 ;;=502.^^128^1107^4
 ;;^UTILITY(U,$J,358.3,17971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17971,1,3,0)
 ;;=3^502.
 ;;^UTILITY(U,$J,358.3,17971,1,4,0)
 ;;=4^Silicosis
 ;;^UTILITY(U,$J,358.3,17971,2)
 ;;=Silicosis^110600
 ;;^UTILITY(U,$J,358.3,17972,0)
 ;;=505.^^128^1107^3
 ;;^UTILITY(U,$J,358.3,17972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17972,1,3,0)
 ;;=3^505.
 ;;^UTILITY(U,$J,358.3,17972,1,4,0)
 ;;=4^Other Pneumoconiosis
 ;;^UTILITY(U,$J,358.3,17973,0)
 ;;=500.^^128^1107^2
 ;;^UTILITY(U,$J,358.3,17973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17973,1,3,0)
 ;;=3^500.
 ;;^UTILITY(U,$J,358.3,17973,1,4,0)
 ;;=4^Coal Workers Pheumonoconiosis
 ;;^UTILITY(U,$J,358.3,17973,2)
 ;;=Coal Workers Pheumonoconiosis^8060
 ;;^UTILITY(U,$J,358.3,17974,0)
 ;;=508.0^^128^1108^7
 ;;^UTILITY(U,$J,358.3,17974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17974,1,3,0)
 ;;=3^508.0
 ;;^UTILITY(U,$J,358.3,17974,1,4,0)
 ;;=4^Radiation Pneumonit
 ;;^UTILITY(U,$J,358.3,17975,0)
 ;;=518.3^^128^1108^2
 ;;^UTILITY(U,$J,358.3,17975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17975,1,3,0)
 ;;=3^518.3
 ;;^UTILITY(U,$J,358.3,17975,1,4,0)
 ;;=4^Eosinophil Pneumonia
 ;;^UTILITY(U,$J,358.3,17976,0)
 ;;=507.0^^128^1108^0
 ;;^UTILITY(U,$J,358.3,17976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17976,1,3,0)
 ;;=3^507.0
 ;;^UTILITY(U,$J,358.3,17976,1,4,0)
 ;;=4^Aspiration Pneumonia
 ;;^UTILITY(U,$J,358.3,17976,2)
 ;;=Aspiration Pneumonia^95581
 ;;^UTILITY(U,$J,358.3,17977,0)
 ;;=507.1^^128^1108^3
 ;;^UTILITY(U,$J,358.3,17977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17977,1,3,0)
 ;;=3^507.1
 ;;^UTILITY(U,$J,358.3,17977,1,4,0)
 ;;=4^Lipoid Pneumonia
 ;;^UTILITY(U,$J,358.3,17978,0)
 ;;=516.0^^128^1108^6
 ;;^UTILITY(U,$J,358.3,17978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17978,1,3,0)
 ;;=3^516.0
 ;;^UTILITY(U,$J,358.3,17978,1,4,0)
 ;;=4^Pulmonary Alveolar Proteinosis
 ;;^UTILITY(U,$J,358.3,17978,2)
 ;;=^100985
 ;;^UTILITY(U,$J,358.3,17979,0)
 ;;=518.89^^128^1108^4
 ;;^UTILITY(U,$J,358.3,17979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17979,1,3,0)
 ;;=3^518.89
 ;;^UTILITY(U,$J,358.3,17979,1,4,0)
 ;;=4^Lung Nodule
 ;;^UTILITY(U,$J,358.3,17979,2)
 ;;=Lung Nodule^87486
 ;;^UTILITY(U,$J,358.3,17980,0)
 ;;=519.11^^128^1108^1
 ;;^UTILITY(U,$J,358.3,17980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17980,1,3,0)
 ;;=3^519.11
 ;;^UTILITY(U,$J,358.3,17980,1,4,0)
 ;;=4^Acute Bronchospasm
 ;;^UTILITY(U,$J,358.3,17980,2)
 ;;=^334092
 ;;^UTILITY(U,$J,358.3,17981,0)
 ;;=519.19^^128^1108^5
 ;;^UTILITY(U,$J,358.3,17981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17981,1,3,0)
 ;;=3^519.19
 ;;^UTILITY(U,$J,358.3,17981,1,4,0)
 ;;=4^Other disease of Trachea/Bronchus
 ;;^UTILITY(U,$J,358.3,17981,2)
 ;;=^87499
 ;;^UTILITY(U,$J,358.3,17982,0)
 ;;=511.0^^128^1109^5
 ;;^UTILITY(U,$J,358.3,17982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17982,1,3,0)
 ;;=3^511.0
 ;;^UTILITY(U,$J,358.3,17982,1,4,0)
 ;;=4^Pleurisy
 ;;^UTILITY(U,$J,358.3,17983,0)
 ;;=501.^^128^1109^1
 ;;^UTILITY(U,$J,358.3,17983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17983,1,3,0)
 ;;=3^501.
 ;;^UTILITY(U,$J,358.3,17983,1,4,0)
 ;;=4^Asbestos Plaques/Pleural Thickening
 ;;^UTILITY(U,$J,358.3,17983,2)
 ;;=Asbestos Plaques^10704
 ;;^UTILITY(U,$J,358.3,17984,0)
 ;;=510.9^^128^1109^2
 ;;^UTILITY(U,$J,358.3,17984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17984,1,3,0)
 ;;=3^510.9
 ;;^UTILITY(U,$J,358.3,17984,1,4,0)
 ;;=4^Empyema
 ;;^UTILITY(U,$J,358.3,17984,2)
 ;;=^39810
 ;;^UTILITY(U,$J,358.3,17985,0)
 ;;=163.9^^128^1109^4
 ;;^UTILITY(U,$J,358.3,17985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17985,1,3,0)
 ;;=3^163.9
 ;;^UTILITY(U,$J,358.3,17985,1,4,0)
 ;;=4^Pleural Malignancy
 ;;^UTILITY(U,$J,358.3,17985,2)
 ;;=Pleural Malignancy^267140
 ;;^UTILITY(U,$J,358.3,17986,0)
 ;;=511.9^^128^1109^3
 ;;^UTILITY(U,$J,358.3,17986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17986,1,3,0)
 ;;=3^511.9
 ;;^UTILITY(U,$J,358.3,17986,1,4,0)
 ;;=4^Pleural Effusion
 ;;^UTILITY(U,$J,358.3,17986,2)
 ;;=Pleural Effusion^123973
 ;;^UTILITY(U,$J,358.3,17987,0)
 ;;=039.1^^128^1110^21
 ;;^UTILITY(U,$J,358.3,17987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17987,1,3,0)
 ;;=3^039.1
 ;;^UTILITY(U,$J,358.3,17987,1,4,0)
 ;;=4^Nocardiosis, Pulmonary
 ;;^UTILITY(U,$J,358.3,17987,2)
 ;;=Nocardiosis, Pulmonary^266495
 ;;^UTILITY(U,$J,358.3,17988,0)
 ;;=466.0^^128^1110^2
 ;;^UTILITY(U,$J,358.3,17988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17988,1,3,0)
 ;;=3^466.0
 ;;^UTILITY(U,$J,358.3,17988,1,4,0)
 ;;=4^Acute Bronchitis
 ;;^UTILITY(U,$J,358.3,17988,2)
 ;;=Acute Bronchitis^259084
 ;;^UTILITY(U,$J,358.3,17989,0)
 ;;=518.6^^128^1110^3
 ;;^UTILITY(U,$J,358.3,17989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17989,1,3,0)
 ;;=3^518.6
 ;;^UTILITY(U,$J,358.3,17989,1,4,0)
 ;;=4^Allergic Bronchopulm Aspergillosis
 ;;^UTILITY(U,$J,358.3,17989,2)
 ;;=Allergic Bronchopulm Aspergillosis^10945
 ;;^UTILITY(U,$J,358.3,17990,0)
 ;;=0^1^128^1110^0^Lower Respiratory Tract^1^1
 ;;^UTILITY(U,$J,358.3,17990,1,0)
 ;;=^358.31IA^0^0
 ;;^UTILITY(U,$J,358.3,17991,0)
 ;;=486.^^128^1110^6
 ;;^UTILITY(U,$J,358.3,17991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17991,1,3,0)
 ;;=3^486.
 ;;^UTILITY(U,$J,358.3,17991,1,4,0)
 ;;=4^Atypical Pneumonia
 ;;^UTILITY(U,$J,358.3,17991,2)
 ;;=Atypical Pneumonia^95632
 ;;^UTILITY(U,$J,358.3,17992,0)
 ;;=482.9^^128^1110^7
 ;;^UTILITY(U,$J,358.3,17992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17992,1,3,0)
 ;;=3^482.9
 ;;^UTILITY(U,$J,358.3,17992,1,4,0)
 ;;=4^Bacterial Pneumonia
 ;;^UTILITY(U,$J,358.3,17992,2)
 ;;=Bacterial Pneumonia^12347
 ;;^UTILITY(U,$J,358.3,17993,0)
 ;;=466.19^^128^1110^1
 ;;^UTILITY(U,$J,358.3,17993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17993,1,3,0)
 ;;=3^466.19
 ;;^UTILITY(U,$J,358.3,17993,1,4,0)
 ;;=4^Acute Bronchiolitis
 ;;^UTILITY(U,$J,358.3,17993,2)
 ;;=Acute Bronchiolitis^304310
 ;;^UTILITY(U,$J,358.3,17994,0)
 ;;=491.21^^128^1110^9
 ;;^UTILITY(U,$J,358.3,17994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17994,1,3,0)
 ;;=3^491.21
 ;;^UTILITY(U,$J,358.3,17994,1,4,0)
 ;;=4^COPD with Chronic Bronchitis, Acute exacerbation
 ;;^UTILITY(U,$J,358.3,17994,2)
 ;;=COPD with Chronic Bronchitis, Acute exacerbation^269954
 ;;^UTILITY(U,$J,358.3,17995,0)
 ;;=491.20^^128^1110^10
 ;;^UTILITY(U,$J,358.3,17995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17995,1,3,0)
 ;;=3^491.20
 ;;^UTILITY(U,$J,358.3,17995,1,4,0)
 ;;=4^COPD with Chronic Bronchitis, Stable
 ;;^UTILITY(U,$J,358.3,17995,2)
 ;;=COPD with Chronic Bronchitis, Stable^269953
 ;;^UTILITY(U,$J,358.3,17996,0)
 ;;=116.0^^128^1110^13
 ;;^UTILITY(U,$J,358.3,17996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17996,1,3,0)
 ;;=3^116.0
 ;;^UTILITY(U,$J,358.3,17996,1,4,0)
 ;;=4^Fungus, Blastomycosis
 ;;^UTILITY(U,$J,358.3,17996,2)
 ;;=Blastomycosis^15213
 ;;^UTILITY(U,$J,358.3,17997,0)
 ;;=117.5^^128^1110^15
 ;;^UTILITY(U,$J,358.3,17997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17997,1,3,0)
 ;;=3^117.5
 ;;^UTILITY(U,$J,358.3,17997,1,4,0)
 ;;=4^Fungus, Cryptococcosis
 ;;^UTILITY(U,$J,358.3,17997,2)
 ;;=Cryptococcosis^29608
 ;;^UTILITY(U,$J,358.3,17998,0)
 ;;=117.3^^128^1110^12
 ;;^UTILITY(U,$J,358.3,17998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17998,1,3,0)
 ;;=3^117.3
 ;;^UTILITY(U,$J,358.3,17998,1,4,0)
 ;;=4^Fungus, Aspergillosis
 ;;^UTILITY(U,$J,358.3,17998,2)
 ;;=Aspergillosis^10935
 ;;^UTILITY(U,$J,358.3,17999,0)
 ;;=115.95^^128^1110^16
 ;;^UTILITY(U,$J,358.3,17999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17999,1,3,0)
 ;;=3^115.95
 ;;^UTILITY(U,$J,358.3,17999,1,4,0)
 ;;=4^Fungus, Histoplasmosis Pneumonia
 ;;^UTILITY(U,$J,358.3,17999,2)
 ;;=Histoplasmosis Pneumonia^266908
 ;;^UTILITY(U,$J,358.3,18000,0)
 ;;=114.5^^128^1110^14
 ;;^UTILITY(U,$J,358.3,18000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18000,1,3,0)
 ;;=3^114.5
 ;;^UTILITY(U,$J,358.3,18000,1,4,0)
 ;;=4^Fungus, Coccidiomycosis
 ;;^UTILITY(U,$J,358.3,18000,2)
 ;;=Coccidiomycosis^295703
 ;;^UTILITY(U,$J,358.3,18001,0)
 ;;=491.1^^128^1110^20
 ;;^UTILITY(U,$J,358.3,18001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18001,1,3,0)
 ;;=3^491.1
 ;;^UTILITY(U,$J,358.3,18001,1,4,0)
 ;;=4^Mucopurulent Chronic Bronchitis
 ;;^UTILITY(U,$J,358.3,18001,2)
 ;;=Mucopurulent Chronic Bronchitis^269949
 ;;^UTILITY(U,$J,358.3,18002,0)
 ;;=491.0^^128^1110^28
 ;;^UTILITY(U,$J,358.3,18002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18002,1,3,0)
 ;;=3^491.0
 ;;^UTILITY(U,$J,358.3,18002,1,4,0)
 ;;=4^Simple Chronic Bronchitis
 ;;^UTILITY(U,$J,358.3,18002,2)
 ;;=Simple Chronic Bronchitis^269946
 ;;^UTILITY(U,$J,358.3,18003,0)
 ;;=079.99^^128^1110^35
 ;;^UTILITY(U,$J,358.3,18003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18003,1,3,0)
 ;;=3^079.99
 ;;^UTILITY(U,$J,358.3,18003,1,4,0)
 ;;=4^Viral Infection
 ;;^UTILITY(U,$J,358.3,18003,2)
 ;;=Viral Infection^295798
 ;;^UTILITY(U,$J,358.3,18004,0)
 ;;=480.9^^128^1110^36
 ;;^UTILITY(U,$J,358.3,18004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18004,1,3,0)
 ;;=3^480.9
 ;;^UTILITY(U,$J,358.3,18004,1,4,0)
 ;;=4^Viral Pneumonia
 ;;^UTILITY(U,$J,358.3,18004,2)
 ;;=Viral Pneumonia^95657
 ;;^UTILITY(U,$J,358.3,18005,0)
 ;;=477.9^^128^1110^4
