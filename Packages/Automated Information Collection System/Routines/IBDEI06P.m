IBDEI06P ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16261,0)
 ;;=R82.91^^56^656^52
 ;;^UTILITY(U,$J,358.3,16261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16261,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,16261,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,16261,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,16262,0)
 ;;=R89.9^^56^656^22
 ;;^UTILITY(U,$J,358.3,16262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16262,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,16262,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,16262,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,16263,0)
 ;;=R90.0^^56^656^102
 ;;^UTILITY(U,$J,358.3,16263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16263,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,16263,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,16263,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,16264,0)
 ;;=R90.89^^56^656^16
 ;;^UTILITY(U,$J,358.3,16264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16264,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,16264,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,16264,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,16265,0)
 ;;=R91.8^^56^656^21
 ;;^UTILITY(U,$J,358.3,16265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16265,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,16265,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,16265,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,16266,0)
 ;;=R92.0^^56^656^121
 ;;^UTILITY(U,$J,358.3,16266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16266,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,16266,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,16266,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,16267,0)
 ;;=R92.1^^56^656^120
 ;;^UTILITY(U,$J,358.3,16267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16267,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,16267,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,16267,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,16268,0)
 ;;=R92.2^^56^656^95
 ;;^UTILITY(U,$J,358.3,16268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16268,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,16268,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,16268,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,16269,0)
 ;;=R93.0^^56^656^10
 ;;^UTILITY(U,$J,358.3,16269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16269,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,16269,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,16269,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,16270,0)
 ;;=R93.2^^56^656^9
 ;;^UTILITY(U,$J,358.3,16270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16270,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,16270,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,16270,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,16271,0)
 ;;=R93.3^^56^656^7
 ;;^UTILITY(U,$J,358.3,16271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16271,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,16271,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,16271,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,16272,0)
 ;;=R93.5^^56^656^6
 ;;^UTILITY(U,$J,358.3,16272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16272,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,16272,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,16272,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,16273,0)
 ;;=R93.6^^56^656^8
 ;;^UTILITY(U,$J,358.3,16273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16273,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,16273,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,16273,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,16274,0)
 ;;=R94.4^^56^656^19
 ;;^UTILITY(U,$J,358.3,16274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16274,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,16274,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,16274,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,16275,0)
 ;;=R94.5^^56^656^20
 ;;^UTILITY(U,$J,358.3,16275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16275,1,3,0)
 ;;=3^Abnormal Liver Function Studies
 ;;^UTILITY(U,$J,358.3,16275,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,16275,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,16276,0)
 ;;=R94.6^^56^656^24
 ;;^UTILITY(U,$J,358.3,16276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16276,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,16276,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,16276,2)
 ;;=^5019743
 ;;^UTILITY(U,$J,358.3,16277,0)
 ;;=R94.7^^56^656^5
 ;;^UTILITY(U,$J,358.3,16277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16277,1,3,0)
 ;;=3^Abnormal Endocrine Function Studies NEC
 ;;^UTILITY(U,$J,358.3,16277,1,4,0)
 ;;=4^R94.7
 ;;^UTILITY(U,$J,358.3,16277,2)
 ;;=^5019744
 ;;^UTILITY(U,$J,358.3,16278,0)
 ;;=R94.31^^56^656^4
 ;;^UTILITY(U,$J,358.3,16278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16278,1,3,0)
 ;;=3^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,16278,1,4,0)
 ;;=4^R94.31
 ;;^UTILITY(U,$J,358.3,16278,2)
 ;;=^5019739
 ;;^UTILITY(U,$J,358.3,16279,0)
 ;;=R97.0^^56^656^71
 ;;^UTILITY(U,$J,358.3,16279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16279,1,3,0)
 ;;=3^Elevated Carcinoembryonic Antigen 
 ;;^UTILITY(U,$J,358.3,16279,1,4,0)
 ;;=4^R97.0
 ;;^UTILITY(U,$J,358.3,16279,2)
 ;;=^5019746
 ;;^UTILITY(U,$J,358.3,16280,0)
 ;;=R97.1^^56^656^70
 ;;^UTILITY(U,$J,358.3,16280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16280,1,3,0)
 ;;=3^Elevated Cancer Antigen 125
 ;;^UTILITY(U,$J,358.3,16280,1,4,0)
 ;;=4^R97.1
 ;;^UTILITY(U,$J,358.3,16280,2)
 ;;=^5019747
 ;;^UTILITY(U,$J,358.3,16281,0)
 ;;=R97.8^^56^656^25
 ;;^UTILITY(U,$J,358.3,16281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16281,1,3,0)
 ;;=3^Abnormal Tumor Markers NEC
 ;;^UTILITY(U,$J,358.3,16281,1,4,0)
 ;;=4^R97.8
 ;;^UTILITY(U,$J,358.3,16281,2)
 ;;=^5019749
 ;;^UTILITY(U,$J,358.3,16282,0)
 ;;=R93.1^^56^656^17
 ;;^UTILITY(U,$J,358.3,16282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16282,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Heart/Cor Circ
 ;;^UTILITY(U,$J,358.3,16282,1,4,0)
 ;;=4^R93.1
 ;;^UTILITY(U,$J,358.3,16282,2)
 ;;=^5019714
 ;;^UTILITY(U,$J,358.3,16283,0)
 ;;=R68.83^^56^656^51
 ;;^UTILITY(U,$J,358.3,16283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16283,1,3,0)
 ;;=3^Chills w/o Fever
 ;;^UTILITY(U,$J,358.3,16283,1,4,0)
 ;;=4^R68.83
 ;;^UTILITY(U,$J,358.3,16283,2)
 ;;=^5019555
 ;;^UTILITY(U,$J,358.3,16284,0)
 ;;=R68.2^^56^656^66
 ;;^UTILITY(U,$J,358.3,16284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16284,1,3,0)
 ;;=3^Dry Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,16284,1,4,0)
 ;;=4^R68.2
 ;;^UTILITY(U,$J,358.3,16284,2)
 ;;=^5019552
 ;;^UTILITY(U,$J,358.3,16285,0)
 ;;=R09.02^^56^656^92
 ;;^UTILITY(U,$J,358.3,16285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16285,1,3,0)
 ;;=3^Hypoxemia
 ;;^UTILITY(U,$J,358.3,16285,1,4,0)
 ;;=4^R09.02
 ;;^UTILITY(U,$J,358.3,16285,2)
 ;;=^332831
 ;;^UTILITY(U,$J,358.3,16286,0)
 ;;=R39.81^^56^656^96
 ;;^UTILITY(U,$J,358.3,16286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16286,1,3,0)
 ;;=3^Incontinence d/t Cognitive Imprmt/Svr Disability/Mobility
 ;;^UTILITY(U,$J,358.3,16286,1,4,0)
 ;;=4^R39.81
 ;;^UTILITY(U,$J,358.3,16286,2)
 ;;=^5019349
 ;;^UTILITY(U,$J,358.3,16287,0)
 ;;=R29.6^^56^656^151
 ;;^UTILITY(U,$J,358.3,16287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16287,1,3,0)
 ;;=3^Repeated Falls
 ;;^UTILITY(U,$J,358.3,16287,1,4,0)
 ;;=4^R29.6
 ;;^UTILITY(U,$J,358.3,16287,2)
 ;;=^5019317
 ;;^UTILITY(U,$J,358.3,16288,0)
 ;;=R44.1^^56^656^166
 ;;^UTILITY(U,$J,358.3,16288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16288,1,3,0)
 ;;=3^Visual Hallucinations
 ;;^UTILITY(U,$J,358.3,16288,1,4,0)
 ;;=4^R44.1
 ;;^UTILITY(U,$J,358.3,16288,2)
 ;;=^5019456
 ;;^UTILITY(U,$J,358.3,16289,0)
 ;;=R93.422^^56^656^11
 ;;^UTILITY(U,$J,358.3,16289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16289,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Left Kidney
 ;;^UTILITY(U,$J,358.3,16289,1,4,0)
 ;;=4^R93.422
 ;;^UTILITY(U,$J,358.3,16289,2)
 ;;=^5139225
 ;;^UTILITY(U,$J,358.3,16290,0)
 ;;=R93.421^^56^656^14
 ;;^UTILITY(U,$J,358.3,16290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16290,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Right Kidney
 ;;^UTILITY(U,$J,358.3,16290,1,4,0)
 ;;=4^R93.421
 ;;^UTILITY(U,$J,358.3,16290,2)
 ;;=^5139224
 ;;^UTILITY(U,$J,358.3,16291,0)
 ;;=R93.49^^56^656^12
 ;;^UTILITY(U,$J,358.3,16291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16291,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Oth Urinary Organs
 ;;^UTILITY(U,$J,358.3,16291,1,4,0)
 ;;=4^R93.49
 ;;^UTILITY(U,$J,358.3,16291,2)
 ;;=^5139227
 ;;^UTILITY(U,$J,358.3,16292,0)
 ;;=R93.41^^56^656^13
 ;;^UTILITY(U,$J,358.3,16292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16292,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Renal Pelvis/Ureter/Bladder
 ;;^UTILITY(U,$J,358.3,16292,1,4,0)
 ;;=4^R93.41
 ;;^UTILITY(U,$J,358.3,16292,2)
 ;;=^5139223
 ;;^UTILITY(U,$J,358.3,16293,0)
 ;;=R97.20^^56^656^72
 ;;^UTILITY(U,$J,358.3,16293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16293,1,3,0)
 ;;=3^Elevated PSA
 ;;^UTILITY(U,$J,358.3,16293,1,4,0)
 ;;=4^R97.20
 ;;^UTILITY(U,$J,358.3,16293,2)
 ;;=^334262
 ;;^UTILITY(U,$J,358.3,16294,0)
 ;;=R97.21^^56^656^152
 ;;^UTILITY(U,$J,358.3,16294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16294,1,3,0)
 ;;=3^Rising PSA After Tx of Prostate CA
 ;;^UTILITY(U,$J,358.3,16294,1,4,0)
 ;;=4^R97.21
 ;;^UTILITY(U,$J,358.3,16294,2)
 ;;=^5139228
 ;;^UTILITY(U,$J,358.3,16295,0)
 ;;=K08.89^^56^656^63
 ;;^UTILITY(U,$J,358.3,16295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16295,1,3,0)
 ;;=3^Disorder of Teeth/Supporting Structures,Oth Specified
 ;;^UTILITY(U,$J,358.3,16295,1,4,0)
 ;;=4^K08.89
 ;;^UTILITY(U,$J,358.3,16295,2)
 ;;=^5008467
 ;;^UTILITY(U,$J,358.3,16296,0)
 ;;=R82.79^^56^656^30
 ;;^UTILITY(U,$J,358.3,16296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16296,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,16296,1,4,0)
 ;;=4^R82.79
 ;;^UTILITY(U,$J,358.3,16296,2)
 ;;=^5139222
 ;;^UTILITY(U,$J,358.3,16297,0)
 ;;=K08.9^^56^656^64
 ;;^UTILITY(U,$J,358.3,16297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16297,1,3,0)
 ;;=3^Disorder of Teeth/Supporting Structures,Unspec
 ;;^UTILITY(U,$J,358.3,16297,1,4,0)
 ;;=4^K08.9
 ;;^UTILITY(U,$J,358.3,16297,2)
 ;;=^5008468
 ;;^UTILITY(U,$J,358.3,16298,0)
 ;;=R93.89^^56^656^15
 ;;^UTILITY(U,$J,358.3,16298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16298,1,3,0)
 ;;=3^Abnormal Finding on Dx Imaging of Oth Body Structures
 ;;^UTILITY(U,$J,358.3,16298,1,4,0)
 ;;=4^R93.89
 ;;^UTILITY(U,$J,358.3,16298,2)
 ;;=^5157477
 ;;^UTILITY(U,$J,358.3,16299,0)
 ;;=R82.998^^56^656^27
 ;;^UTILITY(U,$J,358.3,16299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16299,1,3,0)
 ;;=3^Abnormal Urine Findings,Other
 ;;^UTILITY(U,$J,358.3,16299,1,4,0)
 ;;=4^R82.998
 ;;^UTILITY(U,$J,358.3,16299,2)
 ;;=^5157472
 ;;^UTILITY(U,$J,358.3,16300,0)
 ;;=R82.89^^56^656^26
 ;;^UTILITY(U,$J,358.3,16300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16300,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings,Other
 ;;^UTILITY(U,$J,358.3,16300,1,4,0)
 ;;=4^R82.89
 ;;^UTILITY(U,$J,358.3,16300,2)
 ;;=^5158142
 ;;^UTILITY(U,$J,358.3,16301,0)
 ;;=R82.81^^56^656^149
 ;;^UTILITY(U,$J,358.3,16301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16301,1,3,0)
 ;;=3^Pyuria
 ;;^UTILITY(U,$J,358.3,16301,1,4,0)
 ;;=4^R82.81
 ;;^UTILITY(U,$J,358.3,16301,2)
 ;;=^101879
 ;;^UTILITY(U,$J,358.3,16302,0)
 ;;=R35.89^^56^656^144
 ;;^UTILITY(U,$J,358.3,16302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16302,1,3,0)
 ;;=3^Polyuria,Other
 ;;^UTILITY(U,$J,358.3,16302,1,4,0)
 ;;=4^R35.89
 ;;^UTILITY(U,$J,358.3,16302,2)
 ;;=^5161234
 ;;^UTILITY(U,$J,358.3,16303,0)
 ;;=R63.30^^56^656^76
 ;;^UTILITY(U,$J,358.3,16303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16303,1,3,0)
 ;;=3^Feeding Difficulties,Unspec
 ;;^UTILITY(U,$J,358.3,16303,1,4,0)
 ;;=4^R63.30
 ;;^UTILITY(U,$J,358.3,16303,2)
 ;;=^5161236
 ;;^UTILITY(U,$J,358.3,16304,0)
 ;;=S43.51XA^^56^657^14
 ;;^UTILITY(U,$J,358.3,16304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16304,1,3,0)
 ;;=3^Sprain of Right Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,16304,1,4,0)
 ;;=4^S43.51XA
 ;;^UTILITY(U,$J,358.3,16304,2)
 ;;=^5027903
 ;;^UTILITY(U,$J,358.3,16305,0)
 ;;=S43.52XA^^56^657^5
 ;;^UTILITY(U,$J,358.3,16305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16305,1,3,0)
 ;;=3^Sprain of Left Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,16305,1,4,0)
 ;;=4^S43.52XA
 ;;^UTILITY(U,$J,358.3,16305,2)
 ;;=^5027906
 ;;^UTILITY(U,$J,358.3,16306,0)
 ;;=S43.421A^^56^657^19
 ;;^UTILITY(U,$J,358.3,16306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16306,1,3,0)
 ;;=3^Sprain of Right Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,16306,1,4,0)
 ;;=4^S43.421A
 ;;^UTILITY(U,$J,358.3,16306,2)
 ;;=^5027879
 ;;^UTILITY(U,$J,358.3,16307,0)
 ;;=S43.422A^^56^657^10
 ;;^UTILITY(U,$J,358.3,16307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16307,1,3,0)
 ;;=3^Sprain of Left Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,16307,1,4,0)
 ;;=4^S43.422A
 ;;^UTILITY(U,$J,358.3,16307,2)
 ;;=^5027882
 ;;^UTILITY(U,$J,358.3,16308,0)
 ;;=S53.401A^^56^657^16
 ;;^UTILITY(U,$J,358.3,16308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16308,1,3,0)
 ;;=3^Sprain of Right Elbow
 ;;^UTILITY(U,$J,358.3,16308,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,16308,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,16309,0)
 ;;=S53.402A^^56^657^7
 ;;^UTILITY(U,$J,358.3,16309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16309,1,3,0)
 ;;=3^Sprain of Left Elbow
 ;;^UTILITY(U,$J,358.3,16309,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,16309,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,16310,0)
 ;;=S56.011A^^56^657^56
 ;;^UTILITY(U,$J,358.3,16310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16310,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16310,1,4,0)
 ;;=4^S56.011A
 ;;^UTILITY(U,$J,358.3,16310,2)
 ;;=^5031568
 ;;^UTILITY(U,$J,358.3,16311,0)
 ;;=S56.012A^^56^657^38
 ;;^UTILITY(U,$J,358.3,16311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16311,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16311,1,4,0)
 ;;=4^S56.012A
 ;;^UTILITY(U,$J,358.3,16311,2)
 ;;=^5031571
 ;;^UTILITY(U,$J,358.3,16312,0)
 ;;=S56.111A^^56^657^44
 ;;^UTILITY(U,$J,358.3,16312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16312,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16312,1,4,0)
 ;;=4^S56.111A
 ;;^UTILITY(U,$J,358.3,16312,2)
 ;;=^5031616
 ;;^UTILITY(U,$J,358.3,16313,0)
 ;;=S56.112A^^56^657^25
 ;;^UTILITY(U,$J,358.3,16313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16313,1,3,0)
 ;;=3^Strain of Left Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16313,1,4,0)
 ;;=4^S56.112A
 ;;^UTILITY(U,$J,358.3,16313,2)
 ;;=^5031619
 ;;^UTILITY(U,$J,358.3,16314,0)
 ;;=S56.113A^^56^657^52
 ;;^UTILITY(U,$J,358.3,16314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16314,1,3,0)
 ;;=3^Strain of Right Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16314,1,4,0)
 ;;=4^S56.113A
 ;;^UTILITY(U,$J,358.3,16314,2)
 ;;=^5031622
 ;;^UTILITY(U,$J,358.3,16315,0)
 ;;=S56.114A^^56^657^33
 ;;^UTILITY(U,$J,358.3,16315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16315,1,3,0)
 ;;=3^Strain of Left Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16315,1,4,0)
 ;;=4^S56.114A
 ;;^UTILITY(U,$J,358.3,16315,2)
 ;;=^5031625
 ;;^UTILITY(U,$J,358.3,16316,0)
 ;;=S56.115A^^56^657^54
 ;;^UTILITY(U,$J,358.3,16316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16316,1,3,0)
 ;;=3^Strain of Right Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16316,1,4,0)
 ;;=4^S56.115A
 ;;^UTILITY(U,$J,358.3,16316,2)
 ;;=^5031628
 ;;^UTILITY(U,$J,358.3,16317,0)
 ;;=S56.417A^^56^657^46
 ;;^UTILITY(U,$J,358.3,16317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16317,1,3,0)
 ;;=3^Strain of Right Little Finger at Forearm Level Extn Musc/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16317,1,4,0)
 ;;=4^S56.417A
 ;;^UTILITY(U,$J,358.3,16317,2)
 ;;=^5031781
 ;;^UTILITY(U,$J,358.3,16318,0)
 ;;=S56.418A^^56^657^27
 ;;^UTILITY(U,$J,358.3,16318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16318,1,3,0)
 ;;=3^Strain of Left Little Finger at Forearm Level Extn Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16318,1,4,0)
 ;;=4^S56.418A
 ;;^UTILITY(U,$J,358.3,16318,2)
 ;;=^5031784
 ;;^UTILITY(U,$J,358.3,16319,0)
 ;;=S56.811A^^56^657^42
 ;;^UTILITY(U,$J,358.3,16319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16319,1,3,0)
 ;;=3^Strain of Right Forearm Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16319,1,4,0)
 ;;=4^S56.811A
 ;;^UTILITY(U,$J,358.3,16319,2)
 ;;=^5031862
 ;;^UTILITY(U,$J,358.3,16320,0)
 ;;=S56.812A^^56^657^23
 ;;^UTILITY(U,$J,358.3,16320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16320,1,3,0)
 ;;=3^Strain of Left Forearm Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16320,1,4,0)
 ;;=4^S56.812A
 ;;^UTILITY(U,$J,358.3,16320,2)
 ;;=^5031865
 ;;^UTILITY(U,$J,358.3,16321,0)
 ;;=S56.116A^^56^657^35
 ;;^UTILITY(U,$J,358.3,16321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16321,1,3,0)
 ;;=3^Strain of Left Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16321,1,4,0)
 ;;=4^S56.116A
 ;;^UTILITY(U,$J,358.3,16321,2)
 ;;=^5031631
 ;;^UTILITY(U,$J,358.3,16322,0)
 ;;=S56.117A^^56^657^47
 ;;^UTILITY(U,$J,358.3,16322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16322,1,3,0)
 ;;=3^Strain of Right Little Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16322,1,4,0)
 ;;=4^S56.117A
 ;;^UTILITY(U,$J,358.3,16322,2)
 ;;=^5031634
 ;;^UTILITY(U,$J,358.3,16323,0)
 ;;=S56.118A^^56^657^28
 ;;^UTILITY(U,$J,358.3,16323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16323,1,3,0)
 ;;=3^Strain of Left Little Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16323,1,4,0)
 ;;=4^S56.118A
 ;;^UTILITY(U,$J,358.3,16323,2)
 ;;=^5031637
 ;;^UTILITY(U,$J,358.3,16324,0)
 ;;=S56.211A^^56^657^41
 ;;^UTILITY(U,$J,358.3,16324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16324,1,3,0)
 ;;=3^Strain of Right Forearm Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16324,1,4,0)
 ;;=4^S56.211A
 ;;^UTILITY(U,$J,358.3,16324,2)
 ;;=^5031691
 ;;^UTILITY(U,$J,358.3,16325,0)
 ;;=S56.212A^^56^657^22
 ;;^UTILITY(U,$J,358.3,16325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16325,1,3,0)
 ;;=3^Strain of Left Forearm Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16325,1,4,0)
 ;;=4^S56.212A
 ;;^UTILITY(U,$J,358.3,16325,2)
 ;;=^5031694
 ;;^UTILITY(U,$J,358.3,16326,0)
 ;;=S56.311A^^56^657^57
 ;;^UTILITY(U,$J,358.3,16326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16326,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Extn/Abdr Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,16326,1,4,0)
 ;;=4^S56.311A
