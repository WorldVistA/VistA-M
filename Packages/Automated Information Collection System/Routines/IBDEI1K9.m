IBDEI1K9 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26095,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia B-Cell Type,Not in Remissio
 ;;^UTILITY(U,$J,358.3,26095,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,26095,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,26096,0)
 ;;=C91.11^^127^1271^57
 ;;^UTILITY(U,$J,358.3,26096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26096,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,26096,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,26096,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,26097,0)
 ;;=C92.00^^127^1271^58
 ;;^UTILITY(U,$J,358.3,26097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26097,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,26097,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,26097,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,26098,0)
 ;;=C92.01^^127^1271^59
 ;;^UTILITY(U,$J,358.3,26098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26098,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,26098,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,26098,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,26099,0)
 ;;=C92.41^^127^1271^60
 ;;^UTILITY(U,$J,358.3,26099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26099,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,26099,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,26099,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,26100,0)
 ;;=C92.41^^127^1271^61
 ;;^UTILITY(U,$J,358.3,26100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26100,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,26100,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,26100,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,26101,0)
 ;;=C92.50^^127^1271^62
 ;;^UTILITY(U,$J,358.3,26101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26101,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,26101,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,26101,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,26102,0)
 ;;=C92.51^^127^1271^63
 ;;^UTILITY(U,$J,358.3,26102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26102,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,26102,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,26102,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,26103,0)
 ;;=C92.10^^127^1271^64
 ;;^UTILITY(U,$J,358.3,26103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26103,1,3,0)
 ;;=3^Chronic Myeloid Leukemia BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,26103,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,26103,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,26104,0)
 ;;=C92.11^^127^1271^65
 ;;^UTILITY(U,$J,358.3,26104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26104,1,3,0)
 ;;=3^Chronic Myeloid Leukemia BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,26104,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,26104,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,26105,0)
 ;;=D04.9^^127^1271^66
 ;;^UTILITY(U,$J,358.3,26105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26105,1,3,0)
 ;;=3^Carcinoma in Situ of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,26105,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,26105,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,26106,0)
 ;;=D05.91^^127^1271^67
 ;;^UTILITY(U,$J,358.3,26106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26106,1,3,0)
 ;;=3^Carcinoma in Situ of Right Breast
 ;;^UTILITY(U,$J,358.3,26106,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,26106,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,26107,0)
 ;;=D05.92^^127^1271^68
 ;;^UTILITY(U,$J,358.3,26107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26107,1,3,0)
 ;;=3^Carcinoma in Situ of Left Breast
 ;;^UTILITY(U,$J,358.3,26107,1,4,0)
 ;;=4^D05.92
