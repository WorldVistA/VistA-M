IBDEI14X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18955,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,18955,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,18955,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,18956,0)
 ;;=C82.89^^94^916^74
 ;;^UTILITY(U,$J,358.3,18956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18956,1,3,0)
 ;;=3^Follicular Lymphoma,Extranodal/Solid Organ Sites,Other Types
 ;;^UTILITY(U,$J,358.3,18956,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,18956,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,18957,0)
 ;;=D51.8^^94^916^189
 ;;^UTILITY(U,$J,358.3,18957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18957,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemias,Other
 ;;^UTILITY(U,$J,358.3,18957,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,18957,2)
 ;;=^5002288
 ;;^UTILITY(U,$J,358.3,18958,0)
 ;;=I80.9^^94^916^174
 ;;^UTILITY(U,$J,358.3,18958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18958,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,18958,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,18958,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,18959,0)
 ;;=D45.^^94^916^175
 ;;^UTILITY(U,$J,358.3,18959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18959,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,18959,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,18959,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,18960,0)
 ;;=C77.3^^94^916^107
 ;;^UTILITY(U,$J,358.3,18960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18960,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,18960,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,18960,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,18961,0)
 ;;=C77.2^^94^916^123
 ;;^UTILITY(U,$J,358.3,18961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18961,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,18961,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,18961,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,18962,0)
 ;;=C77.1^^94^916^124
 ;;^UTILITY(U,$J,358.3,18962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18962,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,18962,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,18962,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,18963,0)
 ;;=C77.0^^94^916^140
 ;;^UTILITY(U,$J,358.3,18963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18963,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,18963,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,18963,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,18964,0)
 ;;=C77.8^^94^916^141
 ;;^UTILITY(U,$J,358.3,18964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18964,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,18964,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,18964,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,18965,0)
 ;;=C79.51^^94^916^111
 ;;^UTILITY(U,$J,358.3,18965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18965,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,18965,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,18965,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,18966,0)
 ;;=C79.52^^94^916^110
 ;;^UTILITY(U,$J,358.3,18966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18966,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
 ;;^UTILITY(U,$J,358.3,18966,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,18966,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,18967,0)
 ;;=C79.31^^94^916^112
 ;;^UTILITY(U,$J,358.3,18967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18967,1,3,0)
 ;;=3^Malig Neop Brain,Secondary
 ;;^UTILITY(U,$J,358.3,18967,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,18967,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,18968,0)
 ;;=C79.72^^94^916^127
