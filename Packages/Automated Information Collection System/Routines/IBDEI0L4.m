IBDEI0L4 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9508,1,3,0)
 ;;=3^Abnormal Coagulation Profile
 ;;^UTILITY(U,$J,358.3,9508,1,4,0)
 ;;=4^R79.1
 ;;^UTILITY(U,$J,358.3,9508,2)
 ;;=^5019591
 ;;^UTILITY(U,$J,358.3,9509,0)
 ;;=R82.5^^39^413^73
 ;;^UTILITY(U,$J,358.3,9509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9509,1,3,0)
 ;;=3^Elevated Urine Levels of Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,9509,1,4,0)
 ;;=4^R82.5
 ;;^UTILITY(U,$J,358.3,9509,2)
 ;;=^5019605
 ;;^UTILITY(U,$J,358.3,9510,0)
 ;;=R82.6^^39^413^29
 ;;^UTILITY(U,$J,358.3,9510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9510,1,3,0)
 ;;=3^Abnormal Urine Levels of Subst of Nonmed Source
 ;;^UTILITY(U,$J,358.3,9510,1,4,0)
 ;;=4^R82.6
 ;;^UTILITY(U,$J,358.3,9510,2)
 ;;=^5019606
 ;;^UTILITY(U,$J,358.3,9511,0)
 ;;=R82.90^^39^413^28
 ;;^UTILITY(U,$J,358.3,9511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9511,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,9511,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,9511,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,9512,0)
 ;;=R82.91^^39^413^52
 ;;^UTILITY(U,$J,358.3,9512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9512,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,9512,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,9512,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,9513,0)
 ;;=R89.9^^39^413^22
 ;;^UTILITY(U,$J,358.3,9513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9513,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,9513,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,9513,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,9514,0)
 ;;=R90.0^^39^413^102
 ;;^UTILITY(U,$J,358.3,9514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9514,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,9514,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,9514,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,9515,0)
 ;;=R90.89^^39^413^16
 ;;^UTILITY(U,$J,358.3,9515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9515,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,9515,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,9515,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,9516,0)
 ;;=R91.8^^39^413^21
 ;;^UTILITY(U,$J,358.3,9516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9516,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,9516,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,9516,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,9517,0)
 ;;=R92.0^^39^413^121
 ;;^UTILITY(U,$J,358.3,9517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9517,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,9517,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,9517,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,9518,0)
 ;;=R92.1^^39^413^120
 ;;^UTILITY(U,$J,358.3,9518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9518,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,9518,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,9518,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,9519,0)
 ;;=R92.2^^39^413^95
 ;;^UTILITY(U,$J,358.3,9519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9519,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,9519,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,9519,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,9520,0)
 ;;=R93.0^^39^413^10
 ;;^UTILITY(U,$J,358.3,9520,1,0)
 ;;=^358.31IA^4^2
