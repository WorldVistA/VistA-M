IBDEI0NE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10692,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,10692,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,10692,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,10693,0)
 ;;=C91.00^^68^675^5
 ;;^UTILITY(U,$J,358.3,10693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10693,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,10693,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,10693,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,10694,0)
 ;;=C91.01^^68^675^4
 ;;^UTILITY(U,$J,358.3,10694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10694,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,10694,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,10694,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,10695,0)
 ;;=C92.01^^68^675^7
 ;;^UTILITY(U,$J,358.3,10695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10695,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,10695,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,10695,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,10696,0)
 ;;=C92.00^^68^675^8
 ;;^UTILITY(U,$J,358.3,10696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10696,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,10696,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,10696,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,10697,0)
 ;;=C92.61^^68^675^9
 ;;^UTILITY(U,$J,358.3,10697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10697,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,10697,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,10697,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,10698,0)
 ;;=C92.60^^68^675^10
 ;;^UTILITY(U,$J,358.3,10698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10698,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,10698,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,10698,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,10699,0)
 ;;=C92.A1^^68^675^11
 ;;^UTILITY(U,$J,358.3,10699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10699,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,10699,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,10699,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,10700,0)
 ;;=C92.A0^^68^675^12
 ;;^UTILITY(U,$J,358.3,10700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10700,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,10700,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,10700,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,10701,0)
 ;;=C92.51^^68^675^13
 ;;^UTILITY(U,$J,358.3,10701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10701,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,10701,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,10701,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,10702,0)
 ;;=C92.50^^68^675^14
 ;;^UTILITY(U,$J,358.3,10702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10702,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,10702,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,10702,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,10703,0)
 ;;=C94.40^^68^675^17
 ;;^UTILITY(U,$J,358.3,10703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10703,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,10703,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,10703,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,10704,0)
 ;;=C94.42^^68^675^15
 ;;^UTILITY(U,$J,358.3,10704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10704,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
