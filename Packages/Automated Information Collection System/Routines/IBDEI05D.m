IBDEI05D ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6641,1,3,0)
 ;;=3^Personal Hx of Malaria
 ;;^UTILITY(U,$J,358.3,6641,1,4,0)
 ;;=4^Z86.13
 ;;^UTILITY(U,$J,358.3,6641,2)
 ;;=^5063463
 ;;^UTILITY(U,$J,358.3,6642,0)
 ;;=Z86.73^^26^403^112
 ;;^UTILITY(U,$J,358.3,6642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6642,1,3,0)
 ;;=3^Personal Hx of TIA & Cereb Infrc w/o Residual Deficits
 ;;^UTILITY(U,$J,358.3,6642,1,4,0)
 ;;=4^Z86.73
 ;;^UTILITY(U,$J,358.3,6642,2)
 ;;=^5063477
 ;;^UTILITY(U,$J,358.3,6643,0)
 ;;=Z86.79^^26^403^75
 ;;^UTILITY(U,$J,358.3,6643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6643,1,3,0)
 ;;=3^Personal Hx of Circulatory System Diseases
 ;;^UTILITY(U,$J,358.3,6643,1,4,0)
 ;;=4^Z86.79
 ;;^UTILITY(U,$J,358.3,6643,2)
 ;;=^5063479
 ;;^UTILITY(U,$J,358.3,6644,0)
 ;;=Z91.040^^26^403^64
 ;;^UTILITY(U,$J,358.3,6644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6644,1,3,0)
 ;;=3^Latex Allergy Status
 ;;^UTILITY(U,$J,358.3,6644,1,4,0)
 ;;=4^Z91.040
 ;;^UTILITY(U,$J,358.3,6644,2)
 ;;=^5063607
 ;;^UTILITY(U,$J,358.3,6645,0)
 ;;=Z98.89^^26^403^120
 ;;^UTILITY(U,$J,358.3,6645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6645,1,3,0)
 ;;=3^Postprocedural States/Hx of Surgery NEC
 ;;^UTILITY(U,$J,358.3,6645,1,4,0)
 ;;=4^Z98.89
 ;;^UTILITY(U,$J,358.3,6645,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,6646,0)
 ;;=Z92.3^^26^403^79
 ;;^UTILITY(U,$J,358.3,6646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6646,1,3,0)
 ;;=3^Personal Hx of Irradiation
 ;;^UTILITY(U,$J,358.3,6646,1,4,0)
 ;;=4^Z92.3
 ;;^UTILITY(U,$J,358.3,6646,2)
 ;;=^5063637
 ;;^UTILITY(U,$J,358.3,6647,0)
 ;;=Z91.120^^26^403^60
 ;;^UTILITY(U,$J,358.3,6647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6647,1,3,0)
 ;;=3^Intentional Underdose of Meds d/t Financial Hardship
 ;;^UTILITY(U,$J,358.3,6647,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,6647,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,6648,0)
 ;;=Z91.11^^26^403^69
 ;;^UTILITY(U,$J,358.3,6648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6648,1,3,0)
 ;;=3^Noncompliance w/ Dietary Regimen
 ;;^UTILITY(U,$J,358.3,6648,1,4,0)
 ;;=4^Z91.11
 ;;^UTILITY(U,$J,358.3,6648,2)
 ;;=^5063611
 ;;^UTILITY(U,$J,358.3,6649,0)
 ;;=Z87.891^^26^403^103
 ;;^UTILITY(U,$J,358.3,6649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6649,1,3,0)
 ;;=3^Personal Hx of Nicotine Dependence
 ;;^UTILITY(U,$J,358.3,6649,1,4,0)
 ;;=4^Z87.891
 ;;^UTILITY(U,$J,358.3,6649,2)
 ;;=^5063518
 ;;^UTILITY(U,$J,358.3,6650,0)
 ;;=Z77.090^^26^403^11
 ;;^UTILITY(U,$J,358.3,6650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6650,1,3,0)
 ;;=3^Asbestos Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6650,1,4,0)
 ;;=4^Z77.090
 ;;^UTILITY(U,$J,358.3,6650,2)
 ;;=^5063312
 ;;^UTILITY(U,$J,358.3,6651,0)
 ;;=Z57.8^^26^403^72
 ;;^UTILITY(U,$J,358.3,6651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6651,1,3,0)
 ;;=3^Occupational Exposure to Other Risk Factors
 ;;^UTILITY(U,$J,358.3,6651,1,4,0)
 ;;=4^Z57.8
 ;;^UTILITY(U,$J,358.3,6651,2)
 ;;=^5063127
 ;;^UTILITY(U,$J,358.3,6652,0)
 ;;=Z77.21^^26^403^53
 ;;^UTILITY(U,$J,358.3,6652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6652,1,3,0)
 ;;=3^Hazardous Body Fluid Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6652,1,4,0)
 ;;=4^Z77.21
 ;;^UTILITY(U,$J,358.3,6652,2)
 ;;=^5063323
 ;;^UTILITY(U,$J,358.3,6653,0)
 ;;=Z91.81^^26^403^57
 ;;^UTILITY(U,$J,358.3,6653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6653,1,3,0)
 ;;=3^History of Falling
 ;;^UTILITY(U,$J,358.3,6653,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,6653,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,6654,0)
 ;;=Z91.89^^26^403^118
 ;;^UTILITY(U,$J,358.3,6654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6654,1,3,0)
 ;;=3^Personal Risk Factors NEC
 ;;^UTILITY(U,$J,358.3,6654,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,6654,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,6655,0)
 ;;=Z92.89^^26^403^106
 ;;^UTILITY(U,$J,358.3,6655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6655,1,3,0)
 ;;=3^Personal Hx of Other Medical Treatment
 ;;^UTILITY(U,$J,358.3,6655,1,4,0)
 ;;=4^Z92.89
 ;;^UTILITY(U,$J,358.3,6655,2)
 ;;=^5063641
 ;;^UTILITY(U,$J,358.3,6656,0)
 ;;=Z77.110^^26^403^9
 ;;^UTILITY(U,$J,358.3,6656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6656,1,3,0)
 ;;=3^Air Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6656,1,4,0)
 ;;=4^Z77.110
 ;;^UTILITY(U,$J,358.3,6656,2)
 ;;=^5063314
 ;;^UTILITY(U,$J,358.3,6657,0)
 ;;=Z77.112^^26^403^142
 ;;^UTILITY(U,$J,358.3,6657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6657,1,3,0)
 ;;=3^Soil Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6657,1,4,0)
 ;;=4^Z77.112
 ;;^UTILITY(U,$J,358.3,6657,2)
 ;;=^5063316
 ;;^UTILITY(U,$J,358.3,6658,0)
 ;;=Z77.111^^26^403^148
 ;;^UTILITY(U,$J,358.3,6658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6658,1,3,0)
 ;;=3^Water Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6658,1,4,0)
 ;;=4^Z77.111
 ;;^UTILITY(U,$J,358.3,6658,2)
 ;;=^5063315
 ;;^UTILITY(U,$J,358.3,6659,0)
 ;;=Z77.128^^26^403^119
 ;;^UTILITY(U,$J,358.3,6659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6659,1,3,0)
 ;;=3^Physical Environment Hazards Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6659,1,4,0)
 ;;=4^Z77.128
 ;;^UTILITY(U,$J,358.3,6659,2)
 ;;=^5063322
 ;;^UTILITY(U,$J,358.3,6660,0)
 ;;=Z77.123^^26^403^140
 ;;^UTILITY(U,$J,358.3,6660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6660,1,3,0)
 ;;=3^Radon/Radiation Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6660,1,4,0)
 ;;=4^Z77.123
 ;;^UTILITY(U,$J,358.3,6660,2)
 ;;=^5063321
 ;;^UTILITY(U,$J,358.3,6661,0)
 ;;=Z77.122^^26^403^68
 ;;^UTILITY(U,$J,358.3,6661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6661,1,3,0)
 ;;=3^Noise Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6661,1,4,0)
 ;;=4^Z77.122
 ;;^UTILITY(U,$J,358.3,6661,2)
 ;;=^5063320
 ;;^UTILITY(U,$J,358.3,6662,0)
 ;;=Z77.118^^26^403^19
 ;;^UTILITY(U,$J,358.3,6662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6662,1,3,0)
 ;;=3^Environmental Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6662,1,4,0)
 ;;=4^Z77.118
 ;;^UTILITY(U,$J,358.3,6662,2)
 ;;=^5063317
 ;;^UTILITY(U,$J,358.3,6663,0)
 ;;=Z77.9^^26^403^54
 ;;^UTILITY(U,$J,358.3,6663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6663,1,3,0)
 ;;=3^Health Hazard Contact/Exposure
 ;;^UTILITY(U,$J,358.3,6663,1,4,0)
 ;;=4^Z77.9
 ;;^UTILITY(U,$J,358.3,6663,2)
 ;;=^5063326
 ;;^UTILITY(U,$J,358.3,6664,0)
 ;;=Z77.22^^26^403^18
 ;;^UTILITY(U,$J,358.3,6664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6664,1,3,0)
 ;;=3^Environmental Exposure Tobacco Smoke/Second-Hand Smoke
 ;;^UTILITY(U,$J,358.3,6664,1,4,0)
 ;;=4^Z77.22
 ;;^UTILITY(U,$J,358.3,6664,2)
 ;;=^5063324
 ;;^UTILITY(U,$J,358.3,6665,0)
 ;;=Z80.0^^26^403^35
 ;;^UTILITY(U,$J,358.3,6665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6665,1,3,0)
 ;;=3^Family Hx of Malig Neop of Digestive Organs
 ;;^UTILITY(U,$J,358.3,6665,1,4,0)
 ;;=4^Z80.0
 ;;^UTILITY(U,$J,358.3,6665,2)
 ;;=^5063344
 ;;^UTILITY(U,$J,358.3,6666,0)
 ;;=Z80.1^^26^403^41
 ;;^UTILITY(U,$J,358.3,6666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6666,1,3,0)
 ;;=3^Family Hx of Malig Neop of Trachea,Bronc & Lung
 ;;^UTILITY(U,$J,358.3,6666,1,4,0)
 ;;=4^Z80.1
 ;;^UTILITY(U,$J,358.3,6666,2)
 ;;=^5063345
 ;;^UTILITY(U,$J,358.3,6667,0)
 ;;=Z80.3^^26^403^34
 ;;^UTILITY(U,$J,358.3,6667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6667,1,3,0)
 ;;=3^Family Hx of Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,6667,1,4,0)
 ;;=4^Z80.3
 ;;^UTILITY(U,$J,358.3,6667,2)
 ;;=^5063347
 ;;^UTILITY(U,$J,358.3,6668,0)
 ;;=Z80.41^^26^403^38
 ;;^UTILITY(U,$J,358.3,6668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6668,1,3,0)
 ;;=3^Family Hx of Malig Neop of Ovary
 ;;^UTILITY(U,$J,358.3,6668,1,4,0)
 ;;=4^Z80.41
 ;;^UTILITY(U,$J,358.3,6668,2)
 ;;=^5063348
 ;;^UTILITY(U,$J,358.3,6669,0)
 ;;=Z80.42^^26^403^39
 ;;^UTILITY(U,$J,358.3,6669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6669,1,3,0)
 ;;=3^Family Hx of Malig Neop of Prostate
 ;;^UTILITY(U,$J,358.3,6669,1,4,0)
 ;;=4^Z80.42
 ;;^UTILITY(U,$J,358.3,6669,2)
 ;;=^5063349
 ;;^UTILITY(U,$J,358.3,6670,0)
 ;;=Z80.43^^26^403^40
 ;;^UTILITY(U,$J,358.3,6670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6670,1,3,0)
 ;;=3^Family Hx of Malig Neop of Testis
 ;;^UTILITY(U,$J,358.3,6670,1,4,0)
 ;;=4^Z80.43
 ;;^UTILITY(U,$J,358.3,6670,2)
 ;;=^5063350
 ;;^UTILITY(U,$J,358.3,6671,0)
 ;;=Z80.6^^26^403^32
 ;;^UTILITY(U,$J,358.3,6671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6671,1,3,0)
 ;;=3^Family Hx of Leukemia
 ;;^UTILITY(U,$J,358.3,6671,1,4,0)
 ;;=4^Z80.6
 ;;^UTILITY(U,$J,358.3,6671,2)
 ;;=^5063354
 ;;^UTILITY(U,$J,358.3,6672,0)
 ;;=Z80.8^^26^403^37
 ;;^UTILITY(U,$J,358.3,6672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6672,1,3,0)
 ;;=3^Family Hx of Malig Neop of Organs/Systems
 ;;^UTILITY(U,$J,358.3,6672,1,4,0)
 ;;=4^Z80.8
 ;;^UTILITY(U,$J,358.3,6672,2)
 ;;=^5063356
 ;;^UTILITY(U,$J,358.3,6673,0)
 ;;=Z81.8^^26^403^42
 ;;^UTILITY(U,$J,358.3,6673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6673,1,3,0)
 ;;=3^Family Hx of Mental/Behavioral Disorders
 ;;^UTILITY(U,$J,358.3,6673,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,6673,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,6674,0)
 ;;=Z82.3^^26^403^49
 ;;^UTILITY(U,$J,358.3,6674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6674,1,3,0)
 ;;=3^Family Hx of Stroke
 ;;^UTILITY(U,$J,358.3,6674,1,4,0)
 ;;=4^Z82.3
 ;;^UTILITY(U,$J,358.3,6674,2)
 ;;=^5063367
 ;;^UTILITY(U,$J,358.3,6675,0)
 ;;=Z82.49^^26^403^31
 ;;^UTILITY(U,$J,358.3,6675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6675,1,3,0)
 ;;=3^Family Hx of Ischemic Heart Disease/Circulatory System
 ;;^UTILITY(U,$J,358.3,6675,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,6675,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,6676,0)
 ;;=Z82.5^^26^403^22
 ;;^UTILITY(U,$J,358.3,6676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6676,1,3,0)
 ;;=3^Family Hx of Asthma/Chronic Lower Respiratory Diseases
 ;;^UTILITY(U,$J,358.3,6676,1,4,0)
 ;;=4^Z82.5
 ;;^UTILITY(U,$J,358.3,6676,2)
 ;;=^5063370
 ;;^UTILITY(U,$J,358.3,6677,0)
 ;;=Z82.61^^26^403^21
