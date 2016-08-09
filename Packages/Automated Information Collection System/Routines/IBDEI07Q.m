IBDEI07Q ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7649,2)
 ;;=^5063312
 ;;^UTILITY(U,$J,358.3,7650,0)
 ;;=Z57.8^^42^499^72
 ;;^UTILITY(U,$J,358.3,7650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7650,1,3,0)
 ;;=3^Occupational Exposure to Other Risk Factors
 ;;^UTILITY(U,$J,358.3,7650,1,4,0)
 ;;=4^Z57.8
 ;;^UTILITY(U,$J,358.3,7650,2)
 ;;=^5063127
 ;;^UTILITY(U,$J,358.3,7651,0)
 ;;=Z77.21^^42^499^53
 ;;^UTILITY(U,$J,358.3,7651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7651,1,3,0)
 ;;=3^Hazardous Body Fluid Contact/Exposure
 ;;^UTILITY(U,$J,358.3,7651,1,4,0)
 ;;=4^Z77.21
 ;;^UTILITY(U,$J,358.3,7651,2)
 ;;=^5063323
 ;;^UTILITY(U,$J,358.3,7652,0)
 ;;=Z91.81^^42^499^57
 ;;^UTILITY(U,$J,358.3,7652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7652,1,3,0)
 ;;=3^History of Falling
 ;;^UTILITY(U,$J,358.3,7652,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,7652,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,7653,0)
 ;;=Z91.89^^42^499^118
 ;;^UTILITY(U,$J,358.3,7653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7653,1,3,0)
 ;;=3^Personal Risk Factors NEC
 ;;^UTILITY(U,$J,358.3,7653,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,7653,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,7654,0)
 ;;=Z92.89^^42^499^106
 ;;^UTILITY(U,$J,358.3,7654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7654,1,3,0)
 ;;=3^Personal Hx of Other Medical Treatment
 ;;^UTILITY(U,$J,358.3,7654,1,4,0)
 ;;=4^Z92.89
 ;;^UTILITY(U,$J,358.3,7654,2)
 ;;=^5063641
 ;;^UTILITY(U,$J,358.3,7655,0)
 ;;=Z77.110^^42^499^9
 ;;^UTILITY(U,$J,358.3,7655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7655,1,3,0)
 ;;=3^Air Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,7655,1,4,0)
 ;;=4^Z77.110
 ;;^UTILITY(U,$J,358.3,7655,2)
 ;;=^5063314
 ;;^UTILITY(U,$J,358.3,7656,0)
 ;;=Z77.112^^42^499^142
 ;;^UTILITY(U,$J,358.3,7656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7656,1,3,0)
 ;;=3^Soil Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,7656,1,4,0)
 ;;=4^Z77.112
 ;;^UTILITY(U,$J,358.3,7656,2)
 ;;=^5063316
 ;;^UTILITY(U,$J,358.3,7657,0)
 ;;=Z77.111^^42^499^148
 ;;^UTILITY(U,$J,358.3,7657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7657,1,3,0)
 ;;=3^Water Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,7657,1,4,0)
 ;;=4^Z77.111
 ;;^UTILITY(U,$J,358.3,7657,2)
 ;;=^5063315
 ;;^UTILITY(U,$J,358.3,7658,0)
 ;;=Z77.128^^42^499^119
 ;;^UTILITY(U,$J,358.3,7658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7658,1,3,0)
 ;;=3^Physical Environment Hazards Contact/Exposure
 ;;^UTILITY(U,$J,358.3,7658,1,4,0)
 ;;=4^Z77.128
 ;;^UTILITY(U,$J,358.3,7658,2)
 ;;=^5063322
 ;;^UTILITY(U,$J,358.3,7659,0)
 ;;=Z77.123^^42^499^140
 ;;^UTILITY(U,$J,358.3,7659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7659,1,3,0)
 ;;=3^Radon/Radiation Contact/Exposure
 ;;^UTILITY(U,$J,358.3,7659,1,4,0)
 ;;=4^Z77.123
 ;;^UTILITY(U,$J,358.3,7659,2)
 ;;=^5063321
 ;;^UTILITY(U,$J,358.3,7660,0)
 ;;=Z77.122^^42^499^68
 ;;^UTILITY(U,$J,358.3,7660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7660,1,3,0)
 ;;=3^Noise Contact/Exposure
 ;;^UTILITY(U,$J,358.3,7660,1,4,0)
 ;;=4^Z77.122
 ;;^UTILITY(U,$J,358.3,7660,2)
 ;;=^5063320
 ;;^UTILITY(U,$J,358.3,7661,0)
 ;;=Z77.118^^42^499^19
 ;;^UTILITY(U,$J,358.3,7661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7661,1,3,0)
 ;;=3^Environmental Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,7661,1,4,0)
 ;;=4^Z77.118
 ;;^UTILITY(U,$J,358.3,7661,2)
 ;;=^5063317
 ;;^UTILITY(U,$J,358.3,7662,0)
 ;;=Z77.9^^42^499^54
 ;;^UTILITY(U,$J,358.3,7662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7662,1,3,0)
 ;;=3^Health Hazard Contact/Exposure
 ;;^UTILITY(U,$J,358.3,7662,1,4,0)
 ;;=4^Z77.9
 ;;^UTILITY(U,$J,358.3,7662,2)
 ;;=^5063326
 ;;^UTILITY(U,$J,358.3,7663,0)
 ;;=Z77.22^^42^499^18
 ;;^UTILITY(U,$J,358.3,7663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7663,1,3,0)
 ;;=3^Environmental Exposure Tobacco Smoke/Second-Hand Smoke
 ;;^UTILITY(U,$J,358.3,7663,1,4,0)
 ;;=4^Z77.22
 ;;^UTILITY(U,$J,358.3,7663,2)
 ;;=^5063324
 ;;^UTILITY(U,$J,358.3,7664,0)
 ;;=Z80.0^^42^499^35
 ;;^UTILITY(U,$J,358.3,7664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7664,1,3,0)
 ;;=3^Family Hx of Malig Neop of Digestive Organs
 ;;^UTILITY(U,$J,358.3,7664,1,4,0)
 ;;=4^Z80.0
 ;;^UTILITY(U,$J,358.3,7664,2)
 ;;=^5063344
 ;;^UTILITY(U,$J,358.3,7665,0)
 ;;=Z80.1^^42^499^41
 ;;^UTILITY(U,$J,358.3,7665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7665,1,3,0)
 ;;=3^Family Hx of Malig Neop of Trachea,Bronc & Lung
 ;;^UTILITY(U,$J,358.3,7665,1,4,0)
 ;;=4^Z80.1
 ;;^UTILITY(U,$J,358.3,7665,2)
 ;;=^5063345
 ;;^UTILITY(U,$J,358.3,7666,0)
 ;;=Z80.3^^42^499^34
 ;;^UTILITY(U,$J,358.3,7666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7666,1,3,0)
 ;;=3^Family Hx of Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,7666,1,4,0)
 ;;=4^Z80.3
 ;;^UTILITY(U,$J,358.3,7666,2)
 ;;=^5063347
 ;;^UTILITY(U,$J,358.3,7667,0)
 ;;=Z80.41^^42^499^38
 ;;^UTILITY(U,$J,358.3,7667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7667,1,3,0)
 ;;=3^Family Hx of Malig Neop of Ovary
 ;;^UTILITY(U,$J,358.3,7667,1,4,0)
 ;;=4^Z80.41
 ;;^UTILITY(U,$J,358.3,7667,2)
 ;;=^5063348
 ;;^UTILITY(U,$J,358.3,7668,0)
 ;;=Z80.42^^42^499^39
 ;;^UTILITY(U,$J,358.3,7668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7668,1,3,0)
 ;;=3^Family Hx of Malig Neop of Prostate
 ;;^UTILITY(U,$J,358.3,7668,1,4,0)
 ;;=4^Z80.42
 ;;^UTILITY(U,$J,358.3,7668,2)
 ;;=^5063349
 ;;^UTILITY(U,$J,358.3,7669,0)
 ;;=Z80.43^^42^499^40
 ;;^UTILITY(U,$J,358.3,7669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7669,1,3,0)
 ;;=3^Family Hx of Malig Neop of Testis
 ;;^UTILITY(U,$J,358.3,7669,1,4,0)
 ;;=4^Z80.43
 ;;^UTILITY(U,$J,358.3,7669,2)
 ;;=^5063350
 ;;^UTILITY(U,$J,358.3,7670,0)
 ;;=Z80.6^^42^499^32
 ;;^UTILITY(U,$J,358.3,7670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7670,1,3,0)
 ;;=3^Family Hx of Leukemia
 ;;^UTILITY(U,$J,358.3,7670,1,4,0)
 ;;=4^Z80.6
 ;;^UTILITY(U,$J,358.3,7670,2)
 ;;=^5063354
 ;;^UTILITY(U,$J,358.3,7671,0)
 ;;=Z80.8^^42^499^37
 ;;^UTILITY(U,$J,358.3,7671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7671,1,3,0)
 ;;=3^Family Hx of Malig Neop of Organs/Systems
 ;;^UTILITY(U,$J,358.3,7671,1,4,0)
 ;;=4^Z80.8
 ;;^UTILITY(U,$J,358.3,7671,2)
 ;;=^5063356
 ;;^UTILITY(U,$J,358.3,7672,0)
 ;;=Z81.8^^42^499^42
 ;;^UTILITY(U,$J,358.3,7672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7672,1,3,0)
 ;;=3^Family Hx of Mental/Behavioral Disorders
 ;;^UTILITY(U,$J,358.3,7672,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,7672,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,7673,0)
 ;;=Z82.3^^42^499^49
 ;;^UTILITY(U,$J,358.3,7673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7673,1,3,0)
 ;;=3^Family Hx of Stroke
 ;;^UTILITY(U,$J,358.3,7673,1,4,0)
 ;;=4^Z82.3
 ;;^UTILITY(U,$J,358.3,7673,2)
 ;;=^5063367
 ;;^UTILITY(U,$J,358.3,7674,0)
 ;;=Z82.49^^42^499^31
 ;;^UTILITY(U,$J,358.3,7674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7674,1,3,0)
 ;;=3^Family Hx of Ischemic Heart Disease/Circulatory System
 ;;^UTILITY(U,$J,358.3,7674,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,7674,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,7675,0)
 ;;=Z82.5^^42^499^22
 ;;^UTILITY(U,$J,358.3,7675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7675,1,3,0)
 ;;=3^Family Hx of Asthma/Chronic Lower Respiratory Diseases
 ;;^UTILITY(U,$J,358.3,7675,1,4,0)
 ;;=4^Z82.5
 ;;^UTILITY(U,$J,358.3,7675,2)
 ;;=^5063370
 ;;^UTILITY(U,$J,358.3,7676,0)
 ;;=Z82.61^^42^499^21
 ;;^UTILITY(U,$J,358.3,7676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7676,1,3,0)
 ;;=3^Family Hx of Arthritis
 ;;^UTILITY(U,$J,358.3,7676,1,4,0)
 ;;=4^Z82.61
 ;;^UTILITY(U,$J,358.3,7676,2)
 ;;=^5063371
 ;;^UTILITY(U,$J,358.3,7677,0)
 ;;=Z82.69^^42^499^44
 ;;^UTILITY(U,$J,358.3,7677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7677,1,3,0)
 ;;=3^Family Hx of Musculoskeletal System/Connective Tissue
 ;;^UTILITY(U,$J,358.3,7677,1,4,0)
 ;;=4^Z82.69
 ;;^UTILITY(U,$J,358.3,7677,2)
 ;;=^5063373
 ;;^UTILITY(U,$J,358.3,7678,0)
 ;;=Z83.3^^42^499^28
