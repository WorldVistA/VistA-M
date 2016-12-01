IBDEI0HR ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22510,1,4,0)
 ;;=4^R79.1
 ;;^UTILITY(U,$J,358.3,22510,2)
 ;;=^5019591
 ;;^UTILITY(U,$J,358.3,22511,0)
 ;;=R82.5^^58^852^69
 ;;^UTILITY(U,$J,358.3,22511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22511,1,3,0)
 ;;=3^Elevated Urine Levels of Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,22511,1,4,0)
 ;;=4^R82.5
 ;;^UTILITY(U,$J,358.3,22511,2)
 ;;=^5019605
 ;;^UTILITY(U,$J,358.3,22512,0)
 ;;=R82.6^^58^852^26
 ;;^UTILITY(U,$J,358.3,22512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22512,1,3,0)
 ;;=3^Abnormal Urine Levels of Subst of Nonmed Source
 ;;^UTILITY(U,$J,358.3,22512,1,4,0)
 ;;=4^R82.6
 ;;^UTILITY(U,$J,358.3,22512,2)
 ;;=^5019606
 ;;^UTILITY(U,$J,358.3,22513,0)
 ;;=R82.7^^58^852^27
 ;;^UTILITY(U,$J,358.3,22513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22513,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,22513,1,4,0)
 ;;=4^R82.7
 ;;^UTILITY(U,$J,358.3,22513,2)
 ;;=^5019607
 ;;^UTILITY(U,$J,358.3,22514,0)
 ;;=R82.8^^58^852^23
 ;;^UTILITY(U,$J,358.3,22514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22514,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,22514,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,22514,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,22515,0)
 ;;=R82.90^^58^852^25
 ;;^UTILITY(U,$J,358.3,22515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22515,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,22515,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,22515,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,22516,0)
 ;;=R82.91^^58^852^49
 ;;^UTILITY(U,$J,358.3,22516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22516,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,22516,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,22516,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,22517,0)
 ;;=R82.99^^58^852^24
 ;;^UTILITY(U,$J,358.3,22517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22517,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,22517,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,22517,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,22518,0)
 ;;=R89.9^^58^852^19
 ;;^UTILITY(U,$J,358.3,22518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22518,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,22518,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,22518,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,22519,0)
 ;;=R90.0^^58^852^98
 ;;^UTILITY(U,$J,358.3,22519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22519,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,22519,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,22519,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,22520,0)
 ;;=R90.89^^58^852^13
 ;;^UTILITY(U,$J,358.3,22520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22520,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,22520,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,22520,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,22521,0)
 ;;=R91.8^^58^852^18
 ;;^UTILITY(U,$J,358.3,22521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22521,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,22521,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,22521,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,22522,0)
 ;;=R92.0^^58^852^117
 ;;^UTILITY(U,$J,358.3,22522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22522,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,22522,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,22522,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,22523,0)
 ;;=R92.1^^58^852^116
 ;;^UTILITY(U,$J,358.3,22523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22523,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,22523,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,22523,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,22524,0)
 ;;=R92.2^^58^852^91
 ;;^UTILITY(U,$J,358.3,22524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22524,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,22524,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,22524,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,22525,0)
 ;;=R93.0^^58^852^10
 ;;^UTILITY(U,$J,358.3,22525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22525,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,22525,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,22525,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,22526,0)
 ;;=R93.2^^58^852^9
 ;;^UTILITY(U,$J,358.3,22526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22526,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,22526,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,22526,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,22527,0)
 ;;=R93.3^^58^852^7
 ;;^UTILITY(U,$J,358.3,22527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22527,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,22527,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,22527,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,22528,0)
 ;;=R93.4^^58^852^11
 ;;^UTILITY(U,$J,358.3,22528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22528,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,22528,1,4,0)
 ;;=4^R93.4
 ;;^UTILITY(U,$J,358.3,22528,2)
 ;;=^5019717
 ;;^UTILITY(U,$J,358.3,22529,0)
 ;;=R93.5^^58^852^6
 ;;^UTILITY(U,$J,358.3,22529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22529,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,22529,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,22529,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,22530,0)
 ;;=R93.6^^58^852^8
 ;;^UTILITY(U,$J,358.3,22530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22530,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,22530,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,22530,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,22531,0)
 ;;=R94.4^^58^852^16
 ;;^UTILITY(U,$J,358.3,22531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22531,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,22531,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,22531,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,22532,0)
 ;;=R94.5^^58^852^17
 ;;^UTILITY(U,$J,358.3,22532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22532,1,3,0)
 ;;=3^Abnormal Liver Function Studies
 ;;^UTILITY(U,$J,358.3,22532,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,22532,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,22533,0)
 ;;=R94.6^^58^852^21
 ;;^UTILITY(U,$J,358.3,22533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22533,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,22533,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,22533,2)
 ;;=^5019743
 ;;^UTILITY(U,$J,358.3,22534,0)
 ;;=R94.7^^58^852^5
 ;;^UTILITY(U,$J,358.3,22534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22534,1,3,0)
 ;;=3^Abnormal Endocrine Function Sutdies NEC
 ;;^UTILITY(U,$J,358.3,22534,1,4,0)
 ;;=4^R94.7
 ;;^UTILITY(U,$J,358.3,22534,2)
 ;;=^5019744
 ;;^UTILITY(U,$J,358.3,22535,0)
 ;;=R94.31^^58^852^4
 ;;^UTILITY(U,$J,358.3,22535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22535,1,3,0)
 ;;=3^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,22535,1,4,0)
 ;;=4^R94.31
 ;;^UTILITY(U,$J,358.3,22535,2)
 ;;=^5019739
 ;;^UTILITY(U,$J,358.3,22536,0)
 ;;=R97.0^^58^852^67
 ;;^UTILITY(U,$J,358.3,22536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22536,1,3,0)
 ;;=3^Elevated Carcinoembryonic Antigen 
 ;;^UTILITY(U,$J,358.3,22536,1,4,0)
 ;;=4^R97.0
 ;;^UTILITY(U,$J,358.3,22536,2)
 ;;=^5019746
 ;;^UTILITY(U,$J,358.3,22537,0)
 ;;=R97.1^^58^852^66
 ;;^UTILITY(U,$J,358.3,22537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22537,1,3,0)
 ;;=3^Elevated Cancer Antigen 125
 ;;^UTILITY(U,$J,358.3,22537,1,4,0)
 ;;=4^R97.1
 ;;^UTILITY(U,$J,358.3,22537,2)
 ;;=^5019747
 ;;^UTILITY(U,$J,358.3,22538,0)
 ;;=R97.2^^58^852^68
 ;;^UTILITY(U,$J,358.3,22538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22538,1,3,0)
 ;;=3^Elevated PSA
 ;;^UTILITY(U,$J,358.3,22538,1,4,0)
 ;;=4^R97.2
 ;;^UTILITY(U,$J,358.3,22538,2)
 ;;=^5019748
 ;;^UTILITY(U,$J,358.3,22539,0)
 ;;=R97.8^^58^852^22
 ;;^UTILITY(U,$J,358.3,22539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22539,1,3,0)
 ;;=3^Abnormal Tumor Markers NEC
 ;;^UTILITY(U,$J,358.3,22539,1,4,0)
 ;;=4^R97.8
 ;;^UTILITY(U,$J,358.3,22539,2)
 ;;=^5019749
 ;;^UTILITY(U,$J,358.3,22540,0)
 ;;=R93.8^^58^852^12
 ;;^UTILITY(U,$J,358.3,22540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22540,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Body Structures
 ;;^UTILITY(U,$J,358.3,22540,1,4,0)
 ;;=4^R93.8
 ;;^UTILITY(U,$J,358.3,22540,2)
 ;;=^5019721
 ;;^UTILITY(U,$J,358.3,22541,0)
 ;;=R93.1^^58^852^14
 ;;^UTILITY(U,$J,358.3,22541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22541,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Heart/Cor Circ
 ;;^UTILITY(U,$J,358.3,22541,1,4,0)
 ;;=4^R93.1
 ;;^UTILITY(U,$J,358.3,22541,2)
 ;;=^5019714
 ;;^UTILITY(U,$J,358.3,22542,0)
 ;;=R68.83^^58^852^48
 ;;^UTILITY(U,$J,358.3,22542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22542,1,3,0)
 ;;=3^Chills w/o Fever
 ;;^UTILITY(U,$J,358.3,22542,1,4,0)
 ;;=4^R68.83
 ;;^UTILITY(U,$J,358.3,22542,2)
 ;;=^5019555
 ;;^UTILITY(U,$J,358.3,22543,0)
 ;;=R68.2^^58^852^62
 ;;^UTILITY(U,$J,358.3,22543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22543,1,3,0)
 ;;=3^Dry Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,22543,1,4,0)
 ;;=4^R68.2
 ;;^UTILITY(U,$J,358.3,22543,2)
 ;;=^5019552
 ;;^UTILITY(U,$J,358.3,22544,0)
 ;;=R09.02^^58^852^88
 ;;^UTILITY(U,$J,358.3,22544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22544,1,3,0)
 ;;=3^Hypoxemia
 ;;^UTILITY(U,$J,358.3,22544,1,4,0)
 ;;=4^R09.02
 ;;^UTILITY(U,$J,358.3,22544,2)
 ;;=^332831
 ;;^UTILITY(U,$J,358.3,22545,0)
 ;;=R39.81^^58^852^92
 ;;^UTILITY(U,$J,358.3,22545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22545,1,3,0)
 ;;=3^Incontinence d/t Cognitive Imprmt/Svr Disability/Mobility
 ;;^UTILITY(U,$J,358.3,22545,1,4,0)
 ;;=4^R39.81
