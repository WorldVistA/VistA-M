IBDEI04D ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10496,1,4,0)
 ;;=4^R68.3
 ;;^UTILITY(U,$J,358.3,10496,2)
 ;;=^5019553
 ;;^UTILITY(U,$J,358.3,10497,0)
 ;;=R73.01^^48^500^94
 ;;^UTILITY(U,$J,358.3,10497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10497,1,3,0)
 ;;=3^Impaired Fasting Glucose
 ;;^UTILITY(U,$J,358.3,10497,1,4,0)
 ;;=4^R73.01
 ;;^UTILITY(U,$J,358.3,10497,2)
 ;;=^5019561
 ;;^UTILITY(U,$J,358.3,10498,0)
 ;;=R73.02^^48^500^95
 ;;^UTILITY(U,$J,358.3,10498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10498,1,3,0)
 ;;=3^Impaired Glucose Tolerance (oral)
 ;;^UTILITY(U,$J,358.3,10498,1,4,0)
 ;;=4^R73.02
 ;;^UTILITY(U,$J,358.3,10498,2)
 ;;=^5019562
 ;;^UTILITY(U,$J,358.3,10499,0)
 ;;=R73.09^^48^500^18
 ;;^UTILITY(U,$J,358.3,10499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10499,1,3,0)
 ;;=3^Abnormal Glucose NEC
 ;;^UTILITY(U,$J,358.3,10499,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,10499,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,10500,0)
 ;;=R73.9^^48^500^89
 ;;^UTILITY(U,$J,358.3,10500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10500,1,3,0)
 ;;=3^Hyperglycemia,Unspec
 ;;^UTILITY(U,$J,358.3,10500,1,4,0)
 ;;=4^R73.9
 ;;^UTILITY(U,$J,358.3,10500,2)
 ;;=^5019564
 ;;^UTILITY(U,$J,358.3,10501,0)
 ;;=R76.11^^48^500^147
 ;;^UTILITY(U,$J,358.3,10501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10501,1,3,0)
 ;;=3^Positive PPD
 ;;^UTILITY(U,$J,358.3,10501,1,4,0)
 ;;=4^R76.11
 ;;^UTILITY(U,$J,358.3,10501,2)
 ;;=^5019570
 ;;^UTILITY(U,$J,358.3,10502,0)
 ;;=R79.1^^48^500^3
 ;;^UTILITY(U,$J,358.3,10502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10502,1,3,0)
 ;;=3^Abnormal Coagulation Profile
 ;;^UTILITY(U,$J,358.3,10502,1,4,0)
 ;;=4^R79.1
 ;;^UTILITY(U,$J,358.3,10502,2)
 ;;=^5019591
 ;;^UTILITY(U,$J,358.3,10503,0)
 ;;=R82.5^^48^500^74
 ;;^UTILITY(U,$J,358.3,10503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10503,1,3,0)
 ;;=3^Elevated Urine Levels of Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,10503,1,4,0)
 ;;=4^R82.5
 ;;^UTILITY(U,$J,358.3,10503,2)
 ;;=^5019605
 ;;^UTILITY(U,$J,358.3,10504,0)
 ;;=R82.6^^48^500^30
 ;;^UTILITY(U,$J,358.3,10504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10504,1,3,0)
 ;;=3^Abnormal Urine Levels of Subst of Nonmed Source
 ;;^UTILITY(U,$J,358.3,10504,1,4,0)
 ;;=4^R82.6
 ;;^UTILITY(U,$J,358.3,10504,2)
 ;;=^5019606
 ;;^UTILITY(U,$J,358.3,10505,0)
 ;;=R82.90^^48^500^29
 ;;^UTILITY(U,$J,358.3,10505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10505,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,10505,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,10505,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,10506,0)
 ;;=R82.91^^48^500^53
 ;;^UTILITY(U,$J,358.3,10506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10506,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,10506,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,10506,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,10507,0)
 ;;=R89.9^^48^500^22
 ;;^UTILITY(U,$J,358.3,10507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10507,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,10507,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,10507,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,10508,0)
 ;;=R90.0^^48^500^103
 ;;^UTILITY(U,$J,358.3,10508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10508,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,10508,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,10508,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,10509,0)
 ;;=R90.89^^48^500^16
 ;;^UTILITY(U,$J,358.3,10509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10509,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,10509,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,10509,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,10510,0)
 ;;=R91.8^^48^500^21
 ;;^UTILITY(U,$J,358.3,10510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10510,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,10510,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,10510,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,10511,0)
 ;;=R92.0^^48^500^122
 ;;^UTILITY(U,$J,358.3,10511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10511,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,10511,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,10511,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,10512,0)
 ;;=R92.1^^48^500^121
 ;;^UTILITY(U,$J,358.3,10512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10512,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,10512,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,10512,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,10513,0)
 ;;=R92.2^^48^500^96
 ;;^UTILITY(U,$J,358.3,10513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10513,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,10513,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,10513,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,10514,0)
 ;;=R93.0^^48^500^10
 ;;^UTILITY(U,$J,358.3,10514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10514,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,10514,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,10514,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,10515,0)
 ;;=R93.2^^48^500^9
 ;;^UTILITY(U,$J,358.3,10515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10515,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,10515,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,10515,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,10516,0)
 ;;=R93.3^^48^500^7
 ;;^UTILITY(U,$J,358.3,10516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10516,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,10516,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,10516,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,10517,0)
 ;;=R93.5^^48^500^6
 ;;^UTILITY(U,$J,358.3,10517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10517,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,10517,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,10517,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,10518,0)
 ;;=R93.6^^48^500^8
 ;;^UTILITY(U,$J,358.3,10518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10518,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,10518,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,10518,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,10519,0)
 ;;=R94.4^^48^500^19
 ;;^UTILITY(U,$J,358.3,10519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10519,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,10519,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,10519,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,10520,0)
 ;;=R94.5^^48^500^20
 ;;^UTILITY(U,$J,358.3,10520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10520,1,3,0)
 ;;=3^Abnormal Liver Function Studies
 ;;^UTILITY(U,$J,358.3,10520,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,10520,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,10521,0)
 ;;=R94.6^^48^500^24
 ;;^UTILITY(U,$J,358.3,10521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10521,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,10521,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,10521,2)
 ;;=^5019743
 ;;^UTILITY(U,$J,358.3,10522,0)
 ;;=R94.7^^48^500^5
 ;;^UTILITY(U,$J,358.3,10522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10522,1,3,0)
 ;;=3^Abnormal Endocrine Function Studies NEC
 ;;^UTILITY(U,$J,358.3,10522,1,4,0)
 ;;=4^R94.7
 ;;^UTILITY(U,$J,358.3,10522,2)
 ;;=^5019744
 ;;^UTILITY(U,$J,358.3,10523,0)
 ;;=R94.31^^48^500^4
 ;;^UTILITY(U,$J,358.3,10523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10523,1,3,0)
 ;;=3^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,10523,1,4,0)
 ;;=4^R94.31
 ;;^UTILITY(U,$J,358.3,10523,2)
 ;;=^5019739
 ;;^UTILITY(U,$J,358.3,10524,0)
 ;;=R97.0^^48^500^72
 ;;^UTILITY(U,$J,358.3,10524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10524,1,3,0)
 ;;=3^Elevated Carcinoembryonic Antigen 
 ;;^UTILITY(U,$J,358.3,10524,1,4,0)
 ;;=4^R97.0
 ;;^UTILITY(U,$J,358.3,10524,2)
 ;;=^5019746
 ;;^UTILITY(U,$J,358.3,10525,0)
 ;;=R97.1^^48^500^71
 ;;^UTILITY(U,$J,358.3,10525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10525,1,3,0)
 ;;=3^Elevated Cancer Antigen 125
 ;;^UTILITY(U,$J,358.3,10525,1,4,0)
 ;;=4^R97.1
 ;;^UTILITY(U,$J,358.3,10525,2)
 ;;=^5019747
 ;;^UTILITY(U,$J,358.3,10526,0)
 ;;=R97.8^^48^500^25
 ;;^UTILITY(U,$J,358.3,10526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10526,1,3,0)
 ;;=3^Abnormal Tumor Markers NEC
 ;;^UTILITY(U,$J,358.3,10526,1,4,0)
 ;;=4^R97.8
 ;;^UTILITY(U,$J,358.3,10526,2)
 ;;=^5019749
 ;;^UTILITY(U,$J,358.3,10527,0)
 ;;=R93.1^^48^500^17
 ;;^UTILITY(U,$J,358.3,10527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10527,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Heart/Cor Circ
 ;;^UTILITY(U,$J,358.3,10527,1,4,0)
 ;;=4^R93.1
 ;;^UTILITY(U,$J,358.3,10527,2)
 ;;=^5019714
 ;;^UTILITY(U,$J,358.3,10528,0)
 ;;=R68.83^^48^500^52
 ;;^UTILITY(U,$J,358.3,10528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10528,1,3,0)
 ;;=3^Chills w/o Fever
 ;;^UTILITY(U,$J,358.3,10528,1,4,0)
 ;;=4^R68.83
 ;;^UTILITY(U,$J,358.3,10528,2)
 ;;=^5019555
 ;;^UTILITY(U,$J,358.3,10529,0)
 ;;=R68.2^^48^500^67
 ;;^UTILITY(U,$J,358.3,10529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10529,1,3,0)
 ;;=3^Dry Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,10529,1,4,0)
 ;;=4^R68.2
 ;;^UTILITY(U,$J,358.3,10529,2)
 ;;=^5019552
 ;;^UTILITY(U,$J,358.3,10530,0)
 ;;=R09.02^^48^500^93
 ;;^UTILITY(U,$J,358.3,10530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10530,1,3,0)
 ;;=3^Hypoxemia
 ;;^UTILITY(U,$J,358.3,10530,1,4,0)
 ;;=4^R09.02
 ;;^UTILITY(U,$J,358.3,10530,2)
 ;;=^332831
 ;;^UTILITY(U,$J,358.3,10531,0)
 ;;=R39.81^^48^500^97
 ;;^UTILITY(U,$J,358.3,10531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10531,1,3,0)
 ;;=3^Incontinence d/t Cognitive Imprmt/Svr Disability/Mobility
 ;;^UTILITY(U,$J,358.3,10531,1,4,0)
 ;;=4^R39.81
 ;;^UTILITY(U,$J,358.3,10531,2)
 ;;=^5019349
 ;;^UTILITY(U,$J,358.3,10532,0)
 ;;=R29.6^^48^500^152
 ;;^UTILITY(U,$J,358.3,10532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10532,1,3,0)
 ;;=3^Repeated Falls
 ;;^UTILITY(U,$J,358.3,10532,1,4,0)
 ;;=4^R29.6
 ;;^UTILITY(U,$J,358.3,10532,2)
 ;;=^5019317
 ;;^UTILITY(U,$J,358.3,10533,0)
 ;;=R44.1^^48^500^167
 ;;^UTILITY(U,$J,358.3,10533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10533,1,3,0)
 ;;=3^Visual Hallucinations
 ;;^UTILITY(U,$J,358.3,10533,1,4,0)
 ;;=4^R44.1
 ;;^UTILITY(U,$J,358.3,10533,2)
 ;;=^5019456
 ;;^UTILITY(U,$J,358.3,10534,0)
 ;;=R93.422^^48^500^11
 ;;^UTILITY(U,$J,358.3,10534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10534,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Left Kidney
 ;;^UTILITY(U,$J,358.3,10534,1,4,0)
 ;;=4^R93.422
 ;;^UTILITY(U,$J,358.3,10534,2)
 ;;=^5139225
 ;;^UTILITY(U,$J,358.3,10535,0)
 ;;=R93.421^^48^500^14
 ;;^UTILITY(U,$J,358.3,10535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10535,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Right Kidney
 ;;^UTILITY(U,$J,358.3,10535,1,4,0)
 ;;=4^R93.421
 ;;^UTILITY(U,$J,358.3,10535,2)
 ;;=^5139224
 ;;^UTILITY(U,$J,358.3,10536,0)
 ;;=R93.49^^48^500^12
 ;;^UTILITY(U,$J,358.3,10536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10536,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Oth Urinary Organs
 ;;^UTILITY(U,$J,358.3,10536,1,4,0)
 ;;=4^R93.49
 ;;^UTILITY(U,$J,358.3,10536,2)
 ;;=^5139227
 ;;^UTILITY(U,$J,358.3,10537,0)
 ;;=R93.41^^48^500^13
 ;;^UTILITY(U,$J,358.3,10537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10537,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Renal Pelvis/Ureter/Bladder
 ;;^UTILITY(U,$J,358.3,10537,1,4,0)
 ;;=4^R93.41
 ;;^UTILITY(U,$J,358.3,10537,2)
 ;;=^5139223
 ;;^UTILITY(U,$J,358.3,10538,0)
 ;;=R97.20^^48^500^73
 ;;^UTILITY(U,$J,358.3,10538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10538,1,3,0)
 ;;=3^Elevated PSA
 ;;^UTILITY(U,$J,358.3,10538,1,4,0)
 ;;=4^R97.20
 ;;^UTILITY(U,$J,358.3,10538,2)
 ;;=^334262
 ;;^UTILITY(U,$J,358.3,10539,0)
 ;;=R97.21^^48^500^153
 ;;^UTILITY(U,$J,358.3,10539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10539,1,3,0)
 ;;=3^Rising PSA After Tx of Prostate CA
 ;;^UTILITY(U,$J,358.3,10539,1,4,0)
 ;;=4^R97.21
 ;;^UTILITY(U,$J,358.3,10539,2)
 ;;=^5139228
 ;;^UTILITY(U,$J,358.3,10540,0)
 ;;=K08.89^^48^500^64
 ;;^UTILITY(U,$J,358.3,10540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10540,1,3,0)
 ;;=3^Disorder of Teeth/Supporting Structures,Oth Specified
 ;;^UTILITY(U,$J,358.3,10540,1,4,0)
 ;;=4^K08.89
 ;;^UTILITY(U,$J,358.3,10540,2)
 ;;=^5008467
 ;;^UTILITY(U,$J,358.3,10541,0)
 ;;=R82.79^^48^500^31
 ;;^UTILITY(U,$J,358.3,10541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10541,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,10541,1,4,0)
 ;;=4^R82.79
 ;;^UTILITY(U,$J,358.3,10541,2)
 ;;=^5139222
 ;;^UTILITY(U,$J,358.3,10542,0)
 ;;=K08.9^^48^500^65
 ;;^UTILITY(U,$J,358.3,10542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10542,1,3,0)
 ;;=3^Disorder of Teeth/Supporting Structures,Unspec
 ;;^UTILITY(U,$J,358.3,10542,1,4,0)
 ;;=4^K08.9
 ;;^UTILITY(U,$J,358.3,10542,2)
 ;;=^5008468
 ;;^UTILITY(U,$J,358.3,10543,0)
 ;;=R93.89^^48^500^15
 ;;^UTILITY(U,$J,358.3,10543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10543,1,3,0)
 ;;=3^Abnormal Finding on Dx Imaging of Oth Body Structures
 ;;^UTILITY(U,$J,358.3,10543,1,4,0)
 ;;=4^R93.89
 ;;^UTILITY(U,$J,358.3,10543,2)
 ;;=^5157477
 ;;^UTILITY(U,$J,358.3,10544,0)
 ;;=R82.998^^48^500^28
 ;;^UTILITY(U,$J,358.3,10544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10544,1,3,0)
 ;;=3^Abnormal Urine Findings,Other
 ;;^UTILITY(U,$J,358.3,10544,1,4,0)
 ;;=4^R82.998
 ;;^UTILITY(U,$J,358.3,10544,2)
 ;;=^5157472
 ;;^UTILITY(U,$J,358.3,10545,0)
 ;;=R82.89^^48^500^27
 ;;^UTILITY(U,$J,358.3,10545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10545,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings,Other
 ;;^UTILITY(U,$J,358.3,10545,1,4,0)
 ;;=4^R82.89
 ;;^UTILITY(U,$J,358.3,10545,2)
 ;;=^5158142
 ;;^UTILITY(U,$J,358.3,10546,0)
 ;;=R82.81^^48^500^150
 ;;^UTILITY(U,$J,358.3,10546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10546,1,3,0)
 ;;=3^Pyuria
 ;;^UTILITY(U,$J,358.3,10546,1,4,0)
 ;;=4^R82.81
 ;;^UTILITY(U,$J,358.3,10546,2)
 ;;=^101879
 ;;^UTILITY(U,$J,358.3,10547,0)
 ;;=S43.51XA^^48^501^12
 ;;^UTILITY(U,$J,358.3,10547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10547,1,3,0)
 ;;=3^Sprain of Right Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,10547,1,4,0)
 ;;=4^S43.51XA
 ;;^UTILITY(U,$J,358.3,10547,2)
 ;;=^5027903
 ;;^UTILITY(U,$J,358.3,10548,0)
 ;;=S43.52XA^^48^501^1
 ;;^UTILITY(U,$J,358.3,10548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10548,1,3,0)
 ;;=3^Sprain of Left Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,10548,1,4,0)
 ;;=4^S43.52XA
 ;;^UTILITY(U,$J,358.3,10548,2)
 ;;=^5027906
 ;;^UTILITY(U,$J,358.3,10549,0)
 ;;=S43.421A^^48^501^17
 ;;^UTILITY(U,$J,358.3,10549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10549,1,3,0)
 ;;=3^Sprain of Right Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,10549,1,4,0)
 ;;=4^S43.421A
 ;;^UTILITY(U,$J,358.3,10549,2)
 ;;=^5027879
 ;;^UTILITY(U,$J,358.3,10550,0)
 ;;=S43.422A^^48^501^6
 ;;^UTILITY(U,$J,358.3,10550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10550,1,3,0)
 ;;=3^Sprain of Left Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,10550,1,4,0)
 ;;=4^S43.422A
 ;;^UTILITY(U,$J,358.3,10550,2)
 ;;=^5027882
 ;;^UTILITY(U,$J,358.3,10551,0)
 ;;=S53.401A^^48^501^14
 ;;^UTILITY(U,$J,358.3,10551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10551,1,3,0)
 ;;=3^Sprain of Right Elbow
 ;;^UTILITY(U,$J,358.3,10551,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,10551,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,10552,0)
 ;;=S53.402A^^48^501^3
 ;;^UTILITY(U,$J,358.3,10552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10552,1,3,0)
 ;;=3^Sprain of Left Elbow
 ;;^UTILITY(U,$J,358.3,10552,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,10552,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,10553,0)
 ;;=S56.011A^^48^501^55
 ;;^UTILITY(U,$J,358.3,10553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10553,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,10553,1,4,0)
 ;;=4^S56.011A
 ;;^UTILITY(U,$J,358.3,10553,2)
 ;;=^5031568
 ;;^UTILITY(U,$J,358.3,10554,0)
 ;;=S56.012A^^48^501^36
 ;;^UTILITY(U,$J,358.3,10554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10554,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,10554,1,4,0)
 ;;=4^S56.012A
 ;;^UTILITY(U,$J,358.3,10554,2)
 ;;=^5031571
 ;;^UTILITY(U,$J,358.3,10555,0)
 ;;=S56.111A^^48^501^43
 ;;^UTILITY(U,$J,358.3,10555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10555,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,10555,1,4,0)
 ;;=4^S56.111A
 ;;^UTILITY(U,$J,358.3,10555,2)
 ;;=^5031616
 ;;^UTILITY(U,$J,358.3,10556,0)
 ;;=S56.112A^^48^501^23
 ;;^UTILITY(U,$J,358.3,10556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10556,1,3,0)
 ;;=3^Strain of Left Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,10556,1,4,0)
 ;;=4^S56.112A
 ;;^UTILITY(U,$J,358.3,10556,2)
 ;;=^5031619
 ;;^UTILITY(U,$J,358.3,10557,0)
 ;;=S56.113A^^48^501^51
 ;;^UTILITY(U,$J,358.3,10557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10557,1,3,0)
 ;;=3^Strain of Right Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,10557,1,4,0)
 ;;=4^S56.113A
 ;;^UTILITY(U,$J,358.3,10557,2)
 ;;=^5031622
 ;;^UTILITY(U,$J,358.3,10558,0)
 ;;=S56.114A^^48^501^31
 ;;^UTILITY(U,$J,358.3,10558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10558,1,3,0)
 ;;=3^Strain of Left Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,10558,1,4,0)
 ;;=4^S56.114A
 ;;^UTILITY(U,$J,358.3,10558,2)
 ;;=^5031625
 ;;^UTILITY(U,$J,358.3,10559,0)
 ;;=S56.115A^^48^501^53
 ;;^UTILITY(U,$J,358.3,10559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10559,1,3,0)
 ;;=3^Strain of Right Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,10559,1,4,0)
 ;;=4^S56.115A
 ;;^UTILITY(U,$J,358.3,10559,2)
 ;;=^5031628
 ;;^UTILITY(U,$J,358.3,10560,0)
 ;;=S56.417A^^48^501^45
 ;;^UTILITY(U,$J,358.3,10560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10560,1,3,0)
 ;;=3^Strain of Right Little Finger at Forearm Level Extn Musc/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,10560,1,4,0)
 ;;=4^S56.417A
 ;;^UTILITY(U,$J,358.3,10560,2)
 ;;=^5031781
 ;;^UTILITY(U,$J,358.3,10561,0)
 ;;=S56.418A^^48^501^25
 ;;^UTILITY(U,$J,358.3,10561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10561,1,3,0)
 ;;=3^Strain of Left Little Finger at Forearm Level Extn Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,10561,1,4,0)
 ;;=4^S56.418A
 ;;^UTILITY(U,$J,358.3,10561,2)
 ;;=^5031784
 ;;^UTILITY(U,$J,358.3,10562,0)
 ;;=S56.811A^^48^501^41
 ;;^UTILITY(U,$J,358.3,10562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10562,1,3,0)
 ;;=3^Strain of Right Forearm Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,10562,1,4,0)
 ;;=4^S56.811A
 ;;^UTILITY(U,$J,358.3,10562,2)
 ;;=^5031862
 ;;^UTILITY(U,$J,358.3,10563,0)
 ;;=S56.812A^^48^501^21
