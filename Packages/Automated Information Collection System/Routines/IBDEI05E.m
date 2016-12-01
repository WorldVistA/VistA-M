IBDEI05E ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6677,1,3,0)
 ;;=3^Family Hx of Arthritis
 ;;^UTILITY(U,$J,358.3,6677,1,4,0)
 ;;=4^Z82.61
 ;;^UTILITY(U,$J,358.3,6677,2)
 ;;=^5063371
 ;;^UTILITY(U,$J,358.3,6678,0)
 ;;=Z82.69^^26^403^44
 ;;^UTILITY(U,$J,358.3,6678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6678,1,3,0)
 ;;=3^Family Hx of Musculoskeletal System/Connective Tissue
 ;;^UTILITY(U,$J,358.3,6678,1,4,0)
 ;;=4^Z82.69
 ;;^UTILITY(U,$J,358.3,6678,2)
 ;;=^5063373
 ;;^UTILITY(U,$J,358.3,6679,0)
 ;;=Z83.3^^26^403^28
 ;;^UTILITY(U,$J,358.3,6679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6679,1,3,0)
 ;;=3^Family Hx of Diabetes Mellitus
 ;;^UTILITY(U,$J,358.3,6679,1,4,0)
 ;;=4^Z83.3
 ;;^UTILITY(U,$J,358.3,6679,2)
 ;;=^5063379
 ;;^UTILITY(U,$J,358.3,6680,0)
 ;;=Z83.2^^26^403^24
 ;;^UTILITY(U,$J,358.3,6680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6680,1,3,0)
 ;;=3^Family Hx of Blood/Immune Mechanism Diseases
 ;;^UTILITY(U,$J,358.3,6680,1,4,0)
 ;;=4^Z83.2
 ;;^UTILITY(U,$J,358.3,6680,2)
 ;;=^5063378
 ;;^UTILITY(U,$J,358.3,6681,0)
 ;;=Z82.71^^26^403^47
 ;;^UTILITY(U,$J,358.3,6681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6681,1,3,0)
 ;;=3^Family Hx of Polycystic Kidney
 ;;^UTILITY(U,$J,358.3,6681,1,4,0)
 ;;=4^Z82.71
 ;;^UTILITY(U,$J,358.3,6681,2)
 ;;=^321531
 ;;^UTILITY(U,$J,358.3,6682,0)
 ;;=Z82.1^^26^403^23
 ;;^UTILITY(U,$J,358.3,6682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6682,1,3,0)
 ;;=3^Family Hx of Blindness/Visual Loss
 ;;^UTILITY(U,$J,358.3,6682,1,4,0)
 ;;=4^Z82.1
 ;;^UTILITY(U,$J,358.3,6682,2)
 ;;=^5063365
 ;;^UTILITY(U,$J,358.3,6683,0)
 ;;=Z82.2^^26^403^27
 ;;^UTILITY(U,$J,358.3,6683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6683,1,3,0)
 ;;=3^Family Hx of Deafness/Hearing Loss
 ;;^UTILITY(U,$J,358.3,6683,1,4,0)
 ;;=4^Z82.2
 ;;^UTILITY(U,$J,358.3,6683,2)
 ;;=^5063366
 ;;^UTILITY(U,$J,358.3,6684,0)
 ;;=Z84.0^^26^403^48
 ;;^UTILITY(U,$J,358.3,6684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6684,1,3,0)
 ;;=3^Family Hx of Skin Diseases
 ;;^UTILITY(U,$J,358.3,6684,1,4,0)
 ;;=4^Z84.0
 ;;^UTILITY(U,$J,358.3,6684,2)
 ;;=^5063388
 ;;^UTILITY(U,$J,358.3,6685,0)
 ;;=Z82.79^^26^403^26
 ;;^UTILITY(U,$J,358.3,6685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6685,1,3,0)
 ;;=3^Family Hx of Congen Malform,Deformations & Chromsoml Abnlt
 ;;^UTILITY(U,$J,358.3,6685,1,4,0)
 ;;=4^Z82.79
 ;;^UTILITY(U,$J,358.3,6685,2)
 ;;=^5063374
 ;;^UTILITY(U,$J,358.3,6686,0)
 ;;=Z84.89^^26^403^46
 ;;^UTILITY(U,$J,358.3,6686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6686,1,3,0)
 ;;=3^Family Hx of Other Spec Conditions
 ;;^UTILITY(U,$J,358.3,6686,1,4,0)
 ;;=4^Z84.89
 ;;^UTILITY(U,$J,358.3,6686,2)
 ;;=^5063393
 ;;^UTILITY(U,$J,358.3,6687,0)
 ;;=Z81.1^^26^403^20
 ;;^UTILITY(U,$J,358.3,6687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6687,1,3,0)
 ;;=3^Family Hx of Alcohol Abuse/Dependence
 ;;^UTILITY(U,$J,358.3,6687,1,4,0)
 ;;=4^Z81.1
 ;;^UTILITY(U,$J,358.3,6687,2)
 ;;=^5063359
 ;;^UTILITY(U,$J,358.3,6688,0)
 ;;=Z82.62^^26^403^45
 ;;^UTILITY(U,$J,358.3,6688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6688,1,3,0)
 ;;=3^Family Hx of Osteoporosis
 ;;^UTILITY(U,$J,358.3,6688,1,4,0)
 ;;=4^Z82.62
 ;;^UTILITY(U,$J,358.3,6688,2)
 ;;=^5063372
 ;;^UTILITY(U,$J,358.3,6689,0)
 ;;=Z83.71^^26^403^25
 ;;^UTILITY(U,$J,358.3,6689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6689,1,3,0)
 ;;=3^Family Hx of Colonic Polyps
 ;;^UTILITY(U,$J,358.3,6689,1,4,0)
 ;;=4^Z83.71
 ;;^UTILITY(U,$J,358.3,6689,2)
 ;;=^5063386
 ;;^UTILITY(U,$J,358.3,6690,0)
 ;;=Z84.81^^26^403^29
 ;;^UTILITY(U,$J,358.3,6690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6690,1,3,0)
 ;;=3^Family Hx of Genetic Disease
 ;;^UTILITY(U,$J,358.3,6690,1,4,0)
 ;;=4^Z84.81
 ;;^UTILITY(U,$J,358.3,6690,2)
 ;;=^5063392
 ;;^UTILITY(U,$J,358.3,6691,0)
 ;;=Z86.010^^26^403^76
 ;;^UTILITY(U,$J,358.3,6691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6691,1,3,0)
 ;;=3^Personal Hx of Colonic Polyps
 ;;^UTILITY(U,$J,358.3,6691,1,4,0)
 ;;=4^Z86.010
 ;;^UTILITY(U,$J,358.3,6691,2)
 ;;=^5063456
 ;;^UTILITY(U,$J,358.3,6692,0)
 ;;=Z86.14^^26^403^81
 ;;^UTILITY(U,$J,358.3,6692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6692,1,3,0)
 ;;=3^Personal Hx of MRSA Infection
 ;;^UTILITY(U,$J,358.3,6692,1,4,0)
 ;;=4^Z86.14
 ;;^UTILITY(U,$J,358.3,6692,2)
 ;;=^5063464
 ;;^UTILITY(U,$J,358.3,6693,0)
 ;;=Z86.31^^26^403^77
 ;;^UTILITY(U,$J,358.3,6693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6693,1,3,0)
 ;;=3^Personal Hx of Diabetic Foot Ulcer
 ;;^UTILITY(U,$J,358.3,6693,1,4,0)
 ;;=4^Z86.31
 ;;^UTILITY(U,$J,358.3,6693,2)
 ;;=^5063467
 ;;^UTILITY(U,$J,358.3,6694,0)
 ;;=Z86.711^^26^403^107
 ;;^UTILITY(U,$J,358.3,6694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6694,1,3,0)
 ;;=3^Personal Hx of Pulmonary Embolism
 ;;^UTILITY(U,$J,358.3,6694,1,4,0)
 ;;=4^Z86.711
 ;;^UTILITY(U,$J,358.3,6694,2)
 ;;=^5063474
 ;;^UTILITY(U,$J,358.3,6695,0)
 ;;=Z86.72^^26^403^113
 ;;^UTILITY(U,$J,358.3,6695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6695,1,3,0)
 ;;=3^Personal Hx of Thrombophlebitis
 ;;^UTILITY(U,$J,358.3,6695,1,4,0)
 ;;=4^Z86.72
 ;;^UTILITY(U,$J,358.3,6695,2)
 ;;=^5063476
 ;;^UTILITY(U,$J,358.3,6696,0)
 ;;=Z87.310^^26^403^105
 ;;^UTILITY(U,$J,358.3,6696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6696,1,3,0)
 ;;=3^Personal Hx of Osteoporosis Fx
 ;;^UTILITY(U,$J,358.3,6696,1,4,0)
 ;;=4^Z87.310
 ;;^UTILITY(U,$J,358.3,6696,2)
 ;;=^5063485
 ;;^UTILITY(U,$J,358.3,6697,0)
 ;;=Z87.442^^26^403^116
 ;;^UTILITY(U,$J,358.3,6697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6697,1,3,0)
 ;;=3^Personal Hx of Urinary Calculi
 ;;^UTILITY(U,$J,358.3,6697,1,4,0)
 ;;=4^Z87.442
 ;;^UTILITY(U,$J,358.3,6697,2)
 ;;=^5063497
 ;;^UTILITY(U,$J,358.3,6698,0)
 ;;=Z87.81^^26^403^114
 ;;^UTILITY(U,$J,358.3,6698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6698,1,3,0)
 ;;=3^Personal Hx of Traumatic Fx (Healed)
 ;;^UTILITY(U,$J,358.3,6698,1,4,0)
 ;;=4^Z87.81
 ;;^UTILITY(U,$J,358.3,6698,2)
 ;;=^5063513
 ;;^UTILITY(U,$J,358.3,6699,0)
 ;;=Z87.890^^26^403^109
 ;;^UTILITY(U,$J,358.3,6699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6699,1,3,0)
 ;;=3^Personal Hx of Sex Reassignment
 ;;^UTILITY(U,$J,358.3,6699,1,4,0)
 ;;=4^Z87.890
 ;;^UTILITY(U,$J,358.3,6699,2)
 ;;=^5063517
 ;;^UTILITY(U,$J,358.3,6700,0)
 ;;=Z87.892^^26^403^74
 ;;^UTILITY(U,$J,358.3,6700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6700,1,3,0)
 ;;=3^Personal Hx of Anaphylaxis
 ;;^UTILITY(U,$J,358.3,6700,1,4,0)
 ;;=4^Z87.892
 ;;^UTILITY(U,$J,358.3,6700,2)
 ;;=^5063519
 ;;^UTILITY(U,$J,358.3,6701,0)
 ;;=Z87.39^^26^403^102
 ;;^UTILITY(U,$J,358.3,6701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6701,1,3,0)
 ;;=3^Personal Hx of Musculoskeletal/Connective Tissue Disease
 ;;^UTILITY(U,$J,358.3,6701,1,4,0)
 ;;=4^Z87.39
 ;;^UTILITY(U,$J,358.3,6701,2)
 ;;=^5063488
 ;;^UTILITY(U,$J,358.3,6702,0)
 ;;=Z87.820^^26^403^111
 ;;^UTILITY(U,$J,358.3,6702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6702,1,3,0)
 ;;=3^Personal Hx of TBI
 ;;^UTILITY(U,$J,358.3,6702,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,6702,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,6703,0)
 ;;=Z89.511^^26^403^8
 ;;^UTILITY(U,$J,358.3,6703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6703,1,3,0)
 ;;=3^Acquired Absence of Right Leg Below Knee
 ;;^UTILITY(U,$J,358.3,6703,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,6703,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,6704,0)
 ;;=Z91.82^^26^403^101
 ;;^UTILITY(U,$J,358.3,6704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6704,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,6704,1,4,0)
 ;;=4^Z91.82
 ;;^UTILITY(U,$J,358.3,6704,2)
 ;;=^5063626
 ;;^UTILITY(U,$J,358.3,6705,0)
 ;;=Z91.5^^26^403^108
 ;;^UTILITY(U,$J,358.3,6705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6705,1,3,0)
 ;;=3^Personal Hx of Self-Harm/Suicide Attempt
 ;;^UTILITY(U,$J,358.3,6705,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,6705,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,6706,0)
 ;;=Z89.512^^26^403^5
 ;;^UTILITY(U,$J,358.3,6706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6706,1,3,0)
 ;;=3^Acquired Absence of Left Leg Below Knee
 ;;^UTILITY(U,$J,358.3,6706,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,6706,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,6707,0)
 ;;=Z89.611^^26^403^7
 ;;^UTILITY(U,$J,358.3,6707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6707,1,3,0)
 ;;=3^Acquired Absence of Right Leg Above Knee
 ;;^UTILITY(U,$J,358.3,6707,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,6707,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,6708,0)
 ;;=Z89.612^^26^403^4
 ;;^UTILITY(U,$J,358.3,6708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6708,1,3,0)
 ;;=3^Acquired Absence of Left Leg Above Knee
 ;;^UTILITY(U,$J,358.3,6708,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,6708,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,6709,0)
 ;;=Z90.710^^26^403^1
 ;;^UTILITY(U,$J,358.3,6709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6709,1,3,0)
 ;;=3^Acquired Absence of Cervix & Uterus
 ;;^UTILITY(U,$J,358.3,6709,1,4,0)
 ;;=4^Z90.710
 ;;^UTILITY(U,$J,358.3,6709,2)
 ;;=^5063591
 ;;^UTILITY(U,$J,358.3,6710,0)
 ;;=Z91.030^^26^403^13
 ;;^UTILITY(U,$J,358.3,6710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6710,1,3,0)
 ;;=3^Bee Allergy
 ;;^UTILITY(U,$J,358.3,6710,1,4,0)
 ;;=4^Z91.030
 ;;^UTILITY(U,$J,358.3,6710,2)
 ;;=^5063605
 ;;^UTILITY(U,$J,358.3,6711,0)
 ;;=Z91.038^^26^403^59
 ;;^UTILITY(U,$J,358.3,6711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6711,1,3,0)
 ;;=3^Insect Allergy NEC
 ;;^UTILITY(U,$J,358.3,6711,1,4,0)
 ;;=4^Z91.038
 ;;^UTILITY(U,$J,358.3,6711,2)
 ;;=^5063606
 ;;^UTILITY(U,$J,358.3,6712,0)
 ;;=Z91.041^^26^403^139
 ;;^UTILITY(U,$J,358.3,6712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6712,1,3,0)
 ;;=3^Radiographic Dye Allergy
 ;;^UTILITY(U,$J,358.3,6712,1,4,0)
 ;;=4^Z91.041
 ;;^UTILITY(U,$J,358.3,6712,2)
 ;;=^5063608
 ;;^UTILITY(U,$J,358.3,6713,0)
 ;;=Z91.130^^26^403^146
 ;;^UTILITY(U,$J,358.3,6713,1,0)
 ;;=^358.31IA^4^2
