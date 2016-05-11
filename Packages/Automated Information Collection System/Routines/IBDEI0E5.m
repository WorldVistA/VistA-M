IBDEI0E5 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6505,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,6505,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,6505,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,6506,0)
 ;;=D06.9^^30^396^38
 ;;^UTILITY(U,$J,358.3,6506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6506,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,6506,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,6506,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,6507,0)
 ;;=D06.0^^30^396^40
 ;;^UTILITY(U,$J,358.3,6507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6507,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,6507,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,6507,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,6508,0)
 ;;=D06.1^^30^396^41
 ;;^UTILITY(U,$J,358.3,6508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6508,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,6508,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,6508,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,6509,0)
 ;;=D06.7^^30^396^39
 ;;^UTILITY(U,$J,358.3,6509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6509,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,6509,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,6509,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,6510,0)
 ;;=D04.9^^30^396^42
 ;;^UTILITY(U,$J,358.3,6510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6510,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,6510,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,6510,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,6511,0)
 ;;=C91.11^^30^396^45
 ;;^UTILITY(U,$J,358.3,6511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6511,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,6511,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,6511,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,6512,0)
 ;;=C91.10^^30^396^46
 ;;^UTILITY(U,$J,358.3,6512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6512,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,6512,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,6512,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,6513,0)
 ;;=C92.11^^30^396^47
 ;;^UTILITY(U,$J,358.3,6513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6513,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,6513,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,6513,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,6514,0)
 ;;=C92.10^^30^396^48
 ;;^UTILITY(U,$J,358.3,6514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6514,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,6514,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,6514,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,6515,0)
 ;;=D47.1^^30^396^49
 ;;^UTILITY(U,$J,358.3,6515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6515,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,6515,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,6515,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,6516,0)
 ;;=C82.69^^30^396^50
 ;;^UTILITY(U,$J,358.3,6516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6516,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6516,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,6516,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,6517,0)
 ;;=C82.60^^30^396^51
 ;;^UTILITY(U,$J,358.3,6517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6517,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,6517,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,6517,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,6518,0)
 ;;=D56.2^^30^396^52
