IBDEI2UC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47674,1,3,0)
 ;;=3^Acute Monoblastic/Monocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,47674,1,4,0)
 ;;=4^C93.00
 ;;^UTILITY(U,$J,358.3,47674,2)
 ;;=^5001819
 ;;^UTILITY(U,$J,358.3,47675,0)
 ;;=C93.01^^209^2346^13
 ;;^UTILITY(U,$J,358.3,47675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47675,1,3,0)
 ;;=3^Acute Monoblastic/Monocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,47675,1,4,0)
 ;;=4^C93.01
 ;;^UTILITY(U,$J,358.3,47675,2)
 ;;=^5001820
 ;;^UTILITY(U,$J,358.3,47676,0)
 ;;=C93.02^^209^2346^14
 ;;^UTILITY(U,$J,358.3,47676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47676,1,3,0)
 ;;=3^Acute Monoblastic/Monocytic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,47676,1,4,0)
 ;;=4^C93.02
 ;;^UTILITY(U,$J,358.3,47676,2)
 ;;=^5001821
 ;;^UTILITY(U,$J,358.3,47677,0)
 ;;=C93.10^^209^2346^93
 ;;^UTILITY(U,$J,358.3,47677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47677,1,3,0)
 ;;=3^Chronic Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,47677,1,4,0)
 ;;=4^C93.10
 ;;^UTILITY(U,$J,358.3,47677,2)
 ;;=^5001822
 ;;^UTILITY(U,$J,358.3,47678,0)
 ;;=C93.11^^209^2346^92
 ;;^UTILITY(U,$J,358.3,47678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47678,1,3,0)
 ;;=3^Chronic Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,47678,1,4,0)
 ;;=4^C93.11
 ;;^UTILITY(U,$J,358.3,47678,2)
 ;;=^5001823
 ;;^UTILITY(U,$J,358.3,47679,0)
 ;;=C93.12^^209^2346^91
 ;;^UTILITY(U,$J,358.3,47679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47679,1,3,0)
 ;;=3^Chronic Myelomonocytic Leukemia,In Relaspe
 ;;^UTILITY(U,$J,358.3,47679,1,4,0)
 ;;=4^C93.12
 ;;^UTILITY(U,$J,358.3,47679,2)
 ;;=^5001824
 ;;^UTILITY(U,$J,358.3,47680,0)
 ;;=C93.30^^209^2346^238
 ;;^UTILITY(U,$J,358.3,47680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47680,1,3,0)
 ;;=3^Juvenile Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,47680,1,4,0)
 ;;=4^C93.30
 ;;^UTILITY(U,$J,358.3,47680,2)
 ;;=^5001825
 ;;^UTILITY(U,$J,358.3,47681,0)
 ;;=C93.31^^209^2346^237
 ;;^UTILITY(U,$J,358.3,47681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47681,1,3,0)
 ;;=3^Juvenile Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,47681,1,4,0)
 ;;=4^C93.31
 ;;^UTILITY(U,$J,358.3,47681,2)
 ;;=^5001826
 ;;^UTILITY(U,$J,358.3,47682,0)
 ;;=C93.32^^209^2346^236
 ;;^UTILITY(U,$J,358.3,47682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47682,1,3,0)
 ;;=3^Juvenile Myelomonocytic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,47682,1,4,0)
 ;;=4^C93.32
 ;;^UTILITY(U,$J,358.3,47682,2)
 ;;=^5001827
 ;;^UTILITY(U,$J,358.3,47683,0)
 ;;=C93.Z0^^209^2346^343
 ;;^UTILITY(U,$J,358.3,47683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47683,1,3,0)
 ;;=3^Monocytic Leukemia NEC,Not in Remission
 ;;^UTILITY(U,$J,358.3,47683,1,4,0)
 ;;=4^C93.Z0
 ;;^UTILITY(U,$J,358.3,47683,2)
 ;;=^5001831
 ;;^UTILITY(U,$J,358.3,47684,0)
 ;;=C93.Z1^^209^2346^342
 ;;^UTILITY(U,$J,358.3,47684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47684,1,3,0)
 ;;=3^Monocytic Leukemia NEC,In Remission
 ;;^UTILITY(U,$J,358.3,47684,1,4,0)
 ;;=4^C93.Z1
 ;;^UTILITY(U,$J,358.3,47684,2)
 ;;=^5001832
 ;;^UTILITY(U,$J,358.3,47685,0)
 ;;=C93.Z2^^209^2346^341
 ;;^UTILITY(U,$J,358.3,47685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47685,1,3,0)
 ;;=3^Monocytic Leukemia NEC,In Relapse
 ;;^UTILITY(U,$J,358.3,47685,1,4,0)
 ;;=4^C93.Z2
 ;;^UTILITY(U,$J,358.3,47685,2)
 ;;=^5001833
 ;;^UTILITY(U,$J,358.3,47686,0)
 ;;=C93.90^^209^2346^346
 ;;^UTILITY(U,$J,358.3,47686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47686,1,3,0)
 ;;=3^Monocytic Leukemia,Unspec,Not in Remission
