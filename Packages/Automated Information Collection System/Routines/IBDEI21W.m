IBDEI21W ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34791,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,34791,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,34791,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,34792,0)
 ;;=R90.89^^131^1692^13
 ;;^UTILITY(U,$J,358.3,34792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34792,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,34792,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,34792,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,34793,0)
 ;;=R91.8^^131^1692^18
 ;;^UTILITY(U,$J,358.3,34793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34793,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,34793,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,34793,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,34794,0)
 ;;=R92.0^^131^1692^117
 ;;^UTILITY(U,$J,358.3,34794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34794,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,34794,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,34794,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,34795,0)
 ;;=R92.1^^131^1692^116
 ;;^UTILITY(U,$J,358.3,34795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34795,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,34795,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,34795,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,34796,0)
 ;;=R92.2^^131^1692^91
 ;;^UTILITY(U,$J,358.3,34796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34796,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,34796,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,34796,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,34797,0)
 ;;=R93.0^^131^1692^10
 ;;^UTILITY(U,$J,358.3,34797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34797,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,34797,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,34797,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,34798,0)
 ;;=R93.2^^131^1692^9
 ;;^UTILITY(U,$J,358.3,34798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34798,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,34798,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,34798,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,34799,0)
 ;;=R93.3^^131^1692^7
 ;;^UTILITY(U,$J,358.3,34799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34799,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,34799,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,34799,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,34800,0)
 ;;=R93.4^^131^1692^11
 ;;^UTILITY(U,$J,358.3,34800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34800,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,34800,1,4,0)
 ;;=4^R93.4
 ;;^UTILITY(U,$J,358.3,34800,2)
 ;;=^5019717
 ;;^UTILITY(U,$J,358.3,34801,0)
 ;;=R93.5^^131^1692^6
 ;;^UTILITY(U,$J,358.3,34801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34801,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,34801,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,34801,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,34802,0)
 ;;=R93.6^^131^1692^8
 ;;^UTILITY(U,$J,358.3,34802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34802,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,34802,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,34802,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,34803,0)
 ;;=R94.4^^131^1692^16
 ;;^UTILITY(U,$J,358.3,34803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34803,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
