IBDEI0NG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10717,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,10718,0)
 ;;=D09.0^^68^675^37
 ;;^UTILITY(U,$J,358.3,10718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10718,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,10718,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,10718,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,10719,0)
 ;;=D06.9^^68^675^38
 ;;^UTILITY(U,$J,358.3,10719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10719,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,10719,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,10719,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,10720,0)
 ;;=D06.0^^68^675^40
 ;;^UTILITY(U,$J,358.3,10720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10720,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,10720,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,10720,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,10721,0)
 ;;=D06.1^^68^675^41
 ;;^UTILITY(U,$J,358.3,10721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10721,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,10721,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,10721,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,10722,0)
 ;;=D06.7^^68^675^39
 ;;^UTILITY(U,$J,358.3,10722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10722,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,10722,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,10722,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,10723,0)
 ;;=D04.9^^68^675^42
 ;;^UTILITY(U,$J,358.3,10723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10723,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,10723,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,10723,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,10724,0)
 ;;=C91.11^^68^675^45
 ;;^UTILITY(U,$J,358.3,10724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10724,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,10724,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,10724,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,10725,0)
 ;;=C91.10^^68^675^46
 ;;^UTILITY(U,$J,358.3,10725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10725,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,10725,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,10725,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,10726,0)
 ;;=C92.11^^68^675^47
 ;;^UTILITY(U,$J,358.3,10726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10726,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,10726,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,10726,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,10727,0)
 ;;=C92.10^^68^675^48
 ;;^UTILITY(U,$J,358.3,10727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10727,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,10727,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,10727,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,10728,0)
 ;;=D47.1^^68^675^49
 ;;^UTILITY(U,$J,358.3,10728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10728,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,10728,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,10728,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,10729,0)
 ;;=C82.69^^68^675^50
 ;;^UTILITY(U,$J,358.3,10729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10729,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,10729,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,10729,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,10730,0)
 ;;=C82.60^^68^675^51
 ;;^UTILITY(U,$J,358.3,10730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10730,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
