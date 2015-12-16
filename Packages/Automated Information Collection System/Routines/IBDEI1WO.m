IBDEI1WO ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33512,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,33512,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,33512,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,33513,0)
 ;;=R82.90^^182^2004^23
 ;;^UTILITY(U,$J,358.3,33513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33513,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,33513,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,33513,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,33514,0)
 ;;=R82.91^^182^2004^46
 ;;^UTILITY(U,$J,358.3,33514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33514,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,33514,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,33514,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,33515,0)
 ;;=R82.99^^182^2004^22
 ;;^UTILITY(U,$J,358.3,33515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33515,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,33515,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,33515,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,33516,0)
 ;;=R89.9^^182^2004^17
 ;;^UTILITY(U,$J,358.3,33516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33516,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,33516,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,33516,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,33517,0)
 ;;=R90.0^^182^2004^92
 ;;^UTILITY(U,$J,358.3,33517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33517,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,33517,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,33517,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,33518,0)
 ;;=R90.89^^182^2004^12
 ;;^UTILITY(U,$J,358.3,33518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33518,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,33518,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,33518,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,33519,0)
 ;;=R91.1^^182^2004^142
 ;;^UTILITY(U,$J,358.3,33519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33519,1,3,0)
 ;;=3^Solitary Pulmonary Nodule
 ;;^UTILITY(U,$J,358.3,33519,1,4,0)
 ;;=4^R91.1
 ;;^UTILITY(U,$J,358.3,33519,2)
 ;;=^5019707
 ;;^UTILITY(U,$J,358.3,33520,0)
 ;;=R91.8^^182^2004^16
 ;;^UTILITY(U,$J,358.3,33520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33520,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,33520,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,33520,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,33521,0)
 ;;=R92.0^^182^2004^111
 ;;^UTILITY(U,$J,358.3,33521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33521,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,33521,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,33521,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,33522,0)
 ;;=R92.1^^182^2004^110
 ;;^UTILITY(U,$J,358.3,33522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33522,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,33522,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,33522,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,33523,0)
 ;;=R92.2^^182^2004^86
 ;;^UTILITY(U,$J,358.3,33523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33523,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,33523,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,33523,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,33524,0)
 ;;=R93.0^^182^2004^10
 ;;^UTILITY(U,$J,358.3,33524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33524,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
