IBDEI0ST ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13512,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Other Spec Type
 ;;^UTILITY(U,$J,358.3,13512,1,4,0)
 ;;=4^D05.82
 ;;^UTILITY(U,$J,358.3,13512,2)
 ;;=^5001934
 ;;^UTILITY(U,$J,358.3,13513,0)
 ;;=D05.81^^53^593^36
 ;;^UTILITY(U,$J,358.3,13513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13513,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,13513,1,4,0)
 ;;=4^D05.81
 ;;^UTILITY(U,$J,358.3,13513,2)
 ;;=^5001933
 ;;^UTILITY(U,$J,358.3,13514,0)
 ;;=D05.80^^53^593^38
 ;;^UTILITY(U,$J,358.3,13514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13514,1,3,0)
 ;;=3^Carcinoma in Situ Unspec Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,13514,1,4,0)
 ;;=4^D05.80
 ;;^UTILITY(U,$J,358.3,13514,2)
 ;;=^5001932
 ;;^UTILITY(U,$J,358.3,13515,0)
 ;;=D56.8^^53^593^186
 ;;^UTILITY(U,$J,358.3,13515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13515,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,13515,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,13515,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,13516,0)
 ;;=C82.89^^53^593^76
 ;;^UTILITY(U,$J,358.3,13516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13516,1,3,0)
 ;;=3^Follicular Lymphoma,Extranodal/Solid Organ Sites,Other Types
 ;;^UTILITY(U,$J,358.3,13516,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,13516,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,13517,0)
 ;;=D51.8^^53^593^193
 ;;^UTILITY(U,$J,358.3,13517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13517,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemias,Other
 ;;^UTILITY(U,$J,358.3,13517,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,13517,2)
 ;;=^5002288
 ;;^UTILITY(U,$J,358.3,13518,0)
 ;;=I80.9^^53^593^178
 ;;^UTILITY(U,$J,358.3,13518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13518,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,13518,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,13518,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,13519,0)
 ;;=D45.^^53^593^179
 ;;^UTILITY(U,$J,358.3,13519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13519,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,13519,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,13519,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,13520,0)
 ;;=C77.3^^53^593^109
 ;;^UTILITY(U,$J,358.3,13520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13520,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,13520,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,13520,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,13521,0)
 ;;=C77.2^^53^593^125
 ;;^UTILITY(U,$J,358.3,13521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13521,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,13521,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,13521,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,13522,0)
 ;;=C77.1^^53^593^126
 ;;^UTILITY(U,$J,358.3,13522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13522,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,13522,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,13522,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,13523,0)
 ;;=C77.0^^53^593^142
 ;;^UTILITY(U,$J,358.3,13523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13523,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,13523,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,13523,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,13524,0)
 ;;=C77.8^^53^593^143
 ;;^UTILITY(U,$J,358.3,13524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13524,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
