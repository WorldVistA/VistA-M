IBDEI0H4 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21687,1,3,0)
 ;;=3^Osteomyelofibrosis
 ;;^UTILITY(U,$J,358.3,21687,1,4,0)
 ;;=4^D47.4
 ;;^UTILITY(U,$J,358.3,21687,2)
 ;;=^5002259
 ;;^UTILITY(U,$J,358.3,21688,0)
 ;;=D59.1^^58^840^28
 ;;^UTILITY(U,$J,358.3,21688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21688,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Other
 ;;^UTILITY(U,$J,358.3,21688,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,21688,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,21689,0)
 ;;=D51.3^^58^840^191
 ;;^UTILITY(U,$J,358.3,21689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21689,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Other
 ;;^UTILITY(U,$J,358.3,21689,1,4,0)
 ;;=4^D51.3
 ;;^UTILITY(U,$J,358.3,21689,2)
 ;;=^5002287
 ;;^UTILITY(U,$J,358.3,21690,0)
 ;;=D77.^^58^840^57
 ;;^UTILITY(U,$J,358.3,21690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21690,1,3,0)
 ;;=3^Disorder of Blood/Blood-Forming Organs in Diseases Classified Elsewhere,Other
 ;;^UTILITY(U,$J,358.3,21690,1,4,0)
 ;;=4^D77.
 ;;^UTILITY(U,$J,358.3,21690,2)
 ;;=^5002396
 ;;^UTILITY(U,$J,358.3,21691,0)
 ;;=D58.2^^58^840^83
 ;;^UTILITY(U,$J,358.3,21691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21691,1,3,0)
 ;;=3^Hemoglobinopathies,Other
 ;;^UTILITY(U,$J,358.3,21691,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,21691,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,21692,0)
 ;;=C88.8^^58^840^103
 ;;^UTILITY(U,$J,358.3,21692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21692,1,3,0)
 ;;=3^Malig Immunoproliferative Diseases,Other
 ;;^UTILITY(U,$J,358.3,21692,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,21692,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,21693,0)
 ;;=D70.8^^58^840^174
 ;;^UTILITY(U,$J,358.3,21693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21693,1,3,0)
 ;;=3^Neutropenia,Other
 ;;^UTILITY(U,$J,358.3,21693,1,4,0)
 ;;=4^D70.8
 ;;^UTILITY(U,$J,358.3,21693,2)
 ;;=^334042
 ;;^UTILITY(U,$J,358.3,21694,0)
 ;;=D59.4^^58^840^175
 ;;^UTILITY(U,$J,358.3,21694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21694,1,3,0)
 ;;=3^Nonautoimmune Hemolytic Anemias,Other
 ;;^UTILITY(U,$J,358.3,21694,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,21694,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,21695,0)
 ;;=D69.59^^58^840^181
 ;;^UTILITY(U,$J,358.3,21695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21695,1,3,0)
 ;;=3^Secondary Thrombocytopenia,Other
 ;;^UTILITY(U,$J,358.3,21695,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,21695,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,21696,0)
 ;;=C22.7^^58^840^46
 ;;^UTILITY(U,$J,358.3,21696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21696,1,3,0)
 ;;=3^Carcinomas of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,21696,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,21696,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,21697,0)
 ;;=D75.89^^58^840^56
 ;;^UTILITY(U,$J,358.3,21697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21697,1,3,0)
 ;;=3^Diseases of Blood/Blood-Forming Organs,Other Spec
 ;;^UTILITY(U,$J,358.3,21697,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,21697,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,21698,0)
 ;;=D47.Z9^^58^840^173
 ;;^UTILITY(U,$J,358.3,21698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21698,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
 ;;^UTILITY(U,$J,358.3,21698,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,21698,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,21699,0)
 ;;=D05.82^^58^840^34
 ;;^UTILITY(U,$J,358.3,21699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21699,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Other Spec Type
 ;;^UTILITY(U,$J,358.3,21699,1,4,0)
 ;;=4^D05.82
 ;;^UTILITY(U,$J,358.3,21699,2)
 ;;=^5001934
 ;;^UTILITY(U,$J,358.3,21700,0)
 ;;=D05.81^^58^840^36
 ;;^UTILITY(U,$J,358.3,21700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21700,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,21700,1,4,0)
 ;;=4^D05.81
 ;;^UTILITY(U,$J,358.3,21700,2)
 ;;=^5001933
 ;;^UTILITY(U,$J,358.3,21701,0)
 ;;=D05.80^^58^840^38
 ;;^UTILITY(U,$J,358.3,21701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21701,1,3,0)
 ;;=3^Carcinoma in Situ Unspec Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,21701,1,4,0)
 ;;=4^D05.80
 ;;^UTILITY(U,$J,358.3,21701,2)
 ;;=^5001932
 ;;^UTILITY(U,$J,358.3,21702,0)
 ;;=D56.8^^58^840^186
 ;;^UTILITY(U,$J,358.3,21702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21702,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,21702,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,21702,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,21703,0)
 ;;=C82.89^^58^840^76
 ;;^UTILITY(U,$J,358.3,21703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21703,1,3,0)
 ;;=3^Follicular Lymphoma,Extranodal/Solid Organ Sites,Other Types
 ;;^UTILITY(U,$J,358.3,21703,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,21703,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,21704,0)
 ;;=D51.8^^58^840^193
 ;;^UTILITY(U,$J,358.3,21704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21704,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemias,Other
 ;;^UTILITY(U,$J,358.3,21704,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,21704,2)
 ;;=^5002288
 ;;^UTILITY(U,$J,358.3,21705,0)
 ;;=I80.9^^58^840^178
 ;;^UTILITY(U,$J,358.3,21705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21705,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,21705,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,21705,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,21706,0)
 ;;=D45.^^58^840^179
 ;;^UTILITY(U,$J,358.3,21706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21706,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,21706,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,21706,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,21707,0)
 ;;=C77.3^^58^840^109
 ;;^UTILITY(U,$J,358.3,21707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21707,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,21707,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,21707,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,21708,0)
 ;;=C77.2^^58^840^125
 ;;^UTILITY(U,$J,358.3,21708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21708,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,21708,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,21708,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,21709,0)
 ;;=C77.1^^58^840^126
 ;;^UTILITY(U,$J,358.3,21709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21709,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,21709,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,21709,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,21710,0)
 ;;=C77.0^^58^840^142
 ;;^UTILITY(U,$J,358.3,21710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21710,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,21710,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,21710,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,21711,0)
 ;;=C77.8^^58^840^143
 ;;^UTILITY(U,$J,358.3,21711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21711,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,21711,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,21711,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,21712,0)
 ;;=C79.51^^58^840^113
 ;;^UTILITY(U,$J,358.3,21712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21712,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,21712,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,21712,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,21713,0)
 ;;=C79.52^^58^840^112
 ;;^UTILITY(U,$J,358.3,21713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21713,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
 ;;^UTILITY(U,$J,358.3,21713,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,21713,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,21714,0)
 ;;=C79.31^^58^840^114
 ;;^UTILITY(U,$J,358.3,21714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21714,1,3,0)
 ;;=3^Malig Neop Brain,Secondary
 ;;^UTILITY(U,$J,358.3,21714,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,21714,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,21715,0)
 ;;=C79.72^^58^840^129
 ;;^UTILITY(U,$J,358.3,21715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21715,1,3,0)
 ;;=3^Malig Neop Left Adrenal Gland,Secondary
 ;;^UTILITY(U,$J,358.3,21715,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,21715,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,21716,0)
 ;;=C78.02^^58^840^133
 ;;^UTILITY(U,$J,358.3,21716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21716,1,3,0)
 ;;=3^Malig Neop Left Lung,Secondary
 ;;^UTILITY(U,$J,358.3,21716,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,21716,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,21717,0)
 ;;=C78.7^^58^840^138
 ;;^UTILITY(U,$J,358.3,21717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21717,1,3,0)
 ;;=3^Malig Neop Liver/Intrahepatic Bile Duct,Secondary
 ;;^UTILITY(U,$J,358.3,21717,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,21717,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,21718,0)
 ;;=C79.71^^58^840^151
 ;;^UTILITY(U,$J,358.3,21718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21718,1,3,0)
 ;;=3^Malig Neop Right Adrenal Gland,Secondary
 ;;^UTILITY(U,$J,358.3,21718,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,21718,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,21719,0)
 ;;=C78.01^^58^840^155
 ;;^UTILITY(U,$J,358.3,21719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21719,1,3,0)
 ;;=3^Malig Neop Right Lung,Secondary
 ;;^UTILITY(U,$J,358.3,21719,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,21719,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,21720,0)
 ;;=C79.70^^58^840^106
 ;;^UTILITY(U,$J,358.3,21720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21720,1,3,0)
 ;;=3^Malig Neop Adrenal Gland Unspec,Secondary
 ;;^UTILITY(U,$J,358.3,21720,1,4,0)
 ;;=4^C79.70
 ;;^UTILITY(U,$J,358.3,21720,2)
 ;;=^5001355
 ;;^UTILITY(U,$J,358.3,21721,0)
 ;;=C78.00^^58^840^139
 ;;^UTILITY(U,$J,358.3,21721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21721,1,3,0)
 ;;=3^Malig Neop Lung Unspec,Secondary
 ;;^UTILITY(U,$J,358.3,21721,1,4,0)
 ;;=4^C78.00
 ;;^UTILITY(U,$J,358.3,21721,2)
 ;;=^5001334
