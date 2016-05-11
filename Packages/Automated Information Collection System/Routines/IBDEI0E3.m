IBDEI0E3 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6479,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,6479,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,6479,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,6480,0)
 ;;=C91.00^^30^396^5
 ;;^UTILITY(U,$J,358.3,6480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6480,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,6480,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,6480,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,6481,0)
 ;;=C91.01^^30^396^4
 ;;^UTILITY(U,$J,358.3,6481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6481,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,6481,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,6481,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,6482,0)
 ;;=C92.01^^30^396^7
 ;;^UTILITY(U,$J,358.3,6482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6482,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,6482,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,6482,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,6483,0)
 ;;=C92.00^^30^396^8
 ;;^UTILITY(U,$J,358.3,6483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6483,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,6483,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,6483,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,6484,0)
 ;;=C92.61^^30^396^9
 ;;^UTILITY(U,$J,358.3,6484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6484,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,6484,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,6484,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,6485,0)
 ;;=C92.60^^30^396^10
 ;;^UTILITY(U,$J,358.3,6485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6485,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,6485,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,6485,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,6486,0)
 ;;=C92.A1^^30^396^11
 ;;^UTILITY(U,$J,358.3,6486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6486,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,6486,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,6486,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,6487,0)
 ;;=C92.A0^^30^396^12
 ;;^UTILITY(U,$J,358.3,6487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6487,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,6487,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,6487,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,6488,0)
 ;;=C92.51^^30^396^13
 ;;^UTILITY(U,$J,358.3,6488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6488,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,6488,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,6488,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,6489,0)
 ;;=C92.50^^30^396^14
 ;;^UTILITY(U,$J,358.3,6489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6489,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,6489,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,6489,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,6490,0)
 ;;=C94.40^^30^396^17
 ;;^UTILITY(U,$J,358.3,6490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6490,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,6490,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,6490,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,6491,0)
 ;;=C94.42^^30^396^15
 ;;^UTILITY(U,$J,358.3,6491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6491,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,6491,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,6491,2)
 ;;=^5001845
