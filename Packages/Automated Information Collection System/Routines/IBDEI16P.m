IBDEI16P ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20138,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Other Spec Type
 ;;^UTILITY(U,$J,358.3,20138,1,4,0)
 ;;=4^D05.82
 ;;^UTILITY(U,$J,358.3,20138,2)
 ;;=^5001934
 ;;^UTILITY(U,$J,358.3,20139,0)
 ;;=D05.81^^84^929^36
 ;;^UTILITY(U,$J,358.3,20139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20139,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,20139,1,4,0)
 ;;=4^D05.81
 ;;^UTILITY(U,$J,358.3,20139,2)
 ;;=^5001933
 ;;^UTILITY(U,$J,358.3,20140,0)
 ;;=D05.80^^84^929^38
 ;;^UTILITY(U,$J,358.3,20140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20140,1,3,0)
 ;;=3^Carcinoma in Situ Unspec Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,20140,1,4,0)
 ;;=4^D05.80
 ;;^UTILITY(U,$J,358.3,20140,2)
 ;;=^5001932
 ;;^UTILITY(U,$J,358.3,20141,0)
 ;;=D56.8^^84^929^186
 ;;^UTILITY(U,$J,358.3,20141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20141,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,20141,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,20141,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,20142,0)
 ;;=C82.89^^84^929^76
 ;;^UTILITY(U,$J,358.3,20142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20142,1,3,0)
 ;;=3^Follicular Lymphoma,Extranodal/Solid Organ Sites,Other Types
 ;;^UTILITY(U,$J,358.3,20142,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,20142,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,20143,0)
 ;;=D51.8^^84^929^193
 ;;^UTILITY(U,$J,358.3,20143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20143,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemias,Other
 ;;^UTILITY(U,$J,358.3,20143,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,20143,2)
 ;;=^5002288
 ;;^UTILITY(U,$J,358.3,20144,0)
 ;;=I80.9^^84^929^178
 ;;^UTILITY(U,$J,358.3,20144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20144,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,20144,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,20144,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,20145,0)
 ;;=D45.^^84^929^179
 ;;^UTILITY(U,$J,358.3,20145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20145,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,20145,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,20145,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,20146,0)
 ;;=C77.3^^84^929^109
 ;;^UTILITY(U,$J,358.3,20146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20146,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,20146,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,20146,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,20147,0)
 ;;=C77.2^^84^929^125
 ;;^UTILITY(U,$J,358.3,20147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20147,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,20147,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,20147,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,20148,0)
 ;;=C77.1^^84^929^126
 ;;^UTILITY(U,$J,358.3,20148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20148,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,20148,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,20148,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,20149,0)
 ;;=C77.0^^84^929^142
 ;;^UTILITY(U,$J,358.3,20149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20149,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,20149,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,20149,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,20150,0)
 ;;=C77.8^^84^929^143
 ;;^UTILITY(U,$J,358.3,20150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20150,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
