IBDEI2JH ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40546,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,40546,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,40546,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,40547,0)
 ;;=R82.91^^152^2012^53
 ;;^UTILITY(U,$J,358.3,40547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40547,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,40547,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,40547,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,40548,0)
 ;;=R89.9^^152^2012^22
 ;;^UTILITY(U,$J,358.3,40548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40548,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,40548,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,40548,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,40549,0)
 ;;=R90.0^^152^2012^103
 ;;^UTILITY(U,$J,358.3,40549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40549,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,40549,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,40549,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,40550,0)
 ;;=R90.89^^152^2012^16
 ;;^UTILITY(U,$J,358.3,40550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40550,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,40550,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,40550,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,40551,0)
 ;;=R91.8^^152^2012^21
 ;;^UTILITY(U,$J,358.3,40551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40551,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,40551,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,40551,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,40552,0)
 ;;=R92.0^^152^2012^122
 ;;^UTILITY(U,$J,358.3,40552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40552,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,40552,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,40552,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,40553,0)
 ;;=R92.1^^152^2012^121
 ;;^UTILITY(U,$J,358.3,40553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40553,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,40553,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,40553,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,40554,0)
 ;;=R92.2^^152^2012^96
 ;;^UTILITY(U,$J,358.3,40554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40554,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,40554,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,40554,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,40555,0)
 ;;=R93.0^^152^2012^10
 ;;^UTILITY(U,$J,358.3,40555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40555,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,40555,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,40555,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,40556,0)
 ;;=R93.2^^152^2012^9
 ;;^UTILITY(U,$J,358.3,40556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40556,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,40556,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,40556,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,40557,0)
 ;;=R93.3^^152^2012^7
 ;;^UTILITY(U,$J,358.3,40557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40557,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,40557,1,4,0)
 ;;=4^R93.3
