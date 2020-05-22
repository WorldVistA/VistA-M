IBDEI10X ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16461,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,16461,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,16461,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,16462,0)
 ;;=C91.10^^88^879^49
 ;;^UTILITY(U,$J,358.3,16462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16462,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,16462,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,16462,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,16463,0)
 ;;=C92.11^^88^879^50
 ;;^UTILITY(U,$J,358.3,16463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16463,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,16463,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,16463,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,16464,0)
 ;;=C92.10^^88^879^51
 ;;^UTILITY(U,$J,358.3,16464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16464,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,16464,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,16464,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,16465,0)
 ;;=D47.1^^88^879^52
 ;;^UTILITY(U,$J,358.3,16465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16465,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,16465,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,16465,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,16466,0)
 ;;=C82.69^^88^879^53
 ;;^UTILITY(U,$J,358.3,16466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16466,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,16466,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,16466,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,16467,0)
 ;;=C82.60^^88^879^54
 ;;^UTILITY(U,$J,358.3,16467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16467,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,16467,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,16467,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,16468,0)
 ;;=D56.2^^88^879^55
 ;;^UTILITY(U,$J,358.3,16468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16468,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,16468,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,16468,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,16469,0)
 ;;=D75.9^^88^879^56
 ;;^UTILITY(U,$J,358.3,16469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16469,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,16469,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,16469,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,16470,0)
 ;;=D59.0^^88^879^59
 ;;^UTILITY(U,$J,358.3,16470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16470,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,16470,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,16470,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,16471,0)
 ;;=D59.2^^88^879^60
 ;;^UTILITY(U,$J,358.3,16471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16471,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,16471,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,16471,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,16472,0)
 ;;=R59.9^^88^879^63
 ;;^UTILITY(U,$J,358.3,16472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16472,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,16472,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,16472,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,16473,0)
 ;;=D47.3^^88^879^64
