IBDEI0AX ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26697,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,26698,0)
 ;;=C92.01^^81^1073^7
 ;;^UTILITY(U,$J,358.3,26698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26698,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,26698,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,26698,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,26699,0)
 ;;=C92.00^^81^1073^8
 ;;^UTILITY(U,$J,358.3,26699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26699,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,26699,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,26699,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,26700,0)
 ;;=C92.61^^81^1073^9
 ;;^UTILITY(U,$J,358.3,26700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26700,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,26700,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,26700,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,26701,0)
 ;;=C92.60^^81^1073^10
 ;;^UTILITY(U,$J,358.3,26701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26701,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,26701,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,26701,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,26702,0)
 ;;=C92.A1^^81^1073^11
 ;;^UTILITY(U,$J,358.3,26702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26702,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,26702,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,26702,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,26703,0)
 ;;=C92.A0^^81^1073^12
 ;;^UTILITY(U,$J,358.3,26703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26703,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,26703,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,26703,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,26704,0)
 ;;=C92.51^^81^1073^13
 ;;^UTILITY(U,$J,358.3,26704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26704,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,26704,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,26704,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,26705,0)
 ;;=C92.50^^81^1073^14
 ;;^UTILITY(U,$J,358.3,26705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26705,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,26705,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,26705,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,26706,0)
 ;;=C94.40^^81^1073^17
 ;;^UTILITY(U,$J,358.3,26706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26706,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,26706,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,26706,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,26707,0)
 ;;=C94.42^^81^1073^15
 ;;^UTILITY(U,$J,358.3,26707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26707,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,26707,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,26707,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,26708,0)
 ;;=C94.41^^81^1073^16
 ;;^UTILITY(U,$J,358.3,26708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26708,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,26708,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,26708,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,26709,0)
 ;;=D62.^^81^1073^18
 ;;^UTILITY(U,$J,358.3,26709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26709,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,26709,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,26709,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,26710,0)
 ;;=C92.41^^81^1073^19
 ;;^UTILITY(U,$J,358.3,26710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26710,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,26710,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,26710,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,26711,0)
 ;;=C92.40^^81^1073^20
 ;;^UTILITY(U,$J,358.3,26711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26711,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,26711,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,26711,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,26712,0)
 ;;=D56.0^^81^1073^21
 ;;^UTILITY(U,$J,358.3,26712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26712,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,26712,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,26712,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,26713,0)
 ;;=D63.1^^81^1073^23
 ;;^UTILITY(U,$J,358.3,26713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26713,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,26713,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,26713,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,26714,0)
 ;;=D63.0^^81^1073^24
 ;;^UTILITY(U,$J,358.3,26714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26714,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,26714,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,26714,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,26715,0)
 ;;=D63.8^^81^1073^22
 ;;^UTILITY(U,$J,358.3,26715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26715,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,26715,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,26715,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,26716,0)
 ;;=C22.3^^81^1073^27
 ;;^UTILITY(U,$J,358.3,26716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26716,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,26716,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,26716,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,26717,0)
 ;;=D61.9^^81^1073^28
 ;;^UTILITY(U,$J,358.3,26717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26717,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,26717,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,26717,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,26718,0)
 ;;=D56.1^^81^1073^30
 ;;^UTILITY(U,$J,358.3,26718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26718,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,26718,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,26718,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,26719,0)
 ;;=C83.79^^81^1073^32
 ;;^UTILITY(U,$J,358.3,26719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26719,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,26719,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,26719,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,26720,0)
 ;;=C83.70^^81^1073^33
 ;;^UTILITY(U,$J,358.3,26720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26720,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,26720,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,26720,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,26721,0)
 ;;=D09.0^^81^1073^40
 ;;^UTILITY(U,$J,358.3,26721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26721,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,26721,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,26721,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,26722,0)
 ;;=D06.9^^81^1073^41
 ;;^UTILITY(U,$J,358.3,26722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26722,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,26722,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,26722,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,26723,0)
 ;;=D06.0^^81^1073^43
 ;;^UTILITY(U,$J,358.3,26723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26723,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,26723,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,26723,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,26724,0)
 ;;=D06.1^^81^1073^44
 ;;^UTILITY(U,$J,358.3,26724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26724,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,26724,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,26724,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,26725,0)
 ;;=D06.7^^81^1073^42
 ;;^UTILITY(U,$J,358.3,26725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26725,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,26725,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,26725,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,26726,0)
 ;;=D04.9^^81^1073^45
 ;;^UTILITY(U,$J,358.3,26726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26726,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,26726,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,26726,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,26727,0)
 ;;=C91.11^^81^1073^48
 ;;^UTILITY(U,$J,358.3,26727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26727,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,26727,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,26727,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,26728,0)
 ;;=C91.10^^81^1073^49
 ;;^UTILITY(U,$J,358.3,26728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26728,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,26728,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,26728,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,26729,0)
 ;;=C92.11^^81^1073^50
 ;;^UTILITY(U,$J,358.3,26729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26729,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,26729,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,26729,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,26730,0)
 ;;=C92.10^^81^1073^51
 ;;^UTILITY(U,$J,358.3,26730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26730,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,26730,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,26730,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,26731,0)
 ;;=D47.1^^81^1073^52
 ;;^UTILITY(U,$J,358.3,26731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26731,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,26731,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,26731,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,26732,0)
 ;;=C82.69^^81^1073^53
 ;;^UTILITY(U,$J,358.3,26732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26732,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,26732,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,26732,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,26733,0)
 ;;=C82.60^^81^1073^54
 ;;^UTILITY(U,$J,358.3,26733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26733,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,26733,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,26733,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,26734,0)
 ;;=D56.2^^81^1073^55
 ;;^UTILITY(U,$J,358.3,26734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26734,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,26734,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,26734,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,26735,0)
 ;;=D75.9^^81^1073^56
 ;;^UTILITY(U,$J,358.3,26735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26735,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,26735,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,26735,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,26736,0)
 ;;=D59.0^^81^1073^59
 ;;^UTILITY(U,$J,358.3,26736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26736,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,26736,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,26736,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,26737,0)
 ;;=D59.2^^81^1073^60
 ;;^UTILITY(U,$J,358.3,26737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26737,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,26737,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,26737,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,26738,0)
 ;;=R59.9^^81^1073^63
 ;;^UTILITY(U,$J,358.3,26738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26738,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,26738,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,26738,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,26739,0)
 ;;=D47.3^^81^1073^64
 ;;^UTILITY(U,$J,358.3,26739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26739,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,26739,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,26739,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,26740,0)
 ;;=C82.09^^81^1073^65
 ;;^UTILITY(U,$J,358.3,26740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26740,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,26740,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,26740,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,26741,0)
 ;;=C82.00^^81^1073^66
 ;;^UTILITY(U,$J,358.3,26741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26741,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,26741,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,26741,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,26742,0)
 ;;=C82.19^^81^1073^67
 ;;^UTILITY(U,$J,358.3,26742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26742,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,26742,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,26742,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,26743,0)
 ;;=C82.10^^81^1073^68
 ;;^UTILITY(U,$J,358.3,26743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26743,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,26743,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,26743,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,26744,0)
 ;;=C82.29^^81^1073^69
 ;;^UTILITY(U,$J,358.3,26744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26744,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,26744,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,26744,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,26745,0)
 ;;=C82.20^^81^1073^70
 ;;^UTILITY(U,$J,358.3,26745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26745,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,26745,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,26745,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,26746,0)
 ;;=C82.39^^81^1073^71
 ;;^UTILITY(U,$J,358.3,26746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26746,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,26746,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,26746,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,26747,0)
 ;;=C82.30^^81^1073^72
 ;;^UTILITY(U,$J,358.3,26747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26747,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
 ;;^UTILITY(U,$J,358.3,26747,1,4,0)
 ;;=4^C82.30
 ;;^UTILITY(U,$J,358.3,26747,2)
 ;;=^5001491
 ;;^UTILITY(U,$J,358.3,26748,0)
 ;;=C82.49^^81^1073^73
 ;;^UTILITY(U,$J,358.3,26748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26748,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,26748,1,4,0)
 ;;=4^C82.49
 ;;^UTILITY(U,$J,358.3,26748,2)
 ;;=^5001510
 ;;^UTILITY(U,$J,358.3,26749,0)
 ;;=C82.40^^81^1073^74
 ;;^UTILITY(U,$J,358.3,26749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26749,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Unspec Site
 ;;^UTILITY(U,$J,358.3,26749,1,4,0)
 ;;=4^C82.40
 ;;^UTILITY(U,$J,358.3,26749,2)
 ;;=^5001501
 ;;^UTILITY(U,$J,358.3,26750,0)
 ;;=C82.99^^81^1073^75
 ;;^UTILITY(U,$J,358.3,26750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26750,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,26750,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,26750,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,26751,0)
 ;;=C82.90^^81^1073^76
 ;;^UTILITY(U,$J,358.3,26751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26751,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,26751,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,26751,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,26752,0)
 ;;=R59.1^^81^1073^61
 ;;^UTILITY(U,$J,358.3,26752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26752,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Generalized
 ;;^UTILITY(U,$J,358.3,26752,1,4,0)
 ;;=4^R59.1
 ;;^UTILITY(U,$J,358.3,26752,2)
 ;;=^5019530
 ;;^UTILITY(U,$J,358.3,26753,0)
 ;;=C91.40^^81^1073^80
 ;;^UTILITY(U,$J,358.3,26753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26753,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,26753,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,26753,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,26754,0)
 ;;=C91.42^^81^1073^78
 ;;^UTILITY(U,$J,358.3,26754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26754,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,26754,1,4,0)
 ;;=4^C91.42
 ;;^UTILITY(U,$J,358.3,26754,2)
 ;;=^5001773
 ;;^UTILITY(U,$J,358.3,26755,0)
 ;;=C91.41^^81^1073^79
 ;;^UTILITY(U,$J,358.3,26755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26755,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,26755,1,4,0)
 ;;=4^C91.41
 ;;^UTILITY(U,$J,358.3,26755,2)
 ;;=^5001772
 ;;^UTILITY(U,$J,358.3,26756,0)
 ;;=D57.01^^81^1073^81
 ;;^UTILITY(U,$J,358.3,26756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26756,1,3,0)
 ;;=3^Hb-SS Disease w/ Acute Chest Syndrome
 ;;^UTILITY(U,$J,358.3,26756,1,4,0)
 ;;=4^D57.01
 ;;^UTILITY(U,$J,358.3,26756,2)
 ;;=^5002307
 ;;^UTILITY(U,$J,358.3,26757,0)
 ;;=D57.00^^81^1073^82
 ;;^UTILITY(U,$J,358.3,26757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26757,1,3,0)
 ;;=3^Hb-SS Disease w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,26757,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,26757,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,26758,0)
 ;;=D57.02^^81^1073^83
 ;;^UTILITY(U,$J,358.3,26758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26758,1,3,0)
 ;;=3^Hb-SS Disease w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,26758,1,4,0)
 ;;=4^D57.02
 ;;^UTILITY(U,$J,358.3,26758,2)
 ;;=^5002308
 ;;^UTILITY(U,$J,358.3,26759,0)
 ;;=D68.32^^81^1073^85
 ;;^UTILITY(U,$J,358.3,26759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26759,1,3,0)
 ;;=3^Hemorrhagic Disorder d/t Extrinsic Circulating Anticoagulants
 ;;^UTILITY(U,$J,358.3,26759,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,26759,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,26760,0)
 ;;=C22.2^^81^1073^86
 ;;^UTILITY(U,$J,358.3,26760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26760,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,26760,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,26760,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,26761,0)
 ;;=D58.9^^81^1073^88
 ;;^UTILITY(U,$J,358.3,26761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26761,1,3,0)
 ;;=3^Hereditary Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,26761,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,26761,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,26762,0)
 ;;=C81.99^^81^1073^89
 ;;^UTILITY(U,$J,358.3,26762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26762,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,26762,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,26762,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,26763,0)
 ;;=C81.90^^81^1073^90
 ;;^UTILITY(U,$J,358.3,26763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26763,1,3,0)
 ;;=3^Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,26763,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,26763,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,26764,0)
 ;;=D89.2^^81^1073^91
 ;;^UTILITY(U,$J,358.3,26764,1,0)
 ;;=^358.31IA^4^2
