IBDEI1SD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29903,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,29904,0)
 ;;=C92.01^^135^1372^7
 ;;^UTILITY(U,$J,358.3,29904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29904,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,29904,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,29904,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,29905,0)
 ;;=C92.00^^135^1372^8
 ;;^UTILITY(U,$J,358.3,29905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29905,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,29905,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,29905,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,29906,0)
 ;;=C92.61^^135^1372^9
 ;;^UTILITY(U,$J,358.3,29906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29906,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,29906,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,29906,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,29907,0)
 ;;=C92.60^^135^1372^10
 ;;^UTILITY(U,$J,358.3,29907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29907,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,29907,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,29907,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,29908,0)
 ;;=C92.A1^^135^1372^11
 ;;^UTILITY(U,$J,358.3,29908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29908,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,29908,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,29908,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,29909,0)
 ;;=C92.A0^^135^1372^12
 ;;^UTILITY(U,$J,358.3,29909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29909,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,29909,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,29909,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,29910,0)
 ;;=C92.51^^135^1372^13
 ;;^UTILITY(U,$J,358.3,29910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29910,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,29910,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,29910,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,29911,0)
 ;;=C92.50^^135^1372^14
 ;;^UTILITY(U,$J,358.3,29911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29911,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,29911,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,29911,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,29912,0)
 ;;=C94.40^^135^1372^17
 ;;^UTILITY(U,$J,358.3,29912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29912,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,29912,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,29912,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,29913,0)
 ;;=C94.42^^135^1372^15
 ;;^UTILITY(U,$J,358.3,29913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29913,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,29913,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,29913,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,29914,0)
 ;;=C94.41^^135^1372^16
 ;;^UTILITY(U,$J,358.3,29914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29914,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,29914,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,29914,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,29915,0)
 ;;=D62.^^135^1372^18
 ;;^UTILITY(U,$J,358.3,29915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29915,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,29915,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,29915,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,29916,0)
 ;;=C92.41^^135^1372^19
