IBDEI0AG ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13252,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,13252,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,13252,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,13253,0)
 ;;=C91.01^^43^624^4
 ;;^UTILITY(U,$J,358.3,13253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13253,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,13253,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,13253,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,13254,0)
 ;;=C92.01^^43^624^7
 ;;^UTILITY(U,$J,358.3,13254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13254,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,13254,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,13254,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,13255,0)
 ;;=C92.00^^43^624^8
 ;;^UTILITY(U,$J,358.3,13255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13255,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,13255,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,13255,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,13256,0)
 ;;=C92.61^^43^624^9
 ;;^UTILITY(U,$J,358.3,13256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13256,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,13256,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,13256,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,13257,0)
 ;;=C92.60^^43^624^10
 ;;^UTILITY(U,$J,358.3,13257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13257,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,13257,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,13257,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,13258,0)
 ;;=C92.A1^^43^624^11
 ;;^UTILITY(U,$J,358.3,13258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13258,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,13258,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,13258,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,13259,0)
 ;;=C92.A0^^43^624^12
 ;;^UTILITY(U,$J,358.3,13259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13259,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,13259,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,13259,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,13260,0)
 ;;=C92.51^^43^624^13
 ;;^UTILITY(U,$J,358.3,13260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13260,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,13260,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,13260,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,13261,0)
 ;;=C92.50^^43^624^14
 ;;^UTILITY(U,$J,358.3,13261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13261,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,13261,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,13261,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,13262,0)
 ;;=C94.40^^43^624^17
 ;;^UTILITY(U,$J,358.3,13262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13262,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,13262,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,13262,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,13263,0)
 ;;=C94.42^^43^624^15
 ;;^UTILITY(U,$J,358.3,13263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13263,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,13263,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,13263,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,13264,0)
 ;;=C94.41^^43^624^16
 ;;^UTILITY(U,$J,358.3,13264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13264,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,13264,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,13264,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,13265,0)
 ;;=D62.^^43^624^18
 ;;^UTILITY(U,$J,358.3,13265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13265,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,13265,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,13265,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,13266,0)
 ;;=C92.41^^43^624^19
 ;;^UTILITY(U,$J,358.3,13266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13266,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,13266,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,13266,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,13267,0)
 ;;=C92.40^^43^624^20
 ;;^UTILITY(U,$J,358.3,13267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13267,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,13267,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,13267,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,13268,0)
 ;;=D56.0^^43^624^21
 ;;^UTILITY(U,$J,358.3,13268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13268,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,13268,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,13268,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,13269,0)
 ;;=D63.1^^43^624^23
 ;;^UTILITY(U,$J,358.3,13269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13269,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,13269,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,13269,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,13270,0)
 ;;=D63.0^^43^624^24
 ;;^UTILITY(U,$J,358.3,13270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13270,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,13270,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,13270,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,13271,0)
 ;;=D63.8^^43^624^22
 ;;^UTILITY(U,$J,358.3,13271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13271,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,13271,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,13271,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,13272,0)
 ;;=C22.3^^43^624^26
 ;;^UTILITY(U,$J,358.3,13272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13272,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,13272,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,13272,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,13273,0)
 ;;=D61.9^^43^624^27
 ;;^UTILITY(U,$J,358.3,13273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13273,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,13273,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,13273,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,13274,0)
 ;;=D56.1^^43^624^29
 ;;^UTILITY(U,$J,358.3,13274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13274,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,13274,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,13274,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,13275,0)
 ;;=C83.79^^43^624^31
 ;;^UTILITY(U,$J,358.3,13275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13275,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,13275,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,13275,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,13276,0)
 ;;=C83.70^^43^624^32
 ;;^UTILITY(U,$J,358.3,13276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13276,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,13276,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,13276,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,13277,0)
 ;;=D09.0^^43^624^39
 ;;^UTILITY(U,$J,358.3,13277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13277,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,13277,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,13277,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,13278,0)
 ;;=D06.9^^43^624^40
 ;;^UTILITY(U,$J,358.3,13278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13278,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,13278,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,13278,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,13279,0)
 ;;=D06.0^^43^624^42
 ;;^UTILITY(U,$J,358.3,13279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13279,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,13279,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,13279,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,13280,0)
 ;;=D06.1^^43^624^43
 ;;^UTILITY(U,$J,358.3,13280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13280,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,13280,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,13280,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,13281,0)
 ;;=D06.7^^43^624^41
 ;;^UTILITY(U,$J,358.3,13281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13281,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,13281,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,13281,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,13282,0)
 ;;=D04.9^^43^624^44
 ;;^UTILITY(U,$J,358.3,13282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13282,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,13282,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,13282,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,13283,0)
 ;;=C91.11^^43^624^47
 ;;^UTILITY(U,$J,358.3,13283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13283,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,13283,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,13283,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,13284,0)
 ;;=C91.10^^43^624^48
 ;;^UTILITY(U,$J,358.3,13284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13284,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,13284,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,13284,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,13285,0)
 ;;=C92.11^^43^624^49
 ;;^UTILITY(U,$J,358.3,13285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13285,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,13285,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,13285,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,13286,0)
 ;;=C92.10^^43^624^50
 ;;^UTILITY(U,$J,358.3,13286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13286,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,13286,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,13286,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,13287,0)
 ;;=D47.1^^43^624^51
