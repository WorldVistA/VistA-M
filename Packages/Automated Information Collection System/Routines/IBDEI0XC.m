IBDEI0XC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15642,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15642,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,15642,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,15643,0)
 ;;=F10.29^^58^684^37
 ;;^UTILITY(U,$J,358.3,15643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15643,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15643,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,15643,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,15644,0)
 ;;=F10.180^^58^684^1
 ;;^UTILITY(U,$J,358.3,15644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15644,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15644,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,15644,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,15645,0)
 ;;=F10.280^^58^684^2
 ;;^UTILITY(U,$J,358.3,15645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15645,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15645,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,15645,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,15646,0)
 ;;=F10.980^^58^684^3
 ;;^UTILITY(U,$J,358.3,15646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15646,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15646,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,15646,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,15647,0)
 ;;=F10.94^^58^684^4
 ;;^UTILITY(U,$J,358.3,15647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15647,1,3,0)
 ;;=3^Alcohol Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15647,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,15647,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,15648,0)
 ;;=F10.26^^58^684^7
 ;;^UTILITY(U,$J,358.3,15648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15648,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15648,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,15648,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,15649,0)
 ;;=F10.96^^58^684^8
 ;;^UTILITY(U,$J,358.3,15649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15649,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15649,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,15649,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,15650,0)
 ;;=F10.27^^58^684^9
 ;;^UTILITY(U,$J,358.3,15650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15650,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15650,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,15650,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,15651,0)
 ;;=F10.97^^58^684^10
 ;;^UTILITY(U,$J,358.3,15651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15651,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15651,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,15651,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,15652,0)
 ;;=F10.288^^58^684^5
 ;;^UTILITY(U,$J,358.3,15652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15652,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15652,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,15652,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,15653,0)
 ;;=F10.988^^58^684^6
 ;;^UTILITY(U,$J,358.3,15653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15653,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15653,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,15653,2)
 ;;=^5003113
