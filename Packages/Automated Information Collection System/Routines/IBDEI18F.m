IBDEI18F ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20951,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,20951,1,4,0)
 ;;=4^R82.7
 ;;^UTILITY(U,$J,358.3,20951,2)
 ;;=^5019607
 ;;^UTILITY(U,$J,358.3,20952,0)
 ;;=R82.8^^84^941^23
 ;;^UTILITY(U,$J,358.3,20952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20952,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,20952,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,20952,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,20953,0)
 ;;=R82.90^^84^941^25
 ;;^UTILITY(U,$J,358.3,20953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20953,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,20953,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,20953,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,20954,0)
 ;;=R82.91^^84^941^49
 ;;^UTILITY(U,$J,358.3,20954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20954,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,20954,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,20954,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,20955,0)
 ;;=R82.99^^84^941^24
 ;;^UTILITY(U,$J,358.3,20955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20955,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,20955,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,20955,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,20956,0)
 ;;=R89.9^^84^941^19
 ;;^UTILITY(U,$J,358.3,20956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20956,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,20956,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,20956,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,20957,0)
 ;;=R90.0^^84^941^98
 ;;^UTILITY(U,$J,358.3,20957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20957,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,20957,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,20957,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,20958,0)
 ;;=R90.89^^84^941^13
 ;;^UTILITY(U,$J,358.3,20958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20958,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,20958,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,20958,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,20959,0)
 ;;=R91.8^^84^941^18
 ;;^UTILITY(U,$J,358.3,20959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20959,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,20959,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,20959,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,20960,0)
 ;;=R92.0^^84^941^117
 ;;^UTILITY(U,$J,358.3,20960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20960,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,20960,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,20960,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,20961,0)
 ;;=R92.1^^84^941^116
 ;;^UTILITY(U,$J,358.3,20961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20961,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,20961,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,20961,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,20962,0)
 ;;=R92.2^^84^941^91
 ;;^UTILITY(U,$J,358.3,20962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20962,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,20962,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,20962,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,20963,0)
 ;;=R93.0^^84^941^10
 ;;^UTILITY(U,$J,358.3,20963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20963,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,20963,1,4,0)
 ;;=4^R93.0
