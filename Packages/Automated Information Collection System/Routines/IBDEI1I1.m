IBDEI1I1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25442,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25442,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,25442,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,25443,0)
 ;;=F10.14^^95^1165^34
 ;;^UTILITY(U,$J,358.3,25443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25443,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25443,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,25443,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,25444,0)
 ;;=F10.182^^95^1165^36
 ;;^UTILITY(U,$J,358.3,25444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25444,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25444,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,25444,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,25445,0)
 ;;=F10.20^^95^1165^28
 ;;^UTILITY(U,$J,358.3,25445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25445,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25445,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,25445,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,25446,0)
 ;;=F10.21^^95^1165^29
 ;;^UTILITY(U,$J,358.3,25446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25446,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,25446,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,25446,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,25447,0)
 ;;=F10.230^^95^1165^30
 ;;^UTILITY(U,$J,358.3,25447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25447,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,25447,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,25447,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,25448,0)
 ;;=F10.231^^95^1165^31
 ;;^UTILITY(U,$J,358.3,25448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25448,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,25448,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,25448,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,25449,0)
 ;;=F10.232^^95^1165^32
 ;;^UTILITY(U,$J,358.3,25449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25449,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25449,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,25449,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,25450,0)
 ;;=F10.239^^95^1165^33
 ;;^UTILITY(U,$J,358.3,25450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25450,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25450,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,25450,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,25451,0)
 ;;=F10.24^^95^1165^35
 ;;^UTILITY(U,$J,358.3,25451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25451,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25451,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,25451,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,25452,0)
 ;;=F10.29^^95^1165^37
 ;;^UTILITY(U,$J,358.3,25452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25452,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25452,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,25452,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,25453,0)
 ;;=F10.180^^95^1165^1
 ;;^UTILITY(U,$J,358.3,25453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25453,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25453,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,25453,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,25454,0)
 ;;=F10.280^^95^1165^2
 ;;^UTILITY(U,$J,358.3,25454,1,0)
 ;;=^358.31IA^4^2
