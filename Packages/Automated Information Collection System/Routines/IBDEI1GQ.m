IBDEI1GQ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24849,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,24849,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,24849,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,24850,0)
 ;;=G47.35^^93^1115^25
 ;;^UTILITY(U,$J,358.3,24850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24850,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,24850,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,24850,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,24851,0)
 ;;=G47.34^^93^1115^26
 ;;^UTILITY(U,$J,358.3,24851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24851,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic Hypoventilation
 ;;^UTILITY(U,$J,358.3,24851,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,24851,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,24852,0)
 ;;=G47.9^^93^1115^28
 ;;^UTILITY(U,$J,358.3,24852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24852,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24852,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,24852,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,24853,0)
 ;;=F10.10^^93^1116^27
 ;;^UTILITY(U,$J,358.3,24853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24853,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24853,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,24853,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,24854,0)
 ;;=F10.14^^93^1116^34
 ;;^UTILITY(U,$J,358.3,24854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24854,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24854,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,24854,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,24855,0)
 ;;=F10.182^^93^1116^36
 ;;^UTILITY(U,$J,358.3,24855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24855,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24855,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,24855,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,24856,0)
 ;;=F10.20^^93^1116^28
 ;;^UTILITY(U,$J,358.3,24856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24856,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24856,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,24856,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,24857,0)
 ;;=F10.21^^93^1116^29
 ;;^UTILITY(U,$J,358.3,24857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24857,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,24857,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,24857,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,24858,0)
 ;;=F10.230^^93^1116^30
 ;;^UTILITY(U,$J,358.3,24858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24858,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,24858,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,24858,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,24859,0)
 ;;=F10.231^^93^1116^31
 ;;^UTILITY(U,$J,358.3,24859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24859,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,24859,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,24859,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,24860,0)
 ;;=F10.232^^93^1116^32
 ;;^UTILITY(U,$J,358.3,24860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24860,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24860,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,24860,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,24861,0)
 ;;=F10.239^^93^1116^33
