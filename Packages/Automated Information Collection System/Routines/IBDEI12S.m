IBDEI12S ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17474,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,17474,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,17475,0)
 ;;=R90.89^^61^787^16
 ;;^UTILITY(U,$J,358.3,17475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17475,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,17475,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,17475,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,17476,0)
 ;;=R91.8^^61^787^21
 ;;^UTILITY(U,$J,358.3,17476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17476,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,17476,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,17476,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,17477,0)
 ;;=R92.0^^61^787^121
 ;;^UTILITY(U,$J,358.3,17477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17477,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,17477,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,17477,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,17478,0)
 ;;=R92.1^^61^787^120
 ;;^UTILITY(U,$J,358.3,17478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17478,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,17478,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,17478,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,17479,0)
 ;;=R92.2^^61^787^95
 ;;^UTILITY(U,$J,358.3,17479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17479,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,17479,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,17479,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,17480,0)
 ;;=R93.0^^61^787^10
 ;;^UTILITY(U,$J,358.3,17480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17480,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,17480,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,17480,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,17481,0)
 ;;=R93.2^^61^787^9
 ;;^UTILITY(U,$J,358.3,17481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17481,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,17481,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,17481,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,17482,0)
 ;;=R93.3^^61^787^7
 ;;^UTILITY(U,$J,358.3,17482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17482,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,17482,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,17482,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,17483,0)
 ;;=R93.5^^61^787^6
 ;;^UTILITY(U,$J,358.3,17483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17483,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,17483,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,17483,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,17484,0)
 ;;=R93.6^^61^787^8
 ;;^UTILITY(U,$J,358.3,17484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17484,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,17484,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,17484,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,17485,0)
 ;;=R94.4^^61^787^19
 ;;^UTILITY(U,$J,358.3,17485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17485,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,17485,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,17485,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,17486,0)
 ;;=R94.5^^61^787^20
 ;;^UTILITY(U,$J,358.3,17486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17486,1,3,0)
 ;;=3^Abnormal Liver Function Studies
