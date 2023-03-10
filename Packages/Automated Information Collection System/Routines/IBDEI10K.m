IBDEI10K ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16487,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,16488,0)
 ;;=D06.0^^61^775^47
 ;;^UTILITY(U,$J,358.3,16488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16488,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,16488,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,16488,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,16489,0)
 ;;=D06.1^^61^775^48
 ;;^UTILITY(U,$J,358.3,16489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16489,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,16489,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,16489,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,16490,0)
 ;;=D06.7^^61^775^46
 ;;^UTILITY(U,$J,358.3,16490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16490,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,16490,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,16490,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,16491,0)
 ;;=D04.9^^61^775^49
 ;;^UTILITY(U,$J,358.3,16491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16491,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,16491,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,16491,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,16492,0)
 ;;=C91.11^^61^775^52
 ;;^UTILITY(U,$J,358.3,16492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16492,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,16492,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,16492,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,16493,0)
 ;;=C91.10^^61^775^53
 ;;^UTILITY(U,$J,358.3,16493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16493,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,16493,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,16493,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,16494,0)
 ;;=C92.11^^61^775^54
 ;;^UTILITY(U,$J,358.3,16494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16494,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,16494,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,16494,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,16495,0)
 ;;=C92.10^^61^775^55
 ;;^UTILITY(U,$J,358.3,16495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16495,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,16495,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,16495,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,16496,0)
 ;;=D47.1^^61^775^56
 ;;^UTILITY(U,$J,358.3,16496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16496,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,16496,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,16496,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,16497,0)
 ;;=C82.69^^61^775^57
 ;;^UTILITY(U,$J,358.3,16497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16497,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,16497,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,16497,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,16498,0)
 ;;=C82.60^^61^775^58
 ;;^UTILITY(U,$J,358.3,16498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16498,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,16498,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,16498,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,16499,0)
 ;;=D56.2^^61^775^59
 ;;^UTILITY(U,$J,358.3,16499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16499,1,3,0)
 ;;=3^Delta-Beta Thalassemia
