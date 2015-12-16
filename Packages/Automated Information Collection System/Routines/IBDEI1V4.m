IBDEI1V4 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32781,0)
 ;;=D05.80^^182^1992^34
 ;;^UTILITY(U,$J,358.3,32781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32781,1,3,0)
 ;;=3^Carcinoma in Situ Unspec Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,32781,1,4,0)
 ;;=4^D05.80
 ;;^UTILITY(U,$J,358.3,32781,2)
 ;;=^5001932
 ;;^UTILITY(U,$J,358.3,32782,0)
 ;;=D56.8^^182^1992^175
 ;;^UTILITY(U,$J,358.3,32782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32782,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,32782,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,32782,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,32783,0)
 ;;=C82.89^^182^1992^71
 ;;^UTILITY(U,$J,358.3,32783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32783,1,3,0)
 ;;=3^Follicular Lymphoma,Extranodal/Solid Organ Sites,Other Types
 ;;^UTILITY(U,$J,358.3,32783,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,32783,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,32784,0)
 ;;=D51.8^^182^1992^182
 ;;^UTILITY(U,$J,358.3,32784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32784,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemias,Other
 ;;^UTILITY(U,$J,358.3,32784,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,32784,2)
 ;;=^5002288
 ;;^UTILITY(U,$J,358.3,32785,0)
 ;;=I80.9^^182^1992^167
 ;;^UTILITY(U,$J,358.3,32785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32785,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,32785,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,32785,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,32786,0)
 ;;=D45.^^182^1992^168
 ;;^UTILITY(U,$J,358.3,32786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32786,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,32786,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,32786,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,32787,0)
 ;;=C77.3^^182^1992^104
 ;;^UTILITY(U,$J,358.3,32787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32787,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Notes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,32787,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,32787,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,32788,0)
 ;;=C77.2^^182^1992^120
 ;;^UTILITY(U,$J,358.3,32788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32788,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,32788,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,32788,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,32789,0)
 ;;=C77.1^^182^1992^121
 ;;^UTILITY(U,$J,358.3,32789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32789,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,32789,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,32789,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,32790,0)
 ;;=C77.0^^182^1992^136
 ;;^UTILITY(U,$J,358.3,32790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32790,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,32790,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,32790,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,32791,0)
 ;;=C77.8^^182^1992^137
 ;;^UTILITY(U,$J,358.3,32791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32791,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,32791,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,32791,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,32792,0)
 ;;=C79.51^^182^1992^107
 ;;^UTILITY(U,$J,358.3,32792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32792,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,32792,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,32792,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,32793,0)
 ;;=C79.52^^182^1992^106
 ;;^UTILITY(U,$J,358.3,32793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32793,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
