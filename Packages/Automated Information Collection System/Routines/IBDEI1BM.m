IBDEI1BM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22455,1,3,0)
 ;;=3^Malig Immunoproliferative Diseases,Other
 ;;^UTILITY(U,$J,358.3,22455,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,22455,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,22456,0)
 ;;=D70.8^^87^981^174
 ;;^UTILITY(U,$J,358.3,22456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22456,1,3,0)
 ;;=3^Neutropenia,Other
 ;;^UTILITY(U,$J,358.3,22456,1,4,0)
 ;;=4^D70.8
 ;;^UTILITY(U,$J,358.3,22456,2)
 ;;=^334042
 ;;^UTILITY(U,$J,358.3,22457,0)
 ;;=D59.4^^87^981^175
 ;;^UTILITY(U,$J,358.3,22457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22457,1,3,0)
 ;;=3^Nonautoimmune Hemolytic Anemias,Other
 ;;^UTILITY(U,$J,358.3,22457,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,22457,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,22458,0)
 ;;=D69.59^^87^981^181
 ;;^UTILITY(U,$J,358.3,22458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22458,1,3,0)
 ;;=3^Secondary Thrombocytopenia,Other
 ;;^UTILITY(U,$J,358.3,22458,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,22458,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,22459,0)
 ;;=C22.7^^87^981^46
 ;;^UTILITY(U,$J,358.3,22459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22459,1,3,0)
 ;;=3^Carcinomas of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,22459,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,22459,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,22460,0)
 ;;=D75.89^^87^981^56
 ;;^UTILITY(U,$J,358.3,22460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22460,1,3,0)
 ;;=3^Diseases of Blood/Blood-Forming Organs,Other Spec
 ;;^UTILITY(U,$J,358.3,22460,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,22460,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,22461,0)
 ;;=D47.Z9^^87^981^173
 ;;^UTILITY(U,$J,358.3,22461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22461,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
 ;;^UTILITY(U,$J,358.3,22461,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,22461,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,22462,0)
 ;;=D05.82^^87^981^34
 ;;^UTILITY(U,$J,358.3,22462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22462,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Other Spec Type
 ;;^UTILITY(U,$J,358.3,22462,1,4,0)
 ;;=4^D05.82
 ;;^UTILITY(U,$J,358.3,22462,2)
 ;;=^5001934
 ;;^UTILITY(U,$J,358.3,22463,0)
 ;;=D05.81^^87^981^36
 ;;^UTILITY(U,$J,358.3,22463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22463,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,22463,1,4,0)
 ;;=4^D05.81
 ;;^UTILITY(U,$J,358.3,22463,2)
 ;;=^5001933
 ;;^UTILITY(U,$J,358.3,22464,0)
 ;;=D05.80^^87^981^38
 ;;^UTILITY(U,$J,358.3,22464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22464,1,3,0)
 ;;=3^Carcinoma in Situ Unspec Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,22464,1,4,0)
 ;;=4^D05.80
 ;;^UTILITY(U,$J,358.3,22464,2)
 ;;=^5001932
 ;;^UTILITY(U,$J,358.3,22465,0)
 ;;=D56.8^^87^981^186
 ;;^UTILITY(U,$J,358.3,22465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22465,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,22465,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,22465,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,22466,0)
 ;;=C82.89^^87^981^76
 ;;^UTILITY(U,$J,358.3,22466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22466,1,3,0)
 ;;=3^Follicular Lymphoma,Extranodal/Solid Organ Sites,Other Types
 ;;^UTILITY(U,$J,358.3,22466,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,22466,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,22467,0)
 ;;=D51.8^^87^981^193
 ;;^UTILITY(U,$J,358.3,22467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22467,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemias,Other
 ;;^UTILITY(U,$J,358.3,22467,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,22467,2)
 ;;=^5002288
