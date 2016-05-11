IBDEI1TR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30997,1,4,0)
 ;;=4^G47.411
 ;;^UTILITY(U,$J,358.3,30997,2)
 ;;=^5003981
 ;;^UTILITY(U,$J,358.3,30998,0)
 ;;=G47.37^^123^1554^2
 ;;^UTILITY(U,$J,358.3,30998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30998,1,3,0)
 ;;=3^Central Sleep Apnea,Comorbid w/ Opioid Use
 ;;^UTILITY(U,$J,358.3,30998,1,4,0)
 ;;=4^G47.37
 ;;^UTILITY(U,$J,358.3,30998,2)
 ;;=^332767
 ;;^UTILITY(U,$J,358.3,30999,0)
 ;;=G47.31^^123^1554^3
 ;;^UTILITY(U,$J,358.3,30999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30999,1,3,0)
 ;;=3^Central Sleep Apnea,Idiopathic Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,30999,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,30999,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,31000,0)
 ;;=F51.11^^123^1554^10
 ;;^UTILITY(U,$J,358.3,31000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31000,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,31000,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,31000,2)
 ;;=^5003609
 ;;^UTILITY(U,$J,358.3,31001,0)
 ;;=F51.01^^123^1554^13
 ;;^UTILITY(U,$J,358.3,31001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31001,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,31001,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,31001,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,31002,0)
 ;;=G47.36^^123^1554^24
 ;;^UTILITY(U,$J,358.3,31002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31002,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
 ;;^UTILITY(U,$J,358.3,31002,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,31002,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,31003,0)
 ;;=G47.35^^123^1554^25
 ;;^UTILITY(U,$J,358.3,31003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31003,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,31003,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,31003,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,31004,0)
 ;;=G47.34^^123^1554^26
 ;;^UTILITY(U,$J,358.3,31004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31004,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic Hypoventilation
 ;;^UTILITY(U,$J,358.3,31004,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,31004,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,31005,0)
 ;;=G47.9^^123^1554^28
 ;;^UTILITY(U,$J,358.3,31005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31005,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31005,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,31005,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,31006,0)
 ;;=F10.10^^123^1555^27
 ;;^UTILITY(U,$J,358.3,31006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31006,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31006,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,31006,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,31007,0)
 ;;=F10.14^^123^1555^34
 ;;^UTILITY(U,$J,358.3,31007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31007,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31007,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,31007,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,31008,0)
 ;;=F10.182^^123^1555^36
 ;;^UTILITY(U,$J,358.3,31008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31008,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31008,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,31008,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,31009,0)
 ;;=F10.20^^123^1555^28
 ;;^UTILITY(U,$J,358.3,31009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31009,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31009,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,31009,2)
 ;;=^5003081
