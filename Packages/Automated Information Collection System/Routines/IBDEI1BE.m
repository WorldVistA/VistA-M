IBDEI1BE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22351,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,22352,0)
 ;;=C91.10^^87^981^48
 ;;^UTILITY(U,$J,358.3,22352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22352,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,22352,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,22352,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,22353,0)
 ;;=C92.11^^87^981^49
 ;;^UTILITY(U,$J,358.3,22353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22353,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,22353,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,22353,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,22354,0)
 ;;=C92.10^^87^981^50
 ;;^UTILITY(U,$J,358.3,22354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22354,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,22354,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,22354,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,22355,0)
 ;;=D47.1^^87^981^51
 ;;^UTILITY(U,$J,358.3,22355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22355,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,22355,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,22355,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,22356,0)
 ;;=C82.69^^87^981^52
 ;;^UTILITY(U,$J,358.3,22356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22356,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,22356,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,22356,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,22357,0)
 ;;=C82.60^^87^981^53
 ;;^UTILITY(U,$J,358.3,22357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22357,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,22357,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,22357,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,22358,0)
 ;;=D56.2^^87^981^54
 ;;^UTILITY(U,$J,358.3,22358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22358,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,22358,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,22358,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,22359,0)
 ;;=D75.9^^87^981^55
 ;;^UTILITY(U,$J,358.3,22359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22359,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,22359,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,22359,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,22360,0)
 ;;=D59.0^^87^981^58
 ;;^UTILITY(U,$J,358.3,22360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22360,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,22360,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,22360,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,22361,0)
 ;;=D59.2^^87^981^59
 ;;^UTILITY(U,$J,358.3,22361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22361,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,22361,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,22361,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,22362,0)
 ;;=R59.9^^87^981^62
 ;;^UTILITY(U,$J,358.3,22362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22362,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,22362,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,22362,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,22363,0)
 ;;=D47.3^^87^981^63
 ;;^UTILITY(U,$J,358.3,22363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22363,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,22363,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,22363,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,22364,0)
 ;;=C82.09^^87^981^64
 ;;^UTILITY(U,$J,358.3,22364,1,0)
 ;;=^358.31IA^4^2
