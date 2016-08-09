IBDEI07J ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7452,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,7452,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,7452,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,7453,0)
 ;;=D09.0^^42^498^37
 ;;^UTILITY(U,$J,358.3,7453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7453,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,7453,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,7453,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,7454,0)
 ;;=D06.9^^42^498^38
 ;;^UTILITY(U,$J,358.3,7454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7454,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,7454,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,7454,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,7455,0)
 ;;=D06.0^^42^498^40
 ;;^UTILITY(U,$J,358.3,7455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7455,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,7455,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,7455,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,7456,0)
 ;;=D06.1^^42^498^41
 ;;^UTILITY(U,$J,358.3,7456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7456,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,7456,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,7456,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,7457,0)
 ;;=D06.7^^42^498^39
 ;;^UTILITY(U,$J,358.3,7457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7457,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,7457,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,7457,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,7458,0)
 ;;=D04.9^^42^498^42
 ;;^UTILITY(U,$J,358.3,7458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7458,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,7458,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,7458,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,7459,0)
 ;;=C91.11^^42^498^45
 ;;^UTILITY(U,$J,358.3,7459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7459,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,7459,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,7459,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,7460,0)
 ;;=C91.10^^42^498^46
 ;;^UTILITY(U,$J,358.3,7460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7460,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,7460,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,7460,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,7461,0)
 ;;=C92.11^^42^498^47
 ;;^UTILITY(U,$J,358.3,7461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7461,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,7461,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,7461,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,7462,0)
 ;;=C92.10^^42^498^48
 ;;^UTILITY(U,$J,358.3,7462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7462,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,7462,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,7462,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,7463,0)
 ;;=D47.1^^42^498^49
 ;;^UTILITY(U,$J,358.3,7463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7463,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,7463,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,7463,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,7464,0)
 ;;=C82.69^^42^498^50
 ;;^UTILITY(U,$J,358.3,7464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7464,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,7464,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,7464,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,7465,0)
 ;;=C82.60^^42^498^51
 ;;^UTILITY(U,$J,358.3,7465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7465,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,7465,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,7465,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,7466,0)
 ;;=D56.2^^42^498^52
 ;;^UTILITY(U,$J,358.3,7466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7466,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,7466,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,7466,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,7467,0)
 ;;=D75.9^^42^498^53
 ;;^UTILITY(U,$J,358.3,7467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7467,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,7467,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,7467,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,7468,0)
 ;;=D59.0^^42^498^56
 ;;^UTILITY(U,$J,358.3,7468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7468,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,7468,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,7468,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,7469,0)
 ;;=D59.2^^42^498^57
 ;;^UTILITY(U,$J,358.3,7469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7469,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,7469,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,7469,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,7470,0)
 ;;=R59.9^^42^498^60
 ;;^UTILITY(U,$J,358.3,7470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7470,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,7470,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,7470,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,7471,0)
 ;;=D47.3^^42^498^61
 ;;^UTILITY(U,$J,358.3,7471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7471,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,7471,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,7471,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,7472,0)
 ;;=C82.09^^42^498^62
 ;;^UTILITY(U,$J,358.3,7472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7472,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,7472,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,7472,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,7473,0)
 ;;=C82.00^^42^498^63
 ;;^UTILITY(U,$J,358.3,7473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7473,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,7473,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,7473,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,7474,0)
 ;;=C82.19^^42^498^64
 ;;^UTILITY(U,$J,358.3,7474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7474,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,7474,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,7474,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,7475,0)
 ;;=C82.10^^42^498^65
 ;;^UTILITY(U,$J,358.3,7475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7475,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,7475,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,7475,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,7476,0)
 ;;=C82.29^^42^498^66
 ;;^UTILITY(U,$J,358.3,7476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7476,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,7476,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,7476,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,7477,0)
 ;;=C82.20^^42^498^67
 ;;^UTILITY(U,$J,358.3,7477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7477,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,7477,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,7477,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,7478,0)
 ;;=C82.39^^42^498^68
 ;;^UTILITY(U,$J,358.3,7478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7478,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,7478,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,7478,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,7479,0)
 ;;=C82.30^^42^498^69
 ;;^UTILITY(U,$J,358.3,7479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7479,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
 ;;^UTILITY(U,$J,358.3,7479,1,4,0)
 ;;=4^C82.30
 ;;^UTILITY(U,$J,358.3,7479,2)
 ;;=^5001491
