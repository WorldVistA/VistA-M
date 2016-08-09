IBDEI0IM ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18755,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,18755,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,18756,0)
 ;;=C83.59^^84^967^44
 ;;^UTILITY(U,$J,358.3,18756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18756,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,18756,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,18756,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,18757,0)
 ;;=C83.70^^84^967^45
 ;;^UTILITY(U,$J,358.3,18757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18757,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,18757,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,18757,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,18758,0)
 ;;=C83.79^^84^967^46
 ;;^UTILITY(U,$J,358.3,18758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18758,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,18758,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,18758,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,18759,0)
 ;;=C81.90^^84^967^47
 ;;^UTILITY(U,$J,358.3,18759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18759,1,3,0)
 ;;=3^Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,18759,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,18759,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,18760,0)
 ;;=C81.99^^84^967^48
 ;;^UTILITY(U,$J,358.3,18760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18760,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,18760,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,18760,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,18761,0)
 ;;=C82.90^^84^967^49
 ;;^UTILITY(U,$J,358.3,18761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18761,1,3,0)
 ;;=3^Follicular Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,18761,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,18761,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,18762,0)
 ;;=C82.99^^84^967^50
 ;;^UTILITY(U,$J,358.3,18762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18762,1,3,0)
 ;;=3^Folicular Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,18762,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,18762,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,18763,0)
 ;;=C91.40^^84^967^51
 ;;^UTILITY(U,$J,358.3,18763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18763,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,18763,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,18763,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,18764,0)
 ;;=C90.00^^84^967^52
 ;;^UTILITY(U,$J,358.3,18764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18764,1,3,0)
 ;;=3^Multiple Myeloma,Not in Remission
 ;;^UTILITY(U,$J,358.3,18764,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,18764,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,18765,0)
 ;;=C90.01^^84^967^53
 ;;^UTILITY(U,$J,358.3,18765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18765,1,3,0)
 ;;=3^Multiple Myeloma,In Remission
 ;;^UTILITY(U,$J,358.3,18765,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,18765,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,18766,0)
 ;;=C91.00^^84^967^54
 ;;^UTILITY(U,$J,358.3,18766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18766,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,18766,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,18766,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,18767,0)
 ;;=C91.01^^84^967^55
 ;;^UTILITY(U,$J,358.3,18767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18767,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,18767,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,18767,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,18768,0)
 ;;=C91.10^^84^967^56
 ;;^UTILITY(U,$J,358.3,18768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18768,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia B-Cell Type,Not in Remissio
 ;;^UTILITY(U,$J,358.3,18768,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,18768,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,18769,0)
 ;;=C91.11^^84^967^57
 ;;^UTILITY(U,$J,358.3,18769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18769,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,18769,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,18769,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,18770,0)
 ;;=C92.00^^84^967^58
 ;;^UTILITY(U,$J,358.3,18770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18770,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,18770,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,18770,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,18771,0)
 ;;=C92.01^^84^967^59
 ;;^UTILITY(U,$J,358.3,18771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18771,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,18771,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,18771,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,18772,0)
 ;;=C92.41^^84^967^60
 ;;^UTILITY(U,$J,358.3,18772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18772,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,18772,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,18772,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,18773,0)
 ;;=C92.41^^84^967^61
 ;;^UTILITY(U,$J,358.3,18773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18773,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,18773,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,18773,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,18774,0)
 ;;=C92.50^^84^967^62
 ;;^UTILITY(U,$J,358.3,18774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18774,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,18774,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,18774,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,18775,0)
 ;;=C92.51^^84^967^63
 ;;^UTILITY(U,$J,358.3,18775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18775,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,18775,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,18775,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,18776,0)
 ;;=C92.10^^84^967^64
 ;;^UTILITY(U,$J,358.3,18776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18776,1,3,0)
 ;;=3^Chronic Myeloid Leukemia BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,18776,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,18776,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,18777,0)
 ;;=C92.11^^84^967^65
 ;;^UTILITY(U,$J,358.3,18777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18777,1,3,0)
 ;;=3^Chronic Myeloid Leukemia BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,18777,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,18777,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,18778,0)
 ;;=D04.9^^84^967^66
 ;;^UTILITY(U,$J,358.3,18778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18778,1,3,0)
 ;;=3^Carcinoma in Situ of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,18778,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,18778,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,18779,0)
 ;;=D05.91^^84^967^67
 ;;^UTILITY(U,$J,358.3,18779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18779,1,3,0)
 ;;=3^Carcinoma in Situ of Right Breast
 ;;^UTILITY(U,$J,358.3,18779,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,18779,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,18780,0)
 ;;=D05.92^^84^967^68
 ;;^UTILITY(U,$J,358.3,18780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18780,1,3,0)
 ;;=3^Carcinoma in Situ of Left Breast
 ;;^UTILITY(U,$J,358.3,18780,1,4,0)
 ;;=4^D05.92
 ;;^UTILITY(U,$J,358.3,18780,2)
 ;;=^5001937
 ;;^UTILITY(U,$J,358.3,18781,0)
 ;;=D06.9^^84^967^69
 ;;^UTILITY(U,$J,358.3,18781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18781,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Unspec
 ;;^UTILITY(U,$J,358.3,18781,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,18781,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,18782,0)
 ;;=D09.0^^84^967^70
 ;;^UTILITY(U,$J,358.3,18782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18782,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,18782,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,18782,2)
 ;;=^267742
