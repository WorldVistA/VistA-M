IBDEI37E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53816,1,3,0)
 ;;=3^Peripheral T-cell lymphoma, not classified, nodes mult site
 ;;^UTILITY(U,$J,358.3,53816,1,4,0)
 ;;=4^C84.48
 ;;^UTILITY(U,$J,358.3,53816,2)
 ;;=^5001649
 ;;^UTILITY(U,$J,358.3,53817,0)
 ;;=C90.01^^253^2724^41
 ;;^UTILITY(U,$J,358.3,53817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53817,1,3,0)
 ;;=3^Multiple myeloma in remission
 ;;^UTILITY(U,$J,358.3,53817,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,53817,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,53818,0)
 ;;=C90.02^^253^2724^40
 ;;^UTILITY(U,$J,358.3,53818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53818,1,3,0)
 ;;=3^Multiple myeloma in relapse
 ;;^UTILITY(U,$J,358.3,53818,1,4,0)
 ;;=4^C90.02
 ;;^UTILITY(U,$J,358.3,53818,2)
 ;;=^5001753
 ;;^UTILITY(U,$J,358.3,53819,0)
 ;;=C90.11^^253^2724^47
 ;;^UTILITY(U,$J,358.3,53819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53819,1,3,0)
 ;;=3^Plasma cell leukemia in remission
 ;;^UTILITY(U,$J,358.3,53819,1,4,0)
 ;;=4^C90.11
 ;;^UTILITY(U,$J,358.3,53819,2)
 ;;=^267517
 ;;^UTILITY(U,$J,358.3,53820,0)
 ;;=C90.12^^253^2724^46
 ;;^UTILITY(U,$J,358.3,53820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53820,1,3,0)
 ;;=3^Plasma cell leukemia in relapse
 ;;^UTILITY(U,$J,358.3,53820,1,4,0)
 ;;=4^C90.12
 ;;^UTILITY(U,$J,358.3,53820,2)
 ;;=^5001755
 ;;^UTILITY(U,$J,358.3,53821,0)
 ;;=C90.21^^253^2724^25
 ;;^UTILITY(U,$J,358.3,53821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53821,1,3,0)
 ;;=3^Extramedullary plasmacytoma in remission
 ;;^UTILITY(U,$J,358.3,53821,1,4,0)
 ;;=4^C90.21
 ;;^UTILITY(U,$J,358.3,53821,2)
 ;;=^5001757
 ;;^UTILITY(U,$J,358.3,53822,0)
 ;;=C90.31^^253^2724^50
 ;;^UTILITY(U,$J,358.3,53822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53822,1,3,0)
 ;;=3^Solitary plasmacytoma in remission
 ;;^UTILITY(U,$J,358.3,53822,1,4,0)
 ;;=4^C90.31
 ;;^UTILITY(U,$J,358.3,53822,2)
 ;;=^5001760
 ;;^UTILITY(U,$J,358.3,53823,0)
 ;;=C88.8^^253^2724^33
 ;;^UTILITY(U,$J,358.3,53823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53823,1,3,0)
 ;;=3^Malignant immunoproliferative diseases NEC
 ;;^UTILITY(U,$J,358.3,53823,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,53823,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,53824,0)
 ;;=C90.22^^253^2724^24
 ;;^UTILITY(U,$J,358.3,53824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53824,1,3,0)
 ;;=3^Extramedullary plasmacytoma in relapse
 ;;^UTILITY(U,$J,358.3,53824,1,4,0)
 ;;=4^C90.22
 ;;^UTILITY(U,$J,358.3,53824,2)
 ;;=^5001758
 ;;^UTILITY(U,$J,358.3,53825,0)
 ;;=C90.32^^253^2724^49
 ;;^UTILITY(U,$J,358.3,53825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53825,1,3,0)
 ;;=3^Solitary plasmacytoma in relapse
 ;;^UTILITY(U,$J,358.3,53825,1,4,0)
 ;;=4^C90.32
 ;;^UTILITY(U,$J,358.3,53825,2)
 ;;=^5001761
 ;;^UTILITY(U,$J,358.3,53826,0)
 ;;=C91.01^^253^2724^2
 ;;^UTILITY(U,$J,358.3,53826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53826,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,53826,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,53826,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,53827,0)
 ;;=C91.02^^253^2724^1
 ;;^UTILITY(U,$J,358.3,53827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53827,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,53827,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,53827,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,53828,0)
 ;;=C91.11^^253^2724^16
 ;;^UTILITY(U,$J,358.3,53828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53828,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in remission
 ;;^UTILITY(U,$J,358.3,53828,1,4,0)
 ;;=4^C91.11
