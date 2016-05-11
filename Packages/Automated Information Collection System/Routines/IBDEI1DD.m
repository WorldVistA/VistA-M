IBDEI1DD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23280,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,23280,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,23280,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,23281,0)
 ;;=R90.0^^87^993^98
 ;;^UTILITY(U,$J,358.3,23281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23281,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,23281,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,23281,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,23282,0)
 ;;=R90.89^^87^993^13
 ;;^UTILITY(U,$J,358.3,23282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23282,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,23282,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,23282,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,23283,0)
 ;;=R91.8^^87^993^18
 ;;^UTILITY(U,$J,358.3,23283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23283,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,23283,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,23283,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,23284,0)
 ;;=R92.0^^87^993^117
 ;;^UTILITY(U,$J,358.3,23284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23284,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,23284,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,23284,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,23285,0)
 ;;=R92.1^^87^993^116
 ;;^UTILITY(U,$J,358.3,23285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23285,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,23285,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,23285,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,23286,0)
 ;;=R92.2^^87^993^91
 ;;^UTILITY(U,$J,358.3,23286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23286,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,23286,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,23286,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,23287,0)
 ;;=R93.0^^87^993^10
 ;;^UTILITY(U,$J,358.3,23287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23287,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,23287,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,23287,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,23288,0)
 ;;=R93.2^^87^993^9
 ;;^UTILITY(U,$J,358.3,23288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23288,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,23288,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,23288,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,23289,0)
 ;;=R93.3^^87^993^7
 ;;^UTILITY(U,$J,358.3,23289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23289,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,23289,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,23289,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,23290,0)
 ;;=R93.4^^87^993^11
 ;;^UTILITY(U,$J,358.3,23290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23290,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,23290,1,4,0)
 ;;=4^R93.4
 ;;^UTILITY(U,$J,358.3,23290,2)
 ;;=^5019717
 ;;^UTILITY(U,$J,358.3,23291,0)
 ;;=R93.5^^87^993^6
 ;;^UTILITY(U,$J,358.3,23291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23291,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,23291,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,23291,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,23292,0)
 ;;=R93.6^^87^993^8
 ;;^UTILITY(U,$J,358.3,23292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23292,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
