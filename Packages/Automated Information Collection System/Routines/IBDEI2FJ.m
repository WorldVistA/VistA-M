IBDEI2FJ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41213,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,41213,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,41213,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,41214,0)
 ;;=C91.00^^159^2004^5
 ;;^UTILITY(U,$J,358.3,41214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41214,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,41214,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,41214,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,41215,0)
 ;;=C91.01^^159^2004^4
 ;;^UTILITY(U,$J,358.3,41215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41215,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,41215,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,41215,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,41216,0)
 ;;=C92.01^^159^2004^7
 ;;^UTILITY(U,$J,358.3,41216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41216,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,41216,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,41216,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,41217,0)
 ;;=C92.00^^159^2004^8
 ;;^UTILITY(U,$J,358.3,41217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41217,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,41217,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,41217,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,41218,0)
 ;;=C92.61^^159^2004^9
 ;;^UTILITY(U,$J,358.3,41218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41218,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,41218,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,41218,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,41219,0)
 ;;=C92.60^^159^2004^10
 ;;^UTILITY(U,$J,358.3,41219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41219,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,41219,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,41219,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,41220,0)
 ;;=C92.A1^^159^2004^11
 ;;^UTILITY(U,$J,358.3,41220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41220,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,41220,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,41220,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,41221,0)
 ;;=C92.A0^^159^2004^12
 ;;^UTILITY(U,$J,358.3,41221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41221,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,41221,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,41221,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,41222,0)
 ;;=C92.51^^159^2004^13
 ;;^UTILITY(U,$J,358.3,41222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41222,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,41222,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,41222,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,41223,0)
 ;;=C92.50^^159^2004^14
 ;;^UTILITY(U,$J,358.3,41223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41223,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,41223,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,41223,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,41224,0)
 ;;=C94.40^^159^2004^17
 ;;^UTILITY(U,$J,358.3,41224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41224,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,41224,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,41224,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,41225,0)
 ;;=C94.42^^159^2004^15
 ;;^UTILITY(U,$J,358.3,41225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41225,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
