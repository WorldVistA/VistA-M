IBDEI10U ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16610,0)
 ;;=C77.3^^61^775^117
 ;;^UTILITY(U,$J,358.3,16610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16610,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,16610,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,16610,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,16611,0)
 ;;=C77.2^^61^775^133
 ;;^UTILITY(U,$J,358.3,16611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16611,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,16611,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,16611,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,16612,0)
 ;;=C77.1^^61^775^134
 ;;^UTILITY(U,$J,358.3,16612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16612,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,16612,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,16612,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,16613,0)
 ;;=C77.0^^61^775^150
 ;;^UTILITY(U,$J,358.3,16613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16613,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,16613,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,16613,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,16614,0)
 ;;=C77.8^^61^775^151
 ;;^UTILITY(U,$J,358.3,16614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16614,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,16614,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,16614,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,16615,0)
 ;;=C79.51^^61^775^121
 ;;^UTILITY(U,$J,358.3,16615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16615,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,16615,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,16615,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,16616,0)
 ;;=C79.52^^61^775^120
 ;;^UTILITY(U,$J,358.3,16616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16616,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
 ;;^UTILITY(U,$J,358.3,16616,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,16616,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,16617,0)
 ;;=C79.31^^61^775^122
 ;;^UTILITY(U,$J,358.3,16617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16617,1,3,0)
 ;;=3^Malig Neop Brain,Secondary
 ;;^UTILITY(U,$J,358.3,16617,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,16617,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,16618,0)
 ;;=C79.72^^61^775^137
 ;;^UTILITY(U,$J,358.3,16618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16618,1,3,0)
 ;;=3^Malig Neop Left Adrenal Gland,Secondary
 ;;^UTILITY(U,$J,358.3,16618,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,16618,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,16619,0)
 ;;=C78.02^^61^775^141
 ;;^UTILITY(U,$J,358.3,16619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16619,1,3,0)
 ;;=3^Malig Neop Left Lung,Secondary
 ;;^UTILITY(U,$J,358.3,16619,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,16619,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,16620,0)
 ;;=C78.7^^61^775^146
 ;;^UTILITY(U,$J,358.3,16620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16620,1,3,0)
 ;;=3^Malig Neop Liver/Intrahepatic Bile Duct,Secondary
 ;;^UTILITY(U,$J,358.3,16620,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,16620,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,16621,0)
 ;;=C79.71^^61^775^159
 ;;^UTILITY(U,$J,358.3,16621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16621,1,3,0)
 ;;=3^Malig Neop Right Adrenal Gland,Secondary
 ;;^UTILITY(U,$J,358.3,16621,1,4,0)
 ;;=4^C79.71
