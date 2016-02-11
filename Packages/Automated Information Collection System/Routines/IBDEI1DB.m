IBDEI1DB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22803,0)
 ;;=C79.32^^104^1063^7
 ;;^UTILITY(U,$J,358.3,22803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22803,1,3,0)
 ;;=3^Malig Neop Cerebral Meninges,Secondary
 ;;^UTILITY(U,$J,358.3,22803,1,4,0)
 ;;=4^C79.32
 ;;^UTILITY(U,$J,358.3,22803,2)
 ;;=^5001348
 ;;^UTILITY(U,$J,358.3,22804,0)
 ;;=C78.7^^104^1063^11
 ;;^UTILITY(U,$J,358.3,22804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22804,1,3,0)
 ;;=3^Malig Neop Liver/Intrahepatic Bile Duct,Secondary
 ;;^UTILITY(U,$J,358.3,22804,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,22804,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,22805,0)
 ;;=C78.01^^104^1063^13
 ;;^UTILITY(U,$J,358.3,22805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22805,1,3,0)
 ;;=3^Malig Neop Lung,Right,Secondary
 ;;^UTILITY(U,$J,358.3,22805,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,22805,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,22806,0)
 ;;=C78.02^^104^1063^12
 ;;^UTILITY(U,$J,358.3,22806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22806,1,3,0)
 ;;=3^Malig Neop Lung,Left,Secondary
 ;;^UTILITY(U,$J,358.3,22806,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,22806,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,22807,0)
 ;;=C77.2^^104^1063^9
 ;;^UTILITY(U,$J,358.3,22807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22807,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Secondary
 ;;^UTILITY(U,$J,358.3,22807,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,22807,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,22808,0)
 ;;=C77.3^^104^1063^3
 ;;^UTILITY(U,$J,358.3,22808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22808,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Secondary
 ;;^UTILITY(U,$J,358.3,22808,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,22808,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,22809,0)
 ;;=C77.0^^104^1063^8
 ;;^UTILITY(U,$J,358.3,22809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22809,1,3,0)
 ;;=3^Malig Neop Head/Face/Neck,Secondary
 ;;^UTILITY(U,$J,358.3,22809,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,22809,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,22810,0)
 ;;=C77.1^^104^1063^10
 ;;^UTILITY(U,$J,358.3,22810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22810,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Secondary
 ;;^UTILITY(U,$J,358.3,22810,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,22810,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,22811,0)
 ;;=C77.8^^104^1063^14
 ;;^UTILITY(U,$J,358.3,22811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22811,1,3,0)
 ;;=3^Malig Neop Lymph Nodes,Multiple Regions,Secondary
 ;;^UTILITY(U,$J,358.3,22811,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,22811,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,22812,0)
 ;;=C79.2^^104^1063^15
 ;;^UTILITY(U,$J,358.3,22812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22812,1,3,0)
 ;;=3^Malig Neop Skin,Secondary
 ;;^UTILITY(U,$J,358.3,22812,1,4,0)
 ;;=4^C79.2
 ;;^UTILITY(U,$J,358.3,22812,2)
 ;;=^267333
 ;;^UTILITY(U,$J,358.3,22813,0)
 ;;=C74.91^^104^1064^9
 ;;^UTILITY(U,$J,358.3,22813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22813,1,3,0)
 ;;=3^Malig Neop Adrenal Gland,Right,Unspec Part
 ;;^UTILITY(U,$J,358.3,22813,1,4,0)
 ;;=4^C74.91
 ;;^UTILITY(U,$J,358.3,22813,2)
 ;;=^5001318
 ;;^UTILITY(U,$J,358.3,22814,0)
 ;;=C74.92^^104^1064^8
 ;;^UTILITY(U,$J,358.3,22814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22814,1,3,0)
 ;;=3^Malig Neop Adrenal Gland,Left,Unspec Part
 ;;^UTILITY(U,$J,358.3,22814,1,4,0)
 ;;=4^C74.92
 ;;^UTILITY(U,$J,358.3,22814,2)
 ;;=^5001319
 ;;^UTILITY(U,$J,358.3,22815,0)
 ;;=C74.01^^104^1064^5
 ;;^UTILITY(U,$J,358.3,22815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22815,1,3,0)
 ;;=3^Malig Neop Adrenal Gland Cortex,Right
