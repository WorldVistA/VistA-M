IBDEI0FG ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15465,1,3,0)
 ;;=3^Abnormal Weight Gain
 ;;^UTILITY(U,$J,358.3,15465,1,4,0)
 ;;=4^R63.5
 ;;^UTILITY(U,$J,358.3,15465,2)
 ;;=^5019543
 ;;^UTILITY(U,$J,358.3,15466,0)
 ;;=R64.^^61^752^46
 ;;^UTILITY(U,$J,358.3,15466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15466,1,3,0)
 ;;=3^Cachexia
 ;;^UTILITY(U,$J,358.3,15466,1,4,0)
 ;;=4^R64.
 ;;^UTILITY(U,$J,358.3,15466,2)
 ;;=^17920
 ;;^UTILITY(U,$J,358.3,15467,0)
 ;;=R68.3^^61^752^51
 ;;^UTILITY(U,$J,358.3,15467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15467,1,3,0)
 ;;=3^Clubbing of Fingers
 ;;^UTILITY(U,$J,358.3,15467,1,4,0)
 ;;=4^R68.3
 ;;^UTILITY(U,$J,358.3,15467,2)
 ;;=^5019553
 ;;^UTILITY(U,$J,358.3,15468,0)
 ;;=R73.01^^61^752^89
 ;;^UTILITY(U,$J,358.3,15468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15468,1,3,0)
 ;;=3^Impaired Fasting Glucose
 ;;^UTILITY(U,$J,358.3,15468,1,4,0)
 ;;=4^R73.01
 ;;^UTILITY(U,$J,358.3,15468,2)
 ;;=^5019561
 ;;^UTILITY(U,$J,358.3,15469,0)
 ;;=R73.02^^61^752^90
 ;;^UTILITY(U,$J,358.3,15469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15469,1,3,0)
 ;;=3^Impaired Glucose Tolerance (oral)
 ;;^UTILITY(U,$J,358.3,15469,1,4,0)
 ;;=4^R73.02
 ;;^UTILITY(U,$J,358.3,15469,2)
 ;;=^5019562
 ;;^UTILITY(U,$J,358.3,15470,0)
 ;;=R73.09^^61^752^15
 ;;^UTILITY(U,$J,358.3,15470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15470,1,3,0)
 ;;=3^Abnormal Glucose NEC
 ;;^UTILITY(U,$J,358.3,15470,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,15470,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,15471,0)
 ;;=R73.9^^61^752^84
 ;;^UTILITY(U,$J,358.3,15471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15471,1,3,0)
 ;;=3^Hyperglycemia,Unspec
 ;;^UTILITY(U,$J,358.3,15471,1,4,0)
 ;;=4^R73.9
 ;;^UTILITY(U,$J,358.3,15471,2)
 ;;=^5019564
 ;;^UTILITY(U,$J,358.3,15472,0)
 ;;=R76.11^^61^752^142
 ;;^UTILITY(U,$J,358.3,15472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15472,1,3,0)
 ;;=3^Positive PPD
 ;;^UTILITY(U,$J,358.3,15472,1,4,0)
 ;;=4^R76.11
 ;;^UTILITY(U,$J,358.3,15472,2)
 ;;=^5019570
 ;;^UTILITY(U,$J,358.3,15473,0)
 ;;=R79.1^^61^752^3
 ;;^UTILITY(U,$J,358.3,15473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15473,1,3,0)
 ;;=3^Abnormal Coagulation Profile
 ;;^UTILITY(U,$J,358.3,15473,1,4,0)
 ;;=4^R79.1
 ;;^UTILITY(U,$J,358.3,15473,2)
 ;;=^5019591
 ;;^UTILITY(U,$J,358.3,15474,0)
 ;;=R82.5^^61^752^69
 ;;^UTILITY(U,$J,358.3,15474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15474,1,3,0)
 ;;=3^Elevated Urine Levels of Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,15474,1,4,0)
 ;;=4^R82.5
 ;;^UTILITY(U,$J,358.3,15474,2)
 ;;=^5019605
 ;;^UTILITY(U,$J,358.3,15475,0)
 ;;=R82.6^^61^752^26
 ;;^UTILITY(U,$J,358.3,15475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15475,1,3,0)
 ;;=3^Abnormal Urine Levels of Subst of Nonmed Source
 ;;^UTILITY(U,$J,358.3,15475,1,4,0)
 ;;=4^R82.6
 ;;^UTILITY(U,$J,358.3,15475,2)
 ;;=^5019606
 ;;^UTILITY(U,$J,358.3,15476,0)
 ;;=R82.7^^61^752^27
 ;;^UTILITY(U,$J,358.3,15476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15476,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,15476,1,4,0)
 ;;=4^R82.7
 ;;^UTILITY(U,$J,358.3,15476,2)
 ;;=^5019607
 ;;^UTILITY(U,$J,358.3,15477,0)
 ;;=R82.8^^61^752^23
 ;;^UTILITY(U,$J,358.3,15477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15477,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,15477,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,15477,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,15478,0)
 ;;=R82.90^^61^752^25
 ;;^UTILITY(U,$J,358.3,15478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15478,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,15478,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,15478,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,15479,0)
 ;;=R82.91^^61^752^49
 ;;^UTILITY(U,$J,358.3,15479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15479,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,15479,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,15479,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,15480,0)
 ;;=R82.99^^61^752^24
 ;;^UTILITY(U,$J,358.3,15480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15480,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,15480,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,15480,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,15481,0)
 ;;=R89.9^^61^752^19
 ;;^UTILITY(U,$J,358.3,15481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15481,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,15481,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,15481,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,15482,0)
 ;;=R90.0^^61^752^98
 ;;^UTILITY(U,$J,358.3,15482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15482,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,15482,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,15482,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,15483,0)
 ;;=R90.89^^61^752^13
 ;;^UTILITY(U,$J,358.3,15483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15483,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,15483,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,15483,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,15484,0)
 ;;=R91.8^^61^752^18
 ;;^UTILITY(U,$J,358.3,15484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15484,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,15484,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,15484,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,15485,0)
 ;;=R92.0^^61^752^117
 ;;^UTILITY(U,$J,358.3,15485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15485,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,15485,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,15485,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,15486,0)
 ;;=R92.1^^61^752^116
 ;;^UTILITY(U,$J,358.3,15486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15486,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,15486,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,15486,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,15487,0)
 ;;=R92.2^^61^752^91
 ;;^UTILITY(U,$J,358.3,15487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15487,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,15487,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,15487,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,15488,0)
 ;;=R93.0^^61^752^10
 ;;^UTILITY(U,$J,358.3,15488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15488,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,15488,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,15488,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,15489,0)
 ;;=R93.2^^61^752^9
 ;;^UTILITY(U,$J,358.3,15489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15489,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,15489,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,15489,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,15490,0)
 ;;=R93.3^^61^752^7
 ;;^UTILITY(U,$J,358.3,15490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15490,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,15490,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,15490,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,15491,0)
 ;;=R93.4^^61^752^11
 ;;^UTILITY(U,$J,358.3,15491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15491,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,15491,1,4,0)
 ;;=4^R93.4
 ;;^UTILITY(U,$J,358.3,15491,2)
 ;;=^5019717
 ;;^UTILITY(U,$J,358.3,15492,0)
 ;;=R93.5^^61^752^6
 ;;^UTILITY(U,$J,358.3,15492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15492,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,15492,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,15492,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,15493,0)
 ;;=R93.6^^61^752^8
