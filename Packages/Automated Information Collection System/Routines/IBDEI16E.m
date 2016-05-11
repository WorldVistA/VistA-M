IBDEI16E ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19996,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,19996,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,19997,0)
 ;;=C91.01^^84^929^4
 ;;^UTILITY(U,$J,358.3,19997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19997,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,19997,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,19997,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,19998,0)
 ;;=C92.01^^84^929^7
 ;;^UTILITY(U,$J,358.3,19998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19998,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,19998,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,19998,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,19999,0)
 ;;=C92.00^^84^929^8
 ;;^UTILITY(U,$J,358.3,19999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19999,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,19999,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,19999,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,20000,0)
 ;;=C92.61^^84^929^9
 ;;^UTILITY(U,$J,358.3,20000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20000,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,20000,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,20000,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,20001,0)
 ;;=C92.60^^84^929^10
 ;;^UTILITY(U,$J,358.3,20001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20001,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,20001,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,20001,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,20002,0)
 ;;=C92.A1^^84^929^11
 ;;^UTILITY(U,$J,358.3,20002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20002,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,20002,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,20002,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,20003,0)
 ;;=C92.A0^^84^929^12
 ;;^UTILITY(U,$J,358.3,20003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20003,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,20003,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,20003,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,20004,0)
 ;;=C92.51^^84^929^13
 ;;^UTILITY(U,$J,358.3,20004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20004,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,20004,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,20004,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,20005,0)
 ;;=C92.50^^84^929^14
 ;;^UTILITY(U,$J,358.3,20005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20005,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,20005,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,20005,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,20006,0)
 ;;=C94.40^^84^929^17
 ;;^UTILITY(U,$J,358.3,20006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20006,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,20006,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,20006,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,20007,0)
 ;;=C94.42^^84^929^15
 ;;^UTILITY(U,$J,358.3,20007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20007,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,20007,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,20007,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,20008,0)
 ;;=C94.41^^84^929^16
 ;;^UTILITY(U,$J,358.3,20008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20008,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,20008,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,20008,2)
 ;;=^5001844
