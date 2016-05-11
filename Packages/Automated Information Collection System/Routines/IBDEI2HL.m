IBDEI2HL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42175,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,42175,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,42175,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,42176,0)
 ;;=R90.89^^159^2016^13
 ;;^UTILITY(U,$J,358.3,42176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42176,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,42176,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,42176,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,42177,0)
 ;;=R91.8^^159^2016^18
 ;;^UTILITY(U,$J,358.3,42177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42177,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,42177,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,42177,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,42178,0)
 ;;=R92.0^^159^2016^117
 ;;^UTILITY(U,$J,358.3,42178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42178,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,42178,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,42178,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,42179,0)
 ;;=R92.1^^159^2016^116
 ;;^UTILITY(U,$J,358.3,42179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42179,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,42179,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,42179,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,42180,0)
 ;;=R92.2^^159^2016^91
 ;;^UTILITY(U,$J,358.3,42180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42180,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,42180,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,42180,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,42181,0)
 ;;=R93.0^^159^2016^10
 ;;^UTILITY(U,$J,358.3,42181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42181,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,42181,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,42181,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,42182,0)
 ;;=R93.2^^159^2016^9
 ;;^UTILITY(U,$J,358.3,42182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42182,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,42182,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,42182,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,42183,0)
 ;;=R93.3^^159^2016^7
 ;;^UTILITY(U,$J,358.3,42183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42183,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,42183,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,42183,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,42184,0)
 ;;=R93.4^^159^2016^11
 ;;^UTILITY(U,$J,358.3,42184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42184,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,42184,1,4,0)
 ;;=4^R93.4
 ;;^UTILITY(U,$J,358.3,42184,2)
 ;;=^5019717
 ;;^UTILITY(U,$J,358.3,42185,0)
 ;;=R93.5^^159^2016^6
 ;;^UTILITY(U,$J,358.3,42185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42185,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,42185,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,42185,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,42186,0)
 ;;=R93.6^^159^2016^8
 ;;^UTILITY(U,$J,358.3,42186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42186,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,42186,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,42186,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,42187,0)
 ;;=R94.4^^159^2016^16
 ;;^UTILITY(U,$J,358.3,42187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42187,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
