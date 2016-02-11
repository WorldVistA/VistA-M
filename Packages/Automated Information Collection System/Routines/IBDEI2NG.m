IBDEI2NG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44466,1,3,0)
 ;;=3^Neutropenia,Other
 ;;^UTILITY(U,$J,358.3,44466,1,4,0)
 ;;=4^D70.8
 ;;^UTILITY(U,$J,358.3,44466,2)
 ;;=^334042
 ;;^UTILITY(U,$J,358.3,44467,0)
 ;;=D59.4^^200^2228^171
 ;;^UTILITY(U,$J,358.3,44467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44467,1,3,0)
 ;;=3^Nonautoimmune Hemolytic Anemias,Other
 ;;^UTILITY(U,$J,358.3,44467,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,44467,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,44468,0)
 ;;=D69.59^^200^2228^177
 ;;^UTILITY(U,$J,358.3,44468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44468,1,3,0)
 ;;=3^Secondary Thrombocytopenia,Other
 ;;^UTILITY(U,$J,358.3,44468,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,44468,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,44469,0)
 ;;=C22.7^^200^2228^44
 ;;^UTILITY(U,$J,358.3,44469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44469,1,3,0)
 ;;=3^Carcinomas of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,44469,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,44469,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,44470,0)
 ;;=D75.89^^200^2228^54
 ;;^UTILITY(U,$J,358.3,44470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44470,1,3,0)
 ;;=3^Diseases of Blood/Blood-Forming Organs,Other Spec
 ;;^UTILITY(U,$J,358.3,44470,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,44470,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,44471,0)
 ;;=D47.Z9^^200^2228^169
 ;;^UTILITY(U,$J,358.3,44471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44471,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
 ;;^UTILITY(U,$J,358.3,44471,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,44471,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,44472,0)
 ;;=D05.82^^200^2228^32
 ;;^UTILITY(U,$J,358.3,44472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44472,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Other Spec Type
 ;;^UTILITY(U,$J,358.3,44472,1,4,0)
 ;;=4^D05.82
 ;;^UTILITY(U,$J,358.3,44472,2)
 ;;=^5001934
 ;;^UTILITY(U,$J,358.3,44473,0)
 ;;=D05.81^^200^2228^34
 ;;^UTILITY(U,$J,358.3,44473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44473,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,44473,1,4,0)
 ;;=4^D05.81
 ;;^UTILITY(U,$J,358.3,44473,2)
 ;;=^5001933
 ;;^UTILITY(U,$J,358.3,44474,0)
 ;;=D05.80^^200^2228^36
 ;;^UTILITY(U,$J,358.3,44474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44474,1,3,0)
 ;;=3^Carcinoma in Situ Unspec Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,44474,1,4,0)
 ;;=4^D05.80
 ;;^UTILITY(U,$J,358.3,44474,2)
 ;;=^5001932
 ;;^UTILITY(U,$J,358.3,44475,0)
 ;;=D56.8^^200^2228^182
 ;;^UTILITY(U,$J,358.3,44475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44475,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,44475,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,44475,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,44476,0)
 ;;=C82.89^^200^2228^74
 ;;^UTILITY(U,$J,358.3,44476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44476,1,3,0)
 ;;=3^Follicular Lymphoma,Extranodal/Solid Organ Sites,Other Types
 ;;^UTILITY(U,$J,358.3,44476,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,44476,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,44477,0)
 ;;=D51.8^^200^2228^189
 ;;^UTILITY(U,$J,358.3,44477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44477,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemias,Other
 ;;^UTILITY(U,$J,358.3,44477,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,44477,2)
 ;;=^5002288
 ;;^UTILITY(U,$J,358.3,44478,0)
 ;;=I80.9^^200^2228^174
 ;;^UTILITY(U,$J,358.3,44478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44478,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,44478,1,4,0)
 ;;=4^I80.9
