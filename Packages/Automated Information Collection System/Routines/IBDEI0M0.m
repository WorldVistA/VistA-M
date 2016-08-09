IBDEI0M0 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22193,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,22193,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,22193,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,22194,0)
 ;;=D09.0^^89^1046^39
 ;;^UTILITY(U,$J,358.3,22194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22194,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,22194,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,22194,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,22195,0)
 ;;=D06.9^^89^1046^40
 ;;^UTILITY(U,$J,358.3,22195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22195,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,22195,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,22195,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,22196,0)
 ;;=D06.0^^89^1046^42
 ;;^UTILITY(U,$J,358.3,22196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22196,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,22196,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,22196,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,22197,0)
 ;;=D06.1^^89^1046^43
 ;;^UTILITY(U,$J,358.3,22197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22197,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,22197,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,22197,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,22198,0)
 ;;=D06.7^^89^1046^41
 ;;^UTILITY(U,$J,358.3,22198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22198,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,22198,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,22198,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,22199,0)
 ;;=D04.9^^89^1046^44
 ;;^UTILITY(U,$J,358.3,22199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22199,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,22199,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,22199,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,22200,0)
 ;;=C91.11^^89^1046^47
 ;;^UTILITY(U,$J,358.3,22200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22200,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,22200,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,22200,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,22201,0)
 ;;=C91.10^^89^1046^48
 ;;^UTILITY(U,$J,358.3,22201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22201,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,22201,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,22201,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,22202,0)
 ;;=C92.11^^89^1046^49
 ;;^UTILITY(U,$J,358.3,22202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22202,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,22202,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,22202,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,22203,0)
 ;;=C92.10^^89^1046^50
 ;;^UTILITY(U,$J,358.3,22203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22203,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,22203,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,22203,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,22204,0)
 ;;=D47.1^^89^1046^51
 ;;^UTILITY(U,$J,358.3,22204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22204,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,22204,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,22204,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,22205,0)
 ;;=C82.69^^89^1046^52
 ;;^UTILITY(U,$J,358.3,22205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22205,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,22205,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,22205,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,22206,0)
 ;;=C82.60^^89^1046^53
 ;;^UTILITY(U,$J,358.3,22206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22206,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,22206,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,22206,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,22207,0)
 ;;=D56.2^^89^1046^54
 ;;^UTILITY(U,$J,358.3,22207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22207,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,22207,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,22207,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,22208,0)
 ;;=D75.9^^89^1046^55
 ;;^UTILITY(U,$J,358.3,22208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22208,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,22208,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,22208,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,22209,0)
 ;;=D59.0^^89^1046^58
 ;;^UTILITY(U,$J,358.3,22209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22209,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,22209,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,22209,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,22210,0)
 ;;=D59.2^^89^1046^59
 ;;^UTILITY(U,$J,358.3,22210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22210,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,22210,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,22210,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,22211,0)
 ;;=R59.9^^89^1046^62
 ;;^UTILITY(U,$J,358.3,22211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22211,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,22211,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,22211,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,22212,0)
 ;;=D47.3^^89^1046^63
 ;;^UTILITY(U,$J,358.3,22212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22212,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,22212,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,22212,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,22213,0)
 ;;=C82.09^^89^1046^64
 ;;^UTILITY(U,$J,358.3,22213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22213,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,22213,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,22213,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,22214,0)
 ;;=C82.00^^89^1046^65
 ;;^UTILITY(U,$J,358.3,22214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22214,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,22214,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,22214,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,22215,0)
 ;;=C82.19^^89^1046^66
 ;;^UTILITY(U,$J,358.3,22215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22215,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,22215,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,22215,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,22216,0)
 ;;=C82.10^^89^1046^67
 ;;^UTILITY(U,$J,358.3,22216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22216,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,22216,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,22216,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,22217,0)
 ;;=C82.29^^89^1046^68
 ;;^UTILITY(U,$J,358.3,22217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22217,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,22217,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,22217,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,22218,0)
 ;;=C82.20^^89^1046^69
 ;;^UTILITY(U,$J,358.3,22218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22218,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,22218,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,22218,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,22219,0)
 ;;=C82.39^^89^1046^70
 ;;^UTILITY(U,$J,358.3,22219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22219,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,22219,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,22219,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,22220,0)
 ;;=C82.30^^89^1046^71
 ;;^UTILITY(U,$J,358.3,22220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22220,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
