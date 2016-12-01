IBDEI05B ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6570,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
 ;;^UTILITY(U,$J,358.3,6570,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,6570,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,6571,0)
 ;;=D05.82^^26^402^32
 ;;^UTILITY(U,$J,358.3,6571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6571,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Other Spec Type
 ;;^UTILITY(U,$J,358.3,6571,1,4,0)
 ;;=4^D05.82
 ;;^UTILITY(U,$J,358.3,6571,2)
 ;;=^5001934
 ;;^UTILITY(U,$J,358.3,6572,0)
 ;;=D05.81^^26^402^34
 ;;^UTILITY(U,$J,358.3,6572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6572,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,6572,1,4,0)
 ;;=4^D05.81
 ;;^UTILITY(U,$J,358.3,6572,2)
 ;;=^5001933
 ;;^UTILITY(U,$J,358.3,6573,0)
 ;;=D05.80^^26^402^36
 ;;^UTILITY(U,$J,358.3,6573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6573,1,3,0)
 ;;=3^Carcinoma in Situ Unspec Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,6573,1,4,0)
 ;;=4^D05.80
 ;;^UTILITY(U,$J,358.3,6573,2)
 ;;=^5001932
 ;;^UTILITY(U,$J,358.3,6574,0)
 ;;=D56.8^^26^402^182
 ;;^UTILITY(U,$J,358.3,6574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6574,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,6574,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,6574,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,6575,0)
 ;;=C82.89^^26^402^74
 ;;^UTILITY(U,$J,358.3,6575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6575,1,3,0)
 ;;=3^Follicular Lymphoma,Extranodal/Solid Organ Sites,Other Types
 ;;^UTILITY(U,$J,358.3,6575,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,6575,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,6576,0)
 ;;=D51.8^^26^402^189
 ;;^UTILITY(U,$J,358.3,6576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6576,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemias,Other
 ;;^UTILITY(U,$J,358.3,6576,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,6576,2)
 ;;=^5002288
 ;;^UTILITY(U,$J,358.3,6577,0)
 ;;=I80.9^^26^402^174
 ;;^UTILITY(U,$J,358.3,6577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6577,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,6577,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,6577,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,6578,0)
 ;;=D45.^^26^402^175
 ;;^UTILITY(U,$J,358.3,6578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6578,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,6578,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,6578,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,6579,0)
 ;;=C77.3^^26^402^107
 ;;^UTILITY(U,$J,358.3,6579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6579,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,6579,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,6579,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,6580,0)
 ;;=C77.2^^26^402^123
 ;;^UTILITY(U,$J,358.3,6580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6580,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,6580,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,6580,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,6581,0)
 ;;=C77.1^^26^402^124
 ;;^UTILITY(U,$J,358.3,6581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6581,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,6581,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,6581,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,6582,0)
 ;;=C77.0^^26^402^140
 ;;^UTILITY(U,$J,358.3,6582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6582,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,6582,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,6582,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,6583,0)
 ;;=C77.8^^26^402^141
 ;;^UTILITY(U,$J,358.3,6583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6583,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,6583,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,6583,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,6584,0)
 ;;=C79.51^^26^402^111
 ;;^UTILITY(U,$J,358.3,6584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6584,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,6584,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,6584,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,6585,0)
 ;;=C79.52^^26^402^110
 ;;^UTILITY(U,$J,358.3,6585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6585,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
 ;;^UTILITY(U,$J,358.3,6585,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,6585,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,6586,0)
 ;;=C79.31^^26^402^112
 ;;^UTILITY(U,$J,358.3,6586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6586,1,3,0)
 ;;=3^Malig Neop Brain,Secondary
 ;;^UTILITY(U,$J,358.3,6586,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,6586,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,6587,0)
 ;;=C79.72^^26^402^127
 ;;^UTILITY(U,$J,358.3,6587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6587,1,3,0)
 ;;=3^Malig Neop Left Adrenal Gland,Secondary
 ;;^UTILITY(U,$J,358.3,6587,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,6587,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,6588,0)
 ;;=C78.02^^26^402^131
 ;;^UTILITY(U,$J,358.3,6588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6588,1,3,0)
 ;;=3^Malig Neop Left Lung,Secondary
 ;;^UTILITY(U,$J,358.3,6588,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,6588,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,6589,0)
 ;;=C78.7^^26^402^136
 ;;^UTILITY(U,$J,358.3,6589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6589,1,3,0)
 ;;=3^Malig Neop Liver/Intrahepatic Bile Duct,Secondary
 ;;^UTILITY(U,$J,358.3,6589,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,6589,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,6590,0)
 ;;=C79.71^^26^402^149
 ;;^UTILITY(U,$J,358.3,6590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6590,1,3,0)
 ;;=3^Malig Neop Right Adrenal Gland,Secondary
 ;;^UTILITY(U,$J,358.3,6590,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,6590,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,6591,0)
 ;;=C78.01^^26^402^153
 ;;^UTILITY(U,$J,358.3,6591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6591,1,3,0)
 ;;=3^Malig Neop Right Lung,Secondary
 ;;^UTILITY(U,$J,358.3,6591,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,6591,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,6592,0)
 ;;=C79.70^^26^402^104
 ;;^UTILITY(U,$J,358.3,6592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6592,1,3,0)
 ;;=3^Malig Neop Adrenal Gland Unspec,Secondary
 ;;^UTILITY(U,$J,358.3,6592,1,4,0)
 ;;=4^C79.70
 ;;^UTILITY(U,$J,358.3,6592,2)
 ;;=^5001355
 ;;^UTILITY(U,$J,358.3,6593,0)
 ;;=C78.00^^26^402^137
 ;;^UTILITY(U,$J,358.3,6593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6593,1,3,0)
 ;;=3^Malig Neop Lung Unspec,Secondary
 ;;^UTILITY(U,$J,358.3,6593,1,4,0)
 ;;=4^C78.00
 ;;^UTILITY(U,$J,358.3,6593,2)
 ;;=^5001334
 ;;^UTILITY(U,$J,358.3,6594,0)
 ;;=D57.1^^26^402^178
 ;;^UTILITY(U,$J,358.3,6594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6594,1,3,0)
 ;;=3^Sickle-Cell Disease w/o Crisis
 ;;^UTILITY(U,$J,358.3,6594,1,4,0)
 ;;=4^D57.1
 ;;^UTILITY(U,$J,358.3,6594,2)
 ;;=^5002309
 ;;^UTILITY(U,$J,358.3,6595,0)
 ;;=D75.1^^26^402^176
 ;;^UTILITY(U,$J,358.3,6595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6595,1,3,0)
 ;;=3^Polycythemia,Secondary
 ;;^UTILITY(U,$J,358.3,6595,1,4,0)
 ;;=4^D75.1
 ;;^UTILITY(U,$J,358.3,6595,2)
 ;;=^186856
 ;;^UTILITY(U,$J,358.3,6596,0)
 ;;=C90.30^^26^402^179
 ;;^UTILITY(U,$J,358.3,6596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6596,1,3,0)
 ;;=3^Solitary Plasmacytoma,Not in Remission
 ;;^UTILITY(U,$J,358.3,6596,1,4,0)
 ;;=4^C90.30
 ;;^UTILITY(U,$J,358.3,6596,2)
 ;;=^5001759
 ;;^UTILITY(U,$J,358.3,6597,0)
 ;;=D56.3^^26^402^180
 ;;^UTILITY(U,$J,358.3,6597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6597,1,3,0)
 ;;=3^Thalassemia Minor
 ;;^UTILITY(U,$J,358.3,6597,1,4,0)
 ;;=4^D56.3
 ;;^UTILITY(U,$J,358.3,6597,2)
 ;;=^340497
 ;;^UTILITY(U,$J,358.3,6598,0)
 ;;=D56.9^^26^402^181
 ;;^UTILITY(U,$J,358.3,6598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6598,1,3,0)
 ;;=3^Thalassemia,Unspec
 ;;^UTILITY(U,$J,358.3,6598,1,4,0)
 ;;=4^D56.9
 ;;^UTILITY(U,$J,358.3,6598,2)
 ;;=^340606
 ;;^UTILITY(U,$J,358.3,6599,0)
 ;;=M31.1^^26^402^183
 ;;^UTILITY(U,$J,358.3,6599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6599,1,3,0)
 ;;=3^Thrombotic Microangiopathy
 ;;^UTILITY(U,$J,358.3,6599,1,4,0)
 ;;=4^M31.1
 ;;^UTILITY(U,$J,358.3,6599,2)
 ;;=^119061
 ;;^UTILITY(U,$J,358.3,6600,0)
 ;;=D51.2^^26^402^184
 ;;^UTILITY(U,$J,358.3,6600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6600,1,3,0)
 ;;=3^Transcobalamin II Deficiency
 ;;^UTILITY(U,$J,358.3,6600,1,4,0)
 ;;=4^D51.2
 ;;^UTILITY(U,$J,358.3,6600,2)
 ;;=^5002286
 ;;^UTILITY(U,$J,358.3,6601,0)
 ;;=D05.92^^26^402^33
 ;;^UTILITY(U,$J,358.3,6601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6601,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,6601,1,4,0)
 ;;=4^D05.92
 ;;^UTILITY(U,$J,358.3,6601,2)
 ;;=^5001937
 ;;^UTILITY(U,$J,358.3,6602,0)
 ;;=D05.91^^26^402^35
 ;;^UTILITY(U,$J,358.3,6602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6602,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,6602,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,6602,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,6603,0)
 ;;=D05.90^^26^402^31
 ;;^UTILITY(U,$J,358.3,6603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6603,1,3,0)
 ;;=3^Carcinoma in Situ Breast Unspec,Unspec Type
 ;;^UTILITY(U,$J,358.3,6603,1,4,0)
 ;;=4^D05.90
 ;;^UTILITY(U,$J,358.3,6603,2)
 ;;=^5001935
 ;;^UTILITY(U,$J,358.3,6604,0)
 ;;=D51.0^^26^402^185
 ;;^UTILITY(U,$J,358.3,6604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6604,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Intrinsic Factor Deficiency
 ;;^UTILITY(U,$J,358.3,6604,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,6604,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,6605,0)
 ;;=D51.1^^26^402^186
 ;;^UTILITY(U,$J,358.3,6605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6605,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Selective Vit B12 Malabsorp w/ Proteinuria
 ;;^UTILITY(U,$J,358.3,6605,1,4,0)
 ;;=4^D51.1
