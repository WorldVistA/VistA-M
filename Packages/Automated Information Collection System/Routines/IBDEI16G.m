IBDEI16G ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20022,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,20022,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,20022,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,20023,0)
 ;;=D06.0^^84^929^42
 ;;^UTILITY(U,$J,358.3,20023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20023,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,20023,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,20023,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,20024,0)
 ;;=D06.1^^84^929^43
 ;;^UTILITY(U,$J,358.3,20024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20024,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,20024,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,20024,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,20025,0)
 ;;=D06.7^^84^929^41
 ;;^UTILITY(U,$J,358.3,20025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20025,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,20025,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,20025,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,20026,0)
 ;;=D04.9^^84^929^44
 ;;^UTILITY(U,$J,358.3,20026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20026,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,20026,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,20026,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,20027,0)
 ;;=C91.11^^84^929^47
 ;;^UTILITY(U,$J,358.3,20027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20027,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,20027,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,20027,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,20028,0)
 ;;=C91.10^^84^929^48
 ;;^UTILITY(U,$J,358.3,20028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20028,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,20028,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,20028,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,20029,0)
 ;;=C92.11^^84^929^49
 ;;^UTILITY(U,$J,358.3,20029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20029,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,20029,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,20029,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,20030,0)
 ;;=C92.10^^84^929^50
 ;;^UTILITY(U,$J,358.3,20030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20030,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,20030,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,20030,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,20031,0)
 ;;=D47.1^^84^929^51
 ;;^UTILITY(U,$J,358.3,20031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20031,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,20031,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,20031,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,20032,0)
 ;;=C82.69^^84^929^52
 ;;^UTILITY(U,$J,358.3,20032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20032,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,20032,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,20032,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,20033,0)
 ;;=C82.60^^84^929^53
 ;;^UTILITY(U,$J,358.3,20033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20033,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,20033,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,20033,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,20034,0)
 ;;=D56.2^^84^929^54
 ;;^UTILITY(U,$J,358.3,20034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20034,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,20034,1,4,0)
 ;;=4^D56.2
