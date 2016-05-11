IBDEI0XB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15630,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,15630,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,15630,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,15631,0)
 ;;=G47.34^^58^683^26
 ;;^UTILITY(U,$J,358.3,15631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15631,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic Hypoventilation
 ;;^UTILITY(U,$J,358.3,15631,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,15631,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,15632,0)
 ;;=G47.9^^58^683^28
 ;;^UTILITY(U,$J,358.3,15632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15632,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15632,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,15632,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,15633,0)
 ;;=F10.10^^58^684^27
 ;;^UTILITY(U,$J,358.3,15633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15633,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,15633,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,15633,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,15634,0)
 ;;=F10.14^^58^684^34
 ;;^UTILITY(U,$J,358.3,15634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15634,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15634,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,15634,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,15635,0)
 ;;=F10.182^^58^684^36
 ;;^UTILITY(U,$J,358.3,15635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15635,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15635,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,15635,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,15636,0)
 ;;=F10.20^^58^684^28
 ;;^UTILITY(U,$J,358.3,15636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15636,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,15636,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,15636,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,15637,0)
 ;;=F10.21^^58^684^29
 ;;^UTILITY(U,$J,358.3,15637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15637,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,15637,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,15637,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,15638,0)
 ;;=F10.230^^58^684^30
 ;;^UTILITY(U,$J,358.3,15638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15638,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,15638,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,15638,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,15639,0)
 ;;=F10.231^^58^684^31
 ;;^UTILITY(U,$J,358.3,15639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15639,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,15639,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,15639,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,15640,0)
 ;;=F10.232^^58^684^32
 ;;^UTILITY(U,$J,358.3,15640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15640,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,15640,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,15640,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,15641,0)
 ;;=F10.239^^58^684^33
 ;;^UTILITY(U,$J,358.3,15641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15641,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,15641,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,15641,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,15642,0)
 ;;=F10.24^^58^684^35
 ;;^UTILITY(U,$J,358.3,15642,1,0)
 ;;=^358.31IA^4^2
