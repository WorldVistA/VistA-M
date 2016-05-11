IBDEI1BN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22468,0)
 ;;=I80.9^^87^981^178
 ;;^UTILITY(U,$J,358.3,22468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22468,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,22468,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,22468,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,22469,0)
 ;;=D45.^^87^981^179
 ;;^UTILITY(U,$J,358.3,22469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22469,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,22469,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,22469,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,22470,0)
 ;;=C77.3^^87^981^109
 ;;^UTILITY(U,$J,358.3,22470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22470,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,22470,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,22470,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,22471,0)
 ;;=C77.2^^87^981^125
 ;;^UTILITY(U,$J,358.3,22471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22471,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,22471,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,22471,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,22472,0)
 ;;=C77.1^^87^981^126
 ;;^UTILITY(U,$J,358.3,22472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22472,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,22472,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,22472,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,22473,0)
 ;;=C77.0^^87^981^142
 ;;^UTILITY(U,$J,358.3,22473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22473,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,22473,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,22473,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,22474,0)
 ;;=C77.8^^87^981^143
 ;;^UTILITY(U,$J,358.3,22474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22474,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,22474,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,22474,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,22475,0)
 ;;=C79.51^^87^981^113
 ;;^UTILITY(U,$J,358.3,22475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22475,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,22475,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,22475,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,22476,0)
 ;;=C79.52^^87^981^112
 ;;^UTILITY(U,$J,358.3,22476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22476,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
 ;;^UTILITY(U,$J,358.3,22476,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,22476,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,22477,0)
 ;;=C79.31^^87^981^114
 ;;^UTILITY(U,$J,358.3,22477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22477,1,3,0)
 ;;=3^Malig Neop Brain,Secondary
 ;;^UTILITY(U,$J,358.3,22477,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,22477,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,22478,0)
 ;;=C79.72^^87^981^129
 ;;^UTILITY(U,$J,358.3,22478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22478,1,3,0)
 ;;=3^Malig Neop Left Adrenal Gland,Secondary
 ;;^UTILITY(U,$J,358.3,22478,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,22478,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,22479,0)
 ;;=C78.02^^87^981^133
 ;;^UTILITY(U,$J,358.3,22479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22479,1,3,0)
 ;;=3^Malig Neop Left Lung,Secondary
 ;;^UTILITY(U,$J,358.3,22479,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,22479,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,22480,0)
 ;;=C78.7^^87^981^138
 ;;^UTILITY(U,$J,358.3,22480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22480,1,3,0)
 ;;=3^Malig Neop Liver/Intrahepatic Bile Duct,Secondary
