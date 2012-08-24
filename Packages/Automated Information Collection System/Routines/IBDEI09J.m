IBDEI09J ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12797,1,4,0)
 ;;=4^Ventricular Arrhythmia
 ;;^UTILITY(U,$J,358.3,12798,0)
 ;;=428.0^^94^764^8
 ;;^UTILITY(U,$J,358.3,12798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12798,1,3,0)
 ;;=3^428.0
 ;;^UTILITY(U,$J,358.3,12798,1,4,0)
 ;;=4^CHF
 ;;^UTILITY(U,$J,358.3,12799,0)
 ;;=394.9^^94^764^11
 ;;^UTILITY(U,$J,358.3,12799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12799,1,3,0)
 ;;=3^394.9
 ;;^UTILITY(U,$J,358.3,12799,1,4,0)
 ;;=4^Mitral Regur/Stenosis
 ;;^UTILITY(U,$J,358.3,12799,2)
 ;;=^269571
 ;;^UTILITY(U,$J,358.3,12800,0)
 ;;=410.90^^94^764^12
 ;;^UTILITY(U,$J,358.3,12800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12800,1,3,0)
 ;;=3^410.90
 ;;^UTILITY(U,$J,358.3,12800,1,4,0)
 ;;=4^Myocardial Infarct
 ;;^UTILITY(U,$J,358.3,12801,0)
 ;;=427.2^^94^764^13
 ;;^UTILITY(U,$J,358.3,12801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12801,1,3,0)
 ;;=3^427.2
 ;;^UTILITY(U,$J,358.3,12801,1,4,0)
 ;;=4^Parox Atr Tach
 ;;^UTILITY(U,$J,358.3,12801,2)
 ;;=^117073
 ;;^UTILITY(U,$J,358.3,12802,0)
 ;;=401.9^^94^764^10
 ;;^UTILITY(U,$J,358.3,12802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12802,1,3,0)
 ;;=3^401.9
 ;;^UTILITY(U,$J,358.3,12802,1,4,0)
 ;;=4^Hypertension
 ;;^UTILITY(U,$J,358.3,12802,2)
 ;;=Hypertension^186630
 ;;^UTILITY(U,$J,358.3,12803,0)
 ;;=425.4^^94^764^9
 ;;^UTILITY(U,$J,358.3,12803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12803,1,3,0)
 ;;=3^425.4
 ;;^UTILITY(U,$J,358.3,12803,1,4,0)
 ;;=4^Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,12803,2)
 ;;=Cardiomyopathy^87808
 ;;^UTILITY(U,$J,358.3,12804,0)
 ;;=414.00^^94^764^7
 ;;^UTILITY(U,$J,358.3,12804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12804,1,3,0)
 ;;=3^414.00
 ;;^UTILITY(U,$J,358.3,12804,1,4,0)
 ;;=4^CAD
 ;;^UTILITY(U,$J,358.3,12804,2)
 ;;=CAD^28512
 ;;^UTILITY(U,$J,358.3,12805,0)
 ;;=396.8^^94^764^5
 ;;^UTILITY(U,$J,358.3,12805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12805,1,3,0)
 ;;=3^396.8
 ;;^UTILITY(U,$J,358.3,12805,1,4,0)
 ;;=4^Aortic and Mitral Stenosis/Regurg
 ;;^UTILITY(U,$J,358.3,12805,2)
 ;;=Aortic and Mitral Stenosis/Regurg^269584
 ;;^UTILITY(U,$J,358.3,12806,0)
 ;;=507.0^^94^765^1
 ;;^UTILITY(U,$J,358.3,12806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12806,1,3,0)
 ;;=3^507.0
 ;;^UTILITY(U,$J,358.3,12806,1,4,0)
 ;;=4^Aspriation Pneumonitia/Pneumonia
 ;;^UTILITY(U,$J,358.3,12806,2)
 ;;=Aspriation Pneumonitia/Pneumonia^95581
 ;;^UTILITY(U,$J,358.3,12807,0)
 ;;=495.2^^94^765^2
 ;;^UTILITY(U,$J,358.3,12807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12807,1,3,0)
 ;;=3^495.2
 ;;^UTILITY(U,$J,358.3,12807,1,4,0)
 ;;=4^Bird Fanciers Lung
 ;;^UTILITY(U,$J,358.3,12807,2)
 ;;=Bird Fanciers Lung^14840
 ;;^UTILITY(U,$J,358.3,12808,0)
 ;;=506.4^^94^765^7
 ;;^UTILITY(U,$J,358.3,12808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12808,1,3,0)
 ;;=3^506.4
 ;;^UTILITY(U,$J,358.3,12808,1,4,0)
 ;;=4^Interstitial Lung Disease, Chemical
 ;;^UTILITY(U,$J,358.3,12808,2)
 ;;=Interstitial Lung Disease, Chemical^269978
 ;;^UTILITY(U,$J,358.3,12809,0)
 ;;=515.^^94^765^6
 ;;^UTILITY(U,$J,358.3,12809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12809,1,3,0)
 ;;=3^515.
 ;;^UTILITY(U,$J,358.3,12809,1,4,0)
 ;;=4^Interstital Lung Disease, Unspec
 ;;^UTILITY(U,$J,358.3,12809,2)
 ;;=Interstital Lung Disease, Unspec^101072
 ;;^UTILITY(U,$J,358.3,12810,0)
 ;;=495.9^^94^765^4
 ;;^UTILITY(U,$J,358.3,12810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12810,1,3,0)
 ;;=3^495.9
 ;;^UTILITY(U,$J,358.3,12810,1,4,0)
 ;;=4^Hypersensitivity Pneumonitis
 ;;^UTILITY(U,$J,358.3,12810,2)
 ;;=Hypersensitivity Pneumonitis^5656
 ;;^UTILITY(U,$J,358.3,12811,0)
 ;;=495.0^^94^765^3
 ;;^UTILITY(U,$J,358.3,12811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12811,1,3,0)
 ;;=3^495.0
 ;;^UTILITY(U,$J,358.3,12811,1,4,0)
 ;;=4^Farmer's Lung
 ;;^UTILITY(U,$J,358.3,12811,2)
 ;;=Farmer's Lung^44970
 ;;^UTILITY(U,$J,358.3,12812,0)
 ;;=507.1^^94^765^8
 ;;^UTILITY(U,$J,358.3,12812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12812,1,3,0)
 ;;=3^507.1
 ;;^UTILITY(U,$J,358.3,12812,1,4,0)
 ;;=4^Lipoid Pneumonia
 ;;^UTILITY(U,$J,358.3,12812,2)
 ;;=Lipoid Pneumonia^95664
 ;;^UTILITY(U,$J,358.3,12813,0)
 ;;=710.0^^94^765^9
 ;;^UTILITY(U,$J,358.3,12813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12813,1,3,0)
 ;;=3^710.0
 ;;^UTILITY(U,$J,358.3,12813,1,4,0)
 ;;=4^Lupus Pneumonitis
 ;;^UTILITY(U,$J,358.3,12813,2)
 ;;=Lupus Pneumonitis^72159^517.8
 ;;^UTILITY(U,$J,358.3,12814,0)
 ;;=516.0^^94^765^10
 ;;^UTILITY(U,$J,358.3,12814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12814,1,3,0)
 ;;=3^516.0
 ;;^UTILITY(U,$J,358.3,12814,1,4,0)
 ;;=4^Pulmonary Alveolar Proteinosis
 ;;^UTILITY(U,$J,358.3,12814,2)
 ;;=Pulmonary Alveolar Proteinosis^100985
 ;;^UTILITY(U,$J,358.3,12815,0)
 ;;=135.^^94^765^11
 ;;^UTILITY(U,$J,358.3,12815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12815,1,3,0)
 ;;=3^135.
 ;;^UTILITY(U,$J,358.3,12815,1,4,0)
 ;;=4^Pulmonary Sarcoidosis
 ;;^UTILITY(U,$J,358.3,12815,2)
 ;;=Pulmonary Sarcoidosis^107916^517.8
 ;;^UTILITY(U,$J,358.3,12816,0)
 ;;=714.81^^94^765^12
 ;;^UTILITY(U,$J,358.3,12816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12816,1,3,0)
 ;;=3^714.81
 ;;^UTILITY(U,$J,358.3,12816,1,4,0)
 ;;=4^Rheumatoid Lung
 ;;^UTILITY(U,$J,358.3,12816,2)
 ;;=Rheumatoid Lung^106037
 ;;^UTILITY(U,$J,358.3,12817,0)
 ;;=710.1^^94^765^13
 ;;^UTILITY(U,$J,358.3,12817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12817,1,3,0)
 ;;=3^710.1
 ;;^UTILITY(U,$J,358.3,12817,1,4,0)
 ;;=4^Scleroderma/Systemic Sclerosis
 ;;^UTILITY(U,$J,358.3,12817,2)
 ;;=Scleroderma/Systemic Sclerosis^108590^517.8
 ;;^UTILITY(U,$J,358.3,12818,0)
 ;;=710.2^^94^765^14
 ;;^UTILITY(U,$J,358.3,12818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12818,1,3,0)
 ;;=3^710.2
 ;;^UTILITY(U,$J,358.3,12818,1,4,0)
 ;;=4^Sjogren's Syndrome
 ;;^UTILITY(U,$J,358.3,12818,2)
 ;;=Sjogren's Syndrome^192145^517.8
 ;;^UTILITY(U,$J,358.3,12819,0)
 ;;=516.30^^94^765^5
 ;;^UTILITY(U,$J,358.3,12819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12819,1,3,0)
 ;;=3^516.30
 ;;^UTILITY(U,$J,358.3,12819,1,4,0)
 ;;=4^Idiopathic Pulmonary Fibrosis
 ;;^UTILITY(U,$J,358.3,12819,2)
 ;;=^340610
 ;;^UTILITY(U,$J,358.3,12820,0)
 ;;=501.^^94^766^1
 ;;^UTILITY(U,$J,358.3,12820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12820,1,3,0)
 ;;=3^501.
 ;;^UTILITY(U,$J,358.3,12820,1,4,0)
 ;;=4^Asbestosis
 ;;^UTILITY(U,$J,358.3,12821,0)
 ;;=502.^^94^766^4
 ;;^UTILITY(U,$J,358.3,12821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12821,1,3,0)
 ;;=3^502.
 ;;^UTILITY(U,$J,358.3,12821,1,4,0)
 ;;=4^Silicosis
 ;;^UTILITY(U,$J,358.3,12821,2)
 ;;=Silicosis^110600
 ;;^UTILITY(U,$J,358.3,12822,0)
 ;;=505.^^94^766^3
 ;;^UTILITY(U,$J,358.3,12822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12822,1,3,0)
 ;;=3^505.
 ;;^UTILITY(U,$J,358.3,12822,1,4,0)
 ;;=4^Other Pneumoconiosis
 ;;^UTILITY(U,$J,358.3,12823,0)
 ;;=500.^^94^766^2
 ;;^UTILITY(U,$J,358.3,12823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12823,1,3,0)
 ;;=3^500.
 ;;^UTILITY(U,$J,358.3,12823,1,4,0)
 ;;=4^Coal Workers Pheumonoconiosis
 ;;^UTILITY(U,$J,358.3,12823,2)
 ;;=Coal Workers Pheumonoconiosis^8060
 ;;^UTILITY(U,$J,358.3,12824,0)
 ;;=508.0^^94^767^7
 ;;^UTILITY(U,$J,358.3,12824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12824,1,3,0)
 ;;=3^508.0
 ;;^UTILITY(U,$J,358.3,12824,1,4,0)
 ;;=4^Radiation Pneumonit
 ;;^UTILITY(U,$J,358.3,12825,0)
 ;;=518.3^^94^767^2
 ;;^UTILITY(U,$J,358.3,12825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12825,1,3,0)
 ;;=3^518.3
 ;;^UTILITY(U,$J,358.3,12825,1,4,0)
 ;;=4^Eosinophil Pneumonia
 ;;^UTILITY(U,$J,358.3,12826,0)
 ;;=507.0^^94^767^0
 ;;^UTILITY(U,$J,358.3,12826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12826,1,3,0)
 ;;=3^507.0
 ;;^UTILITY(U,$J,358.3,12826,1,4,0)
 ;;=4^Aspiration Pneumonia
 ;;^UTILITY(U,$J,358.3,12826,2)
 ;;=Aspiration Pneumonia^95581
 ;;^UTILITY(U,$J,358.3,12827,0)
 ;;=507.1^^94^767^3
 ;;^UTILITY(U,$J,358.3,12827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12827,1,3,0)
 ;;=3^507.1
 ;;^UTILITY(U,$J,358.3,12827,1,4,0)
 ;;=4^Lipoid Pneumonia
 ;;^UTILITY(U,$J,358.3,12828,0)
 ;;=516.0^^94^767^6
 ;;^UTILITY(U,$J,358.3,12828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12828,1,3,0)
 ;;=3^516.0
 ;;^UTILITY(U,$J,358.3,12828,1,4,0)
 ;;=4^Pulmonary Alveolar Proteinosis
 ;;^UTILITY(U,$J,358.3,12828,2)
 ;;=^100985
 ;;^UTILITY(U,$J,358.3,12829,0)
 ;;=518.89^^94^767^4
 ;;^UTILITY(U,$J,358.3,12829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12829,1,3,0)
 ;;=3^518.89
 ;;^UTILITY(U,$J,358.3,12829,1,4,0)
 ;;=4^Lung Nodule
 ;;^UTILITY(U,$J,358.3,12829,2)
 ;;=Lung Nodule^87486
 ;;^UTILITY(U,$J,358.3,12830,0)
 ;;=519.11^^94^767^1
 ;;^UTILITY(U,$J,358.3,12830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12830,1,3,0)
 ;;=3^519.11
 ;;^UTILITY(U,$J,358.3,12830,1,4,0)
 ;;=4^Acute Bronchospasm
 ;;^UTILITY(U,$J,358.3,12830,2)
 ;;=^334092
 ;;^UTILITY(U,$J,358.3,12831,0)
 ;;=519.19^^94^767^5
 ;;^UTILITY(U,$J,358.3,12831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12831,1,3,0)
 ;;=3^519.19
 ;;^UTILITY(U,$J,358.3,12831,1,4,0)
 ;;=4^Other disease of Trachea/Bronchus
 ;;^UTILITY(U,$J,358.3,12831,2)
 ;;=^87499
 ;;^UTILITY(U,$J,358.3,12832,0)
 ;;=511.0^^94^768^5
 ;;^UTILITY(U,$J,358.3,12832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12832,1,3,0)
 ;;=3^511.0
 ;;^UTILITY(U,$J,358.3,12832,1,4,0)
 ;;=4^Pleurisy
 ;;^UTILITY(U,$J,358.3,12833,0)
 ;;=501.^^94^768^1
 ;;^UTILITY(U,$J,358.3,12833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12833,1,3,0)
 ;;=3^501.
 ;;^UTILITY(U,$J,358.3,12833,1,4,0)
 ;;=4^Asbestos Plaques/Pleural Thickening
 ;;^UTILITY(U,$J,358.3,12833,2)
 ;;=Asbestos Plaques^10704
 ;;^UTILITY(U,$J,358.3,12834,0)
 ;;=510.9^^94^768^2
 ;;^UTILITY(U,$J,358.3,12834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12834,1,3,0)
 ;;=3^510.9
 ;;^UTILITY(U,$J,358.3,12834,1,4,0)
 ;;=4^Empyema
 ;;^UTILITY(U,$J,358.3,12834,2)
 ;;=^39810
 ;;^UTILITY(U,$J,358.3,12835,0)
 ;;=163.9^^94^768^4
