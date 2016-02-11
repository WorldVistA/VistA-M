IBDEI2UB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47662,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,47662,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,47662,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,47663,0)
 ;;=C92.61^^209^2346^20
 ;;^UTILITY(U,$J,358.3,47663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47663,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,47663,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,47663,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,47664,0)
 ;;=C92.62^^209^2346^21
 ;;^UTILITY(U,$J,358.3,47664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47664,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Relapse
 ;;^UTILITY(U,$J,358.3,47664,1,4,0)
 ;;=4^C92.62
 ;;^UTILITY(U,$J,358.3,47664,2)
 ;;=^5001809
 ;;^UTILITY(U,$J,358.3,47665,0)
 ;;=C92.A0^^209^2346^22
 ;;^UTILITY(U,$J,358.3,47665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47665,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilineage Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,47665,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,47665,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,47666,0)
 ;;=C92.A1^^209^2346^23
 ;;^UTILITY(U,$J,358.3,47666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47666,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilineage Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,47666,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,47666,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,47667,0)
 ;;=C92.A2^^209^2346^24
 ;;^UTILITY(U,$J,358.3,47667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47667,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilineage Dysplasia,In Relapse
 ;;^UTILITY(U,$J,358.3,47667,1,4,0)
 ;;=4^C92.A2
 ;;^UTILITY(U,$J,358.3,47667,2)
 ;;=^5001815
 ;;^UTILITY(U,$J,358.3,47668,0)
 ;;=C92.Z0^^209^2346^365
 ;;^UTILITY(U,$J,358.3,47668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47668,1,3,0)
 ;;=3^Myeloid Leukemia NEC,Not in Remission
 ;;^UTILITY(U,$J,358.3,47668,1,4,0)
 ;;=4^C92.Z0
 ;;^UTILITY(U,$J,358.3,47668,2)
 ;;=^5001816
 ;;^UTILITY(U,$J,358.3,47669,0)
 ;;=C92.Z1^^209^2346^364
 ;;^UTILITY(U,$J,358.3,47669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47669,1,3,0)
 ;;=3^Myeloid Leukemia NEC,In Remission
 ;;^UTILITY(U,$J,358.3,47669,1,4,0)
 ;;=4^C92.Z1
 ;;^UTILITY(U,$J,358.3,47669,2)
 ;;=^5001817
 ;;^UTILITY(U,$J,358.3,47670,0)
 ;;=C92.Z2^^209^2346^363
 ;;^UTILITY(U,$J,358.3,47670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47670,1,3,0)
 ;;=3^Myeloid Leukemia NEC,In Relapse
 ;;^UTILITY(U,$J,358.3,47670,1,4,0)
 ;;=4^C92.Z2
 ;;^UTILITY(U,$J,358.3,47670,2)
 ;;=^5001818
 ;;^UTILITY(U,$J,358.3,47671,0)
 ;;=C92.90^^209^2346^368
 ;;^UTILITY(U,$J,358.3,47671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47671,1,3,0)
 ;;=3^Myeloid Leukemia,Unspec,Not in Remission
 ;;^UTILITY(U,$J,358.3,47671,1,4,0)
 ;;=4^C92.90
 ;;^UTILITY(U,$J,358.3,47671,2)
 ;;=^5001810
 ;;^UTILITY(U,$J,358.3,47672,0)
 ;;=C92.91^^209^2346^367
 ;;^UTILITY(U,$J,358.3,47672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47672,1,3,0)
 ;;=3^Myeloid Leukemia,Unspec,In Remission
 ;;^UTILITY(U,$J,358.3,47672,1,4,0)
 ;;=4^C92.91
 ;;^UTILITY(U,$J,358.3,47672,2)
 ;;=^5001811
 ;;^UTILITY(U,$J,358.3,47673,0)
 ;;=C92.92^^209^2346^366
 ;;^UTILITY(U,$J,358.3,47673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47673,1,3,0)
 ;;=3^Myeloid Leukemia,Unspec,In Relapse
 ;;^UTILITY(U,$J,358.3,47673,1,4,0)
 ;;=4^C92.92
 ;;^UTILITY(U,$J,358.3,47673,2)
 ;;=^5001812
 ;;^UTILITY(U,$J,358.3,47674,0)
 ;;=C93.00^^209^2346^15
 ;;^UTILITY(U,$J,358.3,47674,1,0)
 ;;=^358.31IA^4^2
