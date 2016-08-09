IBDEI08F ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8372,1,4,0)
 ;;=4^R63.1
 ;;^UTILITY(U,$J,358.3,8372,2)
 ;;=^186699
 ;;^UTILITY(U,$J,358.3,8373,0)
 ;;=R63.2^^42^510^147
 ;;^UTILITY(U,$J,358.3,8373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8373,1,3,0)
 ;;=3^Polyphagia
 ;;^UTILITY(U,$J,358.3,8373,1,4,0)
 ;;=4^R63.2
 ;;^UTILITY(U,$J,358.3,8373,2)
 ;;=^5019540
 ;;^UTILITY(U,$J,358.3,8374,0)
 ;;=R63.3^^42^510^76
 ;;^UTILITY(U,$J,358.3,8374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8374,1,3,0)
 ;;=3^Feeding Difficulties
 ;;^UTILITY(U,$J,358.3,8374,1,4,0)
 ;;=4^R63.3
 ;;^UTILITY(U,$J,358.3,8374,2)
 ;;=^5019541
 ;;^UTILITY(U,$J,358.3,8375,0)
 ;;=R63.4^^42^510^29
 ;;^UTILITY(U,$J,358.3,8375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8375,1,3,0)
 ;;=3^Abnormal Weight Loss
 ;;^UTILITY(U,$J,358.3,8375,1,4,0)
 ;;=4^R63.4
 ;;^UTILITY(U,$J,358.3,8375,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,8376,0)
 ;;=R63.5^^42^510^28
 ;;^UTILITY(U,$J,358.3,8376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8376,1,3,0)
 ;;=3^Abnormal Weight Gain
 ;;^UTILITY(U,$J,358.3,8376,1,4,0)
 ;;=4^R63.5
 ;;^UTILITY(U,$J,358.3,8376,2)
 ;;=^5019543
 ;;^UTILITY(U,$J,358.3,8377,0)
 ;;=R64.^^42^510^47
 ;;^UTILITY(U,$J,358.3,8377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8377,1,3,0)
 ;;=3^Cachexia
 ;;^UTILITY(U,$J,358.3,8377,1,4,0)
 ;;=4^R64.
 ;;^UTILITY(U,$J,358.3,8377,2)
 ;;=^17920
 ;;^UTILITY(U,$J,358.3,8378,0)
 ;;=R68.3^^42^510^52
 ;;^UTILITY(U,$J,358.3,8378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8378,1,3,0)
 ;;=3^Clubbing of Fingers
 ;;^UTILITY(U,$J,358.3,8378,1,4,0)
 ;;=4^R68.3
 ;;^UTILITY(U,$J,358.3,8378,2)
 ;;=^5019553
 ;;^UTILITY(U,$J,358.3,8379,0)
 ;;=R73.01^^42^510^96
 ;;^UTILITY(U,$J,358.3,8379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8379,1,3,0)
 ;;=3^Impaired Fasting Glucose
 ;;^UTILITY(U,$J,358.3,8379,1,4,0)
 ;;=4^R73.01
 ;;^UTILITY(U,$J,358.3,8379,2)
 ;;=^5019561
 ;;^UTILITY(U,$J,358.3,8380,0)
 ;;=R73.02^^42^510^97
 ;;^UTILITY(U,$J,358.3,8380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8380,1,3,0)
 ;;=3^Impaired Glucose Tolerance (oral)
 ;;^UTILITY(U,$J,358.3,8380,1,4,0)
 ;;=4^R73.02
 ;;^UTILITY(U,$J,358.3,8380,2)
 ;;=^5019562
 ;;^UTILITY(U,$J,358.3,8381,0)
 ;;=R73.09^^42^510^15
 ;;^UTILITY(U,$J,358.3,8381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8381,1,3,0)
 ;;=3^Abnormal Glucose NEC
 ;;^UTILITY(U,$J,358.3,8381,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,8381,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,8382,0)
 ;;=R73.9^^42^510^91
 ;;^UTILITY(U,$J,358.3,8382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8382,1,3,0)
 ;;=3^Hyperglycemia,Unspec
 ;;^UTILITY(U,$J,358.3,8382,1,4,0)
 ;;=4^R73.9
 ;;^UTILITY(U,$J,358.3,8382,2)
 ;;=^5019564
 ;;^UTILITY(U,$J,358.3,8383,0)
 ;;=R76.11^^42^510^150
 ;;^UTILITY(U,$J,358.3,8383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8383,1,3,0)
 ;;=3^Positive PPD
 ;;^UTILITY(U,$J,358.3,8383,1,4,0)
 ;;=4^R76.11
 ;;^UTILITY(U,$J,358.3,8383,2)
 ;;=^5019570
 ;;^UTILITY(U,$J,358.3,8384,0)
 ;;=R79.1^^42^510^3
 ;;^UTILITY(U,$J,358.3,8384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8384,1,3,0)
 ;;=3^Abnormal Coagulation Profile
 ;;^UTILITY(U,$J,358.3,8384,1,4,0)
 ;;=4^R79.1
 ;;^UTILITY(U,$J,358.3,8384,2)
 ;;=^5019591
 ;;^UTILITY(U,$J,358.3,8385,0)
 ;;=R82.5^^42^510^73
 ;;^UTILITY(U,$J,358.3,8385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8385,1,3,0)
 ;;=3^Elevated Urine Levels of Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,8385,1,4,0)
 ;;=4^R82.5
 ;;^UTILITY(U,$J,358.3,8385,2)
 ;;=^5019605
 ;;^UTILITY(U,$J,358.3,8386,0)
 ;;=R82.6^^42^510^26
 ;;^UTILITY(U,$J,358.3,8386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8386,1,3,0)
 ;;=3^Abnormal Urine Levels of Subst of Nonmed Source
 ;;^UTILITY(U,$J,358.3,8386,1,4,0)
 ;;=4^R82.6
 ;;^UTILITY(U,$J,358.3,8386,2)
 ;;=^5019606
 ;;^UTILITY(U,$J,358.3,8387,0)
 ;;=R82.7^^42^510^27
 ;;^UTILITY(U,$J,358.3,8387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8387,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,8387,1,4,0)
 ;;=4^R82.7
 ;;^UTILITY(U,$J,358.3,8387,2)
 ;;=^5019607
 ;;^UTILITY(U,$J,358.3,8388,0)
 ;;=R82.8^^42^510^23
 ;;^UTILITY(U,$J,358.3,8388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8388,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,8388,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,8388,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,8389,0)
 ;;=R82.90^^42^510^25
 ;;^UTILITY(U,$J,358.3,8389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8389,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,8389,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,8389,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,8390,0)
 ;;=R82.91^^42^510^50
 ;;^UTILITY(U,$J,358.3,8390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8390,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,8390,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,8390,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,8391,0)
 ;;=R82.99^^42^510^24
 ;;^UTILITY(U,$J,358.3,8391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8391,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,8391,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,8391,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,8392,0)
 ;;=R89.9^^42^510^19
 ;;^UTILITY(U,$J,358.3,8392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8392,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,8392,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,8392,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,8393,0)
 ;;=R90.0^^42^510^105
 ;;^UTILITY(U,$J,358.3,8393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8393,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,8393,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,8393,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,8394,0)
 ;;=R90.89^^42^510^8
 ;;^UTILITY(U,$J,358.3,8394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8394,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,8394,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,8394,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,8395,0)
 ;;=R91.8^^42^510^18
 ;;^UTILITY(U,$J,358.3,8395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8395,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,8395,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,8395,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,8396,0)
 ;;=R92.0^^42^510^124
 ;;^UTILITY(U,$J,358.3,8396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8396,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,8396,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,8396,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,8397,0)
 ;;=R92.1^^42^510^123
 ;;^UTILITY(U,$J,358.3,8397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8397,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,8397,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,8397,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,8398,0)
 ;;=R92.2^^42^510^98
 ;;^UTILITY(U,$J,358.3,8398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8398,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,8398,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,8398,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,8399,0)
 ;;=R93.0^^42^510^13
 ;;^UTILITY(U,$J,358.3,8399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8399,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,8399,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,8399,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,8400,0)
 ;;=R93.2^^42^510^12
 ;;^UTILITY(U,$J,358.3,8400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8400,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,8400,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,8400,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,8401,0)
 ;;=R93.3^^42^510^9
 ;;^UTILITY(U,$J,358.3,8401,1,0)
 ;;=^358.31IA^4^2
