IBDEI1S1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30196,1,4,0)
 ;;=4^C96.4
 ;;^UTILITY(U,$J,358.3,30196,2)
 ;;=^5001861
 ;;^UTILITY(U,$J,358.3,30197,0)
 ;;=C96.9^^118^1502^50
 ;;^UTILITY(U,$J,358.3,30197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30197,1,3,0)
 ;;=3^Malig neoplm of lymphoid, hematpoetc and rel tissue, unsp
 ;;^UTILITY(U,$J,358.3,30197,1,4,0)
 ;;=4^C96.9
 ;;^UTILITY(U,$J,358.3,30197,2)
 ;;=^5001864
 ;;^UTILITY(U,$J,358.3,30198,0)
 ;;=C90.00^^118^1502^58
 ;;^UTILITY(U,$J,358.3,30198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30198,1,3,0)
 ;;=3^Multiple myeloma not having achieved remission
 ;;^UTILITY(U,$J,358.3,30198,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,30198,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,30199,0)
 ;;=C90.01^^118^1502^57
 ;;^UTILITY(U,$J,358.3,30199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30199,1,3,0)
 ;;=3^Multiple myeloma in remission
 ;;^UTILITY(U,$J,358.3,30199,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,30199,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,30200,0)
 ;;=C90.02^^118^1502^56
 ;;^UTILITY(U,$J,358.3,30200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30200,1,3,0)
 ;;=3^Multiple myeloma in relapse
 ;;^UTILITY(U,$J,358.3,30200,1,4,0)
 ;;=4^C90.02
 ;;^UTILITY(U,$J,358.3,30200,2)
 ;;=^5001753
 ;;^UTILITY(U,$J,358.3,30201,0)
 ;;=C91.00^^118^1502^1
 ;;^UTILITY(U,$J,358.3,30201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30201,1,3,0)
 ;;=3^Acute lymphoblastic leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,30201,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,30201,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,30202,0)
 ;;=C91.01^^118^1502^3
 ;;^UTILITY(U,$J,358.3,30202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30202,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,30202,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,30202,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,30203,0)
 ;;=C91.02^^118^1502^2
 ;;^UTILITY(U,$J,358.3,30203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30203,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,30203,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,30203,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,30204,0)
 ;;=C91.10^^118^1502^13
 ;;^UTILITY(U,$J,358.3,30204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30204,1,3,0)
 ;;=3^Chronic lymphocytic leuk of B-cell type not achieve remis
 ;;^UTILITY(U,$J,358.3,30204,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,30204,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,30205,0)
 ;;=C91.11^^118^1502^14
 ;;^UTILITY(U,$J,358.3,30205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30205,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in remission
 ;;^UTILITY(U,$J,358.3,30205,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,30205,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,30206,0)
 ;;=C91.12^^118^1502^15
 ;;^UTILITY(U,$J,358.3,30206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30206,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in relapse
 ;;^UTILITY(U,$J,358.3,30206,1,4,0)
 ;;=4^C91.12
 ;;^UTILITY(U,$J,358.3,30206,2)
 ;;=^5001767
 ;;^UTILITY(U,$J,358.3,30207,0)
 ;;=D47.1^^118^1502^16
 ;;^UTILITY(U,$J,358.3,30207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30207,1,3,0)
 ;;=3^Chronic myeloproliferative disease
 ;;^UTILITY(U,$J,358.3,30207,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,30207,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,30208,0)
 ;;=C94.42^^118^1502^5
 ;;^UTILITY(U,$J,358.3,30208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30208,1,3,0)
 ;;=3^Acute panmyelosis with myelofibrosis, in relapse
 ;;^UTILITY(U,$J,358.3,30208,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,30208,2)
 ;;=^5001845
