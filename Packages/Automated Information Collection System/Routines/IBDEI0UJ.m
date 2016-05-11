IBDEI0UJ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14325,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,14325,1,4,0)
 ;;=4^R82.7
 ;;^UTILITY(U,$J,358.3,14325,2)
 ;;=^5019607
 ;;^UTILITY(U,$J,358.3,14326,0)
 ;;=R82.8^^53^605^23
 ;;^UTILITY(U,$J,358.3,14326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14326,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,14326,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,14326,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,14327,0)
 ;;=R82.90^^53^605^25
 ;;^UTILITY(U,$J,358.3,14327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14327,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,14327,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,14327,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,14328,0)
 ;;=R82.91^^53^605^49
 ;;^UTILITY(U,$J,358.3,14328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14328,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,14328,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,14328,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,14329,0)
 ;;=R82.99^^53^605^24
 ;;^UTILITY(U,$J,358.3,14329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14329,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,14329,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,14329,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,14330,0)
 ;;=R89.9^^53^605^19
 ;;^UTILITY(U,$J,358.3,14330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14330,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,14330,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,14330,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,14331,0)
 ;;=R90.0^^53^605^98
 ;;^UTILITY(U,$J,358.3,14331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14331,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,14331,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,14331,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,14332,0)
 ;;=R90.89^^53^605^13
 ;;^UTILITY(U,$J,358.3,14332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14332,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,14332,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,14332,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,14333,0)
 ;;=R91.8^^53^605^18
 ;;^UTILITY(U,$J,358.3,14333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14333,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,14333,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,14333,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,14334,0)
 ;;=R92.0^^53^605^117
 ;;^UTILITY(U,$J,358.3,14334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14334,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,14334,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,14334,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,14335,0)
 ;;=R92.1^^53^605^116
 ;;^UTILITY(U,$J,358.3,14335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14335,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,14335,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,14335,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,14336,0)
 ;;=R92.2^^53^605^91
 ;;^UTILITY(U,$J,358.3,14336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14336,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,14336,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,14336,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,14337,0)
 ;;=R93.0^^53^605^10
 ;;^UTILITY(U,$J,358.3,14337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14337,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,14337,1,4,0)
 ;;=4^R93.0
