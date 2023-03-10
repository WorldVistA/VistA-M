IBDEI0J8 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8652,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,8652,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,8652,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,8653,0)
 ;;=C77.0^^39^401^150
 ;;^UTILITY(U,$J,358.3,8653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8653,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,8653,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,8653,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,8654,0)
 ;;=C77.8^^39^401^151
 ;;^UTILITY(U,$J,358.3,8654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8654,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,8654,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,8654,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,8655,0)
 ;;=C79.51^^39^401^121
 ;;^UTILITY(U,$J,358.3,8655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8655,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,8655,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,8655,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,8656,0)
 ;;=C79.52^^39^401^120
 ;;^UTILITY(U,$J,358.3,8656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8656,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
 ;;^UTILITY(U,$J,358.3,8656,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,8656,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,8657,0)
 ;;=C79.31^^39^401^122
 ;;^UTILITY(U,$J,358.3,8657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8657,1,3,0)
 ;;=3^Malig Neop Brain,Secondary
 ;;^UTILITY(U,$J,358.3,8657,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,8657,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,8658,0)
 ;;=C79.72^^39^401^137
 ;;^UTILITY(U,$J,358.3,8658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8658,1,3,0)
 ;;=3^Malig Neop Left Adrenal Gland,Secondary
 ;;^UTILITY(U,$J,358.3,8658,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,8658,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,8659,0)
 ;;=C78.02^^39^401^141
 ;;^UTILITY(U,$J,358.3,8659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8659,1,3,0)
 ;;=3^Malig Neop Left Lung,Secondary
 ;;^UTILITY(U,$J,358.3,8659,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,8659,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,8660,0)
 ;;=C78.7^^39^401^146
 ;;^UTILITY(U,$J,358.3,8660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8660,1,3,0)
 ;;=3^Malig Neop Liver/Intrahepatic Bile Duct,Secondary
 ;;^UTILITY(U,$J,358.3,8660,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,8660,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,8661,0)
 ;;=C79.71^^39^401^159
 ;;^UTILITY(U,$J,358.3,8661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8661,1,3,0)
 ;;=3^Malig Neop Right Adrenal Gland,Secondary
 ;;^UTILITY(U,$J,358.3,8661,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,8661,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,8662,0)
 ;;=C78.01^^39^401^163
 ;;^UTILITY(U,$J,358.3,8662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8662,1,3,0)
 ;;=3^Malig Neop Right Lung,Secondary
 ;;^UTILITY(U,$J,358.3,8662,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,8662,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,8663,0)
 ;;=C79.70^^39^401^114
 ;;^UTILITY(U,$J,358.3,8663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8663,1,3,0)
 ;;=3^Malig Neop Adrenal Gland Unspec,Secondary
 ;;^UTILITY(U,$J,358.3,8663,1,4,0)
 ;;=4^C79.70
 ;;^UTILITY(U,$J,358.3,8663,2)
 ;;=^5001355
 ;;^UTILITY(U,$J,358.3,8664,0)
 ;;=C78.00^^39^401^147
 ;;^UTILITY(U,$J,358.3,8664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8664,1,3,0)
 ;;=3^Malig Neop Lung Unspec,Secondary
