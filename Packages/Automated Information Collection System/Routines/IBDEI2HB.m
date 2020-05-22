IBDEI2HB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39588,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,39588,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,39588,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,39589,0)
 ;;=C91.10^^152^2000^49
 ;;^UTILITY(U,$J,358.3,39589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39589,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,39589,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,39589,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,39590,0)
 ;;=C92.11^^152^2000^50
 ;;^UTILITY(U,$J,358.3,39590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39590,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,39590,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,39590,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,39591,0)
 ;;=C92.10^^152^2000^51
 ;;^UTILITY(U,$J,358.3,39591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39591,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,39591,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,39591,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,39592,0)
 ;;=D47.1^^152^2000^52
 ;;^UTILITY(U,$J,358.3,39592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39592,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,39592,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,39592,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,39593,0)
 ;;=C82.69^^152^2000^53
 ;;^UTILITY(U,$J,358.3,39593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39593,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,39593,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,39593,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,39594,0)
 ;;=C82.60^^152^2000^54
 ;;^UTILITY(U,$J,358.3,39594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39594,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,39594,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,39594,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,39595,0)
 ;;=D56.2^^152^2000^55
 ;;^UTILITY(U,$J,358.3,39595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39595,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,39595,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,39595,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,39596,0)
 ;;=D75.9^^152^2000^56
 ;;^UTILITY(U,$J,358.3,39596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39596,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,39596,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,39596,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,39597,0)
 ;;=D59.0^^152^2000^59
 ;;^UTILITY(U,$J,358.3,39597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39597,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,39597,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,39597,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,39598,0)
 ;;=D59.2^^152^2000^60
 ;;^UTILITY(U,$J,358.3,39598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39598,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,39598,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,39598,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,39599,0)
 ;;=R59.9^^152^2000^63
 ;;^UTILITY(U,$J,358.3,39599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39599,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,39599,1,4,0)
 ;;=4^R59.9
