IBDEI0PD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11622,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,11622,1,4,0)
 ;;=4^R82.7
 ;;^UTILITY(U,$J,358.3,11622,2)
 ;;=^5019607
 ;;^UTILITY(U,$J,358.3,11623,0)
 ;;=R82.8^^68^687^23
 ;;^UTILITY(U,$J,358.3,11623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11623,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,11623,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,11623,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,11624,0)
 ;;=R82.90^^68^687^25
 ;;^UTILITY(U,$J,358.3,11624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11624,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,11624,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,11624,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,11625,0)
 ;;=R82.91^^68^687^49
 ;;^UTILITY(U,$J,358.3,11625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11625,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,11625,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,11625,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,11626,0)
 ;;=R82.99^^68^687^24
 ;;^UTILITY(U,$J,358.3,11626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11626,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,11626,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,11626,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,11627,0)
 ;;=R89.9^^68^687^19
 ;;^UTILITY(U,$J,358.3,11627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11627,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,11627,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,11627,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,11628,0)
 ;;=R90.0^^68^687^98
 ;;^UTILITY(U,$J,358.3,11628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11628,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,11628,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,11628,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,11629,0)
 ;;=R90.89^^68^687^13
 ;;^UTILITY(U,$J,358.3,11629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11629,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,11629,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,11629,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,11630,0)
 ;;=R91.8^^68^687^18
 ;;^UTILITY(U,$J,358.3,11630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11630,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,11630,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,11630,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,11631,0)
 ;;=R92.0^^68^687^117
 ;;^UTILITY(U,$J,358.3,11631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11631,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,11631,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,11631,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,11632,0)
 ;;=R92.1^^68^687^116
 ;;^UTILITY(U,$J,358.3,11632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11632,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,11632,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,11632,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,11633,0)
 ;;=R92.2^^68^687^91
 ;;^UTILITY(U,$J,358.3,11633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11633,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,11633,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,11633,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,11634,0)
 ;;=R93.0^^68^687^10
 ;;^UTILITY(U,$J,358.3,11634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11634,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,11634,1,4,0)
 ;;=4^R93.0
