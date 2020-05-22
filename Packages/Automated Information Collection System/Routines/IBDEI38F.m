IBDEI38F ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51606,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,51606,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,51606,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,51607,0)
 ;;=R82.91^^193^2509^53
 ;;^UTILITY(U,$J,358.3,51607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51607,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,51607,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,51607,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,51608,0)
 ;;=R89.9^^193^2509^22
 ;;^UTILITY(U,$J,358.3,51608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51608,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,51608,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,51608,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,51609,0)
 ;;=R90.0^^193^2509^103
 ;;^UTILITY(U,$J,358.3,51609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51609,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,51609,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,51609,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,51610,0)
 ;;=R90.89^^193^2509^16
 ;;^UTILITY(U,$J,358.3,51610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51610,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,51610,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,51610,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,51611,0)
 ;;=R91.8^^193^2509^21
 ;;^UTILITY(U,$J,358.3,51611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51611,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,51611,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,51611,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,51612,0)
 ;;=R92.0^^193^2509^122
 ;;^UTILITY(U,$J,358.3,51612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51612,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,51612,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,51612,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,51613,0)
 ;;=R92.1^^193^2509^121
 ;;^UTILITY(U,$J,358.3,51613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51613,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,51613,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,51613,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,51614,0)
 ;;=R92.2^^193^2509^96
 ;;^UTILITY(U,$J,358.3,51614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51614,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,51614,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,51614,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,51615,0)
 ;;=R93.0^^193^2509^10
 ;;^UTILITY(U,$J,358.3,51615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51615,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,51615,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,51615,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,51616,0)
 ;;=R93.2^^193^2509^9
 ;;^UTILITY(U,$J,358.3,51616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51616,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,51616,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,51616,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,51617,0)
 ;;=R93.3^^193^2509^7
 ;;^UTILITY(U,$J,358.3,51617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51617,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,51617,1,4,0)
 ;;=4^R93.3
