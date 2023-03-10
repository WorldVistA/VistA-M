IBDEI10I ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16463,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,16463,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,16464,0)
 ;;=C92.00^^61^775^8
 ;;^UTILITY(U,$J,358.3,16464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16464,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,16464,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,16464,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,16465,0)
 ;;=C92.61^^61^775^9
 ;;^UTILITY(U,$J,358.3,16465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16465,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,16465,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,16465,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,16466,0)
 ;;=C92.60^^61^775^10
 ;;^UTILITY(U,$J,358.3,16466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16466,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,16466,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,16466,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,16467,0)
 ;;=C92.A1^^61^775^11
 ;;^UTILITY(U,$J,358.3,16467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16467,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,16467,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,16467,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,16468,0)
 ;;=C92.A0^^61^775^12
 ;;^UTILITY(U,$J,358.3,16468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16468,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,16468,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,16468,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,16469,0)
 ;;=C92.51^^61^775^13
 ;;^UTILITY(U,$J,358.3,16469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16469,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,16469,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,16469,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,16470,0)
 ;;=C92.50^^61^775^14
 ;;^UTILITY(U,$J,358.3,16470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16470,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,16470,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,16470,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,16471,0)
 ;;=C94.40^^61^775^17
 ;;^UTILITY(U,$J,358.3,16471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16471,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,16471,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,16471,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,16472,0)
 ;;=C94.42^^61^775^15
 ;;^UTILITY(U,$J,358.3,16472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16472,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,16472,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,16472,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,16473,0)
 ;;=C94.41^^61^775^16
 ;;^UTILITY(U,$J,358.3,16473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16473,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,16473,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,16473,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,16474,0)
 ;;=D62.^^61^775^18
 ;;^UTILITY(U,$J,358.3,16474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16474,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,16474,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,16474,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,16475,0)
 ;;=C92.41^^61^775^19
 ;;^UTILITY(U,$J,358.3,16475,1,0)
 ;;=^358.31IA^4^2
