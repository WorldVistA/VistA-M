IBDEI0G3 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7439,2)
 ;;=^5019607
 ;;^UTILITY(U,$J,358.3,7440,0)
 ;;=R82.8^^30^408^23
 ;;^UTILITY(U,$J,358.3,7440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7440,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,7440,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,7440,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,7441,0)
 ;;=R82.90^^30^408^25
 ;;^UTILITY(U,$J,358.3,7441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7441,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,7441,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,7441,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,7442,0)
 ;;=R82.91^^30^408^50
 ;;^UTILITY(U,$J,358.3,7442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7442,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,7442,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,7442,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,7443,0)
 ;;=R82.99^^30^408^24
 ;;^UTILITY(U,$J,358.3,7443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7443,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,7443,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,7443,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,7444,0)
 ;;=R89.9^^30^408^19
 ;;^UTILITY(U,$J,358.3,7444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7444,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,7444,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,7444,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,7445,0)
 ;;=R90.0^^30^408^105
 ;;^UTILITY(U,$J,358.3,7445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7445,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,7445,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,7445,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,7446,0)
 ;;=R90.89^^30^408^13
 ;;^UTILITY(U,$J,358.3,7446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7446,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,7446,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,7446,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,7447,0)
 ;;=R91.8^^30^408^18
 ;;^UTILITY(U,$J,358.3,7447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7447,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,7447,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,7447,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,7448,0)
 ;;=R92.0^^30^408^124
 ;;^UTILITY(U,$J,358.3,7448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7448,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,7448,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,7448,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,7449,0)
 ;;=R92.1^^30^408^123
 ;;^UTILITY(U,$J,358.3,7449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7449,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,7449,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,7449,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,7450,0)
 ;;=R92.2^^30^408^98
 ;;^UTILITY(U,$J,358.3,7450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7450,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,7450,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,7450,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,7451,0)
 ;;=R93.0^^30^408^10
 ;;^UTILITY(U,$J,358.3,7451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7451,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,7451,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,7451,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,7452,0)
 ;;=R93.2^^30^408^9
 ;;^UTILITY(U,$J,358.3,7452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7452,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
