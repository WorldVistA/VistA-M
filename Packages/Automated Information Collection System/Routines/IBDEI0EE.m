IBDEI0EE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6623,2)
 ;;=^5001933
 ;;^UTILITY(U,$J,358.3,6624,0)
 ;;=D05.80^^30^396^36
 ;;^UTILITY(U,$J,358.3,6624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6624,1,3,0)
 ;;=3^Carcinoma in Situ Unspec Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,6624,1,4,0)
 ;;=4^D05.80
 ;;^UTILITY(U,$J,358.3,6624,2)
 ;;=^5001932
 ;;^UTILITY(U,$J,358.3,6625,0)
 ;;=D56.8^^30^396^182
 ;;^UTILITY(U,$J,358.3,6625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6625,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,6625,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,6625,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,6626,0)
 ;;=C82.89^^30^396^74
 ;;^UTILITY(U,$J,358.3,6626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6626,1,3,0)
 ;;=3^Follicular Lymphoma,Extranodal/Solid Organ Sites,Other Types
 ;;^UTILITY(U,$J,358.3,6626,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,6626,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,6627,0)
 ;;=D51.8^^30^396^189
 ;;^UTILITY(U,$J,358.3,6627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6627,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemias,Other
 ;;^UTILITY(U,$J,358.3,6627,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,6627,2)
 ;;=^5002288
 ;;^UTILITY(U,$J,358.3,6628,0)
 ;;=I80.9^^30^396^174
 ;;^UTILITY(U,$J,358.3,6628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6628,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,6628,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,6628,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,6629,0)
 ;;=D45.^^30^396^175
 ;;^UTILITY(U,$J,358.3,6629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6629,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,6629,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,6629,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,6630,0)
 ;;=C77.3^^30^396^107
 ;;^UTILITY(U,$J,358.3,6630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6630,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,6630,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,6630,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,6631,0)
 ;;=C77.2^^30^396^123
 ;;^UTILITY(U,$J,358.3,6631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6631,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,6631,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,6631,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,6632,0)
 ;;=C77.1^^30^396^124
 ;;^UTILITY(U,$J,358.3,6632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6632,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,6632,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,6632,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,6633,0)
 ;;=C77.0^^30^396^140
 ;;^UTILITY(U,$J,358.3,6633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6633,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,6633,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,6633,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,6634,0)
 ;;=C77.8^^30^396^141
 ;;^UTILITY(U,$J,358.3,6634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6634,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,6634,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,6634,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,6635,0)
 ;;=C79.51^^30^396^111
 ;;^UTILITY(U,$J,358.3,6635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6635,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,6635,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,6635,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,6636,0)
 ;;=C79.52^^30^396^110
 ;;^UTILITY(U,$J,358.3,6636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6636,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
