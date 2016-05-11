IBDEI1ZU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33829,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,33829,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,33829,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,33830,0)
 ;;=C91.00^^131^1680^5
 ;;^UTILITY(U,$J,358.3,33830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33830,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,33830,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,33830,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,33831,0)
 ;;=C91.01^^131^1680^4
 ;;^UTILITY(U,$J,358.3,33831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33831,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,33831,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,33831,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,33832,0)
 ;;=C92.01^^131^1680^7
 ;;^UTILITY(U,$J,358.3,33832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33832,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,33832,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,33832,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,33833,0)
 ;;=C92.00^^131^1680^8
 ;;^UTILITY(U,$J,358.3,33833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33833,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,33833,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,33833,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,33834,0)
 ;;=C92.61^^131^1680^9
 ;;^UTILITY(U,$J,358.3,33834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33834,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,33834,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,33834,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,33835,0)
 ;;=C92.60^^131^1680^10
 ;;^UTILITY(U,$J,358.3,33835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33835,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,33835,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,33835,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,33836,0)
 ;;=C92.A1^^131^1680^11
 ;;^UTILITY(U,$J,358.3,33836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33836,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,33836,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,33836,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,33837,0)
 ;;=C92.A0^^131^1680^12
 ;;^UTILITY(U,$J,358.3,33837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33837,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,33837,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,33837,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,33838,0)
 ;;=C92.51^^131^1680^13
 ;;^UTILITY(U,$J,358.3,33838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33838,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,33838,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,33838,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,33839,0)
 ;;=C92.50^^131^1680^14
 ;;^UTILITY(U,$J,358.3,33839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33839,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,33839,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,33839,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,33840,0)
 ;;=C94.40^^131^1680^17
 ;;^UTILITY(U,$J,358.3,33840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33840,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,33840,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,33840,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,33841,0)
 ;;=C94.42^^131^1680^15
 ;;^UTILITY(U,$J,358.3,33841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33841,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
