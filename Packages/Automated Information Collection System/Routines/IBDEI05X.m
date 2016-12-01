IBDEI05X ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7373,1,4,0)
 ;;=4^R63.0
 ;;^UTILITY(U,$J,358.3,7373,2)
 ;;=^7939
 ;;^UTILITY(U,$J,358.3,7374,0)
 ;;=R63.1^^26^414^146
 ;;^UTILITY(U,$J,358.3,7374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7374,1,3,0)
 ;;=3^Polydipsia
 ;;^UTILITY(U,$J,358.3,7374,1,4,0)
 ;;=4^R63.1
 ;;^UTILITY(U,$J,358.3,7374,2)
 ;;=^186699
 ;;^UTILITY(U,$J,358.3,7375,0)
 ;;=R63.2^^26^414^147
 ;;^UTILITY(U,$J,358.3,7375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7375,1,3,0)
 ;;=3^Polyphagia
 ;;^UTILITY(U,$J,358.3,7375,1,4,0)
 ;;=4^R63.2
 ;;^UTILITY(U,$J,358.3,7375,2)
 ;;=^5019540
 ;;^UTILITY(U,$J,358.3,7376,0)
 ;;=R63.3^^26^414^76
 ;;^UTILITY(U,$J,358.3,7376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7376,1,3,0)
 ;;=3^Feeding Difficulties
 ;;^UTILITY(U,$J,358.3,7376,1,4,0)
 ;;=4^R63.3
 ;;^UTILITY(U,$J,358.3,7376,2)
 ;;=^5019541
 ;;^UTILITY(U,$J,358.3,7377,0)
 ;;=R63.4^^26^414^29
 ;;^UTILITY(U,$J,358.3,7377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7377,1,3,0)
 ;;=3^Abnormal Weight Loss
 ;;^UTILITY(U,$J,358.3,7377,1,4,0)
 ;;=4^R63.4
 ;;^UTILITY(U,$J,358.3,7377,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,7378,0)
 ;;=R63.5^^26^414^28
 ;;^UTILITY(U,$J,358.3,7378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7378,1,3,0)
 ;;=3^Abnormal Weight Gain
 ;;^UTILITY(U,$J,358.3,7378,1,4,0)
 ;;=4^R63.5
 ;;^UTILITY(U,$J,358.3,7378,2)
 ;;=^5019543
 ;;^UTILITY(U,$J,358.3,7379,0)
 ;;=R64.^^26^414^47
 ;;^UTILITY(U,$J,358.3,7379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7379,1,3,0)
 ;;=3^Cachexia
 ;;^UTILITY(U,$J,358.3,7379,1,4,0)
 ;;=4^R64.
 ;;^UTILITY(U,$J,358.3,7379,2)
 ;;=^17920
 ;;^UTILITY(U,$J,358.3,7380,0)
 ;;=R68.3^^26^414^52
 ;;^UTILITY(U,$J,358.3,7380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7380,1,3,0)
 ;;=3^Clubbing of Fingers
 ;;^UTILITY(U,$J,358.3,7380,1,4,0)
 ;;=4^R68.3
 ;;^UTILITY(U,$J,358.3,7380,2)
 ;;=^5019553
 ;;^UTILITY(U,$J,358.3,7381,0)
 ;;=R73.01^^26^414^96
 ;;^UTILITY(U,$J,358.3,7381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7381,1,3,0)
 ;;=3^Impaired Fasting Glucose
 ;;^UTILITY(U,$J,358.3,7381,1,4,0)
 ;;=4^R73.01
 ;;^UTILITY(U,$J,358.3,7381,2)
 ;;=^5019561
 ;;^UTILITY(U,$J,358.3,7382,0)
 ;;=R73.02^^26^414^97
 ;;^UTILITY(U,$J,358.3,7382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7382,1,3,0)
 ;;=3^Impaired Glucose Tolerance (oral)
 ;;^UTILITY(U,$J,358.3,7382,1,4,0)
 ;;=4^R73.02
 ;;^UTILITY(U,$J,358.3,7382,2)
 ;;=^5019562
 ;;^UTILITY(U,$J,358.3,7383,0)
 ;;=R73.09^^26^414^15
 ;;^UTILITY(U,$J,358.3,7383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7383,1,3,0)
 ;;=3^Abnormal Glucose NEC
 ;;^UTILITY(U,$J,358.3,7383,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,7383,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,7384,0)
 ;;=R73.9^^26^414^91
 ;;^UTILITY(U,$J,358.3,7384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7384,1,3,0)
 ;;=3^Hyperglycemia,Unspec
 ;;^UTILITY(U,$J,358.3,7384,1,4,0)
 ;;=4^R73.9
 ;;^UTILITY(U,$J,358.3,7384,2)
 ;;=^5019564
 ;;^UTILITY(U,$J,358.3,7385,0)
 ;;=R76.11^^26^414^150
 ;;^UTILITY(U,$J,358.3,7385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7385,1,3,0)
 ;;=3^Positive PPD
 ;;^UTILITY(U,$J,358.3,7385,1,4,0)
 ;;=4^R76.11
 ;;^UTILITY(U,$J,358.3,7385,2)
 ;;=^5019570
 ;;^UTILITY(U,$J,358.3,7386,0)
 ;;=R79.1^^26^414^3
 ;;^UTILITY(U,$J,358.3,7386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7386,1,3,0)
 ;;=3^Abnormal Coagulation Profile
 ;;^UTILITY(U,$J,358.3,7386,1,4,0)
 ;;=4^R79.1
 ;;^UTILITY(U,$J,358.3,7386,2)
 ;;=^5019591
 ;;^UTILITY(U,$J,358.3,7387,0)
 ;;=R82.5^^26^414^73
 ;;^UTILITY(U,$J,358.3,7387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7387,1,3,0)
 ;;=3^Elevated Urine Levels of Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,7387,1,4,0)
 ;;=4^R82.5
 ;;^UTILITY(U,$J,358.3,7387,2)
 ;;=^5019605
 ;;^UTILITY(U,$J,358.3,7388,0)
 ;;=R82.6^^26^414^26
 ;;^UTILITY(U,$J,358.3,7388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7388,1,3,0)
 ;;=3^Abnormal Urine Levels of Subst of Nonmed Source
 ;;^UTILITY(U,$J,358.3,7388,1,4,0)
 ;;=4^R82.6
 ;;^UTILITY(U,$J,358.3,7388,2)
 ;;=^5019606
 ;;^UTILITY(U,$J,358.3,7389,0)
 ;;=R82.7^^26^414^27
 ;;^UTILITY(U,$J,358.3,7389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7389,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,7389,1,4,0)
 ;;=4^R82.7
 ;;^UTILITY(U,$J,358.3,7389,2)
 ;;=^5019607
 ;;^UTILITY(U,$J,358.3,7390,0)
 ;;=R82.8^^26^414^23
 ;;^UTILITY(U,$J,358.3,7390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7390,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,7390,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,7390,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,7391,0)
 ;;=R82.90^^26^414^25
 ;;^UTILITY(U,$J,358.3,7391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7391,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,7391,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,7391,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,7392,0)
 ;;=R82.91^^26^414^50
 ;;^UTILITY(U,$J,358.3,7392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7392,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,7392,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,7392,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,7393,0)
 ;;=R82.99^^26^414^24
 ;;^UTILITY(U,$J,358.3,7393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7393,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,7393,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,7393,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,7394,0)
 ;;=R89.9^^26^414^19
 ;;^UTILITY(U,$J,358.3,7394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7394,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,7394,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,7394,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,7395,0)
 ;;=R90.0^^26^414^105
 ;;^UTILITY(U,$J,358.3,7395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7395,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,7395,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,7395,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,7396,0)
 ;;=R90.89^^26^414^8
 ;;^UTILITY(U,$J,358.3,7396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7396,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,7396,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,7396,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,7397,0)
 ;;=R91.8^^26^414^18
 ;;^UTILITY(U,$J,358.3,7397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7397,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,7397,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,7397,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,7398,0)
 ;;=R92.0^^26^414^124
 ;;^UTILITY(U,$J,358.3,7398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7398,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,7398,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,7398,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,7399,0)
 ;;=R92.1^^26^414^123
 ;;^UTILITY(U,$J,358.3,7399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7399,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,7399,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,7399,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,7400,0)
 ;;=R92.2^^26^414^98
 ;;^UTILITY(U,$J,358.3,7400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7400,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,7400,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,7400,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,7401,0)
 ;;=R93.0^^26^414^13
 ;;^UTILITY(U,$J,358.3,7401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7401,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,7401,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,7401,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,7402,0)
 ;;=R93.2^^26^414^12
 ;;^UTILITY(U,$J,358.3,7402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7402,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,7402,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,7402,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,7403,0)
 ;;=R93.3^^26^414^9
 ;;^UTILITY(U,$J,358.3,7403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7403,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,7403,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,7403,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,7404,0)
 ;;=R93.4^^26^414^14
 ;;^UTILITY(U,$J,358.3,7404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7404,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,7404,1,4,0)
 ;;=4^R93.4
 ;;^UTILITY(U,$J,358.3,7404,2)
 ;;=^5019717
 ;;^UTILITY(U,$J,358.3,7405,0)
 ;;=R93.5^^26^414^6
 ;;^UTILITY(U,$J,358.3,7405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7405,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,7405,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,7405,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,7406,0)
 ;;=R93.6^^26^414^11
 ;;^UTILITY(U,$J,358.3,7406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7406,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,7406,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,7406,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,7407,0)
 ;;=R94.4^^26^414^16
 ;;^UTILITY(U,$J,358.3,7407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7407,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,7407,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,7407,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,7408,0)
 ;;=R94.5^^26^414^17
 ;;^UTILITY(U,$J,358.3,7408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7408,1,3,0)
 ;;=3^Abnormal Liver Function Studies
 ;;^UTILITY(U,$J,358.3,7408,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,7408,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,7409,0)
 ;;=R94.6^^26^414^21
 ;;^UTILITY(U,$J,358.3,7409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7409,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,7409,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,7409,2)
 ;;=^5019743
