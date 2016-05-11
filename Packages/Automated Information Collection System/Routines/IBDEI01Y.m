IBDEI01Y ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,423,1,4,0)
 ;;=4^G47.411
 ;;^UTILITY(U,$J,358.3,423,2)
 ;;=^5003981
 ;;^UTILITY(U,$J,358.3,424,0)
 ;;=G47.37^^3^48^2
 ;;^UTILITY(U,$J,358.3,424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,424,1,3,0)
 ;;=3^Central Sleep Apnea,Comorbid w/ Opioid Use
 ;;^UTILITY(U,$J,358.3,424,1,4,0)
 ;;=4^G47.37
 ;;^UTILITY(U,$J,358.3,424,2)
 ;;=^332767
 ;;^UTILITY(U,$J,358.3,425,0)
 ;;=G47.31^^3^48^3
 ;;^UTILITY(U,$J,358.3,425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,425,1,3,0)
 ;;=3^Central Sleep Apnea,Idiopathic Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,425,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,425,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,426,0)
 ;;=F51.11^^3^48^10
 ;;^UTILITY(U,$J,358.3,426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,426,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,426,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,426,2)
 ;;=^5003609
 ;;^UTILITY(U,$J,358.3,427,0)
 ;;=F51.01^^3^48^13
 ;;^UTILITY(U,$J,358.3,427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,427,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,427,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,427,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,428,0)
 ;;=G47.36^^3^48^24
 ;;^UTILITY(U,$J,358.3,428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,428,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,428,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,428,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,429,0)
 ;;=G47.35^^3^48^25
 ;;^UTILITY(U,$J,358.3,429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,429,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,429,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,429,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,430,0)
 ;;=G47.34^^3^48^26
 ;;^UTILITY(U,$J,358.3,430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,430,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic Hypoventilation
 ;;^UTILITY(U,$J,358.3,430,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,430,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,431,0)
 ;;=G47.9^^3^48^28
 ;;^UTILITY(U,$J,358.3,431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,431,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,431,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,431,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,432,0)
 ;;=F10.10^^3^49^27
 ;;^UTILITY(U,$J,358.3,432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,432,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,432,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,432,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,433,0)
 ;;=F10.14^^3^49^34
 ;;^UTILITY(U,$J,358.3,433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,433,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,433,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,433,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,434,0)
 ;;=F10.182^^3^49^36
 ;;^UTILITY(U,$J,358.3,434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,434,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,434,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,434,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,435,0)
 ;;=F10.20^^3^49^28
 ;;^UTILITY(U,$J,358.3,435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,435,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,435,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,435,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,436,0)
 ;;=F10.21^^3^49^29
 ;;^UTILITY(U,$J,358.3,436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,436,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
