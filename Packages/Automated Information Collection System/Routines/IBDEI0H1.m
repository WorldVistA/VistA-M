IBDEI0H1 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21581,0)
 ;;=C83.70^^58^840^32
 ;;^UTILITY(U,$J,358.3,21581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21581,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,21581,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,21581,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,21582,0)
 ;;=D09.0^^58^840^39
 ;;^UTILITY(U,$J,358.3,21582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21582,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,21582,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,21582,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,21583,0)
 ;;=D06.9^^58^840^40
 ;;^UTILITY(U,$J,358.3,21583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21583,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,21583,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,21583,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,21584,0)
 ;;=D06.0^^58^840^42
 ;;^UTILITY(U,$J,358.3,21584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21584,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,21584,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,21584,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,21585,0)
 ;;=D06.1^^58^840^43
 ;;^UTILITY(U,$J,358.3,21585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21585,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,21585,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,21585,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,21586,0)
 ;;=D06.7^^58^840^41
 ;;^UTILITY(U,$J,358.3,21586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21586,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,21586,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,21586,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,21587,0)
 ;;=D04.9^^58^840^44
 ;;^UTILITY(U,$J,358.3,21587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21587,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,21587,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,21587,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,21588,0)
 ;;=C91.11^^58^840^47
 ;;^UTILITY(U,$J,358.3,21588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21588,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,21588,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,21588,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,21589,0)
 ;;=C91.10^^58^840^48
 ;;^UTILITY(U,$J,358.3,21589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21589,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,21589,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,21589,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,21590,0)
 ;;=C92.11^^58^840^49
 ;;^UTILITY(U,$J,358.3,21590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21590,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,21590,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,21590,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,21591,0)
 ;;=C92.10^^58^840^50
 ;;^UTILITY(U,$J,358.3,21591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21591,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,21591,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,21591,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,21592,0)
 ;;=D47.1^^58^840^51
 ;;^UTILITY(U,$J,358.3,21592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21592,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,21592,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,21592,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,21593,0)
 ;;=C82.69^^58^840^52
 ;;^UTILITY(U,$J,358.3,21593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21593,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,21593,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,21593,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,21594,0)
 ;;=C82.60^^58^840^53
 ;;^UTILITY(U,$J,358.3,21594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21594,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,21594,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,21594,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,21595,0)
 ;;=D56.2^^58^840^54
 ;;^UTILITY(U,$J,358.3,21595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21595,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,21595,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,21595,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,21596,0)
 ;;=D75.9^^58^840^55
 ;;^UTILITY(U,$J,358.3,21596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21596,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,21596,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,21596,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,21597,0)
 ;;=D59.0^^58^840^58
 ;;^UTILITY(U,$J,358.3,21597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21597,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,21597,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,21597,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,21598,0)
 ;;=D59.2^^58^840^59
 ;;^UTILITY(U,$J,358.3,21598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21598,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,21598,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,21598,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,21599,0)
 ;;=R59.9^^58^840^62
 ;;^UTILITY(U,$J,358.3,21599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21599,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,21599,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,21599,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,21600,0)
 ;;=D47.3^^58^840^63
 ;;^UTILITY(U,$J,358.3,21600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21600,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,21600,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,21600,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,21601,0)
 ;;=C82.09^^58^840^64
 ;;^UTILITY(U,$J,358.3,21601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21601,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,21601,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,21601,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,21602,0)
 ;;=C82.00^^58^840^65
 ;;^UTILITY(U,$J,358.3,21602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21602,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,21602,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,21602,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,21603,0)
 ;;=C82.19^^58^840^66
 ;;^UTILITY(U,$J,358.3,21603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21603,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,21603,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,21603,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,21604,0)
 ;;=C82.10^^58^840^67
 ;;^UTILITY(U,$J,358.3,21604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21604,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,21604,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,21604,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,21605,0)
 ;;=C82.29^^58^840^68
 ;;^UTILITY(U,$J,358.3,21605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21605,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,21605,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,21605,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,21606,0)
 ;;=C82.20^^58^840^69
 ;;^UTILITY(U,$J,358.3,21606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21606,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,21606,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,21606,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,21607,0)
 ;;=C82.39^^58^840^70
 ;;^UTILITY(U,$J,358.3,21607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21607,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,21607,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,21607,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,21608,0)
 ;;=C82.30^^58^840^71
 ;;^UTILITY(U,$J,358.3,21608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21608,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
 ;;^UTILITY(U,$J,358.3,21608,1,4,0)
 ;;=4^C82.30
 ;;^UTILITY(U,$J,358.3,21608,2)
 ;;=^5001491
 ;;^UTILITY(U,$J,358.3,21609,0)
 ;;=C82.49^^58^840^72
 ;;^UTILITY(U,$J,358.3,21609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21609,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,21609,1,4,0)
 ;;=4^C82.49
 ;;^UTILITY(U,$J,358.3,21609,2)
 ;;=^5001510
 ;;^UTILITY(U,$J,358.3,21610,0)
 ;;=C82.40^^58^840^73
 ;;^UTILITY(U,$J,358.3,21610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21610,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Unspec Site
 ;;^UTILITY(U,$J,358.3,21610,1,4,0)
 ;;=4^C82.40
 ;;^UTILITY(U,$J,358.3,21610,2)
 ;;=^5001501
 ;;^UTILITY(U,$J,358.3,21611,0)
 ;;=C82.99^^58^840^74
 ;;^UTILITY(U,$J,358.3,21611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21611,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,21611,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,21611,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,21612,0)
 ;;=C82.90^^58^840^75
 ;;^UTILITY(U,$J,358.3,21612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21612,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,21612,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,21612,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,21613,0)
 ;;=R59.1^^58^840^60
 ;;^UTILITY(U,$J,358.3,21613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21613,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Generalized
 ;;^UTILITY(U,$J,358.3,21613,1,4,0)
 ;;=4^R59.1
 ;;^UTILITY(U,$J,358.3,21613,2)
 ;;=^5019530
 ;;^UTILITY(U,$J,358.3,21614,0)
 ;;=C91.40^^58^840^79
 ;;^UTILITY(U,$J,358.3,21614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21614,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,21614,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,21614,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,21615,0)
 ;;=C91.42^^58^840^77
 ;;^UTILITY(U,$J,358.3,21615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21615,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Relapse
