IBDEI133 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17424,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,17424,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,17424,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,17425,0)
 ;;=R92.0^^88^891^122
 ;;^UTILITY(U,$J,358.3,17425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17425,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,17425,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,17425,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,17426,0)
 ;;=R92.1^^88^891^121
 ;;^UTILITY(U,$J,358.3,17426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17426,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,17426,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,17426,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,17427,0)
 ;;=R92.2^^88^891^96
 ;;^UTILITY(U,$J,358.3,17427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17427,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,17427,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,17427,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,17428,0)
 ;;=R93.0^^88^891^10
 ;;^UTILITY(U,$J,358.3,17428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17428,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,17428,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,17428,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,17429,0)
 ;;=R93.2^^88^891^9
 ;;^UTILITY(U,$J,358.3,17429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17429,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,17429,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,17429,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,17430,0)
 ;;=R93.3^^88^891^7
 ;;^UTILITY(U,$J,358.3,17430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17430,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,17430,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,17430,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,17431,0)
 ;;=R93.5^^88^891^6
 ;;^UTILITY(U,$J,358.3,17431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17431,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,17431,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,17431,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,17432,0)
 ;;=R93.6^^88^891^8
 ;;^UTILITY(U,$J,358.3,17432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17432,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,17432,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,17432,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,17433,0)
 ;;=R94.4^^88^891^19
 ;;^UTILITY(U,$J,358.3,17433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17433,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,17433,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,17433,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,17434,0)
 ;;=R94.5^^88^891^20
 ;;^UTILITY(U,$J,358.3,17434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17434,1,3,0)
 ;;=3^Abnormal Liver Function Studies
 ;;^UTILITY(U,$J,358.3,17434,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,17434,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,17435,0)
 ;;=R94.6^^88^891^24
 ;;^UTILITY(U,$J,358.3,17435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17435,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,17435,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,17435,2)
 ;;=^5019743
 ;;^UTILITY(U,$J,358.3,17436,0)
 ;;=R94.7^^88^891^5
