IBDEI0F6 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19181,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,19181,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,19181,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,19182,0)
 ;;=C94.42^^55^788^15
 ;;^UTILITY(U,$J,358.3,19182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19182,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,19182,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,19182,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,19183,0)
 ;;=C94.41^^55^788^16
 ;;^UTILITY(U,$J,358.3,19183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19183,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,19183,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,19183,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,19184,0)
 ;;=D62.^^55^788^18
 ;;^UTILITY(U,$J,358.3,19184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19184,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,19184,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,19184,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,19185,0)
 ;;=C92.41^^55^788^19
 ;;^UTILITY(U,$J,358.3,19185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19185,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,19185,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,19185,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,19186,0)
 ;;=C92.40^^55^788^20
 ;;^UTILITY(U,$J,358.3,19186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19186,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,19186,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,19186,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,19187,0)
 ;;=D56.0^^55^788^21
 ;;^UTILITY(U,$J,358.3,19187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19187,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,19187,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,19187,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,19188,0)
 ;;=D63.1^^55^788^23
 ;;^UTILITY(U,$J,358.3,19188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19188,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,19188,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,19188,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,19189,0)
 ;;=D63.0^^55^788^24
 ;;^UTILITY(U,$J,358.3,19189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19189,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,19189,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,19189,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,19190,0)
 ;;=D63.8^^55^788^22
 ;;^UTILITY(U,$J,358.3,19190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19190,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,19190,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,19190,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,19191,0)
 ;;=C22.3^^55^788^26
 ;;^UTILITY(U,$J,358.3,19191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19191,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,19191,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,19191,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,19192,0)
 ;;=D61.9^^55^788^27
 ;;^UTILITY(U,$J,358.3,19192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19192,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,19192,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,19192,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,19193,0)
 ;;=D56.1^^55^788^29
 ;;^UTILITY(U,$J,358.3,19193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19193,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,19193,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,19193,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,19194,0)
 ;;=C83.79^^55^788^31
 ;;^UTILITY(U,$J,358.3,19194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19194,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,19194,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,19194,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,19195,0)
 ;;=C83.70^^55^788^32
 ;;^UTILITY(U,$J,358.3,19195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19195,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,19195,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,19195,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,19196,0)
 ;;=D09.0^^55^788^39
 ;;^UTILITY(U,$J,358.3,19196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19196,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,19196,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,19196,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,19197,0)
 ;;=D06.9^^55^788^40
 ;;^UTILITY(U,$J,358.3,19197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19197,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,19197,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,19197,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,19198,0)
 ;;=D06.0^^55^788^42
 ;;^UTILITY(U,$J,358.3,19198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19198,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,19198,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,19198,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,19199,0)
 ;;=D06.1^^55^788^43
 ;;^UTILITY(U,$J,358.3,19199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19199,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,19199,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,19199,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,19200,0)
 ;;=D06.7^^55^788^41
 ;;^UTILITY(U,$J,358.3,19200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19200,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,19200,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,19200,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,19201,0)
 ;;=D04.9^^55^788^44
 ;;^UTILITY(U,$J,358.3,19201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19201,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,19201,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,19201,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,19202,0)
 ;;=C91.11^^55^788^47
 ;;^UTILITY(U,$J,358.3,19202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19202,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,19202,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,19202,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,19203,0)
 ;;=C91.10^^55^788^48
 ;;^UTILITY(U,$J,358.3,19203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19203,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,19203,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,19203,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,19204,0)
 ;;=C92.11^^55^788^49
 ;;^UTILITY(U,$J,358.3,19204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19204,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,19204,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,19204,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,19205,0)
 ;;=C92.10^^55^788^50
 ;;^UTILITY(U,$J,358.3,19205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19205,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,19205,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,19205,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,19206,0)
 ;;=D47.1^^55^788^51
 ;;^UTILITY(U,$J,358.3,19206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19206,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,19206,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,19206,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,19207,0)
 ;;=C82.69^^55^788^52
 ;;^UTILITY(U,$J,358.3,19207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19207,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,19207,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,19207,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,19208,0)
 ;;=C82.60^^55^788^53
 ;;^UTILITY(U,$J,358.3,19208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19208,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,19208,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,19208,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,19209,0)
 ;;=D56.2^^55^788^54
 ;;^UTILITY(U,$J,358.3,19209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19209,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,19209,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,19209,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,19210,0)
 ;;=D75.9^^55^788^55
 ;;^UTILITY(U,$J,358.3,19210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19210,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,19210,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,19210,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,19211,0)
 ;;=D59.0^^55^788^58
 ;;^UTILITY(U,$J,358.3,19211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19211,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,19211,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,19211,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,19212,0)
 ;;=D59.2^^55^788^59
 ;;^UTILITY(U,$J,358.3,19212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19212,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,19212,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,19212,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,19213,0)
 ;;=R59.9^^55^788^62
 ;;^UTILITY(U,$J,358.3,19213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19213,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,19213,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,19213,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,19214,0)
 ;;=D47.3^^55^788^63
 ;;^UTILITY(U,$J,358.3,19214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19214,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,19214,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,19214,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,19215,0)
 ;;=C82.09^^55^788^64
 ;;^UTILITY(U,$J,358.3,19215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19215,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,19215,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,19215,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,19216,0)
 ;;=C82.00^^55^788^65
 ;;^UTILITY(U,$J,358.3,19216,1,0)
 ;;=^358.31IA^4^2
