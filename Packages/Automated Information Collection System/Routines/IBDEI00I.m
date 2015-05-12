IBDEI00I ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,333,1,3,0)
 ;;=3^Folicular Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,333,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,333,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,334,0)
 ;;=C91.40^^1^6^51
 ;;^UTILITY(U,$J,358.3,334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,334,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,334,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,334,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,335,0)
 ;;=C90.00^^1^6^52
 ;;^UTILITY(U,$J,358.3,335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,335,1,3,0)
 ;;=3^Multiple Myeloma,Not in Remission
 ;;^UTILITY(U,$J,358.3,335,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,335,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,336,0)
 ;;=C90.01^^1^6^53
 ;;^UTILITY(U,$J,358.3,336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,336,1,3,0)
 ;;=3^Multiple Myeloma,In Remission
 ;;^UTILITY(U,$J,358.3,336,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,336,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,337,0)
 ;;=C91.00^^1^6^54
 ;;^UTILITY(U,$J,358.3,337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,337,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,337,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,337,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,338,0)
 ;;=C91.01^^1^6^55
 ;;^UTILITY(U,$J,358.3,338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,338,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,338,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,338,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,339,0)
 ;;=C91.10^^1^6^56
 ;;^UTILITY(U,$J,358.3,339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,339,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia B-Cell Type,Not in Remissio
 ;;^UTILITY(U,$J,358.3,339,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,339,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,340,0)
 ;;=C91.11^^1^6^57
 ;;^UTILITY(U,$J,358.3,340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,340,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,340,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,340,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,341,0)
 ;;=C92.00^^1^6^58
 ;;^UTILITY(U,$J,358.3,341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,341,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,341,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,341,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,342,0)
 ;;=C92.01^^1^6^59
 ;;^UTILITY(U,$J,358.3,342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,342,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,342,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,342,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,343,0)
 ;;=C92.41^^1^6^60
 ;;^UTILITY(U,$J,358.3,343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,343,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,343,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,343,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,344,0)
 ;;=C92.41^^1^6^61
 ;;^UTILITY(U,$J,358.3,344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,344,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,344,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,344,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,345,0)
 ;;=C92.50^^1^6^62
 ;;^UTILITY(U,$J,358.3,345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,345,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,345,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,345,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,346,0)
 ;;=C92.51^^1^6^63
 ;;^UTILITY(U,$J,358.3,346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,346,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,346,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,346,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,347,0)
 ;;=C92.10^^1^6^64
 ;;^UTILITY(U,$J,358.3,347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,347,1,3,0)
 ;;=3^Chronic Myeloid Leukemia BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,347,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,347,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,348,0)
 ;;=C92.11^^1^6^65
 ;;^UTILITY(U,$J,358.3,348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,348,1,3,0)
 ;;=3^Chronic Myeloid Leukemia BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,348,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,348,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,349,0)
 ;;=D04.9^^1^6^66
 ;;^UTILITY(U,$J,358.3,349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,349,1,3,0)
 ;;=3^Carcinoma in Situ of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,349,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,349,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,350,0)
 ;;=D05.91^^1^6^67
 ;;^UTILITY(U,$J,358.3,350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,350,1,3,0)
 ;;=3^Carcinoma in Situ of Right Breast
 ;;^UTILITY(U,$J,358.3,350,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,350,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,351,0)
 ;;=D05.92^^1^6^68
 ;;^UTILITY(U,$J,358.3,351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,351,1,3,0)
 ;;=3^Carcinoma in Situ of Left Breast
 ;;^UTILITY(U,$J,358.3,351,1,4,0)
 ;;=4^D05.92
 ;;^UTILITY(U,$J,358.3,351,2)
 ;;=^5001937
 ;;^UTILITY(U,$J,358.3,352,0)
 ;;=D06.9^^1^6^69
 ;;^UTILITY(U,$J,358.3,352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,352,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Unspec
 ;;^UTILITY(U,$J,358.3,352,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,352,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,353,0)
 ;;=D09.0^^1^6^70
 ;;^UTILITY(U,$J,358.3,353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,353,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,353,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,353,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,354,0)
 ;;=D45.^^1^6^71
 ;;^UTILITY(U,$J,358.3,354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,354,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,354,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,354,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,355,0)
 ;;=D47.Z9^^1^6^72
 ;;^UTILITY(U,$J,358.3,355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,355,1,3,0)
 ;;=3^Neop of Uncertain Behavior of Lymphoid/Hematpoetc/Related Tissue
 ;;^UTILITY(U,$J,358.3,355,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,355,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,356,0)
 ;;=C94.40^^1^6^73
 ;;^UTILITY(U,$J,358.3,356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,356,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,356,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,356,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,357,0)
 ;;=C94.41^^1^6^74
 ;;^UTILITY(U,$J,358.3,357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,357,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,357,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,357,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,358,0)
 ;;=C94.42^^1^6^75
 ;;^UTILITY(U,$J,358.3,358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,358,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,358,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,358,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,359,0)
 ;;=D47.1^^1^6^76
 ;;^UTILITY(U,$J,358.3,359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,359,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,359,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,359,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,360,0)
 ;;=D47.9^^1^6^77
 ;;^UTILITY(U,$J,358.3,360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,360,1,3,0)
 ;;=3^Neop of Uncertain Behavior of Lymphoid/Hematpoetc/Related Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,360,1,4,0)
 ;;=4^D47.9
 ;;^UTILITY(U,$J,358.3,360,2)
 ;;=^5002260
 ;;^UTILITY(U,$J,358.3,361,0)
 ;;=D47.Z9^^1^6^78
 ;;^UTILITY(U,$J,358.3,361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,361,1,3,0)
 ;;=3^Neop of Uncertain Behavior of Lymphoid/Hematpoetc/Related Tissue,NEC
 ;;^UTILITY(U,$J,358.3,361,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,361,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,362,0)
 ;;=A15.0^^1^7^101
 ;;^UTILITY(U,$J,358.3,362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,362,1,3,0)
 ;;=3^Tuberculosis of Lung
 ;;^UTILITY(U,$J,358.3,362,1,4,0)
 ;;=4^A15.0
 ;;^UTILITY(U,$J,358.3,362,2)
 ;;=^5000062
 ;;^UTILITY(U,$J,358.3,363,0)
 ;;=A31.0^^1^7^87
 ;;^UTILITY(U,$J,358.3,363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,363,1,3,0)
 ;;=3^Pulmonary Mycobacterial Infection
 ;;^UTILITY(U,$J,358.3,363,1,4,0)
 ;;=4^A31.0
 ;;^UTILITY(U,$J,358.3,363,2)
 ;;=^5000149
 ;;^UTILITY(U,$J,358.3,364,0)
 ;;=B95.5^^1^7^91
 ;;^UTILITY(U,$J,358.3,364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,364,1,3,0)
 ;;=3^Streptococcus in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,364,1,4,0)
 ;;=4^B95.5
 ;;^UTILITY(U,$J,358.3,364,2)
 ;;=^5000840
 ;;^UTILITY(U,$J,358.3,365,0)
 ;;=B95.0^^1^7^93
 ;;^UTILITY(U,$J,358.3,365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,365,1,3,0)
 ;;=3^Streptococcus,Group A,in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,365,1,4,0)
 ;;=4^B95.0
 ;;^UTILITY(U,$J,358.3,365,2)
 ;;=^5000835
 ;;^UTILITY(U,$J,358.3,366,0)
 ;;=B95.1^^1^7^94
 ;;^UTILITY(U,$J,358.3,366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,366,1,3,0)
 ;;=3^Streptococcus,Group B,in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,366,1,4,0)
 ;;=4^B95.1
 ;;^UTILITY(U,$J,358.3,366,2)
 ;;=^5000836
 ;;^UTILITY(U,$J,358.3,367,0)
 ;;=B95.4^^1^7^92
 ;;^UTILITY(U,$J,358.3,367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,367,1,3,0)
 ;;=3^Streptococcus in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,367,1,4,0)
 ;;=4^B95.4
 ;;^UTILITY(U,$J,358.3,367,2)
 ;;=^5000839
 ;;^UTILITY(U,$J,358.3,368,0)
 ;;=B95.2^^1^7^48
 ;;^UTILITY(U,$J,358.3,368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,368,1,3,0)
 ;;=3^Enterococcus in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,368,1,4,0)
 ;;=4^B95.2
 ;;^UTILITY(U,$J,358.3,368,2)
 ;;=^5000837
 ;;^UTILITY(U,$J,358.3,369,0)
 ;;=B95.8^^1^7^90
 ;;^UTILITY(U,$J,358.3,369,1,0)
 ;;=^358.31IA^4^2
