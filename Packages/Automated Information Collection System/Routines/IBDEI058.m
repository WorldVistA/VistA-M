IBDEI058 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6462,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,6462,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,6462,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,6463,0)
 ;;=C92.10^^26^402^48
 ;;^UTILITY(U,$J,358.3,6463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6463,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,6463,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,6463,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,6464,0)
 ;;=D47.1^^26^402^49
 ;;^UTILITY(U,$J,358.3,6464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6464,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,6464,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,6464,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,6465,0)
 ;;=C82.69^^26^402^50
 ;;^UTILITY(U,$J,358.3,6465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6465,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6465,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,6465,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,6466,0)
 ;;=C82.60^^26^402^51
 ;;^UTILITY(U,$J,358.3,6466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6466,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,6466,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,6466,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,6467,0)
 ;;=D56.2^^26^402^52
 ;;^UTILITY(U,$J,358.3,6467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6467,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,6467,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,6467,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,6468,0)
 ;;=D75.9^^26^402^53
 ;;^UTILITY(U,$J,358.3,6468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6468,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,6468,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,6468,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,6469,0)
 ;;=D59.0^^26^402^56
 ;;^UTILITY(U,$J,358.3,6469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6469,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,6469,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,6469,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,6470,0)
 ;;=D59.2^^26^402^57
 ;;^UTILITY(U,$J,358.3,6470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6470,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,6470,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,6470,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,6471,0)
 ;;=R59.9^^26^402^60
 ;;^UTILITY(U,$J,358.3,6471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6471,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,6471,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,6471,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,6472,0)
 ;;=D47.3^^26^402^61
 ;;^UTILITY(U,$J,358.3,6472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6472,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,6472,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,6472,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,6473,0)
 ;;=C82.09^^26^402^62
 ;;^UTILITY(U,$J,358.3,6473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6473,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6473,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,6473,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,6474,0)
 ;;=C82.00^^26^402^63
 ;;^UTILITY(U,$J,358.3,6474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6474,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,6474,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,6474,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,6475,0)
 ;;=C82.19^^26^402^64
 ;;^UTILITY(U,$J,358.3,6475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6475,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6475,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,6475,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,6476,0)
 ;;=C82.10^^26^402^65
 ;;^UTILITY(U,$J,358.3,6476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6476,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,6476,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,6476,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,6477,0)
 ;;=C82.29^^26^402^66
 ;;^UTILITY(U,$J,358.3,6477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6477,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6477,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,6477,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,6478,0)
 ;;=C82.20^^26^402^67
 ;;^UTILITY(U,$J,358.3,6478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6478,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,6478,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,6478,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,6479,0)
 ;;=C82.39^^26^402^68
 ;;^UTILITY(U,$J,358.3,6479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6479,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6479,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,6479,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,6480,0)
 ;;=C82.30^^26^402^69
 ;;^UTILITY(U,$J,358.3,6480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6480,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
 ;;^UTILITY(U,$J,358.3,6480,1,4,0)
 ;;=4^C82.30
 ;;^UTILITY(U,$J,358.3,6480,2)
 ;;=^5001491
 ;;^UTILITY(U,$J,358.3,6481,0)
 ;;=C82.49^^26^402^70
 ;;^UTILITY(U,$J,358.3,6481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6481,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6481,1,4,0)
 ;;=4^C82.49
 ;;^UTILITY(U,$J,358.3,6481,2)
 ;;=^5001510
 ;;^UTILITY(U,$J,358.3,6482,0)
 ;;=C82.40^^26^402^71
 ;;^UTILITY(U,$J,358.3,6482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6482,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Unspec Site
 ;;^UTILITY(U,$J,358.3,6482,1,4,0)
 ;;=4^C82.40
 ;;^UTILITY(U,$J,358.3,6482,2)
 ;;=^5001501
 ;;^UTILITY(U,$J,358.3,6483,0)
 ;;=C82.99^^26^402^72
 ;;^UTILITY(U,$J,358.3,6483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6483,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6483,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,6483,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,6484,0)
 ;;=C82.90^^26^402^73
 ;;^UTILITY(U,$J,358.3,6484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6484,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,6484,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,6484,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,6485,0)
 ;;=R59.1^^26^402^58
 ;;^UTILITY(U,$J,358.3,6485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6485,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Generalized
 ;;^UTILITY(U,$J,358.3,6485,1,4,0)
 ;;=4^R59.1
 ;;^UTILITY(U,$J,358.3,6485,2)
 ;;=^5019530
 ;;^UTILITY(U,$J,358.3,6486,0)
 ;;=C91.40^^26^402^77
 ;;^UTILITY(U,$J,358.3,6486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6486,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,6486,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,6486,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,6487,0)
 ;;=C91.42^^26^402^75
 ;;^UTILITY(U,$J,358.3,6487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6487,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,6487,1,4,0)
 ;;=4^C91.42
 ;;^UTILITY(U,$J,358.3,6487,2)
 ;;=^5001773
 ;;^UTILITY(U,$J,358.3,6488,0)
 ;;=C91.41^^26^402^76
 ;;^UTILITY(U,$J,358.3,6488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6488,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,6488,1,4,0)
 ;;=4^C91.41
 ;;^UTILITY(U,$J,358.3,6488,2)
 ;;=^5001772
 ;;^UTILITY(U,$J,358.3,6489,0)
 ;;=D57.01^^26^402^78
 ;;^UTILITY(U,$J,358.3,6489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6489,1,3,0)
 ;;=3^Hb-SS Disease w/ Acute Chest Syndrome
 ;;^UTILITY(U,$J,358.3,6489,1,4,0)
 ;;=4^D57.01
 ;;^UTILITY(U,$J,358.3,6489,2)
 ;;=^5002307
 ;;^UTILITY(U,$J,358.3,6490,0)
 ;;=D57.00^^26^402^79
 ;;^UTILITY(U,$J,358.3,6490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6490,1,3,0)
 ;;=3^Hb-SS Disease w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,6490,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,6490,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,6491,0)
 ;;=D57.02^^26^402^80
 ;;^UTILITY(U,$J,358.3,6491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6491,1,3,0)
 ;;=3^Hb-SS Disease w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,6491,1,4,0)
 ;;=4^D57.02
 ;;^UTILITY(U,$J,358.3,6491,2)
 ;;=^5002308
 ;;^UTILITY(U,$J,358.3,6492,0)
 ;;=D68.32^^26^402^82
 ;;^UTILITY(U,$J,358.3,6492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6492,1,3,0)
 ;;=3^Hemorrhagic Disorder d/t Extrinsic Circulating Anticoagulants
 ;;^UTILITY(U,$J,358.3,6492,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,6492,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,6493,0)
 ;;=C22.2^^26^402^83
 ;;^UTILITY(U,$J,358.3,6493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6493,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,6493,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,6493,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,6494,0)
 ;;=D58.9^^26^402^85
 ;;^UTILITY(U,$J,358.3,6494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6494,1,3,0)
 ;;=3^Hereditary Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,6494,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,6494,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,6495,0)
 ;;=C81.99^^26^402^86
 ;;^UTILITY(U,$J,358.3,6495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6495,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6495,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,6495,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,6496,0)
 ;;=C81.90^^26^402^87
 ;;^UTILITY(U,$J,358.3,6496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6496,1,3,0)
 ;;=3^Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,6496,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,6496,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,6497,0)
 ;;=D89.2^^26^402^88
 ;;^UTILITY(U,$J,358.3,6497,1,0)
 ;;=^358.31IA^4^2
