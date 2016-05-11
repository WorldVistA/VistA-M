IBDEI0SI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13370,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,13370,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,13371,0)
 ;;=C91.01^^53^593^4
 ;;^UTILITY(U,$J,358.3,13371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13371,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,13371,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,13371,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,13372,0)
 ;;=C92.01^^53^593^7
 ;;^UTILITY(U,$J,358.3,13372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13372,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,13372,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,13372,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,13373,0)
 ;;=C92.00^^53^593^8
 ;;^UTILITY(U,$J,358.3,13373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13373,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,13373,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,13373,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,13374,0)
 ;;=C92.61^^53^593^9
 ;;^UTILITY(U,$J,358.3,13374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13374,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,13374,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,13374,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,13375,0)
 ;;=C92.60^^53^593^10
 ;;^UTILITY(U,$J,358.3,13375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13375,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,13375,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,13375,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,13376,0)
 ;;=C92.A1^^53^593^11
 ;;^UTILITY(U,$J,358.3,13376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13376,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,13376,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,13376,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,13377,0)
 ;;=C92.A0^^53^593^12
 ;;^UTILITY(U,$J,358.3,13377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13377,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,13377,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,13377,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,13378,0)
 ;;=C92.51^^53^593^13
 ;;^UTILITY(U,$J,358.3,13378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13378,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,13378,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,13378,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,13379,0)
 ;;=C92.50^^53^593^14
 ;;^UTILITY(U,$J,358.3,13379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13379,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,13379,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,13379,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,13380,0)
 ;;=C94.40^^53^593^17
 ;;^UTILITY(U,$J,358.3,13380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13380,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,13380,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,13380,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,13381,0)
 ;;=C94.42^^53^593^15
 ;;^UTILITY(U,$J,358.3,13381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13381,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,13381,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,13381,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,13382,0)
 ;;=C94.41^^53^593^16
 ;;^UTILITY(U,$J,358.3,13382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13382,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,13382,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,13382,2)
 ;;=^5001844
