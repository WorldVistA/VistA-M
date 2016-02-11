IBDEI16L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19742,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,19742,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,19742,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,19743,0)
 ;;=R82.99^^94^928^24
 ;;^UTILITY(U,$J,358.3,19743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19743,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,19743,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,19743,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,19744,0)
 ;;=R89.9^^94^928^19
 ;;^UTILITY(U,$J,358.3,19744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19744,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,19744,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,19744,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,19745,0)
 ;;=R90.0^^94^928^98
 ;;^UTILITY(U,$J,358.3,19745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19745,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,19745,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,19745,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,19746,0)
 ;;=R90.89^^94^928^13
 ;;^UTILITY(U,$J,358.3,19746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19746,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,19746,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,19746,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,19747,0)
 ;;=R91.8^^94^928^18
 ;;^UTILITY(U,$J,358.3,19747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19747,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,19747,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,19747,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,19748,0)
 ;;=R92.0^^94^928^117
 ;;^UTILITY(U,$J,358.3,19748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19748,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,19748,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,19748,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,19749,0)
 ;;=R92.1^^94^928^116
 ;;^UTILITY(U,$J,358.3,19749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19749,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,19749,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,19749,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,19750,0)
 ;;=R92.2^^94^928^91
 ;;^UTILITY(U,$J,358.3,19750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19750,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,19750,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,19750,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,19751,0)
 ;;=R93.0^^94^928^10
 ;;^UTILITY(U,$J,358.3,19751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19751,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,19751,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,19751,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,19752,0)
 ;;=R93.2^^94^928^9
 ;;^UTILITY(U,$J,358.3,19752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19752,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,19752,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,19752,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,19753,0)
 ;;=R93.3^^94^928^7
 ;;^UTILITY(U,$J,358.3,19753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19753,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,19753,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,19753,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,19754,0)
 ;;=R93.4^^94^928^11
 ;;^UTILITY(U,$J,358.3,19754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19754,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,19754,1,4,0)
 ;;=4^R93.4
