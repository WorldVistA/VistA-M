IBDEI1DD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22829,0)
 ;;=C49.9^^104^1064^13
 ;;^UTILITY(U,$J,358.3,22829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22829,1,3,0)
 ;;=3^Malig Neop Connective & Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,22829,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,22829,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,22830,0)
 ;;=C72.0^^104^1064^17
 ;;^UTILITY(U,$J,358.3,22830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22830,1,3,0)
 ;;=3^Malig Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,22830,1,4,0)
 ;;=4^C72.0
 ;;^UTILITY(U,$J,358.3,22830,2)
 ;;=^267292
 ;;^UTILITY(U,$J,358.3,22831,0)
 ;;=C72.1^^104^1064^12
 ;;^UTILITY(U,$J,358.3,22831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22831,1,3,0)
 ;;=3^Malig Neop Cauda Equina
 ;;^UTILITY(U,$J,358.3,22831,1,4,0)
 ;;=4^C72.1
 ;;^UTILITY(U,$J,358.3,22831,2)
 ;;=^5001298
 ;;^UTILITY(U,$J,358.3,22832,0)
 ;;=C92.40^^104^1065^15
 ;;^UTILITY(U,$J,358.3,22832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22832,1,3,0)
 ;;=3^Promyelocytic Leukemia,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,22832,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,22832,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,22833,0)
 ;;=C92.41^^104^1065^14
 ;;^UTILITY(U,$J,358.3,22833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22833,1,3,0)
 ;;=3^Promyelocytic Leukemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,22833,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,22833,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,22834,0)
 ;;=C92.50^^104^1065^11
 ;;^UTILITY(U,$J,358.3,22834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22834,1,3,0)
 ;;=3^Myelomonocytic Leumkemia,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,22834,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,22834,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,22835,0)
 ;;=C92.51^^104^1065^10
 ;;^UTILITY(U,$J,358.3,22835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22835,1,3,0)
 ;;=3^Myelomonocytic Leumkemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,22835,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,22835,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,22836,0)
 ;;=C92.00^^104^1065^4
 ;;^UTILITY(U,$J,358.3,22836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22836,1,3,0)
 ;;=3^Myeloblastic Leukemia,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,22836,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,22836,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,22837,0)
 ;;=C92.01^^104^1065^3
 ;;^UTILITY(U,$J,358.3,22837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22837,1,3,0)
 ;;=3^Myeloblastic Leukemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,22837,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,22837,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,22838,0)
 ;;=C92.10^^104^1065^7
 ;;^UTILITY(U,$J,358.3,22838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22838,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-Positive,Chr,Not in Remission
 ;;^UTILITY(U,$J,358.3,22838,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,22838,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,22839,0)
 ;;=C92.11^^104^1065^6
 ;;^UTILITY(U,$J,358.3,22839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22839,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-Positive,Chr,In Remission
 ;;^UTILITY(U,$J,358.3,22839,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,22839,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,22840,0)
 ;;=C92.20^^104^1065^9
 ;;^UTILITY(U,$J,358.3,22840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22840,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-neg,Atyp Chr,Not in Remission
 ;;^UTILITY(U,$J,358.3,22840,1,4,0)
 ;;=4^C92.20
 ;;^UTILITY(U,$J,358.3,22840,2)
 ;;=^5001795
 ;;^UTILITY(U,$J,358.3,22841,0)
 ;;=C92.21^^104^1065^8
 ;;^UTILITY(U,$J,358.3,22841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22841,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-neg,Atyp Chr,In Remission
