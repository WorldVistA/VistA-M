IBDEI0YI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16202,1,3,0)
 ;;=3^SCC of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,16202,1,4,0)
 ;;=4^C44.92
 ;;^UTILITY(U,$J,358.3,16202,2)
 ;;=^5001093
 ;;^UTILITY(U,$J,358.3,16203,0)
 ;;=C49.9^^61^726^13
 ;;^UTILITY(U,$J,358.3,16203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16203,1,3,0)
 ;;=3^Malig Neop Connective & Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,16203,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,16203,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,16204,0)
 ;;=C72.0^^61^726^17
 ;;^UTILITY(U,$J,358.3,16204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16204,1,3,0)
 ;;=3^Malig Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,16204,1,4,0)
 ;;=4^C72.0
 ;;^UTILITY(U,$J,358.3,16204,2)
 ;;=^267292
 ;;^UTILITY(U,$J,358.3,16205,0)
 ;;=C72.1^^61^726^12
 ;;^UTILITY(U,$J,358.3,16205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16205,1,3,0)
 ;;=3^Malig Neop Cauda Equina
 ;;^UTILITY(U,$J,358.3,16205,1,4,0)
 ;;=4^C72.1
 ;;^UTILITY(U,$J,358.3,16205,2)
 ;;=^5001298
 ;;^UTILITY(U,$J,358.3,16206,0)
 ;;=C92.40^^61^727^15
 ;;^UTILITY(U,$J,358.3,16206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16206,1,3,0)
 ;;=3^Promyelocytic Leukemia,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,16206,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,16206,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,16207,0)
 ;;=C92.41^^61^727^14
 ;;^UTILITY(U,$J,358.3,16207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16207,1,3,0)
 ;;=3^Promyelocytic Leukemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,16207,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,16207,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,16208,0)
 ;;=C92.50^^61^727^11
 ;;^UTILITY(U,$J,358.3,16208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16208,1,3,0)
 ;;=3^Myelomonocytic Leumkemia,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,16208,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,16208,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,16209,0)
 ;;=C92.51^^61^727^10
 ;;^UTILITY(U,$J,358.3,16209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16209,1,3,0)
 ;;=3^Myelomonocytic Leumkemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,16209,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,16209,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,16210,0)
 ;;=C92.00^^61^727^4
 ;;^UTILITY(U,$J,358.3,16210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16210,1,3,0)
 ;;=3^Myeloblastic Leukemia,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,16210,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,16210,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,16211,0)
 ;;=C92.01^^61^727^3
 ;;^UTILITY(U,$J,358.3,16211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16211,1,3,0)
 ;;=3^Myeloblastic Leukemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,16211,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,16211,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,16212,0)
 ;;=C92.10^^61^727^7
 ;;^UTILITY(U,$J,358.3,16212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16212,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-Positive,Chr,Not in Remission
 ;;^UTILITY(U,$J,358.3,16212,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,16212,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,16213,0)
 ;;=C92.11^^61^727^6
 ;;^UTILITY(U,$J,358.3,16213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16213,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-Positive,Chr,In Remission
 ;;^UTILITY(U,$J,358.3,16213,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,16213,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,16214,0)
 ;;=C92.20^^61^727^9
 ;;^UTILITY(U,$J,358.3,16214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16214,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-neg,Atyp Chr,Not in Remission
 ;;^UTILITY(U,$J,358.3,16214,1,4,0)
 ;;=4^C92.20
