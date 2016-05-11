IBDEI01Z ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,436,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,436,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,437,0)
 ;;=F10.230^^3^49^30
 ;;^UTILITY(U,$J,358.3,437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,437,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,437,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,437,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,438,0)
 ;;=F10.231^^3^49^31
 ;;^UTILITY(U,$J,358.3,438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,438,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,438,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,438,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,439,0)
 ;;=F10.232^^3^49^32
 ;;^UTILITY(U,$J,358.3,439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,439,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,439,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,439,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,440,0)
 ;;=F10.239^^3^49^33
 ;;^UTILITY(U,$J,358.3,440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,440,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,440,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,440,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,441,0)
 ;;=F10.24^^3^49^35
 ;;^UTILITY(U,$J,358.3,441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,441,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,441,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,441,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,442,0)
 ;;=F10.29^^3^49^37
 ;;^UTILITY(U,$J,358.3,442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,442,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,442,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,442,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,443,0)
 ;;=F10.180^^3^49^1
 ;;^UTILITY(U,$J,358.3,443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,443,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,443,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,443,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,444,0)
 ;;=F10.280^^3^49^2
 ;;^UTILITY(U,$J,358.3,444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,444,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,444,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,444,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,445,0)
 ;;=F10.980^^3^49^3
 ;;^UTILITY(U,$J,358.3,445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,445,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,445,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,445,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,446,0)
 ;;=F10.94^^3^49^4
 ;;^UTILITY(U,$J,358.3,446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,446,1,3,0)
 ;;=3^Alcohol Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,446,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,446,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,447,0)
 ;;=F10.26^^3^49^7
 ;;^UTILITY(U,$J,358.3,447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,447,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,447,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,447,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,448,0)
 ;;=F10.96^^3^49^8
 ;;^UTILITY(U,$J,358.3,448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,448,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,448,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,448,2)
 ;;=^5003108
