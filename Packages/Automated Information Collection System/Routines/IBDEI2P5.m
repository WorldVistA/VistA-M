IBDEI2P5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45260,0)
 ;;=R82.8^^200^2240^23
 ;;^UTILITY(U,$J,358.3,45260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45260,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,45260,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,45260,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,45261,0)
 ;;=R82.90^^200^2240^25
 ;;^UTILITY(U,$J,358.3,45261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45261,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,45261,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,45261,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,45262,0)
 ;;=R82.91^^200^2240^49
 ;;^UTILITY(U,$J,358.3,45262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45262,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,45262,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,45262,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,45263,0)
 ;;=R82.99^^200^2240^24
 ;;^UTILITY(U,$J,358.3,45263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45263,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,45263,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,45263,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,45264,0)
 ;;=R89.9^^200^2240^19
 ;;^UTILITY(U,$J,358.3,45264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45264,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,45264,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,45264,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,45265,0)
 ;;=R90.0^^200^2240^98
 ;;^UTILITY(U,$J,358.3,45265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45265,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,45265,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,45265,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,45266,0)
 ;;=R90.89^^200^2240^13
 ;;^UTILITY(U,$J,358.3,45266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45266,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,45266,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,45266,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,45267,0)
 ;;=R91.8^^200^2240^18
 ;;^UTILITY(U,$J,358.3,45267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45267,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,45267,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,45267,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,45268,0)
 ;;=R92.0^^200^2240^117
 ;;^UTILITY(U,$J,358.3,45268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45268,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,45268,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,45268,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,45269,0)
 ;;=R92.1^^200^2240^116
 ;;^UTILITY(U,$J,358.3,45269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45269,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,45269,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,45269,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,45270,0)
 ;;=R92.2^^200^2240^91
 ;;^UTILITY(U,$J,358.3,45270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45270,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,45270,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,45270,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,45271,0)
 ;;=R93.0^^200^2240^10
 ;;^UTILITY(U,$J,358.3,45271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45271,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,45271,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,45271,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,45272,0)
 ;;=R93.2^^200^2240^9
 ;;^UTILITY(U,$J,358.3,45272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45272,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
