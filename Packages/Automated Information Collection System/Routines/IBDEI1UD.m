IBDEI1UD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30837,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,30837,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,30838,0)
 ;;=R90.89^^135^1384^13
 ;;^UTILITY(U,$J,358.3,30838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30838,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,30838,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,30838,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,30839,0)
 ;;=R91.8^^135^1384^18
 ;;^UTILITY(U,$J,358.3,30839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30839,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,30839,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,30839,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,30840,0)
 ;;=R92.0^^135^1384^117
 ;;^UTILITY(U,$J,358.3,30840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30840,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,30840,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,30840,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,30841,0)
 ;;=R92.1^^135^1384^116
 ;;^UTILITY(U,$J,358.3,30841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30841,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,30841,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,30841,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,30842,0)
 ;;=R92.2^^135^1384^91
 ;;^UTILITY(U,$J,358.3,30842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30842,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,30842,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,30842,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,30843,0)
 ;;=R93.0^^135^1384^10
 ;;^UTILITY(U,$J,358.3,30843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30843,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,30843,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,30843,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,30844,0)
 ;;=R93.2^^135^1384^9
 ;;^UTILITY(U,$J,358.3,30844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30844,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,30844,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,30844,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,30845,0)
 ;;=R93.3^^135^1384^7
 ;;^UTILITY(U,$J,358.3,30845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30845,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,30845,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,30845,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,30846,0)
 ;;=R93.4^^135^1384^11
 ;;^UTILITY(U,$J,358.3,30846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30846,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,30846,1,4,0)
 ;;=4^R93.4
 ;;^UTILITY(U,$J,358.3,30846,2)
 ;;=^5019717
 ;;^UTILITY(U,$J,358.3,30847,0)
 ;;=R93.5^^135^1384^6
 ;;^UTILITY(U,$J,358.3,30847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30847,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,30847,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,30847,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,30848,0)
 ;;=R93.6^^135^1384^8
 ;;^UTILITY(U,$J,358.3,30848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30848,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,30848,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,30848,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,30849,0)
 ;;=R94.4^^135^1384^16
 ;;^UTILITY(U,$J,358.3,30849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30849,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,30849,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,30849,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,30850,0)
 ;;=R94.5^^135^1384^17
