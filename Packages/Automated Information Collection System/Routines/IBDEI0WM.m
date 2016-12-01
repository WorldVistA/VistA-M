IBDEI0WM ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42824,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,42824,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,42824,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,42825,0)
 ;;=C92.00^^127^1855^8
 ;;^UTILITY(U,$J,358.3,42825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42825,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,42825,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,42825,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,42826,0)
 ;;=C92.61^^127^1855^9
 ;;^UTILITY(U,$J,358.3,42826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42826,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,42826,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,42826,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,42827,0)
 ;;=C92.60^^127^1855^10
 ;;^UTILITY(U,$J,358.3,42827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42827,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,42827,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,42827,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,42828,0)
 ;;=C92.A1^^127^1855^11
 ;;^UTILITY(U,$J,358.3,42828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42828,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,42828,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,42828,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,42829,0)
 ;;=C92.A0^^127^1855^12
 ;;^UTILITY(U,$J,358.3,42829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42829,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,42829,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,42829,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,42830,0)
 ;;=C92.51^^127^1855^13
 ;;^UTILITY(U,$J,358.3,42830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42830,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,42830,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,42830,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,42831,0)
 ;;=C92.50^^127^1855^14
 ;;^UTILITY(U,$J,358.3,42831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42831,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,42831,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,42831,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,42832,0)
 ;;=C94.40^^127^1855^17
 ;;^UTILITY(U,$J,358.3,42832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42832,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,42832,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,42832,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,42833,0)
 ;;=C94.42^^127^1855^15
 ;;^UTILITY(U,$J,358.3,42833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42833,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,42833,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,42833,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,42834,0)
 ;;=C94.41^^127^1855^16
 ;;^UTILITY(U,$J,358.3,42834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42834,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,42834,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,42834,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,42835,0)
 ;;=D62.^^127^1855^18
 ;;^UTILITY(U,$J,358.3,42835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42835,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,42835,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,42835,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,42836,0)
 ;;=C92.41^^127^1855^19
 ;;^UTILITY(U,$J,358.3,42836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42836,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,42836,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,42836,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,42837,0)
 ;;=C92.40^^127^1855^20
 ;;^UTILITY(U,$J,358.3,42837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42837,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,42837,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,42837,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,42838,0)
 ;;=D56.0^^127^1855^21
 ;;^UTILITY(U,$J,358.3,42838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42838,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,42838,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,42838,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,42839,0)
 ;;=D63.1^^127^1855^23
 ;;^UTILITY(U,$J,358.3,42839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42839,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,42839,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,42839,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,42840,0)
 ;;=D63.0^^127^1855^24
 ;;^UTILITY(U,$J,358.3,42840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42840,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,42840,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,42840,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,42841,0)
 ;;=D63.8^^127^1855^22
 ;;^UTILITY(U,$J,358.3,42841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42841,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,42841,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,42841,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,42842,0)
 ;;=C22.3^^127^1855^26
 ;;^UTILITY(U,$J,358.3,42842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42842,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,42842,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,42842,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,42843,0)
 ;;=D61.9^^127^1855^27
 ;;^UTILITY(U,$J,358.3,42843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42843,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,42843,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,42843,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,42844,0)
 ;;=D56.1^^127^1855^29
 ;;^UTILITY(U,$J,358.3,42844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42844,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,42844,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,42844,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,42845,0)
 ;;=C83.79^^127^1855^31
 ;;^UTILITY(U,$J,358.3,42845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42845,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,42845,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,42845,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,42846,0)
 ;;=C83.70^^127^1855^32
 ;;^UTILITY(U,$J,358.3,42846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42846,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,42846,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,42846,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,42847,0)
 ;;=D09.0^^127^1855^39
 ;;^UTILITY(U,$J,358.3,42847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42847,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,42847,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,42847,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,42848,0)
 ;;=D06.9^^127^1855^40
 ;;^UTILITY(U,$J,358.3,42848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42848,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,42848,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,42848,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,42849,0)
 ;;=D06.0^^127^1855^42
 ;;^UTILITY(U,$J,358.3,42849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42849,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,42849,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,42849,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,42850,0)
 ;;=D06.1^^127^1855^43
 ;;^UTILITY(U,$J,358.3,42850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42850,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,42850,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,42850,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,42851,0)
 ;;=D06.7^^127^1855^41
 ;;^UTILITY(U,$J,358.3,42851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42851,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,42851,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,42851,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,42852,0)
 ;;=D04.9^^127^1855^44
 ;;^UTILITY(U,$J,358.3,42852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42852,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,42852,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,42852,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,42853,0)
 ;;=C91.11^^127^1855^47
 ;;^UTILITY(U,$J,358.3,42853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42853,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,42853,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,42853,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,42854,0)
 ;;=C91.10^^127^1855^48
 ;;^UTILITY(U,$J,358.3,42854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42854,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,42854,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,42854,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,42855,0)
 ;;=C92.11^^127^1855^49
 ;;^UTILITY(U,$J,358.3,42855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42855,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,42855,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,42855,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,42856,0)
 ;;=C92.10^^127^1855^50
 ;;^UTILITY(U,$J,358.3,42856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42856,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,42856,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,42856,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,42857,0)
 ;;=D47.1^^127^1855^51
 ;;^UTILITY(U,$J,358.3,42857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42857,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,42857,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,42857,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,42858,0)
 ;;=C82.69^^127^1855^52
 ;;^UTILITY(U,$J,358.3,42858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42858,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
